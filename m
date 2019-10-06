Return-Path: <SRS0=q1eh=X7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C8FECE58B
	for <iommu@archiver.kernel.org>; Sun,  6 Oct 2019 18:20:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB70020835
	for <iommu@archiver.kernel.org>; Sun,  6 Oct 2019 18:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wbHaJZp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB70020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 66248491;
	Sun,  6 Oct 2019 18:20:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B151540B
	for <iommu@lists.linux-foundation.org>;
	Sun,  6 Oct 2019 18:20:16 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9779C27B
	for <iommu@lists.linux-foundation.org>;
	Sun,  6 Oct 2019 18:20:15 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping regression fix for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570386015;
	bh=vtKjxgXVhNL7l+sHOv51OqBy3Vg4AbXAWqnIMjxAo+w=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=wbHaJZp80I0Ip4ENaW65UOngeRJPbk4YBfNE295RSbMGcG2H8Hz7jl+v2E2HpjDZ2
	5kbcMNMOPrXEO24SJWhvaEFZ+JWYYy7kgsJ0xGVaeaa/h1I4+C4I6OfLTVQiSvohbM
	iGkIxlyI3whZwjs0pPiuzgzAK++eagDPKV9erYY0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191006162740.GA27870@infradead.org>
References: <20191006162740.GA27870@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191006162740.GA27870@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.4-1
X-PR-Tracked-Commit-Id: 2cf2aa6a69db0b17b3979144287af8775c1c1534
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cdb85df6061d001fffd09c6adfbcf20356615e2
Message-Id: <157038601134.10784.18310088469834465902.pr-tracker-bot@kernel.org>
Date: Sun, 06 Oct 2019 18:20:11 +0000
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

The pull request you sent on Sun, 6 Oct 2019 18:27:40 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cdb85df6061d001fffd09c6adfbcf20356615e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
