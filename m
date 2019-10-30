Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B862CA9EC5
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 13:25:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245B920856
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3qiA9LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245B920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E571FD38;
	Wed, 30 Oct 2019 13:25:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D59FCD09
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 13:25:05 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB2818A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 13:25:05 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572441905;
	bh=DmmVLnO2Nuchx2VqNQqfcDQaXZjO+KlZLc+j/LGWQWM=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=U3qiA9LOdmlhEL7fiTwaa9JI3b9W86IMZcgvOdjUPWk+8ov2+TbcurOUJFDBmj821
	C/WBIK7gqxh22pTats0caYT0PijkX6KdBiLa5aAyCTPLviO1SwQtY//ltxXS3mbJSg
	UUwkV2F/1zKz/N3KUK1FkIBVcb4U+Je/asLHcD/w=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191030130251.GA11315@8bytes.org>
References: <20191030130251.GA11315@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191030130251.GA11315@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fixes-v5.4-rc5
X-PR-Tracked-Commit-Id: 160c63f909ffbc797c0bbe23310ac1eaf2349d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 320000e72ec0613e164ce9608d865396fb2da278
Message-Id: <157244190549.19806.13453430741450004166.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2019 13:25:05 +0000
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

The pull request you sent on Wed, 30 Oct 2019 14:02:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/320000e72ec0613e164ce9608d865396fb2da278

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
