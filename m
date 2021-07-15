Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C22C636C9
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 19:28:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3E0613C0
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 19:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3E0613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE2A283E12;
	Thu, 15 Jul 2021 19:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64wVrodGUOXk; Thu, 15 Jul 2021 19:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E6C3E83E0A;
	Thu, 15 Jul 2021 19:28:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA619C001A;
	Thu, 15 Jul 2021 19:28:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6460C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 19:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC33E423CD
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 19:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tb2Np6PMtRkm for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 19:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91E7C423CB
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 19:28:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 19A9F611AE;
 Thu, 15 Jul 2021 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626377296;
 bh=1NSyY1VrYa+ptMyFjLHzUi0wjs3LfZX+gdyrWr/XmOc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=uF+O7WFgcRlPbFnI+GtC3WHGO5yiFbndhQeIA4IHrHBheGVt/jmfKkO8zkRUhSdSX
 AhyvDMOUIuw8oqJBJAKbQzj4Uqh/ebbq8W7uhR6yYGTm1SIymtIbZJmbfoXDKIqqAp
 qmiII2Or0Xa2TGA21hoMh9H2UtJrz8/Ja9A8gUbEwQAnK2GdBZ5cTq/LUarWGkPmYD
 PxYwCopZ9boNikKBGa5tftgnhomEbb8QTFnFteNPyMreh6LVSjnhMOi7Dq2K6eLfeH
 zHMYa9GZ4uSRI+RZKpcfes1jwBPRYfWi09VMNQOqONA1OfyzQFq7+yC2JN9CtDaHMS
 FLL2SBBjXtrOw==
Subject: Re: [git pull] IOMMU Fixes for Linux v5.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YO/tnD+7RA32yO1F@8bytes.org>
References: <YO/tnD+7RA32yO1F@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YO/tnD+7RA32yO1F@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.14-rc1
X-PR-Tracked-Commit-Id: 4a5c155a5ab372516a1a5ddd29473f8f696feb79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3523a226dbb0c925def650a658a0755185d60a8
Message-Id: <162637729595.11736.5575499763587728536.pr-tracker-bot@kernel.org>
Date: Thu, 15 Jul 2021 19:28:15 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
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

The pull request you sent on Thu, 15 Jul 2021 10:11:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3523a226dbb0c925def650a658a0755185d60a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
