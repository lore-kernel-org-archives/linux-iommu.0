Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79623C11D30
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B93C20880
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s25B8T+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B93C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B25A835D8;
	Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OimGBwbt3fl; Mon, 24 Feb 2020 18:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32AFA834ED;
	Mon, 24 Feb 2020 18:24:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B137C18DA;
	Mon, 24 Feb 2020 18:24:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4204C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F99586CD7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lic+O50yxSsy for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 79EE886CDC
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:31 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z3so11583983wru.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JRxfwTIy/8+3jEzlkFDZdgky1C85KqEMpExdkb37WLo=;
 b=s25B8T+S35H/O6yszlE4ht/8dnZTVbVI45eoc18FEdUcuiqMOkNv2En79g5o74Mjb1
 zO0yPt9INl3chhwisC9rzUkdJf0KZaX+EEaOzn4at8814D7OV6Ve3Y/q4pwkE9wi4gYu
 4NYIQP85Zbbc1PlNfDZfjeA3U8wAvoenL2JO0jnQMn9vhAAuMTLgi9jQn9Q1AdYeuJJU
 BkB5JJMJxdDXUmmSYzWum50ng/h3NEbyy9CZzm/kqZ1bBayTgnMnxX3UOetLLAqiANAe
 ytqloaU+0oK0O/ROB9DQ4hPFo9/4wTvVQGYWlX4dBA8x+YHwhPudv6KQaaVQDMvhpCtT
 SQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JRxfwTIy/8+3jEzlkFDZdgky1C85KqEMpExdkb37WLo=;
 b=m/nKLuqNVm/qNarqaxPo0zN7rXPyqznYPa1L2oRiBEh41dorZLqybpTgKK715pB00T
 Rgq/xbV49AsXtVul2Xl/GRi7+YWRuGF+WNkAkr1WUdjAubMZ2kDFv4MV1rYXRrCJ2elm
 Ds0vy1/Iz7DvOIYB493EdNsxAB2xLwzV5jQ6js1URfgcwYD63OD+y+wYCOYREtCR3I+a
 4+fpfeWG7cFf6xy1KqI7zSEyvVe3eh88t8XCuVOpFPlShi20cxl2Ip8aJO+w6n8YSFlW
 A5oNB33yw8VvI2S7hSwusbmIjcjpgaFlPs/e/+BrYtdTPoCWLjyKRQliTaDbSYmy1vga
 /X0g==
X-Gm-Message-State: APjAAAW9Rxz9fSyuezZLxPane8ohqvkMJ/dA3mrJjuuQAb5Y+fai5nOd
 n4KsSBJJe3W5tePYIG/AKAeOjx0fvBE=
X-Google-Smtp-Source: APXvYqzE3blpq1LSjWRjclFKCyKwQ41mykQ2DJWxVVDjuNwoKAu6osDlQgygC/xn0dF39ObvsiZRIA==
X-Received: by 2002:adf:fec4:: with SMTP id q4mr9813022wrs.368.1582568669522; 
 Mon, 24 Feb 2020 10:24:29 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 00/26] iommu: Shared Virtual Addressing and SMMUv3 support
Date: Mon, 24 Feb 2020 19:23:35 +0100
Message-Id: <20200224182401.353359-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

Previous versions of this patchset were sent over a year ago [1][2] but
we've made a lot of progress since then:

* ATS support for SMMUv3 was merged in v5.2.
* The bind() and fault reporting APIs have been merged in v5.3.
* IOASID were added in v5.5.
* SMMUv3 PASID was added in v5.6, with some pending for v5.7.

* The first user of the bind() API will be merged in v5.7 [3]. The zip
  accelerator is also the first piece of hardware that I've been able to
  use for testing (previous versions were developed with software models)
  and I now have tools for evaluating SVA performance. Unfortunately I
  still don't have hardware that supports ATS and PRI; the zip accelerator
  uses stall.

These are the remaining changes for SVA support in SMMUv3. Since v3 [1]
I fixed countless bugs and - I think - addressed everyone's comments.
Thanks to recent MMU notifier rework, iommu-sva.c is a lot more
straightforward. I'm still unhappy with the complicated locking in the
SMMUv3 driver resulting from patch 12 (Seize private ASID), but I
haven't found anything better.

Please find all SVA patches on branches sva/current and sva/zip-devel at
https://jpbrucker.net/git/linux

[1] https://lore.kernel.org/linux-iommu/20180920170046.20154-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/linux-iommu/20180511190641.23008-1-jean-philippe.brucker@arm.com/
[3] https://lore.kernel.org/linux-iommu/1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org/

Jean-Philippe Brucker (26):
  mm/mmu_notifiers: pass private data down to alloc_notifier()
  iommu/sva: Manage process address spaces
  iommu: Add a page fault handler
  iommu/sva: Search mm by PASID
  iommu/iopf: Handle mm faults
  iommu/sva: Register page fault handler
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/io-pgtable-arm: Move some definitions to a header
  iommu/arm-smmu-v3: Manage ASIDs with xarray
  arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Enable broadcast TLB maintenance
  iommu/arm-smmu-v3: Add SVA feature checking
  iommu/arm-smmu-v3: Add dev_to_master() helper
  iommu/arm-smmu-v3: Implement mm operations
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Maintain a SID->device structure
  iommu/arm-smmu-v3: Ratelimit event dump
  dt-bindings: document stall property for IOMMU masters
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export symbols of PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 .../devicetree/bindings/iommu/iommu.txt       |   18 +
 arch/arm64/include/asm/mmu.h                  |    1 +
 arch/arm64/include/asm/mmu_context.h          |   11 +-
 arch/arm64/kernel/cpufeature.c                |    1 +
 arch/arm64/mm/context.c                       |  103 +-
 drivers/iommu/Kconfig                         |   13 +
 drivers/iommu/Makefile                        |    2 +
 drivers/iommu/arm-smmu-v3.c                   | 1354 +++++++++++++++--
 drivers/iommu/io-pgfault.c                    |  533 +++++++
 drivers/iommu/io-pgtable-arm.c                |   27 +-
 drivers/iommu/io-pgtable-arm.h                |   30 +
 drivers/iommu/iommu-sva.c                     |  596 ++++++++
 drivers/iommu/iommu-sva.h                     |   64 +
 drivers/iommu/iommu.c                         |    1 +
 drivers/iommu/of_iommu.c                      |    5 +-
 drivers/misc/sgi-gru/grutlbpurge.c            |    4 +-
 drivers/pci/ats.c                             |    4 +
 include/linux/iommu.h                         |   73 +
 include/linux/mmu_notifier.h                  |   10 +-
 include/linux/pci-ats.h                       |    8 +
 mm/mmu_notifier.c                             |    6 +-
 21 files changed, 2699 insertions(+), 165 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-sva.c
 create mode 100644 drivers/iommu/iommu-sva.h

-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
