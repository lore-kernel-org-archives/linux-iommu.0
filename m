Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00352F28
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678366755; x=1709902755;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qezJ0m005MMtHINPCZFyjL2NOUVWMeICOxKg98NhuOs=;
  b=Mw+Os4VeOHBMrnyJCztJVAJo6i6hViFQEjewqKUaG7m+p6BRD4dQmQXa
   Lrf1hO4ttgsx8TZr1IOidA/ntqj6dvfn+9QaX5utj/8h5zjBBt+wcKxjU
   7P6gVY3JGLhiBG02gipfG6zu6fCKzusU3X49sCDugoRDd0P6Vc5Cxoc5Q
   EluK+ZXcHIJVtx3xrnJo+mwqTGkTqCek/v9QueVQb11t2FPdjgvttBl8c
   wMxqzKcKt2rgcyxq7StMzsqEknJUJGNgNNe5WGNf1djlkCl7r6fXb7W02
   8LcGDTXt0PvC117Ms4zi9c2aa2PVaVvoFBpangsxnQMxz2WFmWZkRGamb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="401269046"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="401269046"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 04:58:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746313122"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="746313122"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.74]) ([10.254.210.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 04:58:43 -0800
Message-ID: <dbdbaf01-ab5d-b2a8-cafc-849ecd1bf738@linux.intel.com>
Date: Thu, 9 Mar 2023 20:58:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iommu: Move dev_iommu_ops() to private header
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309075358.571567-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/9 15:53, Yi Liu wrote:
> dev_iommu_ops() is essentially only used in iommu subsystem, so
> move to a private header to avoid being abused by other drivers.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
