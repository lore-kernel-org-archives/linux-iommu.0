Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8DC4727D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461F2085B
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lCd0Xzlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B8FD8669F;
	Mon,  5 Oct 2020 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q7pAVZLPgR0I; Mon,  5 Oct 2020 15:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5767866B6;
	Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90C4DC0895;
	Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3348FC07FF
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1CD0520486
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2+-sVcc17M9 for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id AF30D203DB
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Wl3IkjJBUUxi3oxlkfGR/3vrMCl8kgivTGhAoZmqxgU=; b=lCd0XzlrYSd6b5lfYfJg99NYqp
 MDbQn98GnIajhGC1tuNDSTCUFl6Fmw5s/cIm/C1fpnQoGrD5hYxygBT0nYkqMcmsHxJx4bU/yt5Ov
 jwdSlL+WnndLsylOxJqEcENBz+2nSFUHjNMkBpnZPHv4qVmYE3EH4fHCh5p+/AlHJVGVuxf/p0PF7
 15OuOcNqunrSP4p41XExqUTJfPv6YbN3MNZ/iYsoDRMk+2LO2/gLfeGu6fC4x5bQfYurxgiv77kpI
 1m51xXY3N95F/EgoUvKO0Cquddr7cq0bRV/+N2+WFjqnVYJadu3SyMxdTmOu+P/Qcnwr0geb168OB
 CMedJzQw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPSQ5-0004MJ-Cc; Mon, 05 Oct 2020 15:28:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kPSQ4-0045Qa-BS; Mon, 05 Oct 2020 16:28:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 06/13] genirq: Add default_affinity argument to
 __irq_alloc_descs()
Date: Mon,  5 Oct 2020 16:28:49 +0100
Message-Id: <20201005152856.974112-6-dwmw2@infradead.org>
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

It already takes an array of affinities for each individual irq being
allocated but that's awkward to allocate and populate in the case
where they're all the same and inherited from the irqdomain, so pass
the default in separately as a simple cpumask.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/irq.h    | 10 ++++++----
 kernel/irq/devres.c    |  8 ++++++--
 kernel/irq/irqdesc.c   | 10 ++++++++--
 kernel/irq/irqdomain.c |  6 +++---
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4dfee35b..6e119594d35d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -897,15 +897,17 @@ unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		      struct module *owner,
-		      const struct irq_affinity_desc *affinity);
+		      const struct irq_affinity_desc *affinity,
+		      const struct cpumask *default_affinity);
 
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct irq_affinity_desc *affinity);
+			   const struct irq_affinity_desc *affinity,
+			   const struct cpumask *default_affinity);
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
-	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL)
+	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL, NULL)
 
 #define irq_alloc_desc(node)			\
 	irq_alloc_descs(-1, 0, 1, node)
@@ -920,7 +922,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 	irq_alloc_descs(-1, from, cnt, node)
 
 #define devm_irq_alloc_descs(dev, irq, from, cnt, node)		\
-	__devm_irq_alloc_descs(dev, irq, from, cnt, node, THIS_MODULE, NULL)
+	__devm_irq_alloc_descs(dev, irq, from, cnt, node, THIS_MODULE, NULL, NULL)
 
 #define devm_irq_alloc_desc(dev, node)				\
 	devm_irq_alloc_descs(dev, -1, 0, 1, node)
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..079339decc23 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -170,6 +170,8 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  * @affinity:	Optional pointer to an irq_affinity_desc array of size @cnt
  *		which hints where the irq descriptors should be allocated
  *		and which default affinities to use
+ * @default_affinity: Optional pointer to a cpumask indicating the default
+ *              affinity to use where not specified by the @affinity array
  *
  * Returns the first irq number or error code.
  *
@@ -177,7 +179,8 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  */
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct irq_affinity_desc *affinity)
+			   const struct irq_affinity_desc *affinity,
+			   const struct cpumask *default_affinity)
 {
 	struct irq_desc_devres *dr;
 	int base;
@@ -186,7 +189,8 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 	if (!dr)
 		return -ENOMEM;
 
-	base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity);
+	base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity,
+				 default_affinity);
 	if (base < 0) {
 		devres_free(dr);
 		return base;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4ac91b9fc618..fcc3b8a1fe01 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -770,15 +770,21 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  * @affinity:	Optional pointer to an affinity mask array of size @cnt which
  *		hints where the irq descriptors should be allocated and which
  *		default affinities to use
+ * @default_affinity: Optional pointer to a cpumask indicating the default
+ *              affinity where not specified in the @affinity array
  *
  * Returns the first irq number or error code
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct irq_affinity_desc *affinity)
+		  struct module *owner, const struct irq_affinity_desc *affinity,
+		  const struct cpumask *default_affinity)
 {
 	int start, ret;
 
+	if (!default_affinity)
+		default_affinity = irq_default_affinity;
+
 	if (!cnt)
 		return -EINVAL;
 
@@ -808,7 +814,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		if (ret)
 			goto unlock;
 	}
-	ret = alloc_descs(start, cnt, node, affinity, irq_default_affinity, owner);
+	ret = alloc_descs(start, cnt, node, affinity, default_affinity, owner);
 unlock:
 	mutex_unlock(&sparse_irq_lock);
 	return ret;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 76cd7ebd1178..c93e00ca11d8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1017,16 +1017,16 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 
 	if (virq >= 0) {
 		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
-					 affinity);
+					 affinity, NULL);
 	} else {
 		hint = hwirq % nr_irqs;
 		if (hint == 0)
 			hint++;
 		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
-					 affinity);
+					 affinity, NULL);
 		if (virq <= 0 && hint > 1) {
 			virq = __irq_alloc_descs(-1, 1, cnt, node, THIS_MODULE,
-						 affinity);
+						 affinity, NULL);
 		}
 	}
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
