Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA29C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 06:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F163341756;
	Thu, 23 Jun 2022 06:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F163341756
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256 header.s=qcdkim header.b=g4MfCw2g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdOx5E08W8Cm; Thu, 23 Jun 2022 06:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 760CF4175E;
	Thu, 23 Jun 2022 06:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 760CF4175E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42B69C0039;
	Thu, 23 Jun 2022 06:02:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C824C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 06:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35C3740534
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 06:02:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35C3740534
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.a=rsa-sha256 header.s=qcdkim header.b=g4MfCw2g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id al63ojT2gSlV for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 06:02:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3D6440123
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3D6440123
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1655964148; x=1687500148;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kQy3/S0oY9NNHYhqGTErgRO6snEJoyWavRF1Xgt/bO4=;
 b=g4MfCw2gxccaWCTynxlaas5YvPU/l6M4jq2MMaXXMOFs6A6nf05NBlHH
 eLxk7R3CLllXrG4D+iu2bb0NKlAO/+QcPS+HRtCup6WGlDHEd0q9F5XQp
 NUQSowFUPhcOyVw0Ru0J0XPRNWDKjnf5ot5uYRylKFljugzus95MVVUG4 s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 23:02:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 23:02:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 23:02:26 -0700
Received: from [10.50.26.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 23:02:22 -0700
Message-ID: <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
Date: Thu, 23 Jun 2022 11:32:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 quic_guptap@quicinc.com, linux-arm-kernel@lists.infradead.org
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

On 5/26/2022 9:44 AM, Sai Prakash Ranjan wrote:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>
> Changes in v2:
>   * Use scm call consistently so that it works on older chipsets where
>     some of these regs are secure registers.
>   * Add device specific data to get the implementation defined register
>     offsets.
>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>   3 files changed, 146 insertions(+), 18 deletions(-)

Any comments on this patch?

Thanks,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
