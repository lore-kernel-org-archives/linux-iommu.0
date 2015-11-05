From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/7] doc:bindings:Document for hi655x pmic driver
Date: Thu, 5 Nov 2015 14:23:47 +0000
Message-ID: <20151105142347.GI18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-4-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0465971537905300454=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-4-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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


--===============0465971537905300454==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2015 at 09:34:44PM +0800, Chen Feng wrote:

> +Required properties:
> +- compatible: Must be "hisilicon,hi655x-regulator-pmic";

If this is a subfunction of a MFD it shouldn't have a compatible string.
If it is instead a standalone device it should just have a name in the
form "vendor,chip" without any random suffixes.

> +- regulator-name: Regulator name in SoC.
> +- regulator-min-microvolt: Smallest voltage support.
> +- regulator-max-microvolt: Largest voltages support.

These should *never* be mandatory properties and the generic regulator
bindings should be reference rather than copied into the binding for a
specific device, that way the standard definitions for things are always
used and people know about any other properties that are available as
standard.

> +- regulator-off-on-delay: The time wait for power steady
> +- regulator-ctrl-regs: Registers offset of control register.
> +  In turn with enable disable and status register offset.
> +- regulator-ctrl-mask: The control mask of the register.
> +- regulator-vset-regs: Voltage set register offset.
> +- regulator-vset-mask: voltage set control mask.
> +- regulator-n-vol: The num of support voltages.
> +- regulator-vset-table: The table of support voltages.

Why is this in the binding?  This is a binding for a specific device,
there is no point in putting all these data tables in the DT - it just
bloats the DT and makes it harder for us to enhance our support for this
device in the future.  Just=20

> +
> +Example:
> +        pmic: pmic@f8000000 {
> +                compatible =3D "hisilicon,hi655x-pmic-driver";
> +		...
> +                ldo2: regulator@a21 {
> +                        compatible =3D "hisilicon,hi655x-regulator-pmic";
> +                        regulator-name =3D "ldo2";
> +                        regulator-min-microvolt =3D <2500000>;
> +                        regulator-max-microvolt =3D <3200000>;
> +                        regulator-valid-modes-mask =3D <0x02>;
> +                        regulator-initial-mode =3D <0x02>;
> +                        regulator-off-on-delay =3D <120>;
> +                        regulator-ctrl-regs =3D <0x029 0x02a 0x02b>;
> +                        regulator-ctrl-mask =3D <0x1>;
> +                        regulator-vset-regs =3D <0x072>;
> +                        regulator-vset-mask =3D <0x3>;
> +                        regulator-n-vol =3D <8>;
> +                        regulator-vset-table  =3D <2500000>,<2600000>,
> +                                                <2700000>,<2800000>,
> +                                                <2900000>,<3000000>,
> +                                                <3100000>,<3200000>;
> +                };
> +		...
> +	}
> --=20
> 1.9.1
>=20
>=20

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO2ZyAAoJECTWi3JdVIfQRjYH/15bCAD+yeC34ZD8dRLzBYuU
5MwOy/3knMKzgOuHyXVqaDOm5y1ttWY5rOQljrdGJh67K+DHTRnYkApW9iESEcQ4
k1WYKcRvUzLsHStsS94O/ve5/cXvgBEoMA3cPravUrcKOZQ8sDwjZQFrbm1WbybX
zcfBkrVEaxiI0nC5O1AFwCd63JYjsMMYLtJbGDbjEHZprDvy8kMrDEdz+OhBBro/
A56zwkIUVbBr4oBQVNbJBpivDqPCiOlfqH8qFhkdKw2bimguuT5xeg+uW8ncGbti
AWKU4514d4P4Hr5UX/LT1pehtl4pgfhuX1erp5MqPqoE1WYalhR0Jkx2KnLj8tQ=
=U5j/
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--

--===============0465971537905300454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0465971537905300454==--
