Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30543C433E7
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE3C207C3
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dyOWTYue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE3C207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B87EF87B45;
	Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id glx-5QCCFMET; Tue, 13 Oct 2020 08:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76F6887AFA;
	Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56DA7C1AD9;
	Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA06FC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B028987AF7
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GsatvZ3yv2SG for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:12:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C9B1687AF2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Ao5ZKp3oCdpN8qk6orFgwO2u0x0OBKGfU399MvCiyiA=; b=dyOWTYueL1K1JnsATOkEHVyI94
 HV0SINa0/AFJC/PW9ldMxFymzDnCHudZuKi2Q3iiVUaEdZaeSSSFavOBeVMsocCarlzVt2D5Ff6Lc
 dmoEGg61oILBMxG54c6oI9IFmTpsr9C5wsUgLe6bnrLJOEi/5MjX1fsSFeY4EQ+R7znumdUYbF/XE
 Asf59OEXIxOhB+lWE277d2VZy3xZc+1LZVcgfSDEvwvdbk/6VYaVsN8dXF8pJk9ZleEew/UpCyC+w
 LeaIgGj1TIkFiMzGQnrLInwdTVH9Ncz6/JcSGQmFTNbTSQxyv1ssE0NMdDpMzvzqAtKSvRWMRk2cf
 AWlmiqKQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSFPM-0006fS-Ur; Tue, 13 Oct 2020 08:12:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kSFPM-006XXq-GP; Tue, 13 Oct 2020 09:11:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 7/9] x86/ioapic: Use irq_find_matching_fwspec() to find
 remapping irqdomain
Date: Tue, 13 Oct 2020 09:11:37 +0100
Message-Id: <20201013081139.1558200-8-dwmw2@infradead.org>
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
 arch/x86/kernel/apic/io_apic.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ca2da19d5c55..73cacc92c3bb 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2305,36 +2305,36 @@ static inline void __init check_timer(void)
 
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_alloc_info info;
 	struct irq_domain *parent;
 	int hwirqs = mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip = &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg = &ip->irqdomain_cfg;
 	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
 	struct fwnode_handle *fn;
-	char *name = "IO-APIC";
+	struct irq_fwspec fwspec;
 
 	if (cfg->type == IOAPIC_DOMAIN_INVALID)
 		return 0;
 
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
-	info.devid = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_irq_domain(&info);
-	if (!parent)
-		parent = x86_vector_domain;
-	else
-		name = "IO-APIC-IR";
-
 	/* Handle device tree enumerated APICs proper */
 	if (cfg->dev) {
 		fn = of_node_to_fwnode(cfg->dev);
 	} else {
-		fn = irq_domain_alloc_named_id_fwnode(name, ioapic);
+		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", ioapic);
 		if (!fn)
 			return -ENOMEM;
 	}
 
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = ioapic;
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
+		return -ENODEV;
+	}
+
 	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
 						 (void *)(long)ioapic);
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
