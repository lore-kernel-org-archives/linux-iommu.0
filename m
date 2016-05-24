From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Tue, 24 May 2016 16:00:06 +0200
Message-ID: <7555154.mU2oTAdECP@wuerfel>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org> <3164695.VzCnHHyi7r@wuerfel> <000601d1b4b9$119c2410$34d46c30$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000601d1b4b9$119c2410$34d46c30$@codeaurora.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday, May 23, 2016 11:35:04 AM CEST Sricharan wrote:
> Hi Arnd,
> 
> >> @@ -124,6 +124,9 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
> >>  		SET_TLBLKCR(base, ctx, 0);
> >>  		SET_CONTEXTIDR(base, ctx, 0);
> >>  	}
> >> +
> >> +	/* Ensure completion of relaxed writes from the above SET macros */
> >> +	mb();
> >>  }
> >
> >Why do the above use the relaxed writes? Do you have any performance
> >numbers showing that skipping the sync for the reset makes a measurable
> >difference?
> >
> >How did you prove that skipping the sync before the write is safe?
> >
> >How about resetting the iommu less often instead?
> >
> 
> I had measured the numbers only for the full usecase path, not for the
> reset path alone. I saw improvement of about 5% on full numbers.
> As you said, the reset path would be called only less often
> and might not bring a measurable change. I did not see a difference in behavior
> when changing the sync to happen after the writes.

Ok, then better not change it.

> But my understanding was that
> the sync after the writes was required to ensure write completion. 

Can you cite the relevant documentation on this? Is this specific
to the Qualcomm CPU implementation or the IOMMU? I don't think
the ARM architecture requires anything like this in general.

> I should have made smaller patches to do this change.
> The only patch relevant for this series is the one that changes the write in _iotlb_range
> function. Rest of the changes, should be added one by one in a separate series.

If you see the same 5% performance improvement with a simpler change, then
better do only that. The IOMMU infrastructure is rather sensitive to
having correct barriers everywhere, so this minimizes the risk of getting
it wrong somewhere.


> >> @@ -181,7 +187,8 @@ fail:
> >>
> >>  static void __flush_iotlb_sync(void *cookie)
> >>  {
> >> -	/* To avoid a null function pointer */
> >> +	/* To ensure completion of the TLBIVA in __flush_iotlb_range */
> >> +	mb();
> >>  }
> >
> >I don't understand the specific race from the comment.
> >
> >What operation comes after this that relies on __flush_iotlb_range
> >having completed, and how does an mb() guarantee this?
> >
> 
> The flush_iotlb_range operation invalidates the tlb for writes to
> pagetable and the finally calls the sync operation to ensure completion
> of the flush and this is required before returning back to the client
> of the iommu. In the case of this iommu, only a barrier is required to
> ensure completion of the invalidate operation. 

This doesn't answer my question: What operation would a client do
that requires the flush to be completed here? A barrier is always
defined in terms of things that come before it in combination with
things that come after it.

Any operation that could trigger a DMA from a device is required
to have a barrier preceding it (usually wmb() one implied by writel()),
so this is clearly not about a driver that installs a DMA mapping
before starting a DMA, but I don't see what else it would be.

> >This seems to be a bug fix that is unrelated to the change to
> >use writel_relaxed(), so better split it out into a separate
> >patch, with a longer changeset description. Did you spot this
> >race by running into incorrect data, or by inspection?
> >
> 
> No i did not see a data corruption issue without the mb(),
> but that it would have been hidden in someother way as well.
> Another difference was the sync  was done before the write
> previously and now its moved after the write. As i understand
> sync after the write is correct. So i will change this patch with more
> description and move rest of that changes out.

Ok.

> >> @@ -500,7 +516,8 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
> >>  	/* Invalidate context TLB */
> >>  	SET_CTX_TLBIALL(iommu->base, master->num, 0);
> >>  	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
> >> -
> >> +	/* Ensure completion of relaxed writes from the above SET macros */
> >> +	mb();
> >>  	par = GET_PAR(iommu->base, master->num);
> >>
> >>  	/* We are dealing with a supersection */
> >
> >In this case, I'd say it's better to rewrite the function to avoid the
> >read: iova_to_phys() should be fast, and not require hardware access.
> >Getting rid of the hardware access by using an in-memory cache for
> >this should gain more than just removing the barriers, as an MMIO read
> >is always slow
> 
> Ok, you mean using the software walk through ? I will check on this to measure
>  the latency difference. If thats true, then the iopgtable ops itself provides a
> function for iova_to_phys conversion, so that can be used.

I hadn't realized that this is a lookup in the hardware, rather than
reading a static register. It's probably a good idea to check this
anyway.


	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
