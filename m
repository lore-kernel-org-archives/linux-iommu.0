From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Fri, 14 Jul 2017 20:01:14 +0100
Message-ID: <20170714190113.GE26488@arm.com>
References: <20170712225459.GZ22780@codeaurora.org>
 <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
 <4dbc938c-ac88-9bd4-cf00-458008ae24c1@codeaurora.org>
 <CAF6AEGsFOtsOjt1sLNPSFLEcu-7d1zxCOhTeC+P8e0TDbb1dSA@mail.gmail.com>
 <60a56ae6-ed9d-57cd-130f-5bd9d32d4d58@codeaurora.org>
 <CAF6AEGvDpRChNQAzqgRFwaQcH=4JCwfKcvj2GQGgQOnO2_A1sg@mail.gmail.com>
 <20170714170743.GA26488@arm.com>
 <CAF6AEGtMiVJvSrPXmQppM2NwS3fsXM8Vep3g0PwQK7SH4N=3xQ@mail.gmail.com>
 <20170714180615.GC26488@arm.com>
 <CAF6AEGubgNiq5fJ9LaBULvW3450iY4-u0ecpp_a6xyMvRx9kug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGubgNiq5fJ9LaBULvW3450iY4-u0ecpp_a6xyMvRx9kug@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Sricharan R <sricharan@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 14, 2017 at 02:25:45PM -0400, Rob Clark wrote:
> On Fri, Jul 14, 2017 at 2:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jul 14, 2017 at 01:42:13PM -0400, Rob Clark wrote:
> >> On Fri, Jul 14, 2017 at 1:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Thu, Jul 13, 2017 at 10:55:10AM -0400, Rob Clark wrote:
> >> >> On Thu, Jul 13, 2017 at 9:53 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > On 7/13/2017 5:20 PM, Rob Clark wrote:
> >> >> >> On Thu, Jul 13, 2017 at 1:35 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> >> >> >>> Hi Vivek,
> >> >> >>>
> >> >> >>> On 7/13/2017 10:43 AM, Vivek Gautam wrote:
> >> >> >>>> Hi Stephen,
> >> >> >>>>
> >> >> >>>>
> >> >> >>>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
> >> >> >>>>> On 07/06, Vivek Gautam wrote:
> >> >> >>>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
> >> >> >>>>>>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
> >> >> >>>>>>                    size_t size)
> >> >> >>>>>>   {
> >> >> >>>>>> -    struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> >> >> >>>>>> +    struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >> >> >>>>>> +    struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> >> >> >>>>>> +    size_t ret;
> >> >> >>>>>>         if (!ops)
> >> >> >>>>>>           return 0;
> >> >> >>>>>>   -    return ops->unmap(ops, iova, size);
> >> >> >>>>>> +    pm_runtime_get_sync(smmu_domain->smmu->dev);
> >> >> >>>>> Can these map/unmap ops be called from an atomic context? I seem
> >> >> >>>>> to recall that being a problem before.
> >> >> >>>>
> >> >> >>>> That's something which was dropped in the following patch merged in master:
> >> >> >>>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
> >> >> >>>>
> >> >> >>>> Looks like we don't  need locks here anymore?
> >> >> >>>
> >> >> >>>  Apart from the locking, wonder why a explicit pm_runtime is needed
> >> >> >>>  from unmap. Somehow looks like some path in the master using that
> >> >> >>>  should have enabled the pm ?
> >> >> >>>
> >> >> >>
> >> >> >> Yes, there are a bunch of scenarios where unmap can happen with
> >> >> >> disabled master (but not in atomic context).  On the gpu side we
> >> >> >> opportunistically keep a buffer mapping until the buffer is freed
> >> >> >> (which can happen after gpu is disabled).  Likewise, v4l2 won't unmap
> >> >> >> an exported dmabuf while some other driver holds a reference to it
> >> >> >> (which can be dropped when the v4l2 device is suspended).
> >> >> >>
> >> >> >> Since unmap triggers tbl flush which touches iommu regs, the iommu
> >> >> >> driver *definitely* needs a pm_runtime_get_sync().
> >> >> >
> >> >> >  Ok, with that being the case, there are two things here,
> >> >> >
> >> >> >  1) If the device links are still intact at these places where unmap is called,
> >> >> >     then pm_runtime from the master would setup the all the clocks. That would
> >> >> >     avoid reintroducing the locking indirectly here.
> >> >> >
> >> >> >  2) If not, then doing it here is the only way. But for both cases, since
> >> >> >     the unmap can be called from atomic context, resume handler here should
> >> >> >     avoid doing clk_prepare_enable , instead move the clk_prepare to the init.
> >> >> >
> >> >>
> >> >> I do kinda like the approach Marek suggested.. of deferring the tlb
> >> >> flush until resume.  I'm wondering if we could combine that with
> >> >> putting the mmu in a stalled state when we suspend (and not resume the
> >> >> mmu until after the pending tlb flush)?
> >> >
> >> > I'm not sure that a stalled state is what we're after here, because we need
> >> > to take care to prevent any table walks if we've freed the underlying pages.
> >> > What we could try to do is disable the SMMU (put into global bypass) and
> >> > invalidate the TLB when performing a suspend operation, then we just ignore
> >> > invalidation whilst the clocks are stopped and, on resume, enable the SMMU
> >> > again.
> >>
> >> wouldn't stalled just block any memory transactions by device(s) using
> >> the context bank?  Putting it in bypass isn't really a good thing if
> >> there is any chance the device can sneak in a memory access before
> >> we've taking it back out of bypass (ie. makes gpu a giant userspace
> >> controlled root hole).
> >
> > If it doesn't deadlock, then yes, it will stall transactions. However, that
> > doesn't mean it necessarily prevents page table walks.
> 
> btw, I guess the concern about pagetable walk is that the unmap could
> have removed some sub-level of the pt that the tlb walk would hit?
> Would deferring freeing those pages help?

Could do, but it sounds like a lot of complication that I think we can fix
by making the suspend operation put the SMMU into a "clean" state.

> > Instead of bypass, we
> > could configure all the streams to terminate, but this race still worries me
> > somewhat. I thought that the SMMU would only be suspended if all of its
> > masters were suspended, so if the GPU wants to come out of suspend then the
> > SMMU should be resumed first.
> 
> I believe this should be true.. on the gpu side, I'm mostly trying to
> avoid having to power the gpu back on to free buffers.  (On the v4l2
> side, somewhere in the core videobuf code would also need to be made
> to wrap it's dma_unmap_sg() with pm_runtime_get/put()..)

Right, and we shouldn't have to resume it if we suspend it in a clean state,
with the TLBs invalidated.

Will
