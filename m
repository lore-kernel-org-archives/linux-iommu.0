Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1752BC10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6447214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6447214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CAB101BD7;
	Thu, 18 Apr 2019 17:26:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 911F91BB7
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 17:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3B171828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 17:26:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BCBA169E;
	Thu, 18 Apr 2019 10:26:36 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
	[10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6FCD3F557;
	Thu, 18 Apr 2019 10:26:33 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 6/7] irqchip/gic-v3-mbi: Don't map the MSI page in
	mbi_compose_m{b, s}i_msg
Date: Thu, 18 Apr 2019 18:26:10 +0100
Message-Id: <20190418172611.21561-7-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	robin.murphy@arm.com, Julien Grall <julien.grall@arm.com>,
	miquel.raynal@bootlin.com, tglx@linutronix.de,
	logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418172610.741DWFv5v01r-o0H50pOYL6YfaI08Giw_u5XtefcG5Q@z>

The functions mbi_compose_m{b, s}i_msg may be called from non-preemptible
context. However, on RT, iommu_dma_map_msi_msg requires to be called
from a preemptible context.

A recent patch split the function iommu_dma_map_msi_msg in 2 functions:
one that should be called in preemptible context, the other does
not have any requirement.

This patch reworks the GICv3 MBI driver to avoid executing preemptible
code in non-preemptible context by preparing the MSI mappings when
allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index fbfa7ff6deb1..c812b80e3ce9 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -84,6 +84,7 @@ static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
 static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct mbi_range *mbi = NULL;
 	int hwirq, offset, i, err = 0;
 
@@ -104,6 +105,16 @@ static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = mbi->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    mbi_phys_base + GICD_CLRSPI_NSR);
+	if (err)
+		return err;
+
+	err = iommu_dma_prepare_msi(info->desc,
+				    mbi_phys_base + GICD_SETSPI_NSR);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = mbi_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
@@ -142,7 +153,7 @@ static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
 	msg[0].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(data->irq, msg);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -202,7 +213,7 @@ static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
 	msg[1].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, &msg[1]);
+	iommu_dma_compose_msi_msg(data->irq, &msg[1]);
 }
 
 /* Platform-MSI specific irqchip */
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
