Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B953AEF57
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860280; cv=fail; b=LCNlyzdsZs3aIGRS5vKNmNRwD+PGuYhGgjhbYuvjDPO3F8VmPNCuHxjVS9lpdGkxkxjFGabSgFVq9dMnml0W+2BfdfnD1CJBT1PESK9YgPsmjTdRo7UdjFEDm9zrfGzpAHSe/C0zEYQdN/+xOQ1Jvxbe4sA/J0ZCLxNFKe9iF8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860280; c=relaxed/simple;
	bh=kpPR+qQcXcA48se40TwKZPWiJchtAd/UD8HZ2uKB9zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJqRPKbdHoetiQwY/UNVLDSbayRZmppCE2m1KafLZ0MM1OffEWdBh6HwBy1htrdezQUvArNrBmVWVQAwXip/EwJB0N+mVXWd+azolySEpsaEaI7z9NVitF8V29iwoFUA7jrm+DrQRufNuzXAcdbvaZs9KMeTNTZQwQvFWoxGYgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4VmXd2y5; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4VmXd2y5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6gOZ+7+2IglVOJGSgPflRPOeRWKVMKEYVTyWqk0/gQSdZD+KjBO/3NBBe3i/kHvkZdoUW3BUDcKLUpjtOarGd3qog/s8yqkixiI1urwg2CxiiRmSzb+i2VwaxrT0xR4QECqOZsBpXe76HrdZ27eObWE7lDZ2HRDFoistgINaCmPeBFcBURK7OejuDfFLKF/QxdqXYzEKqAd89joek8KID8fJ0kliYyqzgpxaFLYbbcDjrSVbjamrFhwNkCSub4SGU5NgdX7BoX15mfkaBlmhz1dgm7df66uSvgsWwiVXNYH5uT28Er0TSZrJblHWDKTHqncvP+5FcjB9y3FYpGo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjZc7iz285wm7FOJP0rtxMcKWGew6rMpM6Vz5ZEHhOk=;
 b=yO0FYeAktb2pZCiE7j16+nGyXVhf39S+20vsF00bHg1ZA+09Y7Dmqef5i2X9HkRRu5YoR/VdF3COlMwCZptodNaK/bl2kdoWN06tMHzS2+f1t93PqWyju2Sc3+IxLJ+vnVZUF1QOwyL1RXYlfocrrI307EqYdftBmob5MSFM/1YkA5DY6+oYm7osu6w0o29Mf1L+PQi6EkXmDs93tHlwoMRmUzPb9rwo1jkLDcd3M5r/a8WVcCE9WlF3o1kRLYIlTLDpsxpvqTl1aMT6YL+WYzpqF8rwJiB7q+dGw6x6kWB1GE3LDc8onwyQhP34qKDAnhY+1F1adEDm/WHocWFk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjZc7iz285wm7FOJP0rtxMcKWGew6rMpM6Vz5ZEHhOk=;
 b=4VmXd2y5ttFh93MCcoRE+MlSTfCNIIt5EyHXE0ypbmQudauO0PJNNv6DLebPX+jXxOWz9o6wcFEfe5xKpQBkR9/rx3KQJkkcAsVAdtEmyll4bFO1ncfYQXwuvyQBKG7u+efW884YnHeJrvfbcR/ndeELfKypWlb2RwQrewGVtSQ=
Received: from PH7PR13CA0004.namprd13.prod.outlook.com (2603:10b6:510:174::25)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:31 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::f) by PH7PR13CA0004.outlook.office365.com
 (2603:10b6:510:174::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:30 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:44:21 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 22/22] iommu/amd: Introduce logic to check and enable vIOMMU feature
Date: Mon, 30 Mar 2026 08:42:06 +0000
Message-ID: <20260330084206.9251-23-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: dd61a066-a3b4-4cea-31f7-08de8e388f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JyUqFd9LPByWaj12esqNj7Wk3/yJRkunjI3XE0mUXUxbbnnB7TEYC+PTv/WxbPUrHOvtfedl++mIIALbfF9fb+i3g9p0AAPprXz0BMa7sENgPORwqqofkede2MH/fFyJPCn6hXMWhj9z7y5p6QvTkB2taNwyKDgnXGddyKELcwJtMa7yPCYyXYI+wqAspF3MQWBzTatS4pJ24uy6JZYTnQC3Yb/jSGRIp7Mk7pNNsUA3vZk7Ev2CzmNMYc7qdCsx94S0F8lhKWVdcWgH3/Pz08iEk7GKLeMa6iqtGfd5VAOC9kL3glyFefVhxwS+1FTZ7KsWaQsadH/8YldmQnnGqdEqtzE/kOhwnoUtlIQ/GU2POgJIyEN1DBBiWZsQPAbdVxVJW7i3ZYXsCRLE56SedfdbRM0BrAzdeVbOqRIMjXqMVk7ondXHWd4wFbHkj70ghHfGeAYumUcE0YJhrj7Ou/MGdlEzUiWpYc709mfXN7f+3eVNyZsMEuSU2Ux778CLo3zQ98lecrjRjrzwpC+8C87dbXrC82997cmVn18NOfFJVuEEH4PW04d/9sXxkIlvNvMr0gclKI6WlYX3KEzvG4UnKqGyrpVU2q6LE7yU2CAjt9aGS/nGi9i5CtNh8cFuHtOxtpJkfMOLqGkQ9HSkfJ95T7oYbcTchB732lDw0OqZHFhQDJZBR5AKwS2HABXieLKt2qu1rRtgbz1AlUDP9EOcu5ahPPoFY9Hp6Ppb85P0fCNcNGan3/h9Ku1vOGqj37tGLTFKcItuO47PKHV67Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f2FibAElNU6aRbPnSgXJV+G24rrmzsNjlayz2u6bSUP6U1HSMHuM4F+aa8sXLu2UecdVthY8XiO8zFbczG6tvG+H3rlWR/IJKT91iI5xn8oqzpNs1QFoci4jMtc1T1t0EHBq26eA652ZaIhR7m0SDA+JcKTa4T4wWP3T0P1BRrJsMhb/wXKZ3POsMjkKCYVH7Cm07N7pScybLm1BG0NZp6YhW7HvWeTXdLqfw+RchmgwpBHdDbzcybmXRqFi4CpU0WHu2lIF2YcAkO4xApFiR4kvZm2kjzUS8MbmY388hvWnSju93QNiimX17upCxBIiCfO7/rigGfH81fJutaB6PxLUth/7zeXJ3AhGZxevGEVwGTgJfwJoLSxH7a+omtb0L0v+56pE7l/WSmubK+xk3pdll4PXfRubHXljiJCk4Gx9BPZ04JXvrgn/brtMddL2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:30.3466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd61a066-a3b4-4cea-31f7-08de8e388f29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

Also switch to enable vIOMMU by default, and provide kernel boot option to
disable the feature.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 14 +++++++++++++-
 drivers/iommu/amd/viommu.c          | 16 ++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 38694ebdb083..2b057ab77ce8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -25,6 +25,7 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
+bool iommu_feature_enable_and_check(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ff72023fa512..4667efcfb8e9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -204,9 +204,12 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_PPR_AUTO_RSP_AON 48
 #define CONTROL_XT_EN		50
+#define CONTROL_VCMD_EN         52
+#define CONTROL_VIOMMU_EN       53
 #define CONTROL_INTCAPXT_EN	51
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
+#define CONTROL_GSTBUFFERTRPMODE	60
 #define CONTROL_SNPAVIC_EN	61
 
 #define CTRL_INV_TO_MASK	7
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0018ae804ab4..63271f4305de 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -195,7 +195,7 @@ bool amdr_ivrs_remap_support __read_mostly;
 bool amd_iommu_force_isolation __read_mostly;
 
 /* VIOMMU enabling flag */
-bool amd_iommu_viommu;
+bool amd_iommu_viommu = true;
 
 unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
 
@@ -436,6 +436,16 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 	iommu_feature_set(iommu, 1ULL, 1ULL, bit);
 }
 
+bool iommu_feature_enable_and_check(struct amd_iommu *iommu, u8 bit)
+{
+	u64 ctrl;
+
+	iommu_feature_enable(iommu, bit);
+
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	return (ctrl & (1ULL << bit));
+}
+
 static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
 {
 	iommu_feature_set(iommu, 0ULL, 1ULL, bit);
@@ -3702,6 +3712,8 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "viommu_disable", 14) == 0) {
+			amd_iommu_viommu = false;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 4626134893d6..5c744de729d5 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -45,6 +45,18 @@
 
 LIST_HEAD(viommu_devid_map);
 
+static int viommu_enable(struct amd_iommu *iommu)
+{
+	/* The GstBufferTRPMode feature is checked by set and test */
+	if (!iommu_feature_enable_and_check(iommu, CONTROL_GSTBUFFERTRPMODE))
+		return -EINVAL;
+
+	iommu_feature_enable(iommu, CONTROL_VCMD_EN);
+	iommu_feature_enable(iommu, CONTROL_VIOMMU_EN);
+
+	return 0;
+}
+
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
 {
 	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
@@ -298,6 +310,10 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	set_iommu_dte(iommu);
 
+	ret = viommu_enable(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.34.1

