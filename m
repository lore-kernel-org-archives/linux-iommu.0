Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA60BC433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72825206FA
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BR09cPe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72825206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EA6BA20511;
	Mon, 17 Aug 2020 17:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clCAAFP8+NUM; Mon, 17 Aug 2020 17:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2797420104;
	Mon, 17 Aug 2020 17:18:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 106D3C088E;
	Mon, 17 Aug 2020 17:18:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD993C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C590620104
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fWAY32ktsEfb for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 17:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 13E9B2000A
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:30 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id qc22so18647888ejb.4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R7aC/DW1op4r+Z4hZksSzHEK9PjzVJ3p6kxoSLnPAKg=;
 b=BR09cPe8bipj+PNSPJ1rZYq6F49uZsaAAEaiZZeLUza/HWSgYsHfiQUqvehNj/zHdo
 qbAxbhzWgLv+JgXc9Hf8u2r0v1qrwMCu7IY9bpfe2MF85MUYUijjETNvgjULx5UIGbMx
 vN81Nd7Fr3GNRpruujEBEwi/FOk3fs+L+J1ksom42jt/RIrqDQ7WW/C4Q+72/n9Kq5Tq
 due0daqEBODsHaOjJ9pd0+84Yq8HsJ3xE9GoW+cLGESU0YeMSiOWmp56VWa09Lly0cQo
 yQVqNC6ia55Pl7kROeww6SaTcZpoM6TDOlbVsdYI6d9Y6hnApPDaUub8SL5YIR+nIsKH
 UcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R7aC/DW1op4r+Z4hZksSzHEK9PjzVJ3p6kxoSLnPAKg=;
 b=V/GPsG1PkhrXINYYY6ah6+2po4kU7xO/Tm9u+dIKuMY10CEJYqiAsMS6cF5uqq38uH
 VM4Bj7pAvAmgTazxTx8U/6MeWHcPFD7rpCMEnekTiVLOruzG59ml/iI0JGtfE+hOffbD
 hDH8HDlNN0dzJ0Fd+BJei2K/6cqKWPOlAPf3Wlu1njIG8fTIeCCGYo2H2XI6//IVL33n
 7qpqK869ZXrOvyoxJZ/AKytZ6w3C9WBUUTRPtXeUsoV5W0KAeMhzVIrTCIe15JQ1Cw8a
 HcmOb8HdC20N0QrpjKUH72ltpjNlIkt0NsXZVHCb1FEShfIWRki8mcFJ/gXknuZM1m2N
 4qeQ==
X-Gm-Message-State: AOAM532IgjKM9lzXxYysfj1zBaSeGfQhhyO6Qs6s+euEnUHaT4ClNOkx
 7PasijZugpphlZEVtAq73pOGfRLwGYFdcVGx
X-Google-Smtp-Source: ABdhPJz+VQOQnttZCxy1+owk4CZNaUQxcFkQ4Xi34Vfk+EDoxMENCWtTQOcb42FV3aeK6PlTS6T3Tg==
X-Received: by 2002:a17:906:c7c8:: with SMTP id
 dc8mr15694071ejb.285.1597684707897; 
 Mon, 17 Aug 2020 10:18:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lc18sm14672502ejb.29.2020.08.17.10.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:18:27 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH RESEND v9 00/13] iommu: Shared Virtual Addressing for SMMUv3
 (PT sharing part)
Date: Mon, 17 Aug 2020 19:15:46 +0200
Message-Id: <20200817171558.325917-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
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

This is version 9 of the page table sharing support for SMMUv3, rebased
onto v5.9-rc1.

v9 resend:
* Rebased onto v5.9-rc1. Moved to drivers/iommu/arm/arm-smmu-v3/ as a
  result.

v9: https://lore.kernel.org/linux-iommu/20200723145724.3014766-1-jean-philippe@linaro.org/
* Moved most of the SVA code to arm-smmu-v3-sva.c. This required moving
  struct definitions and macros to arm-smmu-v3.h (patch 7), hence the
  new 700 insertions/deletions in the diffstat.
* Updated patches 4 and 8 following review.
* Fixed a bug when replacing a private ASID.

v8: https://lore.kernel.org/linux-iommu/20200618155125.1548969-1-jean-philippe@linaro.org/
* Split SVA series into three parts: page table sharing, I/O page
  faults, and additional features (DVM, VHE and HTTU).

Fenghua Yu (1):
  mm: Define pasid in mm

Jean-Philippe Brucker (12):
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/io-pgtable-arm: Move some definitions to a header
  arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
  iommu/arm-smmu-v3: Move definitions to a header
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Check for SVA features
  iommu/arm-smmu-v3: Add SVA device feature
  iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops

 drivers/iommu/Kconfig                         |  17 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   5 +-
 arch/arm64/include/asm/mmu.h                  |   3 +
 arch/arm64/include/asm/mmu_context.h          |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 752 +++++++++++++++
 drivers/iommu/io-pgtable-arm.h                |  30 +
 drivers/iommu/iommu-sva-lib.h                 |  15 +
 include/linux/ioasid.h                        |  10 +-
 include/linux/mm_types.h                      |   4 +
 arch/arm64/kernel/cpufeature.c                |   1 +
 arch/arm64/mm/context.c                       | 105 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 487 ++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 860 ++++--------------
 drivers/iommu/intel/iommu.c                   |   4 +-
 drivers/iommu/intel/svm.c                     |   6 +-
 drivers/iommu/io-pgtable-arm.c                |  27 +-
 drivers/iommu/ioasid.c                        |  38 +-
 drivers/iommu/iommu-sva-lib.c                 |  85 ++
 MAINTAINERS                                   |   3 +-
 20 files changed, 1729 insertions(+), 735 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva-lib.h
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 create mode 100644 drivers/iommu/iommu-sva-lib.c

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
