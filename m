Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CE17FC
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689042579; x=1720578579;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dPL9V5pr/4ZRNU0DEbh4J4CtxUEbZroAQ3X7ZC3he3k=;
  b=I9HrXm7cKsQDMffG1U5OnNCzVkgriPga7vsW0uC6fceVQnEa1DKrCI0t
   IsMjY2xnvbXG9shxQ1v8fUj/HeBt0B7CtG4st0kTfDyK8k2mU21aNJdgD
   jtM/fXUFiUlEowU9+LwxK4puAP+cqQGdcM6HzBrOluQb90yseIRupNNKS
   jKXodqi0h0O0hfs3Rl723r5slV+cNrfwPDGsUNnff24I7ngFkavvOGCcZ
   X0jKW1F5rd/DaRk7TlHi87I05rB+7EVtgvJbA30edprXnQs5E76gMnrPR
   XfmkLmJKYBcuRI4hZLWe3KLu9Yq9Pnhfm8c7emy+swbAYEAumgZGy0tlS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344103659"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344103659"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="1051600620"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1051600620"
Received: from chunyeny-mobl1.gar.corp.intel.com (HELO [10.252.187.35]) ([10.252.187.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:29:32 -0700
Message-ID: <d6399f56-0528-d923-910c-822611137e2d@linux.intel.com>
Date: Tue, 11 Jul 2023 10:29:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 rex.zhang@intel.com, xiaochen.shen@intel.com, narayan.ranganathan@intel.com
Subject: Re: [PATCH v9 0/7] Re-enable IDXD kernel workqueue under DMA API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, dmaengine@vger.kernel.org,
 vkoul@kernel.org
References: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
 <20230710101810.40098ce3@jacob-builder>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230710101810.40098ce3@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/11 1:18, Jacob Pan wrote:
> Hi Baolu, Joerg, and all,

Hi Jacob,

> 
> Just wondering if there are more comments?
> 
> Thanks,
> 
> Jacob
> 
> On Wed, 21 Jun 2023 13:59:40 -0700, Jacob Pan
> <jacob.jun.pan@linux.intel.com>  wrote:
> 
>> Hi Joerg and all,
>>
>> IDXD kernel work queues were disabled due to the flawed use of kernel VA
>> and SVA API.
>> Link:
>> https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
>>
>> The solution is to enable it under DMA API where IDXD shared workqueue
>> users can use ENQCMDS to submit work on buffers mapped by DMA API.
>>
>> This patchset adds support for attaching PASID to the device's default
>> domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD
>> driver can then re-enable the kernel work queues and use them under DMA
>> API.
>>
>> This depends on the IOASID removal series. (merged)
>> https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/
>>
>>
>> Thanks,
>>
>> Jacob
>>
>> ---
>> Changelog:
>> v9:
>> 	- Fix an IDXD driver issue where user interrupt enable bit got
>> cleared during device enable/disable cycle. Reported and tested by
>> 	  Tony Zhu<tony.zhu@intel.com>
>> 	- Rebased to v6.4-rc7

Thanks for fixing this.

It seems that you missed some review comments for v8. I can help to test
and merge when all comments are addressed.

Best regards,
baolu
