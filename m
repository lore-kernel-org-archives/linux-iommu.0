Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ADAC33CB3
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455D721739
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wUDJk1Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455D721739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04E2C20523;
	Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bCPNyKypS2w; Tue, 28 Jan 2020 22:00:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 267911FEBF;
	Tue, 28 Jan 2020 22:00:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFCDEC1D83;
	Tue, 28 Jan 2020 22:00:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96CBFC0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8FD8486C12
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f38c69lnGGrI for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:00:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail25.static.mailgun.info (mail25.static.mailgun.info
 [104.130.122.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C279B86BCF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580248845; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Mf6gK8Pui4SYiZYwgie2fpyV4QvxBlRoxDwIb21t6R0=;
 b=wUDJk1GiF7vPm2aaPE/vLTS2+48SZJ7v/b55y2C15q0zBPIxIDQTHOkxX/Jt4F+DEZkC6lEs
 dDilwmgNUn3Xq7g3bh1MIP4Vw4vnCrvlins8p62fzJ4EtGC5OksVabF6niFATzQMwxUBvGg9
 aKPa9EYhB1N+O+PxLLQlOXMewes=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30af04.7fe130c58228-smtp-out-n01;
 Tue, 28 Jan 2020 22:00:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 4539DC447AF; Tue, 28 Jan 2020 22:00:33 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 914EAC43383;
 Tue, 28 Jan 2020 22:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 914EAC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v5 0/5] iommu/arm-smmu: Split pagetable support for arm-smmu-v2
Date: Tue, 28 Jan 2020 15:00:14 -0700
Message-Id: <1580248819-12644-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Wen Yang <wen.yang99@zte.com.cn>,
 will@kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-arm-kernel@lists.infradead.org, Wambui Karuga <wambui.karugax@gmail.com>,
 freedreno@lists.freedesktop.org, Fritz Koenig <frkoenig@google.com>,
 linux-arm-msm@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>, Enrico Weigelt <info@metux.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 zhengbin <zhengbin13@huawei.com>, Daniel Vetter <daniel@ffwll.ch>,
 Drew Davenport <ddavenport@chromium.org>, Brian Masney <masneyb@onstation.org>,
 robin.murphy@arm.com, Georgi Djakov <georgi.djakov@linaro.org>
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

This is another iteration for the split pagetable support based on the
suggestions from Robin and Will [1].

Background: In order to support per-context pagetables the GPU needs to enable
split tables so that we can store global buffers in the TTBR1 space leaving the
GPU free to program the TTBR0 register with the address of a context specific
pagetable.

If the DOMAIN_ATTR_SPLIT_TABLES attribute is set on the domain before attaching,
the context bank assigned to the domain will be programmed to allow translations
in the TTBR1 space. Translations in the TTBR0 region will be disallowed because,
as Robin pointe out, having a un-programmed TTBR0 register is dangerous.

The driver can determine if TTBR1 was successfully programmed by querying
DOMAIN_ATTR_SPLIT_TABLES after attaching. The domain geometry will also be
updated to reflect the virtual address space for the TTBR1 range.

Upcoming changes will allow auxiliary domains to be attached to the device which
will enable and program TTBR0.

This patchset is based on top of linux-next-20200127.

Change log:

v4: Only program TTBR1 when split pagetables are requested. TTBR0 will be
enabled later when an auxiliary domain is attached
v3: Remove the implementation specific and make split pagetable support
part of the generic configuration

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041373.html

Jordan Crouse (5):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Add support for TTBR1
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
 drivers/gpu/drm/msm/msm_gem_vma.c        | 36 ++++------------------
 drivers/gpu/drm/msm/msm_gpu.c            | 49 ++----------------------------
 drivers/gpu/drm/msm/msm_gpu.h            |  4 +--
 drivers/gpu/drm/msm/msm_gpummu.c         |  6 ----
 drivers/gpu/drm/msm/msm_iommu.c          | 18 ++++++-----
 drivers/gpu/drm/msm/msm_mmu.h            |  1 -
 drivers/iommu/arm-smmu.c                 | 48 +++++++++++++++++++++++++-----
 drivers/iommu/arm-smmu.h                 | 22 ++++++++++----
 include/linux/iommu.h                    |  2 ++
 21 files changed, 198 insertions(+), 155 deletions(-)

-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
