Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21009C433DB
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 00:09:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF1C61974
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 00:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF1C61974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2487C6071E;
	Sat, 20 Mar 2021 00:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Dk9ebS7_1md; Sat, 20 Mar 2021 00:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B712360719;
	Sat, 20 Mar 2021 00:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F74FC000B;
	Sat, 20 Mar 2021 00:09:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F29FEC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB1FD8341E
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Ost4tK__H9x for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 00:09:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC31483408
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:09:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id A4F5B61982;
 Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616198960;
 bh=UyFCj4v/8cbV0sd7GLfot4I6gShJKWeDUiZiBxojxBI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=QTo1/0E99YLNxIgkIaaX85Z6dgCtaR/ssQmgp1tI1enosQlluB68z8KY/FXYembPu
 nvwy+bUQSXBcK/mORQcoqnLMOhyR827hspPdX0R/AZajfmOQDUhr3lMhS9+VLRGQoW
 jR1Ayc7k2/0ij0J+n2/yNQwN2vWz/kEIImqnF8jkW/0JXn7Yr7O6XIwEK2tnU+jczQ
 DNtbVaOaMslTcr2Q5bjfRq1jkzTHrpwpCIU1lAeaj1LIFyaJi8eIpiHor9dGAN4DUI
 uM6y4Prz35eFk1GqT8y/M9tK8tneHLMQr5kC1C41Cn8lRLmIFefKF+VOx7pS1U+klA
 c71x1B7M50BzQ==
Subject: Re: [git pull] IOMMU Fixes for Linux v5.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <YFSHuWNVKFOTHJWt@8bytes.org>
References: <YFSHuWNVKFOTHJWt@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFSHuWNVKFOTHJWt@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.12-rc3
X-PR-Tracked-Commit-Id: 8dfd0fa6ecdc5e2099a57d485b7ce237abc6c7a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65a103747104368cb1ba6f097dcc3f85b1dcf86b
Message-Id: <161619896062.24257.7896646706673366985.pr-tracker-bot@kernel.org>
Date: Sat, 20 Mar 2021 00:09:20 +0000
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

The pull request you sent on Fri, 19 Mar 2021 12:15:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65a103747104368cb1ba6f097dcc3f85b1dcf86b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
