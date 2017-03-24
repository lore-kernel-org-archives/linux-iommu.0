From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
Date: Fri, 24 Mar 2017 15:09:49 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750BC12@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<58D49845.9060407@hisilicon.com>
	<0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
	<5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
	<20170324144340.GA17560@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170324144340.GA17560@red-moon>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, March 24, 2017 2:44 PM
> To: Shameerali Kolothum Thodi
> Cc: Sricharan R; Wangzhou (B); robin.murphy-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linux-
> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org;
> hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> 
> On Fri, Mar 24, 2017 at 09:27:51AM +0000, Shameerali Kolothum Thodi wrote:
> 
> [...]
> 
> > @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct
> device_node *np)
> >   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >   	if (ret < 0) {
> >   		dma_addr = offset = 0;
> >  -		size = dev->coherent_dma_mask + 1;
> >  +		size = max(dev->coherent_dma_mask, dev-
> >coherent_dma_mask + 1);
> >
> > @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum
> dev_dma_attr attr)
> >   	 * Assume dma valid range starts at 0 and covers the whole
> >   	 * coherent_dma_mask.
> >   	 */
> >  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1,
> iommu,
> >  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask +
> 1);
> 
> size is not defined in acpi_dma_configure(), so there is something missing in
> the diff above, just to make sure we are testing the same thing.
> 
> Mind posting kernel logs with and without patch above (fixed) for DT boot
> and ACPI boot please.

Sure. We will rerun the tests to create the logs again and share.

Also need to double check, v9 patches are applied correctly on top of our branch.
If I remember correctly v7 was fine with DT(didn't test with ACPI). But then as 
Shicharan said it had that size fix.

Thanks,
Shameer
[...]
