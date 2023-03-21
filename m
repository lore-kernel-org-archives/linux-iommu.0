Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C110E5
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 01:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679363981; x=1710899981;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KTbPBv8cSI/I5BaaVSZcD11akgCvhZFv+LILOFk3dKo=;
  b=S6k1RXua5ai9cYOyEoig9RJrlPq9po1ZzXJciQCgButV8DxFv8QdMMok
   sCQkgyiYMpwtK3PFLl+iT+GckBe0ZI+GsS+HRG57R8sxhKtGPG9X07ycl
   xmRAbgWTZZ3ska9a4kVFhpYch64i56QUUA+w7TzlcMmJcNpesNPVLUPjD
   WAVP5aerSMOQ5qUJlnVr3+Tem4iewhLlp8V70HqiVL53gXuvow3r7Lry7
   v1fgMMK707qkj4ByIrV5HtRoO2DQoB0uOeakXlIs9PpoDLakHApWhsbcL
   GEV8LGbWwNiUTaeHaAwd/3XJbToVN9y0wVm+zt9OV3xqmYc6tc46ibezA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319222912"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="319222912"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674646881"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="674646881"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 18:59:35 -0700
Message-ID: <0a91496c-d70a-6a52-ab9d-7e3615250d99@linux.intel.com>
Date: Tue, 21 Mar 2023 09:58:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, robin.murphy@arm.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iommu/vt-d: Extend dmar_domain to support nested
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-4-yi.l.liu@intel.com> <ZBhliHzXcbUxuyX1@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZBhliHzXcbUxuyX1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/23 9:54 PM, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 12:22:05AM -0800, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> The nested domain fields are exclusive to those that used for a DMA
>> remapping domain. Use union to avoid memory waste.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
>>   1 file changed, 29 insertions(+), 6 deletions(-)
> 
> Using unions like this often devolves into a mess.
> 
> You'd be better to have more structures
> 
> struct intel_iommu_domain {
>     struct iommu_domain domain;
>     [general fields about attachment]
> };
> 
> struct intel_iopte_domain {
>      struct intel_iommu_domain domain;
>      [stuff describing the io page table data, pgd, format, etc]
> };
> 
> strut intel_s1_domain {
>       struct intel_iommu_domain domain;
>       struct dmar_domain *s2_domain;
>       /* user page table pointer (in GPA) */
>       unsigned long s1_pgtbl;
>       /* page table attributes */
>       struct iommu_hwpt_intel_vtd s1_cfg;
> };
> static_assert(offset_of(struct intel_s1_domain, domain.domain) ==
>                offset_of(struct intel_iommu_domain, domain));
> 
> The per-domain ops allow to make this work sensibly

Yes. This will make the data structures clearer.

However, this will lead to significant code changes. I think it would be
more appropriate to put it in a separate refactoring series later.

Best regards,
baolu
