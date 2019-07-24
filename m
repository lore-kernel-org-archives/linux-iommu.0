Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E34C76191
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADC922387
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8z0/gkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADC922387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AB42F1149;
	Wed, 24 Jul 2019 17:10:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 021661141
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:10:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9C88EF1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:10:21 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988221;
	bh=SSUJBkfMlYhqcaHtLVBYuZ1a8giKpapCmr67x26gzNs=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=p8z0/gkLUJlg6QxzRk+oEILBD3aLN9GNPXnnKvgINWBARLv6w5lGSNCbArXdS+eVZ
	3muyYyAGv6NF/Gn89TaZGNyhenP2uCRuvy57RN/Bmc+WkahCMDmh7TpUmtXvdKNh2M
	n7IAIxmb/rb1eTNCOhwfNO3zYzWL2Z9qVv7HX8o0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190724144942.GA7893@infradead.org>
References: <20190724144942.GA7893@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190724144942.GA7893@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.3-2
X-PR-Tracked-Commit-Id: 06532750010e06dd4b6d69983773677df7fc5291
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2626876c24fe1f326381e3f1d48301bfc627d8e
Message-Id: <156398822137.2764.4372152990600257983.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2019 17:10:21 +0000
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

The pull request you sent on Wed, 24 Jul 2019 16:49:42 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2626876c24fe1f326381e3f1d48301bfc627d8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
