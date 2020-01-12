Return-Path: <SRS0=6LF9=3B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05AC33CA2
	for <iommu@archiver.kernel.org>; Sun, 12 Jan 2020 17:40:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C8D2080D
	for <iommu@archiver.kernel.org>; Sun, 12 Jan 2020 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLEEPy6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C8D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75F2F84483;
	Sun, 12 Jan 2020 17:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9GDzI8A3Mii; Sun, 12 Jan 2020 17:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B075B840C2;
	Sun, 12 Jan 2020 17:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95F59C1D85;
	Sun, 12 Jan 2020 17:40:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 617A8C077D
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jan 2020 17:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A7CD84AAE
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jan 2020 17:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvh0LgFHqx-H for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jan 2020 17:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CCDA784A6C
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jan 2020 17:40:03 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578850803;
 bh=F2rMj+tDgCY54uolmRKP8Lu3t4cWtvsfHk3J8aI4QqI=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=lLEEPy6Ds5dpxuAqq/QJJ+LYZBSXpWSGRkuJV6SC3oeQYNumlOFwz3mBoVs11KJuT
 CEBVmVS9uvG7v9K7c1BPGy1mTBedL33wIKOEJpYo748FlNU51lYRJMZ9tJ+1DcMxwn
 05mzKsvG1V27jh7fh+fwzVn68zy9a6p9yQT3aXwg=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200112095936.GA17108@8bytes.org>
References: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 iommu-fixes-v5.5-rc5
X-PR-Tracked-Commit-Id: 55817b340a31951d23d1692db45522560b1d20f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 040a3c33623ba4bd11588ab0820281b854a3ffaf
Message-Id: <157885080357.18926.14855458420719655456.pr-tracker-bot@kernel.org>
Date: Sun, 12 Jan 2020 17:40:03 +0000
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

The pull request you sent on Sun, 12 Jan 2020 10:59:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/040a3c33623ba4bd11588ab0820281b854a3ffaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
