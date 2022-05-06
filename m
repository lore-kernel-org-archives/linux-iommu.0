Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED715C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97508408E3;
	Fri,  6 May 2022 16:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urukhARqzeMx; Fri,  6 May 2022 16:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B61E40323;
	Fri,  6 May 2022 16:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF38C0039;
	Fri,  6 May 2022 16:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BED0C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6170D408E6
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oz_DQ6A-pIf6 for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:07:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C63F40308
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 02ADA61EE3;
 Fri,  6 May 2022 16:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CDDC385AA;
 Fri,  6 May 2022 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651853232;
 bh=MeBbu6N7dXVwXZN6bbf3yJI1WmMW2WD3trOSa9i+xMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DiaqGgX96HvQ+tSWrsEI1Cgno44W6jhf3OyuasjIe2Qdguhtlox/qf3WkLaoDH/Kv
 Bj0yCp7hteVFKQF/Tsbx8HZhxpy9dnSFt/SZ2TTqI7LXfy2TVaNCiFILSOKYOS29KD
 vdCJ+bQKTC0ZrQEgaBpXOjED5wsIyylAVKVycF79Hi37C1N8uXdLuDM2q3lFRhrCBI
 Fz3vTSDE1okJ2RLp/PlSwSdfGPgzdbJ8R1//86qyx0EwFIFJ8tVU13rSGVEeOipxLW
 nwMz+oefRJdcsI28UOhRM4UKjWVvgwU7ZyHaLQc6UA/rRqZwHNduQmugDQSP7RJvel
 YxQS4+wWmoShw==
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu-qcom: Add SC8280XP support
Date: Fri,  6 May 2022 17:07:01 +0100
Message-Id: <165185088097.2781523.14572195434290854630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220503163429.960998-1-bjorn.andersson@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
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

On Tue, 3 May 2022 09:34:27 -0700, Bjorn Andersson wrote:
> This adds the compatible for the Qualcomm SC8280XP platform and associate the
> Qualcomm impl in the ARM SMMU driver to it.
> 
> Bjorn Andersson (2):
>   dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
>   iommu/arm-smmu-qcom: Add SC8280XP support
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
      https://git.kernel.org/will/c/38db6b41b2f4
[2/2] iommu/arm-smmu-qcom: Add SC8280XP support
      https://git.kernel.org/will/c/d044023e219d

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
