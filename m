Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15EC433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B3E20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGq7w5Vv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIUepu9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B3E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2C1984E8C;
	Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOzt2noRzT5q; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F09C884FB0;
	Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD8BAC016F;
	Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A6ECC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EC9898762E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yl8GVE9IpuQi for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 338FC875DA
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
Message-Id: <20200826112335.092521442@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=b69SWJ3Ur45XxM77SmSu/tsjVczGdpPRTUPeP/VD4Ik=;
 b=sGq7w5VvBLEz68W/6n3xv/ju+gIZDsclrMN42Kbt+Lek2xpknqP50K1/N3zLQ3qy/tSs8i
 5FUrDzJiUCLsdEJZ4ovTq/PJQFLtIf/MfxmxW+nu6cwW9IfZO+2nncmzTnjpEbrV3MH6tj
 9b3brF3GgBQbP9y2bmXgCU8M4zoc2GmpJnNPYPngl4Q3CAXCKlffOoU2TbmM1e7rBtgxG5
 I955rjrk1V8U3FHUiSZO6UvjD62oqONm2qhsAdvpgboUJlslC/n2D3AmOJoiDXEw8WOFvk
 k66LV22FAJnV0xR9tR25lKLopG2+yp6AUrfyM0um/WMR7J6qyoLFz+U0tt9W2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=b69SWJ3Ur45XxM77SmSu/tsjVczGdpPRTUPeP/VD4Ik=;
 b=wIUepu9R9BwJrfL5hHLBQrW187phV08auxKlkm3THVUKZ6T3NRDo7Cxcy1mizpDRZnSQiD
 b3u1CTDbJZZ/EOBg==
Date: Wed, 26 Aug 2020 13:17:13 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 45/46] irqdomain/msi: Provide msi_alloc/free_store()
 callbacks
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
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
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
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

From: Thomas Gleixner <tglx@linutronix.de>

For devices which don't have a standard storage for MSI messages like the
upcoming IMS (Interrupt Message Storm) it's required to allocate storage
space before allocating interrupts and after freeing them.

This could be achieved with the existing callbacks, but that would be
awkward because they operate on msi_alloc_info_t which is not uniform
accross architectures. Also these callbacks are invoked per interrupt but
the allocation might have bulk requirements depending on the device.

As such devices can operate on different architectures it is simpler to
have seperate callbacks which operate on struct device. The resulting
storage information has to be stored in struct msi_desc so the underlying
irq chip implementation can retrieve it for the relevant operations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/msi.h |    8 ++++++++
 kernel/irq/msi.c    |   11 +++++++++++
 2 files changed, 19 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -279,6 +279,10 @@ struct msi_domain_info;
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
+ * @msi_alloc_store:	Optional callback to allocate storage in a device
+ *			specific non-standard MSI store
+ * @msi_alloc_free:	Optional callback to free storage in a device
+ *			specific non-standard MSI store
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by
  * msi_create_irq_domain() and related interfaces
@@ -328,6 +332,10 @@ struct msi_domain_ops {
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
+	int		(*msi_alloc_store)(struct irq_domain *domain,
+					   struct device *dev, int nvec);
+	void		(*msi_free_store)(struct irq_domain *domain,
+					    struct device *dev);
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -434,6 +434,12 @@ int __msi_domain_alloc_irqs(struct irq_d
 	if (ret)
 		return ret;
 
+	if (ops->msi_alloc_store) {
+		ret = ops->msi_alloc_store(domain, dev, nvec);
+		if (ret)
+			return ret;
+	}
+
 	for_each_msi_entry(desc, dev) {
 		ops->set_desc(&arg, desc);
 
@@ -533,6 +539,8 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
 
 	for_each_msi_entry(desc, dev) {
@@ -546,6 +554,9 @@ void __msi_domain_free_irqs(struct irq_d
 			desc->irq = 0;
 		}
 	}
+
+	if (ops->msi_free_store)
+		ops->msi_free_store(domain, dev);
 }
 
 /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
