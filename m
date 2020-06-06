Return-Path: <SRS0=ipMx=7T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D434DC433E0
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BDC207D0
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpXyHUuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BDC207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AA7A846F4;
	Sat,  6 Jun 2020 19:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIvsDp3nmHu6; Sat,  6 Jun 2020 19:15:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 512F483F0F;
	Sat,  6 Jun 2020 19:15:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40168C088D;
	Sat,  6 Jun 2020 19:15:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2681C016E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 19:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1C2A88457
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 19:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XJMI4HTAJztc for <iommu@lists.linux-foundation.org>;
 Sat,  6 Jun 2020 19:15:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A3CC88455
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 19:15:19 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.8, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591470919;
 bh=cxND22Ha225UmQPRUJGsqR+a5+bQ/+hNOBaOgUBq/5M=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=XpXyHUuc3ybHIiBvz4LadHvOaXLAwzXG+A48sObXyfUdfq0vJMq4E/a9roD4OxE9j
 5WhFtpnjIK6SBHO+z1PMzN1vhNMmmsD26X971+QVVvOiihkmvYFYEfpB3ollwO97Ru
 ioUG7LLNz1MM7rDk2CYwGk4mzkoBDMII/a/ZLKx4=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200606160932.GB3482728@infradead.org>
References: <20200606160932.GB3482728@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200606160932.GB3482728@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-2
X-PR-Tracked-Commit-Id: 48530d9fab0d3bf08827f9167be54acf66d4d457
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7
Message-Id: <159147091934.3313.12740023106632055664.pr-tracker-bot@kernel.org>
Date: Sat, 06 Jun 2020 19:15:19 +0000
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

The pull request you sent on Sat, 6 Jun 2020 18:09:32 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
