Return-Path: <SRS0=2m50=W4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87AEC3A5A4
	for <iommu@archiver.kernel.org>; Sun,  1 Sep 2019 11:25:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9660D2339D
	for <iommu@archiver.kernel.org>; Sun,  1 Sep 2019 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNkmgSDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660D2339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4CD0D5B18;
	Sun,  1 Sep 2019 11:25:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E31E22A57
	for <iommu@lists.linux-foundation.org>;
	Sun,  1 Sep 2019 11:25:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A1212709
	for <iommu@lists.linux-foundation.org>;
	Sun,  1 Sep 2019 11:25:10 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id t9so11788596wmi.5
	for <iommu@lists.linux-foundation.org>;
	Sun, 01 Sep 2019 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=01HPTey408UCBL639ZxLYtnZytu5ResDsXDWNRYopFs=;
	b=uNkmgSDRj0aCeJn8wLr/V5uo7ANHZI0Ir4fFw+tfD1CApEj8Mh/wK0Ze7wqdsdBTwD
	wKWWEheNTcNp0sLjO2N31rD5C/mAyePd5I7tPCw+uazWklSplQpGR8VILBdNyVTG1EKy
	x38I63zw9kYwo6PFRwKZyMWg6l3Z74zmSEaE4RXuSFukNISKQDboWeB8EAD5yrS+hfRN
	dBNbudRWyt/FYS5Ire4D12/nCZX29mdcqnjnQpH42mVJ2xlBHRdGvB2PLhH/6QTKYCNe
	DnUIsqnWL3uxsBg0t21xLKaRb609UUIlp8hgs52Bo9OTq4DscFhMg6CpMHf6BBQujP37
	U7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=01HPTey408UCBL639ZxLYtnZytu5ResDsXDWNRYopFs=;
	b=By6CRzQsm7XJLTsP1l2hYhd0ZGE1nup0YAshU8NDCXCma4UzVCPg0nRapRL+w7847T
	F/Jm3vTXVW6/lXBsbR2Tj65VNdEGOCk9nyWwQrG93ret09XCIgk0UYUZgJuTH4rxwwbS
	CLTePe6jYWs8k1iNgFTwT5SH/QaZQUfikXCrwEVP+9eXEYSdou+wHoYPcvfJEhRA02cj
	kAFBgI2npYm7ec3/gwWOY+LLpMhswIbxrVmcHb23tvSQ6PtqaylYmQHeqWcPH9B2Tap3
	0hJDrkte0sZZM+pw98l5iAtdVCXO6xS8RAMGouDu0VV23Z9T/CymoJh/QiY4Jbn/8vBy
	mlGA==
X-Gm-Message-State: APjAAAVoA5oYAvD9mW+VguRXIQgC5HFTpSE0w/kR3L482ui4FilK3M+Q
	QGpKDTWcJDu6jYGvv1TD1mo=
X-Google-Smtp-Source: APXvYqy1j+qHgGkl142BUZQL/cgCiSDmmOxkvewbJoqW69rnrk6CVgyUWdrQETI/0pc6am1fndsuUg==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr28564345wmk.33.1567337109185; 
	Sun, 01 Sep 2019 04:25:09 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de.
	[91.64.150.195])
	by smtp.gmail.com with ESMTPSA id x5sm747241wrg.69.2019.09.01.04.25.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 01 Sep 2019 04:25:08 -0700 (PDT)
From: Krzysztof Wilczynski <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: Remove unused includes and superfluous struct declaration
Date: Sun,  1 Sep 2019 13:25:06 +0200
Message-Id: <20190901112506.8469-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Remove <linux/pci.h> and <linux/msi.h> from being included
directly as part of the include/linux/of_pci.h, and remove
superfluous declaration of struct of_phandle_args.

Move users of include <linux/of_pci.h> to include <linux/pci.h>
and <linux/msi.h> directly rather than rely on both being
included transitively through <linux/of_pci.h>.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/iommu/of_iommu.c                          | 2 ++
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/pci-aardvark.c             | 1 +
 drivers/pci/pci.c                                 | 1 +
 drivers/pci/probe.c                               | 1 +
 include/linux/of_pci.h                            | 4 +---
 6 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..026ad2b29dcd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/limits.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d3156446ff27..7a9bef993e57 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -10,6 +10,7 @@
 
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fc0fe4d4de49..3a05f6ca95b0 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 484e35349565..571e7e00984b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 169943f17a4c..11b11a652d18 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 21a89c4880fa..7929b4c0e886 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -2,11 +2,9 @@
 #ifndef __OF_PCI_H
 #define __OF_PCI_H
 
-#include <linux/pci.h>
-#include <linux/msi.h>
+#include <linux/types.h>
 
 struct pci_dev;
-struct of_phandle_args;
 struct device_node;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
