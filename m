Return-Path: <SRS0=497D=MR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358FC4338F
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 17:49:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BAA60F45
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8BAA60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B4356069D;
	Sun, 25 Jul 2021 17:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PkCcNGLEnuXh; Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A812606BE;
	Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B66FC0010;
	Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8856C000E
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C203E82B51
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nja8SVLaqbUQ for <iommu@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 17:49:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D40082A8F
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:49:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id B536D60F11;
 Sun, 25 Jul 2021 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627235386;
 bh=7pETpqCU40IXUaFx5pvopBByYFHbdyxIvzK1JeQNbOE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=bAQCAKKRRS1boVg3TYyp36sWLiQ9I0SeVoZnKTd43M5Jyl6chC/02FbtB5btZVZKx
 f6FCc4VrH8jW+Q8+l5eF153iunNOFVFCX/jCUpEA5XJpaHyTiPPGpoawvk1cHBO7dv
 i+qBzZwCtK8IoPX1tz63A7JGpdSVjAT5sW+H8Q0gNQMxj14C4vGV3P+JSSiAhuKKYY
 LV67XUTU979vdwYNxE19knooUuqsn8J3ZW4QLyXbhTEHMb0rvrdhbJOXiwZxkbKud7
 nFI1xIuzCNleGLciNcv9A2zZ5Ob7KFS4zyAWhx2AESIWXGkTLo2EfhAUeKmXYF9jcC
 E1mgnOQhEYaQQ==
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <YPz+qQ6dbZVDbMwu@infradead.org>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YPz+qQ6dbZVDbMwu@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.14-1
X-PR-Tracked-Commit-Id: 40ac971eab89330d6153e7721e88acd2d98833f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04ca88d056b44efee1e7635c74c0be3705efc72c
Message-Id: <162723538670.30584.9150662147851995225.pr-tracker-bot@kernel.org>
Date: Sun, 25 Jul 2021 17:49:46 +0000
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

The pull request you sent on Sun, 25 Jul 2021 08:03:21 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04ca88d056b44efee1e7635c74c0be3705efc72c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
