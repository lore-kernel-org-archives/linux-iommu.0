Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCFC433E0
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:01:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DCD207D3
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9vyZZ9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DCD207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FE4E86C93;
	Tue, 19 May 2020 18:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PkLbzAESANPM; Tue, 19 May 2020 18:01:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B471C86C2C;
	Tue, 19 May 2020 18:01:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 930DDC088F;
	Tue, 19 May 2020 18:01:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C4DC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B479B221B5
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DaYqdtBNGfCB for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D2D320355
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:44 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id y3so439925wrt.1
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bX55m437g7MeykE1US3Tftk0H5lzLx6XUpXZp2Kvxoc=;
 b=M9vyZZ9mATtJfZDUOxfdmdgx0RZHnvTGKbSm5F+JwH4itQZSpjYwKXYMCkR2huFvi2
 twh626xwy7oiPNTooN5mL8olWtFlkxdKNWun/7JJy52nt9PxCNGgU3iNKo7o3OgGBjBv
 GtcGwtOW+y4rz0r0Z0/zqBdnL/m4CdO70VTsExVbCbEatxP0xilLLUZJnBsBvKMv2tyJ
 vq/V4yM3GGmE/FtHGK5VR9w0BMSpmTebXfbAaoplg6/qbzV58lFR5DsR+sAVolk1TARd
 9BUbrrk/lyNFvpD6HXmUxfASJGR586E46CfIK9SG/6YNZ8RwjVHLC9QEQCyMTEN7B8Bf
 1ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bX55m437g7MeykE1US3Tftk0H5lzLx6XUpXZp2Kvxoc=;
 b=hO2f14Qqv/9MzSpmygZ1lDd5wy7tje6q9JjzrK1HBi+vp5qMBDl98JvhvIR01u2e2S
 O8cLtYC3FIs3yrYxmUlKB2spedxKsIFDBHHKowySpiYcRuqNhhtyNMrutZuqjMgrQAWn
 ls5DYy0FvxjCFIP1eR+0ep0AhJTD118la/NHwV8BWI3ntlIiMbhzxa7co1FT5SX82+5N
 uqk46Ls1nGka0QulB4yUlRlA3C6lGWzfhz2b7sNZ+Rx51N0oYA+W5onjYkciVo0hZJjI
 ko/Os77liX0hmLi7y7IS2lmy/6aMX79cElKlFUCaSb4E3SQUqiYARf3WY16q/KtoPG4+
 C36w==
X-Gm-Message-State: AOAM532g/C3i478nDBSlY4zDC5IShc8Jclywvo9Ay0jkukr+I+f9HLAD
 BWCHJ1JQvG3oiJuyBV4V2Grpbbgi6TMcvw==
X-Google-Smtp-Source: ABdhPJx1fsDPOtceAXONrGmaumNlQajybGcyP41uWlcXsFpwhVtjyrg3sPruM6jEsNsAR5hEmsZ2Cw==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr125600wrn.44.1589911301763;
 Tue, 19 May 2020 11:01:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:41 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 00/24] iommu: Shared Virtual Addressing for SMMUv3
Date: Tue, 19 May 2020 19:54:38 +0200
Message-Id: <20200519175502.2504091-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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
devices using the IOMMU, PASIDs and I/O page faults. Add SVA support to
the Arm SMMUv3 driver.

Since v6 [1]:
* Rename ioasid_free() to ioasid_put() in patch 02, requiring changes to
  the Intel drivers.
* Use mmu_notifier_register() in patch 16 to avoid copying the ops and
  simplify the invalidate() notifier in patch 17.
* As a result, replace context spinlock with a mutex. Simplified locking in
  patch 11 (That patch still looks awful, but I think the series is more
  readable overall). And I've finally been able to remove the GFP_ATOMIC
  allocations.
* Use a single patch (04) for io-pgfault.c, since the code was simplified
  in v6. Fixed partial list in patch 04.

[1] https://lore.kernel.org/linux-iommu/20200430143424.2787566-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (24):
  mm: Add a PASID field to mm_struct
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  iommu: Add a page fault handler
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
  iommu/arm-smmu-v3: Add SVA device feature
  iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 drivers/iommu/Kconfig                         |   12 +
 drivers/iommu/Makefile                        |    2 +
 .../devicetree/bindings/iommu/iommu.txt       |   18 +
 arch/arm64/include/asm/mmu.h                  |    1 +
 arch/arm64/include/asm/mmu_context.h          |   11 +-
 drivers/iommu/io-pgtable-arm.h                |   30 +
 drivers/iommu/iommu-sva.h                     |   15 +
 include/linux/ioasid.h                        |   10 +-
 include/linux/iommu.h                         |   53 +
 include/linux/mm_types.h                      |    4 +
 include/linux/pci-ats.h                       |    8 +
 arch/arm64/kernel/cpufeature.c                |    1 +
 arch/arm64/mm/context.c                       |  103 +-
 drivers/iommu/arm-smmu-v3.c                   | 1552 +++++++++++++++--
 drivers/iommu/intel-iommu.c                   |    4 +-
 drivers/iommu/intel-svm.c                     |    6 +-
 drivers/iommu/io-pgfault.c                    |  459 +++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/ioasid.c                        |   38 +-
 drivers/iommu/iommu-sva.c                     |   85 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/pci/ats.c                             |    4 +
 MAINTAINERS                                   |    3 +-
 23 files changed, 2286 insertions(+), 165 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
