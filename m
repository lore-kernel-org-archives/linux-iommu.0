Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1DC5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 14:05:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A2A206E5
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8DCxn5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A2A206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B357886CEF;
	Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIXZMaDmzM2s; Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2499186B17;
	Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05568C0891;
	Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0371C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A6C9586D24
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmfd_FW1ZYIx for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 14:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3E51486B96
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBAF3206D4;
 Wed, 25 Nov 2020 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606313126;
 bh=o/3qU9yUVsMRXBPb0/qlY5lVdmNZJsg8udd9M106/9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G8DCxn5J/JaU/e93TuntnK4oh0Kn/xsPcKugLOLB+XfEZqAVNtLJt4J7FrmsO4IUe
 goFFx0ywrjqH6A070RdD+kHWfNDB9KqRmCXZzG3UiO/RNLy4yPLrCG3ChyEIX6BWsF
 s0CfmZ/VDxamoqXudWTtMmtU4s03HAkWJG3iAXH8=
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is forced
 on
Date: Wed, 25 Nov 2020 14:05:15 +0000
Message-Id: <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, tboot-devel@lists.sourceforge.net,
 Adrian Huang <ahuang12@lenovo.com>, kernel-team@android.com
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

On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> domain"), swiotbl could also be used for direct memory access if IOMMU
> is enabled but a device is configured to pass through the DMA translation.
> Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> if "iommu=pt" kernel parameter is used.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
      https://git.kernel.org/arm64/c/e2be2a833ab5

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
