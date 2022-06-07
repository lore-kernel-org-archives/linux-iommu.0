Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10BEC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 00:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5777140153;
	Tue,  7 Jun 2022 00:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2jCPpVTMsgs; Tue,  7 Jun 2022 00:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C373640108;
	Tue,  7 Jun 2022 00:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BF15C0039;
	Tue,  7 Jun 2022 00:59:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A836C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 00:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7424A83E0F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 00:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ijU7Yo-u1chx for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 00:59:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DC9483E06
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 00:59:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 307EBB81C89;
 Tue,  7 Jun 2022 00:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00240C385A9;
 Tue,  7 Jun 2022 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654563555;
 bh=qhUMQOw5KQrmEgJP6K0Cw72gee4T5pVmV1HiwYo1mGs=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Ysb4zzgvWvEVRSTJxA9YgXEHuyGu1FMjOyR7BNKSAHEURXOZeVkzjpsqH54Nfw2Kb
 19MK31SAYmekjxgVeiGtyz6Vmx6anM+VQv0PPieKXZpCmftez7WgqMolcXLrQB1mzn
 hEHrEZkgBwN9RTtZQRFCQ26p6JVx6nDiDPciN5BtfTHigPlT7b7ZF0p3FvNKukYomt
 e8irEhIL8TuqkXcvXXM9COcMU1hNnawah1Sg1YwY4CDPTzlNv/cROzjrKDcWP30yZn
 IEFBka2NFuLC3rdv9D9dNK420t6pBjMa7HhQA/woOm/GYJWmPD5OLvo0sawJeiXS0H
 GwpSbk4xoCQpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DE945E737ED; Tue,  7 Jun 2022 00:59:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yp2g9SGrXn0eSvnA@infradead.org>
References: <Yp2g9SGrXn0eSvnA@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yp2g9SGrXn0eSvnA@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.19-2022-06-06
X-PR-Tracked-Commit-Id: e15db62bc5648ab459a570862f654e787c498faf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e71e60cd74df9386c3f684c54888f2367050b831
Message-Id: <165456355490.3209.6140029243498184002.pr-tracker-bot@kernel.org>
Date: Tue, 07 Jun 2022 00:59:14 +0000
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

The pull request you sent on Mon, 6 Jun 2022 08:38:45 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e71e60cd74df9386c3f684c54888f2367050b831

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
