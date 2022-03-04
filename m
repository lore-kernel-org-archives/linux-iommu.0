Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68BEC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 20:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE7C82A5D;
	Fri,  4 Mar 2022 20:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFZY3ZoyeWtN; Fri,  4 Mar 2022 20:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A4B582A56;
	Fri,  4 Mar 2022 20:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABD9C0012;
	Fri,  4 Mar 2022 20:22:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B8BAC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 20:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 820EF4168F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 20:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDUhaZCobA0X for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 20:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F72E41688
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 20:22:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C907DB82B77;
 Fri,  4 Mar 2022 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D2BC340F4;
 Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646425321;
 bh=drtAVc9iu/9kuWtQa9BBtKt9Vne7cc+zjPAYGhDvYRc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=uGKvNQs0VgiBauASMTlKebGz0/T77FYskLsJd9PIc3AQTjAn0+IRmu7FI0WzlNJSj
 AF85MecRPTf9uaIQnmbLbutx/18VNOz9pJNhiqLUvohNexwNQMq4Rd7n7SRDYdrUGI
 OTgYfcnGJUuHxQBIn7+Gp3K3zdX2Ir3UHDIBzBlJ+jnqqGpme2hBwmO59SF4ZhQsO0
 QIQLJLhMA85e8FdecyjGMgHQj3rO5h2/kUeE/BI1Lf9INNk58c/ZgELG5+gaypmfzf
 Wtdl0ytHaLtfWoWz7nwMqR5RmCLs/VefdVYHM/XQWI/UqzxXx8zaouCEpUCu2RxZvq
 TkuYLFgE3iVFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 60B9FE6D4BB; Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <YiIxynRjN0sRPIju@8bytes.org>
References: <YiIxynRjN0sRPIju@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YiIxynRjN0sRPIju@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.17-rc6
X-PR-Tracked-Commit-Id: 9826e393e4a8c3df474e7f9eacd3087266f74005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f509f5971bca38eeb543186131fb1b404262023
Message-Id: <164642532139.24805.4276557423762311140.pr-tracker-bot@kernel.org>
Date: Fri, 04 Mar 2022 20:22:01 +0000
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

The pull request you sent on Fri, 4 Mar 2022 16:35:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f509f5971bca38eeb543186131fb1b404262023

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
