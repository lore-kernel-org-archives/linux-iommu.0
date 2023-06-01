Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784B1114
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 01:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685582683; x=1717118683;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vkqhGsgk3MYAdTf0+chQ1jY4UVD8G35fFDs8sGIJl94=;
  b=OXu7pWA2sMdu/8XB71W6WbgnwKnpIfCMCwQvJggCdY9cDkRvWsQRVz4r
   xJx2otpGI+nOO8pKVR8hpnMDOsxihRfqG6gz/FqyA8/GegUFvDDqdfkoi
   qQsqyNXI4hUlSIhNbqfdCTlWExSs7zPTmuCVKVQT/DIz914qtcC4czTtH
   F9VAlYj/cIAj2JZL5RFveNQ8mO5o4ChEUSHFDLYFSrPI50kVG5Ta6S3B/
   3n/2UrKrS1lq0ceP5lj/YEMEcHkU2ITOKJqC6dcFLXwrXAfOjsq90CgTY
   LwE8CnSg0MR7Q5m2CMHYiKKndJ2fpAsYzfF2SGLuhLR98iY6lZV/AmN6r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344942007"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="344942007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 18:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037272774"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="1037272774"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 18:24:40 -0700
Message-ID: <e735528a-7bbd-b9a8-7945-10f779fb750e@linux.intel.com>
Date: Thu, 1 Jun 2023 09:23:44 +0800
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
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Content-Language: en-US
To: Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
 <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
 <a745c910-f4be-62f6-cb02-a610c04f4698@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a745c910-f4be-62f6-cb02-a610c04f4698@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/23 3:09 PM, Yanfei Xu wrote:
> On 5/31/2023 11:26 AM, Baolu Lu wrote:
>> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>>> Checking NULL value of 'table' variable deserves a BUG_ON as the
>>> following code will trigger a crash by dereferencing the NULL
>>> 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
>>> plus NULL pointer dereferencing can simplify the crash log.
>>>
>>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index e98f1b122b49..8aa3bfdb7f95 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct 
>>> dmar_domain *domain,
>>>       if (sm_supported(iommu)) {
>>>           unsigned long pds;
>>>   -        WARN_ON(!table);
>>> +        BUG_ON(!table);
>>
>> BUG_ON() is not recommended. Perhaps,
>>
>>         if (!table)
>>             -ENODEV;
>>
> Agree:) It is always better to handle the error than crash kernel.
> 
> How about:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8096273b034c..7f077e3a4128 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1944,7 +1944,10 @@ static int domain_context_mapping_one(struct 
> dmar_domain *domain,
>          if (sm_supported(iommu)) {
>                  unsigned long pds;
> 
> -               WARN_ON(!table);
> +               if (WARN_ON(!table)) {
> +                       ret = -ENODEV;
> +                       goto out_unlock;
> +               }

I'd recommend to remove this line directly. This pointer will be
accessed in the following code, if empty "table" really happens, the
kernel will report a NULL pointer reference warning at the first place.

In the same function, I also saw "WARN_ON(did == 0);". It's unnecessary
as domain_id_iommu() will never return 0. Perhaps we can clean it up as
well.

Best regards,
baolu
