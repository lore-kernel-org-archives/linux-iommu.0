Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B8BC433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DDA610A3
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DDA610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3088241863;
	Thu,  8 Apr 2021 14:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6TtKkTyYXzU; Thu,  8 Apr 2021 14:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 436344185E;
	Thu,  8 Apr 2021 14:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F918C000C;
	Thu,  8 Apr 2021 14:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41F85C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 2382D4010A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id HbCC0IFwpZyb for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:20:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 77F4A40100
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617891610; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vio3MbRBRZte6xvLiIbtXUqWrxzbxeS0h6Hrehm80DA=;
 b=J1/qSAoQ2DLLgUbH2jMOdx2z7f0Wyxj5J04U8lbbQeXGCjwFpPe5UV0aU5YHAoGYKryQfosc
 Y+2vbOFukWz/fx6b5/youBRvCzYMvSkMogPoCQ9U4XgJZ9Y6nDHC8DhbynmAGte2J2xeWXkm
 Tmh+cQtpwjy3b+7+oH4IFU+bLpg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606f11088807bcde1de71f64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 14:19:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1E565C43462; Thu,  8 Apr 2021 14:19:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EC27C43461;
 Thu,  8 Apr 2021 14:19:51 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 08 Apr 2021 07:19:51 -0700
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v4 06/15] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
In-Reply-To: <20210408135901.GB17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-7-isaacm@codeaurora.org>
 <20210408135901.GB17998@willie-the-truck>
Message-ID: <e6d3979a3966a65b8d24e50b3ed304d3@codeaurora.org>
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

On 2021-04-08 06:59, Will Deacon wrote:
> On Wed, Apr 07, 2021 at 09:52:32PM -0700, Isaac J. Manjarres wrote:
>> From: Will Deacon <will@kernel.org>
>> 
>> The 'addr_merge' parameter to iommu_pgsize() is a fabricated address
>> intended to describe the alignment requirements to consider when
>> choosing an appropriate page size. On the iommu_map() path, this 
>> address
>> is the logical OR of the virtual and physical addresses.
>> 
>> Subsequent improvements to iommu_pgsize() will need to check the
>> alignment of the virtual and physical components of 'addr_merge'
>> independently, so pass them in as separate parameters and reconstruct
>> 'addr_merge' locally.
>> 
>> No functional change.
>> 
>> Signed-off-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>> ---
>>  drivers/iommu/iommu.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index bcd623862bf9..ab689611a03b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2357,12 +2357,13 @@ phys_addr_t iommu_iova_to_phys(struct 
>> iommu_domain *domain, dma_addr_t iova)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>> 
>> -static size_t iommu_pgsize(struct iommu_domain *domain,
>> -			   unsigned long addr_merge, size_t size)
>> +static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long 
>> iova,
>> +			   phys_addr_t paddr, size_t size)
>>  {
>>  	unsigned int pgsize_idx;
>>  	unsigned long pgsizes;
>>  	size_t pgsize;
>> +	phys_addr_t addr_merge = paddr | iova;
> 
> ^^^ this needs to be 'unsigned long' as it was before (otherwise using
> GENMASK _is_ a problem).
> 
Done.
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
