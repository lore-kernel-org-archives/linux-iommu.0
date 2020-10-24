Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB2C2D0A3
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2327A24687
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TwEX9h4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2327A24687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C7D222288F;
	Sat, 24 Oct 2020 21:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyUOn56TwF2e; Sat, 24 Oct 2020 21:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1268222E96;
	Sat, 24 Oct 2020 21:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB2EAC0052;
	Sat, 24 Oct 2020 21:35:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCB1C0051
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 80FDD87449
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAelyclmWTZL for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7CD8887353
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=C0ceQD7RpCrLmfkKsXqDNRC608zY/4Bwc4glHhGbq80=; b=TwEX9h4adZHoXwYi8vmInLnsVN
 +L00VhuxtBSQRwLUTSJ5jmMYv/ofpq6xWavAf2eLtMgt0QerE2T6qWmlGIPDOYYUoXErC5wT7MW6J
 OC3nYqgXSRYuxPwEPXglZnUB/2RMNn2oWJNVb1sOKN+TmcTG6+YkCmW2KvstC6FwMIFj0W2uU7oUO
 tq2zyrZwt3lZfapPP3J3Uxixizj72G6QEJQ2AhuyKyhF6MJER9cH/0ylydQ+wdoXyp6eB7M+co4/g
 vtQz3atVW+BnhGqrD1RuATTwH9Fu5W0er2CXYIFso+7o8LQ1S10Um/57zMAu8buVBVlL3QoKdVQPa
 H63NuUvg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCO-0008B4-Gj; Sat, 24 Oct 2020 21:35:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rNo-Lh; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 04/35] x86/devicetree: Fix the ioapic interrupt type table
Date: Sat, 24 Oct 2020 22:35:04 +0100
Message-Id: <20201024213535.443185-5-dwmw2@infradead.org>
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

The ioapic interrupt type table is wrong as it assumes that polarity in
IO/APIC context means active high when set. But the IO/APIC polarity is
working the other way round. This works because the ordering of the entries
is consistent with the device tree and the type information is not used by
the IO/APIC interrupt chip.

The whole trigger and polarity business of IO/APIC is misleading and the
corresponding constants which are defined as 0/1 are not used consistently
and are going to be removed.

Rename the type table members to 'is_level' and 'active_low' and adjust the
type information for consistency sake.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/devicetree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index ddffd80f5c52..6a4cb71c2498 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -184,31 +184,31 @@ static unsigned int ioapic_id;
 
 struct of_ioapic_type {
 	u32 out_type;
-	u32 trigger;
-	u32 polarity;
+	u32 is_level;
+	u32 active_low;
 };
 
 static struct of_ioapic_type of_ioapic_type[] =
 {
 	{
-		.out_type	= IRQ_TYPE_EDGE_RISING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_EDGE_FALLING,
+		.is_level	= 0,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_LOW,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_LEVEL_HIGH,
+		.is_level	= 1,
+		.active_low	= 0,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_HIGH,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_LEVEL_LOW,
+		.is_level	= 1,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_EDGE_FALLING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_EDGE_RISING,
+		.is_level	= 0,
+		.active_low	= 0,
 	},
 };
 
@@ -228,7 +228,7 @@ static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -EINVAL;
 
 	it = &of_ioapic_type[type_index];
-	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
+	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->is_level, it->active_low);
 	tmp.devid = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
 	tmp.ioapic.pin = fwspec->param[0];
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
