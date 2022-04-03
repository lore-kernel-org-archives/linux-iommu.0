Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0FEC433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Apr 2022 20:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4731560E90;
	Sun,  3 Apr 2022 20:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zabLuGyya0NG; Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CFD460E37;
	Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1355BC002C;
	Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 603E0C0012
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 20:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4016660E90
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 20:30:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3CijBxSsdTe for <iommu@lists.linux-foundation.org>;
 Sun,  3 Apr 2022 20:29:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0559960E37
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 20:29:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4F65CB80D9D;
 Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182E0C340F0;
 Sun,  3 Apr 2022 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649017795;
 bh=X+YipOC4djr1WC3mQUko9z9VG1qrdrcKvPLWWWHZ5Zg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=qqMc+px+pX3kfFCvNAh3nqfCI19v0wXIaIpVgrid+CCewVPXxk0sfOdCADN25b0EP
 Tf/8rCICX+xNcJZP0u6tPveZtyakbQcO15e5rCwVFx9OUET5FJl2wkMM0LXSkFcjhT
 Jxyrkx6x0n3vEo/V6SfJvJ93zTaShU97IVOsYzO8wrM+qxMetnDpx18IDJ9OOEGt9v
 brVj+kNEEkSd7+TmJuF+AHLwNWrr0aJFyas1ohB+2lNEPFBFVMZrsTOJUh9TYLXSlS
 EcMxitYdjWfoHZUW132TuYaWiM6c9CqW5MsB1c9GxpP3iziBjA1655ZBTH19By2eMQ
 OHB0VOaz/b5yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 03894E7BB0B; Sun,  3 Apr 2022 20:29:55 +0000 (UTC)
Subject: Re: [GIT PULL] second round of dma-mapping updates for Linux 5.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <YkmRl8McdwST4cII@infradead.org>
References: <YkmRl8McdwST4cII@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YkmRl8McdwST4cII@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.18-1
X-PR-Tracked-Commit-Id: 4fe87e818ea492ade079cc01a31d088e445f8539
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63d12cc30574eec9241932cefa17a21df3afd8d0
Message-Id: <164901779500.22329.10916440707320962926.pr-tracker-bot@kernel.org>
Date: Sun, 03 Apr 2022 20:29:55 +0000
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

The pull request you sent on Sun, 3 Apr 2022 14:22:47 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63d12cc30574eec9241932cefa17a21df3afd8d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
