Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C4C4332F
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3FB6403B7;
	Sat, 27 Nov 2021 01:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RqFcMtP5g9WT; Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63087403B1;
	Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC0DC001C;
	Sat, 27 Nov 2021 01:20:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33455C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F28F607DA
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="IAGZg4nE";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="TLo9yqN9"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DI3ZzFPmZgej for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B51961BFE
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:28 +0000 (UTC)
Message-ID: <20211126230524.661169696@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=7645zM4jmr/sh6ufNFcrhF4sFIscYYINKeWaqJ1fetg=;
 b=IAGZg4nEuFV633zEHMYdJKOCg7bgw4YrAVFNJUrjZ6yJK/gpmDGk25/L6OOkCASCsXASNR
 WoD0h5u+OkB6oI/XU2UslSdkC5mxlRUYlai18Q/3KTqR9slgbNpd932hDu5FcUUAI4ThFu
 cuwZfRXgRESttb7cVw2IXItRIM7pgioliIXIAVKEuqUCTZmL1AeWTuVEoMBvJw8RGu0ZjL
 kEsObjfMyWDDaBJfcV9gZO4y6DiXQ/wZkSUrZVV5vbRKvgYcPUDoyA5QtEQYfd4VYZF18y
 MoKnB6dtm645MX86nUSGcnIC+S81YOgtr3B1CzkN6tsKsdahgnK2wNKN+SXUBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=7645zM4jmr/sh6ufNFcrhF4sFIscYYINKeWaqJ1fetg=;
 b=TLo9yqN9MqnxrgYUmD761QTMbiItfPBJoAiz5YYue8yjXytxOqW2NlXOECM+lmVUFx2gew
 elfrS7MJTlOqQCBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 12/37] platform-msi: Rename functions and clarify comments
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:26 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

It's hard to distinguish what platform_msi_domain_alloc() and
platform_msi_domain_alloc_irqs() are about. Make the distinction more
explicit and add comments which explain the use cases properly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c     |   36 +++++++++++++++++++++---------------
 drivers/irqchip/irq-mbigen.c    |    4 ++--
 drivers/irqchip/irq-mvebu-icu.c |    6 +++---
 include/linux/msi.h             |    8 ++++----
 4 files changed, 30 insertions(+), 24 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -313,17 +313,18 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_fr
  *                              a platform-msi domain
  * @domain:	The platform-msi domain
  *
- * Returns the private data provided when calling
- * platform_msi_create_device_domain.
+ * Return: The private data provided when calling
+ * platform_msi_create_device_domain().
  */
 void *platform_msi_get_host_data(struct irq_domain *domain)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
+
 	return data->host_data;
 }
 
 /**
- * __platform_msi_create_device_domain - Create a platform-msi domain
+ * __platform_msi_create_device_domain - Create a platform-msi device domain
  *
  * @dev:		The device generating the MSIs
  * @nvec:		The number of MSIs that need to be allocated
@@ -332,7 +333,11 @@ void *platform_msi_get_host_data(struct
  * @ops:		The hierarchy domain operations to use
  * @host_data:		Private data associated to this domain
  *
- * Returns an irqdomain for @nvec interrupts
+ * Return: An irqdomain for @nvec interrupts on success, NULL in case of error.
+ *
+ * This is for interrupt domains which stack on a platform-msi domain
+ * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
+ * that platform-msi domain which is the parent for the new domain.
  */
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
@@ -372,18 +377,19 @@ struct irq_domain *
 }
 
 /**
- * platform_msi_domain_free - Free interrupts associated with a platform-msi
- *                            domain
+ * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
+ *				     device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the free operation
  * @nvec:	How many interrupts to free from @virq
  */
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec)
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	struct msi_desc *desc, *tmp;
+
 	for_each_msi_entry_safe(desc, tmp, data->dev) {
 		if (WARN_ON(!desc->irq || desc->nvec_used != 1))
 			return;
@@ -397,10 +403,10 @@ void platform_msi_domain_free(struct irq
 }
 
 /**
- * platform_msi_domain_alloc - Allocate interrupts associated with
- *			       a platform-msi domain
+ * platform_msi_device_domain_alloc - Allocate interrupts associated with
+ *				      a platform-msi device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the allocate operation
  * @nr_irqs:	How many interrupts to free from @virq
  *
@@ -408,8 +414,8 @@ void platform_msi_domain_free(struct irq
  * with irq_domain_mutex held (which can only be done as part of a
  * top-level interrupt allocation).
  */
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs)
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
@@ -421,7 +427,7 @@ int platform_msi_domain_alloc(struct irq
 	err = msi_domain_populate_irqs(domain->parent, data->dev,
 				       virq, nr_irqs, &data->arg);
 	if (err)
-		platform_msi_domain_free(domain, virq, nr_irqs);
+		platform_msi_device_domain_free(domain, virq, nr_irqs);
 
 	return err;
 }
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -207,7 +207,7 @@ static int mbigen_irq_domain_alloc(struc
 	if (err)
 		return err;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err)
 		return err;
 
@@ -223,7 +223,7 @@ static int mbigen_irq_domain_alloc(struc
 static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mbigen_domain_ops = {
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -221,7 +221,7 @@ mvebu_icu_irq_domain_alloc(struct irq_do
 		icu_irqd->icu_group = msi_data->subset_data->icu_group;
 	icu_irqd->icu = icu;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err) {
 		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
 		goto free_irqd;
@@ -245,7 +245,7 @@ mvebu_icu_irq_domain_alloc(struct irq_do
 	return 0;
 
 free_msi:
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -260,7 +260,7 @@ mvebu_icu_irq_domain_free(struct irq_dom
 
 	kfree(icu_irqd);
 
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mvebu_icu_domain_ops = {
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -432,10 +432,10 @@ struct irq_domain *
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs);
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec);
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs);
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
