Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C02C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666382173E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UK75vErF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666382173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 180CB866A8;
	Mon,  5 Oct 2020 15:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BF4Jnz-fs-nB; Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50FD584AB8;
	Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D171C0891;
	Mon,  5 Oct 2020 15:29:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE2F9C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB0EC84D89
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-krDcR0PlRC for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5512D84AB8
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=AHXKkF//pg8HXvfEGdRvLZPd/GZADKu/SygTIEeX7dk=; b=UK75vErFXwrfBfdBqN7fE9wxXp
 uJWOoKpVjyKY/YJOLsNub3BYpptK0ZdTEqZHrvucmPcphtJbBElLORZ1nN/5H9tajC+dB1mZwdEIQ
 xWq7kuK1/Cbhlx+v03xE6nvXuUBXfmHHiXvO4uY3bgDrSdNum4u043yl/Rx//bBBTWuzzrS9fNbez
 sMr+kFBLqkXU5EDz6rTBLDA3G41fuTLrLdH6Y3E/YQKnoaKG1kin+DLUtWusQDL99x6q/ZgkrvOcF
 5uxHQmFRoJKt5lVSiq2TvyiXfAW+2eKLFZSHB1xiHGeMmHwfqCShcxWl+cJ2xM5G8agTHkJaLpLcV
 YCDhDUBA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPSQ5-0004MM-F1; Mon, 05 Oct 2020 15:28:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kPSQ4-0045Qu-EZ; Mon, 05 Oct 2020 16:28:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity without
 IR
Date: Mon,  5 Oct 2020 16:28:53 +0100
Message-Id: <20201005152856.974112-10-dwmw2@infradead.org>
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

When interrupt remapping isn't enabled, only the first 255 CPUs can
receive external interrupts. Set the appropriate max affinity for
the IOAPIC and MSI IRQ domains accordingly.

This also fixes the case where interrupt remapping is enabled but some
devices are not within the scope of any active IOMMU.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/apic/io_apic.c | 2 ++
 arch/x86/kernel/apic/msi.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 4d0ef46fedb9..1c8ce7bc098f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2332,6 +2332,8 @@ static int mp_irqdomain_create(int ioapic)
 	}
 
 	ip->irqdomain->parent = parent;
+	if (parent == x86_vector_domain)
+		irq_domain_set_affinity(ip->irqdomain, &x86_non_ir_cpumask);
 
 	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
 	    cfg->type == IOAPIC_DOMAIN_STRICT)
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 4d891967bea4..af5ce5c4da02 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -259,6 +259,7 @@ struct irq_domain * __init native_create_pci_msi_domain(void)
 		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
 	} else {
 		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
 	}
 	return d;
 }
@@ -479,6 +480,8 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 		irq_domain_free_fwnode(fn);
 		kfree(domain_info);
 	}
+	if (parent == x86_vector_domain)
+		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
 	return d;
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
