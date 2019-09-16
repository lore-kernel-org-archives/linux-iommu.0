Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2814EC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6B62189D
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zaml9FTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6B62189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B52DD1408;
	Mon, 16 Sep 2019 21:35:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3215D13F0
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 21:35:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 07D6A7DB
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 21:35:14 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669713;
	bh=q52ZFHXm/LA/R2JrWmX2L/Z8vL1yV17IsFuxspLn8pA=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=Zaml9FTE90NT3S05cNZvj/c9qNgoRC4cIoplq2xUQOvw+kg8+kp5shlMd7uOFecGf
	wqAGdybZ0b4QEfpout8vK/BsAV//mYOgEqemCDLR7xDsu+3/UgJz37G7cnvJ6yt0OV
	ya73M7Yhsj+rrOPfln/DsteCwcrLz67JwZkyNBFA=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190916151342.GA7444@8bytes.org>
References: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-updates-v5.4
X-PR-Tracked-Commit-Id: e95adb9add75affb98570a518c902f50e5fcce1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a5525214d0d612160154d902956eca0558b7c0
Message-Id: <156866971382.13102.1513006408940685487.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2019 21:35:13 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The pull request you sent on Mon, 16 Sep 2019 17:13:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a5525214d0d612160154d902956eca0558b7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
