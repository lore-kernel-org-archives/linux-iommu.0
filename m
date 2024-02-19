Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFB163
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708305069; cv=none; b=ft6V0SEcxe5oR8W7fljVAOfrxonOUB4GpMYdC/AGFJF4UzJ+mtqkqcsWZJ9Prj2s5ToKUc6187hNblyov4Q1/NxwT1xItxTxHzm7f9yepB0rcdq2KdunEnuUWs1WdaAbd15lIuUkOrL/WpFdoa4xuErxec2h6NoBpGlHgk4Wd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708305069; c=relaxed/simple;
	bh=kRZET2KQOW5YaJGcVoJqNLW4ARdyJnu223yPjHH/TG0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BFXAafMuMozNa6jn9a1rCPmKMVTKtp25daqhD7CPyBlhGtwAbITcOwdiabE4OuzShvOFOaybmVdyvR3O3YZHQEZKN3B77z/vnUGdBajXdNjVxEeaIHNH2pAU1VTRNsuBJpwNoW68TG4qMCwGywFO/Js2+1CdCV58qUZ31VfJi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoqfXIGD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoqfXIGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708305067; x=1739841067;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kRZET2KQOW5YaJGcVoJqNLW4ARdyJnu223yPjHH/TG0=;
  b=IoqfXIGDPsuzH7MY/4NS6C8v1eE1bbyzDhulaB5jBfdInb71y3ZIV4OG
   gjvJiEco6p33Ac/rkp5cqHc4T1UfHs4KKukItRVD4YgBeMxdtbxU/W4Lu
   S/NcsDU+4fny4CCdb1V4NdG0XNipRQwPD7yWdT1MGgcHNq69lC4CPsi1R
   iGwD6hiZbm+VU28/p9gnM1XnGTt2I1wqmLxavSvnnakjTcUPmsu2KhTAl
   XaytjCy4TGnlCDeA1ksjXDlW/ALDy6puqQDcLEfqSzbuDZKEYqWjp1mXe
   Sk1rSWWOlRovnrT997pdEixKwBZtj30P8LSQspJmwAcIrN6JgSniRMRSV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2231053"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2231053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 17:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="35381266"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2024 17:11:05 -0800
Message-ID: <5e186ad1-8869-4a0d-b0b2-ae333dfd1c56@linux.intel.com>
Date: Mon, 19 Feb 2024 09:05:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper function
Content-Language: en-US
To: "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-9-tina.zhang@intel.com>
 <eb13b149-729b-4b22-a6df-63e73ecd73a2@linux.intel.com>
 <MW5PR11MB588131E52514CC9B552DCA7F89512@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB588131E52514CC9B552DCA7F89512@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 8:13 AM, Zhang, Tina wrote:
> Hi Baolu,
> 
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, January 17, 2024 3:33 PM
>> To: Zhang, Tina<tina.zhang@intel.com>;iommu@lists.linux.dev
>> Cc:baolu.lu@linux.intel.com; Tian, Kevin<kevin.tian@intel.com>
>> Subject: Re: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper
>> function
>>
>> On 2024/1/16 9:11, Tina Zhang wrote:
>>> Introduce a helper function to tell if the type of a dmar_domain is
>>> sva or not. In general, comparing with normal iommu_domain, a sva
>>> domain shouldn't be special other than having a different source for
>>> the page table. Thus, this helper function should be used as little as
>>> possible (i.e. only in the cases related to handling page table source).
>>>
>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 0eec5d971315..af466ba301b7 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -244,6 +244,11 @@ static int domain_type_is_si(struct dmar_domain
>> *domain)
>>>    	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
>>>    }
>>>
>>> +static inline bool domain_type_is_sva(struct dmar_domain *domain) {
>>> +	return domain->domain.type == IOMMU_DOMAIN_SVA; }
>> Move the helper into the header file and put appropriate comments around it.
> Is this domain_type_is_sva() helper expected to be reused by others?

I am not sure. But let's put inline helpers in the header instead of C
file.

Best regards,
baolu
