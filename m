Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E0C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 02:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5501607FE;
	Fri, 25 Mar 2022 02:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utUy5RsNqyqK; Fri, 25 Mar 2022 02:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFFD56076A;
	Fri, 25 Mar 2022 02:54:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93AD9C0012;
	Fri, 25 Mar 2022 02:54:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 759F8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F72F842CE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvSJcTiRkkmO for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 02:54:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC377842C3
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 02:54:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4E78616DF;
 Fri, 25 Mar 2022 02:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124BEC340EC;
 Fri, 25 Mar 2022 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648176885;
 bh=aB8ixEDccysOkhO3MI3u1uG75P52wt124Z7/JgpBN2c=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=KYODxL2KbHbHE5eC/DO1/ixJj0ldVNQAfPNunv1tikIki09b0yieE3r9+PE60xQAi
 yWisRtxQyS3gZQUxPMEaD86xUPiR5APGUl4R8h70DAL5ypXSa4vogOrBWVX+xYdac9
 A6rrOV4Jkp4KP4VtJ/EDOIvnzu79Siz1wi3wd+mrDmzWHNFNs8SLzhzocyyNYYEt0M
 TUe0grLRsccqU/gJz04At7CIKv9CSWNAXRBrxmfdC88VuMWhSpAZhTCzKE9QzJRkEc
 TRA6REY+FZPmbQ88MiUMwrktuYouW5e3j7gC3BvSSpqZFF4S4T+kfvSR2wvc8kk2tE
 l9/K5U2Zu407g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F284EE7BB0B; Fri, 25 Mar 2022 02:54:44 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <YjxCJKNbtfcyV/6A@8bytes.org>
References: <YjxCJKNbtfcyV/6A@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjxCJKNbtfcyV/6A@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.18
X-PR-Tracked-Commit-Id: e17c6debd4b2d2d474074f83946f8c6522587566
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34af78c4e616c359ed428d79fe4758a35d2c5473
Message-Id: <164817688498.22503.13146962183170452786.pr-tracker-bot@kernel.org>
Date: Fri, 25 Mar 2022 02:54:44 +0000
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

The pull request you sent on Thu, 24 Mar 2022 11:04:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34af78c4e616c359ed428d79fe4758a35d2c5473

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
