Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC66C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0805920679
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EasVfYhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0805920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4DBD876FE;
	Sat, 27 Jun 2020 20:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODogokEdkJEr; Sat, 27 Jun 2020 20:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2120E86DC5;
	Sat, 27 Jun 2020 20:25:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EABF6C0865;
	Sat, 27 Jun 2020 20:25:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A324C016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 20:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 10A5C86E97
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 20:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbDKDE3klRxx for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 20:25:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8EA6386ABB
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 20:25:13 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593289513;
 bh=9J040E0WnnbQGma5xN3YBHaW/r21PdJwI/TPcLGUJ0k=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=EasVfYhXqGsLNA/0DLHWXBkODWqVUoRomVJK3r61hPPMbNxBlLF/J6YrljHyc0cWm
 gofyPVLAFXvKmELbnHZmTKRxovKAgICDCfY/beCVnQyxUcLrCMKbjXhpqXg1Fc98en
 6xgtwDd4DvuK3oDHZZtw/O4+xoLdq8b45ZrA0r6E=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200627074902.GA2447682@infradead.org>
References: <20200627074902.GA2447682@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627074902.GA2447682@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-4
X-PR-Tracked-Commit-Id: 8e36baf97b252cdcafa53589e8227cbb1e85f0b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f05baa066d0f6a38f0624c28008fb2f53cd00e17
Message-Id: <159328951331.11719.13949831114777019739.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2020 20:25:13 +0000
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

The pull request you sent on Sat, 27 Jun 2020 09:49:02 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f05baa066d0f6a38f0624c28008fb2f53cd00e17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
