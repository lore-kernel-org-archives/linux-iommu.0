Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE18BC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 21:59:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D69965012
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 21:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D69965012
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E0E482B75;
	Fri,  5 Mar 2021 21:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wDMOTx-fvZT; Fri,  5 Mar 2021 21:59:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AB0983F57;
	Fri,  5 Mar 2021 21:59:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10764C000A;
	Fri,  5 Mar 2021 21:59:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD27C0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5769B49E7A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKDyVPR753ce for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 870CB4891C
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 09AE265051;
 Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614981539;
 bh=wCtH3MoXQz+BB4xKiktPGcCpzGS4AumQg2uqoXMHhm4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=uDEsmjUkuk+y1UnQf4uk5YFcHTP7XBVBG9txAdBNZnzp1pHsBXzKGZFaPEcm9spZc
 E+7T033yrncKqEFqNQ6hhEkgu+NTe8SQmEJkzRD81INHWTYeEowGu9LiCZ/YtV3S0I
 YAl4bjzJUSsMOxSj1VGOM/71bjXVQl7GSyP+iwnWJLBRmnJl2uva7cu3QjFARqYRjk
 s/c2XKXevBinKkR0k9lU2D3rlbgw5rA7j680rSxixBZI+FG0bHNstyLHEi6P43zLPy
 DapPD7SKQZGoigRgPsvn4SyclWSs61m577cs2QrsWbkD4zl821XaPpsHuEyFKyStwr
 1LSCqDZbkhuRg==
Subject: Re: [git pull] IOMMU Fixes for Linux iommu-updates-v5.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210305162319.GA14489@8bytes.org>
References: <20210305162319.GA14489@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305162319.GA14489@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.12-rc1
X-PR-Tracked-Commit-Id: 444d66a23c1f1e4c4d12aed4812681d0ad835d60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc2c8d0af05af4c380824e40ff99ede398913ae5
Message-Id: <161498153901.14373.491816744847742815.pr-tracker-bot@kernel.org>
Date: Fri, 05 Mar 2021 21:58:59 +0000
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

The pull request you sent on Fri, 5 Mar 2021 17:23:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc2c8d0af05af4c380824e40ff99ede398913ae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
