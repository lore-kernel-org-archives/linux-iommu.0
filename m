Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E71FC3B197
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E30206ED
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="am+o3vVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E30206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DED39860CF;
	Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9CchXCrlb5c; Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7618A86135;
	Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64289C07FE;
	Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB299C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C626D860CF
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41xE-Fc99w5U for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D1DC086130
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id t3so7549413wru.7
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oJuZlZp89pOsXq+0VjXQ9jH+YMeD48viPFbAUV42/7c=;
 b=am+o3vVNolOAaASmrjBUw9hY20zh4HtDIeCV6yutj5xzyXVGB72Y16IHxHQIChWN4K
 RwEtBXyPJzyBdLrUiuDB9WebfVID313RPtxibqDBWL2qI4fEdVhWvQdYBtq8iutE2Txo
 w88Wt4/3NYU97+1x1rVFsDxgWkSkf5Y5U5yAYg/nOTIQTDbrGTepdUcz0DlVUZ3/K36x
 9H8N+uDIR/4lAvu+ulNTEYXWpYhtxoIrTTyYBvEDAkg3aGBagLnZaGfdsHrcMOkeYCLH
 gUkMaS0Nl4Eix25KyyEsKtyXrPM+71nsvKDJsWYCA2NZQ4m0FRLUlADHZ2WFOr3VOT/B
 q1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oJuZlZp89pOsXq+0VjXQ9jH+YMeD48viPFbAUV42/7c=;
 b=LVBiaOK6cA+msgR+NRqnD8/oVlJLN0/+7vXDhh+iAX15LB8+sIwTF+XZ1J4SEUWzeS
 lkHyRDPxjDdfC8efpa3+54dGL6CzCYFMNCRrWI0ZsfnzNJmp/sgj6qw8jHiI4XtA3Kdj
 fIYY4bcDz3tVArsyX600y1LbeGip7eZGctH01JR6vLcExnwi8LO5g+E+KS3HCNmURY3+
 izzwtb44eW2fKs+l/+2tvtdfaI1qBTdKuakejvlzqEnalFSffj/34SaOR+KnovJANQcI
 kflB2NGqEJydgubRwH88TNCiRtpd5i5YUG8MY927RFq40cXfuGU0gXkMlj9OezlFYBZL
 TTPA==
X-Gm-Message-State: APjAAAWsmExwicLG/z7lR59gyp6WUv7i50zTsZujpxlJc2NSJG39BtNS
 gmZY8uUxVXqZ63aoeZ0+02Z4DA==
X-Google-Smtp-Source: APXvYqyRdKXRvNXU931mCSFJbrbPQ+3L84wtnv9cjPTz5Ed5dcoIv/1s7/DTUZ9TwVfpeh22DgxFBg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr21737194wro.279.1581612727305; 
 Thu, 13 Feb 2020 08:52:07 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:06 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 03/11] PCI: OF: Check whether the host bridge supports ATS
Date: Thu, 13 Feb 2020 17:50:41 +0100
Message-Id: <20200213165049.508908-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
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

Copy the ats-supported flag into the pci_host_bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/controller/pci-host-common.c | 1 +
 drivers/pci/of.c                         | 9 +++++++++
 include/linux/of_pci.h                   | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 250a3fc80ec6..a6ac927be291 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -92,6 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	of_pci_host_check_ats(bridge);
 	platform_set_drvdata(pdev, bridge->bus);
 	return 0;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..4b8a877f1e9f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -576,6 +576,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
 
+void of_pci_host_check_ats(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = bridge->bus->dev.of_node;
+
+	if (!np)
+		return;
+
+	bridge->ats_supported = of_property_read_bool(np, "ats-supported");
+}
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..2d0af410438c 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -7,12 +7,14 @@
 
 struct pci_dev;
 struct device_node;
+struct pci_host_bridge;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
+void of_pci_host_check_ats(struct pci_host_bridge *bridge);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -26,6 +28,7 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline void of_pci_check_probe_only(void) { }
+static inline void of_pci_host_check_ats(struct pci_host_bridge *bridge) { }
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
