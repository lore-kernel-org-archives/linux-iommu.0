Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D371C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 02:26:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0A61260
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 02:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53D0A61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232D683A9C;
	Thu, 21 Oct 2021 02:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2DB16KVTcgob; Thu, 21 Oct 2021 02:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DED9E83A8F;
	Thu, 21 Oct 2021 02:26:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B72B4C0011;
	Thu, 21 Oct 2021 02:26:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E12AAC000D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 02:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC17C401F8
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 02:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AxGx4pOBSP8P for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 02:26:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB0254012E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 02:26:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="315132600"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="315132600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 19:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="483985485"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 20 Oct 2021 19:26:37 -0700
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
To: Marc Zyngier <maz@kernel.org>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
 <8735ovdbcv.wl-maz@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6a886030-cbc6-9e92-bf79-77b659da2915@linux.intel.com>
Date: Thu, 21 Oct 2021 10:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8735ovdbcv.wl-maz@kernel.org>
Content-Language: en-US
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/20/21 10:22 PM, Marc Zyngier wrote:
> On Wed, 20 Oct 2021 06:21:44 +0100,
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>>> The iova allocator is capable of handling any granularity which is a power
>>> of two. Remove the much stronger condition that the granularity must be
>>> smaller or equal to the CPU page size from a BUG_ON there.
>>> Instead, check this condition during __iommu_attach_device and fail
>>> gracefully.
>>>
>>> Signed-off-by: Sven Peter<sven@svenpeter.dev>
>>> ---
>>>    drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
>>>    drivers/iommu/iova.c  |  7 ++++---
>>>    include/linux/iommu.h |  5 +++++
>>>    3 files changed, 41 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index dd7863e453a5..28896739964b 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -80,6 +80,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>    						 unsigned type);
>>>    static int __iommu_attach_device(struct iommu_domain *domain,
>>>    				 struct device *dev);
>>> +static void __iommu_detach_device(struct iommu_domain *domain,
>>> +				  struct device *dev);
>>>    static int __iommu_attach_group(struct iommu_domain *domain,
>>>    				struct iommu_group *group);
>>>    static void __iommu_detach_group(struct iommu_domain *domain,
>>> @@ -1974,6 +1976,19 @@ void iommu_domain_free(struct iommu_domain *domain)
>>>    }
>>>    EXPORT_SYMBOL_GPL(iommu_domain_free);
>>>    +static int iommu_check_page_size(struct iommu_domain *domain)
>>> +{
>>> +	if (!iommu_is_paging_domain(domain))
>>> +		return 0;
>>> +
>>> +	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
>>> +		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
>>> +		return -EFAULT;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static int __iommu_attach_device(struct iommu_domain *domain,
>>>    				 struct device *dev)
>>>    {
>>> @@ -1983,9 +1998,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>>    		return -ENODEV;
>>>      	ret = domain->ops->attach_dev(domain, dev);
>>> -	if (!ret)
>>> -		trace_attach_device_to_domain(dev);
>>> -	return ret;
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>>> +	 * only limit domain->pgsize_bitmap after having attached the first
>>> +	 * device.
>>> +	 */
>>> +	ret = iommu_check_page_size(domain);
>>> +	if (ret) {
>>> +		__iommu_detach_device(domain, dev);
>>> +		return ret;
>>> +	}
>>
>> It looks odd. __iommu_attach_device() attaches an I/O page table for a
>> device. How does it relate to CPU pages? Why is it a failure case if CPU
>> page size is not covered?
> 
> If you allocate a CPU PAGE_SIZE'd region, and point it at a device
> that now can DMA to more than what you have allocated because the
> IOMMU's own page size is larger, the device has now access to data it
> shouldn't see. In my book, that's a pretty bad thing.

But even you enforce the CPU page size check here, this problem still
exists unless all DMA buffers are PAGE_SIZE aligned and sized, right?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
