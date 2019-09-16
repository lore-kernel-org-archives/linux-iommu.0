Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310FC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F33206A4
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oOJd/K6U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BnzkZ5xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F33206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E6181396;
	Mon, 16 Sep 2019 09:48:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3EF581385
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:47:59 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0A56F8C8
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:47:58 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7E17861242; Mon, 16 Sep 2019 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627277;
	bh=6xJTrm/4FdPry2IWK41+EWTv6nMQOj/ZbrFAur8PRO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOJd/K6U/QhAzEQwROVPG7OTO4p5E/w79GkGRDyRodQ/uBssFLXpSRAbg2J0bcHeG
	/iUWsR9Qtv3V1jHpZrr5/IUiDFfuKPzHVlNL+3oAFMpeJeAJeKhSv9RcQnc7JGprS+
	akfmbirdq0hzlr6nd0CdRpBUZvbxspIBEzRpHOo4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id C86496119D;
	Mon, 16 Sep 2019 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627273;
	bh=6xJTrm/4FdPry2IWK41+EWTv6nMQOj/ZbrFAur8PRO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BnzkZ5xAtXRcLXXlbPbam90N4NbATKZatLt13fEJWeHAJ27LvZywd8tlw7vtz1HDL
	G3i9K34lbP713XcWXBK1EHzJBCZQL9aSDVNxHYHRPhZSZM9Ml5WkREXUMfQezPXvo0
	0PkOheXSl94mc55AkvD+b/yT6EC0nZ4m3PsXExxs=
MIME-Version: 1.0
Date: Mon, 16 Sep 2019 15:17:52 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
	hook
In-Reply-To: <5d72761c.1c69fb81.bf5be.09b4@mx.google.com>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-4-vivek.gautam@codeaurora.org>
	<5d72761c.1c69fb81.bf5be.09b4@mx.google.com>
Message-ID: <f61884eb2b71fe90a8b5dda6c33b1c9d@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org, agross@kernel.org,
	robin.murphy@arm.com, linux-arm-msm-owner@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Stephen,

On 2019-09-06 20:37, Stephen Boyd wrote:
> Quoting Vivek Gautam (2019-08-22 23:32:48)
>> diff --git a/drivers/iommu/arm-smmu-impl.c 
>> b/drivers/iommu/arm-smmu-impl.c
>> index 3f88cd078dd5..0aef87c41f9c 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -102,7 +103,6 @@ static struct arm_smmu_device 
>> *cavium_smmu_impl_init(struct arm_smmu_device *smm
>>         return &cs->smmu;
>>  }
>> 
>> -
>>  #define ARM_MMU500_ACTLR_CPRE          (1 << 1)
>> 
>>  #define ARM_MMU500_ACR_CACHE_LOCK      (1 << 26)
> 
> Drop this hunk?
> 
>> @@ -147,6 +147,28 @@ static const struct arm_smmu_impl arm_mmu500_impl 
>> = {
>>         .reset = arm_mmu500_reset,
>>  };
>> 
>> +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>> +{
>> +       int ret;
>> +
>> +       arm_mmu500_reset(smmu);
>> +
>> +       /*
>> +        * To address performance degradation in non-real time 
>> clients,
>> +        * such as USB and UFS, turn off wait-for-safe on sdm845 based 
>> boards,
>> +        * such as MTP and db845, whose firmwares implement secure 
>> monitor
>> +        * call handlers to turn on/off the wait-for-safe logic.
>> +        */
>> +       ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
>> +       if (ret)
>> +               dev_warn(smmu->dev, "Failed to turn off SAFE 
>> logic\n");
>> +
>> +       return 0;
> 
> return ret? Or intentionally don't return an error for failure?
> 
>> +}
>> +
>> +const struct arm_smmu_impl qcom_sdm845_smmu500_impl = {
> 
> static?
> 
>> +       .reset = qcom_sdm845_smmu500_reset,
>> +};
>> 
>>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device 
>> *smmu)
>>  {

Have addressed all your comments in v5.

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
