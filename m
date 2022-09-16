Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F4160
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663296014; x=1694832014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dkNSAIpV+3ISrQK8NuEG29Wy4QbSSd3qb7jfOmQtu7w=;
  b=CVavKezwuzFlyKrptXiN0dSlrTn3NKMGfoyI0QfedoT5ZgivMM7plWsk
   6o9/LX5SrWW1gmlEpZhm7xWVWE1470dWpTpGCOSiVOWKsPax7gqZ6s90V
   2g7YTKI+mQNXkH+/z3yAGnYHH1NtZ6KvVF2XBxlsJ+vTWhhyrvK2eISqx
   /+UNviCq2FXtk6FugKsQZYG9VfCJXsItEAfr3XbkZMU1HmMfFQVjOqgra
   OnXGtFxQnpBxig2WRMfM7QKyPAQEVl4Z9vvkvyk8o5ThIZax6tzJTlKbm
   n/UmTosVnprdMUH9dq4mQ92H2PKIrsIpU+jgJkt77DPRv/32NqOL7op8K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362859616"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="362859616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 19:40:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="568678899"
Received: from yingjieh-mobl.ccr.corp.intel.com (HELO [10.254.215.99]) ([10.254.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 19:40:12 -0700
Message-ID: <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
Date: Fri, 16 Sep 2022 10:40:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-kernel@vger.kernel.org
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
 <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/15 11:00, Baolu Lu 写道:
>
>
> On 9/14/22 4:59 PM, Ethan Zhao wrote:
>>>> What the error path would be if this code runs on some old 
>>>> platforms don't
>>>>
>>>> support PASID, would you print out "this platform doesn't suppor 
>>>> PASID" and
>>>>
>>>> give users an interface function to query if the PASID cap of iommu 
>>>> is enabled
>>>>
>>>> and if not why ?
>>>
>>> It's not an error case if the IOMMU doesn't support PASID. But it's an
>>> error case if any device drivers call PASID related IOMMU interfaces
>>> (for example, iommu_domain_attach/detach_dev_pasid()). The 
>>> corresponding
>>> error code will be returned to the drivers.
>>>
>> So iommu driver withdraws the flexibility/rights from device driver 
>> about the
>>
>> ability to enable PASID, looks much more *integrated* iommu works as 
>> relation
>
> No. This patch doesn't withdraw anything. It's just a code refactoring.
>
>>
>> controller in device-iommu-domain by enabling PASID in iommu probe stage
>>
>> by default -- iommu decides to enable PASID or not though device-iommu-
>>
>> domain might not work ? or they should work because they are hard-wired
>>
>> together (device - iommu) even device is hotpluged later.
>>
>
> I may not get you exactly. :-) Some IOMMU features reply on PASID
> capabilities on both IOMMU and device. The IOMMU drivers enumerate the
> capabilities and enable them if they are supported.
I might not express it straightforward,  I mean with this patch iommu 
deals with

the complexity of enabling PASID (globally?)  or not at probing stage , 
instead

of other device driver side decision to request IOMMU PASID enabling during

their setup state.  if so you move the decision to iommu probe stage. 
hmmm...

Pros,  iommu driver controls everything about PASID enabling.

Cons,  iommu driver handles all possible complexity about capability 
matching

etc.


Thanks,

Ethan

>
> Best regards,
> baolu

-- 
"firm, enduring, strong, and long-lived"

