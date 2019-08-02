Return-Path: <SRS0=q6Nl=V6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E30C433FF
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 16:07:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0C42087C
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRVohKBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0C42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 115BD11F9;
	Fri,  2 Aug 2019 16:07:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5D3FEEAD
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 16:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C78989D
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 16:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] arm highmem block I/O regression fix for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761911;
	bh=igOIKq+ei4WvgHi1Gds5jsfkB5shN0k2mShOFzB380g=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=jRVohKBXeeWNbS0W3As0dvqjmdj0qIYL5CFkx8sJEGkCu1COe4jQWrJhZz3s60XXC
	e03tJGP79djfnsLoXSieyAftA7sEJE6URVamcP4bTmYJ5NakXLH20fGQTl0ZsXFjso
	I9tlAWUzZJ9Mi8SYIMHRbAP8G1gxAXwJeQcn22yA=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190801164702.GA26365@infradead.org>
References: <20190801164702.GA26365@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801164702.GA26365@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/arm-swiotlb-5.3
X-PR-Tracked-Commit-Id: ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 234172f6bbf8e26fa8407c4bbbf2a36da30d7913
Message-Id: <156476191100.27663.8840208654309225219.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2019 16:05:11 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	Roger Quadros <rogerq@ti.com>
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

The pull request you sent on Thu, 1 Aug 2019 19:47:02 +0300:

> git://git.infradead.org/users/hch/dma-mapping.git tags/arm-swiotlb-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/234172f6bbf8e26fa8407c4bbbf2a36da30d7913

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
