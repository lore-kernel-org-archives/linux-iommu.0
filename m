Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5803D7F
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684485773; x=1716021773;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLxW0rA2ic71Nue7yZzXmf+9kuPVAqgNtD93pObAwC0=;
  b=ZLEKfjjQo2wQpbsNZ8HBrqbE070LSf1/55QzYXVFQ9nvesP6D2TJVAFI
   E7QwB2p2O6tTAIyl3gM5NG7HPJ0evloZNcvyge6pevHqbPEs80IsoKQ8k
   ZNk6fGBQsCTzHKJlTmePOJ7IxNQndZvS4KanBywWPlMXKzcG5ai3Z6ZGc
   DElLWuGwrQ/avFwHXsXlozFLohrR4/RoQlgze0HATVKxR+IxpWDjXkH11
   wG28aQbvh5/CSQyb4rAVLe9P6H6dWY32flyaG4S0424Ps9LOWjyT1eyh4
   0UDP+wSfaN5qWIw6zi1STbMo5azVOwSBunctLWhhn+0oRIH/TRiTee/4f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="332682128"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="332682128"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846822237"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="846822237"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.160]) ([10.254.210.160])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:42:48 -0700
Message-ID: <1e6a9967-6cf6-5906-3243-29e028967cdc@linux.intel.com>
Date: Fri, 19 May 2023 16:42:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFCv2 04/24] iommu: Add iommu_domain ops for dirty
 tracking
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230518204650.14541-1-joao.m.martins@oracle.com>
 <20230518204650.14541-5-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230518204650.14541-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/5/19 4:46, Joao Martins wrote:
> Add to iommu domain operations a set of callbacks to perform dirty
> tracking, particulary to start and stop tracking and finally to read and
> clear the dirty data.
> 
> Drivers are generally expected to dynamically change its translation
> structures to toggle the tracking and flush some form of control state
> structure that stands in the IOVA translation path. Though it's not
> mandatory, as drivers will be enable dirty tracking at boot, and just flush
> the IO pagetables when setting dirty tracking.  For each of the newly added
> IOMMU core APIs:
> 
> .supported_flags[IOMMU_DOMAIN_F_ENFORCE_DIRTY]: Introduce a set of flags
> that enforce certain restrictions in the iommu_domain object. For dirty
> tracking this means that when IOMMU_DOMAIN_F_ENFORCE_DIRTY is set via its
> helper iommu_domain_set_flags(...) devices attached via attach_dev will
> fail on devices that do*not*  have dirty tracking supported. IOMMU drivers
> that support dirty tracking should advertise this flag, while enforcing
> that dirty tracking is supported by the device in its .attach_dev iommu op.
> 
> iommu_cap::IOMMU_CAP_DIRTY: new device iommu_capable value when probing for
> capabilities of the device.
> 
> .set_dirty_tracking(): an iommu driver is expected to change its
> translation structures and enable dirty tracking for the devices in the
> iommu_domain. For drivers making dirty tracking always-enabled, it should
> just return 0.
> 
> .read_and_clear_dirty(): an iommu driver is expected to walk the iova range
> passed in and use iommu_dirty_bitmap_record() to record dirty info per
> IOVA. When detecting a given IOVA is dirty it should also clear its dirty
> state from the PTE,*unless*  the flag IOMMU_DIRTY_NO_CLEAR is passed in --
> flushing is steered from the caller of the domain_op via iotlb_gather. The
> iommu core APIs use the same data structure in use for dirty tracking for
> VFIO device dirty (struct iova_bitmap) abstracted by
> iommu_dirty_bitmap_record() helper function.
> 
> Signed-off-by: Joao Martins<joao.m.martins@oracle.com>
> ---
>   drivers/iommu/iommu.c      | 11 +++++++
>   include/linux/io-pgtable.h |  4 +++
>   include/linux/iommu.h      | 67 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 82 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2088caae5074..95acc543e8fb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2013,6 +2013,17 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
> +int iommu_domain_set_flags(struct iommu_domain *domain,
> +			   const struct bus_type *bus, unsigned long val)
> +{
> +	if (!(val & bus->iommu_ops->supported_flags))
> +		return -EINVAL;
> +
> +	domain->flags |= val;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_domain_set_flags);

This seems to be a return to an old question. IOMMU domains are
allocated through buses, but can a domain be attached to devices on
different buses that happen to have different IOMMU ops? In reality, we
may not have such heterogeneous configurations yet, but it is better to
avoid such confusion as much as possible.

How about adding a domain op like .enforce_dirty_page_tracking. The
individual iommu driver which implements this callback will iterate all
devices that the domain has been attached and return success only if all
attached devices support dirty page tracking.

Then, in the domain's attach_dev or set_dev_pasid callbacks, if the
domain has been enforced dirty page tracking while the device to be
attached doesn't support it, -EINVAL will be returned which could be
intercepted by the caller as domain is incompatible.

Best regards,
baolu
