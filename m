Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42BC4332F
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 16:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48DB64094C;
	Tue,  8 Feb 2022 16:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMMfPGI-A2E1; Tue,  8 Feb 2022 16:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D0B24086D;
	Tue,  8 Feb 2022 16:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 156EBC001A;
	Tue,  8 Feb 2022 16:22:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDEA5C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEF304086D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fbw8o0NBqyP1 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 16:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0293540243
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 83D2AB81C11;
 Tue,  8 Feb 2022 16:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA85C340E9;
 Tue,  8 Feb 2022 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644337333;
 bh=MejpiH0diIFxacygh8l6EcAFhF9ZPTI/1saRrB4FEHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C3WubjhTrezZEmOoDNOWDkqOhjIIkSEZxvmA73rQzLCtBhiePAR2kA1dryjSJVYBe
 NWjwkPH3Af4gTZvROlC8XGmMAafkCX4QgEzauAO1ftCegAqnSr5KkiK5iHGl4TAhaY
 YdU6zmsr98mqhbZp16LUFhkD3JVo7xEGBIYjFkF2Ggc1rZgAqDVEuw8l1IbPwMBN/i
 jTdh1fFWY6jKI/BFGMSm4VE9oR7y7nztfxp4vsbYi9QojgsakO/29QEqGk9eXIeV1L
 SBF85MJzqqtxBdt6iOHR6jHbFIyk0ksFJCilG9axZhOx47m2ZJFXk9yVIuNY0dP5dU
 wdxVd/a80nWHg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org, Zhou Guanghui <zhouguanghui1@huawei.com>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix event handling soft lockup
Date: Tue,  8 Feb 2022 16:21:56 +0000
Message-Id: <164433646915.1069624.13877694890558987574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220119070754.26528-1-zhouguanghui1@huawei.com>
References: <20220119070754.26528-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, xuqiang36@huawei.com, kernel-team@android.com
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

On Wed, 19 Jan 2022 07:07:54 +0000, Zhou Guanghui wrote:
> During event processing, events are read from the event queue one
> by one until the queue is empty.If the master device continuously
> requests address access at the same time and the SMMU generates
> events, the cyclic processing of the event takes a long time and
> softlockup warnings may be reported.
> 
> arm-smmu-v3 arm-smmu-v3.34.auto: event 0x0a received:
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x00007f220000280a
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x000010000000007e
> arm-smmu-v3 arm-smmu-v3.34.auto: 	0x00000000034e8670
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [irq/268-arm-smm:247]
> Call trace:
>  _dev_info+0x7c/0xa0
>  arm_smmu_evtq_thread+0x1c0/0x230
>  irq_thread_fn+0x30/0x80
>  irq_thread+0x128/0x210
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x1c
> Kernel panic - not syncing: softlockup: hung tasks
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: fix event handling soft lockup
      https://git.kernel.org/will/c/30de2b541af9

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
