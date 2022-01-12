Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A57CC433F5
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 19:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 267ED83ED9;
	Wed, 12 Jan 2022 19:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hi2u_NZ88NwS; Wed, 12 Jan 2022 19:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 028B583EB9;
	Wed, 12 Jan 2022 19:12:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D87D9C0030;
	Wed, 12 Jan 2022 19:12:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A5BC001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 19:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E53540504
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 19:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8aClLNSPdqh for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 19:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 260D4404CA
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 19:12:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7AD89B820CD;
 Wed, 12 Jan 2022 19:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7D9C36AEA;
 Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642014728;
 bh=CDo7uly22Fc1kgATpN7dPjU3sEevu035m4wPXRN1K7M=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=UpUQATtvFF4gJeXe/RJbuFo2Ych1qwN0JZtTYiKAObF5p5CVsCrG96Fxk91rg6xo5
 HqVQk6TIvVYQwg5jPA+a6RD1fr7h5ur068zSG5cIqHHxtb7oeV15uace9KO3j18uzL
 grySlBUxmDPMra8C/hGSpV0jAW4RN53UPCJj9nWFed4C8rh1GZ8E7JS5CO506NDaAI
 iu8ZlnoEM7eKsexqBu31+1yb4UFectdG9haOr7z9Ywf7qqdafHWlLgjLsB9e7YItYR
 1wJH1RnRBfl8oUZW6iCufnNayf7u4RIO5Syz+RqPtD4/jrI2yVIy5H1CLc2dQ6QY6E
 VnTodxnM6p0ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 35DE1F6078C; Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ydx+6rmjq2giOC/b@infradead.org>
References: <Ydx+6rmjq2giOC/b@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ydx+6rmjq2giOC/b@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.17
X-PR-Tracked-Commit-Id: f857acfc457ea63fa5b862d77f055665d863acfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e7b69654724c72bd3219b71f58937845dca0b2b
Message-Id: <164201472820.2601.1205408391529229477.pr-tracker-bot@kernel.org>
Date: Wed, 12 Jan 2022 19:12:08 +0000
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

The pull request you sent on Mon, 10 Jan 2022 19:46:02 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e7b69654724c72bd3219b71f58937845dca0b2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
