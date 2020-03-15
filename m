Return-Path: <SRS0=ouxr=5A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCCC10F29
	for <iommu@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D82205C9
	for <iommu@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1thktkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D82205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1417789103;
	Sun, 15 Mar 2020 20:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPSN0AbUWvzS; Sun, 15 Mar 2020 20:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FA7D890E9;
	Sun, 15 Mar 2020 20:25:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C85C1AE2;
	Sun, 15 Mar 2020 20:25:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D9E8C013E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 20:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 59CB52150A
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 20:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdIFAQODCkQq for <iommu@lists.linux-foundation.org>;
 Sun, 15 Mar 2020 20:25:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id E0134215DF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 20:25:06 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584303906;
 bh=eiuLjTM0H7dwvn819pmsnMr/lPvShNx1pDwdSrAXyRQ=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=N1thktkZN0Da+XmJMgGqEbwh6qedl5hyY8gzb5T3LArQIyhhDrzfVz8frkUI9LnVr
 Rhz+OuK6CceQHZYPD1NIXSrtsxPr8s3jw3NJiSMx6ud2TFGW0JwchOisx7s/BPY9v/
 emu3Fa0mFlRe2bINEcXCOIeMHo7yBAVMc4F4r12Y=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200315091602.GA18173@8bytes.org>
References: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.6-rc5
X-PR-Tracked-Commit-Id: 1da8347d8505c137fb07ff06bbcd3f2bf37409bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de28a65cd0e39d031dfcdc61fbe06268cb4a5f94
Message-Id: <158430390668.13594.6670059982592088397.pr-tracker-bot@kernel.org>
Date: Sun, 15 Mar 2020 20:25:06 +0000
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

The pull request you sent on Sun, 15 Mar 2020 10:16:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de28a65cd0e39d031dfcdc61fbe06268cb4a5f94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
