Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69172C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 18:37:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BF264E5B
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 18:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BF264E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC07060590;
	Mon, 22 Feb 2021 18:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRo9uSlvEQB5; Mon, 22 Feb 2021 18:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3F5F6F589;
	Mon, 22 Feb 2021 18:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91587C000B;
	Mon, 22 Feb 2021 18:37:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7326BC0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 18:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53DF282FE7
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 18:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amXi7lyMi10v for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 18:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ACF082EB6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 18:37:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id D2F5F64E00;
 Mon, 22 Feb 2021 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614019018;
 bh=XqTM2owIRW5ymW2GMnJRwaO9PsQpx2QDxWNSLEu/UxM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Nti9P5o97v/TbNmpLrHntcqeB+H10Berc44BfJepDNGSU9Pvtix0IsF5S6ruTdK5G
 In3/jHlBjCRj8jL45uk0aP01VieBRBzBb4hl1nlngvaAr6aWaRgq3AqKLdu4aQ5qvd
 Aexe5DSp4D0Un4XNZLCH8Fru7LRWDwGxVFX6UT2NprVFgOZbqlIyLgCfMsxo9QC+yk
 t5LNrJaH7EXKuUacJFwAYV8NqD38rKaDwF5jl3lVoS15Fz7hxyc7j/yMZJT/My/hWP
 zsVFw2q8QHx3rztzdpCFzxeR/yjaHh0S8QsLNeAJZUxfKhueFIoVVJ+HHR/D2a0tmj
 yrkWzK2V/Lyug==
Subject: Re: [git pull] IOMMU Updates for Linux v5.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210222161729.GA26068@8bytes.org>
References: <20210222161729.GA26068@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210222161729.GA26068@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.12
X-PR-Tracked-Commit-Id: 45e606f2726926b04094e1c9bf809bca4884c57f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d652ea30ba32db12fe8365182fad5ba2e7c22822
Message-Id: <161401901883.24925.17382210599066419547.pr-tracker-bot@kernel.org>
Date: Mon, 22 Feb 2021 18:36:58 +0000
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

The pull request you sent on Mon, 22 Feb 2021 17:17:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d652ea30ba32db12fe8365182fad5ba2e7c22822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
