Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA4101C8
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692186539; x=1723722539;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vP7dzVfwzQJ0W/VkN5o/STGMfQUDig133TyWYBekv58=;
  b=ApahMBCe0eObaayqjn5vk5Ix1Gk6pkjqITZAhLAowgzXNYAWuqmP0qK6
   ZfGo/TrlNtytqpEkbdMKSqaMdyCCXAwC+8eYeTQIzoA/0bLtLtW4lW21D
   JycjolCJVt6iTDbsay5uwY2LPnQYNPtISNSNyGVemWGvlfvmK2vAIveX6
   oOSHcmKb+NdzOiyje+VxF+u8yywiaCDK1KWPIA3qGGz0qwFKZt+5h2KED
   r8CFEA7HsJgSZdPyrFrVSs+5p03sZZPLcleCjVFdmFuJzDSDT14LHsxAv
   ZF967OeEHZy3qHsRpH20nML/ddf9Of2qS0eM1DLLXBeX9+0+nQz0mssIg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371419589"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="371419589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711089189"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711089189"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.88]) ([10.254.209.88])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:48:52 -0700
Message-ID: <faa5a247-c42f-8399-0f70-79d0459773b5@linux.intel.com>
Date: Wed, 16 Aug 2023 19:48:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
 alex.williamson@redhat.com, kevin.tian@intel.com, robin.murphy@arm.com,
 cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com> <ZNuoWRH/HthxsLMd@nvidia.com>
 <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
 <ZNy2/4D9AqjtUAnF@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNy2/4D9AqjtUAnF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/8/16 19:46, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 08:35:00AM +0800, Baolu Lu wrote:
>> On 2023/8/16 0:31, Jason Gunthorpe wrote:
>>> On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
>>>> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>>>>    include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>>>>    2 files changed, 42 insertions(+)
>>> I would like to pick this patch out of this series to go with the main
>>> get_info stuff so that we have drivers implementing what is merged. I
>>> made the trivial fixup.
>>>
>>> Lu are you OK?
>> Yes.
>>
>> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> I changed this to an acked-by since you helpd write the patch 😄

Okay, fine to me.

Best regards,
baolu
