Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134C433E8
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508822078D
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wS3tWl/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508822078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C2BF88A24;
	Fri, 10 Jul 2020 16:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORHYEvEAHiWt; Fri, 10 Jul 2020 16:55:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 136D88856E;
	Fri, 10 Jul 2020 16:55:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F273EC077B;
	Fri, 10 Jul 2020 16:55:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 120FFC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F3BF72E63A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wyWUJS8x3Qz for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 16:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 521E320447
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:55:07 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594400107;
 bh=mAA3/ZBpex/kNKkUh0yoZh5GkI0zJQevobe/c/a6Fa8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=wS3tWl/JsQrt6FEbjdidM/c9it1ewDCY00nkXtZ9UlcaeJVkDN4iv3ODGxOCFPFbG
 bgmZpklFNhpvFfhoh6P8blC8dUV1Y3HdWUU3kEzYp7rtUcBki3dUMdII/O3USUWIFp
 Yvlf07hoH/x0nqcLJ5KLhlNicOnPjP7X95WDflnk=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200710154506.GA540305@infradead.org>
References: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-5
X-PR-Tracked-Commit-Id: 68d237056e007c88031d80900cdba0945121a287
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bfde037425d91d1d615d30ec362f5f5c1ca0dd2
Message-Id: <159440010718.18761.15336646128679822312.pr-tracker-bot@kernel.org>
Date: Fri, 10 Jul 2020 16:55:07 +0000
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

The pull request you sent on Fri, 10 Jul 2020 17:45:06 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bfde037425d91d1d615d30ec362f5f5c1ca0dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
