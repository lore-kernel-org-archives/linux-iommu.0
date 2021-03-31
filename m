Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E677C433DB
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 05:36:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354EE619CA
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 05:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354EE619CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDD76842DE;
	Wed, 31 Mar 2021 05:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AOkJQh-1cJA; Wed, 31 Mar 2021 05:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBEBA842A0;
	Wed, 31 Mar 2021 05:36:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9559AC000C;
	Wed, 31 Mar 2021 05:36:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD01C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 350FC40222
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 9qyC9jxEIKqp for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 05:36:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 0352B40223
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:36:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617168970; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+oGCsC1ouJXKIpz/YiMcdAWW3nf5h7TGBTr3/dw3daw=;
 b=RFQncK1aGLxMhPJTyY3vQH2E1QwaTKrMnmNv2+ZYtd/CxtgeqspacTU0hXNGyjeZqne5D373
 A2Yv9bF7oAPrcp1sXw25OpRR4SVkj+CubQfDtaG3V/Ca4mtQczGiqJQ8D+tAOWjnDc6P5cgF
 iBcJgJpy05zXPhtzxdRMOlTZT20=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60640a430a4a07ffda2013a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 05:36:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3E13CC433C6; Wed, 31 Mar 2021 05:36:02 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 66E45C433CA;
 Wed, 31 Mar 2021 05:36:01 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 30 Mar 2021 22:36:01 -0700
From: isaacm@codeaurora.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/5] iommu: Add an unmap_pages() op for IOMMU drivers
In-Reply-To: <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-3-isaacm@codeaurora.org>
 <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
Message-ID: <4c396e68a076f321ed3f406c2c875006@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, pratikp@codeaurora.org
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

On 2021-03-30 21:47, Lu Baolu wrote:
> On 3/31/21 11:00 AM, Isaac J. Manjarres wrote:
>> Add a callback for IOMMU drivers to provide a path for the
>> IOMMU framework to call into an IOMMU driver, which can call
>> into the io-pgtable code, to unmap a virtually contiguous
>> range of pages of the same size.
>> 
>> For IOMMU drivers that do not specify an unmap_pages() callback,
>> the existing logic of unmapping memory one page block at a time
>> will be used.
>> 
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>> Suggested-by: Will Deacon <will@kernel.org>
>> ---
>>   include/linux/iommu.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 5e7fe519430a..9cf81242581a 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -193,6 +193,7 @@ struct iommu_iotlb_gather {
>>    * @detach_dev: detach device from an iommu domain
>>    * @map: map a physically contiguous memory region to an iommu 
>> domain
>>    * @unmap: unmap a physically contiguous memory region from an iommu 
>> domain
>> + * @unmap_pages: unmap a number of pages of the same size from an 
>> iommu domain
>>    * @flush_iotlb_all: Synchronously flush all hardware TLBs for this 
>> domain
>>    * @iotlb_sync_map: Sync mappings created recently using @map to the 
>> hardware
>>    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and 
>> empty flush
>> @@ -245,6 +246,9 @@ struct iommu_ops {
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
>> +	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long 
>> iova,
>> +			      size_t pgsize, size_t pgcount,
>> +			      struct iommu_iotlb_gather *iotlb_gather);
> 
> Is it possible to add an equivalent map_pages() callback?
Yes, map_pages() can be implemented and can leverage a lot of the 
implementation
of unmap_pages(). The problem is that if you map several pages in one 
call, and then
encounter an error and have to rollback, you should do TLB maintenance, 
as iommu_map
does when it encounters an error. However, we can't call iommu_unmap 
from io-pgtable-arm
for example. We can call arm_lpae_unmap_pages() from the later patches, 
but that doesn't
solve the TLB maintenance issue. Do you have any thoughts on how to 
address this?
> 
>>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
>>   	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long 
>> iova,
>>   			       size_t size);
>> 
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
