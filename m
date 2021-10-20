Return-Path: <SRS0=Y7tz=PI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0DC433FE
	for <iommu@archiver.kernel.org>; Wed, 20 Oct 2021 20:46:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108F4611ED
	for <iommu@archiver.kernel.org>; Wed, 20 Oct 2021 20:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 108F4611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC07640613;
	Wed, 20 Oct 2021 20:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wP64mWwiQwD0; Wed, 20 Oct 2021 20:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC5A2407AE;
	Wed, 20 Oct 2021 20:46:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A25E2C0011;
	Wed, 20 Oct 2021 20:46:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E91F6C000D
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 20:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C652682F32
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 20:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_s0ilwhUkno for <iommu@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 20:45:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81D8682C38
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 20:45:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 13DA760F93;
 Wed, 20 Oct 2021 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634762759;
 bh=wGDFcbqhC+mo+7WXiL1S5yCgXcI7n/gryCE5KuVFVW8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=T2d4PtJblAIGbEKFYOJvufiwm9TkOP9BQ3hCfz1SPAQ3Vo5JFtS8M+zUbQIwPo177
 2pJBvYljbo8sO0omeas8BCOMYphr2lqpO92/bm/7G6SrjkP10PoCN0HQAQ0VyCt9J2
 6FRs6lU3fsF1gxwoYr7iPi29aPfwar/U7o6WXyTPS6zjqhavpj6BuCwUr0BZXQZPV1
 xv+G7zSEmqBmYHcR/0MFPCqTNtgNY6vmBYv/delCEeO0Z1BQc1UYHtxslfL0tZZKCK
 zTL1lH8zYI16sG51qNuf1QJrlHVWVDY42iOGzEhN0WyPQzMvhM48AJjMd5DWJyWQ8h
 LhtJDV4tyqNcw==
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <YXBOiy+yS4pwwHeQ@infradead.org>
References: <YXBOiy+yS4pwwHeQ@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXBOiy+yS4pwwHeQ@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.15-2
X-PR-Tracked-Commit-Id: c2bbf9d1e9ac7d4fdd503b190bc1ba8a6302bc49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 515dcc2e02178ea8af2ea53b4ae5bdb6875b53ef
Message-Id: <163476275895.17864.16484280525762467197.pr-tracker-bot@kernel.org>
Date: Wed, 20 Oct 2021 20:45:58 +0000
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

The pull request you sent on Wed, 20 Oct 2021 19:14:51 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/515dcc2e02178ea8af2ea53b4ae5bdb6875b53ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
