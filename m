Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0BFC4724C
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F2720757
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUmjnGJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77FF386DA3;
	Thu, 30 Apr 2020 14:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lKqiCY71xYN; Thu, 30 Apr 2020 14:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA76286B18;
	Thu, 30 Apr 2020 14:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B198BC0864;
	Thu, 30 Apr 2020 14:40:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17A4EC016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 116CC88789
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8WZeqEuBZwfY for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EDD3588787
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:17 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id h4so2150899wmb.4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YYiLFVngM44g0Fy16RMemZHwiB7tGW2h6urXa5JNeA4=;
 b=ZUmjnGJdMThCLpgu6Fn1QVEDSUT+cukEkGuOgFSAHraBV5UE619qvE7lxXPXau+0K9
 ZSHcJOrhjdN8cdq50v47XtlJcbrqef2j4U5/gGNSYSQpruy3HxooSXHs6zM0a7FPLyrf
 N1aYxP7FmR+YZG+U5qEkc7Ou5kN0muT/Fyj74HePtg+qHnxZ/OCxIli3Yg9YjITjQFh/
 9H6GKkTWgkWazMIGgQe+XWGtK1TcSG6alWleOABobFRAn+J2t7Zmt/cdYdpkh/pEJmMD
 jBY9RCioflr2sxajJ38Um+7P1crKRDbyOCc3eBs00MuEh0TbHUtzAb/LNYTvyI9xBJZf
 9UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YYiLFVngM44g0Fy16RMemZHwiB7tGW2h6urXa5JNeA4=;
 b=a6zqWxMMRf5HG8D5X5Rl0zchT/UDv8wzFe6XYkJAIF3hsf1kp9rqEj7145xUGFsPul
 3n3bB3SWjQYIfxP8y9XN+0HBZNFdELKBgXnYm7r5Z8HgFCpM3EpD4L7oa80d2+c0EdZG
 HbU/RepYTEvVVd0rYRviOaW/4wZAuFW9l7jFDRu2CVt2OFSDx/31Gt/EIffzkuF2tayP
 l+x1SaXChCasBuDsVjJPHrn279IZZGHG/n8vH1iF7qY7twEc97CiwSFAtbqKOXGb5uYw
 Et6BgX7lTpMfvKueB1KQgGfu6bL5uNG5Rb8jQIDbnttqsA3Jau+Xk2cW2gtb59NfX3Iv
 vQCg==
X-Gm-Message-State: AGi0PuaurTfQH8BGiAc7rgSc7+kyMzX0stEj+jUGVsruW4/pmS0kJv/O
 8K84eek32rirAb31xXXIZOHjnXjrmXI=
X-Google-Smtp-Source: APiQypIMxbfi2gR+oRZoSzUml7oOF8uYXg/WO7r1FPuma7Uj6M8X8kh92jUG0IVhIXNkP7USztJjJQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr3419281wmm.61.1588257614425;
 Thu, 30 Apr 2020 07:40:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 00/25] iommu: Shared Virtual Addressing for SMMUv3
Date: Thu, 30 Apr 2020 16:33:59 +0200
Message-Id: <20200430143424.2787566-1-jean-philippe@linaro.org>
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

Since v5 [1]:

* Added patches 1-3. Patch 1 adds a PASID field to mm_struct as
  discussed in [1] and [2]. This is also needed for Intel ENQCMD. Patch
  2 adds refcounts to IOASID and patch 3 adds a couple of helpers to
  allocate the PASID.

* Dropped most of iommu-sva.c. After getting rid of io_mm following
  review of v5, there wasn't enough generic code left to justify the
  indirect branch overhead of io_mm_ops in the MMU notifiers. I ended up
  with more glue than useful code, and couldn't find an easy way to deal
  with domains in the SMMU driver (we keep PASID tables per domain,
  while x86 keeps them per device). The direct approach in patch 17 is
  nicer and a little easier to read. The SMMU driver only gained 160
  lines, while iommu-sva lost 470 lines.

  As a result I dropped the MMU notifier patch.

  Jacob, one upside of this rework is that we now free ioasids in
  blocking context, which might help with your addition of notifiers to
  ioasid.c

* Simplified io-pgfault a bit, since flush() isn't called from mm exit
  path anymore.

* Fixed a bug in patch 17 (don't clear the stall bit when stall is
  forced).

You can find the latest version on https://jpbrucker.net/git/linux
branch sva/current, and sva/zip-devel for the Hisilicon zip accelerator.

[1] https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/1585596788-193989-6-git-send-email-fenghua.yu@intel.com/

Jean-Philippe Brucker (25):
  mm: Add a PASID field to mm_struct
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  iommu: Add a page fault handler
  iommu/iopf: Handle mm faults
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

 drivers/iommu/Kconfig                         |   11 +
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
 drivers/iommu/arm-smmu-v3.c                   | 1554 +++++++++++++++--
 drivers/iommu/io-pgfault.c                    |  458 +++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/ioasid.c                        |   30 +-
 drivers/iommu/iommu-sva.c                     |   85 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/pci/ats.c                             |    4 +
 MAINTAINERS                                   |    3 +-
 21 files changed, 2275 insertions(+), 158 deletions(-)
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
