Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B601C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C14D22B3F
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZkMF/YW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+I8epgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C14D22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 497522288F;
	Wed, 26 Aug 2020 12:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vcdg5BNh9Spj; Wed, 26 Aug 2020 12:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC15120416;
	Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F6BBC07FF;
	Wed, 26 Aug 2020 12:01:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27132C07FF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05D2A85EE8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgYdk6eZ7cYX for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DCEF86DA3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:09 +0000 (UTC)
Message-Id: <20200826112331.634777249@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=uwvQNHvaNg/Fdy2Gl3KxXB78ZUpQmA3m1yJB61BHx4U=;
 b=cZkMF/YWULZ4Uotab3k3IXi4r4hFFnpiFtt6iNZpjY2glC7/xkFk3cB9PgaOU/8JGRxOjj
 S7I9iF8wESVzg+xDMZUKVy8Vbe6zq6LwxfCfOp+LsiBpSu672pJYhA6gZdh8IxY2xC6rKX
 3u6zI+8BnB3zMleeiIPXmH/Awu4yF5kC4ReV65SghuOIimGB2BYzAAK9x10MHqSwRaGKkj
 LB3rdDrHqSkWruYzPDa2OvgoiLXf78uxrzp0kxWXqNqww4EKoeJth428QKttN0aAkXjd92
 XLLJA91DUCN7cD4uJ1Gh1vWIc9GqgAIi7jZWF3Ewak/+mo/C3yFdrghRZhkL4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=uwvQNHvaNg/Fdy2Gl3KxXB78ZUpQmA3m1yJB61BHx4U=;
 b=c+I8epgL/HK82KFtaXiIHgczMaYB4MS5Q6XB/264Q9Abn3goTn6OI8aEnTusT/a/dZRKM7
 fW0BwXcA8NuxczDQ==
Date: Wed, 26 Aug 2020 13:16:38 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 10/46] iommu/amd: Consolidate irq domain getter
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

The irq domain request mode is now indicated in irq_alloc_info::type.

Consolidate the two getter functions into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/iommu/amd/iommu.c |   65 ++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3505,77 +3505,54 @@ static void irte_ga_clear_allocated(stru
 
 static int get_devid(struct irq_alloc_info *info)
 {
-	int devid = -1;
-
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		devid     = get_ioapic_devid(info->ioapic_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-		devid     = get_hpet_devid(info->hpet_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return get_hpet_devid(info->hpet_id);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		break;
+		return get_device_id(&info->msi_dev->dev);
 	default:
-		BUG_ON(1);
-		break;
+		WARN_ON_ONCE(1);
+		return -1;
 	}
-
-	return devid;
 }
 
-static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
+						   int devid)
 {
-	struct amd_iommu *iommu;
-	int devid;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	if (!info)
+	if (!iommu)
 		return NULL;
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		break;
+		return iommu->ir_domain;
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		return iommu->msi_domain;
 	default:
+		WARN_ON_ONCE(1);
 		return NULL;
 	}
-
-	devid = get_devid(info);
-	if (devid >= 0) {
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->ir_domain;
-	}
-
-	return NULL;
 }
 
 static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 {
-	struct amd_iommu *iommu;
 	int devid;
 
 	if (!info)
 		return NULL;
 
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		if (devid < 0)
-			return NULL;
-
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->msi_domain;
-		break;
-	default:
-		break;
-	}
-
-	return NULL;
+	devid = get_devid(info);
+	if (devid < 0)
+		return NULL;
+	return get_irq_domain_for_devid(info, devid);
 }
 
 struct irq_remap_ops amd_iommu_irq_ops = {
@@ -3584,7 +3561,7 @@ struct irq_remap_ops amd_iommu_irq_ops =
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_ir_irq_domain,
+	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
