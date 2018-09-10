From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Mon, 10 Sep 2018 17:22:49 +0100
Message-ID: <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 30/08/2018 05:09, Lu Baolu wrote:
> Below APIs are introduced in the IOMMU glue for device drivers to use
> the finer granularity translation.
> 
> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
>   - Represents the ability for supporting multiple domains per device
>     (a.k.a. finer granularity translations) of the IOMMU hardware.

iommu_capable() cannot represent hardware capabilities, we need
something else for systems with multiple IOMMUs that have different
caps. How about iommu_domain_get_attr on the device's domain instead?

> * iommu_en(dis)able_aux_domain(struct device *dev)
>   - Enable/disable the multiple domains capability for a device
>     referenced by @dev.
> 
> * iommu_auxiliary_id(struct iommu_domain *domain)
>   - Return the index value used for finer-granularity DMA translation.
>     The specific device driver needs to feed the hardware with this
>     value, so that hardware device could issue the DMA transaction with
>     this value tagged.

This could also reuse iommu_domain_get_attr.


More generally I'm having trouble understanding how auxiliary domains
will be used. So VFIO allocates PASIDs like this:

* iommu_enable_aux_domain(parent_dev)
* iommu_domain_alloc() -> dom1
* iommu_domain_alloc() -> dom2
* iommu_attach_device(dom1, parent_dev)
  -> dom1 gets PASID #1
* iommu_attach_device(dom2, parent_dev)
  -> dom2 gets PASID #2

Then I'm not sure about the next steps, when userspace does
VFIO_IOMMU_MAP_DMA or VFIO_IOMMU_BIND on an mdev's container. Is the
following use accurate?

For the single translation level:
* iommu_map(dom1, ...) updates first-level/second-level pgtables for
PASID #1
* iommu_map(dom2, ...) updates first-level/second-level pgtables for
PASID #2

Nested translation:
* iommu_map(dom1, ...) updates second-level pgtables for PASID #1
* iommu_bind_table(dom1, ...) binds first-level pgtables, provided by
the guest, for PASID #1
* iommu_map(dom2, ...) updates second-level pgtables for PASID #2
* iommu_bind_table(dom2, ...) binds first-level pgtables for PASID #2


I'm trying to understand how to implement this with SMMU and other
IOMMUs. It's not a clean fit since we have a single domain to hold the
second-level pgtables. Then again, the nested case probably doesn't
matter for us - we might as well assign the parent directly, since all
mdevs have the same second-level and can only be assigned to the same VM.


Also, can non-VFIO device drivers use auxiliary domains to do map/unmap
on PASIDs? They are asking to do that and I'm proposing the private
PASID thing, but since aux domains provide a similar feature we should
probably converge somehow.

Thanks,
Jean
