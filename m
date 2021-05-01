Return-Path: <SRS0=qG/d=J4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B2C433B4
	for <iommu@archiver.kernel.org>; Sat,  1 May 2021 17:20:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C2A614A7
	for <iommu@archiver.kernel.org>; Sat,  1 May 2021 17:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C2A614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA3AB419F6;
	Sat,  1 May 2021 17:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21AaxgXNKzOo; Sat,  1 May 2021 17:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94632419EC;
	Sat,  1 May 2021 17:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFB9C000E;
	Sat,  1 May 2021 17:20:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE45FC0001
 for <iommu@lists.linux-foundation.org>; Sat,  1 May 2021 17:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C006F4027E
 for <iommu@lists.linux-foundation.org>; Sat,  1 May 2021 17:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ug5eQLyLVfA for <iommu@lists.linux-foundation.org>;
 Sat,  1 May 2021 17:20:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18694401F7
 for <iommu@lists.linux-foundation.org>; Sat,  1 May 2021 17:20:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 48B5D61625;
 Sat,  1 May 2021 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619889654;
 bh=t/3lgDnpeyvCdPtZDjLXkOXI5cE2Vg0kvNu9zEys41E=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=AWEXf1eQRWeTEF+40JT8DkVdBLPEuwrtWAFBHpOqoL+x09uN5kmw9ub9WLvTvBvC4
 XAqO5StzQLoxhDudwrPV0MkYpLuR0OaKIBbdTXwq2gObicfaUXdl3Gjictvr9qnPVV
 0Zg00puaAWDh3/IGn/qeTo5yBkWJIomICSQBQcaapmnxuF0DtYXs+fwjoHITAOR5rt
 Cscg9TUegI+DCWKdBZD1JNMAFqW0KUJryPttMeuWkiveRyZ6hEtEPQ1VC3R27JT9/z
 g9Abb9n0msQ2wtS26RKvv3dSSYBTMfYlFCNj9lhMIFO4tKCZTC7H0bB5ojqj70Gbip
 l2dXcrkxMGkLg==
Subject: Re: [git pull] IOMMU Updates for Linux v5.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <YIwRbkQcElemYSjz@8bytes.org>
References: <YIwRbkQcElemYSjz@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YIwRbkQcElemYSjz@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.13
X-PR-Tracked-Commit-Id: 2d471b20c55e13c98d1dba413bf2de618e89cdac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f9701057a9cc1ae6bfc533204c9d3ba386687de
Message-Id: <161988965426.32500.6869537324714282066.pr-tracker-bot@kernel.org>
Date: Sat, 01 May 2021 17:20:54 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
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

The pull request you sent on Fri, 30 Apr 2021 16:17:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f9701057a9cc1ae6bfc533204c9d3ba386687de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
