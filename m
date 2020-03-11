Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44FC2BBDE
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A97227BF
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0OldcPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A97227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45C2685F79;
	Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZVQIWO1bXvt; Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86EDE85F7E;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E08EC18D3;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 832D7C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7CE9785F71
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wd8YsPj2R5nr for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C814285F67
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id e26so1954326wme.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d7fzzw/5lEfLgru+68iO/J8krazqjJjWjKm9fH3TH5I=;
 b=d0OldcPYPTwC6lUxav+jf6KB+UcGBjwxPVFVLOS8P+DRcf4Nq9+Cgk3ER62YCupyKO
 n63Plm+lXXP1tDCSs66zuHCHs/M9n6CcfUD83j6S1A3sgTchEZWf/GNdy1+Sg6PJsXx7
 v6vVCuz7+yMQ9U+jeSTzabfnBGdgbxAl7+8p5eiV0vMWAbcwpvxqhcw3kVlpD7RcuEis
 e5lM+BenuFHNorZQvoPD0B0I5/lix/gZ+JhB+tlQQjDMmJ4sZt8Pupm67tdBc4wFY0mf
 EgB/VSPg8NrV9V5qGawXDH19VqniDfIEy7gvlpILkFxSAN86lG2R7fZNu+SKWuDilrZc
 hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d7fzzw/5lEfLgru+68iO/J8krazqjJjWjKm9fH3TH5I=;
 b=tLUstuT73L6wdUjVrct8wHchZZ1AsQ/4aCcFvdTHl+vYz1HWC1apIqdMh7rfp0mVo0
 aQfQVS95773THxBgTK2iS1x24LpmsnS1v3tGGGsxheBIPcAa8icpLPbcdsLM7DAEdUoO
 Ppm4UTVGcqugfnkKMZfoAVziEHw+MN7jwTqSwDcrNTR8WFy2TC0H/Lbr3IeXO5fG/75b
 Cgd40tTbrrdq7i2RWQfiZNnOpp3BqTGMaA+xoA9gbql8ulg1sR3KFFqPOL7+G/YpM9FJ
 +DhfcnXHt8ndmHN0xMbf2aZSlWvkC1QKQrUeTn0oO9wprczpSnsjx4I5JS+FFzkXJ5pw
 JPZQ==
X-Gm-Message-State: ANhLgQ2DEz8LWxjQvSXp1rwaG54BJCW5KZx86YtIHiwXjdHU8NZjstKj
 YPh+20bcK8iLArmzzLsNkzuXmQ==
X-Google-Smtp-Source: ADFU+vtrrbz3xW1uwROP0nlDBlOyziir6FkZYgi3Shk3F4IjgLnSc2vkzPiEnYQH9VQXQDGBOwBJWg==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr3550520wmc.166.1583930818310; 
 Wed, 11 Mar 2020 05:46:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:46:57 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 03/11] PCI: OF: Check whether the host bridge supports ATS
Date: Wed, 11 Mar 2020 13:44:58 +0100
Message-Id: <20200311124506.208376-4-jean-philippe@linaro.org>
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

When setting up a generic host on a device-tree based system, copy the
ats-supported flag into the pci_host_bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: keep the helper in pci-host-common.c
---
 drivers/pci/controller/pci-host-common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 250a3fc80ec6..2e800bc6ae7a 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -54,6 +54,16 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	return ERR_PTR(err);
 }
 
+static void of_pci_host_check_ats(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = bridge->bus->dev.of_node;
+
+	if (!np)
+		return;
+
+	bridge->ats_supported = of_property_read_bool(np, "ats-supported");
+}
+
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops)
 {
@@ -92,6 +102,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	of_pci_host_check_ats(bridge);
 	platform_set_drvdata(pdev, bridge->bus);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
