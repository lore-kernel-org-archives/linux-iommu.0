Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870939F
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4w5ib8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697680151; x=1729216151;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=agPyMKfKXNrTWaZ39rFKgn0cJ6sTEBJIiI0nmmv1Vos=;
  b=h4w5ib8KgvALeEcQtRMVQIj+dt7ZfDcdSEVM38Fv57uWABZWkWyszFQe
   OVua82CN5gH8VQjHbtkn/qBZlQY3Y/v5NJAydKTudeJWWiEI0m5QEubf2
   KTSF1n82yNWCMFeIoHb0s7XMvl19YquwuZDN8VImdetWDSxkum1LDjrl3
   IADx/K/DDyWMuXI2cHSvbC3EM7jA1XaRkHcpW8KE8FLT2WARVz1bEBpmR
   OaA6C21Ry9DvUzNq47/GLHtyHRLVx0/8Mcs9s36+Yr7gpWGBHomzVudh6
   Tf0hr+cKMvvF/trzDE8TdbOLT/7dK9g2uWKijmBdUXYGyJ/k3AOeo+NTO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4746164"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4746164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="706679301"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="706679301"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2023 18:49:05 -0700
Message-ID: <de816c4d-98a4-4af2-8940-c4508d442e61@linux.intel.com>
Date: Thu, 19 Oct 2023 09:45:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 04/18] iommu: Add iommu_domain ops for dirty tracking
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20231018202715.69734-1-joao.m.martins@oracle.com>
 <20231018202715.69734-5-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231018202715.69734-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/23 4:27 AM, Joao Martins wrote:
> Add to iommu domain operations a set of callbacks to perform dirty
> tracking, particulary to start and stop tracking and to read and clear the
> dirty data.
> 
> Drivers are generally expected to dynamically change its translation
> structures to toggle the tracking and flush some form of control state
> structure that stands in the IOVA translation path. Though it's not
> mandatory, as drivers can also enable dirty tracking at boot, and just
> clear the dirty bits before setting dirty tracking. For each of the newly
> added IOMMU core APIs:
> 
> iommu_cap::IOMMU_CAP_DIRTY: new device iommu_capable value when probing for
> capabilities of the device.
> 
> .set_dirty_tracking(): an iommu driver is expected to change its
> translation structures and enable dirty tracking for the devices in the
> iommu_domain. For drivers making dirty tracking always-enabled, it should
> just return 0.
> 
> .read_and_clear_dirty(): an iommu driver is expected to walk the pagetables
> for the iova range passed in and use iommu_dirty_bitmap_record() to record
> dirty info per IOVA. When detecting that a given IOVA is dirty it should
> also clear its dirty state from the PTE, *unless* the flag
> IOMMU_DIRTY_NO_CLEAR is passed in -- flushing is steered from the caller of
> the domain_op via iotlb_gather. The iommu core APIs use the same data
> structure in use for dirty tracking for VFIO device dirty (struct
> iova_bitmap) abstracted by iommu_dirty_bitmap_record() helper function.
> 
> domain::dirty_ops: IOMMU domains will store the dirty ops depending on
> whether the iommu device supports dirty tracking or not. iommu drivers can
> then use this field to figure if the dirty tracking is supported+enforced
> on attach. The enforcement is enable via domain_alloc_user() which is done
> via IOMMUFD hwpt flag introduced later.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/linux/io-pgtable.h |  4 +++
>   include/linux/iommu.h      | 56 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
