Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9145C43467
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EF8221EB
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2G+tq/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EF8221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C71087AEF;
	Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vpm0OBVsk0C; Tue, 13 Oct 2020 08:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49A8E87AD9;
	Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0AEC1AD6;
	Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 095AFC0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E8A262E0ED
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OLQ0y6H6y0JV for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:12:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 928B62E0E9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=68BAPD1PqgE+zWChu0rPe1NytmXmMNFtrjhEwr73rSg=; b=Z2G+tq/JpEjQSc/077xTiv4w/S
 UU/5T+1pqxMI2TQq45OzDjeuj1ch5n9OlSLRKz2EwlNVxQDAJYgYolehpB44oCgU0BItuiiw8AtUb
 /e00n70kcZPYiCNV6J1hyeBkt3LAWCiqQjQ211lwBA3jLxs/HxwaoSG3GhIVDI+cZ+Mv0xjxB38+H
 KJjzS/qXyHevSCC1iFZwBr/rUgTjwUhtufKfhlMwigh4vdTJ9bY7h2qEyguLjpDp3QaImro6zBNGL
 qa+KsRnim7zetTSd+AYzOxrIKh/g1JRFfQaAJn+frZ216WZv+2Mgteb9HDU4CRU53S0cdVUsgHxtB
 h19DsAXg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSFPM-0006fR-TN; Tue, 13 Oct 2020 08:12:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kSFPM-006XXl-Fj; Tue, 13 Oct 2020 09:11:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 6/9] x86/hpet: Use irq_find_matching_fwspec() to find
 remapping irqdomain
Date: Tue, 13 Oct 2020 09:11:36 +0100
Message-Id: <20201013081139.1558200-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013081139.1558200-1-dwmw2@infradead.org>
References: <0de733f6384874d68afba2606119d0d9b1e8b34e.camel@infradead.org>
 <20201013081139.1558200-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 maz@misterjones.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/hpet.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3b8b12769f3b..fb7736ca7b5b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -543,8 +543,8 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 {
 	struct msi_domain_info *domain_info;
 	struct irq_domain *parent, *d;
-	struct irq_alloc_info info;
 	struct fwnode_handle *fn;
+	struct irq_fwspec fwspec;
 
 	if (x86_vector_domain == NULL)
 		return NULL;
@@ -556,15 +556,6 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	*domain_info = hpet_msi_domain_info;
 	domain_info->data = (void *)(long)hpet_id;
 
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.devid = hpet_id;
-	parent = irq_remapping_get_irq_domain(&info);
-	if (parent == NULL)
-		parent = x86_vector_domain;
-	else
-		hpet_msi_controller.name = "IR-HPET-MSI";
-
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
 	if (!fn) {
@@ -572,6 +563,18 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 		return NULL;
 	}
 
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hpet_id;
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+		return NULL;
+	}
+	if (parent != x86_vector_domain)
+		hpet_msi_controller.name = "IR-HPET-MSI";
+
 	d = msi_create_irq_domain(fn, domain_info, parent);
 	if (!d) {
 		irq_domain_free_fwnode(fn);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
