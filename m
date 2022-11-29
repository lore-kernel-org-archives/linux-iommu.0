Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3737C
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669688097; x=1701224097;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N5zvBX15lr1YZY8BlmGZXuzWrDu5BekEK8IaVFde6q4=;
  b=CpxaVIkHLOjDEA7DFMINf4P5WhGyKOznKZIJZGLk2WvNLSNhx1UZ1pDy
   UYXXK2V/fu+ymihzfFAEf7rR0HfuoRqx38kJSxulhe5f0H8RmbeDAn9DW
   90mbbIbBCImdViXKsCL6aVbTpvZaTjiHGRIzdYEK6CQim30HhH2EeJpx0
   CpCgRBvFeDOYzXC8PX0IczEbUfPJbuf29Zx0D6UD5hDXE2hG8qvV/tJz3
   bn3ihzh2rFBnsNk2StSyEQ/6xh+lRkChteeV+Pyt8U70p7ThJ7Dajl1Jf
   5FQ1IUhbd2EVyXh4W3ngXb0nhNflEKQDz2UpQDd8htgvYlp1tLjTOHYNL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312629127"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="312629127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="594093098"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="594093098"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2022 18:14:50 -0800
Message-ID: <4a979bdc-d7b4-77b4-490a-5f3e691e3df3@linux.intel.com>
Date: Tue, 29 Nov 2022 10:07:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-7-baolu.lu@linux.intel.com>
 <Y4S8elzfzdTJGtyK@nvidia.com> <cb1b825c-55f1-d305-0727-ce8180d5a79e@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cb1b825c-55f1-d305-0727-ce8180d5a79e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/22 9:59 PM, Robin Murphy wrote:
> On 2022-11-28 13:49, Jason Gunthorpe wrote:
>> On Mon, Nov 28, 2022 at 02:46:34PM +0800, Lu Baolu wrote:
>>> The IOMMU driver supports default domain, so the detach_dev op will 
>>> never
>>> be called. Remove it to avoid dead code.
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/mtk_iommu.c | 9 ---------
>>>   1 file changed, 9 deletions(-)
>>
>> I listed this driver as not supporting default domains:
>>
>> https://lore.kernel.org/linux-iommu/20220516135741.GV1343366@nvidia.com/
>>
>> ?
>>
>> Has something changed? Did I get it wrong?
> 
> static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> {
>      struct mtk_iommu_domain *dom;
> 
>      if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
>          return NULL;
> ...
> 
> 
> This one runs on arm64, so has always supported default domains for 
> iommu-dma to work.

This, together with several other ones, only support IOMMU_DOMAIN_DMA
type of default domain. The iommu core handle this by falling back to
IOMMU_DOMAIN_DMA if other types fail.

         dom = __iommu_domain_alloc(bus, type);
         if (!dom && type != IOMMU_DOMAIN_DMA) {
                 dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
                 if (dom)
                         pr_warn("Failed to allocate default IOMMU 
domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
                                 type, group->name);
         }

I have another cleanup series:

https://github.com/LuBaolu/intel-iommu/commits/iommu-use-def_default_type-wip

which adds IOMMU_DOMAIN_DMA default domain type requirement in the
def_domain_type callback. I planed to bring that to discussion after
this one.

Best regards,
baolu
