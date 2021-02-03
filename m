Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C870C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E0264FAE
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E0264FAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9145986B05;
	Wed,  3 Feb 2021 20:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32voBqACCdfW; Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B1F786B02;
	Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69DC4C1DA7;
	Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54359C0FA7
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F7EA871CF
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MUpFpNMzfgr4 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 20:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B9E29871C9
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:29 +0000 (UTC)
IronPort-SDR: WztMeNk04lL7ytjeyKIDpveAFqJ0NTA0KAoWkh1SpmFqcaQJw/LccWcJYWYY5HthiqO7gXDUzf
 l7GYt2SGVrgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160875298"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="160875298"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 12:57:29 -0800
IronPort-SDR: 4XvBfjP/iQqbBWLZ2szBUV+ObDD33PykBEc1uG1b8bXLvYgFtaa6445QuPrkFnLgTfY8JojNhn
 y11wMRRTP6ng==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="372510555"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 03 Feb 2021 12:57:29 -0800
From: Megha Dey <megha.dey@intel.com>
To: tglx@linutronix.de
Subject: [PATCH 04/12] genirq/proc: Take buslock on affinity write
Date: Wed,  3 Feb 2021 12:56:37 -0800
Message-Id: <1612385805-3412-5-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, megha.dey@intel.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, dwmw@amazon.co.uk
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thomas Gleixner <tglx@linutronix.de>

Until now interrupt chips which support setting affinity are not locking
the associated bus lock for two reasons:

 - All chips which support affinity setting do not use buslock because they
   just can operated directly on the hardware.

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
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 kernel/irq/manage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dec3f73..85ede4e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -443,16 +443,16 @@ int irq_update_affinity_desc(unsigned int irq,
 
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
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
