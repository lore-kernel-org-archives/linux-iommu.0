Return-Path: <SRS0=GEJm=WV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF13C3A5A4
	for <iommu@archiver.kernel.org>; Sun, 25 Aug 2019 03:15:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33407217F4
	for <iommu@archiver.kernel.org>; Sun, 25 Aug 2019 03:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR/rkFO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33407217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D8154B6D;
	Sun, 25 Aug 2019 03:15:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3AD59AF0
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 03:15:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ECCE9A7
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 03:15:06 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566702906;
	bh=mPe3odrknBIFfF0lqHZtL9q2YQNnQ+0AuopSqTNkTbM=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=oR/rkFO644feU+z4crnl3ubSvYZmCexFNEafhkRdDyk6GrkjtnoJhZ0Kx9/LQZnwU
	qjqw35eo9RcpQjl/iguP523Omqf9wsVDxVqhGF0fzx/UQAFmcgxeLAIEyUwKrJo0MX
	Uq+SILhGG94Ywy8C93W2Z006GEAAo2TM+RL8XcXY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190824225010.GA18590@infradead.org>
References: <20190824225010.GA18590@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190824225010.GA18590@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.3-5
X-PR-Tracked-Commit-Id: 90ae409f9eb3bcaf38688f9ec22375816053a08e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e67095fd2f727c35e510d831c588696f2138a1bb
Message-Id: <156670290674.4585.269087204039323980.pr-tracker-bot@kernel.org>
Date: Sun, 25 Aug 2019 03:15:06 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The pull request you sent on Sun, 25 Aug 2019 07:50:10 +0900:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e67095fd2f727c35e510d831c588696f2138a1bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
