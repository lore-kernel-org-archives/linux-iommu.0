Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C17F
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663226929; x=1694762929;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=JA0heTaTiaFR1FWR3ZdZwUHttE4/2Sc0xVmI4KDh6Gs=;
  b=l/MSPiL0O1g5Zgv3UMRc51GFoXK7tzO4PXrADmhWLQdVWNGdCbph9KTl
   DPqmfkti+9cMhxXLg4i1N75uQwArC0fZn1ERZ3Gw9vfcx63sBhiKwxgQn
   76SmDyt2InrXWK9+owOu1MSaEJPvuAiSBEMM8nJ4hG324bBxCDBMWltba
   5SngUC2kCuPIPjJcnVoVaHjIXHapUKJiHdcTlGetc96NnTOdAHtl2osWt
   n7B1Vvdfmm82MxNbMhseJaQhq+JVZvMXBJn5dD8U+joYrzce+2ZTrcrTl
   oq1wptmPnR/WoriQGIVOgcNcIjeabH7/bpB3SegS/SVAynejVwcoCrXZA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299451007"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="299451007"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:28:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="742834554"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.238]) ([10.254.208.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:28:41 -0700
Message-ID: <0283328d-7854-2328-e526-29f00f5a2737@linux.intel.com>
Date: Thu, 15 Sep 2022 15:28:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20220914144424.7356-1-vasant.hegde@amd.com>
 <1a5195b4-eef2-00dd-1b16-806d662148ea@linux.intel.com>
 <9c10ed06-9326-4fb5-7af1-973d6094465a@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH] iommu: Handle domain allocation failure gracefully
In-Reply-To: <9c10ed06-9326-4fb5-7af1-973d6094465a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/9/15 14:13, Vasant Hegde wrote:
> On 9/15/2022 8:44 AM, Baolu Lu wrote:
>> On 9/14/22 10:44 PM, Vasant Hegde wrote:
>>> Current code does not validate domain allocation failures. This will
>>> result in random failure at later stage. Hence handle domain allocation
>>> failures.
>>>
>>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>>> ---
>>> Hi Joerg,
>>>     With current code whenever amd driver failes to allocate domain we hit
>>>     failure at late stage and it became difficult to debug. Hence I
>>>     thought of adding this fix.
>>>
>>>     I see that in commit 6e1aa2049154 you have intentionally didn't check
>>>     the return value. Looking into drivers/iommu/* it looks like all
>>>     drivers has domain_alloc() callback handler. But some drivers (like msm
>>>     - msm_iommu_domain_alloc()) allocates default domain for certain type
>>>     only. Hence I'm not sure whether its ok to handle domain allocation
>>>     failures or not. Hence I have marked this patch as RFC.
>>>
>>>     Let me know whether this patch is fine -OR- is there any other way we can
>>>     handle domain allocation failures?
>>>
>>> -Vasant
>>>
>>>    drivers/iommu/iommu.c | 24 +++++++++++++-----------
>>>    1 file changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 780fb7071577..e8a1e7fbffb9 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -289,18 +289,21 @@ int iommu_probe_device(struct device *dev)
>>>          /*
>>>         * Try to allocate a default domain - needs support from the
>>> -     * IOMMU driver. There are still some drivers which don't
>>> -     * support default domains, so the return value is not yet
>>> -     * checked.
>>> +     * IOMMU driver.
>>>         */
>>>        mutex_lock(&group->mutex);
>>> -    iommu_alloc_default_domain(group, dev);
>>> +    ret = iommu_alloc_default_domain(group, dev);
>>> +    if (ret) {
>>> +        mutex_unlock(&group->mutex);
>>> +        iommu_group_put(group);
>>> +        goto err_release;
>>> +    }
>> Some IOMMU drivers (s390, gart, tegra...) don't support default domains.
>> iommu_alloc_default_domain() returns a ENOMEM and the probe process
>> continues.
> Thanks for the clarification.
> 
>> Above changes this behavior. The probe process will always fails with
>> those IOMMU drivers.
> Right. I am wondering whether we have any other way to check the return value?

The __iommu_probe_device() treats ENODEV as a special return value which
actually means "the device has no IOMMU hardware, go ahead with other
devices." You can check with Joerg whether you can play the same game
here.

Best regards,
baolu
