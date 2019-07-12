Return-Path: <SRS0=rccM=VJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF09C742D2
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 23:29:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D2320863
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 23:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIQARSDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2205E5CCC;
	Fri, 12 Jul 2019 23:29:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 01A1156C8
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 23:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3E085CF
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 23:20:16 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562973615;
	bh=qnCXxKnuLDiqmaF/EYePGbD5QlATJx8EvQv2n5KVACk=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=nIQARSDLgPTeaMXDyHW/AIQllozVGEiytmq1GKKGDTFecIzmS5iede/+htPO1gVR/
	PXghnrldPpC8nbkCUxQj/96REatDoMCplJBz7J5wudLReAMGiQbacnbY/eB+ILbj6N
	L0zqD9zxrAqyPqfWpzewCTaxSnIhGN1QobcDT8kg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190711135654.GA15312@infradead.org>
References: <20190711135654.GA15312@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711135654.GA15312@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.3
X-PR-Tracked-Commit-Id: 15ffe5e1acf5fe1512e98b20702e46ce9f25e2f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e3a25dc992dd9f3170fb643bdd95da5ca9c5576
Message-Id: <156297360989.22922.1378645851693477593.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2019 23:20:09 +0000
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

The pull request you sent on Thu, 11 Jul 2019 15:56:54 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e3a25dc992dd9f3170fb643bdd95da5ca9c5576

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
