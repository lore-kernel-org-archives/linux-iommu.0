Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379434;
	b=jn5/DsgeRmjFqFHkS7ly9cMAzxzpOckqUMoLZmXgIqMMU9Ee4DeXSKeQMHDnYcw63+pY
	 eKLQ9pCC0L/rd7CRJCyd8rvG5uHOq89Ui7D2AbT8HeMCqvRDVWSxGkriB0YqIL13wPw8n
	 7sVe2xlfht9fUmGWTL/VtZs5LZkybpsJSueOZaYy719FcaFfaa9k20NnVCAmnoNk7wO8u
	 gJ5GEtiQIXWaAtM6aaVjsMm6yz8EYieiRP3yKEbzkIH4kenI8pjDVaryUpHwAlcipzC9k
	 WL5Dpdl8vO+K1ZFnFPZZLKs7oBWeAuBlL+sRhSBDMjVDx6MSBQIJa7g2IPywMj6f50A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379434;
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
	bh=WiT+BoQEQ1NR124l4s01LG7asBm9+nUiddyWFSOJ7o8=;
	b=oLsKoUxQ0zrIlf2sHfvKFFIswQQnW1KIywK3Kc5fduZmLojfKbOcERB9a9HVMumYTNZU
	 4UOVi4WpxD1BlP4yP1LKzpjBHLp+9b1GMdAhVJj5g1Vx2bDfZeXQ+Q2f8RKc7j8F6q5xK
	 lfRYUYD+vAa4h2PC93EBuqvwB8bqTPMudWamxeXX0aHWgbmITJsoLfvB9WP0OmvdkX83Y
	 sJ7wXXfCKjG9x9mf93MZL47Vz5nSuutSFeUu6PgQZ4DeZ733hTXQfNkpr3uAeqnLbEKn3
	 4yzami1u6W+2UGD+1lXYYFW86YZmC/WSRK/X9q0KIylKvh3nxG5rvkHOLaEyg2OTBLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dYXHfe9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9C606A320;
	Wed, 11 Nov 2026 06:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C9C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dYXHfe9t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtT0rPZ97yYglJSwx/nEpkKpLb/V1m8n2zwbuvtF02Rw4tsiN52ZYRdFraPTn6JNWJO6fBNbU7kZW44NFfeGhN0zaXC8TrXuCbSi5b0IG2YN8t0aCqRQ+JDKiNTB54rbJ9pCNq9MYyCn2pEvafAfoYTUsuO6c+KHm0GrC+ZxML52CyR/W8K5w+5mvQKULxRvQQSjIBKPQBETFothug5+j6bh52RAGJc5ZVWeXOkMwsm01kT+8vVBH97S3Ub1k2Rm05gZX74LjSoDG/6hXmKodU5uv4F0s4gge7/gxzMXYZL48j8Htg1TBRaKggKIqsdfLHcVen0quShcuO573MZjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiT+BoQEQ1NR124l4s01LG7asBm9+nUiddyWFSOJ7o8=;
 b=l4sjcfJX1rkZ31nHwu0K05i6Mp60Q8i0Dc3ZwPsATXD8Ma29E0tNt5ES38CnbaC7axs1aJnxzpMoUnFFYK281Ed7PyXGlcZkIr1vMkU25ddYBsAjbdRnyZT5NFFlARPN/CIJvylQapl2QCHBNCUB0fboKx8ByAaw1c7aRip3yiiRnaiaD6A7wx5kKGL4impIqcgNaEIhOHDttFklEMGzU427aiZj8f1yc53QARvqBqUVoGH1fugP4xs1pLyJo9nL8i5jFjBc0EiLlf4W0fAT7RPzy0pJRmkSCFP9GXdaGLoY3ifeszkRiSmbLpc6vZ7L/LartzfVicYoyqVZhgCcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiT+BoQEQ1NR124l4s01LG7asBm9+nUiddyWFSOJ7o8=;
 b=dYXHfe9tRZ/s6cPVkUecByIqe75YZH1DihKlCLoXELRjZdEmJv/G3cj6xw1C4NCNNDPIjY0sXXhI465U17zOG6k5aKo+eHrB+/O/urIxI5xSv51j7Ec3LsW/fU9C6U6GxmJPc7U1IRVUMzufpjAIytqfQE9oRAfbWm5lo892VH4=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:43:48 +0000
Received: from MW1PEPF0001888D.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 06:43:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888D.mail.protection.outlook.com (10.167.249.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:43:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:43:38 -0600
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
Subject: [PATCH v7 1/7] iommu/amd: KVM: SVM: Rename cpu to apicid in IOMMU interface
Date: Wed, 11 Nov 2026 12:12:36 +0530
Message-ID: <20261111064242.29336-2-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888D:EE_|BL4PR12MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd58a30-b28b-4c52-760b-08df3fbf2387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|921020|10067099003|261026121527099003|11063799006|261026140227099003|56012099006|261102123227099003|261102130727099003|261009223027099003|261022075727099003|261021123027099003|261028144727099003|261022105027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z2U8zc3smLeUZaU43LowEpd3q+iCOJsWt0YAHavQIAnOjyOTLp/LMMC0c939kLRGEJiSpSSqZ57o8yfQvegGhFdKvLlUnBwm2DL4QxIPArZENJuj3EuoJVUWC0/cpFCYwu0pk+8+GeGC28QtvXfUpKRqXBbUEUXw5WcnzlfQfZPqSFQvH8jIfgCltwIo1UlZB7yMZMu12haCePFg2bbtag0hFL9BaOlk7wUWAMYGcBscpfG+JBV4A75dhH+KNfD6YgqayEzy18kwPIphPGpnrv2F+oHNRyNFbwZ8BORC06mm/NISiBCwzWCcG1nQsrzTBTs3lyMHNMz4Qb8vxmGTWpkei6aBTI5/bOraGUs5venbt+CdQuelezBk9xmK/fkQbyqbPB60eOK5zsivvULAjxErrm39/APQlGfbUs6Sqk/BgDWFpGREgMXrADpSnINYd6tdsyGi3+9WtnUj+mgNIJpjecTuQh1c9OzZPuAqMSa0bSto7HeTty4dmqFBptjMRyOAiqG0uIhVHJhtdNA/bAQlZrQXC07lqa6kCzyfozaWidkUbDSB4pQc1iQKtgz5n+OO6Y17OzuxrN3rcbdn5XJ5V2BPU8pUtfjW4/7Iqh/Ijk7363jlXnfbQwmif1GfMlFWaNqpRNs/FgRAT6/cf0sI81tBh+CDx0BVuj2F6D5kEWDuHyY3TBTJ7yW09hDMLQuPIoqCDTXMpVRFX/MqUeptYk5YahQ182GayP316zQuW02mAWe2Ep4zzVnvJ1ZW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(261026121527099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261102130727099003)(261009223027099003)(261022075727099003)(261021123027099003)(261028144727099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7KiaIXHqZn0ScyGQYU8/0otE8iddp9fob30M2ErzYMkNRdTZbE5gORTk5D+SKAHclwfg4tgMZ4rL5l6EU2yjjfVpUNStZMfBK+1nQJZvyFI2HwKuLSjRgkNg2cjVx9aZetmWOVbUWsAIDjajmQgBf8wEgB8OirfIL2C0mGXHzR1sFKWwlEFgCGDQixmtT3VYu/aTsCrEVI1tnaHSZfMjHQdbo3NPwlJR0s6agakVxv54VD580IYDbcPQY2uV+1Nb4Mb2ZymEFphE+W/dhmNt6Ew7jVryvvb3GU6Xzyo1YMdi9lKzVmk+tcdbYyWhgpB9Y3PUhtKeJX3pwaP9IYQ9osyRPvEqI7Hj6HqRhvDwEXEToJ4MpttejVDJ2cfRzmxuPWW8tFhLjfFq8paojm50GE+Q0E2BX/8LAlpjVC8VoQXKawwpqqM4rwYycWSfTOxF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:43:47.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd58a30-b28b-4c52-760b-08df3fbf2387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534

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
index 41ee4ad1dcf8..26afedfbf0bc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4053,14 +4053,14 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
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
@@ -4073,20 +4073,21 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
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
@@ -4100,14 +4101,14 @@ int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
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
@@ -4130,7 +4131,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
+	__amd_iommu_update_ga(entry, apicid, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -4201,7 +4202,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->apicid,
 							    pi_data->ga_log_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 5c9dcf720f84..a467e3e90acc 100644
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
-- 
2.34.1

