From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 01/16] iommu: introduce bind_pasid_table API function
Date: Tue, 10 Oct 2017 15:14:33 +0200
Message-ID: <20171010131433.fgo5tnwidzywfnx4@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507244624-39189-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Liu@8bytes.org, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On Thu, Oct 05, 2017 at 04:03:29PM -0700, Jacob Pan wrote:
> +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	if (unlikely(!domain->ops->unbind_pasid_table))
> +		return -EINVAL;
> +
> +	return domain->ops->unbind_pasid_table(domain, dev);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);

Are there other reasons to let the unbind fail? Otherwise I'd suggest to
just make this a void function. Also not sure what the user of this
function should do when the unbind really fails.

> +enum pasid_table_model {
> +	PASID_TABLE_FORMAT_HOST,

What is this FORMAT_HOST for?

> +	PASID_TABLE_FORMAT_ARM_1LVL,
> +	PASID_TABLE_FORMAT_ARM_2LVL,
> +	PASID_TABLE_FORMAT_AMD,
> +	PASID_TABLE_FORMAT_INTEL,
> +};
> +
> +/**
> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> + * enable guest managed first level page tables.
> + * @version: for future extensions and identification of the data format
> + * @bytes: size of this structure
> + * @base_ptr:	PASID table pointer
> + * @pasid_bits:	number of bits supported in the guest PASID table, must be less
> + *		or equal than the host table size.
> + * @model:	PASID table format for different IOMMU models
> + */
> +struct pasid_table_config {
> +	__u32 version;

Can you also add a define for the version number? Userspace needs it to
initialize the struct and the kernel to check against it.

> +	__u32 bytes;
> +	__u64 base_ptr;
> +	__u8 pasid_bits;
> +	enum pasid_table_model model;
> +	union {
> +		struct {
> +			/* Intel specific fields */
> +		} intel;
> +
> +		struct {
> +			/* ARM specific fields */
> +			bool pasid0_dma_no_pasid;
> +		} arm;
> +
> +		struct {
> +			/* AMD specific fields */
> +		} amd;

Thinking more about this, we can omit the sub-structs for models that
don't need them. For the amd-model for example the base_ptr and
pasid_bits fields are sufficient.


Regards,

	Joerg
