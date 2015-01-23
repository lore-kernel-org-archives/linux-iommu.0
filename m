From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
	arm_iommu_attach_device()
Date: Fri, 23 Jan 2015 17:55:25 +0200
Message-ID: <2416515.WUUq1g4kPD@avalon>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<10179212.ryUUVC9zEx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <10179212.ryUUVC9zEx@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Friday 23 January 2015 16:27:24 Arnd Bergmann wrote:
> On Friday 23 January 2015 16:21:49 Laurent Pinchart wrote:
> > +/**
> > + * arm_iommu_detach_device
> > + * @dev: valid struct device pointer
> > + *
> > + * Detaches the provided device from a previously attached map.
> > + * This voids the dma operations (dma_map_ops pointer)
> > + */
> > +void arm_iommu_detach_device(struct device *dev)
> > +{
> > +       __arm_iommu_detach_device(dev);
> > +       set_dma_ops(dev, NULL);
> > +}
> > 
> >  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> 
> Would this introduce a regression in the case where the device is
> cache coherent and needs arm_coherent_dma_ops set?

I think we need to handle that case (as well as the coherent IOMMU case in 
arm_iommu_attach_device), but this patch only tries to restore the previous 
behaviour to fix the bug detailed in the commit message. Would you prefer 
fixing both issues in one go ?

-- 
Regards,

Laurent Pinchart
