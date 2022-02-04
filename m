Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA07C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 20:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF82660E65;
	Fri,  4 Feb 2022 20:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iAKM2GGL8W4h; Fri,  4 Feb 2022 20:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E06B16009C;
	Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0526C001A;
	Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14277C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E230740920
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rKoY6ChLFanD for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3182E40910
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0B66F614DB;
 Fri,  4 Feb 2022 20:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 717F9C340ED;
 Fri,  4 Feb 2022 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644006877;
 bh=6JwJ6tsccvHMF9copb7bHgjNK6VMkj2Rv75xBiejVjU=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=kvA3X2iGKtsD1DXajuNP0PNaSHZxgsXBDyEw2fB7tLDpH7a3PdWR1+uNeVj17Qrjb
 x/gpRE5s58Bl7ssq/MyGxTKRLdPnVNAT+TTyHK1V3Pra3LXXlC4kO6Ap3OahpJS3oM
 azaGNU3JDOux4i85iMRJGsKvrkSCSWvfhAPa5APn7JC8CwaiCB/vA/N1/mOJLcOvNI
 SHS7kYMFZcpxq82hbQHHnqmZPVzX8ZhuBhDnQiUkdKpWq5LaO6vAt27vatnRBAFz0C
 IMptA9VeDQe7JgG4wX1dQJ83wgV7A0FKrFHlzyzLIdya4QTyD653PfC9EYsA9nNYIk
 aJjkZzWLHiu3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 60F25C6D4EA; Fri,  4 Feb 2022 20:34:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yf1LITyFpv5yAUNJ@8bytes.org>
References: <Yf1LITyFpv5yAUNJ@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yf1LITyFpv5yAUNJ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.17-rc2
X-PR-Tracked-Commit-Id: 9b45a7738eec52bf0f5d8d3d54e822962781c5f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07cd9ac4c54039c99f98d30e83e23040e330fad5
Message-Id: <164400687739.31755.350959112073263932.pr-tracker-bot@kernel.org>
Date: Fri, 04 Feb 2022 20:34:37 +0000
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

The pull request you sent on Fri, 4 Feb 2022 16:49:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07cd9ac4c54039c99f98d30e83e23040e330fad5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
