Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053EEC43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 23:05:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA692084E
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7z8ii+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA692084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6DE27189F;
	Sat, 22 Jun 2019 23:05:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C79F5189E
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 23:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 916E3224
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 23:05:04 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561244704;
	bh=7QUak2VryUzJwlPALMoUzkXCarUVSfSF93ogRPYy7Rw=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=G7z8ii+ZisH9XgKUpYJfVPRw5IkNG/61M7CIvWj85/D4T8f59zeVh5jRguBtaTHOF
	L5wlNVE5NiiU6RVKS/7w3LUf33OPK4Ru/lknH7a7svM2V1NqCD4lL9Irwf2/SFQcTD
	9I4AJq6PvfVvK41ZhRJc1jaFjmWvYaxESPgK2W8Y=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190622194641.GA5200@8bytes.org>
References: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fix-v5.2-rc5
X-PR-Tracked-Commit-Id: 0aafc8ae665f89b9031a914f80f5e58825b33021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6698a71a1e360d89514aafcea15ccff837f59038
Message-Id: <156124470420.733.3742446385319983333.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2019 23:05:04 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The pull request you sent on Sat, 22 Jun 2019 21:46:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6698a71a1e360d89514aafcea15ccff837f59038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
