Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755DC43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9264720656
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E857224A;
	Mon, 29 Apr 2019 14:46:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CCAEA21D6
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6608471C
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:44:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 445C8EBD;
	Mon, 29 Apr 2019 07:44:40 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
	[10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E9B3F5C1;
	Mon, 29 Apr 2019 07:44:37 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/7] genirq/msi: Add a new field in msi_desc to store an
	IOMMU cookie
Date: Mon, 29 Apr 2019 15:44:22 +0100
Message-Id: <20190429144428.29254-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
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
Message-ID: <20190429144422.2b0O6UYzYPum8P3B_C4fXIUhYD-E_5DHaCYqdr8A2kA@z>

When an MSI doorbell is located downstream of an IOMMU, it is required
to swizzle the physical address with an appropriately-mapped IOVA for any
device attached to one of our DMA ops domain.

At the moment, the allocation of the mapping may be done when composing
the message. However, the composing may be done in non-preemtible
context while the allocation requires to be called from preemptible
context.

A follow-up change will split the current logic in two functions
requiring to keep an IOMMU cookie per MSI.

A new field is introduced in msi_desc to store an IOMMU cookie. As the
cookie may not be required in some configuration, the field is protected
under a new config CONFIG_IRQ_MSI_IOMMU.

A pair of helpers has also been introduced to access the field.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Update the commit message to use imperative mood
        - Protect the field with a new config that will be selected by
        IOMMU_DMA later on
        - Add a set of helpers to access the new field
---
 include/linux/msi.h | 26 ++++++++++++++++++++++++++
 kernel/irq/Kconfig  |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..82a308c19222 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
@@ -119,6 +122,29 @@ struct msi_desc {
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return desc->iommu_cookie;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+	desc->iommu_cookie = iommu_cookie;
+}
+#else
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return NULL;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+}
+#endif
+
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2baefca9..8fee06625c37 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config IRQ_MSI_IOMMU
+	bool
+
 config HANDLE_DOMAIN_IRQ
 	bool
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
