Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529ADC433E3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED708208B3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbiiUTm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED708208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B08012214F;
	Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EaFaCJGMxoAj; Thu, 18 Jun 2020 15:52:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C3A832000D;
	Thu, 18 Jun 2020 15:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EBD3C0892;
	Thu, 18 Jun 2020 15:52:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBBCBC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C23F7888D5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8KiEhWrVFud for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7B82F888D3
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:40 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id dp18so6925969ejc.8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NmZThf3a2J6NoF89O5jcQpvbS3tCRuSL8WpQATN4J9s=;
 b=SbiiUTm8b3lLb0G44o0xNz2wAgbRXUJ40PYOfCJkPu1U+7Cz8Q4JukOUgbmBL4er9G
 dJ7Cvj4FRyYN6pkQMQx5jjEvD+YDt6nqjJe71GKRTEca0dl+iI7cVyX+emnBPTvQNZH1
 7pVSfRIPOLiuxhIplgAZNKMP7lTRijVPY3nU7ESh9RJnGqfVgRbjeK36QO9Pakbr47NN
 uESVwsqZ9183zVksg3VwFAlQpoVTv+ObmiUCYcEIKH+gD6ob33Pu/KV8/XRytPEDSHly
 85315iMObHd1V22KfsfQCuO6ehxup/gAkt1TrAqM5SxrS1hQPyM9Ci7EKySAcQPBLKqa
 I3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NmZThf3a2J6NoF89O5jcQpvbS3tCRuSL8WpQATN4J9s=;
 b=rYEbqbZH7vh7FJNt0uM4pEBYw3FdtlrUv5KUbwzuRAujJGCOM7H/B1sKHS5wB6zaHI
 zj04vILVkV2MN6yRjR9A5r2og3+IiagDWfrjY0jQD11zCGsbrtIgXA9uAfhEuxhQQfOk
 Af09zpB4Cr8F3Yk9zkYH0eOc4V7lGjaTqD/eu/dd8NDPTAk3Ji39S9+uyD3j9TFWoN0N
 hD5oUm0gw2DkUZL9mebHF4hPeCXKnF+j8M+BRaJvP5wCVHidMBztMTp5XcckaBfKGz5j
 64R+MopYf8FSN9+bL3bQNTyJ3U3jpOvG6mJ2PnuLyeoyzWOLxh/UWOA6oW1BpgN7LZmD
 sTkg==
X-Gm-Message-State: AOAM530uGXAvL4FKqF9t2cuBYrOhgoB4sIndaRkXoYrEJKfYxqbqtAQm
 Bmm9fmLsAHYfZNAkrMUukqsoM2IZQ6BFxA==
X-Google-Smtp-Source: ABdhPJzjU3VVFUa1Qo56KhnjygVu/pLnUdL9+i0/7jp5cNFPr0/ZP9y2960Bjo4LpilqevPtcgOLCQ==
X-Received: by 2002:a17:906:d9cd:: with SMTP id
 qk13mr4511193ejb.268.1592495558670; 
 Thu, 18 Jun 2020 08:52:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 63sm2402267edy.8.2020.06.18.08.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:52:38 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v8 00/12] iommu: Shared Virtual Addressing for SMMUv3 (PT
 sharing part)
Date: Thu, 18 Jun 2020 17:51:13 +0200
Message-Id: <20200618155125.1548969-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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

Since v7 [1], I split the series into three parts to ease review. This
first one adds page table sharing to the SMMUv3 driver. The second one
adds support for I/O page faults through PRI and Stall, and the last one
adds additional and optional features (DVM, VHE and HTTU). SVA needs the
three parts to work. No significant change apart from that, I just
addressed the previous comments.

I'd rather everything went through the IOMMU tree but I'm assuming patch
1 will also go through the x86 tree as part of [2]. It is definitely
required by patch 3 which is required by patch 11. I don't know how this
kind of conflict is usually resolved, but if it's a problem I could
further shrink the series to only patches 4-10 this cycle.

[1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/1592418233-17762-1-git-send-email-fenghua.yu@intel.com/

Fenghua Yu (1):
  mm: Define pasid in mm

Jean-Philippe Brucker (11):
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/io-pgtable-arm: Move some definitions to a header
  arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Check for SVA features
  iommu/arm-smmu-v3: Add SVA device feature
  iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops

 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 arch/arm64/include/asm/mmu.h         |   1 +
 arch/arm64/include/asm/mmu_context.h |  11 +-
 drivers/iommu/io-pgtable-arm.h       |  30 ++
 drivers/iommu/iommu-sva-lib.h        |  15 +
 include/linux/ioasid.h               |  10 +-
 include/linux/mm_types.h             |   4 +
 arch/arm64/kernel/cpufeature.c       |   1 +
 arch/arm64/mm/context.c              |  95 +++-
 drivers/iommu/arm-smmu-v3.c          | 702 ++++++++++++++++++++++++++-
 drivers/iommu/intel/iommu.c          |   4 +-
 drivers/iommu/intel/svm.c            |   6 +-
 drivers/iommu/io-pgtable-arm.c       |  27 +-
 drivers/iommu/ioasid.c               |  38 +-
 drivers/iommu/iommu-sva-lib.c        |  85 ++++
 MAINTAINERS                          |   3 +-
 17 files changed, 977 insertions(+), 63 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva-lib.h
 create mode 100644 drivers/iommu/iommu-sva-lib.c

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
