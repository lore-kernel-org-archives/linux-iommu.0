Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDE9C3B18C
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9F524650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiYr7b92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 958BD86130;
	Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQwAfZlWyZEA; Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A661860CF;
	Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26E6BC07FE;
	Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1F52C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE03C86E33
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R8Vn2XgDvxzZ for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CD7A586DE7
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:07 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id t23so7041313wmi.1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DLm+diZ2LcHfr0394F1s+yyfGk9eSuidgj94VOIGVJw=;
 b=tiYr7b92oPJK9Rk1Gz7ISnXadjy99eXjJlui5eg7HZk45BvGVN6A61GX0Yu4eKyStX
 vhGv6Ez24Yg8/5hgZtdcD8ly8JxoQmsj0N1Hf7SxEEKVARO5mx5sNNeS0YhSS6e9kq4f
 XotYFn8IB3W5V8rHY+OhK/PWIlMGxUeihlB+8viY5iKvXJKxzAdyjBip2SSKi5kNQJGJ
 C+m9VaqteGLe1AfCrDlGJmNJ9C88TEjEQ9jgLuT5HHgxutbNec16wTRjA7llxO2X0qJH
 mC/avBLY0qWSbS1xsDS5ZHOB8LrkXHdkPiQYRp+vm6UF2MK72kWfz6Rpj2lx/ChK8Sq8
 FOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DLm+diZ2LcHfr0394F1s+yyfGk9eSuidgj94VOIGVJw=;
 b=A+NRnzVl2wKBLnSv9oZ6sPYxmvECCljzZ68llo87JmVQC2Wx8HelnNI+3xdMHQe+t1
 o8GxF+r7IMlcY4+QZsVolpcq2Id5opa+jG9NZy0fdhuz0zHf54pNbWBfkqaur1NEbRCo
 fM3sghV2EInAROqyGPK6oC7vrKH7tP+ABCZH7b8XkszTSFdFNooGQyTRnABeM8VQE0xJ
 zN7EMU5k5n1ryppvS3gZzNK9s++FOAQaqeD88h9wW++SgqxrFYsKmx5Y1ui4tj7P4PER
 6gjoVvvBTN0uh9f8s7iCdUl1Q1NIundWt8yyiEzRTY5yPIbeEK+z10vPufZ7+3XpHcUE
 KoQQ==
X-Gm-Message-State: APjAAAX8B2XRYSu2Wk4POTvBU/dG3DuaNdP6C8ALqKCYc4SRpMonCHKe
 Z1FvffRtLw7QDjFN0Hvr0njiYQ==
X-Google-Smtp-Source: APXvYqywhPBCuc7YV+pVDcQ5dsIQRL3jciqAiBWcZ6RYHFYVHZcjIZ/wRvt2G4McAzl+fiVmWPpNkw==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr6948649wmb.118.1581612726195; 
 Thu, 13 Feb 2020 08:52:06 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:05 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 02/11] PCI: Add ats_supported host bridge flag
Date: Thu, 13 Feb 2020 17:50:40 +0100
Message-Id: <20200213165049.508908-3-jean-philippe@linaro.org>
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

Each vendor has their own way of describing whether a host bridge
supports ATS.  The Intel and AMD ACPI tables selectively enable or
disable ATS per device or sub-tree, while Arm has a single bit for each
host bridge.  For those that need it, add an ats_supported bit to the
host bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/probe.c | 7 +++++++
 include/linux/pci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..75c0a25af44e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,13 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+
+	/*
+	 * Some systems may disable ATS at the host bridge (ACPI IORT,
+	 * device-tree), other filter it with a smaller granularity (ACPI DMAR
+	 * and IVRS).
+	 */
+	bridge->ats_supported = 1;
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..9fe2e84d74d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
+	unsigned int	ats_supported:1;
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
