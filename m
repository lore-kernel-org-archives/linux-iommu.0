Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C060AC433E6
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABC423A01
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABC423A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83CE0871C8;
	Thu, 21 Jan 2021 12:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9yjOvDbKgjf; Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EEB3A871A9;
	Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D945FC1E6F;
	Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E029C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1C4BF844B2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqijPXKU1FGp for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D5F6A844AB
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:32 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l12so1602785wry.2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b3l0OetoC6tw2Q4vXg0OJU58lOnJngSuhcgcpV0j+8A=;
 b=eWz40E4PQwAOppqBXOwKvt7Q0dVqHUMh5fqoJvuQDA3+kHfzRAM63s2hCG8pfXf/KX
 t1YLSGF55pBNR2O9qMkU8XNhlJEEPEFxSPI+KSsuahcO6/fMwqXvmQIo6j1dfavCmDdj
 2B4/qfVkLa0wBIQM3C7X6KgbYGm6oqE9MOBt17J/hCH9OvzxW2nN3/Fafr9nNHhw1pKd
 KvmOhkIHRvFkOP99nRyu5JXBGxSs8J9RFK95nw/VPMXO4yliQAc11MxeVpIy76ZiUVm2
 hY98zO+6QyqZygvqDXOilArvpDWBw4lbh2dFhPuehwvVGwJAKaiui4K6V79Pg/DqOpRc
 a7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b3l0OetoC6tw2Q4vXg0OJU58lOnJngSuhcgcpV0j+8A=;
 b=ZxpVVAjx/iIXzQvY6lhxymBlnNkhBxwCYA4TLqG6KzduLeij/6r5PhWah4BiCFV1kN
 OrnTDu8WJqW9tTa+GvymSL33JkNiaSLL3z4fayqdPpzTiFor9vdFGYO3bqPo5FzteDRV
 s2nyLvSDY2THQPeEuAKjY9skAviAZfklW7Giwus69SA2F+I7AUnTXw1TBRuKn9HyMcQJ
 PvDmQVzjFNO+kdwArwq3cJO9XegArOvJt9CU4RNVIMSxaNllcE710lXpFN30/Y0UXgPk
 ewxJQadKolNXBGCMQjVsghXqUtKFNQtaD9O6kIaDoSUwWcuYb81P2u+HyVLTmCCxbiDy
 4HoA==
X-Gm-Message-State: AOAM530LCrHYnYatSO5/CRKfxf5ixyv3e64m+UUvVh2En8R8sF8qflQT
 T2WqGJguDnidu2+97kuQX2IvHA==
X-Google-Smtp-Source: ABdhPJxQ+YnQY5ijaIW9U3we9pi/dCo07br3O0qdhedw1UO5Y/HhGzv9KZbJGYIhp9HYeRyQJgQvQQ==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr13720018wrh.318.1611232771208; 
 Thu, 21 Jan 2021 04:39:31 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 04:39:30 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v10 00/10] iommu: I/O page faults for SMMUv3
Date: Thu, 21 Jan 2021 13:36:14 +0100
Message-Id: <20210121123623.2060416-1-jean-philippe@linaro.org>
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

Changes since v9 [1]:
* Style changes suggested by Jonathan
* Fixes to patch 10 pointed out by Robin
* In patch 10, don't register the mm fault handler when enabling
  IOMMU_DEV_FEAT_IOPF, because that feature only indicates that a device
  driver wants to use PRI or stall. After enabling it, drivers may
  register their own IOPF handler (see discussion on v9 patch 03).
  Instead register the mm handler when enabling IOMMU_DEV_FEAT_SVA.

[1] https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 347 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1018 insertions(+), 73 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
