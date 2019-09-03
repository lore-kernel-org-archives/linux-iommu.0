Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFCAC3A5A2
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 11:31:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEB421897
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxQ0A7gL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEB421897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 05747D7D;
	Tue,  3 Sep 2019 11:31:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 988CED4B
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 11:31:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC7838A2
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 11:31:02 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id c10so5831598wmc.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 03 Sep 2019 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2Ekc0W7zJk5w+9GqjfFzhlAJ4FiN+oEvkKnq/TUY/UA=;
	b=rxQ0A7gL/rvUTRgFS/x6Jhz66KR/9EtqdUj00Gi6qx2X2kvUeehgUkd8+p67o1zAdh
	jhHPTILE48XYrnwg8UBBO258FnM17/u/jy7Djy7SpVAb0P8pFAoTW1qOfpfAwfNjhJAT
	DgMvezl32n1VEXVXQNQbjeAq4GqCIpmC++6kN/xbkwj+u+PUgbKIgQ1Llm24sLydd5ao
	LKeszXIV4Hr0QQP3BUctE8YxTL4jz9rRJTA4f8AjNqEOacNNW1CVAeZAN2slkCI5Hcqh
	2/OS+iB6IzU6RSZYWkyMRuB5kD1XX6OEaiVdFvsFPUttT5lL/m20kyhe/Hpi4gYMB5ti
	fqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=2Ekc0W7zJk5w+9GqjfFzhlAJ4FiN+oEvkKnq/TUY/UA=;
	b=KtUdTSpMDEmIqQzculFALfJD1yGguPy/QaDZ5nfg82L4e7vqQ6kSJEhB9AaXslQ/6w
	v5VfqTDtQVKCuTBgHKkMACicjMgvVJTayqRP15QE1A0OH0+AEGsRg0IIRHplQX9Aj1CS
	55Q3ENR1IxG8gaSF/bIpA+posEEINiAHtOAL8/7n10gn6+5U4jjkoWyFSz1TfXCvuNSq
	LTKIe8ROURXhVvRjb7C+MCQip0YNTd3+Jx363t1gTYZbcM6FizLcn3oqu7vuF3VD5NPk
	xCrjvYiUdm+LXuBGH3LnC2n5iEcQiJU6B+Kx2x5h4NJIsZho1bpKFggjLEoecCzKt/k3
	e22g==
X-Gm-Message-State: APjAAAVBFB9Rjzn5rQZSR/1MkxNOcpcBMmWA2dQUY3z+pIjyiCv/DOMx
	UnXU5x6AjpP1oFIcHdF3oZU=
X-Google-Smtp-Source: APXvYqziAyX3arV2k8bnfEcXOZ1Bh4SmqiEN1nono5tsDY7ufXY/SqE/5xUTbeQQ6Nd5YaemyR+OCQ==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr29102252wmd.14.1567510261446;
	Tue, 03 Sep 2019 04:31:01 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de.
	[91.64.150.195]) by smtp.gmail.com with ESMTPSA id
	l2sm19455074wme.36.2019.09.03.04.31.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 03 Sep 2019 04:31:00 -0700 (PDT)
From: Krzysztof Wilczynski <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2] PCI: Remove unused includes and superfluous struct
	declaration
Date: Tue,  3 Sep 2019 13:30:59 +0200
Message-Id: <20190903113059.2901-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190901112506.8469-1-kw@linux.com>
References: <20190901112506.8469-1-kw@linux.com>
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
 drivers/irqchip/irq-gic-v2m.c                     | 1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/pci-aardvark.c             | 1 +
 drivers/pci/controller/pci-thunder-pem.c          | 1 +
 drivers/pci/pci.c                                 | 1 +
 drivers/pci/probe.c                               | 1 +
 include/linux/of_pci.h                            | 5 ++---
 9 files changed, 11 insertions(+), 3 deletions(-)

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
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index e88e75c22b6a..fbec07d634ad 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 229d586c3d7a..87711e0f8014 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/acpi_iort.h>
+#include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
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
 
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index f127ce8bd4ef..9491e266b1ea 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-acpi.h>
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
index 21a89c4880fa..29658c0ee71f 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -2,11 +2,10 @@
 #ifndef __OF_PCI_H
 #define __OF_PCI_H
 
-#include <linux/pci.h>
-#include <linux/msi.h>
+#include <linux/types.h>
+#include <linux/errno.h>
 
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
