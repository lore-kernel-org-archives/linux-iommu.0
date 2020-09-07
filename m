Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC88C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 19:05:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2FF20C09
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="LsH3Ubg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2FF20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=connolly.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CEFD22010C;
	Mon,  7 Sep 2020 19:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QG4lTEcm7PLG; Mon,  7 Sep 2020 19:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EA9E42001D;
	Mon,  7 Sep 2020 19:05:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBDF1C0859;
	Mon,  7 Sep 2020 19:05:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9864FC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 761FD20788
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZ8jnWpaPeH8 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 18:57:56 +0000 (UTC)
X-Greylist: delayed 00:08:24 by SQLgrey-1.7.6
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 8E33E20535
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:57:56 +0000 (UTC)
Date: Mon, 07 Sep 2020 18:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
 s=protonmail; t=1599504570;
 bh=ZMHD4pb6eLStL6z+QcCKhBat0AGNJTHtmNZKUYPW0hY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=LsH3Ubg/tM9MN5ir7XnQ3WLf4Kqa4Ok1LVbdc5dOfguhK0D8iWntPUNb2AniTkGTr
 t6yGWMWn/awny7KYCVDQBarjP4Vi8tM8RXu67wPoDYP+mLUrqSnec1IuJEjL6LF5B4
 4xqRBsAXkGGnM0YxTvto9ec9z8+VlwPh1j+w36W4=
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
From: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader
 mappings
Message-ID: <c1cce546-0c49-05e2-8c54-5f343db273c8@connolly.tech>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 07 Sep 2020 19:05:14 +0000
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
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
Reply-To: Caleb Connolly <caleb@connolly.tech>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-09-04 16:55, Bjorn Andersson wrote:
> Based on previous attempts and discussions this is the latest attempt at
> inheriting stream mappings set up by the bootloader, for e.g. boot splash or
> efifb.
>
> Per Will's request this builds on the work by Jordan and Rob for the Adreno
> SMMU support. It applies cleanly ontop of v16 of their series, which can be
> found at
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
>
> Bjorn Andersson (8):
>    iommu/arm-smmu: Refactor context bank allocation
>    iommu/arm-smmu: Delay modifying domain during init
>    iommu/arm-smmu: Consult context bank allocator for identify domains
>    iommu/arm-smmu-qcom: Emulate bypass by using context banks
>    iommu/arm-smmu-qcom: Consistently initialize stream mappings
>    iommu/arm-smmu: Add impl hook for inherit boot mappings
>    iommu/arm-smmu: Provide helper for allocating identity domain
>    iommu/arm-smmu-qcom: Setup identity domain for boot mappings
>
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
>   3 files changed, 205 insertions(+), 42 deletions(-)
>

Tested on the OnePlus 6 (SDM845), allows booting with display enabled.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
