Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AA2C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6E8225AB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6E8225AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB21387458;
	Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRC+4DZA0q6I; Mon, 25 Jan 2021 11:08:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 29FC38744A;
	Mon, 25 Jan 2021 11:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C576C0FA7;
	Mon, 25 Jan 2021 11:08:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52685C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 490FC86762
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LPRqo3SDtcEi for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 11:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6CF93866F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:43 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id m187so10307835wme.2
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L6FzDVWaEEDJLy1ZljH6o/Vmgdxo9JDDb7VAWw5br1s=;
 b=z15BQeUBB8VJb9yD2URB91vmkJHi2zOy3Q34XsHOPk0xk5wiDYl7tdaS4gsd+3N2T+
 fMYFFOFRh3dxoSEmiWempbG7aD9RfYjINgLwMfkhkTxhO/Itm+Mh5sFd3VGII8HUAWR4
 br9XJRJWbB8OcvgDNLmdwgl0H52zwg9lChy3GAEXZMtuAx8MRrjcuhnddLNlKvjRzEp2
 zQR3KB6jWakZURZ2hVfPGVPxo5sTSy8UD+WchIijFKZS/nzuW6Wvya7RtHfwZkMQci1W
 Q9JiRc/cmrkiwa3XOJcH5PtKJFX9S8yPk+nh5JwoGjzc4+VyqxHi1m/HLHN14yjSDWs3
 stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L6FzDVWaEEDJLy1ZljH6o/Vmgdxo9JDDb7VAWw5br1s=;
 b=CkW+SwnNFqfZPxFYSmRUURRNc8gIxBSvhsEVGKT1x9A59hFPoAsEpiaJsKAxOvid0k
 jpbTsZ7cKoC4/8jiev1dJIYRwTZ0cfqBAOET0FUsR1kj7Z+B9SmXJIN6ffPbaE4P8Cdg
 wma9hEDofXIj25TaoZHb9sZi/4VxIzBT667HfoFPZzTH/T8qYxYA2YDSFvI3EUvcEvae
 ZHNLzB8JHHQKtCIze0EsIMbgzy5eCcSnJWfIPVO1bqN7oG8+eiJyq9QxnwFxp40/jJPE
 JzYcuhQJfn4pMXpMLyJ+C/+Ogo7mD2LXEE0bpuzr6a4cSnOVEM3NsyVeV6lno/3vN17L
 XF2A==
X-Gm-Message-State: AOAM532hWwZpcRIEV2YtQT7vguf9yOQTq0gSsTUfoZJuilxxnrXum9sv
 a9PDeW5LojOJxEEeCcYTEnLEow==
X-Google-Smtp-Source: ABdhPJx4ipeZUtiOJeZtJOpzaet9OUvA/7DVVO4eH4Qnc3/pg38U0sy5ZrThSKDxr751NTEqfXQ9qQ==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr6006695wmc.39.1611572921919; 
 Mon, 25 Jan 2021 03:08:41 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 03:08:41 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v11 00/10] iommu: I/O page faults for SMMUv3
Date: Mon, 25 Jan 2021 12:06:41 +0100
Message-Id: <20210125110650.3232195-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Add stall support to the SMMUv3, along with a common I/O Page Fault
handler.

This version fixes a typo introduced in v10 [1] and adds review tags
(thanks!) You can find the range diff for v10->v11 below.

[1] https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (10):
  iommu: Fix comment for struct iommu_fwspec
  iommu/arm-smmu-v3: Use device properties for pasid-num-bits
  iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
  iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
  uacce: Enable IOMMU_DEV_FEAT_IOPF
  iommu: Add a page fault handler
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices

 drivers/iommu/Makefile                        |   1 +
 .../devicetree/bindings/iommu/iommu.txt       |  18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  56 ++-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |  26 +-
 drivers/acpi/arm64/iort.c                     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 349 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1019 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c


-- 
 @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static void arm_smmu_release_device(struct device *dev)
    master = dev_iommu_priv_get(dev);
-   WARN_ON(arm_smmu_master_sva_enabled(master));
-+  iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+-  WARN_ON(arm_smmu_master_sva_enabled(master));
++  if (WARN_ON(arm_smmu_master_sva_enabled(master)))
++          iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
    arm_smmu_detach_dev(master);
    arm_smmu_disable_pasid(master);
    arm_smmu_remove_master(master);
@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static struct iommu_ops arm_smmu_op
    .pgsize_bitmap          = -1UL, /* Restricted during device attach */
  };
  
-@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
- static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
- {
-   int ret;
-+  bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;
- 
-   /* cmdq */
-   ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
 @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
    if (ret)
            return ret;
  
-+  if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
++  if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
++      (smmu->features & ARM_SMMU_FEAT_STALLS)) {
 +          smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 +          if (!smmu->evtq.iopf)
 +                  return -ENOMEM;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
