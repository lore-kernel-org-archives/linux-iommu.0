Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D6C38C0D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFCE20880
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaB0/woq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFCE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D8CF20519;
	Mon, 24 Feb 2020 18:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XmZ4EP9QEVM; Mon, 24 Feb 2020 18:25:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DDB9C20414;
	Mon, 24 Feb 2020 18:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4A58C18DA;
	Mon, 24 Feb 2020 18:25:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3AFDC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B33A9860C5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vSAtGUwP-wpu for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F257285F98
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id z12so304064wmi.4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L4b0/E9FteCzWtJ3m41x7utj4DLNM6J+Wsoo7xEmR/M=;
 b=AaB0/woqy++LPMkoIBZ+m4G2UZnpMtnZvwcO6++TMOA9EU96huOkx2S0UskmT4cEpU
 xMrifrssPWkaFWKgEl2sH4pudtTv9O5xP8UA1tGUign2rkYDTr5uz/QuiZzooFCt1UtE
 rFYtkQKLo4kgyRbPCGQdQ0RkTH5WIdikmyUEt5mlxrO2m5pQuEYSi3SrHoKPrs6ir6C0
 h1xnyNfpSIa1Ci4ubWuYL1OusT1Jg5137L60+g+2IYH6Io8VN2+J8l0BSyTJWIJ6meQH
 bVi7Q64CjqZ4FvWJAUKwwHkRMFvfOpZv/R9jAdlHM31BS2Lo6e6itFaGlBgY5e1Zdzw/
 2HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L4b0/E9FteCzWtJ3m41x7utj4DLNM6J+Wsoo7xEmR/M=;
 b=RKJn2+VAZ0YDE9cVVbSU35U6V/pj+fqsFACW4CS1eu6c4OcqGIPWvczdMwlhRF96GY
 vWRO90CiTnzJWUDwwZxJWsQ2RmB/itPCDiTucYu3uBvgT0h2GcL0FVHUn+dJt6M4LtFE
 Z9wg8XnVWOZaAsF1uz0npxaEalVYy6idRQq2uS0NxL7tVMwYgY1bWsgKP+uhQo9Ln/6S
 W/i/9aE6eqPpsWh74PaIt74ttL3T2z6NVs/1I4R3D+ncIMjQfmB+aFSoQRA9OzumvGXz
 WEi5x8upMb0ugwLPcIzdge03biSdwv6jrqJguifD66Zoy04trJbZnZJvheq+6BEra2vW
 W2Wg==
X-Gm-Message-State: APjAAAWRXxPJKqaBoEsM2/SmX5X+E+D+bLRh3M3fv+5mRRYwP7LTAFOs
 tXZf96zz0HCFWTzute8VEeZ1MHXORPo=
X-Google-Smtp-Source: APXvYqx6ypZ/kM3sOzy1vTskWfaUURVJkjgEhRCiqvXYI27Ek63kaa7GG0Ur7iiefNgxz5pwggvx6A==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr296154wmj.61.1582568697369;
 Mon, 24 Feb 2020 10:24:57 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:56 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 25/26] PCI/ATS: Export symbols of PRI functions
Date: Mon, 24 Feb 2020 19:24:00 +0100
Message-Id: <20200224182401.353359-26-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bbfd0d42b8b9..fc8fc6fc8bd5 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
