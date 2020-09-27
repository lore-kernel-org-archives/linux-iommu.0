Return-Path: <SRS0=BifM=DE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0686C4346E
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539BF23718
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtWT6FXN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lHZQSLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539BF23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC7732039E;
	Sun, 27 Sep 2020 08:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Po-pWvtpKNEN; Sun, 27 Sep 2020 08:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7AF0D2002E;
	Sun, 27 Sep 2020 08:46:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C751C0889;
	Sun, 27 Sep 2020 08:46:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81FCDC0051
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 08:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 723C2854C9
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 08:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFt0NdwUAd-0 for <iommu@lists.linux-foundation.org>;
 Sun, 27 Sep 2020 08:46:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A7751848C2
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 08:46:49 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1601196405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=3LGtm2OI8qF06h9KMGGQRJ7d4e/B09d0iYRNLqK19DE=;
 b=vtWT6FXNpv1rJGdbEJJKxhxZ2hkowdjPcJEaDMAro5/mwYgF7f2qjEeiKFQSSH9PtTbtjQ
 HsUFQz/Trt8kMSfUg/AQa+Dd6H6TLmp85HgtKhILMKJEBPAXZTlBVlCuBVrTlZ3SWkXObd
 A3uYhH4wFHZJacmbgX2O+NsHMqa/9G2Pkuz65AAv9jSfW+iCB+ZS9fYcuTgvLwKZwmDf/O
 zZgGz9fCusPWYJqd2bYwAHlyXGdEd/MWFvhUhNXr7HHWvB0uTZIwM6dBXR4V6SnJO+mQK+
 WSRcbCQJ++zz1iV8DGtZCO9vHOjRIHe69AAw88TEiMXTyc69NYyY/moKXh9SBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1601196405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=3LGtm2OI8qF06h9KMGGQRJ7d4e/B09d0iYRNLqK19DE=;
 b=2lHZQSLVc5ukVdtzXcK6JAqYUmFwK6ZXXzxyFLvvd4IZf5x37NfcDYaGYy6WSVTOsGs4s7
 44wL1Jbt8wkVdCAA==
To: Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@redhat.com>
Subject: [PATCH] x86/apic/msi: Unbreak DMAR and HPET MSI
In-Reply-To: <87tuvltpo5.fsf@nanos.tec.linutronix.de>
Date: Sun, 27 Sep 2020 10:46:44 +0200
Message-ID: <87wo0fli8b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-next@vger.kernel.org,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

Switching the DMAR and HPET MSI code to use the generic MSI domain ops
missed to add the flag which tells the core code to update the domain
operations with the defaults. As a consequence the core code crashes
when an interrupt in one of those domains is allocated.

Add the missing flags.

Fixes: 9006c133a422 ("x86/msi: Use generic MSI domain ops")
Reported-by: Qian Cai <cai@redhat.com> 
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -309,6 +309,7 @@ static struct msi_domain_ops dmar_msi_do
 static struct msi_domain_info dmar_msi_domain_info = {
 	.ops		= &dmar_msi_domain_ops,
 	.chip		= &dmar_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 static struct irq_domain *dmar_get_irq_domain(void)
@@ -408,6 +409,7 @@ static struct msi_domain_ops hpet_msi_do
 static struct msi_domain_info hpet_msi_domain_info = {
 	.ops		= &hpet_msi_domain_ops,
 	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 struct irq_domain *hpet_create_irq_domain(int hpet_id)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
