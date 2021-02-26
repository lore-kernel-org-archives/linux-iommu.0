Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3031C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C26601FA
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C26601FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9D583E62;
	Fri, 26 Feb 2021 08:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JeXR8E8UiUs; Fri, 26 Feb 2021 08:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A34883E55;
	Fri, 26 Feb 2021 08:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 351DCC000B;
	Fri, 26 Feb 2021 08:06:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC8C1C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 08:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id CABD743372
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 08:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id OwSo0tNaPvyt for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:06:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m42-2.mailgun.net (m42-2.mailgun.net [69.72.42.2])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 26A1A43364
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 08:06:38 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1614326800; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=suGyscuJaBSINRblbI0tkgmdetepJU5RPn17qcvFJFQ=;
 b=hc9i6wIk/jKsHz0cPFQ3Qss9xsBT0ZrL2AH6BnYtc2/xqWnd5MZ2m9KqvKFHoKMEB218kMXg
 rm6c7saSDy2ItZN0OG6YEA0Twi2CNTZ4+A0VBDe3zTsRnWK+sFsqeKZjtULSDN6Gn2AspDN0
 MOqLGipQJl+52DDFdBe+8We3Pko=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6038ac0aa27401dc65a88a6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 08:06:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 92E8BC43466; Fri, 26 Feb 2021 08:06:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 96856C433CA;
 Fri, 26 Feb 2021 08:06:33 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 26 Feb 2021 13:36:33 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Jordan Crouse <jordan@cosmicpenguin.net>, Jordan Crouse
 <jcrouse@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <20210225180652.zwhyjhff3jxm7hcw@cosmicpenguin.net>
References: <cover.1614247752.git.saiprakash.ranjan@codeaurora.org>
 <ed9bedef1546879c5b5e9f0f3f6d4667ec6b4fc4.1614247752.git.saiprakash.ranjan@codeaurora.org>
 <20210225180652.zwhyjhff3jxm7hcw@cosmicpenguin.net>
Message-ID: <22bbfd6bb27491adeed18f5d24c42b70@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
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

On 2021-02-25 23:36, Jordan Crouse wrote:
> On Thu, Feb 25, 2021 at 03:54:10PM +0530, Sai Prakash Ranjan wrote:
>> Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
>> both implement "arm,mmu-500" in some QTI SoCs and to run through
>> adreno smmu specific implementation such as enabling split pagetables
>> support, we need to match the "qcom,adreno-smmu" compatible first
>> before apss smmu or else we will be running apps smmu implementation
>> for adreno smmu and the additional features for adreno smmu is never
>> set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
>> and adreno smmu implementing "arm,mmu-500", so the adreno smmu
>> implementation is never reached because the current sequence checks
>> for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
>> specific impl and we never reach adreno smmu specific implementation.
>> 
>> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>> 
>> Its either this or we add a new compatible for adreno smmu 
>> implementing
>> arm,mmu-500 like "qcom,sc7280-adreno-smmu-500".
>> 
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index bea3ee0dabc2..7d0fc2c8e72f 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -345,11 +345,11 @@ struct arm_smmu_device 
>> *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>>  {
>>  	const struct device_node *np = smmu->dev->of_node;
>> 
>> -	if (of_match_node(qcom_smmu_impl_of_match, np))
>> -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
>> -
>>  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>>  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>> 
>> +	if (of_match_node(qcom_smmu_impl_of_match, np))
>> +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
>> +
> 
> It would be good to add a comment here explaining the order here so we
> don't accidentally reorganize ourselves back into a problem later.
> 

Sure its better, will add it.

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
