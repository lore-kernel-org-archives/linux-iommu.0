Return-Path: <SRS0=SJ72=H2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E0C433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 18:46:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA364F10
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 18:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA364F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEA334ECFB;
	Wed, 24 Feb 2021 18:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hw31bMlvEWNU; Wed, 24 Feb 2021 18:46:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9111D4EC7B;
	Wed, 24 Feb 2021 18:46:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67E65C000A;
	Wed, 24 Feb 2021 18:46:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8571C0001
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 18:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6D9783EB5
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 18:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EF3NqDWUHFVf for <iommu@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C55383EB4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 133C164F14;
 Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614192395;
 bh=wccjhusve2dyjRL1HJyUVCR22tEUmUjmRphLm7hPUZo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=CyBcyNICojGga/2cp1jrQWDk7wTlDILUHfR4uJqgy48A2vMmnhOb1chOc8LeUE7Q4
 Tvx76G62UKdRL+07jZnoNMfCFwyNFnxWs0jhINVUN6nw8hPosUzlH9gvmUB3qUdLWu
 raIGcfaYjX7ZlOjYXfKwufL/DTdlzcCs208boOQlrUSfI8lV1vyVPPnQz0KOemsc3N
 yy6HfpA/kDHCbo/R4vI8yOpPZpfFeVvGqefcsjy3pqnB/JiJu+6Jts4oMQVwvuCnbQ
 GMvmKqHkCApyXeesliwJIbOuZWBnebi10XKiUr2ItgtSyKLpGQAqgxSTTnb4DRgayG
 b51VRfqb3QxIA==
Subject: Re: [GIT PULL] dma-mapping updates for 5.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <YDYEOTIu02GKL8T2@infradead.org>
References: <YDYEOTIu02GKL8T2@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDYEOTIu02GKL8T2@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.12
X-PR-Tracked-Commit-Id: 81d88ce55092edf1a1f928efb373f289c6b90efd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4dec04c7ff4307973ba502ce7b27330d9fe04b7
Message-Id: <161419239505.20610.6827236057190476216.pr-tracker-bot@kernel.org>
Date: Wed, 24 Feb 2021 18:46:35 +0000
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

The pull request you sent on Wed, 24 Feb 2021 08:46:01 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4dec04c7ff4307973ba502ce7b27330d9fe04b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
