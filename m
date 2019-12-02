Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F23C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81B207DD
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLPdupFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E9EBF203B0;
	Mon,  2 Dec 2019 21:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9W0LrfoJ0+b; Mon,  2 Dec 2019 21:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 66D501FEAE;
	Mon,  2 Dec 2019 21:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60E28C1797;
	Mon,  2 Dec 2019 21:05:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494EBC087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 21:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 388F685D61
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 21:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HDGQQDTwyKca for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 21:05:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CEF8C85D41
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 21:05:20 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575320720;
 bh=xMwdGCFXqgM6gGkXnnWfZyZRAeOwG5qQZN43h0679/4=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=nLPdupFyuB4Ogeh/DKILu3yfl4TwqrwQNDa8oVfBJEHXFufcFHTQobLyuBNHBDMQz
 icqgnmz0YnrvcZzj1lvcnhFftEisvWWpi0DHTb2zkAa128fa3yvBvnQJnK2DwkGv9l
 DELDvSPvknys+r03ACjTOJzyU+qj3AHMBW2OeNQc=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191129120247.GA6874@8bytes.org>
References: <20191129120247.GA6874@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129120247.GA6874@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.5
X-PR-Tracked-Commit-Id: 9b3a713feef8db41d4bcccb3b97e86ee906690c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
Message-Id: <157532072053.29263.1440104284503498805.pr-tracker-bot@kernel.org>
Date: Mon, 02 Dec 2019 21:05:20 +0000
To: Joerg Roedel <joro@8bytes.org>
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

The pull request you sent on Fri, 29 Nov 2019 13:02:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1daa56bcfd8b329447e0c1b1e91c3925d08489b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
