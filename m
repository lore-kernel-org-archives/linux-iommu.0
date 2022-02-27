Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFB7C433EF
	for <iommu@archiver.kernel.org>; Sun, 27 Feb 2022 21:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15C0F4091F;
	Sun, 27 Feb 2022 21:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iazeiypzqsv9; Sun, 27 Feb 2022 21:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC3EA40914;
	Sun, 27 Feb 2022 21:22:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B57BBC0033;
	Sun, 27 Feb 2022 21:22:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 557CFC001A
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 21:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44AEF60ABE
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 21:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCwCW4SeXxLr for <iommu@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 21:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87F0C605EE
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 21:22:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 63CF461169;
 Sun, 27 Feb 2022 21:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4FDBC340F3;
 Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645996953;
 bh=qeI4SUv6sb2bQnVEchKRvZDw6ejRVEOF7WoawO5c3uw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=MXh2OxPxoErXiXIaewimNRZrUiJVd+5Clgu4ZFmOsVMHuHvl4ezDZbtTbSt7nx4Ah
 59xEBzrJi430UOV+dwYHqbTGycVgx7WIe7a+6EYBQKGCFXGHR7F/Snb5M4FWba63aJ
 jbLxiHIkbZIlFOjlkff/KbYCfikm/mmjRqls5k27oZZTsWzdwBGCTDnfFQHknd4Oo9
 ykgtfSItMz5xjh81P/lggeBXHFgO+OrwkTiWyOPe+Rn8CLZarKkWKKXGDGXecgQii2
 5WCVSbM53eOLSuxAT0Td2dxoaqRp7zNdOLRy8X+WBBaoKxwSXiG2iA6LAbHQivpfpu
 dnrcq9bHOFv+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 AFBA8EAC095; Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yhu+8trQqqmYLid3@infradead.org>
References: <Yhu+8trQqqmYLid3@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yhu+8trQqqmYLid3@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.17-1
X-PR-Tracked-Commit-Id: ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f3e84f8df66f1ac9d04b6d8093993c9bfd69e6
Message-Id: <164599695371.31011.11146855339411947265.pr-tracker-bot@kernel.org>
Date: Sun, 27 Feb 2022 21:22:33 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org,
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

The pull request you sent on Sun, 27 Feb 2022 19:12:02 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f3e84f8df66f1ac9d04b6d8093993c9bfd69e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
