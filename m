From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Thu, 9 Nov 2017 11:36:29 -0800
Message-ID: <20171109113629.6a9251a4@jacob-builder>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
	<A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
	<09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
	<A2975661238FB949B60364EF0F2C257439B06809@SHSMSX104.ccr.corp.intel.com>
	<e95ce88b-7e88-5b1c-3a68-9ac40773a8f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e95ce88b-7e88-5b1c-3a68-9ac40773a8f6-5wv7dgnIgG8@public.gmane.org>
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
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 7 Nov 2017 11:38:50 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> I think the IOMMU should pass the struct device associated to the BDF
> to the fault handler. The fault handler can then deduce the BDF from
> struct device if it needs to. This also allows to support faults from
> non-PCI devices, where the BDF or deviceID is specific to the IOMMU
> and doesn't mean anything to the device driver.
> 
Passing struct device is only useful if we use shared fault
notification method, as I did in V1 patch with group level or current
domain level.

But the patch proposed here is a per device callback, there is no need
for passing struct device since it is implied.

> I agree that we should provide the PASID if present.
> 
>  [...]  
>  [...]  
> 
> Yes, and reporting faulting address and PASID can help the device
> driver decide what to do. For example a GPU driver might share the
> device between multiple processes, and an unrecoverable fault might
> simply be that one of the process tried to DMA outside its
> boundaries. In that case you'd want to kill the process, not reset
> the device.
> 
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
> 
> Actually this could also be that the device simply isn't allowed to
> DMA, so not necessarily the pIOMMU driver misprogramming its tables.
> So the host IOMMU driver should notify the device driver when
> encountering an invalid device entry, telling it to reset the device.
> 
> >>>> * PASID table fetch -> guest IOMMU driver or host userspace's
> >>>> fault  
> 
> Another reason I missed before is "invalid PASID". This means that the
> device driver used a PASID that wasn't reserved or that's outside of
> the PASID table, so is really the device drivers's fault. It should
> probably be distinguished from "pgd fetch error" below, which is the
> vIOMMU driver misprogramming the PASID table.
> 
> >>>> * pgd fetch -> guest IOMMU driver's fault
> >>>> * pte fetch, including validity and access check -> device
> >>>> driver's fault  
>  [...]  
>  [...]  
> > 
> > [Liu, Yi L] Yes, I think for fault during iova(host iova or GPA)
> > translation, the most likely reason would be no calling of map()
> > since we are using synchronized map API.
> > 
> > Besides the four reasons you listed above, I think there is still
> > other reasons like no present bit, invalid programming or so. And
> > also, we have several tables which may be referenced in an address
> > translation. e.g. VT-d, we have root table, CTX table, pasid table,
> > translation page table(1st level, 2nd level). I think AMD-iommu and
> > SMMU should have similar stuffs?  
> 
> Yes but the four (now five) reasons listed above attempt to synthesize
> these reasons into a vendor-agnostic format. For example what I called
> "Invalid device entry" is "invalid root or ctx table" on VT-d,
> "Invalid STE" on SMMU, "illegal dev table entry" on AMD.

For reporting purposes, I think we only need to care about the reasons
that are interesting outside IOMMU subsystem. e.g. invalid root/ctx
programming are solely responsible by IOMMU driver, there is no need to
include that in the fault reporting data.
Could you provide more specific proposals to the fault event? perhaps
i have missed it somewhere.

 * @type contains fault type.
 * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
 *         faults are not reported
 * @paddr: tells the offending page address
 * @pasid: contains process address space ID, used in shared virtual memory(SVM)
 * @rid: requestor ID
 * @page_req_group_id: page request group index
 * @last_req: last request in a page request group
 * @pasid_valid: indicates if the PRQ has a valid PASID
 * @prot: page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE
 * @private_data: uniquely identify device-specific private data for an
 *                individual page request
 */
struct iommu_fault_event {
	enum iommu_fault_type type;
	enum iommu_fault_reason reason;
	u64 paddr;
	u32 pasid;
	u32 rid:16;
	u32 page_req_group_id : 9;
	u32 last_req : 1;
	u32 pasid_valid : 1;
	u32 prot;
	u32 private_data;
};
