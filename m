Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07C7B
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676446109; x=1707982109;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YJgm54HB5SlkTGHQH3AwfbmZD0hjGzeKrj4JoeW3L74=;
  b=CgbpYCvfh9X04uyWCxgpIUwi7/CAIF6331Emw9w3bWr00qFpt2G0yxlm
   325hhukgKOv0SVvTq/pdUZ38/JvHdHK1ipaqJrHVKNluNjsfgIDuiSlRu
   dDsRu7XxG7sWYH3ePxLfD+DeffOzP4K9jDRZhCZTDup3Xk85cKD+XsK8G
   w/yFgbHguCj3UPV0RPUzdfoUm6hXuYGqNDBxMBguqwKt/0+4lYSwxsA4l
   jLQzboBHRWZZr6jJ1vJyCddj8x/goh6PfcaicsfHppVDlAuYTqO8ToG5t
   flPIBF4oeoYoB1qGa267qGBzCL6hggpLTE7hMkH1lphjSZGwC0YXAiElz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332675552"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="332675552"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:28:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733175735"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="733175735"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.164]) ([10.254.212.164])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:28:25 -0800
Message-ID: <4ac228af-fb74-2d89-b8d7-462186170e12@linux.intel.com>
Date: Wed, 15 Feb 2023 15:28:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
 <BN9PR11MB52768BD174CE9F4AE40C12078CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768BD174CE9F4AE40C12078CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/15 14:56, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, February 15, 2023 1:51 PM
>>
>> On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
>>> On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
>>>> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct
>> iommu_group *group,
>>>>    	else
>>>>    		return -EINVAL;
>>>>
>>>> +	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
>>>> +	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
>>>> +		ret = iommu_group_claim_dma_owner(group, (void *)buf);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		group_owner_claimed = true;
>>>> +	}
>>> I don't get it, this should be done unconditionally. If we couldn't
>>> take ownership then we simply can't progress.
>> The existing code allows the user to switch the default domain from
>> strict to lazy invalidation mode. The default domain is not changed,
>> hence it should be seamless and transparent to the device driver.
> Is there real usage relying on this transition for a bound device?
> 
> In concept strict->lazy transition implies relaxed DMA security. It's hard
> to think of a motivation of doing so while the device might be doing
> in-fly DMAs.
> 
> Presumably such perf/security tradeoff should be planned way before
> binding device/driver together.
> 
> btw if strict->lazy is allowed why lazy->strict is prohibited?
> 

We all know, strict vs. lazy is a tradeoff between performance and
security.

strict -> lazy: driver works in secure mode. This transition trades off
security for better performance.

lazy->strict: The driver is already working in non-safety mode. This
transition only results in worse performance. It makes no sense. If user
want to put the driver in a secure mode, they need to unbind the driver,
reset the device and do the lazy->strict transition.

Robin might have better insights.

Best regards,
baolu
