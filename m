Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940481369
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNgkcvpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698196444; x=1729732444;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qpJjJRkBLu59n6lsEp+sa1jxDcxxSkX1crOOHG4/dVI=;
  b=FNgkcvpWN4SLzxklZ6PQX/8g+06WDUDekbFXX0EeoiB5Z4ErLHU5k4xt
   OjgiRsQ9L+inqUNt+nJ3vIz9sYzcDCtgtN4xTXQaKiPkWsNOC6fz6/Knq
   1vxNciscIgFR07pgnAr0ZsOBiDj7UzHH0Tc16m9G+nS0veBYkhagJZlZk
   q5uBAsDHo2jExOddx+oVQtNFCv10+MzAQHRK2V60ltBdnmwTQfrHDB83P
   4Udf8BeT5l0m5I29pw6v+E58v5T9+vMqs9u4zT0BObqoSeFfZ2txvEJPh
   v2OpwSCQbCmtxdkmBhKu8i0R5n/Tc+Cvu7KCrs7mKC9xAqYDIiQS9UV8P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391079011"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="391079011"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="708528752"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="708528752"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2023 18:13:57 -0700
Message-ID: <62f396d4-f890-477f-b9ea-7b330fec35c2@linux.intel.com>
Date: Wed, 25 Oct 2023 09:10:08 +0800
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
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH] iommu/vt-d: Enhance capability check for nested parent
 domain allocation
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20231024150011.44642-1-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231024150011.44642-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 11:00 PM, Yi Liu wrote:
> This adds the scalable mode check before allocating the nested parent domain
> as checking nested capability is not enough. User may turn off scalable mode
> which also means no nested support even if the hardware supports it.
> 
> Fixes: c97d1b20d383 ("iommu/vt-d: Add domain_alloc_user op")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v1: Based on Joao's dirty page tracking v6 https://github.com/jpemartins/linux/commits/iommufd-v6
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   drivers/iommu/intel/iommu.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Hi Jason,

Given that this fixes a commit in the iommufd tree, can you please pick
this fix as well?

Best regards,
baolu
