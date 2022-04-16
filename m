Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DDAC433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 20:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DD4F60C33;
	Sat, 16 Apr 2022 20:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oem4pCDg1Du; Sat, 16 Apr 2022 20:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5DA6960BD8;
	Sat, 16 Apr 2022 20:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31C4CC0033;
	Sat, 16 Apr 2022 20:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC9D5C002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 20:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 850B840C6C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 20:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7jOV5IOUlmN for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 20:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 659B240185
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 20:43:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DEE52B8083A;
 Sat, 16 Apr 2022 20:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94782C385A1;
 Sat, 16 Apr 2022 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650141777;
 bh=VxkwGfU9iHJE5L0HxycfmYK299/j5zMhv83yEXB65vw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Am15EMsDMN5QTtt3i8Gl2aM2ZkOu05QWzq3H99cK9PGpCL6QVmdDcBizyO/ciR5gy
 DZwoBm+kfcMTOsDPwR9paH2PgvMCp4//8GjjqnHlfioXMSe1EqiREyMhpf84x376c7
 VK7G67vdJa1GsOoC8VIH/JoW/ObNWxIVKt0DtCzYEESF8hsmGN+9cEykTZQArtpuKC
 EBYnvzbl/gD7EibcpKaQ6BQMdBsWruKNIQQ2Qo3YGUipqaUkuS7sVMDB1cM7gmXwy1
 FoZKupJdi6oiuddGy0+6kHnS6NIgO9creSVO7CsIDl5E5EMCI9TqWq16mNTI0tLRQ9
 /8OrOfaDTvJqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 826FBE7399D; Sat, 16 Apr 2022 20:42:57 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <YlpaRgHee1NPl2XB@infradead.org>
References: <YlpaRgHee1NPl2XB@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlpaRgHee1NPl2XB@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.18-2
X-PR-Tracked-Commit-Id: 9e02977bfad006af328add9434c8bffa40e053bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b00868396dbd23bb6875f4096b6e59e1b17d67de
Message-Id: <165014177752.10681.14946785121575724320.pr-tracker-bot@kernel.org>
Date: Sat, 16 Apr 2022 20:42:57 +0000
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

The pull request you sent on Sat, 16 Apr 2022 07:55:18 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b00868396dbd23bb6875f4096b6e59e1b17d67de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
