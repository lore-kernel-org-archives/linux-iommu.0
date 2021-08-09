Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DBC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 19:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF0C61004
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 19:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CF0C61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5303D40255;
	Mon,  9 Aug 2021 19:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGWHhA6rDp3u; Mon,  9 Aug 2021 19:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01C0E40204;
	Mon,  9 Aug 2021 19:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE97C001A;
	Mon,  9 Aug 2021 19:59:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776D5C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 19:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5210E6060D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 19:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEFpvwjXFb1y for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 19:59:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD431605D4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 19:59:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19E66D;
 Mon,  9 Aug 2021 12:59:41 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3261C3F40C;
 Mon,  9 Aug 2021 12:59:40 -0700 (PDT)
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To: Rajat Jain <rajatja@google.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
 <CACK8Z6HSM678q=BZ3FY7spN2S3ZkhdJ3ecnMCbKWrqB5dNWaMA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <00baf83a-5eb3-4d72-309c-5adfd3242c07@arm.com>
Date: Mon, 9 Aug 2021 20:59:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6HSM678q=BZ3FY7spN2S3ZkhdJ3ecnMCbKWrqB5dNWaMA@mail.gmail.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-08-09 20:05, Rajat Jain wrote:
> On Wed, Aug 4, 2021 at 10:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Factor out flush queue setup from the initial domain init so that we
>> can potentially trigger it from sysfs later on in a domain's lifetime.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>>   include/linux/dma-iommu.h |  9 ++++++---
>>   2 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 2e19505dddf9..f51b8dc99ac6 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>>          return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>>   }
>>
>> +int iommu_dma_init_fq(struct iommu_domain *domain)
>> +{
>> +       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +
>> +       if (domain->type != IOMMU_DOMAIN_DMA_FQ)
>> +               return -EINVAL;
>> +       if (cookie->fq_domain)
>> +               return 0;
>> +
>> +       if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
>> +                                 iommu_dma_entry_dtor)) {
>> +               pr_warn("iova flush queue initialization failed\n");
>> +               domain->type = IOMMU_DOMAIN_DMA;
>> +               return -ENODEV;
>> +       }
>> +       cookie->fq_domain = domain;
>> +       return 0;
>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>          }
>>
>>          init_iova_domain(iovad, 1UL << order, base_pfn);
>> -
>> -       if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
>> -               if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
>> -                                         iommu_dma_entry_dtor)) {
>> -                       pr_warn("iova flush queue initialization failed\n");
>> -                       domain->type = IOMMU_DOMAIN_DMA;
>> -               } else {
>> -                       cookie->fq_domain = domain;
>> -               }
>> -       }
>> +       iommu_dma_init_fq(domain);
>>
>>          return iova_reserve_iommu_regions(dev, domain);
>>   }
>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> index 758ca4694257..81ab647f1618 100644
>> --- a/include/linux/dma-iommu.h
>> +++ b/include/linux/dma-iommu.h
>> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>>
>>   /* Setup call for arch DMA mapping code */
>>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
>> +int iommu_dma_init_fq(struct iommu_domain *domain);
>>
>>   /* The DMA API isn't _quite_ the whole story, though... */
>>   /*
>> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>>
>>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>>
>> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>> -               struct iommu_domain *domain);
>> -
> 
> This looks like an unrelated code cleanup. Should this be a separate patch?

Ha, busted! Much of this was done in the "stream of consciousness" style 
where I made a big sprawling mess then split it up into patches and 
branches afterwards. TBH it was already feeling pretty tenuous having a 
separate patch just to move this one function, and it only gets more so 
with the simplification Will pointed out earlier. I think I'll squash 
iommu_dma_init_fq() into the next patch then do a thorough header sweep, 
since I've now spotted some things in iova.h which could probably go as 
well.

Thanks for the poke!

Robin.

> 
> Thanks,
> 
> Rajat
> 
> 
>>   extern bool iommu_dma_forcedac;
>>
>>   #else /* CONFIG_IOMMU_DMA */
>> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>>   {
>>   }
>>
>> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
>> +{
>> +       return -EINVAL;
>> +}
>> +
>>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>>   {
>>          return -ENODEV;
>> --
>> 2.25.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
