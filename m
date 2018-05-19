From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 35/40] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Sat, 19 May 2018 13:25:06 -0400
Message-ID: <922474e8-0aa5-e022-0502-f1e51b0d4859@codeaurora.org>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-36-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-36-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 5/11/2018 3:06 PM, Jean-Philippe Brucker wrote:
> PCIe devices can implement their own TLB, named Address Translation Cache
> (ATC). Enable Address Translation Service (ATS) for devices that support
> it and send them invalidation requests whenever we invalidate the IOTLBs.
> 
>   Range calculation
>   -----------------
> 
> The invalidation packet itself is a bit awkward: range must be naturally
> aligned, which means that the start address is a multiple of the range
> size. In addition, the size must be a power of two number of 4k pages. We
> have a few options to enforce this constraint:
> 
> (1) Find the smallest naturally aligned region that covers the requested
>     range. This is simple to compute and only takes one ATC_INV, but it
>     will spill on lots of neighbouring ATC entries.
> 
> (2) Align the start address to the region size (rounded up to a power of
>     two), and send a second invalidation for the next range of the same
>     size. Still not great, but reduces spilling.
> 
> (3) Cover the range exactly with the smallest number of naturally aligned
>     regions. This would be interesting to implement but as for (2),
>     requires multiple ATC_INV.
> 
> As I suspect ATC invalidation packets will be a very scarce resource, I'll
> go with option (1) for now, and only send one big invalidation. We can
> move to (2), which is both easier to read and more gentle with the ATC,
> once we've observed on real systems that we can send multiple smaller
> Invalidation Requests for roughly the same price as a single big one.
> 
> Note that with io-pgtable, the unmap function is called for each page, so
> this doesn't matter. The problem shows up when sharing page tables with
> the MMU.
> 
>   Timeout
>   -------
> 
> ATC invalidation is allowed to take up to 90 seconds, according to the
> PCIe spec, so it is possible to hit the SMMU command queue timeout during
> normal operations.
> 
> Some SMMU implementations will raise a CERROR_ATC_INV_SYNC when a CMD_SYNC
> fails because of an ATC invalidation. Some will just abort the CMD_SYNC.
> Others might let CMD_SYNC complete and have an asynchronous IMPDEF
> mechanism to record the error. When we receive a CERROR_ATC_INV_SYNC, we
> could retry sending all ATC_INV since last successful CMD_SYNC. When a
> CMD_SYNC fails without CERROR_ATC_INV_SYNC, we could retry sending *all*
> commands since last successful CMD_SYNC.
> 
> We cannot afford to wait 90 seconds in iommu_unmap, let alone MMU
> notifiers. So we'd have to introduce a more clever system if this timeout
> becomes a problem, like keeping hold of mappings and invalidating in the
> background. Implementing safe delayed invalidations is a very complex
> problem and deserves a series of its own. We'll assess whether more work
> is needed to properly handle ATC invalidation timeouts once this code runs
> on real hardware.
> 
>   Misc
>   ----
> 
> I didn't put ATC and TLB invalidations in the same functions for three
> reasons:
> 
> * TLB invalidation by range is batched and committed with a single sync.
>   Batching ATC invalidation is inconvenient, endpoints limit the number of
>   inflight invalidations. We'd have to count the number of invalidations
>   queued and send a sync periodically. In addition, I suspect we always
>   need a sync between TLB and ATC invalidation for the same page.
> 
> * Doing ATC invalidation outside tlb_inv_range also allows to send less
>   requests, since TLB invalidations are done per page or block, while ATC
>   invalidations target IOVA ranges.
> 
> * TLB invalidation by context is performed when freeing the domain, at
>   which point there isn't any device attached anymore.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>


Nothing specific about this patch but just a general observation. Last time I
looked at the code, it seemed to require both ATS and PRI support from a given
hardware.

I think you can assume that for ATS 1.1 specification but ATS 1.0 specification
allows a system to have ATS+PASID without PRI. 

QDF2400 is ATS 1.0 compatible as an example. 

Is this an assumption / my misinterpretation?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
