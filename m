Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56AC433DB
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 22:24:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CF823133
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CF823133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DA478698C;
	Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mT98waOHntAM; Tue, 22 Dec 2020 22:24:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1B6386960;
	Tue, 22 Dec 2020 22:24:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5F2C1825;
	Tue, 22 Dec 2020 22:24:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37D8AC0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 22:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2D9B987271
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 22:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKhdHEGu3acD for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 22:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BEAE18722B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 22:24:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 4938323103;
 Tue, 22 Dec 2020 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608675861;
 bh=kW0JXLvBKhdsWzU3y7QVqr3L5AXy0WeZwxVxoFJECKI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=KjHO5mF0wtdPjNvKUwU+eTC7F1DMVUffazOaLzoHKv3zxMm1OmMXmZngmXgRL4pjB
 tzCjYlQdCL4bEX9co62Ta1lgbaTjwiiiCRAF9eQkm1fe8ooGR8kgIPspTuvILn7jYL
 RxIyUrXKZYLblWSZKy/gNcYDCGphvl0aSOT16O5TAsaDUc/MZdNqHG/fNwtqG22457
 em6r0iLaw6E5u44axdmmKTPdUZcq0aiUYtE1n4XcK1NR+BlFm39JXHfGheJTGJHczU
 rqAr+1hkXpUAh7CHajFkuqopR14cbsaKmsRbF8t42yUFalBwo7WeMLyTuaCFYNWC10
 fX6/m9jEG1Miw==
Subject: Re: [GIT PULL] dma-mapping updates for 5.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201222160112.GA3019603@infradead.org>
References: <20201222160112.GA3019603@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20201222160112.GA3019603@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.11
X-PR-Tracked-Commit-Id: 7679325702c90aecd393cd7cde685576c14489c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 347d81b68b8f7044c9ce3fefa130a736ca916176
Message-Id: <160867586125.8550.11731307102280818177.pr-tracker-bot@kernel.org>
Date: Tue, 22 Dec 2020 22:24:21 +0000
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

The pull request you sent on Tue, 22 Dec 2020 17:01:12 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/347d81b68b8f7044c9ce3fefa130a736ca916176

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
