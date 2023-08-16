Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77138D
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692146109; x=1723682109;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8f2iATa2xEdHMvk63Q2DKkqtOyMKfE9XSsgVimDXLjw=;
  b=IcdLGvWfdpTEpq4y+pHYrIBgHxFzX5lfMHcF/HQeBMZ1FHTSq3QMWcJY
   wICWvd7fS6WHs/KzUQuscYBBy/I0tAv+hKkeIyKuOv5TeUAyRBw3hfc0H
   e3+dCgDtvZxZaRnbKO7bDa0evo/E7bgO1MNgHoAdRpEjpqsO0ghSoNxEq
   Ane0B/uKunCX5egnzFAoVE+qQ6vbx5pRROjkPbjw51Y9WwaupqbYrXXmK
   37ubyKGl8QyhRypOF9sl8btXaHwAV6OZrZFoC2PUzR9Tyj9lf6plC7ilX
   pjmgcklKGLawHgjLHPUet5xGxX3m56c3Ptip90tx0ZInqR1ZN0UZkXZhE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438753900"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="438753900"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824042590"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="824042590"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.45]) ([10.254.212.45])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:35:02 -0700
Message-ID: <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
Date: Wed, 16 Aug 2023 08:35:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, robin.murphy@arm.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com> <ZNuoWRH/HthxsLMd@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNuoWRH/HthxsLMd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/16 0:31, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
>> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>>   include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
> I would like to pick this patch out of this series to go with the main
> get_info stuff so that we have drivers implementing what is merged. I
> made the trivial fixup.
> 
> Lu are you OK?

Yes.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
