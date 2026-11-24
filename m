Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522554;
	b=2R2ObIip3K9wG/zRW37M3qp0KEH7SZzureAwA7vi7kaFkIgEJytTWXdxwNKC4jPWBkOl
	 Jqqj5s5b2bTtdrI08rcmnDKKcVtVUqJHIZ/rIx6hb8Z8M+hzTIZXmQby1dqe6FdugCyPL
	 cAXxpv3tbNB3vQWn0kxHduVj/ZmZ0gxVmxn2IQ5iEakboCQ6klH90rUAqDnwg63CHEDU/
	 fkxyISOn9YghfxkFRsZ4TqgvIfhiQoONqbqOA6hWGZXv25dJT6WeARy1RML7bzB2wPh/F
	 8GvUYbRZPSDipcBZmRr66TLnAb+oQUXJbOy8WzjzfqaHU9cHDCQou6TeQY0LbOmTtgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522554;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPPgdgJv3p61PHC94G8DwdLAu9SwdqBRTFNPG1gejsg=;
	b=MBL8H6p2iGMqhoDAd7PdBCUIkAzB8Z7VxFaiRfK+lC30SFN+pZfTSIepYYynrVc9fORK
	 Pq22S4wEmUraEMoZfaEXddQMJzDZJ5fMV8zNMDMgTfs3H6mdsCy4/ROGkkgAm+kbF3nZx
	 i5ikOO849SaO89USmdrONs9yEe9+bkvAr1rJ9mdQfq8nWA7hf3dPE3UAiblDbTyJ+A+WF
	 L5nzHdBeB5PCEJDxjqXhHZJI1/GPvhcTCQfQNf6v0reP/gy0XYCUabJcCQw9lrlHwz4sl
	 K5Mw1gZ03DFWqOEGGBieggMYiNvs6ywfWUBzz4PuOw5r8nHn6SUxbOdIekJ8fowqs1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fuH9tYJY;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C12606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 12:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C12606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fuH9tYJY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795522546; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dPPgdgJv3p61PHC94G8DwdLAu9SwdqBRTFNPG1gejsg=;
	b=fuH9tYJY0YyALn4G37wU0iVJlC/KEfXTzUlTebmHipPkH3/qQn3x6AZ43ekEjIO9xUFYwzjFLH2w8YusHzX2OVjhIORl23RUkZ2eC4pv4Pipe5B6LkJHnoCjGjqwsDvwRqZp5kETQ7ueDdXblegJfHaubIyumuPrXw1WAAt2W4k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFOXWnb_1795522518;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFOXWnb_1795522518 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:15:45 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: vasant.hegde@amd.com
Cc: guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: [PATCH v2] iommu/amd: Reuse device data for IRTE cache invalidation
Date: Tue, 24 Nov 2026 20:15:18 +0800
Message-ID: <20261124121518.440906-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <721a92c6-fbf3-4f92-9812-3765dbe4af6a@amd.com>
References: <721a92c6-fbf3-4f92-9812-3765dbe4af6a@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA alias invalidation path in iommu_flush_irt_and_complete()
performs a linear search_dev_data() walk on every IRTE update.  Nested
VM entry and exit can switch multiple interrupt routes between guest
and remapping modes, repeating this lookup for each posted interrupt.
A reported workload with 4334 device entries shows median lookup
latencies of 22-33 us per invocation, even when IRT caching is
disabled and the lookup result is unused.

Save the allocation-time device data in struct amd_ir_data and thread
it through all IRTE update paths:

 - iommu_flush_irt_and_complete() accepts a dev_data parameter.  When
   IRT caching is disabled it returns immediately without any lookup.
   When dev_data is NULL (IOAPIC/HPET allocated before PCI enumeration)
   it falls back to search_dev_data() so DMA-alias invalidation still
   works if the device is later probed.

 - modify_irte_ga(), modify_irte() and free_irte() accept and forward
   dev_data.

 - The amd_irte_ops callbacks (activate, deactivate, set_affinity) are
   extended to carry dev_data so that amd_ir_update_irte() and the
   irq_remapping activate/deactivate domain callbacks pass the cached
   pointer.

 - amd_iommu_activate_guest_mode() and deactivate_guest_mode() pass
   ir_data->dev_data directly.

 - amd_ir_set_vcpu_affinity() reuses ir_data->dev_data for the vCPU
   affinity capability check.  This path is only reachable through
   irq_bypass producers (VFIO-PCI, vhost-vDPA), where device probe
   always precedes IRQ allocation, so dev_data is guaranteed non-NULL.

Device data is retained in the segment list across unplug and reused on
reprobe, so the cached pointer remains valid throughout the IRQ
lifetime.  The PCI device is still resolved through dev_data->dev at
flush time so that later device association is observed.

DMA-alias invalidation, command ordering, locking and completion waits
are preserved when IRT caching is enabled.

Fixes: 5aac28784dca ("iommu/amd: Invalidate IRT cache for DMA aliases")
Reported-by: Yifei Ge <geyifei@linux.alibaba.com>
Co-developed-by: hr567 <hr567@linux.alibaba.com>
Signed-off-by: hr567 <hr567@linux.alibaba.com>
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 10 ++--
 drivers/iommu/amd/iommu.c           | 76 +++++++++++++++++------------
 2 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f98770db0090..da6d90f3a574 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1029,6 +1029,7 @@ struct irq_2_irte {
 
 struct amd_ir_data {
 	struct amd_iommu *iommu;
+	struct iommu_dev_data *dev_data;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
@@ -1045,9 +1046,12 @@ struct amd_ir_data {
 
 struct amd_irte_ops {
 	void (*prepare)(void *, u32, bool, u8, u32, int);
-	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
-	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
-	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
+	void (*activate)(struct amd_iommu *iommu, void *, u16, u16,
+			 struct iommu_dev_data *dev_data);
+	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16,
+			   struct iommu_dev_data *dev_data);
+	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8,
+			     u32, struct iommu_dev_data *dev_data);
 	void *(*get)(struct irq_remap_table *, int);
 	void (*set_allocated)(struct irq_remap_table *, int);
 	bool (*is_allocated)(struct irq_remap_table *, int);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf8..d171ccf2eee0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3291,18 +3291,21 @@ static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
 	return ret;
 }
 
-static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
+static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid,
+					 struct iommu_dev_data *dev_data)
 {
 	int ret;
 	u64 data;
 	unsigned long flags;
 	struct iommu_cmd cmd;
 	struct pci_dev *pdev = NULL;
-	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
+	if (!dev_data)
+		dev_data = search_dev_data(iommu, devid);
+
 	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
@@ -3578,7 +3581,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 }
 
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
-			  struct irte_ga *irte)
+			  struct irte_ga *irte, struct iommu_dev_data *dev_data)
 {
 	int ret;
 
@@ -3586,13 +3589,13 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 	if (ret)
 		return ret;
 
-	iommu_flush_irt_and_complete(iommu, devid);
+	iommu_flush_irt_and_complete(iommu, devid, dev_data);
 
 	return 0;
 }
 
-static int modify_irte(struct amd_iommu *iommu,
-		       u16 devid, int index, union irte *irte)
+static int modify_irte(struct amd_iommu *iommu, u16 devid, int index,
+		       union irte *irte, struct iommu_dev_data *dev_data)
 {
 	struct irq_remap_table *table;
 	unsigned long flags;
@@ -3605,12 +3608,13 @@ static int modify_irte(struct amd_iommu *iommu,
 	table->table[index] = irte->val;
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt_and_complete(iommu, devid);
+	iommu_flush_irt_and_complete(iommu, devid, dev_data);
 
 	return 0;
 }
 
-static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
+static void free_irte(struct amd_iommu *iommu, u16 devid, int index,
+		      struct iommu_dev_data *dev_data)
 {
 	struct irq_remap_table *table;
 	unsigned long flags;
@@ -3623,7 +3627,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
 	iommu->irte_ops->clear_allocated(table, index);
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt_and_complete(iommu, devid);
+	iommu_flush_irt_and_complete(iommu, devid, dev_data);
 }
 
 static void irte_prepare(void *entry,
@@ -3656,50 +3660,57 @@ static void irte_ga_prepare(void *entry,
 	irte->lo.fields_remap.valid       = 1;
 }
 
-static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
+static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid,
+			  u16 index, struct iommu_dev_data *dev_data)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 1;
-	modify_irte(iommu, devid, index, irte);
+	modify_irte(iommu, devid, index, irte, dev_data);
 }
 
-static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
+static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid,
+			     u16 index, struct iommu_dev_data *dev_data)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 1;
-	modify_irte_ga(iommu, devid, index, irte);
+	modify_irte_ga(iommu, devid, index, irte, dev_data);
 }
 
-static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
+static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
+			    u16 index, struct iommu_dev_data *dev_data)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 0;
-	modify_irte(iommu, devid, index, irte);
+	modify_irte(iommu, devid, index, irte, dev_data);
 }
 
-static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
+static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
+			       u16 index, struct iommu_dev_data *dev_data)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 0;
-	modify_irte_ga(iommu, devid, index, irte);
+	modify_irte_ga(iommu, devid, index, irte, dev_data);
 }
 
-static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
-			      u8 vector, u32 dest_apicid)
+static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid,
+			      u16 index, u8 vector, u32 dest_apicid,
+			      struct iommu_dev_data *dev_data)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.vector = vector;
 	irte->fields.destination = dest_apicid;
-	modify_irte(iommu, devid, index, irte);
+	modify_irte(iommu, devid, index, irte, dev_data);
 }
 
-static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
-				 u8 vector, u32 dest_apicid)
+static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry,
+				 u16 devid, u16 index, u8 vector,
+				 u32 dest_apicid,
+				 struct iommu_dev_data *dev_data)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
@@ -3709,7 +3720,7 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(iommu, devid, index, irte);
+		modify_irte_ga(iommu, devid, index, irte, dev_data);
 	}
 }
 
@@ -3945,6 +3956,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		}
 
 		data->iommu = iommu;
+		data->dev_data = dev_data;
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
@@ -3963,7 +3975,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		}
 	}
 	for (i = 0; i < nr_irqs; i++)
-		free_irte(iommu, devid, index + i);
+		free_irte(iommu, devid, index + i, dev_data);
 out_free_parent:
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	return ret;
@@ -3982,7 +3994,8 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 		if (irq_data && irq_data->chip_data) {
 			data = irq_data->chip_data;
 			irte_info = &data->irq_2_irte;
-			free_irte(data->iommu, irte_info->devid, irte_info->index);
+			free_irte(data->iommu, irte_info->devid,
+				  irte_info->index, data->dev_data);
 			kfree(data->entry);
 			kfree(data);
 		}
@@ -4007,7 +4020,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 		return 0;
 
 	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
-				  irte_info->index);
+				  irte_info->index, data->dev_data);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
 }
@@ -4021,7 +4034,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 
 	if (iommu)
 		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
-					    irte_info->index);
+					    irte_info->index, data->dev_data);
 }
 
 static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
@@ -4133,7 +4146,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry);
+			      ir_data->irq_2_irte.index, entry, ir_data->dev_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
@@ -4165,7 +4178,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry);
+			      ir_data->irq_2_irte.index, entry, ir_data->dev_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 
@@ -4174,7 +4187,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 	int ret;
 	struct amd_iommu_pi_data *pi_data = info;
 	struct amd_ir_data *ir_data = data->chip_data;
-	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct iommu_dev_data *dev_data;
 
 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
@@ -4183,7 +4195,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 	if (ir_data->iommu == NULL)
 		return -EINVAL;
 
-	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
+	dev_data = ir_data->dev_data;
 
 	/* Note:
 	 * This device has never been set up for guest mode.
@@ -4225,7 +4237,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 	 */
 	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
 				      irte_info->index, cfg->vector,
-				      cfg->dest_apicid);
+				      cfg->dest_apicid, ir_data->dev_data);
 }
 
 static int amd_ir_set_affinity(struct irq_data *data,

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.7

