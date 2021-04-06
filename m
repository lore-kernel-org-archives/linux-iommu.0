Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B74AC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 19:38:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF5561158
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 19:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF5561158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DB45402EE;
	Tue,  6 Apr 2021 19:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GPEplstSpL5y; Tue,  6 Apr 2021 19:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0687A400A5;
	Tue,  6 Apr 2021 19:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5E9BC000B;
	Tue,  6 Apr 2021 19:38:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD19C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 19:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 8295040698
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 19:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id PojvltYclKsb for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 19:38:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 124014064A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 19:38:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617737925; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=75Jpwne1BfAWOOAw2sX8Rd9ZbHrEyC4gPQ08M4dfVPg=;
 b=qMGsRQ5pUqaxrEQukZ7e633IUFQDOXov+m8k99NdsA3FKr1D50xQd7XZULsO70uClSGPQanV
 7c+RvIFn+dVPXTr3/GZ4u8KhIDBHAgXYzTf7UFChKbvIxe4psZk1WnNHtxVBdk/b/K4bf+9P
 AQ4LcAv/XVm6TE2+MN4BYREuyuc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 606cb8bb8166b7eff7096c15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 19:38:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 46C91C43466; Tue,  6 Apr 2021 19:38:35 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 699C6C433ED;
 Tue,  6 Apr 2021 19:38:34 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 06 Apr 2021 12:38:34 -0700
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v3 06/12] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
In-Reply-To: <20210406115355.GC13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-7-isaacm@codeaurora.org>
 <20210406115355.GC13747@willie-the-truck>
Message-ID: <224fa23c3597f946bb5cfac39e235dc8@codeaurora.org>
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

On 2021-04-06 04:53, Will Deacon wrote:
> On Mon, Apr 05, 2021 at 12:11:06PM -0700, Isaac J. Manjarres wrote:
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
>> index 9006397b6604..a3bbf7e310b0 100644
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
> Huh, so this was 'unsigned long' before and, given that the 
> pgsize_bitmap
> on the domain is also unsigned long, then I think that's fine. So using
> that would mean you don't need GENMASK_ULL for this guy either.
> 
> Will
Thanks, I will address this in version 4 of the series.

--Isaac
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
