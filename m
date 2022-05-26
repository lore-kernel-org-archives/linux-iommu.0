Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5A5C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 02:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 767EB424CB;
	Thu, 26 May 2022 02:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8TE6C5Pj2iY; Thu, 26 May 2022 02:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0938B424CC;
	Thu, 26 May 2022 02:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0EC2C0039;
	Thu, 26 May 2022 02:59:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A26F7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 02:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83185424CB
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 02:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zrPOaFIXqewr for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 02:59:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16D1041D32
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 02:59:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5044DB81EC3;
 Thu, 26 May 2022 02:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1D21C385B8;
 Thu, 26 May 2022 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653533962;
 bh=00LMgoPWEFmCnxipynpG3BFblBalQPIF1H2NyYkl7lM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=hH088AjP/rh9vOL2vZ+DCoftDkucsJaUBraKBVSRdRz0LT/ptQ085IyfMBLZULkwA
 hTMA8SqkTGtx3a0KHM+cWgV0z1Ovh1+aX/iwMCD0QkEusSIhgNtNGfk6i7/GQhICA8
 s1YKGX0RbTsz3fvu6Q42KaLDD3DQ8zNnxh0L3uXeeVDSQxsAPCsdQ/kbp6bZBd9afD
 jP8E7m5t6Gi1AmDfoI2hb+tg7ZuRdyacj5VrRwp/cgnCfez9wxzgsCYZrx8T8DoOel
 8hNtKMObq6GXICafk3uY2OoGo6XJkW+Y2xvICarnbp58XPe1UqJI0Eney3NHjIy2Hi
 wdOC77lg49k+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DF57DE8DBDA; Thu, 26 May 2022 02:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yo5t+HAiFg5jaSEt@infradead.org>
References: <Yo5t+HAiFg5jaSEt@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yo5t+HAiFg5jaSEt@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.19-2022-05-25
X-PR-Tracked-Commit-Id: 4a37f3dd9a83186cb88d44808ab35b78375082c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f306ea2e18568f693f7763d1c2178f349ae8f31
Message-Id: <165353396191.29187.2933220820599232248.pr-tracker-bot@kernel.org>
Date: Thu, 26 May 2022 02:59:21 +0000
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

The pull request you sent on Wed, 25 May 2022 19:57:12 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f306ea2e18568f693f7763d1c2178f349ae8f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
