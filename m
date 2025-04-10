Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEE207666
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270342; cv=none; b=kNlHSGvaed4ZFg1rkTIKBb+2QkBCuYLsczjJ5gB/n5dVZwV2jzVA6OLhFUGYDfnPVNqU7WBJBIi/oSKsR/oPRtvq3gpbsEBffEflb2edDKjPh/j0qHuQsHcPnkQmxnRVPSt9Jsd+Gj+lhd5BGNDw4AKKJ5SVBzjktZvIYDoFW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270342; c=relaxed/simple;
	bh=+9e4FJ2BILObpO6DDTO7rXs/sdl5nKv9ccrtsIhF8Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlQlyBFNklj2Bzz89aSjeEBgVqynWzmVxeoZDaNUvFraRqNIwT4oeQU0FZzHxvH288E6+4SUbexCFzJnX8bAleE9F8HgJAMocm+wwKhzZEn3EIheHdctKgRidV2UaXdp13P3A+T495FTLEwEetz1rX4aIFIz55xQqtMVi8RSZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpfaHAVa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpfaHAVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744270339; x=1775806339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9e4FJ2BILObpO6DDTO7rXs/sdl5nKv9ccrtsIhF8Ho=;
  b=JpfaHAVa7F4GMP+SFhjDTw9F4JvSTwUnK5qTG8Bk+Mlj/AyRamkmuJIe
   oyWTL2QKEcZaQ1T0UNjSmi8oni09L8AjVyfsmzJ8bgVmSP4XUk6mv2lhJ
   jnqzsH3UVZ9g5WavNaeEIxbBHrL+PML69Bbu0oR5b420VSw69sbtB3yNI
   bLaoHVEZAK6AoZqwChTnTgVxAIRdas9wE6IrQSzoBm0Ek+X7AFIq8eaoa
   2fOzP47En33uq4/RU/2jJvp8GpISC7TM9rCH6BWoNVXiXZGZwlOatlVW5
   Oef7UPesD+NlOQFq8RRqrfN4ql4fYRcQbSy+JSaZtAqoiRMZ/p+5rhShn
   w==;
X-CSE-ConnectionGUID: KDf9eyF1TF+fexSJz+LH2g==
X-CSE-MsgGUID: UaIHWfS6SD6jqDGueSa47A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="48478809"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="48478809"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:32:19 -0700
X-CSE-ConnectionGUID: LZF2SkG2QZaavNN78LVKNg==
X-CSE-MsgGUID: +bAJ7Th0R7alb88TJ2Mrgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129166470"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2025 00:32:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs
Date: Thu, 10 Apr 2025 15:32:46 +0800
Message-ID: <20250410073247.1454287-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410073247.1454287-1-baolu.lu@linux.intel.com>
References: <20250410073247.1454287-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Set the posted MSI irq_chip's irq_ack() hook to irq_move_irq() instead of
a dummy/empty callback so that posted MSIs process pending changes to the
IRQ's SMP affinity.  Failure to honor a pending set-affinity results in
userspace being unable to change the effective affinity of the IRQ, as
IRQD_SETAFFINITY_PENDING is never cleared and so irq_set_affinity_locked()
always defers moving the IRQ.

The issue is most easily reproducible by setting /proc/irq/xx/smp_affinity
multiple times in quick succession, as only the first update is likely to
be handled in process context.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: Robert Lippert <rlippert@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Wentao Yang <wentaoyang@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250321194249.1217961-1-seanjc@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ea3ca5203919..3bc2a03cceca 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1287,43 +1287,44 @@ static struct irq_chip intel_ir_chip = {
 };
 
 /*
- * With posted MSIs, all vectors are multiplexed into a single notification
- * vector. Devices MSIs are then dispatched in a demux loop where
- * EOIs can be coalesced as well.
+ * With posted MSIs, the MSI vectors are multiplexed into a single notification
+ * vector, and only the notification vector is sent to the APIC IRR.  Device
+ * MSIs are then dispatched in a demux loop that harvests the MSIs from the
+ * CPU's Posted Interrupt Request bitmap.  I.e. Posted MSIs never get sent to
+ * the APIC IRR, and thus do not need an EOI.  The notification handler instead
+ * performs a single EOI after processing the PIR.
  *
- * "INTEL-IR-POST" IRQ chip does not do EOI on ACK, thus the dummy irq_ack()
- * function. Instead EOI is performed by the posted interrupt notification
- * handler.
+ * Note!  Pending SMP/CPU affinity changes, which are per MSI, must still be
+ * honored, only the APIC EOI is omitted.
  *
  * For the example below, 3 MSIs are coalesced into one CPU notification. Only
- * one apic_eoi() is needed.
+ * one apic_eoi() is needed, but each MSI needs to process pending changes to
+ * its CPU affinity.
  *
  * __sysvec_posted_msi_notification()
  *	irq_enter();
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *	apic_eoi()
  *	irq_exit()
+ *
  */
-
-static void dummy_ack(struct irq_data *d) { }
-
 static struct irq_chip intel_ir_chip_post_msi = {
 	.name			= "INTEL-IR-POST",
-	.irq_ack		= dummy_ack,
+	.irq_ack		= irq_move_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
-- 
2.43.0

