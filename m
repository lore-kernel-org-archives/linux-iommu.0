From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 03/20] iommu/tegra: gart: Ignore devices without IOMMU
 phandle in DT
Date: Mon, 24 Sep 2018 12:05:25 +0200
Message-ID: <20180924100525.GE21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 24, 2018 at 03:41:36AM +0300, Dmitry Osipenko wrote:
> GART can't handle all devices, hence ignore devices that aren't related
> to GART. IOMMU phandle must be explicitly assign to devices in the device
> tree.

I think technically the GART can indeed handle all devices since it is
just a physical address region that can be used to remap other physical
addresses. That's not to say that doing so would be a good idea. So the
commit message here is slightly confusing, but other than that the idea
is good, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotuUACgkQ3SOs138+
s6FALBAAihy4Koa8dQIhpVPATIDDQsyRjFl4jqvkGh5jHGBULZGdXN8uUyzuMj7/
5aOiJQ/HgbzR+U/eX/rwOLMQmcr6aLYw2TqwcpwcERhOvDyQNRI8U9PtTIAxcuhO
DFqTwYCX+aZGy2MCfF+P9hl3MKweAXFCqvj+ckBh1GIGkU5lqYM8r1sgfz/mB/xc
QDcODaJcIYy/umpDO5ADZK+Q9A6KC/ZGY6xdS4BppKlasG8wKGG6nC0PbiSKhpby
mjeIRFo2XULhp7/+0Nqj2V5gGDUcu+yRe2lKKMzmELeaIJ7LgxkD3uva4mQ4nxFK
mx/kuCeSZrvxWiV12whALZ0c2znYamDXzlLHb9orgEsV4zrb6OhBAh5LK733AQ/e
+5FpejQ+Tna8pWVzRDTkvx2GAeYS+EdmDXjZT+OLGVk2DvAPfx1ORFKIGaWrisZQ
B/yASM3fEXX4/fpQaz6WN6XLUtZu4SWRJR5QIF+E5t6jAPhBVHyaD6ItNGb+Vbpm
KoEHJfg4eIFwlN5r6aSV/UVS9Ik014fxUu5DtPr3U5+7jLcL6N7/rhYuF1fE01yv
A1B6bjK9NeCwo4qgUiU+xKHR/2VBw9OaL06qYakzz0K6XADzDbyBYsolqU/TdbMG
/NI2DduseQE3DzaSuvREtm3fQbJN4s/tbdcTW/VGygIvHL+RTU0=
=Cw72
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
