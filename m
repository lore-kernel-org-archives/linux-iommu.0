Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148DC2BA19
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A26220757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="udYBT7Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A26220757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1432284EE2;
	Thu,  9 Apr 2020 23:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id As_Ltt_br9gD; Thu,  9 Apr 2020 23:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8328C847EB;
	Thu,  9 Apr 2020 23:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B7FC1D7E;
	Thu,  9 Apr 2020 23:34:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7375BC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6740C87FC9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fk+Q4gvLifwK for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 23:34:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5FE9B87E39
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:34:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586475245; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HLu3LXKVdwRi2myzF6VISXReouVgdhBst/ZOPq5Z52I=;
 b=udYBT7VexZ/fYNgP4OdXmBK+I6C3gL02tlaZJiRdsZFyd62JQycz03OHY2rrkeMoP0utFD0L
 OxbAI8Q9WenFOW2qN4IeGc7S7j+ylyLM9eTlESWEbQg5f61TMVnADrmqaM6HUxKOWDXlYSuj
 a/CcYdMk8Mg/9IZ48Lt3JxITnBE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8fb0e9.7f8fb85663e8-smtp-out-n05;
 Thu, 09 Apr 2020 23:34:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 387B1C00448; Thu,  9 Apr 2020 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (c-71-237-101-98.hsd1.co.comcast.net
 [71.237.101.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A0FF5C433D2;
 Thu,  9 Apr 2020 23:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0FF5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v6 0/5] iommu/arm-smmu: Split pagetable support for arm-smmu-v2
Date: Thu,  9 Apr 2020 17:33:45 -0600
Message-Id: <20200409233350.6343-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Cc: Sam Ravnborg <sam@ravnborg.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 David Airlie <airlied@linux.ie>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Wen Yang <wen.yang99@zte.com.cn>,
 will@kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>,
 freedreno@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>, robin.murphy@arm.com,
 Abhinav Kumar <abhinavk@codeaurora.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 zhengbin <zhengbin13@huawei.com>, tongtiangen <tongtiangen@huawei.com>,
 Daniel Vetter <daniel@ffwll.ch>, Drew Davenport <ddavenport@chromium.org>,
 Wambui Karuga <wambui.karugax@gmail.com>, Enrico Weigelt <info@metux.net>,
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

This patchset is based on top of linux-next-20200409

Change log:

v6: Cleanups for the arm-smmu TTBR1 patch from Will Deacon
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

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c    | 16 ++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c    | 51 ++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  | 23 ++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h  |  8 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 18 +++------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 18 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c |  4 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 ++++-----
 drivers/gpu/drm/msm/msm_drv.h            |  8 +---
 drivers/gpu/drm/msm/msm_gem_vma.c        | 36 +++--------------
 drivers/gpu/drm/msm/msm_gpu.c            | 49 +----------------------
 drivers/gpu/drm/msm/msm_gpu.h            |  4 +-
 drivers/gpu/drm/msm/msm_gpummu.c         |  6 ---
 drivers/gpu/drm/msm/msm_iommu.c          | 18 +++++----
 drivers/gpu/drm/msm/msm_mmu.h            |  1 -
 drivers/iommu/arm-smmu.c                 | 48 ++++++++++++++++++----
 drivers/iommu/arm-smmu.h                 | 24 ++++++++---
 include/linux/iommu.h                    |  2 +
 21 files changed, 200 insertions(+), 155 deletions(-)

-- 
2.17.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
