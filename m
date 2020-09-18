Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A008C43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 19:04:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B52221EC
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 19:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDqRm34Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B52221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B04152E23B;
	Fri, 18 Sep 2020 19:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXG1WMOJg5CX; Fri, 18 Sep 2020 19:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A84282E1F1;
	Fri, 18 Sep 2020 19:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6892AC0888;
	Fri, 18 Sep 2020 19:04:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE58C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 19:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 244BB2E1F1
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 19:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvj-y6ZAdWFR for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 19:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id AAAAF204B4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 19:04:14 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600455854;
 bh=ENzdNrr6Yxov2Bq4jXUL6Wo6Vtn0e8D2Uu4poYfo59Q=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=KDqRm34Z2uFXVYGIG2bdFP3UNv4TFwH+CGAq67wfqdTtRNM1ID9TiUiNgPTfDQOm9
 2r37+N6alFdjvnZ9C69UJdvoXO/CMGn0q8Y1C7R+EtXDVA2DqenNivLBSZoz9wL36a
 6JgYpzJnLTGkSJJu0b+6g88i94vDVyaMksPa1rpg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200918151051.GA31007@8bytes.org>
References: <20200918151051.GA31007@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200918151051.GA31007@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.9-rc5
X-PR-Tracked-Commit-Id: e97685abd5d711c885053d4949178f7ab9acbaef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fd79656f7d59b2ccfc8d7ec8136db60d21f1e0a
Message-Id: <160045585430.18461.16309137272287318103.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2020 19:04:14 +0000
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

The pull request you sent on Fri, 18 Sep 2020 17:10:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fd79656f7d59b2ccfc8d7ec8136db60d21f1e0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
