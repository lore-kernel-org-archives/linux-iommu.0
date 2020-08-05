Return-Path: <SRS0=9QAy=BP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7CC433DF
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 01:05:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C4A20792
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0xo/kexh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C4A20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5043B85E25;
	Wed,  5 Aug 2020 01:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iSjkCK4IY5RL; Wed,  5 Aug 2020 01:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D5D1585E24;
	Wed,  5 Aug 2020 01:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6DF1C0050;
	Wed,  5 Aug 2020 01:05:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9B6C004C
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 01:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EA7F688031
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 01:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11VOt10mM9v8 for <iommu@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 01:05:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 814DA88020
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 01:05:08 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596589508;
 bh=V8SyMJUhTk121eZYzAmhMw82jobWxaHTOhXR1PgnYnE=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=0xo/kexh69Mx1o1AXt7z9fqmSfKd++oqctX1Lzm/2CvXBpnVEyQR2c5H17/+FQvuR
 GqskXQ6MnPlLaebzPqSFOofnXsD8ENW7BDhkrF4zrga4SS6kU+x7cXIQG53PSXNY5z
 hOcqfPLzrd183MhG1/VHEQjKTOHs1kWlcLZgqJ3o=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200803141547.GA752173@infradead.org>
References: <20200803141547.GA752173@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803141547.GA752173@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.9
X-PR-Tracked-Commit-Id: 274b3f7bf34415eed106e479e4815e897ce5d763
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ed90dbbf7be3b7cd2790fc6fa946c478ab496b8
Message-Id: <159658950828.28431.11011770511224592315.pr-tracker-bot@kernel.org>
Date: Wed, 05 Aug 2020 01:05:08 +0000
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

The pull request you sent on Mon, 3 Aug 2020 16:15:47 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ed90dbbf7be3b7cd2790fc6fa946c478ab496b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
