Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA19C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 11:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E11DC60D90;
	Tue, 10 May 2022 11:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ola6BE2Vl8-A; Tue, 10 May 2022 11:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD8D760B48;
	Tue, 10 May 2022 11:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98B45C0039;
	Tue, 10 May 2022 11:33:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2EF4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9003560F57
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KKuhjuZ8QB5 for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:33:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 95EC560B48
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:33:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DAFEBB81CFB;
 Tue, 10 May 2022 11:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18ACC385C6;
 Tue, 10 May 2022 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652182402;
 bh=Al4HaPN8KLVAWTTn5oD+jKewg9gXqt8HYust9TpV1kw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fbRyOLdqFG/tceW3K2IL6FfLwOnSmqojn93X+3zmnqBlHrXV3gxpkRIgmBE2xV9X0
 HIVvOoIz6dmoOQrxX8AnLBmrV+u/afpQfzlxh+4eoI2mwh/3z8EOa9n5qTRrAZxh6H
 adNuN3B0BSuAdR7Y7SUqNL277KxsO/7MDwVGBnKJ+QA56dfoq6nKiI0MoD0nc3u9yZ
 LxFCnBRsfO/ugMBKxnvj/aeA44aHpkJQ0D6pncCI1ALGxSLhClj0MdO8WyR9WXDFiE
 wb2MZs9p02sVxjJrWjNUoB4sFyQKO22IE678a7PKabTVq00zk41VTJwGuvYphL9j1w
 6vJkhSHE16A1Q==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Force identity domains for legacy binding
Date: Tue, 10 May 2022 12:33:13 +0100
Message-Id: <165218049230.3350360.14414230028321512162.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9805e4c492cb972bdcdd57999d2d001a2d8b5aab.1652171938.git.robin.murphy@arm.com>
References: <9805e4c492cb972bdcdd57999d2d001a2d8b5aab.1652171938.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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

On Tue, 10 May 2022 09:38:58 +0100, Robin Murphy wrote:
> When using the legacy "mmu-masters" DT binding, we reject DMA domains
> since we have no guarantee of driver probe order and thus can't rely on
> client drivers getting the correct DMA ops. However, we can do better
> than fall back to the old no-default-domain behaviour now, by forcing an
> identity default domain instead. This also means that detaching from a
> VFIO domain can actually work - that looks to have been broken for over
> 6 years, so clearly isn't something that legacy binding users care
> about, but we may as well make the driver code make sense anyway.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Force identity domains for legacy binding
      https://git.kernel.org/will/c/628bf55b6204

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
