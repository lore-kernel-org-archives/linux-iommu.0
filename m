Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A2C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E516137D
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E516137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B760B41561;
	Thu,  1 Apr 2021 15:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AuoOuhXNvVyZ; Thu,  1 Apr 2021 15:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6864041841;
	Thu,  1 Apr 2021 15:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47293C000D;
	Thu,  1 Apr 2021 15:48:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 829BAC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73FB241843
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTfYoNw-4Iwu for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:48:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 205F841561
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:14 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 b2-20020a7bc2420000b029010be1081172so1146655wmj.1
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Rqc2+6jggGKUT8/YAMcYP1juQODWAVCbo22wEIJOzg=;
 b=XkGSJlAzvgm3OxpT3lKOGiYqyTKylXidnXzbEQbvCvOrv1JBib0O+woGdI2pYUzsPs
 YjutU8dIM58r6FFx5bM2W2CM8K58JHvsTmyfbNYnImC1dY0paQzXYNdCjmKlXRsfcDgm
 Stf3yokmr8D+AOKQTwhqLBhdA0cqvjMkZ8pnxKFNO9KfoiXWpAwOaB93U9kQ38CRvfBy
 lt6wN4kmg7pd0aOwB5QGaod87brX+NBDUPbTIFW4J9utStdorl8ftkrcD/5bzDb+OPvd
 /qs2jGX46hUvuBn78thXYzyOco0wVORhvSd0yrP8wSpA/H0+dQsvw20J7EYNcXSEAnCZ
 /Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Rqc2+6jggGKUT8/YAMcYP1juQODWAVCbo22wEIJOzg=;
 b=oiV5v4XKZEao83HZpzgUI2xtlk5lHGv7s7OyceNXy8Ir/P299uTM1FfUGVE8D9YkGj
 tnl8/mJ+X5Ax18wk7Z6xiQxL9jgUDCkzXxojeDOvb8K401+mdta7t59nrTO6SSwDvnbT
 o5T+kEubMHnoAt2B6BOzINi9dQjQiR2ox7A3/x3UpijFI+BfAAKGAp/9ZmRfsDQl3aPS
 WBk8HXCVtDxs4W8P+vuSATlwvJZosnqiNf1lxZIkfiXTq8Iew6QUYJMGC04YGH9e7OWE
 CE8UYCUTZCw8USmVPq0SeeFzLkuvVvSvnEopkIcxz8oVPjlNjwxxW1Q4hu+J8TSEFYzD
 qGrA==
X-Gm-Message-State: AOAM533T5P3wmZZw/qYhn7Q8u3m/MtMZziMbOEus6l2eZgmOLWZlSBv5
 Zft/IsQCOOL9/Jv3MjoJPAb67w==
X-Google-Smtp-Source: ABdhPJxN1jziZ4oZxiGvM5oGVMwG6ILgdWAeLhxA89O6osCdjCFgqJR9jExdn0MmdGKlbB9xdLtK0w==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr8637858wmj.54.1617292093384; 
 Thu, 01 Apr 2021 08:48:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:48:13 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
Date: Thu,  1 Apr 2021 17:47:09 +0200
Message-Id: <20210401154718.307519-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
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

Add stall support to the SMMUv3 driver, along with a common I/O Page
Fault handler.

Since [v13] I added review and ack tags (Thanks!), and a lockdep_assert.
It would be good to have all of it in v5.13, since patch 10 introduces
the first user for the IOPF interface from patch 6.  But if that's not
possible, please pick patches 1-6 so the Vt-d driver can start using
them.

[v13] https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 355 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1025 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
