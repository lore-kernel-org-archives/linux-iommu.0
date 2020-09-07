Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB3C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD4E2087D
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB1zGfdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD4E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 898EF86749;
	Mon,  7 Sep 2020 16:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwoNiryt5iQ3; Mon,  7 Sep 2020 16:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF12D8528B;
	Mon,  7 Sep 2020 16:06:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA727C0052;
	Mon,  7 Sep 2020 16:06:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B21DDC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9E4D32152C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YTKFB5kQk5Rt for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 16:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id AE1EE21519
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C0ABD21789;
 Mon,  7 Sep 2020 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599494761;
 bh=u+k7kNV35vshUGOv/l53aOVXGrjP+5BmSgodlKTxJ1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EB1zGfdI/2Irq6huzU1qnpnAJgCC56yqMX8YrqhjMhF+71NiOtRxfBYvFWR0CL9rv
 ELZQCy6nONVEkOamdDCy0xQI+Ax0137BrSgVFoc1OJiYCCb/7uEWL6Uw8GHMGm3E+l
 r39M9YH667xes+vMr0eqvXmUfhUS/3GN+R6WJSYo=
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix l1 stream table size in the error
 message
Date: Mon,  7 Sep 2020 17:05:38 +0100
Message-Id: <159948439400.581956.11158746781131068189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200826141758.341-1-yuzenghui@huawei.com>
References: <20200826141758.341-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 wanghaibin.wang@huawei.com, kernel-team@android.com,
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

On Wed, 26 Aug 2020 22:17:58 +0800, Zenghui Yu wrote:
> The actual size of level-1 stream table is l1size. This looks like an
> oversight on commit d2e88e7c081ef ("iommu/arm-smmu: Fix LOG2SIZE setting
> for 2-level stream tables") which forgot to update the @size in error
> message as well.
> 
> As memory allocation failure is already bad enough, nothing worse would
> happen. But let's be careful.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Fix l1 stream table size in the error message
      https://git.kernel.org/will/c/dc898eb84b25

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
