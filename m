Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1882C2BA2B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 04:05:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CE220757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 04:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaL50o8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CE220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6956484EA7;
	Thu,  9 Apr 2020 04:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zh9x_Arqixrm; Thu,  9 Apr 2020 04:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ECFA284CE6;
	Thu,  9 Apr 2020 04:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFAF7C1D89;
	Thu,  9 Apr 2020 04:05:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32F24C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 04:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C7D3203ED
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 04:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPyt7QejnqlB for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 04:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 876A02038D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 04:05:27 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586405127;
 bh=/iCiFLfNiF3lDS9yAdPdQdDcxKFBzlt/5vNI9IAYhjU=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=OaL50o8N/S53pWagcp6RAbqUFlYFfG+1qWIbyI5wkvAEyQyME5S8c1f214kKSmMC4
 nQbOG5HYbkW54Zn4+vndYAkj0ovdM+FXj1fSvLjSqSHSQAVdq2C8RYYGrhdbDdinrY
 /s4EF0cQfdYApC/krqOC26Hmjf9yu/s0+qH3Zdgs=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200407152635.GA10588@8bytes.org>
References: <20200407152635.GA10588@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407152635.GA10588@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.7
X-PR-Tracked-Commit-Id: ff68eb23308e6538ec7864c83d39540f423bbe90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0906d8b975ff713cfb55328e4f3bf6de5967415e
Message-Id: <158640512732.12302.9078407130199098833.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2020 04:05:27 +0000
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

The pull request you sent on Tue, 7 Apr 2020 17:26:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0906d8b975ff713cfb55328e4f3bf6de5967415e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
