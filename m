From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 28 Jul 2015 16:52:55 +0100
Message-ID: <20150728155255.GP29209@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
	<20150728101722.GF29209@arm.com> <55B7A22B.6010608@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B7A22B.6010608-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 28, 2015 at 04:39:23PM +0100, Robin Murphy wrote:
> On 28/07/15 11:17, Will Deacon wrote:
> >> +	if (cfg->tlb->flush_pgtable)
> >
> > Why would you have both a dev and a flush callback? In which cases is the
> > DMA API insufficient?
> 
> a) Bisectability given existing users.

You could still make it an if (dev) .. else if (flush_pgtable) ... though.
Then we could put the wmb() in the if () clause after the DMA-api calls
and remove the conditional once everybody has been ported over.

> >> +static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
> >> +			       struct io_pgtable_cfg *cfg, void *cookie)
> >> +{
> >> +	struct device *dev = cfg->iommu_dev;
> >> +
> >> +	*ptep = pte;
> >> +
> >> +	if (dev)
> >> +		dma_sync_single_for_device(dev, __arm_lpae_dma(dev, ptep),
> >> +					   sizeof(pte), DMA_TO_DEVICE);
> >> +	if (cfg->tlb->flush_pgtable)
> >> +		cfg->tlb->flush_pgtable(ptep, sizeof(pte), cookie);
> >
> > Could we kill the flush_pgtable callback completely and just stick in a
> > dma_wmb() here? Ideally, we've have something like dma_store_release,
> > which we could use to set the parent page table entry, but that's left
> > as a future exercise ;)
> 
> I couldn't convince myself that there wouldn't never be some weird case 
> where an IOMMU driver still needs to do something funky for a coherent 
> device, so I left it in. Given that the existing implementations are 
> either dsb or nothing, however, I agree it may be worth taking out now 
> and only bringing back later if proven necessary.

Yeah, let's keep it as simple as we can and avoid giving people callbacks
unless they actually need them.

> I would think we'd need at least wmb() though, since dma_wmb() only 
> gives us a dmb on arm64; if the PTE is going from invalid to valid (i.e. 
> no TLB involved), we'd have the normal cacheable write of the PTE 
> potentially racing with an MMIO write after we return (the "do DMA with 
> this address" command to the master) and I think we might need a dsb to 
> avoid that - if the PTE write hasn't got far enough for the IOMMU to 
> snoop it, the walk hits the stale invalid entry, aborts the incoming 
> transaction and kills the device.

Yes, you're right. I was in a CPU-centric mindset and forgot that we can't
deal with transient faults when going from invalid -> valid for a device
mapping.

Will
