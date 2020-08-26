Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA9FC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B113F20786
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoGPFS/7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUrBzRDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B113F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 754A987C16;
	Wed, 26 Aug 2020 12:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxKA7zQcMu-s; Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC65086DA3;
	Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A445EC07FF;
	Wed, 26 Aug 2020 12:01:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21D3EC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F10EE20406
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PR+oUH9le9PE for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 7400F20413
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:00:59 +0000 (UTC)
Message-Id: <20200826112330.806095671@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TWm8LKwbxOdbljCkicslqQNPr7yXxn0950j4VKvFXNo=;
 b=UoGPFS/7WkvtfI0hX3punHqhBhP/UK4S88ikGD8RW/yf+AurFKJjX4P4EC3wMRQEo3XlUZ
 LtujGPYmgVYq+2AdnyFhaPffxQeMmZLY5riQhmLkbyaNqb5/Tl2/vF8P4/flzxfoNve7Gd
 HvMq+AchBIH/zXZpuCw50Xyw8kZUbXsTBX1z6AM0cPb4XUIN3ZT296ZxwMS9Ftls90RKIx
 QYPHptNSZLVoIKxXnLJuhge/uZrOimnl1Bbl+174HzrumKwK3TJyXxS/LA+CUj9RLLCDum
 tDilxjDbgeG8VP1uAjLlsZFPbkEndfzcYttDAx/NS1vPFTXjsmKgSZgpI1+3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=TWm8LKwbxOdbljCkicslqQNPr7yXxn0950j4VKvFXNo=;
 b=sUrBzRDj7jLvhAKHO3Jo5Tdws9M7K35CNKNa2DKprDj7HLmFAHquotUL5w484KVxZFblZx
 8bAUtdxFXrHkzvDg==
Date: Wed, 26 Aug 2020 13:16:30 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 02/46] x86/init: Remove unused init ops
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

Some past platform removal forgot to get rid of this unused ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h   |   10 ----------
 arch/x86/include/asm/x86_init.h |   10 ----------
 arch/x86/kernel/mpparse.c       |   26 ++++----------------------
 arch/x86/kernel/x86_init.c      |    4 ----
 4 files changed, 4 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -67,21 +67,11 @@ static inline void find_smp_config(void)
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern int default_mpc_apic_id(struct mpc_cpu *m);
-extern void default_smp_read_mpc_oem(struct mpc_table *mpc);
-# ifdef CONFIG_X86_IO_APIC
-extern void default_mpc_oem_bus_info(struct mpc_bus *m, char *str);
-# else
-#  define default_mpc_oem_bus_info NULL
-# endif
 extern void default_find_smp_config(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable 0
-#define default_mpc_apic_id NULL
-#define default_smp_read_mpc_oem NULL
-#define default_mpc_oem_bus_info NULL
 #define default_find_smp_config x86_init_noop
 #define default_get_smp_config x86_init_uint_noop
 #endif
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -11,22 +11,12 @@ struct cpuinfo_x86;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
- * @mpc_record:			platform specific mpc record accounting
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @mpc_apic_id:		platform specific mpc apic id assignment
- * @smp_read_mpc_oem:		platform specific oem mpc table setup
- * @mpc_oem_pci_bus:		platform specific pci bus setup (default NULL)
- * @mpc_oem_bus_info:		platform specific mpc bus info
  * @find_smp_config:		find the smp configuration
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
-	void (*mpc_record)(unsigned int mode);
 	void (*setup_ioapic_ids)(void);
-	int (*mpc_apic_id)(struct mpc_cpu *m);
-	void (*smp_read_mpc_oem)(struct mpc_table *mpc);
-	void (*mpc_oem_pci_bus)(struct mpc_bus *m);
-	void (*mpc_oem_bus_info)(struct mpc_bus *m, char *name);
 	void (*find_smp_config)(void);
 	void (*get_smp_config)(unsigned int early);
 };
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -46,11 +46,6 @@ static int __init mpf_checksum(unsigned
 	return sum & 0xFF;
 }
 
-int __init default_mpc_apic_id(struct mpc_cpu *m)
-{
-	return m->apicid;
-}
-
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	int apicid;
@@ -61,7 +56,7 @@ static void __init MP_processor_info(str
 		return;
 	}
 
-	apicid = x86_init.mpparse.mpc_apic_id(m);
+	apicid = m->apicid;
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR) {
 		bootup_cpu = " (Bootup-CPU)";
@@ -73,7 +68,7 @@ static void __init MP_processor_info(str
 }
 
 #ifdef CONFIG_X86_IO_APIC
-void __init default_mpc_oem_bus_info(struct mpc_bus *m, char *str)
+static void __init mpc_oem_bus_info(struct mpc_bus *m, char *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
@@ -84,7 +79,7 @@ static void __init MP_bus_info(struct mp
 {
 	char str[7];
 
-	x86_init.mpparse.mpc_oem_bus_info(m, str);
+	mpc_oem_bus_info(m, str);
 
 #if MAX_MP_BUSSES < 256
 	if (m->busid >= MAX_MP_BUSSES) {
@@ -100,9 +95,6 @@ static void __init MP_bus_info(struct mp
 		mp_bus_id_to_type[m->busid] = MP_BUS_ISA;
 #endif
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI) - 1) == 0) {
-		if (x86_init.mpparse.mpc_oem_pci_bus)
-			x86_init.mpparse.mpc_oem_pci_bus(m);
-
 		clear_bit(m->busid, mp_bus_not_pci);
 #ifdef CONFIG_EISA
 		mp_bus_id_to_type[m->busid] = MP_BUS_PCI;
@@ -198,8 +190,6 @@ static void __init smp_dump_mptable(stru
 			1, mpc, mpc->length, 1);
 }
 
-void __init default_smp_read_mpc_oem(struct mpc_table *mpc) { }
-
 static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 {
 	char str[16];
@@ -218,14 +208,7 @@ static int __init smp_read_mpc(struct mp
 	if (early)
 		return 1;
 
-	if (mpc->oemptr)
-		x86_init.mpparse.smp_read_mpc_oem(mpc);
-
-	/*
-	 *      Now process the configuration blocks.
-	 */
-	x86_init.mpparse.mpc_record(0);
-
+	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
 		switch (*mpt) {
 		case MP_PROCESSOR:
@@ -256,7 +239,6 @@ static int __init smp_read_mpc(struct mp
 			count = mpc->length;
 			break;
 		}
-		x86_init.mpparse.mpc_record(1);
 	}
 
 	if (!num_processors)
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -67,11 +67,7 @@ struct x86_init_ops x86_init __initdata
 	},
 
 	.mpparse = {
-		.mpc_record		= x86_init_uint_noop,
 		.setup_ioapic_ids	= x86_init_noop,
-		.mpc_apic_id		= default_mpc_apic_id,
-		.smp_read_mpc_oem	= default_smp_read_mpc_oem,
-		.mpc_oem_bus_info	= default_mpc_oem_bus_info,
 		.find_smp_config	= default_find_smp_config,
 		.get_smp_config		= default_get_smp_config,
 	},


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
