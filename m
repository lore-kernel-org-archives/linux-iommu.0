Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FD37267E;
	Fri, 21 Aug 2026 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291912; cv=fail; b=YCEvPsrwNT7L0zsdPir8YxioLlUzEgmfW7SchLHUv1Qyq5xSh7u/hJniSh30dVTc1On9sWNEdiWdOezhap1K5fsZb45JJm2+Ct1WpFefkVeyDVoCl0+uvMoGGDnUoqVFphsZGh4kavV8nttxuF/XuP9YitCvumJsDs3+IzIQRDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291912; c=relaxed/simple;
	bh=XSRE+FhNWFs6bh8bAyjF0fA4zSS90ohK0MLKWQxlBZY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff3ZJuYm0AgsP7q/CYwM3NaxMhFYcfFfIFidhCC2rULWDpxwL6bHipNA9BTDR+eF0WnjkTrc54ORDgVf32v9JiyZy1t5T+G3J6iEr5rxWUar++/pOJ9b3FM7cBZfaK0CYwJplPpkVsvCdNmiIkVIj60oKi6hV/j/u0vpw7L5SFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j+xINJIt; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j+xINJIt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqDPL5eL2Rig2/N+16cNB1tZqIe9jnPNPGdf7lcYRwPfhoBROYRiNCKg2gmsdATmsgsH415JMXWinDyFcZNKZEJSrkJaxuIUmvwQzw+0V6X3jlJWzMvcHV18+zfm1H+X5M4dIQlcnZafUqYXkmBxlxYNNv+MdAoN2zKqGg5h1Jv8yIkvuoqKmEiM+NmCrA/u+JW6eXwcwA4i1NLGu+wPQVhuyDjrtp/2ms0LVRTS73jJKgqiog1gE911N0Ggl+Xfj3XsbEEf8qTUReE3r/xUcbQg+W4gag8dwFJUqNU8R9u8xEtQKynoqGa94s8sjnC6D2Pn1kZ/wXObI6OoFMc3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQYAKQJZf5ObBluTB/J1JBik1QRa/DCQy2D96SdIoRw=;
 b=hFBssGG0y5I7TZfDQu/OFWcwlcME1nDX/ZJDrp8qY6ktCfEy4QGIPWqUQRf5+Fo1TMIWDUTW77rthLJ9sqX9QwYmzNd0iEhMr6uQwWkV9v3OwQ9YKr9BAXFiWK7uRwrPVIkLucg3LCzANZD64dXyPlnJzlEL2poaSxYpdgNkETNdzE+mEYDrLsBdo/lZiLjFNk2rv3EELWr5/lhQy4YMUW50h//AeA31ruIJXYviyy3ZDxnq8qelWNGwLlNLO/YejqABr89HQwEb7iUMwsIssjmARycY6HFldiCvDJ7vjzfZXxfgfE4TuvOstpKVX3OIYY8/XSbm2DtHrs9Pguhh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQYAKQJZf5ObBluTB/J1JBik1QRa/DCQy2D96SdIoRw=;
 b=j+xINJItLMWr/nyClx4PIu0QQilCof3ijD5bd3JTbBM6mp3YNrdQf2n3VVu+JjMtYzP+eGpF3PpS0TQCpZsg8iWhRdiawmDbuYjMQXcttQhy1JgvhpEQdNoYsa8o7mW4d3S8GWhXUBgRjSg2uT8UKKSo5Io76Pd/AIMnKoNs9qM=
Received: from SN7PR04CA0028.namprd04.prod.outlook.com (2603:10b6:806:f2::33)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 05:58:24 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::31) by SN7PR04CA0028.outlook.office365.com
 (2603:10b6:806:f2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 05:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 05:58:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 00:58:15 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
	<leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Biggers" <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kiryl Shutsemau
	<kas@kernel.org>, Li RongQing <lirongqing@baidu.com>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v4 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
Date: Fri, 21 Aug 2026 11:26:08 +0530
Message-ID: <20260821055611.27138-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821055611.27138-1-sarunkod@amd.com>
References: <20260821055611.27138-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7ec9b3-3b6d-4dff-74fe-08deff49362d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|13003099007|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	mjEZYLFSwpfOoN/+FqF2AqWT10/RTYH69SICPYOs4/MGtjhGtzZxRMvMw/diYoYpl+tUOnjq6WEUR1zbFKu5MNgMy/a9SfddZydWbkD5i3xIlq9M2U57pLdymu0ih4tpuOucNNET/6E3MVIRBrGsJIjqgT5UkIT24IUseN+qjwHbtpT91IUyVBPn6iDkSyW03qKtYFQuTkQb6zVVtCMVBoheK/lU5koGTCmwY1H+/W47BzmLxKtbJQZM8uQ2J0cP/uit/yE6OGz+OKoOEXEFY8NrHe94fk8idYYH28t4BQkZjC24GTEmO+G5C7kgDGtemT1rA9fnzFLd8brBcsUgAoDtcTunq8/h/fzPSsH5WwauMzdiTGUUbksg6GTbGsP2cuVe5BK2WmOqRdJmtfSDZ09gONXQ+hJii6Era1fH/+k4Y1HjOohEJUD8VHQxDJOBKq9rfB34PwlFb/9xXHnSidgy3P7vNgALCtmsfy1kFjgHZbOUhSr3DhdL9xypwcoGwJFhXCVJGXNUHV20iqKk6qhe91U47S3jgn7kPHpe8F7cJMao0E4Fr+w/1ELif2p+JjPOPbY9FmTQ1JVicoiE56UvQXCyNMxCteHWcEp823ZGUy9qWcM+hoQwQzZ7shJhVNfz+xVuJWxGI3Hth+EWIeRA1Hy3/bf/glsD1IBDesJK7KBBJJt69qK266zmdmDRBQqr4gXOQl1H7T4M861qWZsCN0YN7EhWoHJZl9N3lpYgrbjf1qi7yC2KLlEo88zf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LRLc7ZybUwP63EVmjo4H6aoKbuTwJ5qwY6jsDp/VSwhIs4OCi1JEMA5qU5EOmSjzrvLaUX6TzxpLDWHGmfxFmaUlSOGMOrl7eZNY74s3o0nGwv4QNoKl9FqfK5+6GaBwY6UXJ5pG4DfWSEVFcLU4n1aJAK2rzc9JRmPVefTU4mwMlG6srRtba4C94SWh8fQCDhHH43Mp2M6X6nO+5h4totH0C9xf5nj8E6zLVKduLkF8vGlzfwGPP0/elqPUgl1Nn0+k5nF0I7PNhX7mbzbtw8qGAqCoPzB2+6HQlwwKsBsa6rxIojh1synMG6CgBe5lqWOKPYdJuSt0+oHxXArB/2bxfE7seG/2KO0ZMvbZ3GJd3FSk4LFxgBbL4eAjUTB7pDx6A3NT28KIDb8qCl8ITMPhg8TaR6cDWNZ/dT+WgQBlooDv6NZpGawiHd2ouben
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:58:23.9195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7ec9b3-3b6d-4dff-74fe-08deff49362d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

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
---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++-
 drivers/iommu/amd/init.c            |  3 +++
 drivers/iommu/amd/iommu.c           | 30 +++++++++++++++++++----------
 include/linux/amd-iommu.h           |  6 ++++++
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f9f718087893..26d7a9796e64 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -113,6 +113,7 @@
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+#define FEATURE_GAPPIDISSUP	BIT_ULL(4)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -1004,7 +1005,8 @@ union irte_ga_lo {
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
index 3bdb380d23e9..2e1889f8a9e4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,9 @@ u8 amd_iommu_hpt_level;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+bool amd_iommu_gappi;
+EXPORT_SYMBOL(amd_iommu_gappi);
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a5f89e93ee41..d89e3ce97e57 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3970,8 +3970,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
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
 
@@ -3982,15 +3992,15 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
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
index a5f1bd6db0ee..de228140ce6e 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -35,6 +35,9 @@ extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
 extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
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

