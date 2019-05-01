Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95ACC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:59:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F6A21670
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F6A21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E50F0474F;
	Wed,  1 May 2019 13:59:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D63E83778
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:58:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 46099711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:58:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119E015AD;
	Wed,  1 May 2019 06:58:41 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
	[10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9201E3F5AF;
	Wed,  1 May 2019 06:58:38 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg() in two
	parts
Date: Wed,  1 May 2019 14:58:19 +0100
Message-Id: <20190501135824.25586-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
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
Message-ID: <20190501135819.xcoJdlUtxCkOsYL_qsf3P4M_6BobfG6iRO3rWqZ1eCU@z>

On RT, iommu_dma_map_msi_msg() may be called from non-preemptible
context. This will lead to a splat with CONFIG_DEBUG_ATOMIC_SLEEP as
the function is using spin_lock (they can sleep on RT).

iommu_dma_map_msi_msg() is used to map the MSI page in the IOMMU PT
and update the MSI message with the IOVA.

Only the part to lookup for the MSI page requires to be called in
preemptible context. As the MSI page cannot change over the lifecycle
of the MSI interrupt, the lookup can be cached and re-used later on.

iomma_dma_map_msi_msg() is now split in two functions:
    - iommu_dma_prepare_msi(): This function will prepare the mapping
    in the IOMMU and store the cookie in the structure msi_desc. This
    function should be called in preemptible context.
    - iommu_dma_compose_msi_msg(): This function will update the MSI
    message with the IOVA when the device is behind an IOMMU.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Auguer <eric.auger@redhat.com>

---
    Changes in v3:
        - Update the comment to use kerneldoc format
        - Fix typoes in the comments
        - More use of msi_desc_set_iommu_cookie
        - Add Robin's and Eric's reviewed-by

    Changes in v2:
        - Rework the commit message to use imperative mood
        - Use the MSI accessor to get/set the iommu cookie
        - Don't use ternary on return
        - Select CONFIG_IRQ_MSI_IOMMU
        - Pass an msi_desc rather than the irq number
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/dma-iommu.c | 46 +++++++++++++++++++++++++++++++++++++---------
 include/linux/dma-iommu.h | 25 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816..eb1c8cd243f9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,6 +94,7 @@ config IOMMU_DMA
 	bool
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
 config FSL_PAMU
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe637a60..f847904098f7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -888,17 +888,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
-	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
+	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
 	unsigned long flags;
 
-	if (!domain || !domain->iova_cookie)
-		return;
+	if (!domain || !domain->iova_cookie) {
+		desc->iommu_cookie = NULL;
+		return 0;
+	}
 
 	cookie = domain->iova_cookie;
 
@@ -911,7 +912,36 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	spin_unlock_irqrestore(&cookie->msi_lock, flags);
 
-	if (WARN_ON(!msi_page)) {
+	msi_desc_set_iommu_cookie(desc, msi_page);
+
+	if (!msi_page)
+		return -ENOMEM;
+	return 0;
+}
+
+void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+			       struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_dma_msi_page *msi_page;
+
+	msi_page = msi_desc_get_iommu_cookie(desc);
+
+	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_page->iova);
+	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo += lower_32_bits(msi_page->iova);
+}
+
+void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
 		/*
 		 * We're called from a void callback, so the best we can do is
 		 * 'fail' by filling the message with obviously bogus values.
@@ -922,8 +952,6 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo = ~0U;
 		msg->data = ~0U;
 	} else {
-		msg->address_hi = upper_32_bits(msi_page->iova);
-		msg->address_lo &= cookie_msi_granule(cookie) - 1;
-		msg->address_lo += lower_32_bits(msi_page->iova);
+		iommu_dma_compose_msi_msg(desc, msg);
 	}
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..0b781a98ee73 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -71,12 +71,26 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 /* The DMA API isn't _quite_ the whole story, though... */
+/*
+ * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU device
+ *
+ * The MSI page will be stored in @desc.
+ *
+ * Return: 0 on success otherwise an error describing the failure.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+
+/* Update the MSI message if required. */
+void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+			       struct msi_msg *msg);
+
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
 
 struct iommu_domain;
+struct msi_desc;
 struct msi_msg;
 struct device;
 
@@ -99,6 +113,17 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+
+static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+					     struct msi_msg *msg)
+{
+}
+
 static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
