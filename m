Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA5FC433DF
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:19:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9D2207BB
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y82HTfhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9D2207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD05C8848F;
	Thu, 20 Aug 2020 21:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4zKC2CGp6ib; Thu, 20 Aug 2020 21:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF2678846E;
	Thu, 20 Aug 2020 21:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94BCBC07FF;
	Thu, 20 Aug 2020 21:19:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F95CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1C0318693C
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 915FxyxZarY3 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 21:19:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B71E98692B
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:19:46 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597958384;
 bh=2hq6onQCdlA403xN+jtRAG5QjR2ibewvyvH6gGLQeH4=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=y82HTfhV8vskYpYEAgQFRWNVn5iAR4aqiJ21sUp3dzCVX2IydREZrrVG8KfcFxw9a
 X1l8w0kcTHCEH5Ku6muPA3TryhIWhty0wZ4x8O4WB/x7i23jYQTL8KwsyZ0khuJcwD
 NTDRBs6xeL8OJggOTgTTDJNnhL+Sq7CVDUXUrYwI=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200820164158.GA2186695@infradead.org>
References: <20200820164158.GA2186695@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200820164158.GA2186695@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.9-1
X-PR-Tracked-Commit-Id: d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d271b51c60ebe71e0435a9059b315a3d8bb8a099
Message-Id: <159795838442.11229.2400574888982180858.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2020 21:19:44 +0000
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

The pull request you sent on Thu, 20 Aug 2020 18:41:58 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d271b51c60ebe71e0435a9059b315a3d8bb8a099

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
