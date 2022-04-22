Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD50C433FE
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 10:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6532641A50;
	Fri, 22 Apr 2022 10:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJgwIna8KQ9y; Fri, 22 Apr 2022 10:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC09D41A2C;
	Fri, 22 Apr 2022 10:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9AA0C0039;
	Fri, 22 Apr 2022 10:55:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD238C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B473D41A50
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhXkmkRrXTtP for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 10:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F95941A2C
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:55:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5AE1CB82C28;
 Fri, 22 Apr 2022 10:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6CFC385A4;
 Fri, 22 Apr 2022 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650624943;
 bh=+cKfxQ5Un069trX//5/HF8F2JDcrdgw8jHpxYnApt5g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rm7Gq5OECvDvxwFdR7Xj8FjXlfDMY+5Eap+7ELRHNLNNM0V2gx6J8mIgeUyeRUBKF
 fSUqQOo+pWcBKISqrhoO8AkTvzpVynxmnve+BabpE20CoNhLVbYOdvbslVAD88N0bV
 e8AvYHfLwGG8FT6uVh1sh+XR2VApgPYU2sYLYPq7DZHF35+UxKz3bL/BuNpxPwP3oS
 Qqq/9sOp6BndsruFRqVN3PLts74vc0jR876+QwMk/gfLbl05TjX2heREryextp5AMj
 Gi6iHFIdtyzJomG5r1lV4ATpdixmakngvrpyiJYXk0DMQFbsDB+NVGFZz6VMFavWOg
 t41/kd86r+FYg==
From: Will Deacon <will@kernel.org>
To: jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com,
 Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Date: Fri, 22 Apr 2022 11:55:35 +0100
Message-Id: <165053012237.502660.4418683392126519698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220421081504.24678-1-amhetre@nvidia.com>
References: <20220421081504.24678-1-amhetre@nvidia.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 Pritesh Raithatha <praithatha@nvidia.com>, Snikam@nvidia.com,
 kernel-team@android.com
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

On Thu, 21 Apr 2022 13:45:04 +0530, Ashish Mhetre wrote:
> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> entries to not be invalidated correctly. The problem is that the walk
> cache index generated for IOVA is not same across translation and
> invalidation requests. This is leading to page faults when PMD entry is
> released during unmap and populated with new PTE table during subsequent
> map request. Disabling large page mappings avoids the release of PMD
> entry and avoid translations seeing stale PMD entry in walk cache.
> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
> Tegra234 devices. This is recommended fix from Tegra hardware design
> team.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
      https://git.kernel.org/will/c/4a25f2ea0e03

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
