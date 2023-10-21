Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7280D
	for <iommu@lists.linux.dev>; Sat, 21 Oct 2023 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gctITkrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697859220; x=1729395220;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zcdqHYQWFyvsNVnfPxTOb64x44qJuCf6D3wSldjPzF8=;
  b=gctITkrv6fcDNd7ZKsXbL8tIukkHIJsqAPgmHlvTg5QK87VLvRrhKGpv
   xQXaUaV+MCXFMtZSpCkmIdrht6w483OaAye2TcYRCPBj3dzThA0jiQK/j
   fKZ8c6YcogUHwltDdHKr4Vc9+uWG0XmJBTis6tgVvT5p9dNZADCsUz7oe
   ObStl3vm8/36zKLYhJqqFYnT4T7Ah4wk02vDIlyiVKVOEhZ5/R0a53xzI
   o3PApw73Yf9arIm9Td9bpOpiM2RK/foOVcKqn4mrndU8mJeCp6WN+cptT
   DdZy4SqPR1EkgHfYFWSlamerfeRIfoQzle+PLS2XkMtRH7pGcF56wii6D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8165905"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8165905"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="848267523"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="848267523"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2023 20:33:33 -0700
Message-ID: <2b2fce1f-d44b-4988-a214-5d368a85b336@linux.intel.com>
Date: Sat, 21 Oct 2023 11:29:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com
Subject: Re: [PATCH v6 2/3] iommu/vt-d: Make iotlb flush helpers to be extern
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20231020093719.18725-1-yi.l.liu@intel.com>
 <20231020093719.18725-3-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231020093719.18725-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/23 5:37 PM, Yi Liu wrote:
> This makes the helpers visible to nested.c.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 10 +++++-----
>   drivers/iommu/intel/iommu.h |  6 ++++++
>   2 files changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
