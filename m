Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF07C433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 15:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C615409FF;
	Tue, 29 Mar 2022 15:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhKQVI8mRCCT; Tue, 29 Mar 2022 15:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1965E40920;
	Tue, 29 Mar 2022 15:57:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEA72C002C;
	Tue, 29 Mar 2022 15:57:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A704BC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A386860E7C
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3txNX5Coa77 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 15:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3B0960E19
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:57:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CCD3CB8181F;
 Tue, 29 Mar 2022 15:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A361C36AE2;
 Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648569430;
 bh=OALu3e4G6DViU7RlcvyUOAUs4LuErpcF4updO83j36I=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=stDNkXfYXXTn9ye2hIKKav9UKyb57sgQvl1g6qr+jHcu0J4LZy69mlXJkUQW40tHN
 SfsXNq6Rwdf7lwpPFg7Err47HI4BO3g2BcF03E4y0OZIhrq+gt4qA4RDZRIi90jqKS
 HrE1ncw+wY6OZW0eiJNvMvwp+jpOgdDm25SEbvr3A0buQ0aXT+Eq5hy37ic+rtEUNl
 V3hKs+lvuKiRTbueK+PMMqkCGjgDKyu1iC6W9VpkS9+/leHqn1Kn2CjbG1d1aQ9MOZ
 V9VH3UN+aUQAeAE6/q3J14y2koYUFXI5V7XJCFXPE46yCZWv5P3ozarJtHgSsPp8O2
 yWJGJnfbaYoww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 663CFEAC081; Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <YkMOoNaIpyQf/LKL@infradead.org>
References: <YkMOoNaIpyQf/LKL@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkMOoNaIpyQf/LKL@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.18
X-PR-Tracked-Commit-Id: 8ddde07a3d285a0f3cec14924446608320fdc013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ae2a143081fa8fba5042431007b33d9a855b7a2
Message-Id: <164856943041.29048.4286933805151487227.pr-tracker-bot@kernel.org>
Date: Tue, 29 Mar 2022 15:57:10 +0000
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

The pull request you sent on Tue, 29 Mar 2022 15:50:24 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ae2a143081fa8fba5042431007b33d9a855b7a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
