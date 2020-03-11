Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C422C2BB8C
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56981227BF
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8RuT72W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56981227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 399C82262E;
	Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xAcssGydZU8K; Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12ABA22268;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D43BC18D3;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B607EC0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A00C85F71
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hl3jbHx553D7 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9EA4185F67
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id t11so2450686wrw.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N4gyYG6pd1qHC2GjZUAc/a5emn2edBGVA7chcRhvAO8=;
 b=R8RuT72WL1I4haJ6qD2A19NADfHGGL4h8E65a5bB32JeKEnVO9JbfE6y04C41FHnLL
 AiH3yxrWmV4b4ouGsgZnYDvH6JyHDntuFb3/9DvYzPs3xRWl9CkmzwGARwuOAyD3ENG8
 ExLs4O2EfRkqOxjujXUUTbIjhiAylBxQ8ybvym8Qyo1jwtRGcka/n1mIYt++nCi7pTJf
 r7VZnDbXLgsvy6IWe8+Hwi6VVKzu0VjNNczUmct/KxpEmMqWQtjtAeb2DhsSv3KYbkPr
 VSYMt4h9O6gpK0lYTWS8aMFDJFwbWDK7v4kkJazCh6yUcurLTvS7ONepD43137VO3oBz
 gmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N4gyYG6pd1qHC2GjZUAc/a5emn2edBGVA7chcRhvAO8=;
 b=nJjpsEIwb5fFcYLvSD5maZSB7aBehRzg7dIaNvftU8Ju7gL/RU7Hn/BqCrubYLtHo0
 ade2IwOLIFHEOHTzQen8O0WhrBcmpvXLy0Adth4gJog8aDzgfsqzr0VouhlLI0NRFqkC
 Psg8Ys+ztl5wd1SiNYNQR4u6LWQsM2icoluh+c/Ne5qhZzEo0fHT6ZCuLpol4SOVILad
 i5l6vpd4KC6rcyUfTdeQFFdCJMz3lVtETfrnxZlLpljvk/sOkycTJLtXlsNeYFRS18Fr
 ahbnkTmDLjvUTV80fPofBwZdU91C9fw4qlrI2+aBgjEKF6Sh1VTIgsJKk7qutupcpbpV
 dfiA==
X-Gm-Message-State: ANhLgQ2cCdC/E5jQj/gamm1vGjRycyAaktrZ2h8YdNtChKsh/7cAza8N
 wWeCxS9HSDdbkR7ThECu6Nxs3A==
X-Google-Smtp-Source: ADFU+vtVplsLJKhJ5k96cjG7bQIJiqMwH6aOvBxLDVX3vK8y4Ou+veGu1hCYgxMQXp8PN1ugVbeDHg==
X-Received: by 2002:adf:a555:: with SMTP id j21mr4427467wrb.409.1583930817062; 
 Wed, 11 Mar 2020 05:46:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:46:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 02/11] PCI: Add ats_supported host bridge flag
Date: Wed, 11 Mar 2020 13:44:57 +0100
Message-Id: <20200311124506.208376-3-jean-philippe@linaro.org>
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

Each vendor has their own way of describing whether a host bridge
supports ATS.  The Intel and AMD ACPI tables selectively enable or
disable ATS per device or sub-tree, while Arm has a single bit for each
host bridge.  For those that need it, add an ats_supported bit to the
host bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: try to improve the comment
---
 drivers/pci/probe.c | 8 ++++++++
 include/linux/pci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..b5e36f06b40a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+
+	/*
+	 * Some systems (ACPI IORT, device-tree) declare ATS support at the host
+	 * bridge, and clear this bit when ATS isn't supported. Others (ACPI
+	 * DMAR and IVRS) declare ATS support with a smaller granularity, and
+	 * need this bit set.
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
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
