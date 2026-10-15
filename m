Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C703EF0BE;
	Thu, 15 Oct 2026 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046970; cv=fail; b=gVUBHSMLWThZ4mdoffxNL3mxs/EoNNEsJOhjVberJzsqTv/+OOQphKZ01871/Hbay8X5NjHb+eF5VVJK9idlBk7rIdobLHNO2+nZ+lBxYY7atkvrNkUYWZsNk2uZmbFA2z429kcU84DXPbRE9xyEpr2bNLtAvQyLXn1B4OB6C4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046970; c=relaxed/simple;
	bh=a2aIWJwWAkePaedAJ6hr+y9p+XElMn/KGhThhxO+C9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McL2f3UHe9piasGo4gS8C1raZ4AkW7aW9oMMfHO14If6hHBa0g0In26++RlWjvFXkEMP+eKnNHWzayAUo9D0WyIdp6V693M/Y6dn8eduKH64YhAmiHnlpskjYD2EPOipENJJmjxkx9vBw4ckY9HOhXoU2gBz6x2NU5EPTqE99DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tbuBjoNh; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tbuBjoNh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts0iQODKqC4N/1NHornndkChmlVRQH73Br6zg0EswGiB7aLPIb972pIcJu1B/zLq3vAUttlM5eFQ+48eahSi9rYZiyp4vTZ1YJ0ql3Vzk1rhmN8LZnBT7JcqY777uyL78cLPVr5n58Qjzc0XLz5QhqMLyDTPLBRQmQRJD2bFWpXBnGPD6i+JYDQLMqR3MvlGl0YdruTTIgsTfPvjz5ASyX1RJGpXS1AkiOCSi+4zo1DrMTDiZZDT+5BB5zxmiKF/oltJbg9o1GeQMNpySc+hO/2kPjUyOOu9CciPvHg97Czfd6Q9QgnUnk+/uOxhEjAKZp1WAnv6nV3LYGKZ0CD5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYRsVr/nlKF96mKikhwg6KyU5DHIccFCaikhblsrUJg=;
 b=uJadsIHfAm7hrHOR9tHNXjEjRJNkkSO42o5d5qdK5oNEoKizJAd0DRDY+LVXGBk8jWIaR9j/PPk0Spu3HvgCyvH0XToRllPaSY1QfWw0h0zWuvd1naETAImSWTf9W/BJi1tbVG/t1roZw4WOxOO1G3rltNJhehNiVOwe5xO3/KR65ygQjdn7uSm+Q2tnE4Sn78MctP5NJCl9ZkhcCW/ibF80gosfVbLUEXgjOA9/93n33rAKjt6w2r9xq2CsI4wOkg2d6G+RAo6V346qOjQSBf5Tx+dFPJ4UFfwucACoV+M82NzxCRlL207GE9SZ90zck+P6AfHGISG8+b7NVhLdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYRsVr/nlKF96mKikhwg6KyU5DHIccFCaikhblsrUJg=;
 b=tbuBjoNhCfwE0Dv+hJgrgthGeI3xIWN5gdLUKe5Yv+7Uf3+HwO7NyjiJniFC62aWztWQGqpxy917eBuSeZRivNFv0yJizE6BDZ4JybRz55yb4XgQ3v9EMJ/3C4NdqKEz3fxile/a/hmiXAtklrPkqtaOZLHxVC88joEETGrQYfs=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 06:47:17 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:610:58:cafe::4c) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:47:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:47:17 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:47:02 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v5 1/7] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
Date: Thu, 15 Oct 2026 12:15:09 +0530
Message-ID: <20261015064515.10700-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015064515.10700-1-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 00222377-2332-434d-73da-08df2a882771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|11063799006|921020|18002099003|22082099003|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	LTXSlMFADEl+Se6KxCHDaSBMSbdQgTO6stPEaGpbG9up1URzbf2CME4QLe24B3QdiX2zLRzuifZOzDz1hosWjgwueaFKjRmbJ4G8GS/db33sql31Devn7J+pr5G2EHWtzvol5tNdpal7iR2PNC5AvwB8Nm4l6cwg+SykGhvzkkxogG5+fJ/iylnIPuciCHeIPlgBVdJmFeH8XXkWOy2YV04wGjlV5VVUe9HebiR15RmCFHilf22J1rLyybBIiyXVVl/9jNlFN0ZMORjxlcYZc6LOg1xq9c8qE3sfnqCLfBz6SmVhqqO+b2cbx0vuR8r2muKun6BYhRlMJjBXJb7Rmk3ieeN18aJOlGkQqlG45vXpGWb0goO9f5hgGcgY0jdd6v8gEoh9b93RI3pbCKErBPH+gSZ/P+Mtd7oCGBv9zl3RDBSjoUxlQTAvTLF7NBnMp7MkvdS7hQ/Fn+q2cjcicqfxABcfslhzfJ0kYYD2WhigZz9HeF+CJo/hSl8OA5tG1fPlapQyUQy0Euznl9sfdw82Ynbaaq8zYdv3v56rVjJjp0gL1k3kOxyMTDHwNOXmvWMoDbpUFZR9B87NZydg6Aw+38cNBBm14ZjeB+kGvVWbU8WCuLuQYOabMnFy6WOXaszrZ1pzfeVxhjSIFRGmnFMqh5MGMqvZHv23tQzBZ7f1u9H9O7Wulr3rZEbd43Kiwe3IfdgLZKN46I1/8Rt+f0FAmi+uZcSp9Y/nwbuEJ84Tlr6LeRbVFAkmQwLDJulX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(921020)(18002099003)(22082099003)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ScQxuNay7qDglK3nSZzMB8NQ9NVh+QgDRmRRQqa+2i+J2h3DbV9D4Ca8/083p1TjC5Es8XG5hRxu8CEXF5ihz+A5/xh5Pxmlc36Reo7tVg0ueFq1GwWxksVp4mkfbCn4aVvqHY0q/0bOmCBb4ZpmL2/+Lx3rJhlJTVEcyPeERH6g+e3xo+bEouedVdLMVee6DTHvefRTJ84uyV37P7qTypZhBFgd80ASsJThAnH94hWWgVhmKd7I89gKv7Vo3Yh/Bht20QvO+5yb0YPMTXtNXvnGYpbsDaDy9gRqvZy2RSRmEsRx72iV+rxo5tnB7XO02rsA8xftB68bivpe077k2GqIbbref1+T5QzshVbz8EyG12CBb4JhW6df70eBu2RHwS+Vi9l+L055v0/Af3UZFo+RC6UTmRkTk9FsZ0E0lTE+MxZ/z6MkxRULOK3O2zHd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:47:17.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00222377-2332-434d-73da-08df2a882771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

The cpu field passed from SVM to the AMD IOMMU driver does not hold a
linux CPU number. It carries the host physical APIC ID used to program
the IRTE Destination field when the target vCPU is running
(IRTE[IsRun] = 1).

Rename the field to apicid everywhere in the IOMMU interface so the
name matches the hardware semantics.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  2 +-
 arch/x86/kvm/svm/avic.c              | 12 +++++-----
 drivers/iommu/amd/iommu.c            | 35 ++++++++++++++--------------
 include/linux/amd-iommu.h            |  8 +++----
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 37b94f484ef3..263f4df429d8 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,7 +35,7 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
-	int cpu;
+	int apicid;
 	bool ga_log_intr;
 	bool is_guest_mode;
 	void *ir_data;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 96ca39c0045f..5ac5ce4039a6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -960,9 +960,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
-			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
-			pi_data.cpu = -1;
+			pi_data.apicid = -1;
 			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
 		}
 
@@ -1015,7 +1015,7 @@ enum avic_vcpu_action {
 	AVIC_START_BLOCKING	= BIT(1),
 };
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
 	bool ga_log_intr = (action & AVIC_START_BLOCKING);
@@ -1035,9 +1035,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, cpu, ga_log_intr));
-		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, ga_log_intr));
+		else if (apicid >= 0)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, ga_log_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..aa9848d57f6b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3993,14 +3993,14 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
+static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 				  bool ga_log_intr)
 {
-	if (cpu >= 0) {
+	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
-					APICID_TO_IRTE_DEST_LO(cpu);
+					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
-					APICID_TO_IRTE_DEST_HI(cpu);
+					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
@@ -4013,20 +4013,21 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
  * Update the pCPU information for an IRTE that is configured to post IRQs to
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
- * If the vCPU is associated with a pCPU (@cpu >= 0), configure the Destination
- * with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the vCPU isn't
- * associated with a pCPU (@cpu < 0), clear IsRun and set/clear GALogIntr based
- * on input from the caller (e.g. KVM only requests GALogIntr when the vCPU is
- * blocking and requires a notification wake event).  I.e. treat vCPUs that are
- * associated with a pCPU as running.  This API is intended to be used when a
- * vCPU is scheduled in/out (or stops running for any reason), to do a fast
- * update of IsRun, GALogIntr, and (conditionally) Destination.
+ * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
+ * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
+ * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
+ * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * when the vCPU is blocking and requires a notification wake event).  I.e.
+ * treat vCPUs that are associated with a pCPU as running.  This API is
+ * intended to be used when a vCPU is scheduled in/out (or stops running for
+ * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
+ * Destination.
  *
  * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4040,14 +4041,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4070,7 +4071,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4141,7 +4142,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
 							    pi_data->ga_log_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a..2c6232aefafa 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 {
 	return 0;
 }

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.34.1

