Return-Path: <SRS0=f6HJ=CI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF1AC433E6
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0F020CC7
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1yUGSVPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AC1D32001F;
	Sun, 30 Aug 2020 19:15:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CgZFyCccNad; Sun, 30 Aug 2020 19:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D423620012;
	Sun, 30 Aug 2020 19:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6B32C07FF;
	Sun, 30 Aug 2020 19:15:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCAA4C0051
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 19:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B18662001F
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 19:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBwpM+VTCbdg for <iommu@lists.linux-foundation.org>;
 Sun, 30 Aug 2020 19:15:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 09C6920012
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 19:15:22 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598814921;
 bh=Br6e0WOYrr+RijueJYikk4WsoKHe7tRGYDDJjzH4Bek=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=1yUGSVPxtGF92RPCXyJFrI95SOXJphhwh5J/N7weO78YODFYqbx+3n6HlUpISRXk1
 BYdu8vROUwED6W299FNg7FjcjF0K9FcxM90dr/n9JxpXP+OmO8qzt46yfZudnQTD/E
 6IvOKOX1CUhdUbapCBGqzErTqU/WCI6sAFVd+K+w=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200830063135.GA1224156@infradead.org>
References: <20200830063135.GA1224156@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200830063135.GA1224156@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.9-2
X-PR-Tracked-Commit-Id: 892fc9f6835ecf075efac20789b012c5c9997fcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4011283a7d5d64a50991dd3baa9acdf3d49092c
Message-Id: <159881492180.11576.7289909181486653680.pr-tracker-bot@kernel.org>
Date: Sun, 30 Aug 2020 19:15:21 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The pull request you sent on Sun, 30 Aug 2020 08:31:35 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4011283a7d5d64a50991dd3baa9acdf3d49092c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
