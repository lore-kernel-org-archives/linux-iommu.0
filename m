Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369FC433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 21:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ACA4607EC;
	Fri, 24 Jun 2022 21:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ACA4607EC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N3hRhJGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAXm90P2NyAY; Fri, 24 Jun 2022 21:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E97B607B5;
	Fri, 24 Jun 2022 21:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E97B607B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1F92C0039;
	Fri, 24 Jun 2022 21:08:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC2BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 627E183EA0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 21:08:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 627E183EA0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=N3hRhJGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDXuX3kK-OdM for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 21:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95E2D83E96
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95E2D83E96
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D9FC62371;
 Fri, 24 Jun 2022 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914DCC34114;
 Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656104886;
 bh=fS+jx8P4aZnV8oKAi8Icer+oLHscd1uAmryuXFxfYyA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=N3hRhJGqk1QAU9gQ+DPM1qaDTRjQ/+eRY4Jf8isI+JyxWLawDjQvuqytVJsvhOMPV
 cH59Olhh6BBdVfxwiCVCCBArKaLz/rCklY0xBOQ4fU4IsZl6Y1kbZFdvdBBWwP97gc
 1SzJOf339KNxfrLUozURu6uxfUcMr+5OMFwYTV7gLotP+ScOJZ21W4NVIVkcN9cD+y
 4f9S95qmhzqhhcObbzgYSyKDG72T2dZd8sm0e2rjSdCmzyYNHFWJUpWFgI5g1GYZBN
 WhAIf4B+vF/VZ9B08aqcTstqFw2ylPPr4rNgoe687rpv+E88VbTln/vTrPawzFyiJ4
 eXvlIY3VLvnmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 7B6B3E737F0; Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <YrXCfic1ua0DdDBQ@8bytes.org>
References: <YrXCfic1ua0DdDBQ@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrXCfic1ua0DdDBQ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.19-rc3
X-PR-Tracked-Commit-Id: c242507c1b895646b4a25060df13b6214805759f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc3b8977e3747ab8aa54a0760dce5cdfa37ad4d6
Message-Id: <165610488648.13803.4593691440555303262.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jun 2022 21:08:06 +0000
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

The pull request you sent on Fri, 24 Jun 2022 15:56:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc3b8977e3747ab8aa54a0760dce5cdfa37ad4d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
