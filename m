From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 12:18:17 +0200
Message-ID: <20130626101816.GE27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
[...]
> @@ -23,3 +24,13 @@ Example:
>  		nvidia,swgroups = <0x00000000 0x000779ff>;
>  		nvidia,ahb = <&ahb>;
>  	};
> +
> +	host1x {
> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> +		nvidia,memory-clients = <SWGID_HC>;

And this could use the SWGID(HC) to match up with how GPIOs are
referenced in the DTS files. Though I see that the clocks don't use a
parameterized version either, so things are inconsistent anyway. But if
SWGID() isn't used then maybe it shouldn't be provided by the header
file in the first place.

Oh, one other thing: both GPIO and CAR use the TEGRA_ prefix, perhaps
this should use it as well?

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
[...]
> index 14ec3f9..3fcee3f 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -1,5 +1,6 @@
>  #include <dt-bindings/clock/tegra30-car.h>
>  #include <dt-bindings/gpio/tegra-gpio.h>
> +#include <dt-bindings/iommu/tegra-swgid.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>

Nit: these includes seem to be ordered alphabetically; if so then iommu
should go below interrupt-controller.

> @@ -286,6 +300,7 @@
>  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
>  		nvidia,dma-request-selector = <&apbdma 20>;
>  		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
> +		nvidia,memory-clients = <14>;

SWGID_PPCS?

Thierry

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyr/oAAoJEN0jrNd/PrOh1FAP/02Owj95zfivu0SthXrGBTpK
fJuHQgkHZrseNfN8ymp1XxEEcAPSzev39J0Y5R2fVZJpZOFPcoU2r9bykhFm/p/t
4bDMEnFfWIwhf7FDdHoM2calUF5GA8YS9FZCsEDz4MaAKFhgeJmiMFdObquIvo1M
gp24L0iq31UXFP1bkqj3HFNXZamyhhhA9/KaXHE1QrdLdTcWj2fW4MkQ4ICtsJe2
t0doVVFDxezWk1gLF94oHQ6Ek92llwzyMEhCdtB/Rtz6bF3P3AuIoDwYyLSwIm52
y0t99mMxPPhA5miVCty596vDCRj4R/GiEKhrSYdSfIt1Ug7jGRC+jUEJ2lo7rDZc
3yQjkJYYo3EyVm9EemB9tpz1rOo0P091XE9n8aJgrUJ/NxlRyU8FsZTuvF2kYAVE
HY8BOceGasPZaSUI7bkSLQYgkdn0ySg9LtmIEofMZj2cwrQzTNwdbA6jTnw7lLbz
DdLea+ge57gwZM/TDnZNU3l5aT0rLSigV3xonUtgbT9qY2GOO6Qhjm7lj/27PfWI
GGaNLSvDj1OwIjCoiIedFi6+c7l/BhVBSTSJoIhbtvMO4EbGPHf8ulnfLyYmOzj9
xpABDOV6GJfP2OylabWPx2OmyTvh6SEV+Qmx7YGW1KBJvStbd+2zHJ9FozMZytP2
jpTSs853RA75YbmK31L6
=QmRg
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
