Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0468C388F9
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 06:40:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD1220795
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 06:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mPabV0lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1220795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD3A28684A;
	Wed, 11 Nov 2020 06:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BhFUmqIRDyTP; Wed, 11 Nov 2020 06:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CDEA86072;
	Wed, 11 Nov 2020 06:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4427C0889;
	Wed, 11 Nov 2020 06:40:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2D5C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 06:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8C59D87394
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 06:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzcuwSdAzdDz for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 06:40:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B17C87393
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 06:40:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1605076853; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=G5QF7G064HtJTosA44a0rDZ6QvsJzebmYGAGLkBClkA=;
 b=mPabV0lH9AOI6uXWYgABbea+cmtYQIGqMRO0OVUYUcPwiVoy8EM03Ua79v2Cg0hsX2VjSm+h
 JsgbgDeoUtqCgeuaXa2cVwRPnJO1lvgvi6Y4454btK7jBbZQxMd8xkehAXHyRNY8KXmdRSGK
 wjIS4jUvapb90fnBlW2f2VIXNLg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fab877436968cecaf883e03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 06:40:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BF9B6C433FE; Wed, 11 Nov 2020 06:40:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B0E68C433C8;
 Wed, 11 Nov 2020 06:40:50 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 11 Nov 2020 12:10:50 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv7 2/7] iommu/arm-smmu: Add domain attribute for system
 cache
In-Reply-To: <20201110121835.GC16239@willie-the-truck>
References: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <a4e454630e57aedd9da6a4ba40c8e1c415bb6836.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <20201110121835.GC16239@willie-the-truck>
Message-ID: <b12284cce40225274c3b2d9aff7eed3a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 "Kristian H .
 Kristensen" <hoegsberg@google.com>, Robin Murphy <robin.murphy@arm.com>,
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

On 2020-11-10 17:48, Will Deacon wrote:
> On Fri, Oct 30, 2020 at 02:53:09PM +0530, Sai Prakash Ranjan wrote:
>> Add iommu domain attribute for using system cache aka last level
>> cache by client drivers like GPU to set right attributes for caching
>> the hardware pagetables into the system cache.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 17 +++++++++++++++++
>>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>>  include/linux/iommu.h                 |  1 +
>>  3 files changed, 19 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index b1cf8f0abc29..070d13f80c7e 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct 
>> iommu_domain *domain,
>>  	if (smmu_domain->non_strict)
>>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> 
>> +	if (smmu_domain->sys_cache)
>> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>> +
>>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>  	if (!pgtbl_ops) {
>>  		ret = -ENOMEM;
>> @@ -1520,6 +1523,9 @@ static int arm_smmu_domain_get_attr(struct 
>> iommu_domain *domain,
>>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>>  			*(int *)data = smmu_domain->non_strict;
>>  			return 0;
>> +		case DOMAIN_ATTR_SYS_CACHE:
>> +			*((int *)data) = smmu_domain->sys_cache;
>> +			return 0;
>>  		default:
>>  			return -ENODEV;
>>  		}
>> @@ -1551,6 +1557,17 @@ static int arm_smmu_domain_set_attr(struct 
>> iommu_domain *domain,
>>  			else
>>  				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>>  			break;
>> +		case DOMAIN_ATTR_SYS_CACHE:
>> +			if (smmu_domain->smmu) {
>> +				ret = -EPERM;
>> +				goto out_unlock;
>> +			}
>> +
>> +			if (*((int *)data))
>> +				smmu_domain->sys_cache = true;
>> +			else
>> +				smmu_domain->sys_cache = false;
>> +			break;
>>  		default:
>>  			ret = -ENODEV;
>>  		}
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 885840f3bec8..dfc44d806671 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -373,6 +373,7 @@ struct arm_smmu_domain {
>>  	struct mutex			init_mutex; /* Protects smmu pointer */
>>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>>  	struct iommu_domain		domain;
>> +	bool				sys_cache;
>>  };
>> 
>>  struct arm_smmu_master_cfg {
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b95a6f8db6ff..4f4bb9c6f8f6 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -118,6 +118,7 @@ enum iommu_attr {
>>  	DOMAIN_ATTR_FSL_PAMUV1,
>>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>> +	DOMAIN_ATTR_SYS_CACHE,
> 
> I think you're trying to make this look generic, but it's really not.
> If we need to funnel io-pgtable quirks through domain attributes, then 
> I
> think we should be open about that and add something like
> DOMAIN_ATTR_IO_PGTABLE_CFG which could take a struct of page-table
> configuration data for the domain (this could just be quirks initially,
> but maybe it's worth extending to take ias, oas and page size)
> 

Actually the initial versions used DOMAIN_ATTR_QCOM_SYS_CACHE
to make it QCOM specific and not generic, I don't see anyone else
using this attribute, would that work?

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
