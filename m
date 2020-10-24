Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B8C55178
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F5F2467D
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5b57apR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F5F2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EB4186DAB;
	Sat, 24 Oct 2020 21:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRm2AeAsq7j5; Sat, 24 Oct 2020 21:35:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4E2F86DE6;
	Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B406C0893;
	Sat, 24 Oct 2020 21:35:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4843BC0893
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 44ABF23042
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGW4pvC74J2x for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E02F22EE6
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=oRyakceIP/TFXvK76fbdXS3FFH/9LgbMQ1HbuHTy96Y=; b=d5b57apRweNghhk9ezifYmHEda
 JPVqba1KtUlqcAJ5GQALllLQyxydLXGW6P/qinNaYpJNzecpjnogG9J6Delg0cg7ouZuqAejJkAvg
 i8ni2pGb6L6JuvIZeahlDvl2hsqcX+6ML36O0bHmQo3Pl3QZqOLFV6CMo1I99VEKoT8SK3ZX7u5Kx
 3zMO0fAb3cX8o08K1SABBK4r4OZ3YrP+WpYfLswpiDkVQ7z0HCGg+KjYQrqm+JV2wMMKvODlo5dSG
 7St5aUW07NHnRje9KZribPJGjrN93wzPJGx7CQ3gKOZX8L1LLsmtlpogVCMee6TpZOfTVjwYrdpq9
 s+bCa8IQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCS-0008BW-Tj; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rOH-S9; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 11/35] genirq/msi: Allow shadow declarations of
 msi_msg::$member
Date: Sat, 24 Oct 2020 22:35:11 +0100
Message-Id: <20201024213535.443185-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
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

From: Thomas Gleixner <tglx@linutronix.de>

Architectures like x86 have their MSI messages in various bits of the data,
address_lo and address_hi field. Composing or decomposing these messages
with bitmasks and shifts is possible, but unreadable gunk.

Allow architectures to provide an architecture specific representation for
each member of msi_msg. Provide empty defaults for each and stick them into
an union.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/asm-generic/msi.h |  4 ++++
 include/linux/msi.h       | 46 +++++++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index e6795f088bdd..25344de0e8f9 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+
 #ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
 # define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
 #endif
@@ -30,4 +32,6 @@ typedef struct msi_alloc_info {
 
 #define GENERIC_MSI_DOMAIN_OPS		1
 
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+
 #endif
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6b584cc4757c..360a0a7e7341 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,11 +4,50 @@
 
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <asm/msi.h>
+
+/* Dummy shadow structures if an architecture does not define them */
+#ifndef arch_msi_msg_addr_lo
+typedef struct arch_msi_msg_addr_lo {
+	u32	address_lo;
+} __attribute__ ((packed)) arch_msi_msg_addr_lo_t;
+#endif
+
+#ifndef arch_msi_msg_addr_hi
+typedef struct arch_msi_msg_addr_hi {
+	u32	address_hi;
+} __attribute__ ((packed)) arch_msi_msg_addr_hi_t;
+#endif
+
+#ifndef arch_msi_msg_data
+typedef struct arch_msi_msg_data {
+	u32	data;
+} __attribute__ ((packed)) arch_msi_msg_data_t;
+#endif
 
+/**
+ * msi_msg - Representation of a MSI message
+ * @address_lo:		Low 32 bits of msi message address
+ * @arch_addrlo:	Architecture specific shadow of @address_lo
+ * @address_hi:		High 32 bits of msi message address
+ *			(only used when device supports it)
+ * @arch_addrhi:	Architecture specific shadow of @address_hi
+ * @data:		MSI message data (usually 16 bits)
+ * @arch_data:		Architecture specific shadow of @data
+ */
 struct msi_msg {
-	u32	address_lo;	/* low 32 bits of msi message address */
-	u32	address_hi;	/* high 32 bits of msi message address */
-	u32	data;		/* 16 bits of msi message data */
+	union {
+		u32			address_lo;
+		arch_msi_msg_addr_lo_t	arch_addr_lo;
+	};
+	union {
+		u32			address_hi;
+		arch_msi_msg_addr_hi_t	arch_addr_hi;
+	};
+	union {
+		u32			data;
+		arch_msi_msg_data_t	arch_data;
+	};
 };
 
 extern int pci_msi_ignore_mask;
@@ -243,7 +282,6 @@ struct msi_controller {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 
 #include <linux/irqhandler.h>
-#include <asm/msi.h>
 
 struct irq_domain;
 struct irq_domain_ops;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
