Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01761185D
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 03:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695958618; x=1727494618;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xjoLJw3bXTsWO1tn8Vf7R8FlDJcSY5uHYNKpTGwJjiI=;
  b=kB78wu3fMuYm39XMqsBQwpLLjZHlaGCP/dXXrY3NBogiFUkU4DHrPFnM
   qqqumnpmtWx/qOJkGGbByPgKBZweE23JVF3tJmzdU46rz8v1DSl+U4lR2
   pxlnd5gfYggtrp5r4+QUeQgCJ/aadPYgM0nxFgSZVdEeHds4hQo/l05ob
   DRYGdy2afb1gN5iwyK4U0pPrOy3JZ6+LWKcl/n3JshK8GZX73YaBxroWK
   Us9za78yjjCTGgN/Bh2rJe+O58Ge70iSpXHdKz2INwPf1BGmMX9iNTZ4Q
   /IhanJCeWyZKLNegK0iwNwggsvDpoz6vz/I/ng43Ckh3H4uqmXhvCnNEO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361602553"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="361602553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 20:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="893279800"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="893279800"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 20:35:39 -0700
Message-ID: <8faa388d-fe64-aa73-fe12-a402d24888a7@linux.intel.com>
Date: Fri, 29 Sep 2023 11:33:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 3/6] iommufd/hw_pagetable: Accepts user flags for
 domain allocation
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-4-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230928071528.26258-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/23 3:15 PM, Yi Liu wrote:
> This extends iommufd_hw_pagetable_alloc() to accepts user flags.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 2 +-
>   drivers/iommu/iommufd/hw_pagetable.c    | 9 ++++++---
>   drivers/iommu/iommufd/iommufd_private.h | 3 ++-
>   3 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
