Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D071CC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 18:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81AAB418F1;
	Wed,  4 May 2022 18:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-wN0A53EZHX; Wed,  4 May 2022 18:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2AE97418C8;
	Wed,  4 May 2022 18:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D7EC0039;
	Wed,  4 May 2022 18:24:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A01C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67D5E418F1
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pn53KN2FoaZX for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 18:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F5AD418C8
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:24:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 86BA7CE2907;
 Wed,  4 May 2022 18:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6630C385A4;
 Wed,  4 May 2022 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651688685;
 bh=liG3cYrRGvwUoDwAWoGZTFZHsaA/cjuphBPla3ASGr4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=IcIaAa0SXapMwNmAECOJ2njWBcGB8NcJoxGpTGGAAhSIcnVLM/44GNLc487aQsQXB
 UHhKlGxASMSCGrjro4FjGoiLHPyL4aWij4ynx6fTlBJ23TSABlPFrvGt9KiltnLy20
 rFhsM2p2IJ8YSpywhx3cATlI08np/uhH88gSzIpzPppdYN2E887dDVTSkOLd7FT4gc
 MJEdlsDhD/cfgMfz1m0LMyjx8ET8Vs3G05p01zTLWBj9SXzCTlhORFZchU34UAZxic
 II9WkVULbHqOPXI0EPTYZKX5zLC4piiVr+UP+9Z9fpYUJ7GoRVyYSWe1l6pm8HorKN
 iUIry776ssAXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B1035E5D087; Wed,  4 May 2022 18:24:45 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <YnKie9R0RhJsGMz9@8bytes.org>
References: <YnKie9R0RhJsGMz9@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YnKie9R0RhJsGMz9@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iomm-fixes-v5.18-rc5
X-PR-Tracked-Commit-Id: 392bf51946c2463436a1ba237c1ec5865b234825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7391ad3572431a354c927cf8896e86e50d7d0bf
Message-Id: <165168868571.19526.14478834492995171046.pr-tracker-bot@kernel.org>
Date: Wed, 04 May 2022 18:24:45 +0000
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

The pull request you sent on Wed, 4 May 2022 17:57:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iomm-fixes-v5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7391ad3572431a354c927cf8896e86e50d7d0bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
