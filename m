Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88A20EA
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 04:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663300885; x=1694836885;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=p0Qt0UnWfoVS6JvGUi8jQiIyuqNGHGzZh3tKtN75M9Q=;
  b=agC/h7oGy7iNo931Z7+5iZY17q1xh+uE72r8spafRjS2nQxoMaP6tTg6
   t51mmyiCPqQ8uBFKzR+6ub7qjDqKNTn6pt9odJq2BkASOA8RdhA9e/Ycy
   ZPJuTlFS+VF4Gj0vhzsDf5VeWVHw766f8IXUBO81pmFXDM4B5yYLArEr0
   +aXTas5BsS0fhNDQCILE/E37lDYWKeHs076cp5qaYoX+A9Ebs7Dz++Sx+
   x0qM0yLJ2+swqj4doq3B6SSaBjjb1wMWE2TRKCiZk/lOsIZ0iOunDVlDr
   ZDygWuRnjRDfaP/rTZMzaquwRzgJOfxORwkuSj0dy1mqgUkE/xCCUyJn+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325173947"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325173947"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 21:01:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="792969741"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.216]) ([10.254.214.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 21:01:22 -0700
Message-ID: <cbb2504c-cb6a-1334-2207-63a410cf6484@linux.intel.com>
Date: Fri, 16 Sep 2022 12:01:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
 <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
 <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
 <fc1f5412-6041-71b8-2a87-84f2f32456fc@linux.intel.com>
 <a6ac5953-7372-9894-58d4-d1ee2905d4dd@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <a6ac5953-7372-9894-58d4-d1ee2905d4dd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/9/16 11:35, Ethan Zhao wrote:
> Baolu,
> 
> 在 2022/9/16 11:05, Baolu Lu 写道:
>> On 2022/9/16 10:40, Ethan Zhao wrote:
>>>>
>>>> I may not get you exactly. 😄 Some IOMMU features reply on PASID
>>>> capabilities on both IOMMU and device. The IOMMU drivers enumerate the
>>>> capabilities and enable them if they are supported.
>>> I might not express it straightforward,  I mean with this patch iommu 
>>> deals with
>>>
>>> the complexity of enabling PASID (globally?)  or not at probing stage 
>>> , instead
>>>
>>> of other device driver side decision to request IOMMU PASID enabling 
>>> during
>>>
>>> their setup state.  if so you move the decision to iommu probe stage. 
>>> hmmm...
>>
>> I am sorry that the commit message was a bit confusing. Actually we
>> always enable PASID at iommu probe path w/ or w/o this patch.
> Really ?  the commit message is quit clear to me ~~@
>>
>>>
>>> Pros,  iommu driver controls everything about PASID enabling.
>>>
>>> Cons,  iommu driver handles all possible complexity about capability 
>>> matching
>>
>> Do device drivers need to configure PCI PASID without IOMMU? I searched
>> the tree and found nothing.
> 
> Device knows if it has PCI PASID cap and its driver also could determine 
> to request
> 
> iommu to enable PASID or not by invoking
> 
> intel_iommu_enable_sva()->*intel_iommu_enable_pasid()*

PASID is a PCIe capability. Though SVA is built on it,it's not only
for SVA. Thus, the purpose of intel_iommu_enable_sva() is not for
enabling PASID.

> 
> *that is the old style without this patch.

No. Without this patch, PASID is also enabled in probe path. Calling
intel_iommu_enable_pasid() in enabling SVA path is actually duplicate.

The commit message for this patch is not correct. It's my bad. :-)

> *
> 
> *Iommu driver of course  also knows if devices in its group related the 
> iommu
> *
> 
> *have PASID cap support or not by enumerating them from the ACPI DMAR.
> *
> 
> This is my understanding, correct me if wrong.
> 
> While configuring device PCI PASID cap is another thing, from kernel or 
> userland,
> 
> compatible with the iommu cap, works, or not work.  Could you prevent anyone
> 
> from doing that ?

I do not object to adding a common interface to enable/disable PASID if
any device driver needs to manage PASID by itself. Before that, there
is no need to add complexity in IOMMU subsystem for a non-existent
requirement.

Best regards,
baolu
