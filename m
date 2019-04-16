From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 6/7] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Tue, 16 Apr 2019 11:00:42 +0100
Message-ID: <20190416100042.GA32213@fuggles.cambridge.arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
	<20190409165245.26500-7-jean-philippe.brucker@arm.com>
	<20190415132121.GC15023@fuggles.cambridge.arm.com>
	<0b9b600f-60e0-0740-e1db-6b684bf5a195@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0b9b600f-60e0-0740-e1db-6b684bf5a195-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 15, 2019 at 07:00:27PM +0100, Jean-Philippe Brucker wrote:
> On 15/04/2019 14:21, Will Deacon wrote:
> > On Tue, Apr 09, 2019 at 05:52:44PM +0100, Jean-Philippe Brucker wrote:
> >> PCIe devices can implement their own TLB, named Address Translation Cache
> >> (ATC). Enable Address Translation Service (ATS) for devices that support
> >> it and send them invalidation requests whenever we invalidate the IOTLBs.
> >>
> >> ATC invalidation is allowed to take up to 90 seconds, according to the
> >> PCIe spec, so it is possible to get a SMMU command queue timeout during
> >> normal operations. However we expect implementations to complete
> >> invalidation in reasonable time.
> >>
> >> We only enable ATS for "trusted" devices, and currently rely on the
> >> pci_dev->untrusted bit. For ATS we have to trust that:
> > 
> > AFAICT, devicetree has no way to describe a device as untrusted, so
> > everything will be trusted by default on those systems. Is that right?
> 
> Yes, although I'm adding a devicetree property for PCI in v5.2:
> https://lore.kernel.org/linux-pci/20190411211823.GU256045-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org/T/#m9f2c036748bab6e262233280b22c1e6fab4e1607

Perfect :)

> >> (a) The device doesn't issue "translated" memory requests for addresses
> >>     that weren't returned by the SMMU in a Translation Completion. In
> >>     particular, if we give control of a device or device partition to a VM
> >>     or userspace, software cannot program the device to access arbitrary
> >>     "translated" addresses.
> > 
> > Any plans to look at split-stage ATS later on? I think that would allow
> > us to pass untrusted devices through to a VM behind S1 ATS.
> 
> I haven't tested it so far, we can look at that after adding support for
> nested translation

Sure, just curious. Thanks.

> 
> >> (b) The device follows permissions granted by the SMMU in a Translation
> >>     Completion. If the device requested read+write permission and only
> >>     got read, then it doesn't write.
> > 
> > Guessing we just ignore execute permissions, or do we need read implies
> > exec?
> 
> Without PASID, a function cannot ask for execute permission, only RO and
> RW. In this case execution by the endpoint is never permitted (because
> the Exe bit in an ATS completion is always zero).
> 
> With PASID, the endpoint must explicitly ask for execute permission (and
> interestingly, can't obtain it if the page is mapped exec-only, because
> in ATS exec implies read.)

Got it, thanks again.

> [...]
> >> +static bool disable_ats_check;
> >> +module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
> >> +MODULE_PARM_DESC(disable_ats_check,
> >> +	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
> > 
> > Yikes, do we really want this option, or is it just a leftover from
> > debugging?
> 
> I wasn't sure what to do with it, I'll drop it in next version

Cheers.

> [...]
> >> @@ -876,6 +911,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
> >>  		dev_err(smmu->dev, "retrying command fetch\n");
> >>  	case CMDQ_ERR_CERROR_NONE_IDX:
> >>  		return;
> >> +	case CMDQ_ERR_CERROR_ATC_INV_IDX:
> >> +		/*
> >> +		 * ATC Invalidation Completion timeout. CONS is still pointing
> >> +		 * at the CMD_SYNC. Attempt to complete other pending commands
> >> +		 * by repeating the CMD_SYNC, though we might well end up back
> >> +		 * here since the ATC invalidation may still be pending.
> >> +		 */
> >> +		return;
> > 
> > This is pretty bad, as it means we're unable to unmap a page safely from a
> > misbehaving device. Ideally, we'd block further transactions from the
> > problematic endpoint, but I suppose we can't easily know which one it was,
> > or inject a fault back into the unmap() path.
> > 
> > Having said that, won't we get a CMD_SYNC timeout long before the ATC timeout?
> 
> Yes, CMD_SYNC timeout is 1s, ATC timeout is 90s...
> 
> > Perhaps we could propagate that out of arm_smmu_cmdq_issue_sync() and fail the
> > unmap?
> > 
> > Not sure, what do you think?
> 
> The callers of iommu_unmap() will free the page regardless of the return
> value, even though the device could still be accessing it. But I'll look
> at returning 0 if the CMD_SYNC times out, it's a good start for
> consolidating this. With dma-iommu.c it will trigger a WARN().

If it's not too tricky, that would be good.

> It gets a worse with PRI, when the invalidation comes from an MMU
> notifier and we can't even return an error. Ideally we'd hold a
> reference to these pages until invalidation completes.

Agreed.

> [...]
> >> +	/*
> >> +	 * Find the smallest power of two that covers the range. Most
> >> +	 * significant differing bit between start and end address indicates the
> >> +	 * required span, ie. fls(start ^ end). For example:
> >> +	 *
> >> +	 * We want to invalidate pages [8; 11]. This is already the ideal range:
> >> +	 *		x = 0b1000 ^ 0b1011 = 0b11
> >> +	 *		span = 1 << fls(x) = 4
> >> +	 *
> >> +	 * To invalidate pages [7; 10], we need to invalidate [0; 15]:
> >> +	 *		x = 0b0111 ^ 0b1010 = 0b1101
> >> +	 *		span = 1 << fls(x) = 16
> >> +	 */
> > 
> > Urgh, "The Address span is aligned to its size by the SMMU" is what makes
> > this horrible. Please can you add that to the comment?
> 
> Sure (but the culprit is really the PCIe spec, with its "naturally
> aligned" ranges.)

Ok, blame them then :)

> > An alternative would be to emit multiple ATC_INV commands. Do you have a
> > feeling for what would be more efficient?
> 
> With the current code, we might be removing cached entries of long-term
> mappings (tables and ring buffers) every time we unmap a buffer, in
> which case enabling ATS would certainly make the device slower.
> 
> Multiple ATC_INV commands may be more efficient but I'm not too
> comfortable implementing it until I have some hardware to test it. I
> suspect we might need to optimize it a bit to avoid sending too many
> invalidations for large mappings.

Ok, just stick that in the comment as well then, please.

Will
