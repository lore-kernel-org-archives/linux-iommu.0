Return-Path: <SRS0=J3yl=YT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD7DCA9EBD
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 10:45:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593C3214DA
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 10:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuZAVF8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593C3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1731A3EE;
	Sat, 26 Oct 2019 10:45:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 281529D
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 10:45:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 155C413A
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 10:45:06 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.4-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572086705;
	bh=wdh+9CC4zUjH3UODJiT2QF2al9L/PsZbfHr3V3iKhlQ=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=MuZAVF8EFlEWDixY58ZGWLsdUpqIVP2UMFen0yfcCE8Zl3WTWeqAt+LAiuxvNYIRw
	KqWCDP4q7DA/z3JuYa/oRrq+DKAFvWTwB8cIVdi3JcDn4WsRChZPZZsRimgh/xI6Hz
	yybxqTjSu27VCnp1atiWQaq5m0DmwGpBLqwkhct8=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191026054551.GA5340@infradead.org>
References: <20191026054551.GA5340@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026054551.GA5340@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.4-2
X-PR-Tracked-Commit-Id: 9c24eaf81cc44d4bb38081c99eafd72ed85cf7f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964f9cfaaee31588b1f1a23edee8bed94136452a
Message-Id: <157208670584.20302.7834835768159432653.pr-tracker-bot@kernel.org>
Date: Sat, 26 Oct 2019 10:45:05 +0000
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

The pull request you sent on Sat, 26 Oct 2019 07:45:51 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964f9cfaaee31588b1f1a23edee8bed94136452a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
