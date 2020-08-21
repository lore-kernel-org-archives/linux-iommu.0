Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C6C433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AC42075E
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajI2pJdE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mU3SPMbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AC42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4B3B8868D;
	Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQs4CAQFJBUk; Fri, 21 Aug 2020 02:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 934ED886B7;
	Fri, 21 Aug 2020 02:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74FE7C0894;
	Fri, 21 Aug 2020 02:17:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24797C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1362F86CD4
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkdhmNcaPTEA for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E5E286CEF
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:12 +0000 (UTC)
Message-Id: <20200821002947.868727656@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TtSCch4Pl9idW7lZ/MfqjUP9Aer+OWMrbEhYjWyctzk=;
 b=ajI2pJdEYzOm/NA7mpsVnmmYpP8BChSbOklVsS1Clri/O+HTySypMyq7V9Aw/6oWO1KmUT
 DxKpuJLMRwQ0KE3iVhSMBKYHFDiHrvGC7RE6UmzR14YefId9dgx5pU0BBUz4EPNu9EKsub
 e1HrJdYrH+nKV762GYpTzhxjnjNa3+TTxl6Qh9dbQCrhltTygTZebPaudPK1tsCadByiUp
 OhqKB1ZySsgRfQWYfMY91XPjiowAtQJE4zIRTMtpE7//eE4b7p9H69mUH8dVKxAZ08m/1N
 95TY2NPmPXmzOiPUd0jhPkGPYbcghDXRR+H7jdLv/Ddyc481pN2Axj0dNhkMmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TtSCch4Pl9idW7lZ/MfqjUP9Aer+OWMrbEhYjWyctzk=;
 b=mU3SPMbQsB++v6eyvlflbVy+D6aYL3jGw0t+vLRnS/VfAKbRJOsLYlNIUdAfx3WAYLh4wO
 XJc9lvDYLRoiMOCw==
Date: Fri, 21 Aug 2020 02:24:50 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 26/38] x86/xen: Wrap XEN MSI management into irqdomain
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-xen--Wrap-XEN-MSI-management-into-irqdomain.patch"
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

To allow utilizing the irq domain pointer in struct device it is necessary
to make XEN/MSI irq domain compatible.

While the right solution would be to truly convert XEN to irq domains, this
is an exercise which is not possible for mere mortals with limited XENology.

Provide a plain irqdomain wrapper around XEN. While this is blatant
violation of the irqdomain design, it's the only solution for a XEN igorant
person to make progress on the issue which triggered this change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
Note: This is completely untested, but it compiles so it must be perfect.
---
 arch/x86/pci/xen.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -406,6 +406,63 @@ static void xen_teardown_msi_irq(unsigne
 	WARN_ON_ONCE(1);
 }
 
+static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
+				     struct device *dev,  int nvec)
+{
+	int type;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return -EINVAL;
+
+	if (first_msi_entry(dev)->msi_attrib.is_msix)
+		type = PCI_CAP_ID_MSIX;
+	else
+		type = PCI_CAP_ID_MSI;
+
+	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+}
+
+static void xen_msi_domain_free_irqs(struct irq_domain *domain,
+				     struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+static struct msi_domain_ops xen_pci_msi_domain_ops = {
+	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
+	.domain_free_irqs	= xen_msi_domain_free_irqs,
+};
+
+static struct msi_domain_info xen_pci_msi_domain_info = {
+	.ops			= &xen_pci_msi_domain_ops,
+};
+
+/*
+ * This irq domain is a blatant violation of the irq domain design, but
+ * distangling XEN into real irq domains is not a job for mere mortals with
+ * limited XENology. But it's the least dangerous way for a mere mortal to
+ * get rid of the arch_*_msi_irqs() hackery in order to store the irq
+ * domain pointer in struct device. This irq domain wrappery allows to do
+ * that without breaking XEN terminally.
+ */
+static __init struct irq_domain *xen_create_pci_msi_domain(void)
+{
+	struct irq_domain *d = NULL;
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
+	if (fn)
+		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
+
+	/* FIXME: No idea how to survive if this fails */
+	BUG_ON(!d);
+
+	return d;
+}
+
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_initial_domain()) {
@@ -426,6 +483,12 @@ static __init void xen_setup_pci_msi(voi
 	}
 
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+
+	/*
+	 * Override the PCI/MSI irq domain init function. No point
+	 * in allocating the native domain and never use it.
+	 */
+	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
 }
 
 #else /* CONFIG_PCI_MSI */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
