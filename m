Return-Path: <SRS0=lnwu=5U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012EEC4332B
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22F32071C
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt0Nybnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22F32071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 84D1F884B2;
	Sat,  4 Apr 2020 17:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D02Wx8IjKRoJ; Sat,  4 Apr 2020 17:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0690587E3F;
	Sat,  4 Apr 2020 17:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CECA7C1AE2;
	Sat,  4 Apr 2020 17:50:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA510C07FF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A6BE785F9D
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3o3rFadBjBaR for <iommu@lists.linux-foundation.org>;
 Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4B98985F8F
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586022624;
 bh=cKK4vs/ElMxlmbk52kFAcJUDROfeksg+vPch0uqr/Hw=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Pt0NybnfUbUjG+K9PWNQgx3n0++R+6EAhGcraUZ46TT5jqQIUzZ6K2vfl+h6WSzQg
 qS9i+ves0qvlDDPFgCwTNVS3Yb12Tjp35v8fXYdWYg2TNuaaCNitE4+9rMLTf3By5k
 TT5eLz1fI9VqCF6c6OL+l0rbzKkF4O3xqb2TjUKQ=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200404065855.GA656254@infradead.org>
References: <20200404065855.GA656254@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200404065855.GA656254@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.7
X-PR-Tracked-Commit-Id: fd27a526bb381f43dded6db30b3b016468ab0e6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f43bae38269a55534e1f86a9917318167de6639
Message-Id: <158602262410.31764.10662666727749617192.pr-tracker-bot@kernel.org>
Date: Sat, 04 Apr 2020 17:50:24 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

The pull request you sent on Sat, 4 Apr 2020 08:58:55 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f43bae38269a55534e1f86a9917318167de6639

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
