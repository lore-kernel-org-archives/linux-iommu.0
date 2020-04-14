Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC724C2BB85
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21BC20678
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEj+O1VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21BC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7E2FA85CFF;
	Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7la9BTHF-3Zl; Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40FD385D17;
	Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 348F9C089E;
	Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F9B1C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0749686DAB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z33lAUXYh2QI for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 530A485736
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:19 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x4so13826102wmj.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fDR92FG/W9XzyoEKCk0ZF8N6Phe9WGPiX+0dpA5beXc=;
 b=NEj+O1VPlDE3+b9GRhqJpb7imwatVrbEHRPijSau+X9Vbg+US5qIqjILEeTsiMZyzd
 Jbi8pl9C2UJZk5wt+F2ohcMMgOlmn6vRXNL+oLg3PX1OQyFq5Vi7QeyaSHWpCnKH9wwW
 BQcMuKVX1Kxci3T4tlG5aUlteOmxPqpT3W6wO26dWN/t7wdHaxqmgBUfDWUgwMMU2ufA
 pOJXldxAAh12JJAT7GYE/YQAYLgMhCdkm9Y3ZNUlaySCcDtsLm5njdvcwhqHN+ekOPfb
 7Kguikc/vkv7QzJrcpWobUk53WblaNZeBLUQoi01vtQvlCASM3Ery/NF+KrJ8hZbl8nn
 tsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fDR92FG/W9XzyoEKCk0ZF8N6Phe9WGPiX+0dpA5beXc=;
 b=BCc6IIHvMPqiDGXRKp9IteLQqfibxsdXGhoMPQ8/Bfunz0za/hjgt21Jf0GhkqWv4N
 v7zwxviSxjcVpcQI7loCCTeMubZblCHpPnq2YW/mQgJ2gNd1awENfM3VmDifIJpnLWKQ
 WLjfi1sflBdRlNrPdETmr/tIvWM6GMl5zKkVj6853KBA5moNKRZUHxSyZOC3or8u5/46
 5/sJ6N0I7uYmSh7tvzhXkJCq/yqhN6Yamim79lWGImjbCwiPreossv7tsFQsUJSNFIGt
 3tH19f2FhmctNIJbvH6Vd6Sd5DjMdV/BGyxQKywFPiH2ww1MWxmBMNNWIuvCzjGs2bwv
 gGKQ==
X-Gm-Message-State: AGi0PuY2mzLCkfycmjVPALHGUquybyRtAlSNY2i9rYl4aBF4+MlSDLTe
 abPhQ49vjyrphNFR5q2GgI/wg64EyTiOjA==
X-Google-Smtp-Source: APiQypIdArRSrPXSdknP2IMK7ppxpSO4QpwtmnnSeA+CSALQDIlf3m4G7fjFu80JrmrhRYEK5Otokw==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr723817wmh.157.1586883857511; 
 Tue, 14 Apr 2020 10:04:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:16 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 00/25] iommu: Shared Virtual Addressing and SMMUv3 support
Date: Tue, 14 Apr 2020 19:02:28 +0200
Message-Id: <20200414170252.714402-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

Shared Virtual Addressing (SVA) allows to share process page tables with
devices using the IOMMU. Add a generic implementation of the IOMMU SVA
API, and add support in the Arm SMMUv3 driver.

Since v4 [1] I changed the PASID lifetime. It isn't released when the
corresponding process address space dies, but when the device driver calls
unbind. This alleviates the mmput() path as we don't need to ensure that
the device driver stops DMA there anymore. For more details see my
proposal from last week [2], which is a requirement for this series. As a
result patch 1 has separate clear() and detach() operations, and patch 17
has a new context descriptor state. 

Other changes are a simplification of the locking in patch 1 and overall
cleanups following review comments.

[1] [PATCH v4 00/26] iommu: Shared Virtual Addressing and SMMUv3 support
    https://lore.kernel.org/linux-iommu/20200224182401.353359-1-jean-philippe@linaro.org/
[2] [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
    https://lore.kernel.org/linux-iommu/20200408140427.212807-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (25):
  mm/mmu_notifiers: pass private data down to alloc_notifier()
  iommu/sva: Manage process address spaces
  iommu: Add a page fault handler
  iommu/sva: Search mm by PASID
  iommu/iopf: Handle mm faults
  iommu/sva: Register page fault handler
  arm64: mm: Add asid_gen_match() helper
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/io-pgtable-arm: Move some definitions to a header
  iommu/arm-smmu-v3: Manage ASIDs with xarray
  arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Enable broadcast TLB maintenance
  iommu/arm-smmu-v3: Add SVA feature checking
  iommu/arm-smmu-v3: Implement mm operations
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 drivers/iommu/Kconfig                         |   13 +
 drivers/iommu/Makefile                        |    2 +
 .../devicetree/bindings/iommu/iommu.txt       |   18 +
 arch/arm64/include/asm/mmu.h                  |    1 +
 arch/arm64/include/asm/mmu_context.h          |   11 +-
 drivers/iommu/io-pgtable-arm.h                |   30 +
 drivers/iommu/iommu-sva.h                     |   78 +
 include/linux/iommu.h                         |   75 +
 include/linux/mmu_notifier.h                  |   11 +-
 include/linux/pci-ats.h                       |    8 +
 arch/arm64/kernel/cpufeature.c                |    1 +
 arch/arm64/mm/context.c                       |  103 +-
 drivers/iommu/arm-smmu-v3.c                   | 1398 +++++++++++++++--
 drivers/iommu/io-pgfault.c                    |  525 +++++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/iommu-sva.c                     |  557 +++++++
 drivers/iommu/iommu.c                         |    1 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/misc/sgi-gru/grutlbpurge.c            |    5 +-
 drivers/pci/ats.c                             |    4 +
 mm/mmu_notifier.c                             |    6 +-
 21 files changed, 2716 insertions(+), 163 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
