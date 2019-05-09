Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC58C04AB3
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 16:25:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A6521848
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndCLGOlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A6521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6BDBEDD0;
	Thu,  9 May 2019 16:25:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0D978CBC
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 16:25:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CF515831
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 16:25:13 +0000 (UTC)
Subject: Re: [GIT PULL] DMA mapping updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557419113;
	bh=AsLoE8maqrC84xuyzNDEGIn3ooBziPzN27H1NlD7Of0=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=ndCLGOlVB5hhd0GvzQKyR1fu88VowsDofoFtyzsuGQV6PqX+8eRhm2bu+xcPjDkcY
	iNAdzL7GJUeFegV5moO6CgG45DNsKT+ab78Q7PmqoHztAwh9YneX1lzLYlIIJwb5Oo
	EVxGydB/iC40imXqSWfS5+Z+TsHb4RbgC0UXRiVg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190509071634.GA604@infradead.org>
References: <20190509071634.GA604@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509071634.GA604@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.2
X-PR-Tracked-Commit-Id: 13bf5ced93775ffccb53527a9d862e023a9daa03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddab5337b23c99777d7cfb39c0f8efe536c17dff
Message-Id: <155741911358.30533.13545205602641074733.pr-tracker-bot@kernel.org>
Date: Thu, 09 May 2019 16:25:13 +0000
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

The pull request you sent on Thu, 9 May 2019 09:16:34 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddab5337b23c99777d7cfb39c0f8efe536c17dff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
