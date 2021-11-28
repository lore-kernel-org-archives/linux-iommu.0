Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96FBC433EF
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 15:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42F8B832EB;
	Sun, 28 Nov 2021 15:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_IzYi5mj3lt; Sun, 28 Nov 2021 15:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADA74832EA;
	Sun, 28 Nov 2021 15:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF96C001C;
	Sun, 28 Nov 2021 15:46:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92ED9C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 15:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 692EC40260
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 15:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvCZmXrzxzN1 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 15:46:39 +0000 (UTC)
X-Greylist: delayed 00:08:16 by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C6544025B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 15:46:39 +0000 (UTC)
Received: from mail.kernel.org (unknown [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C24C60FF2;
 Sun, 28 Nov 2021 15:38:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 86C736023B;
 Sun, 28 Nov 2021 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638113901;
 bh=3udFigij+Mxrmq6hY+BjxOVZFE6nlg3w7jRkh/g87Co=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=g7U6/wzwWHvojN4rYp66iB2npDaQGZKTjueEt6LWDy2iClcp4+AHJ2TWe+Hv3kKDW
 qbM2uk2niCwiW90620S1YXlM8GBpaaY+5N7fpR7ELxicHmd5lU8THpwRkPzneC85bG
 rtFBsU330vMIeopnbVPS9cAd6eGxYxi13iZ5WDu+nACv6tPQZJyGuxyzro+T8VJFla
 eXE5z0pz4sloh3qdt1z6We+HeAtYOTXyFa4FkXHq5z8k6vjy31FIp3T5F/wRSr/KF4
 IUWxWVA7VM+xZQvOtC6znyGGdmdSH3jNxz4bg58WTrIK8xBIMy4VZy7WZ3opPp2Hch
 QKP4KrKtsXclw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CFA0609D5;
 Sun, 28 Nov 2021 15:38:21 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <YaOFCyGBRITPRyaa@8bytes.org>
References: <YaOFCyGBRITPRyaa@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaOFCyGBRITPRyaa@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.16-rc2
X-PR-Tracked-Commit-Id: 86dc40c7ea9c22f64571e0e45f695de73a0e2644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0757ca01d944001254a94ac1b25ced702a1e9ac5
Message-Id: <163811390145.31138.15681907790046498142.pr-tracker-bot@kernel.org>
Date: Sun, 28 Nov 2021 15:38:21 +0000
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

The pull request you sent on Sun, 28 Nov 2021 14:32:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0757ca01d944001254a94ac1b25ced702a1e9ac5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
