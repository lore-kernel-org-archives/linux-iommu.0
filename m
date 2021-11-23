Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98852C433EF
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 501BD403BD;
	Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkjDXQWEAet9; Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F2FE40395;
	Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD0DC001E;
	Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36624C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25E27403B9
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3A62zPlERks8 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 16:11:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 712DC40395
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637683859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKa8ZUFo4xy2ejTxRVJ7dQpSqytToaSdfIyOgQL0cDw=;
 b=MPsAUeJZvIivmbuoqhBEXDBJfI0hqEPtx4FYohPjU18ug+9fIgNpHw6aLLk7iZEq5EFb4o
 3img3HJ3Mudai3dpenrXOg8JbsCp2zmKTQnIUPoGkvcPjquu2Bwd/OQwEyV0UXX5Y2synW
 GSNFtwfJynm7+Ft7e+etsaQfcVrEUxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-2AxzFmK1MsusrrIldq5tzQ-1; Tue, 23 Nov 2021 11:10:54 -0500
X-MC-Unique: 2AxzFmK1MsusrrIldq5tzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C4E8799EB;
 Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 500D760843;
 Tue, 23 Nov 2021 16:10:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/amd: x2apic mode: setup the INTX registers on
 mask/unmask
Date: Tue, 23 Nov 2021 18:10:36 +0200
Message-Id: <20211123161038.48009-4-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 "open list:AMD IOMMU AMD-VI" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
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

This is more logically correct and will also allow us to
to use mask/unmask logic to restore INTX setttings after
the resume from s3/s4.

Fixes: 66929812955bb ("iommu/amd: Add support for X2APIC IOMMU interrupts")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 65 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b905604f434e1..9e895bb8086a6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2015,48 +2015,18 @@ union intcapxt {
 	};
 } __attribute__ ((packed));
 
-/*
- * There isn't really any need to mask/unmask at the irqchip level because
- * the 64-bit INTCAPXT registers can be updated atomically without tearing
- * when the affinity is being updated.
- */
-static void intcapxt_unmask_irq(struct irq_data *data)
-{
-}
-
-static void intcapxt_mask_irq(struct irq_data *data)
-{
-}
 
 static struct irq_chip intcapxt_controller;
 
 static int intcapxt_irqdomain_activate(struct irq_domain *domain,
 				       struct irq_data *irqd, bool reserve)
 {
-	struct amd_iommu *iommu = irqd->chip_data;
-	struct irq_cfg *cfg = irqd_cfg(irqd);
-	union intcapxt xt;
-
-	xt.capxt = 0ULL;
-	xt.dest_mode_logical = apic->dest_mode_logical;
-	xt.vector = cfg->vector;
-	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
-	xt.destid_24_31 = cfg->dest_apicid >> 24;
-
-	/**
-	 * Current IOMMU implemtation uses the same IRQ for all
-	 * 3 IOMMU interrupts.
-	 */
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
 	return 0;
 }
 
 static void intcapxt_irqdomain_deactivate(struct irq_domain *domain,
 					  struct irq_data *irqd)
 {
-	intcapxt_mask_irq(irqd);
 }
 
 
@@ -2090,6 +2060,38 @@ static void intcapxt_irqdomain_free(struct irq_domain *domain, unsigned int virq
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+
+static void intcapxt_unmask_irq(struct irq_data *irqd)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+	struct irq_cfg *cfg = irqd_cfg(irqd);
+	union intcapxt xt;
+
+	xt.capxt = 0ULL;
+	xt.dest_mode_logical = apic->dest_mode_logical;
+	xt.vector = cfg->vector;
+	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
+	xt.destid_24_31 = cfg->dest_apicid >> 24;
+
+	/**
+	 * Current IOMMU implementation uses the same IRQ for all
+	 * 3 IOMMU interrupts.
+	 */
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+}
+
+static void intcapxt_mask_irq(struct irq_data *irqd)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+}
+
+
 static int intcapxt_set_affinity(struct irq_data *irqd,
 				 const struct cpumask *mask, bool force)
 {
@@ -2099,8 +2101,7 @@ static int intcapxt_set_affinity(struct irq_data *irqd,
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
-
-	return intcapxt_irqdomain_activate(irqd->domain, irqd, false);
+	return 0;
 }
 
 static struct irq_chip intcapxt_controller = {
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
