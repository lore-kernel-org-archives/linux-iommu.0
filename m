Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BBCC3F2D8
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849CF22464
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaFI7USc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849CF22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D04787EA8;
	Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZwDpubyPfuMe; Wed, 11 Mar 2020 12:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE9A387E4A;
	Wed, 11 Mar 2020 12:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B90EDC18D3;
	Wed, 11 Mar 2020 12:47:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD1B7C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 55EFC85F7D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NNnkUWJa-P5x for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B89D85F67
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g62so1978114wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U47FGde+FbNcdQs+RPhyYEqijb3kd9q1HrNDc4ml5OM=;
 b=PaFI7UScmuJq/vQMffhQojPOeVfgLOAOjM4tY3da2DCq6MkkfzqrKf7V1Pxw17ncw8
 I7lQsl4LNyrad1s2jqB7jxtjderJz1RfVJLzyzLHT+oAi/Nou6U8jheMoW1RCz5MFSmt
 8TqQOYGDNPNoEyjr7Wiqwd81sNgrr8blWpNAwkKUf1YvpBlEq53rad+vRE26mSuLionw
 wAz0sy3xHgGF1Xt7nkvW0dLEL7P3CqIctcFCnPvoWBwkwSJ3aEqgNcQBJaSFzZUK4ZuH
 LE/gRrJ60DA+fHf+OG44ZIz5IHRMbefyq84xQfidyBcnHlOEgny1G6Qa9QaCs7OF3Ab7
 7uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U47FGde+FbNcdQs+RPhyYEqijb3kd9q1HrNDc4ml5OM=;
 b=CaLsTfxcyUnX7CPADUP0Q+mdr9eep+hS+8/tByZNA9c3GMbbCjTdo+wZk1GBNaWzDG
 kCmbmAlq29gryI71nSRaysIMNkuwpxJ7kV5zj/UVDNCzXXd8OBc9pFJCPUZTQmRJXVS5
 kp0tw8bEMJ8YZUjJnliZB0zfcnyq7Jdf6qJ5wVxApmycxxr7rezSFHQXJ0NFh+7gQAZR
 h0AzbDKxaayqMAD6HFyqzAzmn+fCBKZGBce/5TK/35uIyI2eI51N5oeVqVL4uDeaNUan
 5WSYARHCEat1JInIw+aiKtqcO3qs7JzPr0WtHkIRekgjRJ1zKDKNv34ZoTBQI2KOnJvc
 nPWA==
X-Gm-Message-State: ANhLgQ1OUEMSlciZb0hV/IKJl0+iqoLZhmXv9G0iGLg3uTloQUxt96iU
 f2ubL+9Rsiy39Tkyi5oMD9+GAg==
X-Google-Smtp-Source: ADFU+vssp6pgSA4SHhUAKAeskjqrgFN5K6L5kBvQztm1aXqSMSSOxW9M674hcGUdXj2nfa3aXBAr9Q==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr1007198wmb.110.1583930819703; 
 Wed, 11 Mar 2020 05:46:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:46:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 04/11] ACPI/IORT: Check ATS capability in root complex node
Date: Wed, 11 Mar 2020 13:44:59 +0100
Message-Id: <20200311124506.208376-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 frowand.list@gmail.com, corbet@lwn.net, liviu.dudau@arm.com, rjw@rjwysocki.net,
 guohanjun@huawei.com, amurray@thegoodpenguin.co.uk, robin.murphy@arm.com,
 dwmw2@infradead.org, lenb@kernel.org
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

When initializing a PCI root bridge, copy its "ATS supported" attribute
into the root bridge.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 27 +++++++++++++++++++++++++++
 drivers/acpi/pci_root.c   |  3 +++
 include/linux/acpi_iort.h |  8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..d99d7f5b51e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1633,6 +1633,33 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 		}
 	}
 }
+
+static acpi_status iort_match_host_bridge_callback(struct acpi_iort_node *node,
+						   void *context)
+{
+	struct acpi_iort_root_complex *pci_rc;
+	struct pci_host_bridge *host_bridge = context;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+
+	return pci_domain_nr(host_bridge->bus) == pci_rc->pci_segment_number ?
+		AE_OK : AE_NOT_FOUND;
+}
+
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_root_complex *pci_rc;
+
+	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+			      iort_match_host_bridge_callback, host_bridge);
+	if (!node)
+		return;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	host_bridge->ats_supported = !!(pci_rc->ats_attribute &
+					ACPI_IORT_ATS_SUPPORTED);
+}
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d1e666ef3fcc..eb2fb8f17c0b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -917,6 +918,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
 
+	iort_pci_host_bridge_setup(host_bridge);
+
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
 	 * exists and returns 0, we must preserve any PCI resource
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..7b06871cc3aa 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
+#include <linux/pci.h>
 
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
@@ -55,4 +56,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 #endif
 
+#if defined(CONFIG_ACPI_IORT) && defined(CONFIG_PCI)
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge);
+#else
+static inline
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge) { }
+#endif
+
 #endif /* __ACPI_IORT_H__ */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
