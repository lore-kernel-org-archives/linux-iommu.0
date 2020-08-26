Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10729C433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4D120838
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJn39pF+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hT/OBr4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4D120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C935888031;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iwa19LWneJKI; Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4EB7886EC8;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3719BC0891;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4904DC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 17AC4228BD
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vtiFveMGjIvo for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 73C072279B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Message-Id: <20200826112332.954409970@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=ua6NqpYSmZApI6uP+18lDgw4EnjAETLTuYc3KhfX2+w=;
 b=eJn39pF++R7y4RiJv9aME9HZXKzf7AMtx9gOIQ/KZhoM3Ld0hlH/DnKGJSmV3hVK7ueYqX
 g1TpG290lPqFhzmAKo6hqVmPwqEyrX7rt/PhmQiixSoeLrqPBxlBTb7V5nlKo9FeeO68w9
 P+nP/kWZ0Q3FfsrwOaftJfMc0rekm49YPAwe1NBLe4ss62eDgjZkUMH5SBARbrLVSeCsHW
 9wSFLRhkhyvmHyqMypfoAkbY6kL/Y1hZFdrfo2aarMJtV0+1qhqRZ+WGFKj/hsCV4En27V
 zyFSS2ZxL7C8PQ53C1/a/Tt9WRdp2fAapfBPmUw2+7K8K2Qi+jcv21W0IVT5RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=ua6NqpYSmZApI6uP+18lDgw4EnjAETLTuYc3KhfX2+w=;
 b=hT/OBr4eTGEXyMwMWWHmsjom0DAsmwGAPtkbOlxE5LrlE3lHi77XHAXMud4bbKn68MLXI3
 kEfd4yz3w6MRPuDQ==
Date: Wed, 26 Aug 2020 13:16:51 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 23/46] irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
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

PCI devices behind a VMD bus are not subject to interrupt remapping, but
the irq domain for VMD MSI cannot be distinguished from a regular PCI/MSI
irq domain.

Add a new domain bus token and allow it in the bus token check in
msi_check_reservation_mode() to keep the functionality the same once VMD
uses this token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/irqdomain.h |    1 +
 kernel/irq/msi.c          |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -370,8 +370,13 @@ static bool msi_check_reservation_mode(s
 {
 	struct msi_desc *desc;
 
-	if (domain->bus_token != DOMAIN_BUS_PCI_MSI)
+	switch(domain->bus_token) {
+	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_VMD_MSI:
+		break;
+	default:
 		return false;
+	}
 
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
