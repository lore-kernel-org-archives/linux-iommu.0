Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A42C2D0BF
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459EC206E0
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d+rra/2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459EC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B50F21F76;
	Mon, 16 Dec 2019 16:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+r+LC8QFul5; Mon, 16 Dec 2019 16:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2F58121567;
	Mon, 16 Dec 2019 16:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C72DC18DD;
	Mon, 16 Dec 2019 16:43:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA883C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 16:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B81F721577
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 16:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJs5AEaf7ESF for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 16:43:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id DBCEB21563
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 16:43:09 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1576514590; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Vr7DeB6UN1uAvIEGB/iA7hx6Y0Q4rdMGj2xmO945Nsw=;
 b=d+rra/2GyodJgV2l4pIWqwMbymbH9g90QivEZy9jOwjX/ZX0XbK6fD+7wt65K3A1jD36u72k
 4YuXo3s3CDiuB8OZpx45qFoPY6bc/gGvpkOi7H2CKWuT9dCxcQ162AnFKPq4Vams1Uuo3XTi
 YpWKvblRaZqSHrIxhxyEYqUcGhA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df7b2e9.7f650ebdd570-smtp-out-n02;
 Mon, 16 Dec 2019 16:38:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B9566C447AE; Mon, 16 Dec 2019 16:37:59 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DE5A9C433CB;
 Mon, 16 Dec 2019 16:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE5A9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/5] iommu/arm-smmu: Split pagetable support for arm-smmu-v2
Date: Mon, 16 Dec 2019 09:37:46 -0700
Message-Id: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>,
 will@kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
 Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org,
 Brian Masney <masneyb@onstation.org>, freedreno@lists.freedesktop.org,
 Fritz Koenig <frkoenig@google.com>, linux-arm-msm@vger.kernel.org,
 Alexios Zavras <alexios.zavras@intel.com>,
 Jeykumar Sankaran <jsanka@codeaurora.org>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 zhengbin <zhengbin13@huawei.com>, Daniel Vetter <daniel@ffwll.ch>,
 Drew Davenport <ddavenport@chromium.org>, robin.murphy@arm.com,
 Georgi Djakov <georgi.djakov@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Another refresh to support split pagetables for Adreno GPUs as part of an
incremental process to enable per-context pagetables.

In order to support per-context pagetables the GPU needs to enable split tables
so that we can store global buffers in the TTBR1 space leaving the GPU free to
program the TTBR0 register with the address of a context specific pagetable.

This patchset adds split pagetable support if requested by the domain owner
via the DOMAIN_ATTR_SPLIT_TABLES attribute. If the attribute is non zero at
attach time, the implementation will set up the TTBR0 and TTBR1 spaces with
identical configurations and program the domain pagetable into the TTBR1
register. The TTBR0 register will be unused.

The driver can determine if split pagetables were programmed by querying
DOMAIN_ATTR_SPLIT_TABLES after attaching. The domain geometry will also be
updated to reflect the virtual address space for the TTBR1 range.

These patches are on based on top of linux-next-20191216 with [1], [2], and [3]
from Robin on the iommu list.

Change log:

v3: Remove the implementation specific and make split pagetable support
part of the generic configuration

[1] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039718.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039719.html
[3] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039720.html


Jordan Crouse (5):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Add support for split pagetables
  drm/msm: Attach the IOMMU device during initialization
  drm/msm: Refactor address space initialization
  drm/msm/a6xx: Support split pagetables

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c    | 16 ++++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c    | 51 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  | 23 ++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h  |  8 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 18 ++++-------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 18 +++++------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c |  4 ---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 +++++------
 drivers/gpu/drm/msm/msm_drv.h            |  8 ++---
 drivers/gpu/drm/msm/msm_gem_vma.c        | 37 +++++------------------
 drivers/gpu/drm/msm/msm_gpu.c            | 49 ++----------------------------
 drivers/gpu/drm/msm/msm_gpu.h            |  4 +--
 drivers/gpu/drm/msm/msm_gpummu.c         |  6 ----
 drivers/gpu/drm/msm/msm_iommu.c          | 18 ++++++-----
 drivers/gpu/drm/msm/msm_mmu.h            |  1 -
 drivers/iommu/arm-smmu.c                 | 40 +++++++++++++++++++++----
 drivers/iommu/arm-smmu.h                 | 45 ++++++++++++++++++++++++----
 include/linux/iommu.h                    |  1 +
 21 files changed, 215 insertions(+), 153 deletions(-)

-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
