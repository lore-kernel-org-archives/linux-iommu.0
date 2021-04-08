Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B173C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98259610F7
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98259610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 503C040100;
	Thu,  8 Apr 2021 14:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zv1LoNAE1Nh3; Thu,  8 Apr 2021 14:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34AFC40115;
	Thu,  8 Apr 2021 14:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF196C000C;
	Thu,  8 Apr 2021 14:41:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69017C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 4E3B140115
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id ihx733v-xdCb for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:41:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 0546440100
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:41:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617892888; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=z51+eKPSzi2Ser76/aHTCeRR6xiusVzqYKx//MdgCXU=;
 b=jH6tumGl3i/pmpo4wGnTrmZZKXqnaEHUbSHn9/9QfPcxwzbxNXhp0XmpbtRJp/DHXI+7UwAP
 LW9T1Maz7sX5ic6vts5/GzZxEcSu5l748hCoyrzISld6N28F4N8FufgX+lUfUXp2MNSjrz02
 a+763s1gLTtJrIlaXuAQux01Yy0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606f15f48807bcde1d045ccb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 14:40:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 05F98C43462; Thu,  8 Apr 2021 14:40:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 03918C433C6;
 Thu,  8 Apr 2021 14:40:50 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 08 Apr 2021 07:40:50 -0700
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v4 10/15] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
In-Reply-To: <20210408143211.GE17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-11-isaacm@codeaurora.org>
 <20210408143211.GE17998@willie-the-truck>
Message-ID: <0c50e14c0ed005d92289b2c8c32bc821@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On 2021-04-08 07:32, Will Deacon wrote:
> On Wed, Apr 07, 2021 at 09:52:36PM -0700, Isaac J. Manjarres wrote:
>> Implement the unmap_pages() callback for the ARM LPAE io-pgtable
>> format.
>> 
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>> Suggested-by: Will Deacon <will@kernel.org>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 70 
>> ++++++++++++++++++++++------------
>>  1 file changed, 45 insertions(+), 25 deletions(-)
>> 
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index ea66b10c04c4..6700685f81d4 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -253,8 +253,8 @@ static void __arm_lpae_set_pte(arm_lpae_iopte 
>> *ptep, arm_lpae_iopte pte,
>> 
>>  static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  			       struct iommu_iotlb_gather *gather,
>> -			       unsigned long iova, size_t size, int lvl,
>> -			       arm_lpae_iopte *ptep);
>> +			       unsigned long iova, size_t size, size_t pgcount,
>> +			       int lvl, arm_lpae_iopte *ptep);
>> 
>>  static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  				phys_addr_t paddr, arm_lpae_iopte prot,
>> @@ -298,7 +298,7 @@ static int arm_lpae_init_pte(struct 
>> arm_lpae_io_pgtable *data,
>>  			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>> 
>>  			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> -			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
>> +			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
>>  					     lvl, tblp) != sz) {
>>  				WARN_ON(1);
>>  				return -EINVAL;
>> @@ -526,14 +526,14 @@ static size_t arm_lpae_split_blk_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>  				       struct iommu_iotlb_gather *gather,
>>  				       unsigned long iova, size_t size,
>>  				       arm_lpae_iopte blk_pte, int lvl,
>> -				       arm_lpae_iopte *ptep)
>> +				       arm_lpae_iopte *ptep, size_t pgcount)
>>  {
>>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>  	arm_lpae_iopte pte, *tablep;
>>  	phys_addr_t blk_paddr;
>>  	size_t tablesz = ARM_LPAE_GRANULE(data);
>>  	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>> -	int i, unmap_idx = -1;
>> +	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
>> 
>>  	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>>  		return 0;
>> @@ -542,15 +542,18 @@ static size_t arm_lpae_split_blk_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>  	if (!tablep)
>>  		return 0; /* Bytes unmapped */
>> 
>> -	if (size == split_sz)
>> -		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
>> +	if (size == split_sz) {
>> +		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>> +		max_entries = (tablesz >> ilog2(sizeof(pte))) - unmap_idx_start;
>> +		num_entries = min_t(int, pgcount, max_entries);
>> +	}
>> 
>>  	blk_paddr = iopte_to_paddr(blk_pte, data);
>>  	pte = iopte_prot(blk_pte);
>> 
>>  	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {
> 
> Given that we already have a 'tablesz / sizeof(pte)' expression here, 
> I'd be
> inclined to have either a local variable or a macro helper to get at 
> the
> ptes_per_table value that you also need to compute max_entries.
I think a macro might be helpful, as the number of PTEs per table is 
useful in a few places.
> 
>>  		/* Unmap! */
>> -		if (i == unmap_idx)
>> +		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
>>  			continue;
>> 
>>  		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
>> @@ -568,38 +571,45 @@ static size_t arm_lpae_split_blk_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>  			return 0;
>> 
>>  		tablep = iopte_deref(pte, data);
>> -	} else if (unmap_idx >= 0) {
>> -		io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
>> -		return size;
>> +	} else if (unmap_idx_start >= 0) {
>> +		for (i = 0; i < num_entries; i++)
>> +			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, 
>> size);
> 
> I suppose we could add a count paramater to the iotlb gather stuff in
> future too, but for now this is fine as this series is already pretty 
> big.
> 
Okay. I can keep this in mind for the future.
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
