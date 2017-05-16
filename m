From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC v1 4/7] iommu/arm-smmu-v3: Enable HiSilicon erratum
 161010701
Date: Tue, 16 May 2017 13:46:36 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838350A10@FRAEML521-MBX.china.huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-5-shameerali.kolothum.thodi@huawei.com>
 <6d290334-cb68-5b20-a969-0cc6010922d5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6d290334-cb68-5b20-a969-0cc6010922d5-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, May 16, 2017 2:13 PM
> To: Shameerali Kolothum Thodi; will.deacon-5wv7dgnIgG8@public.gmane.org;
> mark.rutland-5wv7dgnIgG8@public.gmane.org; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gabriele Paoloni; John Garry; Linuxarm;
> linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Wangzhou
> (B); Guohanjun (Hanjun Guo); linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
> Subject: Re: [RFC v1 4/7] iommu/arm-smmu-v3: Enable HiSilicon erratum
> 161010701
> 
> On 13/05/17 10:47, shameer wrote:
> > This replaces the existing broken_prefetch_cmd quirk using
> > the new erratum framework.
> >
> > Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/arm64/Kconfig          | 10 +++++++++-
> >  drivers/iommu/arm-smmu-v3.c | 36 ++++++++++--------------------------
> >  2 files changed, 19 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a39029b..21d61ff 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -508,8 +508,16 @@ config QCOM_FALKOR_ERRATUM_1009
> >
> >  	  If unsure, say Y.
> >
> > -endmenu
> > +config HISILICON_ERRATUM_161010701
> > +	bool "HiSilicon erratum 161010701: Skip SMMU Prefetch Cmd"
> > +	default y
> > +	help
> > +	  On HiSilicon Hip06/Hip07 platforms, the SMMU v3 doesn't support
> the
> > +	  CMD_PREFETCH_CFG. This will skip the prefetch cmd usage.
> >
> > +	  If unsure, say Y.
> 
> We don't need a config. This feature (not to mention others like it) is
> runtime-detected, and has effectively zero execution overhead and
> negligible Image-size overhead either way; why would anyone ever turn it
> off?

This was the side effect of the "framework". Sure will update on next revision.

Thanks,
Shameer
 
> Robin.
> 
> > +
> > +endmenu
> >
> >  choice
> >  	prompt "Page size"
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index f20d5d5..14538cb 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -650,16 +650,6 @@ struct arm_smmu_domain {
> >  	struct iommu_domain		domain;
> >  };
> >
> > -struct arm_smmu_option_prop {
> > -	u32 opt;
> > -	const char *prop;
> > -};
> > -
> > -static struct arm_smmu_option_prop arm_smmu_options[] = {
> > -	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-
> cmd" },
> > -	{ 0, NULL},
> > -};
> > -
> >  enum smmu_erratum_match_type {
> >  	se_match_dt,
> >  };
> > @@ -677,7 +667,17 @@ struct smmu_erratum_workaround {
> >  };
> >
> >  static const struct smmu_erratum_workaround smmu_workarounds[] = {
> > +#ifdef CONFIG_HISILICON_ERRATUM_161010701
> > +	{
> > +		.match_type = se_match_dt,
> > +		.id = "hisilicon,erratum-161010701",
> > +		.desc_str = "HiSilicon erratum 161010701",
> > +		.enable = erratum_skip_prefetch_cmd,
> > +	},
> > +#endif
> > +	{
> >
> > +	},
> >  };
> >
> >  typedef bool (*se_match_fn_t)(const struct smmu_erratum_workaround
> *,
> > @@ -735,20 +735,6 @@ static struct arm_smmu_domain
> *to_smmu_domain(struct iommu_domain *dom)
> >  	return container_of(dom, struct arm_smmu_domain, domain);
> >  }
> >
> > -static void parse_driver_options(struct arm_smmu_device *smmu)
> > -{
> > -	int i = 0;
> > -
> > -	do {
> > -		if (of_property_read_bool(smmu->dev->of_node,
> > -						arm_smmu_options[i].prop))
> {
> > -			smmu->options |= arm_smmu_options[i].opt;
> > -			dev_notice(smmu->dev, "option %s\n",
> > -				arm_smmu_options[i].prop);
> > -		}
> > -	} while (arm_smmu_options[++i].opt);
> > -}
> > -
> >  /* Low-level queue manipulation functions */
> >  static bool queue_full(struct arm_smmu_queue *q)
> >  {
> > @@ -2695,8 +2681,6 @@ static int arm_smmu_device_dt_probe(struct
> platform_device *pdev,
> >  	else
> >  		ret = 0;
> >
> > -	parse_driver_options(smmu);
> > -
> >  	smmu_check_workarounds(smmu, se_match_dt, dev->of_node);
> >
> >  	if (of_dma_is_coherent(dev->of_node))
> >

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
