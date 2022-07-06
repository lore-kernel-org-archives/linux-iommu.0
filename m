Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2976FC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 16:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F2AA41781;
	Wed,  6 Jul 2022 16:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F2AA41781
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iuBzYQOx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tj6Q0_LPq9SQ; Wed,  6 Jul 2022 16:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BCFE41717;
	Wed,  6 Jul 2022 16:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BCFE41717
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AFB8C0033;
	Wed,  6 Jul 2022 16:50:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23625C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 16:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBE2783123
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 16:50:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBE2783123
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iuBzYQOx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJWeGik9czNs for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 16:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0B43830E3
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0B43830E3
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 16:50:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 65CC0CE2140;
 Wed,  6 Jul 2022 16:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C588C3411C;
 Wed,  6 Jul 2022 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657126242;
 bh=0pOVIbCNmcN/nm8RoI711i6Sp2Cnnc7ILx8PHcMjOhc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iuBzYQOx/x119o/XKj4ad95UQ07vgkKRljfmsnYkmmrirzmMQjHuby+c86rVqRooj
 e62NitvEEgbRi/AkzT7cg7TPO5SEkCwOZhTG7qYwx9ou9gdEYHoqM7GHTxceb5Z/h0
 umIFpmDdt4evqfV+29PgG+EcUn3IfZqFDGD/sIoHZaLdcOTBCGKDbHcPwi54S2RqpB
 aXx9RrWGAtvmFF3iPDr7aaQfWbAYYGqMazIZgoSiRZEh1pgfK4M8g8OOlQ8fXf38YE
 VIXsvv+bqBqh/aL0z7bhbqJtvVoEYVcl4U3sRSY1zUXsLWJFf2MCnW9ZgAGMpF69bi
 bS877EsNGSq2Q==
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Clark <robdclark@gmail.com>,
 freedreno@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 dri-devel@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>,
 Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to
 the client list.
Date: Wed,  6 Jul 2022 17:50:30 +0100
Message-Id: <165710831607.931151.17780533895560931345.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
References: <20220614230136.3726047-1-emma@anholt.net>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 14 Jun 2022 16:01:35 -0700, Emma Anholt wrote:
> Required for turning on per-process page tables for the GPU.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
      https://git.kernel.org/will/c/3482c0b73073
[2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
      (no commit info)

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
