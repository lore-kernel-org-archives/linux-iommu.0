From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 08/16] iommu: introduce device fault data
Date: Thu, 11 Jan 2018 13:10:55 -0800
Message-ID: <20180111131055.436b7ccc@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<f9f9dd55-3191-eba0-f4e7-e7c9f16c00f1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f9f9dd55-3191-eba0-f4e7-e7c9f16c00f1-5wv7dgnIgG8@public.gmane.org>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org" <Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 10 Jan 2018 11:41:58 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Jacob,
> 
> On 17/11/17 18:55, Jacob Pan wrote:
> [...]
> > +/**
> > + * struct iommu_fault_event - Generic per device fault data
> > + *
> > + * - PCI and non-PCI devices
> > + * - Recoverable faults (e.g. page request), information based on
> > PCI ATS
> > + * and PASID spec.
> > + * - Un-recoverable faults of device interest
> > + * - DMA remapping and IRQ remapping faults
> > +
> > + * @type contains fault type.
> > + * @reason fault reasons if relevant outside IOMMU driver, IOMMU
> > driver internal
> > + *         faults are not reported
> > + * @addr: tells the offending page address
> > + * @pasid: contains process address space ID, used in shared
> > virtual memory(SVM)
> > + * @rid: requestor ID
> > + * @page_req_group_id: page request group index
> > + * @last_req: last request in a page request group
> > + * @pasid_valid: indicates if the PRQ has a valid PASID
> > + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> > IOMMU_FAULT_WRITE
> > + * @device_private: if present, uniquely identify device-specific
> > + *                  private data for an individual page request.
> > + * @iommu_private: used by the IOMMU driver for storing
> > fault-specific
> > + *                 data. Users should not modify this field before
> > + *                 sending the fault response.
> > + */
> > +struct iommu_fault_event {
> > +	enum iommu_fault_type type;
> > +	enum iommu_fault_reason reason;
> > +	u64 addr;
> > +	u32 pasid;
> > +	u32 page_req_group_id : 9;  
> 
> As I've been rebasing my work onto your series, I have a few more
> comments about this structure. Is there any advantage in limiting the
> PRGI as a bitfield? PCI uses 9 bits, but others might need more. For
> instance ARM Stall uses 16-bit IDs to identify a fault event.
> 
> Could you please make it a u32 (as well as in page_response_msg), and
> could page_req_group_id be renamed to simply "id"?
> 
sure, I will make it u32 in v4 version of the patchset. I was using PCI
standard as a base with no specific advantage.
I am running into little bit problem with testing, so perhaps next week.
> > +	u32 last_req : 1;
> > +	u32 pasid_valid : 1;  
> I noticed that page_response_msg in patch 15/16 calls this bit
> "pasid_present". Could you rename it to "pasid_valid" for consistency?
> 
make sense.
> Thanks,
> Jean

[Jacob Pan]
