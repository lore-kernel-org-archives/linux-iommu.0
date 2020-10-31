Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990CC388F7
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 19:53:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66AD206E9
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZCrgG6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66AD206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C6D427E4C;
	Sat, 31 Oct 2020 19:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCXXaGdjBkGq; Sat, 31 Oct 2020 19:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A7F4276D4;
	Sat, 31 Oct 2020 19:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0EB2C088B;
	Sat, 31 Oct 2020 19:53:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61FBFC0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E23A867EB
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z6O3QIAxrst0 for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D32B4867AC
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:53:54 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604174034;
 bh=viwE+r2ezqayH37udQUFt9+Rvq68jOQmPS7y1ziw3n0=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=nZCrgG6UAmfVoyJ8F0dzDpn0LyUMdOh9i5pYHlikaR3UqVPIt3pmzYNNzjuK2Hd0Q
 EtiQW8GB8dh4d1OHXRIn7LNLL0CbjxZkwi2hwoGc3nViLkazoFOtxyOxUOiumI1LtL
 l8K0jUPQ0OPUEItWeUhY5URYeGD6ascm0AnngC5w=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201031093823.GA453843@infradead.org>
References: <20201031093823.GA453843@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201031093823.GA453843@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.10-2
X-PR-Tracked-Commit-Id: 48ab6d5d1f096d6fac5b59f94af0aa394115a001
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb3540be73ca1e483aa977d859960895fe85372d
Message-Id: <160417403443.21727.3065273541120028592.pr-tracker-bot@kernel.org>
Date: Sat, 31 Oct 2020 19:53:54 +0000
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

The pull request you sent on Sat, 31 Oct 2020 10:38:23 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb3540be73ca1e483aa977d859960895fe85372d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
