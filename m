Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55590C433EA
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283D72087D
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/9S15/F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DFd6NyEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283D72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B8C587F8E;
	Wed, 26 Aug 2020 12:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plSa63+7oX9c; Wed, 26 Aug 2020 12:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4B1B87A72;
	Wed, 26 Aug 2020 12:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0AD0C08A5;
	Wed, 26 Aug 2020 12:01:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6A9DC088B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8484986DA3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oaZXoCTuK7al for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6D97486EC8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:15 +0000 (UTC)
Message-Id: <20200826112332.163462706@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=mqnIcRU+8mJ14Mkki/W6mS6K78Mp2NlN7l+CkgxD+8o=;
 b=Y/9S15/F+/l+sIoxpjKT+lKY2eH9kcch+ZUeDE0/p5MBKA41C4FbGZzCr2P40FwJs+b8kH
 aP3m68Yo7e9VGLYMb7lowUb7k4nT04PUU39uphOc/8R8Aroe90mmvDy6wgiMmRn7bASjLj
 kNwm9CILE9qJXAfoDjG9Q2H9mS8mfofKpj+omGNLDF/Ti6AOkRqT/z2/s8EQRcdADxh1h4
 mNzYep3t8S6A1xmp8v0RaTVEMGCHbEw/AALmCjZ94qb8nGr7UmRmi4pUhhIECgm8RNKE7a
 zkbZRkbuTyEq14qthAKtwgAl8JKfXNRycTxUwM1LW8QwiL7iP4/GzuGSd0ywOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=mqnIcRU+8mJ14Mkki/W6mS6K78Mp2NlN7l+CkgxD+8o=;
 b=DFd6NyEpm6qkQ9xT3f5z9cx+wU0ADabSVM33TuNvaWV/8ZV1/ExDQnOGUkzJskUPW+kXTJ
 lBCvwjVIBiOvpBBQ==
Date: Wed, 26 Aug 2020 13:16:43 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
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

None of the DMAR specific fields are required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/hw_irq.h |    6 ------
 arch/x86/kernel/apic/msi.c    |   10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -83,12 +83,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_DMAR_TABLE
-		struct {
-			int		dmar_id;
-			void		*dmar_data;
-		};
-#endif
 #ifdef	CONFIG_X86_UV
 		struct {
 			int		uv_limit;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
 static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->dmar_id;
+	return arg->hwirq;
 }
 
 static int dmar_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_domain_set_info(domain, virq, arg->dmar_id, info->chip, NULL,
-			    handle_edge_irq, arg->dmar_data, "edge");
+	irq_domain_set_info(domain, virq, arg->devid, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -384,8 +384,8 @@ int dmar_alloc_hwirq(int id, int node, v
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
-	info.dmar_id = id;
-	info.dmar_data = arg;
+	info.devid = id;
+	info.data = arg;
 
 	return irq_domain_alloc_irqs(domain, 1, node, &info);
 }


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
