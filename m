Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394DC64E7B
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 15:15:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1F32076C
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqxO0kqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1F32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5A2BD236B5;
	Tue,  1 Dec 2020 15:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A24+bBfPQtz3; Tue,  1 Dec 2020 15:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7225C2048D;
	Tue,  1 Dec 2020 15:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52B13C1833;
	Tue,  1 Dec 2020 15:14:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D357C0859
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 15:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 739C986B3A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 15:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtYOA9aPhjas for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 15:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D50786AD9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8DC2A20758;
 Tue,  1 Dec 2020 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606835694;
 bh=HMmHyNZfTEpkSnUg73w6HsRLWnEh1qItRUUnj3WI6B8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uqxO0kqdze7c7XWhe0fDabyPcf8U1NmRfSSyhXqvQyJ0K7sWDaJdX0EitKMslaR9O
 o6t0Vikyo+iXHM//02S8QHCC7HLuh4xNH1Ylg8ATR5QhKs9eKWSBt4jPYNyNzMbQ4J
 3akyPgw4GVaMlKEvIMmbTdrr8UErkd1ugxmuq4xU=
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: patches for v5.11
Date: Tue,  1 Dec 2020 15:14:48 +0000
Message-Id: <160683494055.4078099.9348533428206914795.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201201013149.2466272-1-baolu.lu@linux.intel.com>
References: <20201201013149.2466272-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-team@android.com,
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

On Tue, 1 Dec 2020 09:31:48 +0800, Lu Baolu wrote:
> Below patch is ready for v5.11. It includes:
> 
>  - Avoid GFP_ATOMIC where it is not needed
> 
> Can you please consider it for v5.11?
> 
> Best regards,
> Lu Baolu
> 
> [...]

Applied to arm64 (for-next/iommu/vt-d), thanks!

[1/1] iommu/vt-d: Avoid GFP_ATOMIC where it is not needed
      https://git.kernel.org/arm64/c/33e07157105e

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
