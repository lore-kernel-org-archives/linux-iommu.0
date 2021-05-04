Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E1C433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 18:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B89613D8
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 18:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B89613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A4A4405B3;
	Tue,  4 May 2021 18:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbIgSZop7wvg; Tue,  4 May 2021 18:30:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DAC440119;
	Tue,  4 May 2021 18:30:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6230C000E;
	Tue,  4 May 2021 18:30:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36D69C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 18:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1827F843CC
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 18:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56F2uO-r_eAN for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02A31843D9
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 18:30:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 62DA5613DC;
 Tue,  4 May 2021 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620153007;
 bh=4MA8+3281a+DAt6DJlZCUtFOBn/VW5k4P09P8KzXyqQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=MGKzhq4wEVOKtQUSiMijZBMVPT/vPHIaMdHl/pUxjxbmDO8GDpQqx9lY+DGFy6xCO
 Bny4nfM4cGpvCNlJTfqhG4ktOJCe8o0ZQV/fmp4DggH0DFqIjaG08c0GtJ9vEQV8DP
 rPJakjLiATNtgeCvN+czEkWCIBKIxvWyTEyb/6nssT5sr9cOrqfSkVte4I2FNrKl6a
 qW8UC9deOmFtzuOjOPEw6/uOtX0pGNes/8DqAfyovGJuZZ0NDraAc4iC7SGd9HEjjd
 1qRt+wmhU19gffnlKfGo6PJ18LIl6/UPA22UBFYRzkUe39QBR8jWKCZcPGYOO95rEs
 vjks04V6BoU6g==
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <YJD+n2zT+BOA7ar8@infradead.org>
References: <YJD+n2zT+BOA7ar8@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJD+n2zT+BOA7ar8@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.13
X-PR-Tracked-Commit-Id: a7f3d3d3600c8ed119eb0d2483de0062ce2e3707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 954b7207059cc4004f2e18f49c335304b1c6d64a
Message-Id: <162015300737.4220.11662487020833432644.pr-tracker-bot@kernel.org>
Date: Tue, 04 May 2021 18:30:07 +0000
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

The pull request you sent on Tue, 4 May 2021 09:58:23 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/954b7207059cc4004f2e18f49c335304b1c6d64a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
