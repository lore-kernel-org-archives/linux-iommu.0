From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/7] regulator: add driver for mtcmos voltage regulator
	on hi6220 SoC
Date: Thu, 5 Nov 2015 14:44:41 +0000
Message-ID: <20151105144441.GK18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-6-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4301795931876115261=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-6-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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


--===============4301795931876115261==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:34:46PM +0800, Chen Feng wrote:
> Add driver to support mtcmos on hi6220

I just noticed that these patches are all being posted to the IOMMU list
- that seems a bit odd?

> +static int hi6220_mtcmos_is_on(struct hi6220_mtcmos *mtcmos,
> +			       unsigned int regs, unsigned int mask, int shift)
> +{
> +	unsigned int ret;
> +
> +	ret = readl(mtcmos->sc_on_regs + regs);
> +	ret &= (mask << shift);
> +
> +	return ret;
> +}
> +
> +static int hi6220_mtcmos_is_enabled(struct regulator_dev *rdev)
> +{
> +	int ret;
> +	struct hi6220_mtcmos_info *sreg = rdev_get_drvdata(rdev);
> +	struct platform_device *pdev =
> +		container_of(rdev->dev.parent, struct platform_device, dev);
> +	struct hi6220_mtcmos *mtcmos = platform_get_drvdata(pdev);
> +	struct hi6220_mtcmos_ctrl_regs *ctrl_regs = &sreg->ctrl_regs;
> +	struct hi6220_mtcmos_ctrl_data *ctrl_data = &sreg->ctrl_data;
> +
> +	ret = hi6220_mtcmos_is_on(mtcmos, ctrl_regs->status_reg,
> +				  ctrl_data->mask, ctrl_data->shift);
> +	return ret;
> +}

That's a *lot* of code for checking if a single bit is set, the same
thinng applies to the rest of the driver.  Unless this is for some
reason very performance critical I'd recommend just using regmap-mmio
and the regmap helpers, that will enable you to remove almost all the
code here.  Even if you can't do that at least removing the extra level
of helper function would help.

> +	sc_on_regs = of_get_property(np, "hisilicon,mtcmos-sc-on-base", NULL);
> +	if (sc_on_regs) {
> +		regs = ioremap(be32_to_cpu(*sc_on_regs), SZ_4K);
> +		mtcmos->sc_on_regs = regs;
> +	} else
> +		return -ENODEV;

{ } on both sides of the if statement.  You should also use normal
reg resource specifiers for register blocks the you need rather than
open coding some custom properties with absolute addresses.

> +	for (i = 0; i < HI6220_RG_MAX; i++) {
> +		init_data = hi6220_mtcmos_matches[i].init_data;
> +		if (!init_data)
> +			continue;

No, you should register all regulators on the device not just those with
init_data - you should just let the core do the DT parsing for you using
the standard of_match feature in the regulator_desc.

> +		mtcmos->rdev[i] = regulator_register(&sreg->rdesc, &config);
> +		if (IS_ERR(mtcmos->rdev[i])) {

devm_regulator_register().

> +static const struct of_device_id of_hi6220_mtcmos_match_tbl[] = {
> +	{ .compatible = "hisilicon,hi6220-mtcmos-driver", },

Why is -driver part of the compatible?

> +	.driver = {
> +		.name = "hisi_hi6220_mtcmos",

Linux generally uses - not _ in names.

> +static int __init hi6220_mtcmos_init(void)
> +{
> +	return platform_driver_register(&mtcmos_driver);
> +}
> +
> +static void __exit hi6220_mtcmos_exit(void)
> +{
> +	platform_driver_unregister(&mtcmos_driver);
> +}
> +
> +fs_initcall(hi6220_mtcmos_init);

Why is this at fs_initcall?!

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO2tYAAoJECTWi3JdVIfQjuAH/R2MXGGGUX6dgSc/DAE+NxTy
zD/n3DLQS/hg/jNok/L/b225iwPNU8IwGt+QaVarcuRlaYRhB/XQJfF326UKK03S
dZ5AZKk/G7pR4PppRS7huL9dleDEhWXEETSseVdghb8zqeMN01iIVraIqNrxNZSp
3gKUicN/CR2GwPBMZpCuVsrPcyiQHpPEfI/5UCOVSiTZoRyw/oFzaxrk7aSMNEuo
XnIIaYKwSK+REpHW3Aunv/yL9bcqQP7MWf47Bz8av7LxJCdX1PZZoSXhsCFaLJJ7
D77YKV2EidQs4AUH3xD5XaFYVuNrw5s7TgkXl5VaqKGe/EsT6Gn//CN/Z3XXfPY=
=Rhqg
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--

--===============4301795931876115261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4301795931876115261==--
