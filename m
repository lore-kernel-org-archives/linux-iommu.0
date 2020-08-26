Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9AC433E8
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D6C20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQK+hWPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYT9vQkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D6C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C6E586AB1;
	Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNgjJppImBMr; Wed, 26 Aug 2020 12:01:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2AA8869F8;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF8BAC0891;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA4E3C07FF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CA4C786BBD
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3kli81cYfRC for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2AEB48633E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
Message-Id: <20200826112334.198633344@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=x1lilm1wSab7jCk+RVn7Y9w51r0P/DEEXiuOg6SwxNA=;
 b=xQK+hWPf8Qa3VBlzaS65MXD1rTSFvkAArmzsKQ683fYw7lGT3CJmc6zDW+r/7Jgj7ZV2nl
 4UevQBnTw5XpFbtakjWkpbHWqqet9HRqvMyaTaWT3cBq4RXUPJOhHdfh2EIk61yrHamuIN
 rwAWoeD72N9K27PQHP75BHj50xOq7Jn7kaeVNW4Cq6/dGK200KYcNr3AFIK7SNAH4HSk1j
 JxFtDFFu+1RikYKodYarFpSnJDprYU8G0NdM5nmBB3ic8gWfzlYKdubancrikcp+6yOWJe
 4Z8TVxOBgZtq/VWS2JJDmRCvaLbI3TPKTxzAHcjo1M3fn/h1MXV08dRp/uIHQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=x1lilm1wSab7jCk+RVn7Y9w51r0P/DEEXiuOg6SwxNA=;
 b=gYT9vQkYl8yJG877OT3E6JNjTxccLTMsmLl+imB25zhe9GgkmpQIzEmEzvfi2t8TSIfYQR
 EUDgFsP2OsmAzsCA==
Date: Wed, 26 Aug 2020 13:17:04 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 36/46] x86/irq: Make most MSI ops XEN private
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

Nothing except XEN uses the setup/teardown ops. Hide them there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/x86_init.h |    2 --
 arch/x86/pci/xen.c              |   21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -276,8 +276,6 @@ struct x86_platform_ops {
 struct pci_dev;
 
 struct x86_msi_ops {
-	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,6 +157,13 @@ static int acpi_register_gsi_xen(struct
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
+struct xen_msi_ops {
+	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_msi_irqs)(struct pci_dev *dev);
+};
+
+static struct xen_msi_ops xen_msi_ops __ro_after_init;
+
 static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
@@ -415,7 +422,7 @@ static int xen_msi_domain_alloc_irqs(str
 	else
 		type = PCI_CAP_ID_MSI;
 
-	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
 static void xen_msi_domain_free_irqs(struct irq_domain *domain,
@@ -424,7 +431,7 @@ static void xen_msi_domain_free_irqs(str
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+	xen_msi_ops.teardown_msi_irqs(to_pci_dev(dev));
 }
 
 static struct msi_domain_ops xen_pci_msi_domain_ops = {
@@ -463,16 +470,16 @@ static __init void xen_setup_pci_msi(voi
 {
 	if (xen_pv_domain()) {
 		if (xen_initial_domain()) {
-			x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+			xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 		} else {
-			x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
+			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
 		}
-		x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 		pci_msi_ignore_mask = 1;
 	} else if (xen_hvm_domain()) {
-		x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+		xen_msi_ops.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
 	} else {
 		WARN_ON_ONCE(1);
 		return;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
