Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BDC38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 14:05:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CB62083B
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 14:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m14WVEGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FF7987434;
	Thu,  7 May 2020 14:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJDXFGRvMXfl; Thu,  7 May 2020 14:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FCB2873D6;
	Thu,  7 May 2020 14:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0797C0865;
	Thu,  7 May 2020 14:05:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8352EC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 14:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F6CF884C2
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 14:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0duA25vvlGwW for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 14:05:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7DEA18854D
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3FCB2083B;
 Thu,  7 May 2020 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588860309;
 bh=WSIu7Z5FH7Emv/oKuxSvVTdQZPPJK253Dm+oh4ENuGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m14WVEGgqdY1BxkifsScKEe4PKnbecF54jWpO3WQvo76eVuDN39EOCgIiCQzGcK+W
 +pa/U27p31NMVqGymANvioEXgq3KJtJPrve852KmfbwHjm3SMPons+m2enqrwX3v/4
 kzw9D2KzefXg71rr3X5MGEHlREkOpIsMRpKQHFxs=
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Sibi Sankar <sibis@codeaurora.org>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv4 0/6] iommu/arm-smmu: Allow client devices to select
 identity mapping
Date: Thu,  7 May 2020 15:04:55 +0100
Message-Id: <158885770316.87552.2164546926384187579.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
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

On Tue, 21 Apr 2020 00:03:48 +0530, Sai Prakash Ranjan wrote:
> This series allows DRM, Modem devices to set a default
> identity mapping in qcom smmu implementation.
> 
> Patch 1 is cleanup to support other SoCs to call into
> QCOM specific  implementation.
> Patch 2 sets the default identity domain for DRM devices.
> Patch 3 implements def_domain_type callback for arm-smmu.
> Patch 4 sets the default identity domain for modem device.
> Patch 5-6 adds the iommus property for mss pil.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/6] iommu: arm-smmu-impl: Convert to a generic reset implementation
      https://git.kernel.org/will/c/64510ede3684
[2/6] iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back
      https://git.kernel.org/will/c/232c5ae8a361
[3/6] iommu/arm-smmu: Allow client devices to select direct mapping
      https://git.kernel.org/will/c/0e764a01015d
[4/6] iommu/arm-smmu-qcom: Request direct mapping for modem device
      (not applied)
[5/6] dt-bindings: remoteproc: qcom: Add iommus property
      https://git.kernel.org/will/c/23cf515c6042
[6/6] arm64: dts: qcom: sdm845-cheza: Add iommus property
      https://git.kernel.org/will/c/68aee4af5f62

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
