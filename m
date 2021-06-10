Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B64AC48BE5
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 08:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300DD613ED
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 08:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300DD613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85FB640522;
	Thu, 10 Jun 2021 08:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9W_5OJOA2-5I; Thu, 10 Jun 2021 08:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81B0E40538;
	Thu, 10 Jun 2021 08:02:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C95F4C002B;
	Thu, 10 Jun 2021 08:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D11AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 08:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 746FD405BD
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 08:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iku53g-ZB2At for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AC25405B0
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 08:02:48 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id f2so1120064wri.11
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
 b=ObI/IzUukEYxx+7H8+Qf0c5GsgYSNdbZSErulQp+S5M095cDQ63LAs4nqiCOr4OSe0
 i/FNuhtV6CsQXPFO7XOQ6EM/eQxQDqwiYBae+RKq3EOIgwxnwJUnU7d09ygRpJh0rbiS
 WmfD13dPCc27InjhoUw07zaBwR0qqlRJMZrskGrqVpjWJEuhLHcy7PnYvSBzEkMk7Y4C
 X/nPyuSTqbaIwiPMZbeIP5zs4ELOKDWw4c7/dWuPyF1U172DTBtgjmadVm4nASZWRfbM
 M0tjl+lcuIZQH59VeO5Eb0JfSz8aylyM0XkCrZmSE6BhddflN5ZkTX1nTFcqksk8IJHb
 gIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
 b=LHZDkqB16vdURasPwUco+/yDlx/vcmfbw9Gp+v/Vwie44scal8Uk5TEdShBvu1pJwk
 yCV27nmY7aUxXYw7DVjezJG0sh322eZJZ502872eImUTVt7z/syKAIFqc22j4tN6zsqX
 u0cd89GORFuxQ+elNeS9tMA0udKB7viYMJRL5VMiZIrsZLj4jLw/4kzl2hOj1pDGb0SD
 XmJ9PP3xOVIw69+pjDzUssVS/fY4YFatce8lSuX+NJ9W6lcVQ7HupyUhTkhziLTgChbG
 rtIkw7JsQMAtsaB/t738vDvb2J9KAWst48VlvD0OPX+BMsedpgS+eZt4F5hRIzpfAm8D
 g0fw==
X-Gm-Message-State: AOAM533L5e/jRf8HR1h/ta6pjpdjlKxFQloK79BEvY4eUJ4UGIVB/TBJ
 lknnzyPwzcE9ldfWUx8CgBfD+g==
X-Google-Smtp-Source: ABdhPJz3GLvas2zyoO7uIAb3y7v6qAeWCy4E0Q2PobZGKURJL4xC2/JOv5xITetYPC0Kt6UtuqclGw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr3885872wrx.144.1623312166388; 
 Thu, 10 Jun 2021 01:02:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 01:02:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v4 0/6] Add support for ACPI VIOT
Date: Thu, 10 Jun 2021 09:51:27 +0200
Message-Id: <20210610075130.67517-1-jean-philippe@linaro.org>
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
information for para-virtual IOMMUs. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
take this series through the IOMMU tree, which requires Acks for patches
1-3.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
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
 drivers/acpi/scan.c          |  78 +++++++-
 drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 580 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
