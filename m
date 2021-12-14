Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0984BC433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF558814AB;
	Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPtCZZJfby34; Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2513814B7;
	Tue, 14 Dec 2021 15:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A62C002F;
	Tue, 14 Dec 2021 15:18:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F232C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 705174022F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmmEizTqTVv3 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB3374024D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E1611614D9;
 Tue, 14 Dec 2021 15:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E44FC34605;
 Tue, 14 Dec 2021 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639495120;
 bh=mEbPeXsB67W9U6l/CDNJAqk9FaFgvYpMLADkkYtKvlc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=av6TKgBpidFRVzmgEir7OzPlWXZj4u6Yfzx66u2R1J43vHPxHv5dfUlQ+pw+2p7NQ
 1gb3dfZmMNGN4U/dcX92CABeMfhUuhQErd1TXmZSk2EgJvsXWWJS/RMx/MrBHXv9wC
 loT9TsoRSPhOCL8ZYDOBA5d4Jp3HobnugKl6AMcu1rLsuVV/ZwhVZSlvSqupIQMkwf
 1/R0rJ9W3x2sHrcAe1TY+n6VNaN5qE9et0Jim2s3B0loeeixng6r9S/JT8wT+Q14qA
 Z7y0Wnowj03jlX7gv60R9WFc/sC8/nMnJ74CA/phF8suXP2NCYBVAzCQfjMwPF1Gz+
 8xswokRRLyGLQ==
From: Will Deacon <will@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] Add support from SM8450 IOMMU
Date: Tue, 14 Dec 2021 15:18:16 +0000
Message-Id: <163949303736.2865377.9243428032755790961.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201073943.3969549-1-vkoul@kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
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

On Wed, 1 Dec 2021 13:09:41 +0530, Vinod Koul wrote:
> This adds the binding and support for IOMMU found in SM8450 SoC
> 
> Vinod Koul (2):
>   dt-bindings: arm-smmu: Add compatible for SM8450 SoC
>   iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation
> 
> Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
>  2 files changed, 2 insertions(+)
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      https://git.kernel.org/will/c/810d8cabaab5
[2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation
      https://git.kernel.org/will/c/cd76990c94bb

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
