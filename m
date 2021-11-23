Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0109CC433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 16:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA017607FF;
	Tue, 23 Nov 2021 16:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4H7XG4JgN2Jj; Tue, 23 Nov 2021 16:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B78B860749;
	Tue, 23 Nov 2021 16:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968F4C001E;
	Tue, 23 Nov 2021 16:11:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF94FC002F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE23540222
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_Mu_PI1mjm8 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D116140255
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637683861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jPW+WKBoU8cMQJCk9QAE8DV8VVxJ4t74Xc1vlfEknk=;
 b=VzreR8e/wkO2Dr1WY9LkPu+R4fibTEqdBdm2nyXv6YcP//GF+LfVZLFtiwC+U0uVfE5ek3
 olRz6WJP0V64U39/8KIUWlDziSBaK2npoTD0/42J2ClYCd2YhDTPonBM0Iq+PYkUQU2lxh
 mkXHMtY6GrbxQjBUK1JKCKqbd9vBYfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-o45FhOIrOW6NTahcy1bRKQ-1; Tue, 23 Nov 2021 11:10:56 -0500
X-MC-Unique: o45FhOIrOW6NTahcy1bRKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E99419200C0;
 Tue, 23 Nov 2021 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A11D60843;
 Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iommu/amd: x2apic mode: mask/unmask interrupts on
 suspend/resume
Date: Tue, 23 Nov 2021 18:10:37 +0200
Message-Id: <20211123161038.48009-5-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 "open list:AMD IOMMU AMD-VI" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
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

Use IRQCHIP_MASK_ON_SUSPEND to make the core irq code to
mask the iommu interrupt on suspend and unmask it on the resume.

Since now the unmask function updates the INTX settings,
that will restore them on resume from s3/s4.

Since IRQCHIP_MASK_ON_SUSPEND is only effective for interrupts
which are not wakeup sources, remove IRQCHIP_SKIP_SET_WAKE flag
and instead implement a dummy .irq_set_wake which doesn't allow
the interrupt to become a wakeup source.

Fixes: 66929812955bb ("iommu/amd: Add support for X2APIC IOMMU interrupts")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9e895bb8086a6..b94822fc2c9f7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2104,6 +2104,11 @@ static int intcapxt_set_affinity(struct irq_data *irqd,
 	return 0;
 }
 
+static int intcapxt_set_wake(struct irq_data *irqd, unsigned int on)
+{
+	return on ? -EOPNOTSUPP : 0;
+}
+
 static struct irq_chip intcapxt_controller = {
 	.name			= "IOMMU-MSI",
 	.irq_unmask		= intcapxt_unmask_irq,
@@ -2111,7 +2116,8 @@ static struct irq_chip intcapxt_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity       = intcapxt_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.irq_set_wake		= intcapxt_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static const struct irq_domain_ops intcapxt_domain_ops = {
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
