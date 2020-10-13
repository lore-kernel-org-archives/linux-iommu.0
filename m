Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52719C433E7
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:11:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE6F21D6C
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oSwC0KbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE6F21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A89C887449;
	Tue, 13 Oct 2020 08:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRTsWMYHsK3i; Tue, 13 Oct 2020 08:11:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 213A48744E;
	Tue, 13 Oct 2020 08:11:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EE11C1AD7;
	Tue, 13 Oct 2020 08:11:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C814AC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B782584FB2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00gf1fZUkKOQ for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:11:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A25F58729E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tEXSxiZgiyhsPeGxpXN53zeSdpwjvDGCNA3IHBXORac=; b=oSwC0KbPAFSpC/WqgJP3XjFYGN
 NKckUFk2AQSKgJBBzcrp9P1GYZ3pSV0nmP4pB98Wgjo1JvgjUnq6xnn7YZV5W0/5di0w/+OdHht2+
 JTUx/UhUgRLiErsYEq3+zF2w6SwzDbRpW2JL5ek8P0D9JIuz2syNfv9o0gd4Zq7CLhuLpacg6GoAu
 z85UTdCLVWAA31bfa677lFTtjseIAhPTAQnBuiRBsbrvC83XmTDfp4/qjexVM96GM0fuIvcpTBQFy
 5ycGi5hFw8QbkqmddWmBr22ZewFqesFKD3CEIGNb6OxxsqiCIQpKBSzPZCuM49AnxDsGUTAKSlY+/
 zOJkwNYw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSFPN-0005sW-Di; Tue, 13 Oct 2020 08:11:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kSFPM-006XXQ-Cx; Tue, 13 Oct 2020 09:11:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 2/9] x86/apic: Add select() method on vector irqdomain
Date: Tue, 13 Oct 2020 09:11:32 +0100
Message-Id: <20201013081139.1558200-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013081139.1558200-1-dwmw2@infradead.org>
References: <0de733f6384874d68afba2606119d0d9b1e8b34e.camel@infradead.org>
 <20201013081139.1558200-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
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

This will be used to select the irqdomain for I/OAPIC and HPET.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/irqdomain.h |  3 +++
 arch/x86/kernel/apic/vector.c    | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index cd684d45cb5f..125c23b7bad3 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -12,6 +12,9 @@ enum {
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
 };
 
+extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
+extern int x86_fwspec_is_hpet(struct irq_fwspec *fwspec);
+
 extern struct irq_domain *x86_vector_domain;
 
 extern void init_irq_alloc_info(struct irq_alloc_info *info,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb2e2a2488a5..b9b05caa28a4 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -636,7 +636,50 @@ static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 }
 #endif
 
+int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "IO-APIC-", 8) &&
+			simple_strtol(fwname+8, NULL, 10) == fwspec->param[0];
+	}
+	return to_of_node(fwspec->fwnode) &&
+		of_device_is_compatible(to_of_node(fwspec->fwnode),
+					"intel,ce4100-ioapic");
+}
+
+int x86_fwspec_is_hpet(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "HPET-MSI-", 9) &&
+			simple_strtol(fwname+9, NULL, 10) == fwspec->param[0];
+	}
+	return 0;
+}
+
+static int x86_vector_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			     enum irq_domain_bus_token bus_token)
+{
+	/*
+	 * HPET and I/OAPIC cannot be parented in the vector domain
+	 * if IRQ remapping is enabled. APIC IDs above 15 bits are
+	 * only permitted if IRQ remapping is enabled, so check that.
+	 */
+	if (apic->apic_id_valid(32768))
+		return 0;
+
+	return x86_fwspec_is_ioapic(fwspec) || x86_fwspec_is_hpet(fwspec);
+}
+
 static const struct irq_domain_ops x86_vector_domain_ops = {
+	.select		= x86_vector_select,
 	.alloc		= x86_vector_alloc_irqs,
 	.free		= x86_vector_free_irqs,
 	.activate	= x86_vector_activate,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
