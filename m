From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 01/16] iommu: introduce bind_pasid_table API function
Date: Fri, 24 Nov 2017 12:04:08 +0000
Message-ID: <18102756-9b41-c03f-0a9a-5028d7c1b2cd@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Yi L <yi.l.liu@linux.intel.com>, "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

On 17/11/17 18:54, Jacob Pan wrote:
> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> use in the guest:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> 
> As part of the proposed architecture, when an SVM capable PCI
> device is assigned to a guest, nested mode is turned on. Guest owns the
> first level page tables (request with PASID) which performs GVA->GPA
> translation. Second level page tables are owned by the host for GPA->HPA
> translation for both request with and without PASID.
> 
> A new IOMMU driver interface is therefore needed to perform tasks as
> follows:
> * Enable nested translation and appropriate translation type
> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> 
> This patch introduces new API functions to perform bind/unbind guest PASID
> tables. Based on common data, model specific IOMMU drivers can be extended
> to perform the specific steps for binding pasid table of assigned devices.
> 
[...]
>  
>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -187,6 +188,8 @@ struct iommu_resv_region {
>   * @domain_get_windows: Return the number of windows for a domain
>   * @of_xlate: add OF master IDs to iommu grouping
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> + * @bind_pasid_table: bind pasid table pointer for guest SVM
> + * @unbind_pasid_table: unbind pasid table pointer and restore defaults

I was wondering, are you planning on using the IOMMU_DOMAIN_NESTING
attribute? It differentiates a domain that supports
bind/unbind_pasid_table and map/unmap GPA (virt SVM), from the domain that
supports bind/unbind individual PASIDs and map/unmap IOVA (host SVM)?

Users can set this attribute by using the VFIO_TYPE1_NESTING_IOMMU type
instead of VFIO_TYPE1v2_IOMMU, which seems ideal for what we're trying to do.

[...]
> +/**
> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> + * enable guest managed first level page tables.
> + * @version: for future extensions and identification of the data format
> + * @bytes: size of this structure
> + * @base_ptr:	PASID table pointer
> + * @pasid_bits:	number of bits supported in the guest PASID table, must be less
> + *		or equal than the host supported PASID size.

Why remove the @model parameter?

> + */
> +struct pasid_table_config {
> +	__u32 version;
> +#define PASID_TABLE_CFG_VERSION 1
> +	__u32 bytes;
> +	__u64 base_ptr;
> +	__u8 pasid_bits;
> +	/* reserved for extension of vendor specific config */
> +	union {
> +		struct {
> +			/* ARM specific fields */
> +			bool pasid0_dma_no_pasid;
> +		} arm;

I think @model is still required for sanity check, but could you remove
the whole union for the moment? Other parameters will be needed and I'm
still thinking about it, so I'll add the arm struct back in a future patch.

Thanks,
Jean
