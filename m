From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
Date: Fri, 24 Mar 2017 14:43:40 +0000
Message-ID: <20170324144340.GA17560@red-moon>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<58D49845.9060407@hisilicon.com>
	<0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
	<5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 24, 2017 at 09:27:51AM +0000, Shameerali Kolothum Thodi wrote:

[...]

> @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>   	if (ret < 0) {
>   		dma_addr = offset = 0;
>  -		size = dev->coherent_dma_mask + 1;
>  +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> 
> @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>   	 * Assume dma valid range starts at 0 and covers the whole
>   	 * coherent_dma_mask.
>   	 */
>  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);

size is not defined in acpi_dma_configure(), so there is
something missing in the diff above, just to make sure we are
testing the same thing.

Mind posting kernel logs with and without patch above (fixed) for
DT boot and ACPI boot please.

Thanks,
Lorenzo

>  +	arch_setup_dma_ops(dev, 0, size, iommu,
>   			   attr == DEV_DMA_COHERENT);
> 
> With the above fixes, DT boot works fine. But we still get the below crash on ACPI
> 
> > > [  402.581445] kernel BUG at drivers/iommu/arm-smmu-v3.c:1064!
> > > [  402.587007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > > [  402.592479] Modules linked in: vfio_iommu_type1 vfio_pci irqbypass
> > vfio_virqfd vfio ixgbevf ixgb
> 
> > The change that this series does is trying to add the dma/iommu ops to the
> > device after the iommu is actually probed.
> > So in your working case, does the device initially gets hooked to iommu_ops
> > and the above same check passes in working case ?
> 
> I believe so. Because didn't notice the "specified DMA range outside IOMMU capability"
> in the working case.
>  
> Thanks,
> Shameer
