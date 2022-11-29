Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05C2583
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669723111; x=1701259111;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U3Tl4S3Ip9ci59HnrcRegp2OrXY5p8eKKuV4kx7lCKE=;
  b=oEt4jIwZqXM6tYQ5EF5YHKI4bX0s8W1jm1ocX/m8MZcC/u02+Coy2lrl
   4/zzZ6TAPMRg1aG708BhhsJTi4PRuVmmHbIPU6VKqIQm1HOJItGo0FH0u
   trE3cDflA+qbxbwhU4Ow45AB2BU7MCHXZ8mUDySaI4jD3J4jbYXxNvMwr
   1RwSoOxVC7ZpgLriqAs70ylFu/uuzD9qu2uY02YGwRq/4I3NkExCTVnd4
   ojp1IyfoOF8AydH+U3sSz3G1kWKRVDci9tb0tZV+lXo/MB8RfRrb8+mOX
   1EnXAgap2co2erhzjc51xF1fCWFUnJBhITIUGjtfuKLpKNIW8/hZY3gR+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="315121074"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315121074"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:58:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888819302"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="888819302"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.73]) ([10.254.214.73])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:58:24 -0800
Message-ID: <953f2282-9459-d301-7766-a252703114f5@linux.intel.com>
Date: Tue, 29 Nov 2022 19:58:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Rob Clark <robdclark@gmail.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/20] iommu/mtk: Remove detach_dev callback
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-7-baolu.lu@linux.intel.com>
 <Y4S8elzfzdTJGtyK@nvidia.com> <cb1b825c-55f1-d305-0727-ce8180d5a79e@arm.com>
 <4a979bdc-d7b4-77b4-490a-5f3e691e3df3@linux.intel.com>
 <f9d005e2-9fc6-bbf4-53fb-95f18201ce2d@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f9d005e2-9fc6-bbf4-53fb-95f18201ce2d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/11/29 19:45, Robin Murphy wrote:
> On 2022-11-29 02:07, Baolu Lu wrote:
>> On 11/28/22 9:59 PM, Robin Murphy wrote:
>>> On 2022-11-28 13:49, Jason Gunthorpe wrote:
>>>> On Mon, Nov 28, 2022 at 02:46:34PM +0800, Lu Baolu wrote:
>>>>> The IOMMU driver supports default domain, so the detach_dev op will 
>>>>> never
>>>>> be called. Remove it to avoid dead code.
>>>>>
>>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> ---
>>>>>   drivers/iommu/mtk_iommu.c | 9 ---------
>>>>>   1 file changed, 9 deletions(-)
>>>>
>>>> I listed this driver as not supporting default domains:
>>>>
>>>> https://lore.kernel.org/linux-iommu/20220516135741.GV1343366@nvidia.com/
>>>>
>>>> ?
>>>>
>>>> Has something changed? Did I get it wrong?
>>>
>>> static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>>> {
>>>      struct mtk_iommu_domain *dom;
>>>
>>>      if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
>>>          return NULL;
>>> ...
>>>
>>>
>>> This one runs on arm64, so has always supported default domains for 
>>> iommu-dma to work.
>>
>> This, together with several other ones, only support IOMMU_DOMAIN_DMA
>> type of default domain. The iommu core handle this by falling back to
>> IOMMU_DOMAIN_DMA if other types fail.
>>
>>          dom = __iommu_domain_alloc(bus, type);
>>          if (!dom && type != IOMMU_DOMAIN_DMA) {
>>                  dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
>>                  if (dom)
>>                          pr_warn("Failed to allocate default IOMMU 
>> domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>>                                  type, group->name);
>>          }
>>
>> I have another cleanup series:
>>
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-use-def_default_type-wip
>>
>> which adds IOMMU_DOMAIN_DMA default domain type requirement in the
>> def_domain_type callback. I planed to bring that to discussion after
>> this one.
> 
> Per the discussion over on the s390 thread, I think that would be a step 
> in the wrong direction. I'd prefer to keep .def_domain_type for 
> device-specific requirements and express general driver domain support a 
> different way. If the IOMMU_DOMAIN_DMA fallback is worth removing then 
> the one for IOMMU_DOMAIN_BLOCKED is as well - no point doing half the 
> job ;)

Get you. Thanks for pointing this out. Sure, let's keep the code.

Best regards,
baolu
