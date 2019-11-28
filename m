Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFADC432C3
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 19:55:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E5621775
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 19:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvpjWkXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E5621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 005B72039E;
	Thu, 28 Nov 2019 19:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7qNJ7T2FhJhR; Thu, 28 Nov 2019 19:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5D4DC20387;
	Thu, 28 Nov 2019 19:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 427C5C1DD5;
	Thu, 28 Nov 2019 19:55:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FACAC0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 19:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 287E12039E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 19:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iHAgQt7jxZMc for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 19:55:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id A891F20387
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 19:55:15 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574970915;
 bh=0YZdEDTRQcaiem7wsteKe6vcE3rtm3kUJ9ehSINoDl8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=kvpjWkXNYyUDkXLS42imM1H9+9EBJcccD3gEVPy0JMXbKphDEcKe5OijzdU/VvIEs
 QjXPd3h8xgaX0QrwkVVBOGYIm7PAJQLicNZa+UANzLUeuGXTmhxXt3Xlv81MfGJ5sT
 YlApeDjar01JhqQsFF+HD2tUhPugQbZehgkWj9rg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191128164904.GA20771@infradead.org>
References: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.5
X-PR-Tracked-Commit-Id: a7ba70f1787f977f970cd116076c6fce4b9e01cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81b6b96475ac7a4ebfceae9f16fb3758327adbfe
Message-Id: <157497091536.22792.17174255235714068782.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2019 19:55:15 +0000
To: Christoph Hellwig <hch@infradead.org>
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

The pull request you sent on Thu, 28 Nov 2019 17:49:04 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81b6b96475ac7a4ebfceae9f16fb3758327adbfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
