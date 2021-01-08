Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40519C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 23:49:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AF323AA7
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 23:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AF323AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8DA702E160;
	Fri,  8 Jan 2021 23:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCDpwhFq4xCW; Fri,  8 Jan 2021 23:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18438203EF;
	Fri,  8 Jan 2021 23:49:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE2F4C088B;
	Fri,  8 Jan 2021 23:49:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49CB4C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 23:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2511D2E15D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 23:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIrbRVSFYKa6 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 23:49:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 70F5C203EF
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 23:49:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 1A23023A9D;
 Fri,  8 Jan 2021 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610149742;
 bh=kVuMIv3ezT4SphLrIQOHZyCrYXc4poJVk7uyKGKQ/c8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=j94WOsYdYQSTI6fr9IhsyeGlaIiIRgYp2CFvpMJO34BjHRlzPqiGJPJ2Lg/zJ0bxl
 q9As4op4Pv+IgA+IJkxP18a78dDorPMkj6mCPJ56FaRCHMUhr2xjWiH4KCzwV+FfFJ
 0RKHdjN8kCkNoisk0M3oEQtQRgTiDZtWQzKEFWVQwgjDaOra7ahtufnxgiwG1iqVjB
 +4M2gP3S605sSqcuQanNntwq4KQfMfcTWMkL4fD9Appv+6cxHdrHWsob6SOIyPsYer
 hAkt7tZOjDbV25gedJIgPawr35Nzq2VGai+s7PJOIPHw2+GvB5u9Xmv607M0LgBZWA
 yzehjvju9+IYg==
Subject: Re: [GIT PULL] IOMMU fixes for -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210108143951.GA4867@willie-the-truck>
References: <20210108143951.GA4867@willie-the-truck>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210108143951.GA4867@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/iommu-fixes
X-PR-Tracked-Commit-Id: 7c29ada5e70083805bc3a68daa23441df421fbee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e2a590acbed38a6908a5c4df7754dcb65f6fd37
Message-Id: <161014974206.3246.14661746099090491156.pr-tracker-bot@kernel.org>
Date: Fri, 08 Jan 2021 23:49:02 +0000
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, torvalds@linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>
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

The pull request you sent on Fri, 8 Jan 2021 14:39:51 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e2a590acbed38a6908a5c4df7754dcb65f6fd37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
