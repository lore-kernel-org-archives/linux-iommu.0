Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487DEC433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 23:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6F5760C1A;
	Mon,  2 May 2022 23:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2yF4vQJAVGTE; Mon,  2 May 2022 23:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB98D60C04;
	Mon,  2 May 2022 23:07:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B780C0039;
	Mon,  2 May 2022 23:07:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D570C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 23:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CD6981427
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 23:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLs-SzaABj2y for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 23:07:27 +0000 (UTC)
X-Greylist: delayed 00:43:11 by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 955F881417
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 23:07:27 +0000 (UTC)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88]
 helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1nleSf-0005bu-2T; Tue, 03 May 2022 00:24:09 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>,
	hjc@rock-chips.com
Subject: Re: [PATCH] drm/rockchip: Refactor IOMMU initialisation
Date: Tue,  3 May 2022 00:24:03 +0200
Message-Id: <165153020898.255051.11175155714135351840.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <94eee7ab434fe11eb0787f691e9f1ab03a2e91be.1649168685.git.robin.murphy@arm.com>
References: <94eee7ab434fe11eb0787f691e9f1ab03a2e91be.1649168685.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-rockchip@lists.infradead.org, s.hauer@pengutronix.de,
 iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org
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

On Tue, 5 Apr 2022 15:32:50 +0100, Robin Murphy wrote:
> Defer the IOMMU domain setup until after successfully binding
> components, so we can figure out IOMMU support directly from the VOP
> devices themselves, rather than manually inferring it from the DT (which
> also fails to account for whether the IOMMU driver is actually loaded).
> Although this is somewhat of a logical cleanup, the main motivation is
> to prepare for a change in the iommu_domain_alloc() interface.

Applied, thanks!

[1/1] drm/rockchip: Refactor IOMMU initialisation
      commit: 421be3ee36a497949a4b564cd1e4f7f9fe755f57

Additionally tested on rk3288, rk3399 and px30.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
