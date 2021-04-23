Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BEC43470
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94EC6145F
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94EC6145F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5175040555;
	Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3qWOJES9bg6; Fri, 23 Apr 2021 11:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38279404FC;
	Fri, 23 Apr 2021 11:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F021C000F;
	Fri, 23 Apr 2021 11:56:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1EAFC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D658C40617
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eIlHTpQfYWnq for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:56:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A85B8403F8
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:55 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id c4so9212002wrt.8
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8OCtTdC5nBJa7AZmDlmzklJ0KIvQRoRufXj59YXg9RM=;
 b=xxpjzNJRvJDMbMoE0tNn6IDo2ICmCTLmNrSFUy+DyLjclCsJ50hEk67FvEk9pf255W
 46kYA9cB+trAycZz8VQ52YcEBz1JuKw9L0As/Us439uqUy+lhb6ugdX6gQzVrEEbqKSB
 3/3F/MUMk1RFaiCzi3joPgc4cdcoDV2Kv/cP13xT/VN+2nd7GJJf6VZQ77lMknn5Jvx/
 nAqYXlV8EnOuwrN3BrGgd2/btDTxVd1OLXGJXVl40lIBiowFxSC9ZrWQgYTlzjOr8rvy
 OmsM0uV5OJoaOuWp4izzgx4yX9URzryVAyAwd4UduiR+q/cZJzQKGz4Xwrw6KzMG/14I
 NXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8OCtTdC5nBJa7AZmDlmzklJ0KIvQRoRufXj59YXg9RM=;
 b=nFQ894UzAfE5OCneUS3odol743I8a4lESPYzc8ZBEHEht7eLc4N4+1tH78gKDh+m5K
 qXpNtdS6jbn39oYyqENAqjFPk47IQETks3BWuheSJJM1B49IjWZaMdi2B8Ih/L2dyYT/
 gw+RNY7AXkpAu+julA58tW9xeXhyGtgWacKh+8j6ZJROBsZkQDu0UMZuXNvLSHgsisAG
 BGKFYQUBquoFC7wcPi0HEPLiCGNXXYMYMynCP38YhiZ6raaLI0pI/20A6y7joFNhxYFM
 urFjx+fLSCeAKQ9Hxn+ZHp3kdsknsJV/IeJt1MTylgB0ItTHpyPUuLYuTylJkYtn9qVg
 xDqA==
X-Gm-Message-State: AOAM531rszaZ8U7R5bidua83isugrTbzEWcYkE4trpcfLDQ5lY2d5J1a
 6IoNBdprWgB785hORdYoUi7epQ==
X-Google-Smtp-Source: ABdhPJyPpRSQxeHrMpv6L9ZEKawoGl7i7qyluCOrnXzXwS5te0ECEeIqx0XP2UAqECduDHkazD4q7A==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr4264902wrp.368.1619179013954; 
 Fri, 23 Apr 2021 04:56:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 04:56:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v2 0/6] Add support for ACPI VIOT
Date: Fri, 23 Apr 2021 13:38:31 +0200
Message-Id: <20210423113836.3974972-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
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

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual platforms. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v1 [1]:
* The VIOT header definitions have been picked for v5.13
* Share more code with IORT. Patches 1 and 2 extract the common code
  from IORT.
* Simplify the VIOT driver. Use the existing fwnode infrastructure
  instead of adding hooks to the IOMMU driver.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU. This
series, based on linux-next, is at [3]

[1] https://lore.kernel.org/linux-iommu/20210316191652.3401335-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
[3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

Jean-Philippe Brucker (6):
  ACPI: arm64: Move DMA setup operations out of IORT
  ACPI: Move IOMMU setup code out of IORT
  ACPI: Add driver for the VIOT table
  iommu/dma: Pass address limit rather than size to
    iommu_setup_dma_ops()
  iommu/dma: Simplify calls to iommu_setup_dma_ops()
  iommu/virtio: Enable x86 support

 drivers/acpi/Kconfig         |   3 +
 drivers/iommu/Kconfig        |   4 +-
 drivers/acpi/Makefile        |   2 +
 drivers/acpi/arm64/Makefile  |   1 +
 include/acpi/acpi_bus.h      |   3 +
 include/linux/acpi.h         |   3 +
 include/linux/acpi_iort.h    |  14 +-
 include/linux/acpi_viot.h    |  19 ++
 include/linux/dma-iommu.h    |   4 +-
 arch/arm64/mm/dma-mapping.c  |   2 +-
 drivers/acpi/arm64/dma.c     |  50 +++++
 drivers/acpi/arm64/iort.c    | 129 ++-----------
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |  60 +++++-
 drivers/acpi/viot.c          | 350 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 548 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
