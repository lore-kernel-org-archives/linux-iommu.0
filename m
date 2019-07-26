Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A0C7618F
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305F822C7E
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoj913NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305F822C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E995DE5D;
	Fri, 26 Jul 2019 18:25:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 66BE3E45
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 18:25:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D265894
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 18:25:23 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165523;
	bh=nJnUujJ+so3cSBaZGhIbQ4Uh18h9udPXuxvD24fEUfk=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=qoj913NNaMCDtEKCHQB9WDDAYKoLceduU7weNRH3+fvEV1dF6Ay9x/FOhUfE9jFT6
	xF8WCynyqH6ugrC3aWK/3uxiBQA0fYJTA0PqVNS1Jr4/j0PPJFeAUaFyFWpIyndesb
	hpmyOJzQOFnR0/oK/eDYguyTVh1khOdRVKguXq5w=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190726092048.GA3957@8bytes.org>
References: <20190726092048.GA3957@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726092048.GA3957@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fixes-v5.3-rc1
X-PR-Tracked-Commit-Id: 66929812955bbec808c94d7a3916f41638a98a0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b381c016c5cfea94f2ad22c0c2195306a70d54ac
Message-Id: <156416552310.19332.10815430798423943308.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2019 18:25:23 +0000
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

The pull request you sent on Fri, 26 Jul 2019 11:20:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b381c016c5cfea94f2ad22c0c2195306a70d54ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
