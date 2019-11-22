Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A916FC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EF42073F
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bn+Nr/yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EF42073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B73386205;
	Fri, 22 Nov 2019 10:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dONqfx7OqhTc; Fri, 22 Nov 2019 10:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D360F85F83;
	Fri, 22 Nov 2019 10:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD821C1DD8;
	Fri, 22 Nov 2019 10:57:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFFF6C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C9D0B86E0A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8vvkNSzL7RV for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:57:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C335E86DDC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:57:57 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id e9so6814663ljp.13
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GnM7tdmIuTsFG/gPDSUiRJmc1F37mgdxvtHO3FtFylE=;
 b=Bn+Nr/ytUk5YMVm1sQH/UVWhb/mMA2dE72H0//SsVqGsJ9g8ztbjNMl03n+vqtDgX1
 BVKT3vkBXC/ScqOu1f0iF7XkX6lsqaoR5LUZxq0mZatIZOz7WNO1g8raGl67VngxgyW9
 Zn2kqX9vdxYlDvCmxLBCm2xmeGhSiwiljE+9lmgXsFsgUPRpHuMCsvvuNYY6NigcTHtB
 6RIo/Qb2nm8M3urPlnZCBvaTaniwiuU4Ty9DcH8MlFxUi10bX7AZqP19/YZ8ro/tJBja
 iDFhce9IQReQ91LQ4rr7HwA94Ofb7+RxgCw7sMyVwzrXEjrM0k5Wqz6UJ8AMXLdvEArk
 /QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GnM7tdmIuTsFG/gPDSUiRJmc1F37mgdxvtHO3FtFylE=;
 b=iI+H78QiIh3ccK5GweDkT168JzNd13fcvlcBH1W1AEcIRbEhnVRQWDrDaUwSP8uBzX
 mBUo4191JBLV4/KJzRxLtJHgbaeEeVOnbyFXTjwwgDH+T6vScVrUVEdkidWpcoyovmWS
 eVFxLvEZz+2vvavu3qlve9fOo3DARBxZDr2UM0sH+H7HNKvjVrDvpeElDUpVPUHkrHI4
 PT24xlbVC9DqRoa0XEXNc4o5xgQJm62BEwe7OsYNwvK15OmGRxNo6EZwbSLCCXMMLMj5
 i0JsEpLDv1fxy22+rIv/vy6dT3ogSRX239lX+qB7KXCiRX5+N04oBZiJRDK7U4GCfHsN
 TRLQ==
X-Gm-Message-State: APjAAAVcMhNcz3ragwW1o8FMSLoHHPNzCqhXj4UYZYb0Gn4CFn6Cnari
 zRoukYqYjTBb83e4PODplga6yzLFWhE=
X-Google-Smtp-Source: APXvYqwkrBA1P0X6qMijtc1m/IkH374uodkpj4sCzTHsq7FVgmjD/iynOAUZy7h3h+1OHmfVUN05+Q==
X-Received: by 2002:adf:c611:: with SMTP id n17mr17357418wrg.317.1574419852465; 
 Fri, 22 Nov 2019 02:50:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:50:52 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 01/13] ACPI/IORT: Move IORT to the ACPI folder
Date: Fri, 22 Nov 2019 11:49:48 +0100
Message-Id: <20191122105000.800410-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com,
 jasowang@redhat.com, lenb@kernel.org
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

IORT can be used (by QEMU) to describe a virtual topology containing an
architecture-agnostic paravirtualized device.

In order to build IORT for x86 systems, the driver has to be moved outside
of arm64/. Since there is nothing specific to arm64 in the driver, it
simply requires moving Makefile and Kconfig entries.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 MAINTAINERS                     | 9 +++++++++
 drivers/acpi/Kconfig            | 3 +++
 drivers/acpi/Makefile           | 1 +
 drivers/acpi/arm64/Kconfig      | 3 ---
 drivers/acpi/arm64/Makefile     | 1 -
 drivers/acpi/{arm64 => }/iort.c | 0
 6 files changed, 13 insertions(+), 4 deletions(-)
 rename drivers/acpi/{arm64 => }/iort.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..9153d278f67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,15 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/i2c-multi-instantiate.c
 
+ACPI IORT DRIVER
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Hanjun Guo <guohanjun@huawei.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/acpi/iort.c
+
 ACPI PMIC DRIVERS
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..548976c8b2b0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,9 @@ config TPS68470_PMIC_OPREGION
 	  region, which must be available before any of the devices
 	  using this, are probed.
 
+config ACPI_IORT
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..9d1792165713 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -123,3 +123,4 @@ video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
+obj-$(CONFIG_ACPI_IORT) 	+= iort.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..d0902c85d46e 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -3,8 +3,5 @@
 # ACPI Configuration for ARM64
 #
 
-config ACPI_IORT
-	bool
-
 config ACPI_GTDT
 	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 6ff50f4ed947..38771a816caf 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/iort.c
similarity index 100%
rename from drivers/acpi/arm64/iort.c
rename to drivers/acpi/iort.c
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
