Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47209C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 18:13:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE8E64E88
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 18:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE8E64E88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7E3A72E12E;
	Fri,  5 Feb 2021 18:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ur869nVh0w3i; Fri,  5 Feb 2021 18:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0FDE520372;
	Fri,  5 Feb 2021 18:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A4F9C0174;
	Fri,  5 Feb 2021 18:13:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 601CBC013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 18:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4F1E287308
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 18:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VROYpv9c438 for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0E5D87311
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 18:13:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 7FE6F64E56;
 Fri,  5 Feb 2021 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612548790;
 bh=TuFNjPw1NsrOwjuRo3deQ7Iau/3JzS2c+Vvx+VpO4yA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=pUSxiIb+nPFA/B3n7GVwjiXtPRdn8tBBQIUbuZ8KbaAZ130Tl5Fq1hG+BFEIDGMGP
 oOiFSKcQed8jNCvl6o/MHoi6xyf1c8hBjuCoCaIHUfH07UveZCPPkuqJts6AntH+Jm
 6X0CHSNs3+TxxPTYrbVoeioCqd5CWXdY7c8xwnqd2d8mSmsmxOdLwrv3jiVCTKyaW9
 53UFQcs+6UqE2PdqOI7XrN7frLFiN1RT92iqJJd9s1M++V1EmGsxjwPCeyAjXZhHOn
 IV4exwKqrw0Rt4JCRXA3boPcrsgxn+P6guY/8cvDDed8zagR0HRp3owBALQbc+z41d
 6jlWjnVxQFC8w==
Subject: Re: [git pull] IOMMU Fix for Linux v5.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210205160146.GA28800@8bytes.org>
References: <20210205160146.GA28800@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210205160146.GA28800@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.11-rc6
X-PR-Tracked-Commit-Id: 4c9fb5d9140802db4db9f66c23887f43174e113c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ba0c7413f83ab3b43a5ba05362ecc837fce518
Message-Id: <161254879049.14736.13228089910092450378.pr-tracker-bot@kernel.org>
Date: Fri, 05 Feb 2021 18:13:10 +0000
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

The pull request you sent on Fri, 5 Feb 2021 17:01:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ba0c7413f83ab3b43a5ba05362ecc837fce518

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
