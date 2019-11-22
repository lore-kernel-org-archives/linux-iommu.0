Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC0C43141
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057AB20726
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mBKPgwEW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="G1l8UkSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057AB20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FCB187400;
	Fri, 22 Nov 2019 23:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfJtToBZCaOm; Fri, 22 Nov 2019 23:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 118AD87516;
	Fri, 22 Nov 2019 23:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1E00C1DDD;
	Fri, 22 Nov 2019 23:31:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A76AC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5DFA6883C3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zq6YXCSPGxCC for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 23:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-186.smtp-out.us-west-2.amazonses.com
 (a27-186.smtp-out.us-west-2.amazonses.com [54.240.27.186])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 88C21879F8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465509;
 h=From:To:Cc:Subject:Date:Message-Id;
 bh=6W+Hea0Amd6/uilOnF5QbG8DckcKj2ySVsuPY5EsZLg=;
 b=mBKPgwEWhAjRTwq5g/IQLGDPWRZpVPCIhcN5EZA0L7F1PfEDlXUehW4jSgZrzzaW
 1yGBCr3NjNz2Kvcvk4ICjTxrp5NYDuoh+WrfDGX+nkZRXsnhn49nGm5pfVP/Mn++VQl
 KF9azvFk0GV1+muQuuN80klN57AVbL9IHUTDIq2A=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465509;
 h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
 bh=6W+Hea0Amd6/uilOnF5QbG8DckcKj2ySVsuPY5EsZLg=;
 b=G1l8UkScWUAQTxmH+hUMluhXIZYBoxEiB/m/ejMg9mDUEgJUk73/E3eC6UDQf6VF
 TGN50Vfs0sb0PvI70XjmNZQg7cIz00QDZMhGRC6kpuEiBPQIpw0RWmbBz8KySCEjZZ2
 zL5dL0I49LABUuT1H5ftcc7US65RlAR5movu6CEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79D8FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/8] iommu/arm-smmu: Split pagetable support for Adreno GPUs
Date: Fri, 22 Nov 2019 23:31:49 +0000
Message-ID: <0101016e95751931-d40ed4f2-bcaf-4628-a856-12431fd92117-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2019.11.22-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Wen Yang <wen.yang99@zte.com.cn>,
 Jonathan Marek <jonathan@marek.ca>, will@kernel.org,
 Mamta Shukla <mamtashukla555@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Alexios Zavras <alexios.zavras@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>, Bruce Wang <bzwang@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Drew Davenport <ddavenport@chromium.org>,
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


Another refresh to support split pagetables for Adreno GPUs as part of an
incremental process to enable per-context pagetables.

In order to support per-context pagetables the GPU needs to enable split tables
so that we can store global buffers in the TTBR1 space leaving the GPU free to
program the TTBR0 register with the address of a context specific pagetable.

This patchset adds split pagetable support for devices identified with the
compatible string qcom,adreno-smmu-v2. If the compatible string is enabled and
DOMAIN_ATTR_SPLIT_TABLES is non zero at attach time, the implementation will
set up the TTBR0 and TTBR1 spaces with identical configurations and program
the domain pagetable into the TTBR1 register. The TTBR0 register will be
unused.

The driver can determine if split pagetables were programmed by querying
DOMAIN_ATTR_SPLIT_TABLES after attaching. The domain geometry will also be
updated to reflect the virtual address space for the TTBR1 range.

These patches are on based on top of linux-next-20191120 with [1], [2], and [3]
from Robin on the iommu list.

The first four patches add the device tree bindings and implementation
specific support for arm-smmu and the rest of the patches add the drm/msm
implementation followed by the device tree update for sdm845.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039718.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039719.html
[3] https://lists.linuxfoundation.org/pipermail/iommu/2019-October/039720.html


Jordan Crouse (8):
  dt-bindings: arm-smmu: Add Adreno GPU variant
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Pass io_pgtable_cfg to impl specific init_context
  iommu/arm-smmu: Add split pagetables for Adreno IOMMU implementations
  drm/msm: Attach the IOMMU device during initialization
  drm/msm: Refactor address space initialization
  drm/msm/a6xx: Support split pagetables
  arm64: dts: qcom: sdm845:  Update Adreno GPU SMMU compatible string

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  6 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  2 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              | 16 ++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 45 ++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 23 ++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  8 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 18 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           | 18 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |  4 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           | 18 ++--
 drivers/gpu/drm/msm/msm_drv.h                      |  8 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  | 37 ++-------
 drivers/gpu/drm/msm/msm_gpu.c                      | 49 +----------
 drivers/gpu/drm/msm/msm_gpu.h                      |  4 +-
 drivers/gpu/drm/msm/msm_gpummu.c                   |  6 --
 drivers/gpu/drm/msm/msm_iommu.c                    | 18 ++--
 drivers/gpu/drm/msm/msm_mmu.h                      |  1 -
 drivers/iommu/arm-smmu-impl.c                      |  6 +-
 drivers/iommu/arm-smmu-qcom.c                      | 96 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 52 +++++++++---
 drivers/iommu/arm-smmu.h                           | 14 +++-
 include/linux/iommu.h                              |  1 +
 25 files changed, 295 insertions(+), 158 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
