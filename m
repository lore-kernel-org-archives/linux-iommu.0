Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B1C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:04:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132E02087E
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML1KRP0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132E02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E89E853D9;
	Fri,  6 Nov 2020 13:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcUBGXeaTUSM; Fri,  6 Nov 2020 13:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 302868502A;
	Fri,  6 Nov 2020 13:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9E0C0893;
	Fri,  6 Nov 2020 13:04:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0796C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB7532E119
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IrYuNrsAWMs0 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 13:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0DA582E115
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02ECB208B8;
 Fri,  6 Nov 2020 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604667885;
 bh=cC/J7ZAo6ygcwSZVGqFQd40kAxaIspe68gfu67AM8NQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ML1KRP0YhdAsl8w6Ubt0nz0It9sWII3JaspYf3HOUXtJDPYB2lZVyXwH2LpkV+RUf
 Xii0uVtAGcR9BjSSpyl8dgcW/AigPVURkG1BZ6y9/II7gAotQ/BeY2BI+DF9mvE/v7
 Xieb5YqWx+CmhZ6KIg7CMixNF2f8SZ+8sB/EnMf4=
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu: Use new devm_krealloc()
Date: Fri,  6 Nov 2020 13:04:36 +0000
Message-Id: <160466631075.2597.12844533585330278381.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <355e8d70c7f47d462d85b386aa09f2b5c655f023.1603713428.git.robin.murphy@arm.com>
References: <355e8d70c7f47d462d85b386aa09f2b5c655f023.1603713428.git.robin.murphy@arm.com>
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

On Mon, 26 Oct 2020 12:00:22 +0000, Robin Murphy wrote:
> The implementation-specific subclassing of struct arm_smmu_device really
> wanted an appropriate version of realloc(). Now that one exists, take
> full advantage of it to clarify what's actually being done here.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Use new devm_krealloc()
      https://git.kernel.org/will/c/af9da91493e5

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
