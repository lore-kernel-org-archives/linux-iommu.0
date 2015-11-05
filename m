From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] doc:bindings:Add document for mfd hi665x PMIC
Date: Thu, 5 Nov 2015 14:04:12 +0000
Message-ID: <20151105140412.GG18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-2-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1602456937885091515=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-2-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, haojian.zhuang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1602456937885091515==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2015 at 09:34:42PM +0800, Chen Feng wrote:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> +- #interrupt-cells: Should be 2, two cells are needed for irq.
> +- interrupt-controller: hi655x has internal IRQs (has own IRQ domain).
> +- pmu_irq_gpio: should be &gpio_pmu_irq_n, is the IRQ gpio of hi655x.

I'm not entirely sure what this is but it sounds worrying - why can you
not just use a normal interrupt specifier?  It also doesn't correspond
to the example:

> +Example:
> +	pmic: pmic@f8000000 {
> +		compatible =3D "hisilicon,hi655x-pmic-driver";
> +		reg =3D <0x0 0xf8000000 0x0 0x1000>;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		pmic_gpios =3D <&gpio_pmu_irq_n>;
> +		status =3D "okay";
> +	}
> --=20
> 1.9.1
>=20
>=20

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO2HYAAoJECTWi3JdVIfQwakH/AtaBrA8Y1kDas7nFl58D4BM
/HpHYZJvu0WHdTs+z5oAdUTrREuA2wo3voXb4Er7q6TpE8ZsMbc3/e0pirvogEUP
4rPHRCo0Nn8XoGopVK9zLSohyJbeB2EO80KIPE2yu+trMl89Ol5twjiVMyEVHPtH
H9ASxS5kinz1avedj/1y9IxP0kPc+FTAe42D645GzpfqH4PJ65dPk8AyLVt+B0ry
InWia+Sy/3oEGTwZV5YfHyV6GnVnYHyfKcWrPs3p8il72cjVWW9h29GWN0RRu9tE
8mJnTQQCGKhJsY7l0MhyfFLNCf6fdneUpu8hsKJxFSGlD+yKhk6yR3OgjzK5zmg=
=BkIs
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--

--===============1602456937885091515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1602456937885091515==--
