Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC45C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 19:23:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6102764E3F
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 19:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6102764E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EC1B86FEB;
	Sun,  7 Feb 2021 19:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1b9aW7CsJaP; Sun,  7 Feb 2021 19:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD4BA86FE6;
	Sun,  7 Feb 2021 19:23:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B58F0C0891;
	Sun,  7 Feb 2021 19:23:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D84F5C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 19:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C694B86FE2
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 19:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bHrIFBnnxSiU for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 19:23:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D3EA86FE6
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 19:23:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 99861614A5;
 Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612725789;
 bh=msh9b6gLp5g+4J4ZMnBvvfjYMhDNUKmW83TLyiQU/pg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=L4MYpxKvO/07DIedD1PTFzhgv4K0ApU/HyRSIxdKFW4N4K7srFu2NvmJW4mNSxIwc
 ay9ThT6/vC04OSU0GQnr/RZXL5XVRwyJ+wbXrGJdo3KX3cxKvzzNAdV449nkgqzZdP
 h9GL2bHJ0DMn8q6nLyuYnPHxlhpBcbHvpZJox7w6sYhwAxGzq0rKhh3SGPztDeJv7y
 Zrfu6SgXtgckO7NMZJDClrfKJuLxpAYdc8tVQrr7aARsNWf2piQfmGLdAVh0396sbv
 CmXoa4smgr7LE+qi2qwVNtuSiG4x7XIG3Pxbd0QVO7eS33P9i/V7dORQp9SH+w+h5j
 EKw4UzOGLv+CA==
Subject: Re: [GIT PULL] dma-mapping fix for 5.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <YCAUnVvH3rA24ZCa@infradead.org>
References: <YCAUnVvH3rA24ZCa@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCAUnVvH3rA24ZCa@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.11-2
X-PR-Tracked-Commit-Id: 9f5f8ec50165630cfc49897410b30997d4d677b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff92acb220c506f14aea384a07b130b87ac1489a
Message-Id: <161272578948.18997.5094577277878785721.pr-tracker-bot@kernel.org>
Date: Sun, 07 Feb 2021 19:23:09 +0000
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

The pull request you sent on Sun, 7 Feb 2021 17:26:05 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff92acb220c506f14aea384a07b130b87ac1489a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
