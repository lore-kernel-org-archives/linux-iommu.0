From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] doc:bindings:Document for mtcmos regulator on hi6220
 SoC
Date: Thu, 5 Nov 2015 14:14:02 +0000
Message-ID: <20151105141402.GH18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
 <1446730488-31930-3-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446730488-31930-3-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Feng <puck.chen@hisilicon.com>
Cc: w.f@huawei.com, sameo@linux.intel.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, joro@8bytes.org, iommu@lists.linux-foundation.org, haojian.zhuang@linaro.org, devicetree@vger.kernel.org, xuwei5@hisilicon.com, xuyiping@hisilicon.com, kong.kongxinwei@hisilicon.com, z.liuxinliang@hisilicon.com, yudongbin@hisilicon.com, weidong2@hisilicon.com, saberlily.xia@hisilicon.com, haojian.zhuang@outlook.com, leo.yan@linaro.org, linuxarm@huawei.com, dan.zhao@hisilicon.com, peter.panshilin@hisilicon.com, qijiwen@hisilicon.com
List-Id: iommu@lists.linux-foundation.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:34:43PM +0800, Chen Feng wrote:

> +- hisilicon,mtcmos-steady-us: The time to wait for power steady
> +- hisilicon,mtcmos-sc-on-base: address of mtcmos on hi6220 SoC
> +
> +Required child device properties:
> +- regulator-name: The name of mtcmos
> +- hisilicon,ctrl-regs: Offset of ctrl-regs
> +- hisilicon,ctrl-data: The bit to ctrl the regulator

This doesn't look like a regulator binding at all...  for one thing
there's no reference to the generic regulator bindings, and having a
mandatory regulator-name seems like there's a problem somewhere.

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO2QpAAoJECTWi3JdVIfQjWgH/1GAS4hIwaq3xg+vCn+MqmD5
TpGgA0E/HGs+s+uZhfMHeKz27+uwUcMfOzzQ2xmyJOa1zP+PzyFdbXPAhE89El+m
AiStkraFQdWEx+TRJbvs/pdI7oNC9uOgU386snZNKPy89/d1iKosANFT/XHxLxI2
HPWR0JJyrniVhpyozFzuZ8e435BpMZFQMjz1e4qZtUJRcXkRb0CC4V63NTeIvYlM
ucrU2SyEjL1gei58HQLujQj1btVDMdafNqOfcL4CJO4GJpgKO5TVGUa58HFSiiSs
/qEjweFPfHpDcDbNSkZcH8nLIhWEFPG7RXZmTO8g4aQ8M7BPg3auYoT29upgxF4=
=OODY
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
