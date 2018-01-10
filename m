From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 08/16] iommu: introduce device fault data
Date: Wed, 10 Jan 2018 11:41:58 +0000
Message-ID: <f9f9dd55-3191-eba0-f4e7-e7c9f16c00f1@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-9-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Yi L <yi.l.liu@linux.intel.com>, "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 17/11/17 18:55, Jacob Pan wrote:
[...]
> +/**
> + * struct iommu_fault_event - Generic per device fault data
> + *
> + * - PCI and non-PCI devices
> + * - Recoverable faults (e.g. page request), information based on PCI ATS
> + * and PASID spec.
> + * - Un-recoverable faults of device interest
> + * - DMA remapping and IRQ remapping faults
> +
> + * @type contains fault type.
> + * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
> + *         faults are not reported
> + * @addr: tells the offending page address
> + * @pasid: contains process address space ID, used in shared virtual memory(SVM)
> + * @rid: requestor ID
> + * @page_req_group_id: page request group index
> + * @last_req: last request in a page request group
> + * @pasid_valid: indicates if the PRQ has a valid PASID
> + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
> + * @device_private: if present, uniquely identify device-specific
> + *                  private data for an individual page request.
> + * @iommu_private: used by the IOMMU driver for storing fault-specific
> + *                 data. Users should not modify this field before
> + *                 sending the fault response.
> + */
> +struct iommu_fault_event {
> +	enum iommu_fault_type type;
> +	enum iommu_fault_reason reason;
> +	u64 addr;
> +	u32 pasid;
> +	u32 page_req_group_id : 9;

As I've been rebasing my work onto your series, I have a few more comments
about this structure. Is there any advantage in limiting the PRGI as a
bitfield? PCI uses 9 bits, but others might need more. For instance ARM
Stall uses 16-bit IDs to identify a fault event.

Could you please make it a u32 (as well as in page_response_msg), and
could page_req_group_id be renamed to simply "id"?

> +	u32 last_req : 1;
> +	u32 pasid_valid : 1;
I noticed that page_response_msg in patch 15/16 calls this bit
"pasid_present". Could you rename it to "pasid_valid" for consistency?

Thanks,
Jean
