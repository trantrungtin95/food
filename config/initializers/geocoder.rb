Geocoder.configure(

    # street address geocoding service (default :nominatim)
    lookup: :here,
  
    # IP address geocoding service (default :ipinfo_io)
    ip_lookup: :maxmind,
  
    # to use an API key:
    api_key: "m_kJb3qtY4wvDtGiiTm38hJyolKnYtiTjacmhhmtygM",
  
    # geocoding service request timeout, in seconds (default 3):
    timeout: 5,
  
    # set default units to kilometers:
    units: :km,
  
    # caching (see [below](#caching) for details):
    # cache: Redis.new,
    cache_prefix: "..."
  
  )