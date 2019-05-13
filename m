Return-Path: <SRS0=HAYh=TN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8435FC04AA7
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:40:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EB62147A
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6I4z9cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EB62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 14E58DC5;
	Mon, 13 May 2019 13:40:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9FD40A49
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 66D4B27B
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:40:13 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557754813;
	bh=rWm1npmDCQiZfGCj5p9nObj1h65ayLSshpiWhCZnxJQ=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=i6I4z9cOE7jEoQdrxU6dKQncnLWoIZUqq54R/eNHCx64fP+neiqiznBvkUg+122uU
	8PNhV7mXCX6htKlawdWTn/aopsLFO0naF7xQkzyjjKvbCOzbxJsiiowZmWVlA/C+tj
	i+/T6UkCOAfSRNZyb6qaNak2fwkY0ztvue46cjJ0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190513115328.GA12854@8bytes.org>
References: <20190513115328.GA12854@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513115328.GA12854@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
	tags/iommu-updates-v5.2
X-PR-Tracked-Commit-Id: b5531563e8a0b8fcc5344a38d1fad9217e08e09b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a13f0655503a4a89df67fdc7cac6a7810795d4b3
Message-Id: <155775481315.19061.13502173457976680281.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2019 13:40:13 +0000
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

The pull request you sent on Mon, 13 May 2019 13:53:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a13f0655503a4a89df67fdc7cac6a7810795d4b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
