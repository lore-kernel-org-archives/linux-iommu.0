From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] mfd: hi655x: Add hi665x pmic driver
Date: Thu, 5 Nov 2015 14:30:10 +0000
Message-ID: <20151105143010.GJ18409@sirena.org.uk>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-5-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3694602394536599762=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-5-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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


--===============3694602394536599762==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:34:45PM +0800, Chen Feng wrote:

> +config MFD_HI655X_PMIC
> +        bool "HiSilicon Hi655X series PMU/Codec IC"

Why is this bool and not tristate?

> +        depends on ARCH_HISI

Can we have an || COMPILE_TEST here?

> +static irqreturn_t hi655x_pmic_irq_handler(int irq, void *data)
> +{
> +	struct hi655x_pmic *pmic = (struct hi655x_pmic *)data;
> +	u32 pending;
> +	u32 ret = IRQ_NONE;
> +	unsigned long offset;
> +	int i;

This looks like you should be able to use regmap_irq?

> +static int hi655x_pmic_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
> +
> +	free_irq(pmic->irq, pmic);
> +	gpio_free(pmic->gpio);
> +	devm_release_mem_region(dev, pmic->res->start,
> +				resource_size(pmic->res));
> +	devm_kfree(dev, pmic);
> +	platform_set_drvdata(pdev, NULL);

There is no point in using devm_ cleanup functions in the device removal
path unless there's some ordering issue with respect to other stuff
which doesn't seem to be the case here.

> +static struct platform_driver hi655x_pmic_driver = {
> +	.driver	= {
> +		.name =	"hisi,hi655x-pmic",

We don't normally use OF style names in the Linux driver names.

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO2fyAAoJECTWi3JdVIfQhXQH/RIo7rtxAZ5RgzWByhvia68h
h5TtUQIJz2IPKcI21LCPrX0yVAs4vWz8ekT/Ogd0NUVwC/kszq2UOg8VfiI8X4e+
4xIniMVPeJIBc6NkL1k3V3DQ2bWzlQFUonSTOVzdUtftgAckci0t2zy+pOad9m9Q
JdJPUQYq9S2Z7j62MDcPcr+7uBggABD7ry39kooawcz2OrT/r/xbm7ibpXwsDehZ
/QauvnvOTKdBdn9K3lE6ejufxzTlGbaLGxvjeLSG6pbDN2UWIsFIOYZuulrl4Cc7
sEH7G5rbG1XHdbTChB7sgKZe8Y/8Hz4ycuP7sYRaizsHIOn1TnSxwQ4QdUzoM0E=
=H64R
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--

--===============3694602394536599762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3694602394536599762==--
