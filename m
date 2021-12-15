Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42449C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 10:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9CEA60E30;
	Wed, 15 Dec 2021 10:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSzR5VJUdKjF; Wed, 15 Dec 2021 10:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C0B9A60E07;
	Wed, 15 Dec 2021 10:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99407C002F;
	Wed, 15 Dec 2021 10:49:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0EA7C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 10:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80C81410D2
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 10:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcwH7vsdNmpI for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 10:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EB3C410D1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 10:49:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5FD91B81EC1;
 Wed, 15 Dec 2021 10:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B03EC34605;
 Wed, 15 Dec 2021 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639565377;
 bh=gWDre0MhLRPLuYdlG+NZcyZGCWS+xSxbacr8UkX2D1M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BXesnsXs/wCVpbJrE1kSFnU07iHLvNMYE6rBSMlfCQaxbaEpwxIWn2siN2jgzj/+/
 MeAfzX7v9aDUAxJI3LqmHdlarMtjCQk8tWCWpIgGAJMBpOR4Gpuk83tGj+s1MQ700G
 od1uoRsfsPugk9wJeML4Z/U/geRVnH88LPCG/4b8STBbaBRzUqoVXW7XtZaYr5oEFA
 EC95sB//rWJVngvuDAwfIt26hZQciu4JzLPBUNyff0UEaGguCDXPJRfmpOUQha+q1T
 YTdlRiTjabyumDbWuddHDm/ll+uJQFXUQKPQbKZgIedfupbC/fuEtUjYIHp03wtAWV
 f8RpysdzPYXSQ==
From: Will Deacon <will@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "iommu/arm-smmu-v3: Decrease the queue size of
 evtq and priq"
Date: Wed, 15 Dec 2021 10:49:30 +0000
Message-Id: <163956324640.2477372.9935164271328492606.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
References: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 7 Dec 2021 14:32:48 +0800, Zhou Wang wrote:
> The commit f115f3c0d5d8 ("iommu/arm-smmu-v3: Decrease the queue size of
> evtq and priq") decreases evtq and priq, which may lead evtq/priq to be
> full with fault events, e.g HiSilicon ZIP/SEC/HPRE have maximum 1024 queues
> in one device, every queue could be binded with one process and trigger a
> fault event. So let's revert f115f3c0d5d8.
> 
> In fact, if an implementation of SMMU really does not need so long evtq
> and priq, value of IDR1_EVTQS and IDR1_PRIQS can be set to proper ones.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq"
      https://git.kernel.org/will/c/477436699e78

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
