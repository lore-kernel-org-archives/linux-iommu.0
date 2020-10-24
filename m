Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD68C55179
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270F92464E
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pcSMH5Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270F92464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ACE18738C;
	Sat, 24 Oct 2020 21:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bcuoDtCO9uUf; Sat, 24 Oct 2020 21:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34B0E87550;
	Sat, 24 Oct 2020 21:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2339AC1AD7;
	Sat, 24 Oct 2020 21:36:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1F4AC0051
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DA39486A32
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkvyaBO2QAk5 for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 04D6B86A3F
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=IEuM/DY48LV1kSqzyk1PpZ8V9H+gSFXivoek6I+9py8=; b=pcSMH5Uf7aMUj+QI2qxpqDBW60
 v8jB7TDJe7fFIA5RTGZic2fzHTRjKamdE26IZweyod2fS7lop/pkHotBUJOwAkAUn99IOTcr5coaD
 iSrVJaEOaCBqpywm5xk8r037hTXqM7SBWGtGnJYARQ9Bs6xlx9nyf5lRnZnfsh3lP0JIMXt71OlIv
 bWou9ix3RNI9POEqGDby1NVnjMImabKERWPjWRxX+BS6JmVqyWIhTTdgnAyEXP1KH0zpzGDlDL6Ie
 Oz+XvA2Odnw4Y+KQyBPgvNOvGq0cHxd0lEjZZKKdHRTFz6II6D3ycd2aersugYj+8zf7GmQTchyOs
 qZxvCt0w==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCS-0006HM-TX; Sat, 24 Oct 2020 21:35:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCN-001rPa-Ef; Sat, 24 Oct 2020 22:35:39 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 31/35] x86/ioapic: Handle Extended Destination ID field in
 RTE
Date: Sat, 24 Oct 2020 22:35:31 +0100
Message-Id: <20201024213535.443185-32-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

Bits 63-48 of the I/OAPIC Redirection Table Entry map directly to bits 19-4
of the address used in the resulting MSI cycle.

Historically, the x86 MSI format only used the top 8 of those 16 bits as
the destination APIC ID, and the "Extended Destination ID" in the lower 8
bits was unused.

With interrupt remapping, the lowest bit of the Extended Destination ID
(bit 48 of RTE, bit 4 of MSI address) is now used to indicate a remappable
format MSI.

A hypervisor can use the other 7 bits of the Extended Destination ID to
permit guests to address up to 15 bits of APIC IDs, thus allowing 32768
vCPUs before having to expose a vIOMMU and interrupt remapping to the
guest.

No behavioural change in this patch, since nothing yet permits APIC IDs
above 255 to be used with the non-IR I/OAPIC domain.

[ tglx: Converted it to the cleaned up entry/msi_msg format and added
  	commentry ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/io_apic.h |  3 ++-
 arch/x86/kernel/apic/io_apic.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 73da644b2f0d..437aa8d00e53 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -67,7 +67,8 @@ struct IO_APIC_route_entry {
 				is_level		:  1,
 				masked			:  1,
 				reserved_0		: 15,
-				reserved_1		: 24,
+				reserved_1		: 17,
+				virt_destid_8_14	:  7,
 				destid_0_7		:  8;
 		};
 		struct {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 443d2c9086b9..1cfd65ef295b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1238,9 +1238,10 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
 				entry.ir_zero);
 		} else {
-			printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n", buf,
+			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
 			       entry.dest_mode_logical ? "logical " : "physical",
-			       entry.destid_0_7, entry.delivery_mode);
+			       entry.virt_destid_8_14, entry.destid_0_7,
+			       entry.delivery_mode);
 		}
 	}
 }
@@ -1409,6 +1410,7 @@ void native_restore_boot_irq_mode(void)
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
+		u32 apic_id = read_apic_id();
 
 		memset(&entry, 0, sizeof(entry));
 		entry.masked		= false;
@@ -1416,7 +1418,8 @@ void native_restore_boot_irq_mode(void)
 		entry.active_low	= false;
 		entry.dest_mode_logical	= false;
 		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
-		entry.destid_0_7	= read_apic_id();
+		entry.destid_0_7	= apic_id & 0xFF;
+		entry.virt_destid_8_14	= apic_id >> 8;
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
@@ -1885,7 +1888,11 @@ static void ioapic_setup_msg_from_msi(struct irq_data *irq_data,
 	/* DMAR/IR: 1, 0 for all other modes */
 	entry->ir_format		= msg.arch_addr_lo.dmar_format;
 	/*
-	 * DMAR/IR: index bit 0-14.
+	 * - DMAR/IR: index bit 0-14.
+	 *
+	 * - Virt: If the host supports x2apic without a virtualized IR
+	 *	   unit then bit 0-6 of dmar_index_0_14 are providing bit
+	 *	   8-14 of the destination id.
 	 *
 	 * All other modes have bit 0-6 of dmar_index_0_14 cleared and the
 	 * topmost 8 bits are destination id bit 0-7 (entry::destid_0_7).
@@ -2063,6 +2070,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	int apic, pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	u32 apic_id;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
 	if (pin == -1) {
@@ -2078,11 +2086,13 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
+	apic_id = hard_smp_processor_id();
 	memset(&entry1, 0, sizeof(entry1));
 
 	entry1.dest_mode_logical	= true;
 	entry1.masked			= false;
-	entry1.destid_0_7		= hard_smp_processor_id();
+	entry1.destid_0_7		= apic_id & 0xFF;
+	entry1.virt_destid_8_14		= apic_id >> 8;
 	entry1.delivery_mode		= APIC_DELIVERY_MODE_EXTINT;
 	entry1.active_low		= entry0.active_low;
 	entry1.is_level			= false;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
