Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3EBC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:09:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BECC23C8E
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BECC23C8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E8362051E;
	Wed,  9 Dec 2020 18:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaKRdJwoKLjB; Wed,  9 Dec 2020 18:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DAA6D204F2;
	Wed,  9 Dec 2020 18:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6C30C0893;
	Wed,  9 Dec 2020 18:09:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69785C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 517F287409
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h3n5aJDwEe+2 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D52AD87401
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607537386;
 bh=MsyqIRUCM2LjhoRDi35EkFF1ESIf2BAfUJ8bcwdw2+U=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=XlNQliH1vSnOaxmolsvDJ5Abo1m6Ruw8YCydrMqOY/WXyo9TWZBildmBHCFtes0sL
 LMmrVLZuUTxOZnIM0O02hLXkLCHpCYFBMu3HDRN25hXcwWYVgl1PbsgkcMC/3g+CgO
 gZGzvQnQecnV6rp8oZ21sT9Mzo5OE5k/XTCmy2JGipR3YXcHn06XpusKQgtPk1FmDH
 7MdsL/ClKNCaCUxAPfaAOBudE30DsxiNpcUHX7EQCZ9qlv3CRQrARIyq7GEiDZmhSk
 IqA5gMpRwTXAWSzThReVMuoJsL8CvqL9geU7f8uXRO4lm2mw/kWSjq7zr5MZJm+03a
 rQLPjZ6+O44Og==
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201209141237.GA8092@willie-the-truck>
References: <20201209141237.GA8092@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201209141237.GA8092@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/iommu-fixes
X-PR-Tracked-Commit-Id: 4165bf015ba9454f45beaad621d16c516d5c5afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca4bbdaf171604841f77648a2877e2e43db69b71
Message-Id: <160753738624.9915.18144343532450407181.pr-tracker-bot@kernel.org>
Date: Wed, 09 Dec 2020 18:09:46 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
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

The pull request you sent on Wed, 9 Dec 2020 14:12:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca4bbdaf171604841f77648a2877e2e43db69b71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
