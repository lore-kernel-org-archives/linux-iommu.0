Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC71114
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685582196; x=1717118196;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tAtoy6vyD/FFo8yx/WSerckmwPvtc200QA5T5JTs1Ps=;
  b=QiH0J94Xo7WBaijhu5sKKgtxxpKBHNCTWXj30uXZIlOUYh/4swCxvfR3
   KLnjajJze2Mj1IZ1UeOLhp0vWpdXYWkLJyT9iSVYq+VaOOkbP3R5UYLZc
   9dapCM4r498nw+x2RZZSJixP4egxDaj8PkZOeC8Js28iMV+Ib2o6P1IGw
   bRRSnsZusNZmLa2tocbAqGN9uL0w7q9+N2p5X95Y90GFwZHzBV2r00MgR
   3AUxhhbdxcY5WQc+STp5mlmlmT6A9P+2XX/MF3GQv9b403JmuAHdwqqoJ
   1MpdMLkvEqawLkuDmJC3S3xDzRCMdRw0W5VP5OZK/lqwuP2p3XX0qpDzU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441775772"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="441775772"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 18:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="796932050"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="796932050"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 18:16:33 -0700
Message-ID: <c8c0a8f6-751b-b9e7-ffd8-72859c0e3b12@linux.intel.com>
Date: Thu, 1 Jun 2023 09:15:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove the dead code in init_iommu_hw()
To: Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-2-yanfei.xu@intel.com>
 <3d7ce5c1-c248-a14a-2dc4-79449da9aa43@linux.intel.com>
 <35cff015-2408-b7bf-976a-b0ac8cfd6857@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <35cff015-2408-b7bf-976a-b0ac8cfd6857@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/23 2:55 PM, Yanfei Xu wrote:
> 
> On 5/31/2023 11:24 AM, Baolu Lu wrote:
>> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>>> After 'commit 2a41ccee2fdc ("iommu/vt-d: Change
>>> iommu_enable/disable_translation to return void")', init_iommu_hw() only
>>> returns 0. If statement for return value of this function is 
>>> meaningless.
>>> Hence change init_iommu_hw() to return viod and remove the dead code of
>>> if statement in init_iommu_hw()
>>>
>>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 8096273b034c..e98f1b122b49 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -2963,7 +2963,7 @@ static void __init init_no_remapping_devices(void)
>>>   }
>>>     #ifdef CONFIG_SUSPEND
>>> -static int init_iommu_hw(void)
>>> +static void init_iommu_hw(void)
>>>   {
>>>       struct dmar_drhd_unit *drhd;
>>>       struct intel_iommu *iommu = NULL;
>>> @@ -2988,8 +2988,6 @@ static int init_iommu_hw(void)
>>>           iommu_enable_translation(iommu);
>>>           iommu_disable_protect_mem_regions(iommu);
>>>       }
>>> -
>>> -    return 0;
>>
>> 2966 static int init_iommu_hw(void)
>> 2967 {
>> 2968         struct dmar_drhd_unit *drhd;
>> 2969         struct intel_iommu *iommu = NULL;
>> 2970
>> 2971         for_each_active_iommu(iommu, drhd)
>> 2972                 if (iommu->qi)
>> 2973                         dmar_reenable_qi(iommu);
>>
>> dmar_reenable_qi() still possibly returns an error number. It's better
>> to pass this error number to the caller of init_iommu_hw()?
>>
> Event dmar_reenable_qi can return error number, but there is no caller
> check it. As below, only these two places invoke it:
> 1. init_iommu_hw->dmar_reenable_qi
> 2. reenable_irq_remapping->dmar_reenable_qi
> 
> I think we can also convert dmar_reenable_qi() to return void:
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index a3414afe11b0..1432483c79e8 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2112,13 +2112,10 @@ int __init enable_drhd_fault_handling(void)
>   /*
>    * Re-enable Queued Invalidation interface.
>    */
> -int dmar_reenable_qi(struct intel_iommu *iommu)
> +void dmar_reenable_qi(struct intel_iommu *iommu)
>   {
> -       if (!ecap_qis(iommu->ecap))
> -               return -ENOENT;
> -
> -       if (!iommu->qi)
> -               return -ENOENT;
> +       WARN_ON(!iommu->qi || !ecap_qis(iommu->ecap))
> +               return;
> 
>          /*
>           * First disable queued invalidation.
> @@ -2130,8 +2127,6 @@ int dmar_reenable_qi(struct intel_iommu *iommu)
>           * invalidation.
>           */
>          __dmar_enable_qi(iommu);
> -
> -       return 0;
>   }
> 
>  From my understanding, dmar_reenable_qi() is used in suspend/resume case,
> so the extended cap of an existing IOMMU hardware is unlikely changed. As
> for the check of iommu->qi, if dmar_reenable_qi() can be invoked all is
> depended on the no-NULL of iommu->qi at first. How about using WARN_ON for
> both of them to simply this function.

This seems to be heading in the opposite direction. Actually any
operation may succeed or fail.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..ecc2007a96f9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2967,10 +2967,13 @@ static int init_iommu_hw(void)
  {
         struct dmar_drhd_unit *drhd;
         struct intel_iommu *iommu = NULL;
+       int ret;

-       for_each_active_iommu(iommu, drhd)
-               if (iommu->qi)
-                       dmar_reenable_qi(iommu);
+       for_each_active_iommu(iommu, drhd) {
+               ret = dmar_reenable_qi(iommu);
+               if (ret)
+                       return ret;
+       }

         for_each_iommu(iommu, drhd) {
                 if (drhd->ignored) {

Best regards,
baolu
