Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB8C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6EF23A54
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6EF23A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75FBF87399;
	Fri, 22 Jan 2021 13:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPy7xBXr2I3P; Fri, 22 Jan 2021 13:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B2F7D8738F;
	Fri, 22 Jan 2021 13:49:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD2C2C08A1;
	Fri, 22 Jan 2021 13:49:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15F44C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D568A2E0FF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id waI4Ztz+zcYP for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id EFF7D226F3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B522F23A53;
 Fri, 22 Jan 2021 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611323380;
 bh=LGurerklXvR4NnJ2R8hS26LPpzDeKKOYA+gAwfQoSdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k7F5A79gPeylu8LP+hiFK16LlhWxqX7PQuZQXrumdef0GPdCK/AQMnUwxq1tdbEsu
 5Nm3cpEVRksO6fmVPZM4UgZpBYwmce1fFrAvpZKsZBLuvaMYolqDxnqmQFZQ9A3jOQ
 IMavJ6SASKap66Tag9gRQatH9bMF3d9QO8UiLFnSJdQjiwUqGsAWGLDW/ugzk7QUq6
 h+41OC/bj9BWNZAUoe9gqCYnteRgoPTqHN7YjfM6bXkQghmAGu/gasnzdMHhNJJxyV
 ybEWzGbOnLthYyMyALLby4bxjigillVvvZAicIN9S2eAVsNN2ughyucXtPjj0Rej9D
 U5R2YA5nl0pCQ==
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X
 compatible
Date: Fri, 22 Jan 2021 13:49:31 +0000
Message-Id: <161132114998.228840.14370401178606658365.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
References: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
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

On Wed, 20 Jan 2021 17:40:04 -0800, Bjorn Andersson wrote:
> Add compatible for the ARM SMMU found in the Qualcomm SC8180x platform.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
      https://git.kernel.org/will/c/9cde12ba07ce
[2/2] iommu/arm-smmu-qcom: Add Qualcomm SC8180X impl
      https://git.kernel.org/will/c/1a7180ff81aa

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
