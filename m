Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BCC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 12:05:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B95E61215
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 12:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B95E61215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10F2742747;
	Mon,  4 Oct 2021 12:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGcnFfISbX0L; Mon,  4 Oct 2021 12:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7825E427A1;
	Mon,  4 Oct 2021 12:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 535E0C0011;
	Mon,  4 Oct 2021 12:05:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB96C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D4EA606A2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0t0q2cZH8r1 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A973760AEB
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 12:05:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F9261452;
 Mon,  4 Oct 2021 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633349151;
 bh=DczapP2V5LAVbduqo9lFtPbbyPM9o8Og7N2F7J1rbPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E1bhSjAGiVnD8Sr1dLFAeEW60oKwO02PjL0305VrZCXwBWUhmC/eo6SH/HNxrivu+
 pUxsq8TeBu1IYVi4keUKzx6ZC6VJDOza/fEfw5t1v7dvEcyE1cAI1camLiqwWD7YfR
 UV+aT7n1DGXLP3+Pyu/d3PS+p86UTJ25/SglDtVi1lSR+umo6Iv9nBHQMo5wbBpuPv
 0ZXS2n2M4Rlo5Sf0juaUOn+WSFER4kHEdCfvq6v1c5JW8BRDkQ62J+DDPDeeraEg0D
 C95SlKbZxKt0Lapa5Z7X92ldcjQMpKgzehn3tUHzQWkbTzbhFD4O+g4OM068GdnbD5
 SZfehzTy+d0PQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Perform some simple
 optimizations for arm_smmu_cmdq_build_cmd()
Date: Mon,  4 Oct 2021 13:05:36 +0100
Message-Id: <163334647414.1581641.3396518420865935764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818080452.2079-1-thunder.leizhen@huawei.com>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>
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

On Wed, 18 Aug 2021 16:04:50 +0800, Zhen Lei wrote:
> v1 --> v2:
> 1. Add patch 1, Properly handle the return value of arm_smmu_cmdq_build_cmd()
> 2. Remove arm_smmu_cmdq_copy_cmd(). In addition, when build command fails, out_cmd is not filled.
> 
> 
> Zhen Lei (2):
>   iommu/arm-smmu-v3: Properly handle the return value of
>     arm_smmu_cmdq_build_cmd()
>   iommu/arm-smmu-v3: Simplify useless instructions in
>     arm_smmu_cmdq_build_cmd()
> 
> [...]

Applied first patch only to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_build_cmd()
      https://git.kernel.org/will/c/59d9bd727495

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
