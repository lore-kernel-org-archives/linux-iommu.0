Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D76C433E6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FDC207B7
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FDC207B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E357985F46;
	Wed, 27 Jan 2021 15:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LjtgzrlTIJzG; Wed, 27 Jan 2021 15:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 439C385F29;
	Wed, 27 Jan 2021 15:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13EF0C013A;
	Wed, 27 Jan 2021 15:44:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A377C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5986A227AD
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZfRX2Xgwr9f for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 15:44:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 2E232226F3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:35 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id g10so2413414wrx.1
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wS1ZhkPy53Ug869D5KbFul/TixGQjhvdRxH2RGl6FFE=;
 b=yN8+ZEYXs60LN4H3/iPUmkayFZ/QFexI3MYPBddUqnXmHvaY0MXGcSoHtKGUGxBV7c
 htle9Dm4IzXGK+AFIQBxOCDlyawRU2/4Zxpk022izvBIRBliGrxNFxcTQBDRUV8NGYff
 WjI+fQb5fNoNcnAcq1+EM4Zr40bYkcq0Pq9P8M1MRSSkWNS/u7gmKPYcWqSWnuZDM2sY
 7O235W+myUX8QySNqVx40PNuAvAQePQiBSFrRXdcGt1cNOmrWFEiBxF2Y2jp5jL50DRM
 UNJ9LSP88Qref/3tFFBjVg1GkIQGAKo4NjTZsaCKcq8f9eE2WMxyrP1DYs3odfFOss1P
 Nhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wS1ZhkPy53Ug869D5KbFul/TixGQjhvdRxH2RGl6FFE=;
 b=JBQWc2AK4XMUVlmZR6xrOR0896NLwwGKEgRsaX5P5vuF2Iou8CxHcF1h+r2qCPKUkb
 G7EisIW69z4tCGdi5FVTpUZn3X0CyROuXacyIXbwncFiqv4gefG/bEsgS1mASCgS5JwG
 yldxeGwznh9ZFV0Z3XkSYmwdnlOe4tTDlhLmhQEfLWB76XRGobM0YGPNVuRd0BKYRUzh
 rdrSWtEESe6RITm1exzl0TaZzRWmYeZ+1gqbID8E863F3LCJDV6Gevf35dZ7ZgS6SLdn
 cmCUhqHm0ayiscs3zUts3l0ukEpLQv7GPxXtbDpHgXm9K9D7KjpY7QWIwgJraPT5lNw9
 fogQ==
X-Gm-Message-State: AOAM530yJNmf7xM/pg/p7vMSOvcA5qPnpJaJKUw1k5uvCIXkWPEwD0ct
 vEcfKmZnEfzZR6dmuKEXiWaKTg==
X-Google-Smtp-Source: ABdhPJw8bmHv9UQA9WE+SkZNIdRG10VRBsv+I85VSHEhTtrJjAVrYGHN6RHpUEQcYQaNw5S9xdZKEg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr11958548wrp.165.1611762273360; 
 Wed, 27 Jan 2021 07:44:33 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 07:44:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v12 00/10] iommu: I/O page faults for SMMUv3
Date: Wed, 27 Jan 2021 16:43:13 +0100
Message-Id: <20210127154322.3959196-1-jean-philippe@linaro.org>
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

Since v11 I added a sanity check in arm_smmu_dev_disable_feature(),
patch 10: return -EBUSY if device drivers attempt to disable the IOPF
feature before SVA. That would leak the IOPF param and fault handler.

v11: https://lore.kernel.org/linux-iommu/20210125110650.3232195-1-jean-philippe@linaro.org/
v10: https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/
v9: https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 351 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1021 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
