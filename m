Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660EC43466
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:19:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0372311D
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aawrGoT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0372311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06C2787688;
	Fri, 18 Sep 2020 10:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXS0pGTIE+Sq; Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6062D87672;
	Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DDCFC0888;
	Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01926C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD6B9877E6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yD-3bC4kjnRa for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEA71877E4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:55 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id ay8so5520726edb.8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lv4b9GY6+/bQQk9KCigu2YOyVf5wGbkZ83LEMpm6G8I=;
 b=aawrGoT0HCqKrNQLDsu4ySNkEpm9PttsoV+pu7FbzHS81I9fNNjUJyKDF4TsAV1ufp
 9E/FoBjhs1QgEv5nLGUt1aSMg+T32u2GOYujngMtZVPBALd3S+ZY9cRBoi+BTkFOPP0V
 JbUHqZEVcB8zGGWRHcO96t1EaUKaN0+xktEBQ6mZOtbCZiOZR0C2nt/278BH3wJWhJC9
 1G5i9+7H7VsoOhMRLzbQJp8c/fgFAfUIvUUx5yA4i7EKVUWcmpXN2j9I4xy0tIekT6GQ
 +Tym/HBZZa3/UoH7uqJiCPkyDGzw7zhcEzXkPJ5vUi0ZhB3MqWKrggWJGhVSs1zh09e0
 GJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lv4b9GY6+/bQQk9KCigu2YOyVf5wGbkZ83LEMpm6G8I=;
 b=eoY+Y+ucVOzcr1OQahueQI9DMStFNhW6MaWz6oW9wb1639+deLNYkRQYFHwXXXoIRl
 jhHjpwkSkoGDiSWSgAPIwQ3NWbUHeMa2SiCiX0bXUkz1D+8Swt4xUFnXP/iBYvyXtROU
 76Kzu0AvWkhoa9xbri8J8Hgh+UO28PJ33uszrPomFnuFSgJg36QBJQ1wXQmll8YT6zt+
 LnFwYupp564BtcOQRuM7sE61QIwILWoUNxtyqWJ87U8biP8hDpT7QnSKFNTtWuNeKa94
 9oKDpvfRhjos83mUvBTXP6OlgBW7uNbsnwHidnIMjYL99Mo/FXSN/anPNWqPEC7WRdvi
 Xn+g==
X-Gm-Message-State: AOAM532jnsTFUWEbvypG00kR6ziE1JWdTCgKJ91bGaEv/D1ayF5HaQTe
 8dOam7UZAYjQDiEq/KucD8+3aDBlOgu7eXAe
X-Google-Smtp-Source: ABdhPJyUUObxySn2EBQo1QBdHyPSiPfxzCfd37bHd4/MqRE0Cc6VLlNPyEeZiwMMHqJCW9gF33Crwg==
X-Received: by 2002:a50:9d0a:: with SMTP id v10mr37167009ede.144.1600424393968; 
 Fri, 18 Sep 2020 03:19:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:19:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 00/13] iommu: Shared Virtual Addressing for SMMUv3 (PT
 sharing part)
Date: Fri, 18 Sep 2020 12:18:40 +0200
Message-Id: <20200918101852.582559-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhangfei.gao@linaro.org,
 will@kernel.org
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

This is version 10 of the page table sharing support for Arm SMMUv3.
Patch 1 still needs an Ack from mm maintainers. However patches 4-11 do
not depend on it, and could get merged for v5.10 regardless.

v10:
* Fix patches 3, 8, 9 and 10 following Eric's review.

v9 resend: https://lore.kernel.org/linux-iommu/20200817171558.325917-1-jean-philippe@linaro.org/
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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 488 ++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 860 ++++--------------
 drivers/iommu/intel/iommu.c                   |   4 +-
 drivers/iommu/intel/svm.c                     |   6 +-
 drivers/iommu/io-pgtable-arm.c                |  27 +-
 drivers/iommu/ioasid.c                        |  38 +-
 drivers/iommu/iommu-sva-lib.c                 |  86 ++
 MAINTAINERS                                   |   3 +-
 20 files changed, 1731 insertions(+), 735 deletions(-)
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
