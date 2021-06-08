Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D77C4743D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1B961358
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1B961358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96746606EA;
	Tue,  8 Jun 2021 11:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLZq6HbbAK5s; Tue,  8 Jun 2021 11:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACF666079D;
	Tue,  8 Jun 2021 11:42:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84F00C000B;
	Tue,  8 Jun 2021 11:42:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5845BC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D5534044D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZKt80Vr9aX9h for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:42:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6487A40424
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 791EB61364;
 Tue,  8 Jun 2021 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623152577;
 bh=bY8DNkX7vzFlmdAwO/oaPooA1JibNQ9/EzESl4Fuy0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vN/iDmxohvpkrpHSTgh8MhUcmx63RQRG/Nxlp6sMwZBn6On1oPgFBq1R5Tn4JApNp
 PjLM7/EJuwy85uF12XCr98DVywFSG+eSY0o4eJwSi8TMe+sYIwkgF5PhvLPlJiFk+d
 emy1LEfat7Lfu/dnAnqJ9TyC0znwHU00uyQJddcmG3wQ2LGDTehXRkVYTyWDZSk6C+
 4wiKMVUGS5Bagsd4W61/DnGWjKLb+FNZr9fJpRMifqDfbuudS5WguzPDnWilL0fsRw
 2sZgEBrCJwxjgNqDyb4+wFHFURNizHxkbwGeg3ZvEJ78MkVsOqgtPblA1DQuH+ca/2
 uLfh+6lSKKMNA==
From: Will Deacon <will@kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Decrease the queue size of evtq
 and priq
Date: Tue,  8 Jun 2021 12:42:37 +0100
Message-Id: <162314747848.3711241.13281936770478633279.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531123553.9602-1-thunder.leizhen@huawei.com>
References: <20210531123553.9602-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>
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

On Mon, 31 May 2021 20:35:53 +0800, Zhen Lei wrote:
> Commit d25f6ead162e ("iommu/arm-smmu-v3: Increase maximum size of queues")
> expands the cmdq queue size to improve the success rate of concurrent
> command queue space allocation by multiple cores. However, this extension
> does not apply to evtq and priq, because for both of them, the SMMU driver
> is the consumer. Instead, memory resources are wasted. Therefore, the
> queue size of evtq and priq is restored to the original setting, one page.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
      https://git.kernel.org/will/c/f115f3c0d5d8

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
