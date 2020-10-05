Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E940C46466
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE73F2184D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1YCVnUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73F2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A793A866A1;
	Mon,  5 Oct 2020 15:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aILPiJwg2raF; Mon,  5 Oct 2020 15:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D53F866AF;
	Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB12C0895;
	Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 190FFC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 055CD870CD
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuHaK4Q-hnJo for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 15:28:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B7F53865A1
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Mgg6kezGCxQyZfR1XtRZQfzcS8/IMb4UEOhailZTsT0=; b=Q1YCVnUcbTrToEFiUSc8yVe3Xt
 wKg0pnossS2LjB5wwGHpFWzLo4jSYSAjkk6QDriWfuWSNeF8oeggeSJwUh8yyAJS8k3HfEgBAHalH
 ZBDCb5jQj1aiV26yX7fWS50MuGEYf3wH6PrkwqSNcOchTGKWsp++MLXOupaH/N/3cmex3WClhMy/R
 SvWjr+B/aCLDxukGqyfDI4v1HdcfnLUGTk7iJc/cr82lQTjCHeD9XYR7XsADrJ113mcvMxQMQFxY7
 +U0Mi9vEhg09HU1sbGUKq1wCpOLaujbruCaYSgvQOO7wbe5tPtXJIOsbMEBviRChW7ChT2gUzBRMU
 zQlRgeZw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPSQ4-0001mN-SV; Mon, 05 Oct 2020 15:28:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kPSQ4-0045Qp-Dq; Mon, 05 Oct 2020 16:28:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 09/13] x86/irq: Add x86_non_ir_cpumask
Date: Mon,  5 Oct 2020 16:28:52 +0100
Message-Id: <20201005152856.974112-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005152856.974112-1-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

This is the mask of CPUs to which IRQs can be delivered without interrupt
remapping.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/mpspec.h  |  1 +
 arch/x86/kernel/apic/apic.c    | 12 ++++++++++++
 arch/x86/kernel/apic/io_apic.c |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 25ee8ca0a1f2..b2090be5b444 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -141,5 +141,6 @@ static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
 #define PHYSID_MASK_NONE	{ {[0 ... PHYSID_ARRAY_SIZE-1] = 0UL} }
 
 extern physid_mask_t phys_cpu_present_map;
+extern cpumask_t x86_non_ir_cpumask;
 
 #endif /* _ASM_X86_MPSPEC_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 459c78558f36..069f5e9f1d28 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -103,6 +103,9 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_bios_cpu_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
+/* Mask of CPUs which can be targeted by non-remapped interrupts. */
+cpumask_t x86_non_ir_cpumask = { CPU_BITS_ALL };
+
 #ifdef CONFIG_X86_32
 
 /*
@@ -1838,6 +1841,7 @@ static __init void x2apic_enable(void)
 static __init void try_to_enable_x2apic(int remap_mode)
 {
 	u32 apic_limit = 0;
+	int i;
 
 	if (x2apic_state == X2APIC_DISABLED)
 		return;
@@ -1880,6 +1884,14 @@ static __init void try_to_enable_x2apic(int remap_mode)
 	if (apic_limit)
 		x2apic_set_max_apicid(apic_limit);
 
+	/* Build the affinity mask for interrupts that can't be remapped. */
+	cpumask_clear(&x86_non_ir_cpumask);
+	i = min_t(unsigned int, num_possible_cpus() - 1, apic_limit);
+	for ( ; i >= 0; i--) {
+		if (cpu_physical_id(i) <= apic_limit)
+			cpumask_set_cpu(i, &x86_non_ir_cpumask);
+	}
+
 	x2apic_enable();
 }
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index aa9a3b54a96c..4d0ef46fedb9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2098,6 +2098,8 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
 		struct irq_alloc_info info;
 
 		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
+		if (domain->parent == x86_vector_domain)
+			info.mask = &x86_non_ir_cpumask;
 		info.devid = mpc_ioapic_id(ioapic);
 		info.ioapic.pin = pin;
 		mutex_lock(&ioapic_mutex);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
