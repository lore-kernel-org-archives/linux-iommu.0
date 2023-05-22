Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00CEA2
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684723237; x=1716259237;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xmzhWPnmJhTOy/cF278AiDEnzQcCzw7OgqRfXxJnCtk=;
  b=Iq/QE2eQJw5WLvpEzyYAelesAjLaPBK+p+qAqdLII+sSz31GrGTnLtZG
   0tpcA0vZ++AyeGkbxMTjmHXfairysBd0x8Bpr2iP7ejV2SgF3JHPSU8dq
   Gm5d8ySh6MkxIKTUgblJVZkQ1mzu6KlA+yXdOxFpI90eJmZ2+tfHDTSFc
   SXpiVwyCVIJPfYW9J5U9lQl3or/0MpgEN1QAV+hE9z8N9N2wtm1pZdtSI
   IvogRhuMNd0wbTMU73FFtOlF+ZXJWf0CPgCgpPx8uQxtLvmIw6BQyBlLA
   OxuMdXYJVm+5g8Uigvi54FPA/MieE5vjVcHTxI1Bz+eji2+jnH66oICfi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="332416862"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="332416862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773051627"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773051627"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 21 May 2023 19:40:33 -0700
Message-ID: <dc5d6fb3-ed20-73f8-9ece-a4ff0d15998e@linux.intel.com>
Date: Mon, 22 May 2023 10:39:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 10/10] iommu: Avoid locking/unlocking for
 iommu_probe_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Remove the race where a hotplug of a device into an existing group will
> have the device installed in the group->devices, but not yet attached to
> the group's current domain.
> 
> Move the group attachment logic from iommu_probe_device() and put it under
> the same mutex that updates the group->devices list so everything is
> atomic under the lock.
> 
> We retain the two step setup of the default domain for the
> bus_iommu_probe() case solely so that we have a more complete view of the
> group when creating the default domain for boot time devices. This is not
> generally necessary with the current code structure but seems to be
> supporting some odd corner cases like alias RID's and IOMMU_RESV_DIRECT or
> driver bugs returning different default_domain types for the same group.
> 
> During bus_iommu_probe() the group will have a device list but both
> group->default_domain and group->domain will be NULL.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
