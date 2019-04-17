Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C0C282DD
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5942064B
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5942064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 61C4DE4F;
	Wed, 17 Apr 2019 18:28:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D8B61E4E
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9DF0D14D
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 18:28:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5491C15AB;
	Wed, 17 Apr 2019 11:28:15 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D79D3F59C; 
	Wed, 17 Apr 2019 11:28:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: will.deacon@arm.com,
	lorenzo.pieralisi@arm.com,
	bhelgaas@google.com
Subject: [PATCH v3 2/9] PCI: Add a stub for pci_ats_disabled()
Date: Wed, 17 Apr 2019 19:24:41 +0100
Message-Id: <20190417182448.12382-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417182441.u4h6jbXYD77_yCurgZW1Aib1t1WAg7C0FvKWNqM9sZo@z>

Currently pci_ats_disabled() is only defined when CONFIG_PCI is enabled.
Since we're about to use the function in the Arm SMMUv3 driver, which
could be built with CONFIG_PCI disabled, add a definition of
pci_ats_disabled() for !CONFIG_PCI.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 169c6a18d0b0..61d7cd888bad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1713,6 +1713,7 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 							 struct pci_dev *dev)
 { return NULL; }
+static inline bool pci_ats_disabled(void) { return true; }
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PCI_ATS
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
