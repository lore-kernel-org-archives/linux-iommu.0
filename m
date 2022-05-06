Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A71EC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B1F81D5A;
	Fri,  6 May 2022 16:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vFAG51zNRJn; Fri,  6 May 2022 16:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC6B882486;
	Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8586C0039;
	Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16333C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04DEB8282C
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jOGj2uhqoefA for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:07:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B4F682486
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3BFC9B83709;
 Fri,  6 May 2022 16:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0BC385B1;
 Fri,  6 May 2022 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651853240;
 bh=HYc8kR/H5TxbxplFH1FuhV35mhkrf7IJ8g9tiQWF6ig=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DP78+2lyclWRCUDsSlbplfm8Yc6EkWzZUMXPXJ32GgeiYA0Gvln8APd9HU1j+3vC7
 v5FSpm3qmFLrImkMdgerZ6Ty6bfc7GqfJ5e+yg3b2wfkTsS5/ocvfzUIjvGAKAKnTy
 /HMqwKPZv+McZxgufERSgP4DrH+8fWdj+WbudTSORsqYncxZS5WLKs4/IELJdIqclp
 HrmCxzcGAUG5S66/uVEjaEFccbht60Yh26TMIuzU7WrZQJjPkD0TfJtwFWhsOOCcI0
 IUMZcdF9oCG8k0Aj8ZhNXkoozjmd0DstA/RhMUWc9/g58aUU8w9zuP4xPJMOBxpaYI
 G7wa+yoMTB5ig==
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Support Tegra234 SMMU
Date: Fri,  6 May 2022 17:07:04 +0100
Message-Id: <165185099765.2781901.13785452169185170055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429082243.496000-1-thierry.reding@gmail.com>
References: <20220429082243.496000-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, kernel-team@android.com,
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

On Fri, 29 Apr 2022 10:22:40 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi Joerg,
> 
> this is essentially a resend of v2 with a Acked-by:s from Robin and Will
> added. These have been on the list for quite a while now, but apparently
> there was a misunderstanding, so neither you nor Will picked this up.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] dt-bindings: arm-smmu: Document nvidia,memory-controller property
      https://git.kernel.org/will/c/c02bda09f91a
[2/3] dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
      https://git.kernel.org/will/c/95d5aeabda00
[3/3] iommu/arm-smmu: Support Tegra234 SMMU
      https://git.kernel.org/will/c/5ca216155b5e

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
