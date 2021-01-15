Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA57CC433E9
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 18:58:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB2923AA9
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 18:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB2923AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BCF486B68;
	Fri, 15 Jan 2021 18:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8QaAklxg9knu; Fri, 15 Jan 2021 18:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3430586B3A;
	Fri, 15 Jan 2021 18:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E96AC0893;
	Fri, 15 Jan 2021 18:58:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FA36C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33938203A0
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lq5WfQicyx66 for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 18:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 7157E20385
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 18:58:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id EE7A623A6C;
 Fri, 15 Jan 2021 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610737082;
 bh=4JjoI0+xHLeSfQpYYCNlnGBtgj7Hl02nV+poDWdHDew=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=chk4b/cPZEVM3GJ/sN8YA7Si7rGdTxemSf9XxpjYMYNFz3OoN3iX6rwX4PnkWuC8p
 FI4Xxhm1warQQPpGSvQOwlJsBwUuFWfw3MTyYJzpaB7m6KZ0JSycKXep1wIgnltqn9
 8n7XMRuMk0rOWAJ6DIa27RefGe8OhwYmH9YvYiJewMW3YtwQh9nqGM48PfFaXTBzLS
 zsWy0IjcwcehaFdzZe/7nnkE74sJ3fRUbX3wtFZpp7yduyTzq5Yj6RKj8yG+QOou3X
 9TpvjSozw2zQevTARuLfzgvLUEDjG6I5f9MjiBpIcaw61C6kCerLVOGc9qc9trLaU2
 kRaDVEbPDE6lw==
Subject: Re: [GIT PULL] IOMMU fixes for -rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210115112619.GA14253@willie-the-truck>
References: <20210115112619.GA14253@willie-the-truck>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210115112619.GA14253@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/iommu-fixes
X-PR-Tracked-Commit-Id: 694a1c0adebee9152a9ba0320468f7921aca647d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aec71cd9c1f251ef17eae5f898c10133d49421d
Message-Id: <161073708194.18503.10792478323149655072.pr-tracker-bot@kernel.org>
Date: Fri, 15 Jan 2021 18:58:01 +0000
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, torvalds@linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>
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

The pull request you sent on Fri, 15 Jan 2021 11:26:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aec71cd9c1f251ef17eae5f898c10133d49421d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
