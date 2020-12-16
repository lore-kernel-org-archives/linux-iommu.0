Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A52FC4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:04:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF91C23426
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF91C23426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5B688228E7;
	Wed, 16 Dec 2020 22:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-79OZzvJJF4; Wed, 16 Dec 2020 22:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6B93F21FA9;
	Wed, 16 Dec 2020 22:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB49C088E;
	Wed, 16 Dec 2020 22:04:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CDD2C013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8464387454
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYBM7B9fHO9y for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 22:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33B3387445
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:04:06 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608156245;
 bh=S/Ul4lH6lcWEirkzt4WMunpxcnDaYdmPn4tG6s6NqwM=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=cGouDdgckih4V/BB6n1tgELoYNw02Cx5InmYouvK4X8F8H7i0ZViU7+VHNJXh0apV
 fzKREuDoJxIcRADlqdXWcp2ZiXIZ9x8yKNVazWFqgCilZ0YcC3XCuD12Mq3R75zO8C
 HBN/SvwzsTi8u/dwAM+DlUGo+owD98MvvDElRKBahw3IlSVuA2M1exxVy/jBd3MbAd
 k2UJmkYmEXGGSSh5XR6I3DPmm9+gin1jMySTWg8M5ZODDWylKZyFmQNApCPfeT4Rrx
 VxiCW5Q9O10ebXf4fppk4nn5eyCH6MCj+2Xcxbl+c9zBtNi7EFc1CPRIXYSF0mMR3C
 zUFtu5RVnaLdA==
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201214234518.GA14575@willie-the-truck>
References: <20201214234518.GA14575@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214234518.GA14575@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/iommu-updates-v5.11
X-PR-Tracked-Commit-Id: 5ae9a046a452d60b6a6c076f6df7e3f8e34f918f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19778dd504b5ff5c3c1283aa3da7a56f34c2c3b0
Message-Id: <160815624564.26131.15399501793441701742.pr-tracker-bot@kernel.org>
Date: Wed, 16 Dec 2020 22:04:05 +0000
To: Will Deacon <will@kernel.org>
Cc: kernel-team@android.com, torvalds@linux-foundation.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
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

The pull request you sent on Mon, 14 Dec 2020 23:45:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-updates-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19778dd504b5ff5c3c1283aa3da7a56f34c2c3b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
