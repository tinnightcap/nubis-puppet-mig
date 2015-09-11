
class mig (
    $version
) {
    require mig::params

    $url = "https://s3.amazonaws.com/mig-packages/mig-agent-nubis${mig::params::silly}${mig::params::version}.${mig::params::prod}${::architecture}.${mig::params::ext}"

    notice ("Grabbing from ${url}")

    wget::fetch { "download MIG ${version}":
        source      => $url,
        destination => "/tmp/mig.${mig::params::ext}",
        verbose     => true,
        redownload  => true, # The file already exists, we replace it
    }

    package { 'mig':
        ensure   => present,
        source   => "/tmp/mig.${mig::params::ext}",
        provider => $mig::params::provider,
        require  => Wget::Fetch["download MIG $version"]
    }

}
