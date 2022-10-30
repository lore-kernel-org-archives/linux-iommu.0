Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66493190
	for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667119323; x=1698655323;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0pZ5BXM1KKlllTzvGlawsj7qioUyJBmxNGtcs+Xr9vc=;
  b=OZQr8NExV9jUHlrTLML3+g0kMhz4kWwaiHrF9/PnCD/hIucpcSAcYPYg
   zAKPYlNN8/Upx72ATa64sRWCZvPpFIFYngiIdFSxaLFEN/2yV2SkkAUwy
   z1SX0uzgRE2eNht1h6HmsLtHFf1c2IfyMPAayU0yisDUeeQaBIWvfTbkT
   yKBDQiQDXdEpS4+ifIYXj5OjO7T+Nuk7RE5/7msMusg/6DWP7HS32bNdS
   1en+OLEtgyI0WpjlfiNyrjwX2FpCHzH8RNA4bHTnMBieFnmZ/q2BYpCAI
   fv6LhPdxb73Qi8wvHzA9FflSkVRs5fuGKutNJKp+DHWTkZouZydOQla6F
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="296136358"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="296136358"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 01:42:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="627945761"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="627945761"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.60]) ([10.254.210.60])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 01:42:01 -0700
Message-ID: <fd26ae05-4c92-8756-e9b9-fa8041b07641@linux.intel.com>
Date: Sun, 30 Oct 2022 16:41:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Subject: Re: lockdep splat with intel iommu
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <Y1qOqBXgll9qa7Hm@nvidia.com>
 <cd727ea9-32f8-cc6a-a070-74e039b725f5@linux.intel.com>
 <Y11PleKAgldyfKCi@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y11PleKAgldyfKCi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/30 0:06, Jason Gunthorpe wrote:
> On Sat, Oct 29, 2022 at 04:22:32PM +0800, Baolu Lu wrote:
>> On 2022/10/27 21:59, Jason Gunthorpe wrote:
>>> I'm seeing this at every boot, on v6.1-rc2
>>>
>>> I've just realized it means lockdep is turned off for the actual
>>> testing I want to do. Very annoying
>>>
>>> Lu, is there a solution yet? I saw some patches for a different
>>> lockdep splat but not this one.
>>
>> Hi Jason,
>>
>> Possibly the same issue as this one?
>>
>> https://lore.kernel.org/linux-iommu/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/
> 
> No, this has nothing to do with coretemp and this one involves irq_domain_mutex

Can you please share a copy of the .config with me? I am trying to
reproduce this with a local machine.

Best regards,
baolu
