Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFFAC43334
	for <iommu@archiver.kernel.org>; Sun, 26 Jun 2022 17:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0047240643;
	Sun, 26 Jun 2022 17:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0047240643
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZSX9NqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uFlILw_RvYKC; Sun, 26 Jun 2022 17:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1125402F3;
	Sun, 26 Jun 2022 17:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1125402F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F3BC0032;
	Sun, 26 Jun 2022 17:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC04CC002D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 17:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8241660B29
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 17:36:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8241660B29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RZSX9NqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFJpSpbVbweE for <iommu@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 17:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97F0C60AE8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97F0C60AE8
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 17:36:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7E9A260EFB;
 Sun, 26 Jun 2022 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEC49C341CF;
 Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656264973;
 bh=c8nuLbyJ32noHL1fCGnmIXKIF1eDIKhRoZCQAUDC63M=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=RZSX9NqXyQ0uVqxCfiYbg6Apj2LxTWsLn5RsFZc/RqX8E85iRgCv2S6i8erMAhUD/
 fDdyqVY9RQw3/I0RMmib+Bqq0MNWgBzNh9OcbwW5pz1Q6AdzPkMGd0NRjFWJpbC7Jz
 FZUBVyQOHS5N5KEu4d/Esl425ryABdJA3g9ZKN4PYb48qtWVtbqfsLI8hGEgXCJbw1
 YO8wD8ftLsKGimbtmCUV5ZozV141VdnoAijJrh8pSqoFtTyRCgWXCpAhhmwkB4eXiu
 e/isl3b4xZMgeSKCDXYzsHGS8j8fd6fTROIwbEU9/d5uDZEXW5caQZPg7SfmeiQeXp
 pGg2N1WFjg5xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CC835E8DBEE; Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yrf0ItiAJ4cVfdPf@infradead.org>
References: <Yrf0ItiAJ4cVfdPf@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yrf0ItiAJ4cVfdPf@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.19-2022-06-26
X-PR-Tracked-Commit-Id: 3be4562584bba603f33863a00c1c32eecf772ee6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c898c67db6d7de1b1e7970cd16c45eaa46bd231b
Message-Id: <165626497383.22456.6991533634522697276.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jun 2022 17:36:13 +0000
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

The pull request you sent on Sun, 26 Jun 2022 07:52:34 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c898c67db6d7de1b1e7970cd16c45eaa46bd231b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
