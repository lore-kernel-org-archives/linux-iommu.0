Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB7C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:23:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591FF610A8
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 591FF610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25293404F6;
	Mon,  2 Aug 2021 15:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kubSa_I1m1X; Mon,  2 Aug 2021 15:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 055214050A;
	Mon,  2 Aug 2021 15:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF178C0010;
	Mon,  2 Aug 2021 15:23:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E60CC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DF674050A
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w33g5ngYmlnN for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:23:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 269B1404F6
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:23:32 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdhbZ25Vcz6FFxN;
 Mon,  2 Aug 2021 23:23:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:23:29 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:23:28 +0100
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be flexible
To: Will Deacon <will@kernel.org>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
 <20210802150153.GC28735@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
Date: Mon, 2 Aug 2021 16:23:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210802150153.GC28735@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, linuxarm@huawei.com,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, robin.murphy@arm.com,
 jasowang@redhat.com, tian.shu.qiu@intel.com
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

On 02/08/2021 16:01, Will Deacon wrote:
> On Wed, Jul 14, 2021 at 06:36:39PM +0800, John Garry wrote:
>> Some LLDs may request DMA mappings whose IOVA length exceeds that of the
>> current rcache upper limit.
> 
> What's an LLD?
> 

low-level driver

maybe I'll stick with simply "drivers"

>> This means that allocations for those IOVAs will never be cached, and
>> always must be allocated and freed from the RB tree per DMA mapping cycle.
>> This has a significant effect on performance, more so since commit
>> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
>> fails"), as discussed at [0].
>>
>> As a first step towards allowing the rcache range upper limit be
>> configured, hold this value in the IOVA rcache structure, and allocate
>> the rcaches separately.
>>
>> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c |  2 +-
>>   drivers/iommu/iova.c      | 23 +++++++++++++++++------
>>   include/linux/iova.h      |  4 ++--
>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 98ba927aee1a..4772278aa5da 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -434,7 +434,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>   	 * rounding up anything cacheable to make sure that can't happen. The
>>   	 * order of the unadjusted size will still match upon freeing.
>>   	 */
>> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>> +	if (iova_len < (1 << (iovad->rcache_max_size - 1)))
>>   		iova_len = roundup_pow_of_two(iova_len);
>>   
>>   	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index b6cf5f16123b..07ce73fdd8c1 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -15,6 +15,8 @@
>>   /* The anchor node sits above the top of the usable address space */
>>   #define IOVA_ANCHOR	~0UL
>>   
>> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range size (in pages) */
> 
> Is that the same as an 'order'? i.e. IOVA_RANGE_CACHE_MAX_ORDER?

Yeah, that may be better. I was just using the same name as before.

> 
>> +
>>   static bool iova_rcache_insert(struct iova_domain *iovad,
>>   			       unsigned long pfn,
>>   			       unsigned long size);
>> @@ -881,7 +883,14 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>>   	unsigned int cpu;
>>   	int i;
>>   
>> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
>> +
>> +	iovad->rcaches = kcalloc(iovad->rcache_max_size,
>> +				 sizeof(*iovad->rcaches), GFP_KERNEL);
>> +	if (!iovad->rcaches)
>> +		return;
> 
> Returning quietly here doesn't seem like the right thing to do. At least, I
> don't think the rest of the functions here are checking rcaches against
> NULL.
> 

For sure, but that is what other code which can fail here already does, 
like:

static void init_iova_rcaches(struct iova_domain *iovad)
{
	...

	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
		...

		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), 
cache_line_size());
		if (WARN_ON(!rcache->cpu_rcaches))
			continue;
}

and that is not safe either.

This issue was raised a while ago. I don't mind trying to fix it - a 
slightly painful part is that it touches a few subsystems.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
