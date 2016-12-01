From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device
	gets context mapped
Date: Thu, 1 Dec 2016 11:33:07 +0100
Message-ID: <20161201103307.GL2078@8bytes.org>
References: <582C232F.6080205@redhat.com>
	<CAL-B5D1kkWE4e6P1xY1Cgkf-7+nBXH=C7g21=phEzmM4FPZRRQ@mail.gmail.com>
	<582D1A40.409@redhat.com> <20161129143547.GG2078@8bytes.org>
	<583E8A9B.7070906@redhat.com> <20161130090327.GA4192@x1>
	<20161130095334.GB4192@x1> <20161130102334.GC4192@x1>
	<20161130142642.GJ2078@8bytes.org> <583F87D1.6030402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <583F87D1.6030402-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 01, 2016 at 10:15:45AM +0800, Xunlei Pang wrote:
> index 3965e73..624eac9 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2024,6 +2024,25 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>         if (context_present(context))
>                 goto out_unlock;
>  
> +       /*
> +        * For kdump cases, old valid entries may be cached due to the
> +        * in-flight DMA and copied pgtable, but there is no unmapping
> +        * behaviour for them, thus we need an explicit cache flush for
> +        * the newly-mapped device. For kdump, at this point, the device
> +        * is supposed to finish reset at its driver probe stage, so no
> +        * in-flight DMA will exist, and we don't need to worry anymore
> +        * hereafter.
> +        */
> +       if (context_copied(context)) {
> +               u16 did_old = context_domain_id(context);
> +
> +               if (did_old >= 0 && did_old < cap_ndoms(iommu->cap))
> +                       iommu->flush.flush_context(iommu, did_old,
> +                                                  (((u16)bus) << 8) | devfn,
> +                                                  DMA_CCMD_MASK_NOBIT,
> +                                                  DMA_CCMD_DEVICE_INVL);
> +       }
> +
>         pgd = domain->pgd;

Yes, this looks better. Have you tested it the same way as the old
patch?


	Joerg
