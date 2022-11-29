Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5836811
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 11:45:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D956D6E;
	Tue, 29 Nov 2022 03:46:00 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F9D3F73D;
	Tue, 29 Nov 2022 03:45:49 -0800 (PST)
Message-ID: <f9d005e2-9fc6-bbf4-53fb-95f18201ce2d@arm.com>
Date: Tue, 29 Nov 2022 11:45:45 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 06/20] iommu/mtk: Remove detach_dev callback
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
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
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-7-baolu.lu@linux.intel.com>
 <Y4S8elzfzdTJGtyK@nvidia.com> <cb1b825c-55f1-d305-0727-ce8180d5a79e@arm.com>
 <4a979bdc-d7b4-77b4-490a-5f3e691e3df3@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4a979bdc-d7b4-77b4-490a-5f3e691e3df3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-11-29 02:07, Baolu Lu wrote:
> On 11/28/22 9:59 PM, Robin Murphy wrote:
>> On 2022-11-28 13:49, Jason Gunthorpe wrote:
>>> On Mon, Nov 28, 2022 at 02:46:34PM +0800, Lu Baolu wrote:
>>>> The IOMMU driver supports default domain, so the detach_dev op will 
>>>> never
>>>> be called. Remove it to avoid dead code.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/mtk_iommu.c | 9 ---------
>>>>   1 file changed, 9 deletions(-)
>>>
>>> I listed this driver as not supporting default domains:
>>>
>>> https://lore.kernel.org/linux-iommu/20220516135741.GV1343366@nvidia.com/
>>>
>>> ?
>>>
>>> Has something changed? Did I get it wrong?
>>
>> static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>> {
>>      struct mtk_iommu_domain *dom;
>>
>>      if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
>>          return NULL;
>> ...
>>
>>
>> This one runs on arm64, so has always supported default domains for 
>> iommu-dma to work.
> 
> This, together with several other ones, only support IOMMU_DOMAIN_DMA
> type of default domain. The iommu core handle this by falling back to
> IOMMU_DOMAIN_DMA if other types fail.
> 
>          dom = __iommu_domain_alloc(bus, type);
>          if (!dom && type != IOMMU_DOMAIN_DMA) {
>                  dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
>                  if (dom)
>                          pr_warn("Failed to allocate default IOMMU 
> domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>                                  type, group->name);
>          }
> 
> I have another cleanup series:
> 
> https://github.com/LuBaolu/intel-iommu/commits/iommu-use-def_default_type-wip
> 
> which adds IOMMU_DOMAIN_DMA default domain type requirement in the
> def_domain_type callback. I planed to bring that to discussion after
> this one.

Per the discussion over on the s390 thread, I think that would be a step 
in the wrong direction. I'd prefer to keep .def_domain_type for 
device-specific requirements and express general driver domain support a 
different way. If the IOMMU_DOMAIN_DMA fallback is worth removing then 
the one for IOMMU_DOMAIN_BLOCKED is as well - no point doing half the job ;)

Thanks,
Robin.
