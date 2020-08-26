Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9181C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991632087D
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S31zf4KR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRfG8jWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991632087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43D7387697;
	Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyX1lysqRwy3; Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF2BC875DA;
	Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81D55C016F;
	Wed, 26 Aug 2020 12:08:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC07DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C80AF84E97
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TO_G0ZfPCkYG for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 27B8884E8C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:08:49 +0000 (UTC)
Message-Id: <20200826112334.795343913@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=++RJAb0XwXR6HGwCiKdimUJ+P96gsDP2cTuWDbVCwn8=;
 b=S31zf4KRdKSl+c/54qaBKf9wiJkWSKJKFVO3xb0t8u3lZOBrM+cgNH7LKEKYWzT/y/HwU0
 mI4r8a/uksNI5Vj9EC+f4ho50SX72FhEgvzxuRqkIKlIH5X37IGajDxfGALbvPrnnix18L
 XYH6svrlZFlPJJoWtNXPqV4SuQjzyJuaNpdeRlu/0jh6J9Y5Am5xrIBHDLjgy0Atbv2JoJ
 HN7ySGpQ4wwoj91aEaCckv39Gll7Pv8enAqSOUDLnY7IBSWqKio6eCPc6y+A8zKjrzUQIw
 1fleRXIy5jKI+RdfMzzmocRDunkz9kLkt8ibCm7I0U1OH3q5r64Bp5MTrt68Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=++RJAb0XwXR6HGwCiKdimUJ+P96gsDP2cTuWDbVCwn8=;
 b=VRfG8jWe0BEQR76gNnsKVNJRq1rafZxZ4YVg3rty4q0d1NS7xGqWPCzx5Fhj9EVpwoneik
 IgeTkQyy30POemBw==
Date: Wed, 26 Aug 2020 13:17:10 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 42/46] genirq/proc: Take buslock on affinity write
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

Until now interrupt chips which support setting affinity are nit locking
the associated bus lock for two reasons:

 - All chips which support affinity setting do not use buslock because they just
   can operated directly on the hardware.

 - All chips which use buslock do not support affinity setting because
   their interrupt chips are not capable. These chips are usually connected
   over a bus like I2C, SPI etc. and have an interrupt output which is
   conneted to CPU interrupt of some sort. So there is no way to set the
   affinity on the chip itself.

Upcoming hardware which is PCIE based sports a non standard MSI(X) variant
which stores the MSI message in RAM which is associated to e.g. a device
queue. The device manages this RAM and writes have to be issued via command
queues or similar mechanisms which is obviously not possible from interrupt
disabled, raw spinlock held context.

The buslock mechanism of irq chips can be utilized to support that. The
affinity write to the chip writes to shadow state, marks it pending and the
irq chip's irq_bus_sync_unlock() callback handles the command queue and
wait for completion similar to the other chip operations on I2C or SPI
busses.

Change the locking in irq_set_affinity() to bus_lock/unlock to help with
that. There are a few other callers than the proc interface, but none of
them is affected by this change as none of them affects an irq chip with
bus lock support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/irq/manage.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -373,16 +373,16 @@ int irq_set_affinity_locked(struct irq_d
 
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc;
 	unsigned long flags;
 	int ret;
 
+	desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
 	if (!desc)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
 	ret = irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask, force);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
