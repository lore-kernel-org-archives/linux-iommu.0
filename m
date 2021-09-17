Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2394C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 19:29:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7316C60F9C
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 19:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7316C60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 356EE4047E;
	Fri, 17 Sep 2021 19:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KYrKTO_CMtG; Fri, 17 Sep 2021 19:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C9A1400EA;
	Fri, 17 Sep 2021 19:29:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C27C000F;
	Fri, 17 Sep 2021 19:29:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00DE7C000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 19:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0B5E83E84
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 19:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQhITXpUhp0V for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 19:29:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED20283B61
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 19:29:30 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 7DAFE61019;
 Fri, 17 Sep 2021 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631906970;
 bh=MgAZhsC9YYXH0eMO0LIh/+e9w36OjRQfUqYYEFgnqvI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=mLQCrCl2Fgc7bZAnOym98F5MLn/oIixqG7RBHQKL/pokEUD7lJtHso5/J6AWf16rp
 9/hwuXyqA40tX3I4fllxAKYQoTdr+YeUqFQSDl/0aqtZ4McpdAfKoEzqU+S+7fmMc4
 zkqnLSYx9VycYg1JK4NvDbgNmrawLGUXAEL47zpNqNbvuqbhqRlPSlWfefAgZR/LLS
 uqPWoZhtz8FtFoF8uES3L9441mlJCLJlh9gcgp3KZP0d3cRha2MEerrCmdUwRT5A0H
 glHoN3+i0fT1gW/L/ykpixfvhi8tIXs6Ys3Z6apiYoHTItETaNYEBFNxgqEOQmqM/I
 EiL1v0wVGxzKQ==
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15 (2nd attempt)
From: pr-tracker-bot@kernel.org
In-Reply-To: <YUTEnFAls4dyIyJ1@infradead.org>
References: <YUTEnFAls4dyIyJ1@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YUTEnFAls4dyIyJ1@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.15-1
X-PR-Tracked-Commit-Id: 59583f747664046aaae5588d56d5954fab66cce8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9b11b133b4a0b4f8dc36ec04d81d630f763eaa6
Message-Id: <163190697037.17353.4870116211073217387.pr-tracker-bot@kernel.org>
Date: Fri, 17 Sep 2021 19:29:30 +0000
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

The pull request you sent on Fri, 17 Sep 2021 18:38:52 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9b11b133b4a0b4f8dc36ec04d81d630f763eaa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
