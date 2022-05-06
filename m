Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A91AC4332F
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7B334109F;
	Fri,  6 May 2022 16:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmoMBLsFYl_3; Fri,  6 May 2022 16:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AB9840907;
	Fri,  6 May 2022 16:07:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E335C0039;
	Fri,  6 May 2022 16:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE8EC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E53360C12
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WXajQH2oaFY0 for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:07:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7786E607F2
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 39F69B83708;
 Fri,  6 May 2022 16:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF25C385AC;
 Fri,  6 May 2022 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651853234;
 bh=BsHciZyBB3xWL73AbdpSoqjZBacibPbLxJJS1iCzzGo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DWQxIIq/0mHGXbQ/aeYoYzuDxBDPx7lGe9dFAAyA3JljuxJSiGDn1nUMJ5TOB5aIC
 ueFp+Z7S88zvseAxKlVzyDSGLbt696Bff3Ux44stTw3NypDsmpWD5NmWd8AQxDXL7o
 M+2BsGhiek+i3UEejJQxecipQmCNUQjkaKLU7GHkkE0cxABK0JGxjWvZJmsiej5KB9
 dK2gJxhtN3ZJFJgFbLDoi44n35lzuaegHUq78gsNOSYT56ljSkCiMii58V09HBPJPt
 gCwOKgSK29cbFS2bF9qCoiMt/l7ap8kkeysSAOBOJHlMrQRW+ifHoZCG1fqcwtEprj
 D0AQeVIWnPbFw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-sva: Fix mm use-after-free
Date: Fri,  6 May 2022 17:07:02 +0100
Message-Id: <165185074006.2781108.9309916587764564938.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220426130444.300556-1-jean-philippe@linaro.org>
References: <20220426130444.300556-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
 zhangfei.gao@linaro.org
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

On Tue, 26 Apr 2022 14:04:45 +0100, Jean-Philippe Brucker wrote:
> We currently call arm64_mm_context_put() without holding a reference to
> the mm, which can result in use-after-free. Call mmgrab()/mmdrop() to
> ensure the mm only gets freed after we unpinned the ASID.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3-sva: Fix mm use-after-free
      https://git.kernel.org/will/c/cbd23144f766

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
