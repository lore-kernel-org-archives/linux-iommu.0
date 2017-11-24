From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 08/16] iommu: introduce device fault data
Date: Fri, 24 Nov 2017 12:03:33 +0000
Message-ID: <65b76897-55b8-6f0c-e103-4337254041ca@arm.com>
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
Cc: Lan Tianyu <tianyu.lan@intel.com>, Yi L <yi.l.liu@linux.intel.com>, "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 17/11/17 18:55, Jacob Pan wrote:
> Device faults detected by IOMMU can be reported outside IOMMU
> subsystem for further processing. This patch intends to provide
> a generic device fault data such that device drivers can be
> communicated with IOMMU faults without model specific knowledge.
> 
> The proposed format is the result of discussion at:
> https://lkml.org/lkml/2017/11/10/291
> Part of the code is based on Jean-Philippe Brucker's patchset
> (https://patchwork.kernel.org/patch/9989315/).
> 
> The assumption is that model specific IOMMU driver can filter and
> handle most of the internal faults if the cause is within IOMMU driver
> control. Therefore, the fault reasons can be reported are grouped
> and generalized based common specifications such as PCI ATS.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>

This looks good from my point of view. And since it's not UAPI, we can
always update it if it turns out that device drivers need more information.

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

This comment can be removed

Thanks,
Jean

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
> +	u32 last_req : 1;
> +	u32 pasid_valid : 1;
> +	u32 prot;
> +	u64 device_private;
> +	u64 iommu_private;
> +};
