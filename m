Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF59C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554D364F13
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554D364F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4B0D4F12B;
	Tue,  2 Mar 2021 09:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9gASbwvsgH1; Tue,  2 Mar 2021 09:35:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82B334F10E;
	Tue,  2 Mar 2021 09:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56AFAC000B;
	Tue,  2 Mar 2021 09:35:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 915F4C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 710574F10E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ulJeSAFb4TFO for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 219444F10D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:32 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id d11so19085454wrj.7
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cEvh5d2SHvxkSF+1irchEvrHiYiFzIPFtl5KjBbhkiY=;
 b=e0QdvPzBHHsEWw8yEUV63Abhpos9MC8ghOLDX4KpBWQHX7ucYQLT1YohHplRdd1zWv
 MsXtxpCExw1/mrCBDAuhbSb0Ki8sJDYCXMYOlfkPnS1TSu+HOTMXh+yBivoQUwNrMJ8L
 x3uhIY9nhxSRtqRnBJ+Fz7azE098RqmzW+feKSdcNSMY0Rb+J/B+sbXlblnOwArExQ3Q
 OTnGY6UWnuczU+CPWx9NZyIBzqwmumm2H9sLU8YvwZ9l3OBEewLY8qAVSXfZKnkF0UwU
 nT8CMx0ljrIjGklCr2zkJ2uHjWXnXJTEUgnp6WQMmNp4lSPQHnUsuus8J0kxsBGoSeub
 cuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cEvh5d2SHvxkSF+1irchEvrHiYiFzIPFtl5KjBbhkiY=;
 b=ddWS7KkXlub1YyGOxvjspEIkYR+OwEOVLQX5Wh0E9hSu8fdlQVazzFZ9BevKpQ0LOY
 jTqPmyQZ98IZ5sm+LYGeLFri5sE/SQctOq45PxGO4dP37HMC0Fbs8ZaVaNdWiASuRd3h
 aijPngtNtTqMrzbLnL965vQXyPgW+w3k15fTIaQNeP1895xpRNTnCg6WtH+j6j35E9He
 E/1ZKtCi2QXhwe2//frWPUv0uoXQ4PJNfdbvWejmkqM0sUVvmXN3zBCej6Keiwc2aN68
 P4GRbBDayRfTfUtT+w4ee19S4Sh5rC8T7EFr65FZXpdXOzQ/p8WxuAQQ2RG/0dzkSsbc
 /9Vg==
X-Gm-Message-State: AOAM532bVXFyMwcltjAZ/z8/0IolCcsmysOVfFOeHZQqHgSrBG5wohnx
 TxPmndlZ87Y1FjNc9oKUFNYlNQ==
X-Google-Smtp-Source: ABdhPJzwD2G5q6rP9T+vUtD3KyAyfU1qRsMeo52c3TFT0pOxMNOJrhtlwKkPcLVRuwoKj88VYCWBtg==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr22098078wro.200.1614677730353; 
 Tue, 02 Mar 2021 01:35:30 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Date: Tue,  2 Mar 2021 10:26:36 +0100
Message-Id: <20210302092644.2553014-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
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

Since v12 [1]:
* Fixed failure path of arm_smmu_insert_master(), in patch 07 (Keqian
  Zhu)
* In arm_smmu_handle_evt(), patch 10, don't report IPA field on stage-1
  faults, and report accurate fault reason (Eric Auger)
* Fix possible use-after-free in arm_smmu_handle_evt(), patch 10: if a
  master is removed while we handle its events, we could in theory
  dereference a freed master struct. Hold streams_mutex while using a
  master struct obtained with arm_smmu_find_master().


Future work regarding IOPF:
* Keep stall disabled by default, only enable it per CD when drivers
  request it [2][3].
* Add PRI support to SMMUv3.
* Route all recoverable faults through io-pgfault.c, so we can track
  partial faults better [4].
* Nested IOPF [5].

[1] https://lore.kernel.org/linux-iommu/20210127154322.3959196-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/22fa4120-eadf-20d5-0d0a-9935aa0f1fb5@hisilicon.com/
[3] https://lore.kernel.org/linux-iommu/YAhui7UOw7743shI@myrica/
[4] https://lore.kernel.org/kvm/YB0f5Yno9frihQq4@myrica/
[5] https://lore.kernel.org/linux-acpi/MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com/

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 354 ++++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1024 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
