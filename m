Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA9C433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ACD2086A
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiLeH5k1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXln3vkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ACD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6812386CE4;
	Fri, 21 Aug 2020 02:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJ1gGdkCGaFH; Fri, 21 Aug 2020 02:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C16B186CF6;
	Fri, 21 Aug 2020 02:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC0B8C0894;
	Fri, 21 Aug 2020 02:17:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8C0BC0889
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AB45522E6E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMBEnMQ65onk for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id F412523018
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:55 +0000 (UTC)
Message-Id: <20200821002946.594509001@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=F0DCbonLQEL0D8Df9OCMfcJxjv/hy8xJtmzGkTlqTvs=;
 b=FiLeH5k11k/JQk52LH07+Ha7hk2n6XQvR9iMpdcvrX0tGljFYc9Qi7o0vZeoI2pUpr7GAQ
 gWARnz+Dyy0o3UBEGQr7w05ek4rV/jDbOjy9VUToJ3LYHQk6KxCN+kV2Z5XvNluJsq3ZQJ
 Ux4MZW6mDOuO0i5C+v696sSuJt9PUm1WyLWZFnLnChKRx7Ml9Gc11Q+UPrRLV1BSljsAu8
 MFMNC756vte58E3bXdW0eBuOu1wEsLayoglkGDRvYc1qTKxi3JMTcMQaUH4uAHrFmwyU76
 cwolBKYJBVyvOzB7TinHMZvwR2GuMsDX8+KplK43DzRvVoVZFiWeBehrxcNVLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=F0DCbonLQEL0D8Df9OCMfcJxjv/hy8xJtmzGkTlqTvs=;
 b=vXln3vkM6Fevc/JOETlWU1DSFXrQ25Mc+B9Hb6i6fwkV0etAyK5QBWjFXhdiu4LrVkOWQu
 2f7XTKsxazS0bBCA==
Date: Fri, 21 Aug 2020 02:24:37 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="PCI--MSI--Rework-pci_msi_domain_calc_hwirq--.patch"
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

Retrieve the PCI device from the msi descriptor instead of doing so at the
call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/kernel/apic/msi.c |    2 +-
 drivers/pci/msi.c          |   13 ++++++-------
 include/linux/msi.h        |    3 +--
 3 files changed, 8 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
-	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
+	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1346,17 +1346,17 @@ void pci_msi_domain_write_msg(struct irq
 
 /**
  * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @dev:	Pointer to the PCI device
  * @desc:	Pointer to the MSI descriptor
  *
  * The ID number is only used within the irqdomain.
  */
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc)
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
+	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
+
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		pci_dev_id(pdev) << 11 |
+		(pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
@@ -1406,8 +1406,7 @@ static void pci_msi_domain_set_desc(msi_
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
-					       desc);
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 #else
 #define pci_msi_domain_set_desc		NULL
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -369,8 +369,7 @@ void pci_msi_domain_write_msg(struct irq
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc);
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
