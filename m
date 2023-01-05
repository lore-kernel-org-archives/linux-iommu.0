Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF97FD
	for <iommu@lists.linux.dev>; Thu,  5 Jan 2023 05:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672898333; x=1704434333;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=s5aaIEbbbKip1vwzbtKy2QwcpBFkECPTXwB0EP8j7fA=;
  b=XI/Gj5xxcy7eLfwJgWeNVxMcwcfYnKswL1RXk2Kg94AxvnVbxxHinel8
   bWj5KRdw4uP8TE8XU0uPpVJ75xjCmztx+ylU04zBQInOda3enKwVKg6UC
   OPgi0PuPeb+e8KkimykLkrEbBA1RXf6SSDERmTASnlo9v9dMJK6XGjKEB
   fbWZpHJiKeGnmolPS5lL/tSyj9zVu2i+80hPBYHSetf/Eb/CW/snWiOQH
   NPRNxu40nDjHgw4yNyf3vb+MFUNEi8ipMAm+NJQpjG3fIqMl2SEBkCCNw
   vm2La9KVJQAO3BjrZSct0wwDUAT9PIKHcdRzPM2hYj2QTJ0SyrYtyBCo7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="305624762"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="305624762"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:58:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="648810306"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="648810306"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:58:44 -0800
Message-ID: <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
Date: Thu, 5 Jan 2023 13:58:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
In-Reply-To: <Y7V8bcUF5zvGvCAP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 2023/1/4 21:17, Jason Gunthorpe wrote:
> On Wed, Jan 04, 2023 at 08:57:16PM +0800, Lu Baolu wrote:
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index de91dd88705b..4e35a9f94873 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2163,6 +2163,17 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>>   	return 0;
>>   }
>>   
>> +static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +
>> +	if (!ops->set_platform_dma_ops)
>> +		return -EINVAL;
>> +
>> +	ops->set_platform_dma_ops(dev);
>> +	return 0;
>> +}
>> +
>>   static int __iommu_group_set_domain(struct iommu_group *group,
>>   				    struct iommu_domain *new_domain)
>>   {
>> @@ -2177,10 +2188,14 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>>   	 * platform specific behavior.
>>   	 */
>>   	if (!new_domain) {
>> -		if (WARN_ON(!group->domain->ops->detach_dev))
>> -			return -EINVAL;
> This should still have the WARN_ON..
> 
> if (WARN_ON(!group->domain->ops->detach_dev && !dev_iommu_ops(dev)->set_platform_dma_ops)

This has been implicitly included in the code.

iommu_group_do_set_platform_dma() returns -EINVAL if the iommu driver
doesn't support set_platform_dma_ops (otherwise always return success).
Then, the domain->ops->detach_dev is required and a WARN_ON was there.

         if (!new_domain) {
                 ret = __iommu_group_for_each_dev(group, NULL,
                                 iommu_group_do_set_platform_dma);
                 if (ret) {
                         if (WARN_ON(!group->domain->ops->detach_dev))
                                 return -EINVAL;
                         __iommu_group_for_each_dev(group, group->domain,
                                 iommu_group_do_detach_device);
                 }
                 group->domain = NULL;
                 return 0;
         }

Perhaps I should add a comment to explain this?

--
Best regards,
baolu
