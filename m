Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B373C10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D84C21872
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIdGPlbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47726DDE;
	Fri, 12 Apr 2019 15:30:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 093AFDD4
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 15:30:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE469872
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 15:30:07 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083007;
	bh=oiV2TF0Cayljh36UB+zkBeste5mIsG5MpuOTV8JQfKQ=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=ZIdGPlbQTcaWPexS1EZjg74qqz+cO9RUfsLeHqxtiHEpIPc5GQrk3OzaVqV8iYhWa
	2ikp9b9ZyoSeJfEo30uPMcCxxeQffJv7eAhVGgIH/w7jY/iqn0b+x4CbH8WCFJywpg
	EuiVCou/jaw6bnETE52xbtK+4hkmAnrVrEGWJyD4=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190412132938.GA13555@8bytes.org>
References: <20190412132938.GA13555@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412132938.GA13555@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fix-v5.1-rc5
X-PR-Tracked-Commit-Id: 3c677d206210f53a4be972211066c0f1cd47fe12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4876191cbe2a4702b0067d4156e1d8648ac36801
Message-Id:
 <155508300772.31973.10115471264720043552.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2019 15:30:07 +0000
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412153007.9ElzHMuxbr54yOtcWWMxL-E86xWb9bN5OxDc6K-DUmE@z>

The pull request you sent on Fri, 12 Apr 2019 15:29:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4876191cbe2a4702b0067d4156e1d8648ac36801

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
