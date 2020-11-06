Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFEC5517A
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 21:13:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECF1221F8
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fthJfn7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECF1221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77CF8203FE;
	Fri,  6 Nov 2020 21:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtJOFlkUei5O; Fri,  6 Nov 2020 21:13:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A947D203DF;
	Fri,  6 Nov 2020 21:13:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80549C088B;
	Fri,  6 Nov 2020 21:13:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5196C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 21:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96E35203DF
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 21:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zmQKjRjtidLC for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 21:13:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id DC2A9203CD
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 21:13:25 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604697205;
 bh=5cKkHA45t/SLEE2IkJBajbrClJ/7j/9wbW6DCSjB73M=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=fthJfn7SaUkgmGr0fMljmEbInWGwApLCFkSBg1PHxEGpyXVfc0ea7bJVVkRVey9pi
 ctjf/yJoBCAfSdRjqSLqROewZEXR09/VIMf8BsqQf0QP4C5jVWidj+h42fItvjY4Ay
 rh9JCAwxLgFKDrJxNAhegpsiHalEuQ7U3N8lhzqQ=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201106162302.GA3084@8bytes.org>
References: <20201106162302.GA3084@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201106162302.GA3084@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.10-rc2
X-PR-Tracked-Commit-Id: 4dd6ce478003525df8618750d30f0b90380047a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02a2aa3500a993c9f0812b8564d36d63b8d49ce4
Message-Id: <160469720523.14190.4464532018621557998.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2020 21:13:25 +0000
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

The pull request you sent on Fri, 6 Nov 2020 17:23:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02a2aa3500a993c9f0812b8564d36d63b8d49ce4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
