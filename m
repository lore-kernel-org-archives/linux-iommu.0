Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3AC31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 16:15:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B627217D6
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YucqWFdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B627217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2325115AC;
	Fri, 14 Jun 2019 16:15:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D54D415AB
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 16:15:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3F0F174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 16:15:07 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560528907;
	bh=2+K1vZzfZH05W3JJSs2Pul0tXH3bGKmc3kyN/HUe408=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=YucqWFdDpXXrp06J+Ete4AZ/0gdaFlsf+io5xEBba/4HmcJ1KS/cR1v3i5/NoZLdZ
	gNbUo8OmYCNFAi+CdvrxdTTFKRdkKBaCGs3z359JmXRistAxlpoivmTuwL0N3GWyaA
	J+5HhOZNKtE7cz9e6QTm0lLmO81bHBuQ38MVYP5Q=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190614093854.GA10155@8bytes.org>
References: <20190614093854.GA10155@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190614093854.GA10155@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-fixes-v5.2-rc4
X-PR-Tracked-Commit-Id: 4e4abae311e4b44aaf61f18a826fd7136037f199
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c78ad1be4b4d65eb214421b90a788abf3c85c3ea
Message-Id: <156052890740.10292.7234479296212051919.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2019 16:15:07 +0000
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

The pull request you sent on Fri, 14 Jun 2019 11:39:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c78ad1be4b4d65eb214421b90a788abf3c85c3ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
