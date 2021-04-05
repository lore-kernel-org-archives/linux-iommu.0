Return-Path: <SRS0=tsXo=JC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C9AC433B4
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 19:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C51613B3
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 19:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C51613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11708848D5;
	Mon,  5 Apr 2021 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6v27AFa1w0Dg; Mon,  5 Apr 2021 19:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 055CF848C5;
	Mon,  5 Apr 2021 19:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C686DC000B;
	Mon,  5 Apr 2021 19:22:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 820F9C000A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 762F6403FB
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id bLfWbTNlGbXl for <iommu@lists.linux-foundation.org>;
 Mon,  5 Apr 2021 19:22:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 61E1740273
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 19:22:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617650538; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=SshjAHv68WkNXAdrnKH+yCLNw1oLr15hUOwFl8hUIOc=;
 b=rVojRM2KfKAaKUfpOHOewVwATZ5qSibY9eR/FB9WFIoK5GVS5xCXSn8XiuC07WQ8TZgh9UqU
 LVohlPkJ1Yuveewh9puPZY+59hmxmGIFvnVWR8eTebS1XEbv832kPBNMhN6HyeAOzuAm+rl0
 35buOcXsMg/otq8ONgFzErBuv+o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 606b635fe0e9c9a6b61a074c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Apr 2021 19:22:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B10BFC43463; Mon,  5 Apr 2021 19:22:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0501AC433C6;
 Mon,  5 Apr 2021 19:22:05 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 05 Apr 2021 12:22:05 -0700
From: isaacm@codeaurora.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 07/12] iommu: Hook up '->unmap_pages' driver callback
In-Reply-To: <0d1a6c6b-c523-8868-99c5-51c6a1e40cc4@linux.intel.com>
References: <20210402013452.4013-1-isaacm@codeaurora.org>
 <20210402013452.4013-8-isaacm@codeaurora.org>
 <0d1a6c6b-c523-8868-99c5-51c6a1e40cc4@linux.intel.com>
Message-ID: <72cf6c7ceff1ffbf84f596c7f877d4ab@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 pratikp@codeaurora.org
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

On 2021-04-04 23:00, Lu Baolu wrote:
> Hi,
> 
> On 4/2/21 9:34 AM, Isaac J. Manjarres wrote:
>>   static size_t __iommu_unmap(struct iommu_domain *domain,
>>   			    unsigned long iova, size_t size,
>>   			    struct iommu_iotlb_gather *iotlb_gather)
>> @@ -2476,7 +2519,7 @@ static size_t __iommu_unmap(struct iommu_domain 
>> *domain,
>>   	unsigned long orig_iova = iova;
>>   	unsigned int min_pagesz;
>>   -	if (unlikely(ops->unmap == NULL ||
>> +	if (unlikely((ops->unmap == NULL && ops->unmap_pages == NULL) ||
>>   		     domain->pgsize_bitmap == 0UL))
> 
> This change should also be applied to __iommu_map() path. And perhaps
> could be:
> 
> 	if (unlikely(!(ops->unmap || ops->unmap_pages) || 
> !domain->pgsize_bitmap))
> 
Yep, that's correct. Thank you for spotting that; I've updated it in the 
latest series: 
https://lore.kernel.org/linux-iommu/20210405191112.28192-1-isaacm@codeaurora.org/T/#t.

Thanks,
Isaac
> Best regards,
> baolu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
