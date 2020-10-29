Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB897C4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 18:34:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D22520825
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR/UvLGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D22520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BACF86B66;
	Thu, 29 Oct 2020 18:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qo5z83kPolvk; Thu, 29 Oct 2020 18:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A044286B5E;
	Thu, 29 Oct 2020 18:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 833A3C0859;
	Thu, 29 Oct 2020 18:34:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B3DAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 18:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 298E086B66
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 18:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qE78WzPzEjGY for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 18:34:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 10DC986B5E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D18EF20759;
 Thu, 29 Oct 2020 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603996465;
 bh=HQpIAjP1Wxod0EOhVucw1rVm/CQHnVqnXZFVdJMA/3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WR/UvLGkSG+GOYRLKdDaQJrwlOsEA87CShZ7hL/vdp4sFUNaF1//S4AZGBo/nmWIb
 Wy1Obxgr5/Q9CVI7nbHXzcWog/SlCul5Jviz1b68vpunbOjLcL8q1xlDXYSP/E4abW
 Kzm/LmaDH+FJt2ypzm8zFjBVQ/EML1jLdoa/9tA0=
From: Will Deacon <will@kernel.org>
To: Thierry Reding <treding@nvidia.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Clark <robdclark@chromium.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-qcom: Support maintaining
 bootloader mappings
Date: Thu, 29 Oct 2020 18:34:18 +0000
Message-Id: <160399513141.1314250.8831514745970142969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
References: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, kernel-team@android.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 19 Oct 2020 11:23:20 -0700, Bjorn Andersson wrote:
> This is the revised fourth attempt of inheriting the stream mapping for
> the framebuffer on many Qualcomm platforms, in order to not hit
> catastrophic faults during arm-smmu initialization.
> 
> The new approach does, based on Robin's suggestion, take a much more
> direct approach with the allocation of a context bank for bypass
> emulation and use of this context bank pretty much isolated to the
> Qualcomm specific implementation.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu: Allow implementation specific write_s2cr
      https://git.kernel.org/will/c/56b75b51ed6d
[2/3] iommu/arm-smmu-qcom: Read back stream mappings
      https://git.kernel.org/will/c/07a7f2caaa5a
[3/3] iommu/arm-smmu-qcom: Implement S2CR quirk
      https://git.kernel.org/will/c/f9081b8ff593

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
