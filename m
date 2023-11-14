Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996ABA53
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns1bn67g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699937940; x=1731473940;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vzuLGZppEUfGNm/Q6z7GNvK1qKKvMHzq4ZmTZdmNAeU=;
  b=Ns1bn67gYC3sXEHqhWxWXPNDEBJMdqip22u1/yPYzjrObyt350RrvtSa
   NxNGYJfKvY9JweV4xp1b27qierPgHQGLFwC6+1KMlFyQOxdkJGnwi/vE7
   Zwdlf+EWzBd5qD1xRwcUAaPD9AmG3LF7SWOQx5jk/dPaP4qw6NOj7eLVy
   DJrT0Xhv135c/y/mdWgGfoc3emLXCuIe6JIC96DauB9uCL7+FeXgi7XMo
   wZjgssHFIgsNKSeIWdW/x/bfWEDhaKePR9bDNeiExgrbZt69eEtWkn476
   cwZ3q8IK5+qX0MlRgrSm0CerjEEjjgNglVn3xiZVQItdbe1hD4oyg94QK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390376980"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="390376980"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937938476"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="937938476"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 13 Nov 2023 20:58:57 -0800
Message-ID: <79b2f656-6342-4f46-a4cf-fe8152f1c67f@linux.intel.com>
Date: Tue, 14 Nov 2023 12:54:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
 <BN9PR11MB52761EDB3AE90DE87661A3C28CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761EDB3AE90DE87661A3C28CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/23 12:45 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, November 14, 2023 11:14 AM
>>
>> On 11/14/23 11:14 AM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, November 14, 2023 9:11 AM
>>>>
>>>> The latest VT-d spec indicates that when remapping hardware is disabled
>>>> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
>>>> requests are treated as UR (Unsupported Request).
>>>>
>>>> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
>>>> Invalidations that software refrain from submitting any Device-TLB
>>>> invalidation requests when address remapping hardware is disabled.
>>>>
>>>> Verify address remapping hardware is enabled prior to submitting Device-
>>>> TLB invalidation requests.
>>>>
>>>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>>>> default")
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>>> index a3414afe11b0..23cb80d62a9a 100644
>>>> --- a/drivers/iommu/intel/dmar.c
>>>> +++ b/drivers/iommu/intel/dmar.c
>>>> @@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu
>>>> *iommu, u16 sid, u16 pfsid,
>>>>    {
>>>>    	struct qi_desc desc;
>>>>
>>>> +	/*
>>>> +	 * VT-d spec, section 4.3:
>>>> +	 *
>>>> +	 * Software is recommended to not submit any Device-TLB
>>>> invalidation
>>>> +	 * requests while address remapping hardware is disabled.
>>>> +	 */
>>>> +	if (!(iommu->gcmd & DMA_GCMD_TE))
>>>> +		return;
>>>> +
>>> Is it a valid case to see such request when the iommu is disabled?
>>> If not then let's add a WARN.
>>
>> There might be valid cases. The VT-d translation is turned on after all
>> devices get probed.
>>
> 
> but I didn't get why there will be actual mapping changes before
> vtd translation is enabled...

For an example, in iommu_create_device_direct_mappings(),
iommu_flush_iotlb_all() is called after direct mappings are created.

Best regards,
baolu
