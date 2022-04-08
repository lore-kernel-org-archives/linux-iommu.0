Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CFAC433EF
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 16:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE1D341756;
	Fri,  8 Apr 2022 16:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKGgTvb2R9X7; Fri,  8 Apr 2022 16:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C83241729;
	Fri,  8 Apr 2022 16:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B885C0033;
	Fri,  8 Apr 2022 16:49:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D990C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B47E41156
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOMy8vDrZLHs for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 16:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EBFD40292
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:49:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A187F620D6;
 Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08C9AC385A1;
 Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649436554;
 bh=9fDbVWN2d02f10S01kpofCopfEgC6rNw91l0eHgtu40=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=UXWsQPBqMlRVoEiDMGK33BZKXEYA0WitXv3ks+A1sUvBX0cknedEg5wV6QMUXQSUR
 fSQupqcV42/krB3HXULXCAa9X5+7rBdiYnxAAPaa1QdHzsYH32cnr5rJ+7Tc3INpnb
 YqB+Jf/DNjNCKrNckrMKswzF9hDzloGhu7MtVXuxJD4K7zeA2x+VuXhiTRHDZqFztL
 s1DvViq8iiq+CZRnQAWZiqewI/eMu097kGmX3N/dL8p9hV4tL8szHXCDhYx/KIdmJV
 jEuNu9QY2jl9F/9Z2Stc4AVcD5IiKCc3oRS9cB+NyrTmkXILh3fmaRggMVShGSCYZC
 WfOSw8ESUhWKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EA18DE6D402; Fri,  8 Apr 2022 16:49:13 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YlAh5jHAEl/wvb0g@8bytes.org>
References: <YlAh5jHAEl/wvb0g@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlAh5jHAEl/wvb0g@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.18-rc1
X-PR-Tracked-Commit-Id: 71ff461c3f41f6465434b9e980c01782763e7ad8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02994fd2da76b99d3f6777f5b3bdb5d2823a0fed
Message-Id: <164943655395.24432.17355773310620270569.pr-tracker-bot@kernel.org>
Date: Fri, 08 Apr 2022 16:49:13 +0000
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

The pull request you sent on Fri, 8 Apr 2022 13:52:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02994fd2da76b99d3f6777f5b3bdb5d2823a0fed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
