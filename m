Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F7C4363D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05D82184D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0IVPH4+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05D82184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2E5486693;
	Mon,  5 Oct 2020 15:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SCXo8xcr8x8; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85B1186695;
	Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70253C0891;
	Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F3EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1735870C7
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HmTAcm3u6CyW for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9196F865A1
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=IVCSakrSwvBC/94Qs7X2IIppr71sOhGWu/QBQEBl22I=; b=0IVPH4+m+qk7v2uMU02/NMpO3B
 K3H1JlXjphg3LK3TPa7y6AUlxOKR6nYcU4HyGj4fmcXmdm+kTFsBdciKT1cGbUbyJb1kqnMxdT5zX
 s5sUqDR0KPloxduhUYQNUb0Auc9dnGxTWqCEAw6PPQJ0kot+pgsCiq/SJRVf1RcNh9HvWCq/iFENP
 DcI6CmVXe6hHtmwqedqqDXHbS7ikjt2+MvPIPOJ5pgN/WYfUosMPgm23Tevn3ThXWzlWJSdZOlPGe
 E86/1CDCZV8fwbx8UXF+ljYZZY6UCj+M00856oZjrfg/Af9ZTAz0doyKy7vdZkkPr+dw8D+JyxgXE
 r5wgcdiw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPSQ5-0004MK-Dn; Mon, 05 Oct 2020 15:28:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kPSQ4-0045Qk-D3; Mon, 05 Oct 2020 16:28:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 08/13] genirq: Add irq_domain_set_affinity()
Date: Mon,  5 Oct 2020 16:28:51 +0100
Message-Id: <20201005152856.974112-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005152856.974112-1-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

This allows a maximal affinity to be set, for IRQ domains which cannot
target all CPUs in the system.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/irqdomain.h |  4 ++++
 kernel/irq/irqdomain.c    | 28 ++++++++++++++++++++++++++--
 kernel/irq/manage.c       | 19 +++++++++++++++----
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 6b5576da77f0..cf686f18c1fa 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,6 +151,7 @@ struct irq_domain_chip_generic;
  *      drivers using the generic chip library which uses this pointer.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  * @debugfs_file: dentry for the domain debugfs file
+ * @max_affinity: mask of CPUs targetable by this IRQ domain
  *
  * Revmap data, used internally by irq_domain
  * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
@@ -177,6 +178,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	struct dentry		*debugfs_file;
 #endif
+	const struct cpumask *max_affinity;
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
@@ -453,6 +455,8 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
+extern int irq_domain_set_affinity(struct irq_domain *domain,
+				   const struct cpumask *affinity);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ffd41f21afca..0b298355be1b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -661,7 +661,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 
 	/* Allocate a virtual interrupt number */
 	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
-				      NULL, NULL);
+				      NULL, domain->max_affinity);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -1078,6 +1078,27 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data)
 }
 EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
 
+/**
+ * irq_domain_set_affinity - Set maximum CPU affinity for domain
+ * @parent:	Domain to set affinity for
+ * @affinity:	Pointer to cpumask, consumed by domain
+ *
+ * Sets the maximal set of CPUs to which interrupts in this domain may
+ * be delivered. Must only be called after creation, before any interrupts
+ * have been in the domain.
+ *
+ * This function retains a pointer to the cpumask which is passed in.
+ */
+int irq_domain_set_affinity(struct irq_domain *domain,
+			    const struct cpumask *affinity)
+{
+	if (cpumask_empty(affinity))
+		return -EINVAL;
+	domain->max_affinity = affinity;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_domain_set_affinity);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1110,6 +1131,9 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 	if (domain) {
 		domain->parent = parent;
 		domain->flags |= flags;
+		if (parent && parent->max_affinity)
+			irq_domain_set_affinity(domain,
+						parent->max_affinity);
 	}
 
 	return domain;
@@ -1375,7 +1399,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 		virq = irq_base;
 	} else {
 		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
-					      affinity, NULL);
+					      affinity, domain->max_affinity);
 		if (virq < 0) {
 			pr_debug("cannot allocate IRQ(base %d, count %d)\n",
 				 irq_base, nr_irqs);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5df903fccb60..e8c5f8ecd306 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -345,6 +345,10 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	struct irq_desc *desc = irq_data_to_desc(data);
 	int ret = 0;
 
+	if (data->domain && data->domain->max_affinity &&
+	    !cpumask_subset(mask, data->domain->max_affinity))
+		return -EINVAL;
+
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
@@ -484,13 +488,20 @@ int irq_setup_affinity(struct irq_desc *desc)
 	struct cpumask *set = irq_default_affinity;
 	int ret, node = irq_desc_get_node(desc);
 	static DEFINE_RAW_SPINLOCK(mask_lock);
-	static struct cpumask mask;
+	static struct cpumask mask, max_mask;
 
 	/* Excludes PER_CPU and NO_BALANCE interrupts */
 	if (!__irq_can_set_affinity(desc))
 		return 0;
 
 	raw_spin_lock(&mask_lock);
+
+	if (desc->irq_data.domain && desc->irq_data.domain->max_affinity)
+		cpumask_and(&max_mask, cpu_online_mask,
+			    desc->irq_data.domain->max_affinity);
+	else
+		cpumask_copy(&max_mask, cpu_online_mask);
+
 	/*
 	 * Preserve the managed affinity setting and a userspace affinity
 	 * setup, but make sure that one of the targets is online.
@@ -498,15 +509,15 @@ int irq_setup_affinity(struct irq_desc *desc)
 	if (irqd_affinity_is_managed(&desc->irq_data) ||
 	    irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
 		if (cpumask_intersects(desc->irq_common_data.affinity,
-				       cpu_online_mask))
+				       &max_mask))
 			set = desc->irq_common_data.affinity;
 		else
 			irqd_clear(&desc->irq_data, IRQD_AFFINITY_SET);
 	}
 
-	cpumask_and(&mask, cpu_online_mask, set);
+	cpumask_and(&mask, &max_mask, set);
 	if (cpumask_empty(&mask))
-		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_copy(&mask, &max_mask);
 
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
