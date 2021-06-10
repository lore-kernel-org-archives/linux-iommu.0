Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9CC48BE0
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 05:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC723613E7
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 05:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC723613E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CC5F83C8D;
	Thu, 10 Jun 2021 05:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svVJb6D_7VYP; Thu, 10 Jun 2021 05:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44D8783C98;
	Thu, 10 Jun 2021 05:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3919C000E;
	Thu, 10 Jun 2021 05:25:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD35C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 4C64440383
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id mfrEv9LC8ly0 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:25:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 3CF4040380
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:25:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623302710; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Bgf1x/nFWFQGqJpMO9ldu/lRRQ3GhGowilaUgKGPmUA=;
 b=rM/ZF4vUKYNHyEopeG6Xa/i7vHsmD3eYWZzvrousMsKXmdIo1098iL7LT3FS29wJ5e/g+wx2
 6kUUIGRpsXEkEgGiuDFpM3X2DJMxypI3I5xE/Kyv+ro1TAGZSh2dphJhHqv/HFWFKWHvcSoD
 0EQYD4iOzbKhNr4F9G63gDylJ0g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c1a22ced59bf69ccccc7cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Jun 2021 05:25:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 0161EC43146; Thu, 10 Jun 2021 05:25:00 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 23D8BC4338A;
 Thu, 10 Jun 2021 05:24:58 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 10 Jun 2021 10:54:58 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
Message-ID: <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

Hi Robin,

On 2021-06-10 00:14, Robin Murphy wrote:
> On 2021-06-09 15:53, Sai Prakash Ranjan wrote:
>> Currently for iommu_unmap() of large scatter-gather list with page 
>> size
>> elements, the majority of time is spent in flushing of partial walks 
>> in
>> __arm_lpae_unmap() which is a VA based TLB invalidation (TLBIVA for
>> arm-smmu).
>> 
>> For example: to unmap a 32MB scatter-gather list with page size 
>> elements
>> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize 
>> (2MB
>> for 4K granule) and each of 2MB will further result in 512 TLBIVAs 
>> (2MB/4K)
>> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a 
>> huge
>> overhead.
>> 
>> So instead use io_pgtable_tlb_flush_all() to invalidate the entire 
>> context
>> if size (pgsize) is greater than the granule size (4K, 16K, 64K). For 
>> this
>> example of 32MB scatter-gather list unmap, this results in just 16 
>> ASID
>> based TLB invalidations or tlb_flush_all() callback (TLBIASID in case 
>> of
>> arm-smmu) as opposed to 8192 TLBIVAs thereby increasing the 
>> performance of
>> unmaps drastically.
>> 
>> Condition (size > granule size) is chosen for 
>> io_pgtable_tlb_flush_all()
>> because for any granule with supported pgsizes, we will have at least 
>> 512
>> TLB invalidations for which tlb_flush_all() is already recommended. 
>> For
>> example, take 4K granule with 2MB pgsize, this will result in 512 
>> TLBIVA
>> in partial walk flush.
>> 
>> Test on QTI SM8150 SoC for 10 iterations of iommu_{map_sg}/unmap:
>> (average over 10 iterations)
>> 
>> Before this optimization:
>> 
>>      size        iommu_map_sg      iommu_unmap
>>        4K            2.067 us         1.854 us
>>       64K            9.598 us         8.802 us
>>        1M          148.890 us       130.718 us
>>        2M          305.864 us        67.291 us
>>       12M         1793.604 us       390.838 us
>>       16M         2386.848 us       518.187 us
>>       24M         3563.296 us       775.989 us
>>       32M         4747.171 us      1033.364 us
>> 
>> After this optimization:
>> 
>>      size        iommu_map_sg      iommu_unmap
>>        4K            1.723 us         1.765 us
>>       64K            9.880 us         8.869 us
>>        1M          155.364 us       135.223 us
>>        2M          303.906 us         5.385 us
>>       12M         1786.557 us        21.250 us
>>       16M         2391.890 us        27.437 us
>>       24M         3570.895 us        39.937 us
>>       32M         4755.234 us        51.797 us
>> 
>> This is further reduced once the map/unmap_pages() support gets in 
>> which
>> will result in just 1 tlb_flush_all() as opposed to 16 
>> tlb_flush_all().
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index 87def58e79b5..c3cb9add3179 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -589,8 +589,11 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>     		if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>   			/* Also flush any partial walks */
>> -			io_pgtable_tlb_flush_walk(iop, iova, size,
>> -						  ARM_LPAE_GRANULE(data));
>> +			if (size > ARM_LPAE_GRANULE(data))
>> +				io_pgtable_tlb_flush_all(iop);
>> +			else
> 
> Erm, when will the above condition ever not be true? ;)
> 

Ah right, silly me :)

> Taking a step back, though, what about the impact to drivers other
> than SMMUv2?

Other drivers would be msm_iommu.c, qcom_iommu.c which does the same
thing as arm-smmu-v2 (page based invalidations), then there is 
ipmmu-vmsa.c
which does tlb_flush_all() for flush walk.

> In particular I'm thinking of SMMUv3.2 where the whole
> range can be invalidated by VA in a single command anyway, so the
> additional penalties of TLBIALL are undesirable.
> 

Right, so I am thinking we can have a new generic quirk 
IO_PGTABLE_QUIRK_RANGE_INV
to choose between range based invalidations(tlb_flush_walk) and 
tlb_flush_all().
In this case of arm-smmu-v3.2, we can tie up ARM_SMMU_FEAT_RANGE_INV 
with this quirk
and have something like below, thoughts?

if (iop->cfg.quirks & IO_PGTABLE_QUIRK_RANGE_INV)
         io_pgtable_tlb_flush_walk(iop, iova, size,
                                   ARM_LPAE_GRANULE(data));
else
         io_pgtable_tlb_flush_all(iop);

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
