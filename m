Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18366C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 17:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92C0A40D81;
	Tue, 31 May 2022 17:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Udobr-uSGWWZ; Tue, 31 May 2022 17:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7861640D24;
	Tue, 31 May 2022 17:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58607C0039;
	Tue, 31 May 2022 17:05:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E04A1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB8BE40D7D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMfbBEqqkNqe for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 17:05:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E49DE40D24
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:05:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2650BB810E8;
 Tue, 31 May 2022 17:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3B52C3411D;
 Tue, 31 May 2022 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654016742;
 bh=geYWQQF2NYACb3iPTD3PzJTMEWfwSAAWrcsQxD9KdH8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=lKLxP3glFKdN7vWQ1oIyIDYTTpcIGuVEe810ZWnLUq2GoSUbnqk/l718hHwyR7jZE
 afCjjLhIgMg1Lvra+M34ogqzfoG8R0Rpn4cS5YNXMp7vS5wxa4KULsRDc8NJJpuMgi
 kpEDw35QZm9Sz4w0RHNZIxfM0fGK1kma37cdaipAgkltYZIWdq2PnrUOyceEfHNKFK
 zp72UWpmf1RnypyEe1StVfCyoozLdgcejgIrzufQiUOH2goUYQm/GXgptjYhVZX6c1
 mFqvzREAgnLoC6RErwDSF2Szbca7ctNby1jUUCgushHxi9Qe183v5wow9cPVwgfdMK
 On0DnF29OynhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C1C27F0383D; Tue, 31 May 2022 17:05:42 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <YpYMFlGhQQOt914S@8bytes.org>
References: <YpYMFlGhQQOt914S@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpYMFlGhQQOt914S@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.19
X-PR-Tracked-Commit-Id: b0dacee202efbf1a5d9f5cdfd82049e8b5b085d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5
Message-Id: <165401674278.5782.17258985925276129478.pr-tracker-bot@kernel.org>
Date: Tue, 31 May 2022 17:05:42 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
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

The pull request you sent on Tue, 31 May 2022 14:37:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
