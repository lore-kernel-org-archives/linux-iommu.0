Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B3C00307
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39EC2178F
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1EpUlSbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39EC2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9182822A5;
	Fri,  6 Sep 2019 20:00:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D13F52252
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 20:00:06 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 923888A3
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 20:00:06 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567800006;
	bh=2K3R/dyDKxGrrVxKDbGMHID5lj8Lbh6A2qaZcfIDRjQ=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=1EpUlSbuKCPvixmzdFzIHfoW/q+JlEyj97X4CwnTg9brBZ+74Mgd9dsS6/UhZw233
	GvWgQlUfzy/9nKQH/GCp2jMvltduiDCmC9OCcFi2wd/hSvU14Ns44iDGaOo1zIIc/l
	bMlUAFa8j6je1MVDIGGkSwza4CSMmXH+1j9OpjzU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190906151220.GA8420@8bytes.org>
References: <20190906151220.GA8420@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190906151220.GA8420@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fixes-v5.3-rc7
X-PR-Tracked-Commit-Id: 754265bcab78a9014f0f99cd35e0d610fcd7dfa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76f5e9f870b045546b9a429f21b65205baf69c0c
Message-Id: <156780000639.21952.17823516206887580681.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2019 20:00:06 +0000
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

The pull request you sent on Fri, 6 Sep 2019 17:12:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76f5e9f870b045546b9a429f21b65205baf69c0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
