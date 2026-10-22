Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678122;
	b=keiau7cBlIz+RK7+wPHD0E79eCfQWQSm/BAWLgXhrHnIZ1WTd6j3/rbzOYaajlL4rwGD
	 0bm+1gpZAWN3Qf/9Hn9xBQi1Ebqsttzju1uWu0msLV5sUrIER7jwypqB6XClX4QB0BXIZ
	 pLI4ed8iMg8ekrWPASSCHHhFYB9wvp86j/ml6AkHMMFCISSZS99Vw7kKvxB2s5DQQr+xr
	 f7IGTdQqDe9+dG5vSnGOG7cTX5M70FZ9TcLXp4mf7rorQITbxwINk6/T5wBsv+YFwFBx1
	 /2Dr4CNiiMFn1uedisQP0sgJFeFHGXEnunXvLYgJclRQUqWDiheGTJw6+ho/0c+sXCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678122;
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
	bh=3dy8u9jL9js/YF14E7Oazq/mSQzPmCRKMdlerODHTOs=;
	b=mjgGVC8uSxQtmeinNRtfj3U3PJQp9oajeJvvE+bb3hbZxZ/Lzzl/ZLei+rV4lCiUScYZ
	 dLW/8VpxNe0LctXuBYb1XjJrZ/P1tX44UteXL1Fx2qNsoIlxVsMZdw1jZndk6F1yJoQW0
	 EVUf1ikoqcWIzd0sQvCV8y7bcVoKq571LW7/D1hnxRSpKWUbG7EnZabjEOkWIhRoFZglS
	 kKbPK8+E5ftHoij5EjRebc5o/oq8U2BS3PM8JyTBLngGmsjwNnxWVxSf/ZAGD7RRzmKj1
	 BlB6itAoBFotRaZSs5BQjnI/+2tyIs5FQSxKFIAqvGkKmickpSdWpDDV3fhPOmS0g3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XuOhdrMd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.14
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC81606A319;
	Thu, 22 Oct 2026 14:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC81606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XuOhdrMd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S60WwtCEcKmKRKvocLpO2gZB/XvPN4CyQ3b398eJ7Pk5zAdnN9E5+4clVkXCaOGXbauGKzCwxKNexIxGiS2c5wtHiqx+lrrCGVyqFKZLhnoc/bae/WiHlStyTIr95SGhlANlq2XvGkAyfYktmC/8Xb+fHOZ7go9ILBUa/EQPXsyGZHxxGQ6DJkKzIuw2x8UmGTbLoIeRZfjac1XywjjIaQHOFXg9GLm7BkF913EM3FdE4UN1E9U/OOjIgWVvh0okyM6l6LDN/T3IYmBnjVJAPBr+CX9551XRSLsu9JButxmX975YZnWuQpZCe+41XFwW7X62P99Up9cqUOLFt6acnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dy8u9jL9js/YF14E7Oazq/mSQzPmCRKMdlerODHTOs=;
 b=oolYO9SqUbtKIeazPKkAxWoqJ/jGl4KumaBdVEV3I+MRddF1atsBCtokAxWhhyk38MXzijmPnebePhxlwtTkQLNgdX+fE+Aah82fbh/3FoOnulbMCd4unJ/2PZe2rUxY02zZt7edmT58PdEbHNCSmIsZc+bYj/UThnzXcCll1GZiTnmaOWMh2z2WVHSLM2Ozb0oFw+eCuDpkygcp0lwXyyRDLDAZasV7HWc9qp1fnkb5VAY4Y5vbP3Y7GAle8HSrNYi5ab2l00G+5kIeObjJZiv6y2D/R/M2MqNY5AQ9tn1gFXa9EbWWUyFZ5bBh1P5saByQ2cBedVo0pu36tAuonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dy8u9jL9js/YF14E7Oazq/mSQzPmCRKMdlerODHTOs=;
 b=XuOhdrMdrUSY/OmmoChwwFxJXsCM9xUIksl3VasMnhAp7AtzRrYZzPZmGwLNRjJ1iWC+2WxCN1hk7spDC9mWV36DAr4u0o/1s/5oaOr3IR6hb9tD6M+6AE/Z4OgoVo1nn+GOe7iBOGVFW9kgiIb3EGxTJDit4XbjTOS/+UQBpJg=
Received: from DS7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:8:54::7) by
 DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Thu, 22 Oct 2026 14:08:32 +0000
Received: from CY7PEPF000000F5.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::a3) by DS7PR06CA0039.outlook.office365.com
 (2603:10b6:8:54::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 14:08:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F5.mail.protection.outlook.com (10.167.247.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:08:31 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:08:20 -0500
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
Subject: [PATCH v6 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
Date: Thu, 22 Oct 2026 19:34:22 +0530
Message-ID: <20261022140425.27465-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022140425.27465-1-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F5:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4ef04d-391b-46ee-3ec7-08df3045f3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|376014|36860700016|13003099007|921020|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zJY5YUWcOcsemp5V5DnxgGqY7DpEC2BCjOkdsvTWsjz7pxIsrkOcgy0stg4qd71kF41LJakGeCF8BgJ81XAS5VnpM2y1+AOrk9UJ2bBnkOBhDQkYLMDAACRpd/T700Vc1MxY4pYvW27FeFJk7XEHcmRFIoj5xGv8/QADlpzY2d3Pu6E2uz2aVGmKkHeprVHshG1ggj+HKMu9PkRpeZh0eXaVh5+DxFgyijsBwPYoJjQBb5CPE3IyrICUs+wh+AgqscF2T/uLqEa3ebavVTd0Ak39sjWlNLPdQ9Pqc+6elh1kiHP4gEA6gE8l30ZP4pHvP1ZE0C1oqITr/XP2vLFd5e8WBJ5dUzOCNtinxx69wuK5cXAGNdTZ7VpAdu9sXZQQHqc9r5Gj6FxSDv6pm+07o1n4X5h02jkFnzbyab8pVQQGSkhuVtmxo6os2wKQts055UpjV1N3nGJMYGJYmdcNe0WpbYlj4gzI0CzYmuDVG3x88OceFVTV35BTSdA02wNYrkIecs30pKu+PbKLsIfwVWrEILF/VRCE6oisF4UiNzKGko1xjgabfPhvYrtrceCZxWv1lLz2TKr0RlzY8INBWbkTrwm+qqecBllA1flh0PGZfmVSOBfZIuK//PKcmZMOHNXyROtyh+V34eruY/lZP7wN9J3PtPbEpqk3eQn0B3dRK3WrXkLSF1fC+X8eWx6UDfGpx3jidvkf7D0QE0vwxVb/BA3o2rVFbNwRKvqXLYvHqKVCOnHfDgzXgr14IJ83
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HvrE56+RamiNz4ZmgbX4/qnPTRh2PTqXaAGLhRU3ZqURMNVj9yGkVbjS9SSyGpb+Dv2t9T6YVxOdLxem/SYhxBMKm9q0kBXDb6OblSyvPZZYlwm8QeJnWBHWgTPksrbLM5UQC1hsVY8KSg4PO3abdEtbbV3ySTa7aO7KG+uWy5wbYbYMJu7o+/abAvbA7mVTDocFsFO5n/efEezQQkNA/Co1YCclgIO8QJGSegeAX+s3KoI/MtC3+s0mxsxaLSYBEdYtLSuYmE+M3b9dHg50fbflkILaU5kw/EFY8doqM7mIBHmkR99HQF6oRtsTbPj2dqKOjFbw0DR85/YzGJj0KQT4LzeXbyr+rPUyvEIUiRsNcu4cuWC2ucVIqs+JOyeAx+5+JK48//imCKL+F3FIEewh3C09ZMMK4GwSmxtezVouAuAmK7TZkg3htlyHpIdu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:08:31.1681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4ef04d-391b-46ee-3ec7-08df3045f3e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658

Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
GA log for notifying the host when a device interrupt targets a
non-running vCPU (IRTE[IsRun] = 0). Per the AMD IOMMU specification [1]
(section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
interrupt to the CPU described by IRTE[Destination], using
IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
backing page IRR as usual.

The AMD IOMMU also allows suppressing GAPPI interrupts using the
IRTE[GAPPIDis] bit when the GAPPIDisSup feature is available in
extended feature register 2. The AMD IOMMU driver sets this bit when
the wakeup_intr flag is not set by KVM.

Note: amd_iommu_gappi is currently false; a later patch enables it via
the kernel command line.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++-
 drivers/iommu/amd/init.c            |  5 +++++
 drivers/iommu/amd/iommu.c           | 31 +++++++++++++++++++----------
 include/linux/amd-iommu.h           |  6 ++++++
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..b89a2b3df0a4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -97,6 +97,7 @@
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+#define FEATURE_GAPPIDISSUP	BIT_ULL(4)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -982,7 +983,8 @@ union irte_ga_lo {
 		    no_fault	: 1,
 		    /* ------ */
 		    ga_log_intr	: 1,
-		    rsvd1	: 3,
+		    rsvd1	: 2,
+		    gappi_dis	: 1,
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..78e3c14dc1c2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,11 @@ u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+#ifdef CONFIG_IRQ_REMAP
+bool amd_iommu_gappi;
+EXPORT_SYMBOL(amd_iommu_gappi);
+#endif
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 099df57384e9..5bf4621d9be5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4003,9 +4003,20 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
+		entry->lo.fields_vapic.gappi_dis = false;
 	} else {
-		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		if (amd_iommu_gappi) {
+			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
+						check_feature2(FEATURE_GAPPIDISSUP);
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(apicid);
+			entry->hi.fields.destination =
+						APICID_TO_IRTE_DEST_HI(apicid);
+		} else {
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		}
 	}
 }
 
@@ -4016,15 +4027,15 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is scheduled to run on pCPU (@is_running = 1), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr. If the
  * vCPU is scheduled out (@is_running = 0), clear IsRun and set/clear GALogIntr
- * based on input from the caller (e.g. KVM only requests wakeup_intr when the
- * vCPU is blocking and requires a notification wake event). This API is
- * intended to be used when a vCPU is scheduled in/out (or stops running for
- * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
- * Destination.
+ * and GAPPIDis based on input from the caller (e.g. KVM only requests
+ * wakeup_intr when the vCPU is blocking and requires a notification wake
+ * event). This API is intended to be used when a vCPU is scheduled in/out (or
+ * stops running for any reason), to do a fast update of IsRun, GALogIntr,
+ * GAPPIDis and (conditionally) Destination.
  *
- * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
- * and thus don't require an invalidation to ensure the IOMMU consumes fresh
- * information.
+ * Per the IOMMU spec, the Destination, IsRun, GATag and GAPPIDis fields are
+ * not cached and thus don't require an invalidation to ensure the IOMMU
+ * consumes fresh information.
  */
 int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index e07dc8efac32..68a42427fdf9 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -35,6 +35,9 @@ extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
 extern int amd_iommu_activate_guest_mode(void *data, int apicid);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
+/* IOMMU AVIC Flag */
+extern bool amd_iommu_gappi;
+
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 static inline int
@@ -58,6 +61,9 @@ static inline int amd_iommu_deactivate_guest_mode(void *data)
 {
 	return 0;
 }
+
+#define amd_iommu_gappi false
+
 #endif /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 int amd_iommu_get_num_iommus(void);
-- 
2.34.1

