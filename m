Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A4C433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C974230FB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C974230FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FF52855EF;
	Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mwRt2pqaCpXN; Tue,  5 Jan 2021 22:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B60A785570;
	Tue,  5 Jan 2021 22:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8362C088B;
	Tue,  5 Jan 2021 22:07:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B474CC013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BCC9871CA
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNgYaVf1kEQ7 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3DD6186F1B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AF8422D75;
 Tue,  5 Jan 2021 22:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609884429;
 bh=QKouQDs5mHt1pS/Y2SeBb6oJBFvZCDfzTFkJdGgVs1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ITOWwX2rcOhhLmvDkNKzFrD2LxFRdIE0wkVUq0VDROLZxXGOSsH+fAUPM4+GQ6+vK
 K8z72IFnwhDIH94i/fVMzO4hM/69U7wRGS5CsnHgKPUp8rhUMT3r7m37Y1PqlGAbsi
 VaAx/35TIeN3xYMemCqE4xGm6NoT+mTTFTIFtpbDfseCchoft1LsuWA+jCbZwOkLGz
 227YFFVlq60iGVAc97odi1HkrxwJcMdG1HojSQrAwLegNs3SurTiZTeQjtFQVDztfF
 vTPe+A0scAMsVwAc8O6xyiadPA60uav2BIh9B1DLcFWArEkGF4r1t6wkdzF+UUyR1a
 IqcFXNJkiB9Bw==
From: Will Deacon <will@kernel.org>
To: kjlu@umn.edu,
	Dinghao Liu <dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] [v2] iommu/intel: Fix memleak in intel_irq_remapping_alloc
Date: Tue,  5 Jan 2021 22:07:00 +0000
Message-Id: <160987392685.28117.15806761775546828125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
References: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, Jiang Liu <jiang.liu@linux.intel.com>
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

On Tue, 5 Jan 2021 13:18:37 +0800, Dinghao Liu wrote:
> When irq_domain_get_irq_data() or irqd_cfg() fails
> at i == 0, data allocated by kzalloc() has not been
> freed before returning, which leads to memleak.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/intel: Fix memleak in intel_irq_remapping_alloc
      https://git.kernel.org/arm64/c/ff2b46d7cff8

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
