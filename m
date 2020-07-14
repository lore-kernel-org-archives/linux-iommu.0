Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBBC433E1
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 01:35:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA8421924
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 01:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lumb+JbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA8421924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EE5F8A346;
	Tue, 14 Jul 2020 01:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sY9BdLykhbpl; Tue, 14 Jul 2020 01:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D11C8A344;
	Tue, 14 Jul 2020 01:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A44AC0888;
	Tue, 14 Jul 2020 01:35:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16F2CC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 01:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F363F88D4B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 01:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glbhnXkduWRl for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 01:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DDF76889BE
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 01:35:03 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594690503;
 bh=D/Bl2d/W9e6p4DWfLpdQLJsdo0VCU8TQe8i6i7tmhv8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=lumb+JbSYY9uiio0MEji0Gw7NEPFMKmWzdsiMO62/MyFqadPpzANgXspuIvYTu5fz
 HZa+29m8BAWHEiu8q1P8KjJ+eYnNFdBNDiALTnWiQ2dm8i9VkewjyDbRKswgzhrghJ
 KW4SA8PYKDbS+JTv151+ZKQEI+pVhJctqv35Rpio=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200713153649.GA2615@8bytes.org>
References: <20200713153649.GA2615@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200713153649.GA2615@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.8-rc5
X-PR-Tracked-Commit-Id: a082121b55bac125f7d09d78de00607ea75a6903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dc589da873b58b70f4caf4b070fb0cf70fdd1dc
Message-Id: <159469050366.22447.6799245194138996381.pr-tracker-bot@kernel.org>
Date: Tue, 14 Jul 2020 01:35:03 +0000
To: Joerg Roedel <joro@8bytes.org>
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

The pull request you sent on Mon, 13 Jul 2020 17:36:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dc589da873b58b70f4caf4b070fb0cf70fdd1dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
