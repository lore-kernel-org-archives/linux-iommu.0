Return-Path: <SRS0=jbNj=BV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF1DC433E1
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF5520786
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwTW2X2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF5520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1522488276;
	Tue, 11 Aug 2020 21:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxhF3ExdtE7c; Tue, 11 Aug 2020 21:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6D2DB8826E;
	Tue, 11 Aug 2020 21:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50B43C013C;
	Tue, 11 Aug 2020 21:23:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57979C004D
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 21:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B20E87F6A
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 21:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JK1bHJqu7xX for <iommu@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 21:23:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5CBE987F49
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 21:23:26 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597181006;
 bh=mr6YJD1V4dkwy/Iwhe/jxgg4pJipy7PDAUDoeF1s8c8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=fwTW2X2J+0qYpKurzFhAD2TPfZWDUy0AJTjxF1gT59wBB3aSP7wnR4dmYBxriOQdw
 xTtVPq9bzmNy6TCqdEB0cEOEMjHTUhAAlVBAluzQcykGACKfrlipurZjAFi6beSd0T
 2cpbZJQG8UkwmVNa6kLgNc0Kvpl9avhn3/pJFkYM=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200811124747.GA13876@8bytes.org>
References: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.9
X-PR-Tracked-Commit-Id: e46b3c0d011eab9933c183d5b47569db8e377281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952ace797c17d06e50ad2a738babd27159b8d7cc
Message-Id: <159718100611.533.7037020432422807245.pr-tracker-bot@kernel.org>
Date: Tue, 11 Aug 2020 21:23:26 +0000
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

The pull request you sent on Tue, 11 Aug 2020 14:47:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952ace797c17d06e50ad2a738babd27159b8d7cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
