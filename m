Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A5C4361B
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 15:54:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22A023AC0
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22A023AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6216E203B9;
	Tue,  8 Dec 2020 15:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Ll914yhpuUK; Tue,  8 Dec 2020 15:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 949F420336;
	Tue,  8 Dec 2020 15:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 776F1C0FA7;
	Tue,  8 Dec 2020 15:54:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40C09C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 15:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 279A987492
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 15:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wh3hON7N1PXj for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 15:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9737B8748F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 15:54:38 +0000 (UTC)
From: Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Joerg Roedel <joro@8bytes.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Kunkun Jiang <jiangkunkun@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] iommu/io-pgtalbe-arm: Remove "iopte_type(pte,
 l)" extra parameter "l"
Date: Tue,  8 Dec 2020 15:54:29 +0000
Message-Id: <160743594324.2814527.17080141528844810125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207120150.1891-1-jiangkunkun@huawei.com>
References: <20201207120150.1891-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, wanghaibin.wang@huawei.com,
 Keqian Zhu <zhukeqian1@huawei.com>
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

On Mon, 7 Dec 2020 20:01:50 +0800, Kunkun Jiang wrote:
> Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
> parameter "l" (level). So we'd better to remove it.

Applied to arm64 (for-next/iommu/misc), thanks!

[1/1] iommu/io-pgtalbe-arm: Remove "iopte_type(pte, l)" extra parameter "l"
      https://git.kernel.org/arm64/c/f37eb48466d2

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
