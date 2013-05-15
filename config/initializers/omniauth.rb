Encoding.default_external = Encoding.find("UTF-8")

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "230VG13eXRiYVbHPrr4Hlg", "XYoHWin0z6SaVsRwZyAJaVbqmxOnJ1YPC8RWC3yy6Xc"
end