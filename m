Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D4BC433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BC820775
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eav8Bw+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BC820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62594877C4;
	Wed,  8 Jul 2020 22:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKFa6vW6c_qT; Wed,  8 Jul 2020 22:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3A3087710;
	Wed,  8 Jul 2020 22:03:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D620AC077B;
	Wed,  8 Jul 2020 22:03:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3B07C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 22:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A8A2A87233
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 22:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQVMyivjq1IH for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 22:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 53F498722F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2F822078C;
 Wed,  8 Jul 2020 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594245781;
 bh=E/vudvWWgrOMP+Ul19LafZmg3S5ficayHxrL/U28ueQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Eav8Bw+2NB+pEAgOzJ6gS1k6aJvJpT2OBddRrE2TKnIoEDQwDv+XTTm4XUOk+P4Hp
 04tsXVDOKjvf0U3RKZjc3+DfCqh5/JP7jIEVnvlr3soLIkrvGynk1V6zvbZPzCSS6V
 5zB1kMhatUdtqlybvePyeLrVytkB+f38UHxDztEY=
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu: Update impl quirks comment
Date: Wed,  8 Jul 2020 23:02:37 +0100
Message-Id: <159424067112.2034751.1237477027712722505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1e742177e084621f3454fbaf768325a6c215656a.1592994291.git.robin.murphy@arm.com>
References: <1e742177e084621f3454fbaf768325a6c215656a.1592994291.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
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

On Wed, 24 Jun 2020 11:24:51 +0100, Robin Murphy wrote:
> The comment about implementation and integration quirks being
> mutually-exclusive is out of date, and in fact the code is already
> structured for the case it anticipates, so document that properly.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Update impl quirks comment
      https://git.kernel.org/will/c/976492922a6a

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
