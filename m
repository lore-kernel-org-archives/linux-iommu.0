Return-Path: <SRS0=t+bH=3N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02AAC2D0DB
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DB32075D
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Ak3IoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB32075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DA358821F;
	Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3a9UJyHWTbSw; Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2AC8187E0B;
	Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 185C8C1D80;
	Fri, 24 Jan 2020 18:00:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E2EC0174
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 18:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6341D87884
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 18:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrZWl5MAPFBg for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jan 2020 18:00:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F2FC6867D0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 18:00:04 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579888804;
 bh=2b4GYibQY/giByCe+xBlKXf22xXWn/Kj4DMTXSEoz0U=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=C2Ak3IoLK1W7BmXzCxmcgjx666/EUoACtNda7R5u4o1OwthkwlfCBuEpD/lbTDCWt
 VUZvvRn7W9R2r+NJyPNaW07uHHsspKJOUmSAi+pe7D+mUjw9/4rTFY9lor1yffcmra
 DDWxeNi94byonTOmwIVRNOl/wrpGFqetRH8fpNl0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200124172938.GA30565@8bytes.org>
References: <20200124172938.GA30565@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200124172938.GA30565@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.5-rc7
X-PR-Tracked-Commit-Id: 8c17bbf6c8f70058a66305f2e1982552e6ea7f47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6381b442836ea3c52eae630b10be8c27c7a17af2
Message-Id: <157988880477.9531.3662551803752426240.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2020 18:00:04 +0000
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

The pull request you sent on Fri, 24 Jan 2020 18:29:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6381b442836ea3c52eae630b10be8c27c7a17af2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
