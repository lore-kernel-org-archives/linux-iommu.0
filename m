Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B41F1805A
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707466; cv=none; b=UaPZlSXDoiSQqAXjxIxX6yuDKhpPKCLsHB4LTcm3tKVWXhHRx3g8lk+OO3uz0gNaOk4SwawMUfXEtBgPf/Qgk08hZjy+1jcBHxZPJZbjGU65pf5seL4qzdRWQ+/w8c7d7tAIAsGGzxkhEADVo0PIFqOtgrpqOT9wofox+GVFOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707466; c=relaxed/simple;
	bh=NVK6aeHxFVjKF4Va1geyDXQeurNOTtiKU+4h8KaNvbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOtFOafJOyOewvXIiG1fderxKesKjHpYZ1RqAJmuOJgzIDm/d3rSsu6WSGmyNB+BKl3GWohlDaH5k/MZH2MyMujX+pp24XZebdE9YBqLv8O2L75JbVWKFpz8RlZ+zCmZ3MfNTEu0ZKVqtzRXSJ1+WWJeASUs/UMCOYfYv2UX+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mm135TVO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mm135TVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740707464; x=1772243464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NVK6aeHxFVjKF4Va1geyDXQeurNOTtiKU+4h8KaNvbI=;
  b=Mm135TVOfCG4Qyyb9SJc5ZzgCaV30M+u9e5mN+trVaqZGdsQJdqafWDR
   4zXULwcpGQIbA2nvrQAFfHj7petQ2N/0cT7bLOAR2cYRWjJUNCd3pBz71
   cDy2wylzsqR+NTSHFtqB1xocKmb/DoN/uXpSh+ue1hCyKHNvPu1AbngKL
   avvz0UDDscM3oph1pFlV/hQTxXi86wg7BVO3PfNr1f20SRLVnhpnrRCyq
   iqSGi007tXGhZaHYXGQYpMH2Afaeqfu7ILtURDdCtD18Pv7jU98tDJnpo
   UBkS3HCxXZlalhKS2JwH3yiJhHNJFpp3159uvfXN266kKNF2jmg0Y9fIt
   w==;
X-CSE-ConnectionGUID: tHTEFaELTWKs1sSK/YRQ0g==
X-CSE-MsgGUID: tmOXj8eIS8mjfGX+M3FiIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40801157"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40801157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 17:51:03 -0800
X-CSE-ConnectionGUID: NToOz/kVS1mHCy7WEkLP2Q==
X-CSE-MsgGUID: dygBxTZKT5ivv0w7HueOuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117230434"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 17:51:01 -0800
Message-ID: <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
Date: Fri, 28 Feb 2025 09:47:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 00:04, Vasant Hegde wrote:
> On 2/26/2025 12:40 PM, Tian, Kevin wrote:
>>> From: Vasant Hegde<vasant.hegde@amd.com>
>>> Sent: Wednesday, February 26, 2025 12:47 PM
>>>
>>>>   3) TA is an IOVA and the IOMMU runs it through the full translation
>>>>      to validate it. ATS is just used to signal non-present
>>> Yes. AMD does this when Host page table is configured.
>> Here 'signal non-present' implies to support PRI.
>>
>> But...
>>
>>> We need to consider various scenarios. For AMD:
>>>    - Currently on baremetal, we cannot enable SVA and Secure ATS
>> ... here it says SVA/SATS are incompatible. Any more background?
> Sorry. I should have explained it better.
> 
> To support SVA (PASID/PRI), we have to configure domain with AMD Guest (v2) Page
> table and host page table will not be set (DTE[Mode]=0).
> 
>    GVA -> GPA contains translation and GPA = SPA.
> 
> On ATS request it will send GPA back to device (which is actually a SPA). We can
> support secure ATS, but ATS response will contain the SPA.

So, the hardware is configured to work in secure ATS mode, but the ATS
is not actually secure here, right? AMD's secure ATS relies on checking
GPA to SPA translation; however, GPA is always equal to SPA in the SVA
case.

Am I understanding this correctly?

Thanks,
baolu
