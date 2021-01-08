Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8192C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7595323A04
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7595323A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DF04D20412;
	Fri,  8 Jan 2021 15:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6qORW4996Obe; Fri,  8 Jan 2021 15:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C6B5A2041B;
	Fri,  8 Jan 2021 15:02:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A065FC0891;
	Fri,  8 Jan 2021 15:02:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B916AC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9E90186DD5
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AqaVRsSKokyW for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9CB3086DD2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:29 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 3so8666107wmg.4
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9LxmaGFsoHsyiW4BIZVKPeyt3J9qr8cLi2zlatmsMp0=;
 b=KZFJdK1uOxU13tuF7A1+PLi2EH+/cnbUqwMv9T1ACMWomHP3A/P/Bpr6aDWS7/LBsg
 r7hV7S/g38e3vl2vdXsDzcl/HJsUBPgyWSl8s0Ir3r9LXLbpYkYjy4j258sT+zyf5NX/
 jenNm/Spg8b6eOUDml2FPQZPKN0KaobawaJTgkpigzohy3P5Rob0HL6m+DZFOsAs02uX
 65SuIJt6sFoG+R5MlglHdQQyE/F/iMPD4WRur8w5d9ORqq2DDjhtde80HUrtnc5RQdbN
 TH2UcgGb6BE5Xo1XAAx3ZRRHtt3w5YKmWY79M9kgcluqs5Wo7EFME/KmHGx6Wbv2n4vw
 cQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9LxmaGFsoHsyiW4BIZVKPeyt3J9qr8cLi2zlatmsMp0=;
 b=iWV6ixFsngo8qGhQ9NMGaS9oslbh/My2SVcyaIYgWG/3+/0nFXpWoWUGXcwbdBxMEA
 k9uRwBM0+FTB504QajCf+Io/MQf/8D9zBAvLvQzQ1y5ru7DSCoJ/RId5/FlAK7sjkQWn
 r9WFxOibRpWRrlQMr2Dlgtk7Swtp4V3bJNlYx6L66Qi0DUxcQKPrJK7nwIQr817NHOPF
 BqC1OdPGCyUZd9XQVEDk5yFHx9r9Uu+GZDBPu0N830WCAuGduBywg8dudifXFzBiVmwq
 HYMBtmLeZUURAttlwbSqITxkBSE6lVE9nxlkdOZfCM1YsyT2pxlCpSge+KYD65ClZF/v
 gsmA==
X-Gm-Message-State: AOAM532IcsdxAl5AIPyAZ0/f7hlFKuX1jF/FUzgEhvEoBOecouB+a5HR
 Ht7cIp66CFywgqEQlUptnvYxew==
X-Google-Smtp-Source: ABdhPJwryieGz+IIpJFdRcitNF3mYDnUq00efz6rzlTllf+zarGcbHI5biYr33cJ6dUnp49vkxQ9ZQ==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr3515616wmg.65.1610118147821; 
 Fri, 08 Jan 2021 07:02:27 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 00/10] iommu: I/O page faults for SMMUv3
Date: Fri,  8 Jan 2021 15:52:08 +0100
Message-Id: <20210108145217.2254447-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Changes since v8 [1]:
* Added patches 1 and 2 which aren't strictly related to IOPF but need to
  be applied in order - 8 depends on 2 which depends on 1. Patch 2 moves
  pasid-num-bits to a device property, following Robin's comment on v8.
* Patches 3-5 extract the IOPF feature from the SVA one, to support SVA
  implementations that handle I/O page faults through the device driver
  rather than the IOMMU driver [2]
* Use device properties for dma-can-stall, instead of a special fwspec
  member.
* Dropped PRI support for now, since it doesn't seem to be available in
  hardware and adds some complexity.
* Had to drop some Acks and Tested tags unfortunately, due to code
  changes.

As usual, you can get the latest SVA patches from
http://jpbrucker.net/git/linux sva/current

[1] https://lore.kernel.org/linux-iommu/20201112125519.3987595-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/BY5PR12MB3764F5D07E8EC48327E39C86B3C60@BY5PR12MB3764.namprd12.prod.outlook.com/

Jean-Philippe Brucker (10):
  iommu: Remove obsolete comment
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  74 ++-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |  25 +-
 drivers/acpi/arm64/iort.c                     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  70 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 354 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 462 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  32 +-
 12 files changed, 1046 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
