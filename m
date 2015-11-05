From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/7] regulator: hisilicon: Add hi655x pmic voltage
 regulator driver
Date: Thu, 5 Nov 2015 14:52:35 +0000
Message-ID: <20151105145235.GL18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
 <1446730488-31930-7-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446730488-31930-7-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Feng <puck.chen@hisilicon.com>
Cc: w.f@huawei.com, sameo@linux.intel.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, joro@8bytes.org, iommu@lists.linux-foundation.org, haojian.zhuang@linaro.org, devicetree@vger.kernel.org, xuwei5@hisilicon.com, xuyiping@hisilicon.com, kong.kongxinwei@hisilicon.com, z.liuxinliang@hisilicon.com, yudongbin@hisilicon.com, weidong2@hisilicon.com, saberlily.xia@hisilicon.com, haojian.zhuang@outlook.com, leo.yan@linaro.org, linuxarm@huawei.com, dan.zhao@hisilicon.com, peter.panshilin@hisilicon.com, qijiwen@hisilicon.com
List-Id: iommu@lists.linux-foundation.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:34:47PM +0800, Chen Feng wrote:

> +config REGULATOR_HI6220_MTCMOS
> +        bool "Hisilicon Hi6220 mtcmos support"
> +        depends on ARCH_HISI
> +        help
> +          This driver provides support for the mtcmos regulators of Hi6220 Soc.
> +

The Kconfig and Makefile updates for MCTMOS should have been in the
patch adding the driver for that.

> +config REGULATOR_HI655X
> +        bool "HiSilicon Hi655x PMIC voltage regulator support"
> +        depends on ARCH_HISI

For both of these we should have an || COMPILE_TEST and there's no need
for either to be bool I can see, they should be tristate.

> +static int hi655x_is_enabled(struct regulator_dev *rdev)
> +{
> +	unsigned int value = 0;
> +
> +	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +	struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
> +
> +	regmap_read(rdev->regmap, ctrl_regs->status_reg, &value);
> +	return (value & BIT(regulator->ctrl_mask));
> +}

Use the standard regmap helpers, don't open code them.

> +static int hi655x_set_voltage(struct regulator_dev *rdev,
> +			      int min_uV, int max_uV, unsigned *selector)

Use the standard helpers, including one of the map_voltage()s and
set_voltage_sel_regmap(), don't open code them.

> +static unsigned int hi655x_map_mode(unsigned int mode)
> +{
> +	/* hi655x pmic on hi6220 SoC only support normal mode */
> +	if (mode == REGULATOR_MODE_NORMAL)
> +		return REGULATOR_MODE_NORMAL;
> +	else
> +		return -EINVAL;
> +}

If the device only has one mode it should not have any mode operations,
they're only meaningful if there are multiple modes to set and they are
optional.

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO20zAAoJECTWi3JdVIfQzNEH/jpa836KNhSjL0W65vB9atoO
dRea5z98Kf63gySLLlDetVOpkognKWcINX1JpA8lX/rRcz+k7aMiGiUOMKcl8Nme
FARTdYniBeaWFzsqnQ5x3Fj+hYQKZI1w790zmYXq8s62poBOKD7urZORFa6t7FyM
dQbx+cv4GjTomMHyHP/ZG1sqzzmU5OOl3pU250perDTnMsAhWa7Ffcuiig3zvoSz
mfkydBteaWlXHGfea7HY1qPD02ZVCbJXd+ggVGxbAVs4d8uW9uUDrdWPqGAkaelK
Fj1hbNBp/bCxQyIXb/4wKx0vj/8an/MoRUMaanfofInXeRNj3Jdp0Mx0oXXiLPU=
=9lqP
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
