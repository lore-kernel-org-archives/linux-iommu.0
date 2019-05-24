Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6661CC282DD
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D1A217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9EDCB1178;
	Fri, 24 May 2019 01:16:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D5A3A114A
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0D09CF4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
Date: Thu, 23 May 2019 18:16:22 -0700
Message-Id: <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, Wincy Van <fanwenyi0529@gmail.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When interrupt remapping is enabled, MSI interrupt messages must follow a
special format that the IOMMU can understand. Hence, when the HPET hard
lockup detector is used with interrupt remapping, it must also follow this
special format.

The IOMMU, given the information about a particular interrupt, already
knows how to populate the MSI message with this special format and the
corresponding entry in the interrupt remapping table. Given that this is a
special interrupt case, we want to avoid the interrupt subsystem. Add two
functions to create an entry for the HPET hard lockup detector. Perform
this process in two steps as described below.

When initializing the lockup detector, the function
hld_hpet_intremap_alloc_irq() permanently allocates a new entry in the
interrupt remapping table and populates it with the information the
IOMMU driver needs. In order to populate the table, the IOMMU needs to
know the HPET block ID as described in the ACPI table. Hence, add such
ID to the data of the hardlockup detector.

When the hardlockup detector is enabled, the function
hld_hpet_intremapactivate_irq() activates the recently created entry
in the interrupt remapping table via the modify_irte() functions. While
doing this, it specifies which CPU the interrupt must target via its APIC
ID. This function can be called every time the destination iD of the
interrupt needs to be updated; there is no need to allocate or remove
entries in the interrupt remapping table.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wincy Van <fanwenyi0529@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         | 11 +++++++
 arch/x86/kernel/hpet.c              |  1 +
 drivers/iommu/intel_irq_remapping.c | 49 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index a82cbe17479d..811051fa7ade 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -119,6 +119,8 @@ struct hpet_hld_data {
 	u64		tsc_ticks_per_cpu;
 	u32		handling_cpu;
 	u32		enabled_cpus;
+	u8		blockid;
+	void		*intremap_data;
 	struct msi_msg	msi_msg;
 	unsigned long	cpu_monitored_mask[0];
 };
@@ -129,6 +131,15 @@ extern void hardlockup_detector_hpet_stop(void);
 extern void hardlockup_detector_hpet_enable(unsigned int cpu);
 extern void hardlockup_detector_hpet_disable(unsigned int cpu);
 extern void hardlockup_detector_switch_to_perf(void);
+#ifdef CONFIG_IRQ_REMAP
+extern int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata);
+extern int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata);
+#else
+static inline int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
+{ return -ENODEV; }
+static inline int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata)
+{ return -ENODEV; }
+#endif /* CONFIG_IRQ_REMAP */
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index dd3bb664a188..ddc9be81a075 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -202,6 +202,7 @@ struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 	 */
 	temp = (u64)cfg << HPET_COUNTER_CLK_PERIOD_SHIFT;
 	hdata->ticks_per_second = hpet_get_ticks_per_sec(temp);
+	hdata->blockid = hpet_blockid;
 
 	return hdata;
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 2e61eaca7d7e..256466dd30cb 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -20,6 +20,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 #include <asm/msidef.h>
+#include <asm/hpet.h>
 
 #include "irq_remapping.h"
 
@@ -1516,3 +1517,51 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 
 	return ret;
 }
+
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
+{
+	u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
+	struct intel_ir_data *data;
+
+	data = (struct intel_ir_data *)hdata->intremap_data;
+	data->irte_entry.dest_id = IRTE_DEST(destid);
+	return modify_irte(&data->irq_2_iommu, &data->irte_entry);
+}
+
+int hld_hpet_intremap_alloc_irq(struct hpet_hld_data *hdata)
+{
+	struct intel_ir_data *data;
+	struct irq_alloc_info info;
+	struct intel_iommu *iommu;
+	struct irq_cfg irq_cfg;
+	int index;
+
+	iommu = map_hpet_to_ir(hdata->blockid);
+	if (!iommu)
+		return -ENODEV;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	down_read(&dmar_global_lock);
+	index =  alloc_irte(iommu, 0, &data->irq_2_iommu, 1);
+	up_read(&dmar_global_lock);
+	if (index < 0)
+		return index;
+
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.hpet_id = hdata->blockid;
+
+	/* Vector is not relevant if NMI is the delivery mode */
+	irq_cfg.vector = 0;
+	irq_cfg.delivery_mode = dest_NMI;
+	intel_irq_remapping_prepare_irte(data, &irq_cfg, &info, index, 0);
+
+	hdata->intremap_data = data;
+	memcpy(&hdata->msi_msg, &data->msi_entry, sizeof(hdata->msi_msg));
+
+	return 0;
+}
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_HPET */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
