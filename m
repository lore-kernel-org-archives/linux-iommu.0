Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC00C433FE
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0F0F84BEB;
	Thu, 13 Jan 2022 00:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcQ_1xpZDZRs; Thu, 13 Jan 2022 00:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F8E881BB4;
	Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73E68C0030;
	Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2102C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 00:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B68B409C8
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 00:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k4ZsXyz-T-dU for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 00:45:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EA974034A
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 00:45:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 231CA61BB2;
 Thu, 13 Jan 2022 00:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A52C36AE5;
 Thu, 13 Jan 2022 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642034730;
 bh=wimvmhiPAXfDQnz1xnR6somYrEezfKXJbRcatQqc8/U=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=ojjQg8KQY1XYqtpgZiW9sKg8DNmt0Z1BKlv6NEt4SACejl37v9Ou3nd0lqhnU+bx9
 pvi/abtbceqVKUAiLjLNgeUhfgyWSUyP5zqfLoa+bOZJUhUBu8aJ1SucC9S7IJeehm
 Y+6MJXqLYvNhqFV9TpIEV1suhf9GFD+bKfIqsaa7+oebPAN2IC1e6ORb5q3QZr/Y+9
 j1QyACeU3PZx7tprxYkM0ZF7uK5tXP4kX+rOca7BQTplOPLb2do1NrFa6DF7X1V5wv
 BJcEO75tvznU8pIdwsgB/DWdtpPZjK5yYYa8iRNDUs2LRXYa3G2TU/GuHJkRenR0dk
 MmjTxHQ/Iiskw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 766D2F6078C; Thu, 13 Jan 2022 00:45:30 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yd8Jn2aUqblPfRvF@8bytes.org>
References: <Yd8Jn2aUqblPfRvF@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yd8Jn2aUqblPfRvF@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 iommu-updates-v5.17
X-PR-Tracked-Commit-Id: 66dc1b791c5839d64d261c8b40250a33e6da050b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13eaa5bda0df8f5c1c4f2a4fb4a0bc20787dcc68
Message-Id: <164203473047.19726.14219021764370905266.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jan 2022 00:45:30 +0000
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

The pull request you sent on Wed, 12 Jan 2022 18:02:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-updates-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13eaa5bda0df8f5c1c4f2a4fb4a0bc20787dcc68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
