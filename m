Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C54AC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CD92087C
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DLCrWRXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/g1akpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CD92087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2253D228DC;
	Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NL007rTjsnLj; Wed, 26 Aug 2020 12:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D9DC21561;
	Wed, 26 Aug 2020 12:01:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59432C0891;
	Wed, 26 Aug 2020 12:01:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F05BCC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EC18D86DA3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XMTKA5Yre7G2 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1462A86D2D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:02 +0000 (UTC)
Message-Id: <20200826112331.047917603@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=aNA6imWCCycyDoE7I/LUogJu92HNj5sOKiAANrwrDhI=;
 b=DLCrWRXadgrQCf4qFjiJ+39EHne5FXGzCP9hiodZy6C8kQ1/WBZONwRpITcKeNKBrD1AWK
 rF/EG4OJ4JLSWL/HoTIqnPXKvoPYzGcme0j15L3eojvZ2bWAiS7Mtp6MC3bxVEb0cBOUC9
 yg4BEsBD55+FiJ8p6JF3228cFuTpo4myNllLNfJ6Fh7oNyAQy3Eqj0+p/pwh4qFx+ZTFbN
 X8rK+gsgw02K975GfmmssF7oLxWMt/bW4zGm2/v0gmC9AwwlH59Uhn5HEaoAcw83sZ1qnk
 6UwasHDKTy053t1sugGUnbd9oxc0qCPpErEWb9QDItLE7iM7JBH4ygOMbYregw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=aNA6imWCCycyDoE7I/LUogJu92HNj5sOKiAANrwrDhI=;
 b=d/g1akpo73oJHiKD3AFk+oXcaGgFtQKzORD6f4yN1CPu2he0HCayOxiJxkUBpk9OkfVzCq
 JLPec94nQktRTKBQ==
Date: Wed, 26 Aug 2020 13:16:32 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 04/46] genirq/chip: Use the first chip in
 irq_chip_compose_msi_msg()
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

The documentation of irq_chip_compose_msi_msg() claims that with
hierarchical irq domains the first chip in the hierarchy which has an
irq_compose_msi_msg() callback is chosen. But the code just keeps
iterating after it finds a chip with a compose callback.

The x86 HPET MSI implementation relies on that behaviour, but that does not
make it more correct.

The message should always be composed at the domain which manages the
underlying resource (e.g. APIC or remap table) because that domain knows
about the required layout of the message.

On X86 the following hierarchies exist:

1)   vector -------- PCI/MSI
2)   vector -- IR -- PCI/MSI

The vector domain has a different message format than the IR (remapping)
domain. So obviously the PCI/MSI domain can't compose the message without
having knowledge about the parent domain, which is exactly the opposite of
what hierarchical domains want to achieve.

X86 actually has two different PCI/MSI chips where #1 has a compose
callback and #2 does not. #2 delegates the composition to the remap domain
where it belongs, but #1 does it at the PCI/MSI level.

For the upcoming device MSI support it's necessary to change this and just
let the first domain which can compose the message take care of it. That
way the top level chip does not have to worry about it and the device MSI
code does not need special knowledge about topologies. It just sets the
compose callback to NULL and lets the hierarchy pick the first chip which
has one.

Due to that the attempt to move the compose callback from the direct
delivery PCI/MSI domain to the vector domain made the system fail to boot
with interrupt remapping enabled because in the remapping case
irq_chip_compose_msi_msg() keeps iterating and choses the compose callback
of the vector domain which obviously creates the wrong format for the remap
table.

Break out of the loop when the first irq chip with a compose callback is
found and fixup the HPET code temporarily. That workaround will be removed
once the direct delivery compose callback is moved to the place where it
belongs in the vector domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch. Note, that this might break other stuff which relies on the
    current behaviour, but the hierarchy composition of DT based chips is
    really hard to follow.
---
 arch/x86/kernel/apic/msi.c |    7 +++++--
 kernel/irq/chip.c          |   12 +++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -479,10 +479,13 @@ struct irq_domain *hpet_create_irq_domai
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL)
+	if (parent == NULL) {
 		parent = x86_vector_domain;
-	else
+	} else {
 		hpet_msi_controller.name = "IR-HPET-MSI";
+		/* Temporary fix: Will go away */
+		hpet_msi_controller.irq_compose_msi_msg = NULL;
+	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1544,10 +1544,16 @@ int irq_chip_compose_msi_msg(struct irq_
 	struct irq_data *pos = NULL;
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
-		if (data->chip && data->chip->irq_compose_msi_msg)
+	for (; data; data = data->parent_data) {
+		if (data->chip && data->chip->irq_compose_msi_msg) {
 			pos = data;
+			break;
+		}
+	}
+#else
+	if (data->chip && data->chip->irq_compose_msi_msg)
+		pos = data;
+#endif
 	if (!pos)
 		return -ENOSYS;
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
