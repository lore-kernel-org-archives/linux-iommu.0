Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379458;
	b=o77N4SNqNudcVfrazlbalBbEfmmWn4Vwx+oacenHr0mb51q49KUOr+Apkyu5YhPcSBaM
	 JO76QAe1HdryiKdHUIzvu7LXCD2D/am3yM6Z58d8LyhcjI40mu6kUn+hu4RGSXKilrjMj
	 IiGHCtS5K3BgCExkXWGpTyzIJXc4wFZFKaSXYJq37v58cW4ZDr38CEuAwx8cQQErkjLKl
	 L2iL5fMnISGDnrCC/fU8uO8c9qY05MUC46lmCOX/4HEeibcPZNJOzUudJyGxcz5gZZsby
	 uvsaZTtj2K3fzyDGBj0IwzoGm1hXlz5w9XFcUrVSl/cToN3hzPhImngfI6r9P2jsSKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379458;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H0/WzuSWW1o+eROnhz5sjhBt9GVk+7dFS4jmdziU0PQ=;
	b=N6gVk56PG1wRUrZvYDe6WH5QbzRZAn2kRcbSYfyt/lR359CvqgNu8CrVEZG8fZ0zWGrC
	 a1K3MRohAl4zdwxyvCf9Zpo8v0FbfdY7SasXQFlUrrwynStW3K0k/BCeaXOBK9Cn+HCoO
	 6HS3NUMY14rxVpuqACsDbPDPTwG9XByHaGHLJu49XQJ24ahzteSMJs6WXGHXYh26l7iuT
	 Jza4ywTesCcFPn6JApjKJkzQ/s1maIz0DOvl1JcAj+zukCHt2xeUdGIe7iuG3V+8zU2R4
	 sixLFDn/nKWZXSJPwg137KoOmfbJP+Fh8fclryqYPgEwP5gB6ziZE3hcnGZnzzVDIog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WU9lZ7pC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.54
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8A606A320;
	Wed, 11 Nov 2026 06:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E8A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WU9lZ7pC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0csOPkduUmTcKEqgtJ1UkGKt+QdvEq9lD87FAM78r0OWp+XNnmvYTzGEUkM19TMAFL65A9arXRsDFHIcEjfd/JnSThdymhMiknEagFJIWlwdTwZYcb3knvl9L9hHCsDkvg18jgnf4uh7nYp20dH/lyg99OWdUSX519Dtv+echtZ6gnXno4AvDQe3zngpwdlOfw6m9JNAra73CteuU7+F4i7UN+/etYV4qwY73HwrEb6QhnxyH+NrKAE0qmKR/16yQ0+4zdboZ2/2w1kySWrytKra8z9AFk1nK7Sn+c3ShwGsLKGr1oT/o8qgN80OpOhmuBNu4H6TI8PgXLU5Dfwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0/WzuSWW1o+eROnhz5sjhBt9GVk+7dFS4jmdziU0PQ=;
 b=H+h/zEsmdDqvYaih1wtvmoJdk4gx6Xzj1xRKOA7oTXuIxI6JVbAIlnztbefw9/Ckp4ZMS8silcof1XrGuPBIWNaLAKxDYoUoqA58uX8pkHnMqdNQUR97nUajKEqpM8YhcuMYwjNKM6G3Zc9CYm6rgnUGzZ3hv+GHhfVQkTQhsgtwY69HqIrmpeq0ygzg5XODLkxNSHBnfWpV2A/7zVeQUfB3IOwfXT1w9JX1vGZNHxH06Uk8pqlJ+ZN+rP0Xkz9xr5u7K/oAt1Gp4PyNXDWwykvy7QFLOV7PVVFesHbHOnHyL8bshYvxPg6krlDbDbi3R1ov1yxcOhfunxQIrOVSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0/WzuSWW1o+eROnhz5sjhBt9GVk+7dFS4jmdziU0PQ=;
 b=WU9lZ7pC6eZ49mExuRxbd4EFDS0Se8GD6rus4mjMa2xE7G8WiLj8XGyv4CuOG+CkDq+ccCmFToXwECQoA7AfR5wBFBFReI8nBp1I7GPbOwXGN0VDMtxQOwPNoQwl8HybJ52rvicXeEYrDWtehxcFOIXSlb6blepiEhqZgDo/HZU=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:44:10 +0000
Received: from MW1PEPF00018893.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::64) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 06:44:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018893.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:44:09 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:44:00 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Layton
	<jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter
	<kmehltretter@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v7 2/7] iommu/amd: KVM: SVM: Rename ga_log_intr to wakeup_intr in IOMMU interface
Date: Wed, 11 Nov 2026 12:12:37 +0530
Message-ID: <20261111064242.29336-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111064242.29336-1-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
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
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018893:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb751d3-047c-4990-cb2d-08df3fbf30ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|7416014|82310400026|261009223027099003|10067099003|261028144727099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|260925021311599003|260925021911599003|260925022911599003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0S/h8xJlYLezczcDRHk3Auov+ZbimZVpRAKP16YfEuDnShMTm1VzB8doL3iW8XKShX35lsQN7YOUq1eVJS3dU+znABUpKBviyncV+BW2JKrCHgfqJXB5359SdNC7yndRe073nD5MMpEvsOkqaDgq6S12kDLzFouSewCtoIGXlknfVcwzjqkXLBip/TyKte5dbscbYbpwpBa5c/tPt8Zno5MrY/de4y5wzdFZLmy0BFvFs0T5T67tmXANg7he1IX3sJ7fjiBxkrWOz9bzPquy6w3ApxyTEG3gVmm8jsecXZjJd11je8OblS0WODiS26hdc++R4Xghqu3ZeCKPhdqpRyhEl+Mbb2tASAyZaSrgSHtp/qEPAjpUtN7Mv+E97x/g1DEWHPiHPFwN9n69YVcHYHdOnOsPSrHe/Xu0WGcyLYvSdjz6Kc8BX6Am8jntz3pqR9FQJxvlaQ93RW5qTbTxS7onC9v/ea6u4m3qR4fwbCuetjcnVzOkb/baZj3X+Pf0N0jDtfBW1p07GgDPo/o7m8SlUgvdeNOglYNgBp90l26kqhtdn3gtd0n+vXBhyAuB3ZHX+CqOwW13kLiMz5H5Ptdh5DkmBx1ow/yRuBjqsAaGRoIOagEdlNAp4F4qfsX3oRla6MOk3fY5apygFbTyYcVjfs9cRVMmtg5v4hhajiZmVRC//0HOJE7XzzfJgHJaYVQmw5LduTfYF/9yisQrjge+narmyZb2XGu5LelKsM9LuXS5x5AbFaWGfMwtzhuR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(7416014)(82310400026)(261009223027099003)(10067099003)(261028144727099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZnCtoOK3H2Z+6as+tZ6KPo+Wamyq7YvifDzlT8XymB0JA7RLkAbWhCxSw/GhvsPABQEr2gIeFvKwTEDBkGJf7pWeAk/1l6tGGBKlXXWUtDK1eGLtrjh0fPpCxTTwgluC94BW+HWfc7AoHVA6mGWWD2cIdkwqD1uTC1CV4r3+tBAf9AwgQh23LBNcfn/QlvAxIPu6K9h0//Feur3qwBNQaY8XQIVz8sXgL1lay+7z60fvVVYtmzSU/tc8CO6Ff8SOxMZGp4vlMGq0QZ3lh+u67Fyf0B41F4B29/6XFqCNvWLrXP6gcw0G2HBFV/U/XnfeUmIjmGzfGMVs0DYtRHFh/zcOupCggEwwu3pdfYi+q93/lLv5fQMuwW85e3d8W+1krfgfEw0ZXAqtQ7B4SbFFt+8LYCpQGJzbWaZokwSXnCIkc9oRAqCA9HKpM/gwvDEA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:44:09.7404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb751d3-047c-4990-cb2d-08df3fbf30ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

When AVIC is enabled, device interrupts are posted into the guest virtual
APIC backing page regardless of vCPU running state. When the vCPU is not
running, KVM may additionally need the IOMMU to notify the host so the
vCPU can be woken, historically via the GA log mechanism.

The existing ga_log_intr name is tied to one specific hardware mechanism.
Guest APIC Physical Processor Interrupt (GAPPI) provides an alternative
host-notification path when the vCPU is not running, i.e., IRTE[IsRun] = 0.
The KVM-side intent is the same in both cases: request host wakeup
notification while the vCPU is blocked.

Rename ga_log_intr to wakeup_intr in the IOMMU API to describe KVM's
intent rather than a single hardware knob. The IOMMU driver still maps
wakeup_intr to IRTE[GALogIntr] in this patch; GAPPI support is added in
following patches.

Similarly rename the synthetic AVIC physical ID table shadow bit from
AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR to AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR.

No functional change is intended.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/include/asm/irq_remapping.h |  2 +-
 arch/x86/include/asm/svm.h           |  9 +++++----
 arch/x86/kvm/svm/avic.c              | 26 +++++++++++++-------------
 drivers/iommu/amd/iommu.c            | 16 ++++++++--------
 include/linux/amd-iommu.h            |  8 ++++----
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 263f4df429d8..789e3e154600 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -36,7 +36,7 @@ struct amd_iommu_pi_data {
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
 	int apicid;
-	bool ga_log_intr;
+	bool wakeup_intr;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 83fd49b26a4b..3f38fafec138 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -264,11 +264,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
 
 /*
- * GA_LOG_INTR is a synthetic flag that's never propagated to hardware-visible
- * tables.  GA_LOG_INTR is set if the vCPU needs device posted IRQs to generate
- * GA log interrupts to wake the vCPU (because it's blocking or about to block).
+ * WAKEUP_INTR is a synthetic flag that's never propagated to hardware-visible
+ * tables.  WAKEUP_INTR is set if the vCPU needs device posted IRQs to generate
+ * GA log/GAPPI interrupts to wake the vCPU (because it's blocking or about to
+ * block).
  */
-#define AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR		BIT_ULL(61)
+#define AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR		BIT_ULL(61)
 
 #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
 #define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	GENMASK_ULL(51, 12)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 5ac5ce4039a6..edbdb5d75062 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -963,7 +963,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
 			pi_data.apicid = -1;
-			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1002,15 +1002,15 @@ enum avic_vcpu_action {
 	 * No unique action is required to deal with a vCPU that stops/starts
 	 * running.  A vCPU that starts running by definition stops blocking as
 	 * well, and a vCPU that stops running can't have been blocking, i.e.
-	 * doesn't need to toggle GALogIntr.
+	 * doesn't need to toggle host wakeup notification.
 	 */
 	AVIC_START_RUNNING	= 0,
 	AVIC_STOP_RUNNING	= 0,
 
 	/*
-	 * When a vCPU starts blocking, KVM needs to set the GALogIntr flag
-	 * int all associated IRTEs so that KVM can wake the vCPU if an IRQ is
-	 * sent to the vCPU.
+	 * When a vCPU starts blocking, KVM needs to request host wakeup
+	 * notification in all associated IRTEs so that KVM can wake the vCPU
+	 * if an IRQ is sent to the vCPU.
 	 */
 	AVIC_START_BLOCKING	= BIT(1),
 };
@@ -1018,7 +1018,7 @@ enum avic_vcpu_action {
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 					    enum avic_vcpu_action action)
 {
-	bool ga_log_intr = (action & AVIC_START_BLOCKING);
+	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -1035,9 +1035,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
 		else if (apicid >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, ga_log_intr));
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
@@ -1073,7 +1073,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~(AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK |
-		   AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+		   AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
@@ -1134,7 +1134,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
-	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
 	/*
 	 * Keep the previous APIC ID in the entry so that a rogue doorbell from
@@ -1146,11 +1146,11 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	/*
-	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR in the table as
+	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR in the table as
 	 * it's a synthetic flag that usurps an unused should-be-zero bit.
 	 */
 	if (action & AVIC_START_BLOCKING)
-		entry |= AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+		entry |= AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 
 	svm->avic_physical_id_entry = entry;
 
@@ -1182,7 +1182,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
 		 * configured to generate GA Log Interrupts.
 		 */
-		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR))))
+		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26afedfbf0bc..fcf23ed4ce43 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4054,7 +4054,7 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 };
 
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
-				  bool ga_log_intr)
+				  bool wakeup_intr)
 {
 	if (apicid >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -4065,7 +4065,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
+		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
 	}
 }
 
@@ -4076,7 +4076,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is associated with a pCPU (@apicid >= 0), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the
  * vCPU isn't associated with a pCPU (@apicid < 0), clear IsRun and set/clear
- * GALogIntr based on input from the caller (e.g. KVM only requests GALogIntr
+ * GALogIntr based on input from the caller (e.g. KVM only requests wakeup_intr
  * when the vCPU is blocking and requires a notification wake event).  I.e.
  * treat vCPUs that are associated with a pCPU as running.  This API is
  * intended to be used when a vCPU is scheduled in/out (or stops running for
@@ -4087,7 +4087,7 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4101,14 +4101,14 @@ int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
+int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4131,7 +4131,7 @@ int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, wakeup_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4203,7 +4203,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
 			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
-							    pi_data->ga_log_intr);
+							    pi_data->wakeup_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index a467e3e90acc..7253456331de 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr);
-extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr);
+extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr);
+extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -42,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(void *data, int apicid, bool ga_log_intr)
+static inline int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool ga_log_intr)
+static inline int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr)
 {
 	return 0;
 }
-- 
2.34.1

