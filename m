Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F07C4727F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6A3207E8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="e9imC3OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6A3207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 10A7E87030;
	Mon, 28 Sep 2020 12:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4TYe29vrGI8; Mon, 28 Sep 2020 12:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94EF087017;
	Mon, 28 Sep 2020 12:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75760C0889;
	Mon, 28 Sep 2020 12:29:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB9E9C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 756DA851FB
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X5iql-bJkrIo for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 12:28:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9489E847D5
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:28:57 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1601296137; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=xdne3b42R19CBmmD1o/ATM9Y99s0hNLFfkiTn9N47ps=;
 b=e9imC3OXTI0vMl2fIhYoSQeyObi4faFdHzqtaNoia3/HZYJ+wdEymuse3LXtRGgnw6hrIai+
 R3b0tnCH0ewIe6vqRo6vx8cul1bgGRKbAjaqJB8KU/fQFMn4DwiiOK9sjH5xRkUjdMyA5uef
 BRhIAw27K5ECiznOJMgK+nXBf6Q=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f71d70883f5ac99dbfb17a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 12:28:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id AC8E9C433FF; Mon, 28 Sep 2020 12:28:56 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C9D21C433C8;
 Mon, 28 Sep 2020 12:28:55 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 28 Sep 2020 17:58:55 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv5 5/6] iommu: arm-smmu-impl: Use table to list QCOM
 implementations
In-Reply-To: <d9b46e48-afa5-ceff-aee8-a75a95a3e459@arm.com>
References: <cover.1600754909.git.saiprakash.ranjan@codeaurora.org>
 <f2d079d46cee22f09f6eb7e6f874a9eaa786ec2a.1600754909.git.saiprakash.ranjan@codeaurora.org>
 <d9b46e48-afa5-ceff-aee8-a75a95a3e459@arm.com>
Message-ID: <ca9d546d27b358a03a8108c98a37e17b@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 2020-09-23 20:54, Robin Murphy wrote:
> On 2020-09-22 07:18, Sai Prakash Ranjan wrote:
>> Use table and of_match_node() to match qcom implementation
>> instead of multiple of_device_compatible() calls for each
>> QCOM SMMU implementation.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> index d199b4bff15d..ce78295cfa78 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>> @@ -9,6 +9,13 @@
>>     #include "arm-smmu.h"
>>   +static const struct of_device_id __maybe_unused 
>> qcom_smmu_impl_of_match[] = {
>> +	{ .compatible = "qcom,sc7180-smmu-500" },
>> +	{ .compatible = "qcom,sdm845-smmu-500" },
>> +	{ .compatible = "qcom,sm8150-smmu-500" },
>> +	{ .compatible = "qcom,sm8250-smmu-500" },
>> +	{ }
>> +};
> 
> Can you push the table itself into arm-smmu-qcom? That way you'll be
> free to add new SoCs willy-nilly without any possibility of
> conflicting with anything else.
> 
> Bonus points if you can fold in the Adreno variant and keep everything
> together ;)
> 

Sure I can get bonus points :)

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
