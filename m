Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF8C47082
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 02:43:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7126061026
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 02:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7126061026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CAA740340;
	Mon, 24 May 2021 02:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYxL4543ezWN; Mon, 24 May 2021 02:43:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE56B40336;
	Mon, 24 May 2021 02:43:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB6A0C000E;
	Mon, 24 May 2021 02:43:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE024C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 93ECB40333
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:43:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id qUOloRE1UBen for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:43:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id CB6E64034C
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:43:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1621824216; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3HgzMQsvg1nEqkCRO70Zl63RQaxdpKr9j62Ak5Bqp0Y=;
 b=q6eaQplIbWfhkWBfIl0xkpgHK9eqQS+s7JuzZ9oqnZ3BlSyXh9fEbrg23UXm6CMXO2Yis4iW
 VaDV653CTbkLqw6k3npZuB8FPW7e1rgcsm6eSq9jNQPNOmxuAHDRqHFU5//K7f3IlD9WR1wl
 YJ0aQbyMArVXSGaKzu5yVH0VcCQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60ab12d360c53c8c9d34857f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 May 2021 02:43:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3D0CAC43146; Mon, 24 May 2021 02:43:30 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 70F1DC433F1;
 Mon, 24 May 2021 02:43:29 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 24 May 2021 08:13:29 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv3 0/2] iommu/arm-smmu-qcom: Add SC7280 support
In-Reply-To: <cover.1618898456.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1618898456.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <664abf04654d78b08b118d11c7c03d99@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 saiprakash.ranjan=codeaurora.org@codeaurora.org,
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

Hi Will,

On 2021-04-20 11:34, Sai Prakash Ranjan wrote:
> Patch 1 adds the sc7280 smmu compatible.
> Patch 2 moves the adreno smmu check before apss smmu to enable
> adreno smmu specific implementation.
> 
> Note that dt-binding for sc7280 is already merged.
> 
> Changes in v3:
>  * Collect acks and reviews
>  * Rebase on top of for-joerg/arm-smmu/updates
> 
> Changes in v2:
>  * Add a comment to make sure this order is not changed in future 
> (Jordan)
> 
> Sai Prakash Ranjan (2):
>   iommu/arm-smmu-qcom: Add SC7280 SMMU compatible
>   iommu/arm-smmu-qcom: Move the adreno smmu specific impl earlier
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Gentle Ping!

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
