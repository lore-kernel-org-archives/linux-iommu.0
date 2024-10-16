Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379F18BBB4
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055919; cv=fail; b=iI6DLx7gciXvZEKeMIkqEg5I3lY5D+dtMGs0St4/K/J/wzaktsi7lu3sK5KLgxylI3DtrAII1X4G0jtWQHOfh89a5lyka0MuK7ZyNTVEpl7Lm87iA1JWS8E8KhWOJrM1c9/FmSK3Xg5idr/EdrgA8xIdcYppGXFprdFluM69LBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055919; c=relaxed/simple;
	bh=0O+4rnDzZhpIAXdH/YQHR6P9GnX+3BAQojnZzYKQU2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfZJrz4KgZYWBODTlVXCDYae68RdBnE1FIFMMJOUq4+/6LDcVdxbBxkCk7kl9IVSy4OYgFRYvtvrRBG65idi2jrVlH0L4rFknbucDmhJijE4DYZeTj74dXVpUvXcGJSTRm57TviIidbSTZB8WrSbHydqkPnVTOGbwQca8muKqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0Uzt1d8; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0Uzt1d8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSPCBCZH9EHxILvO6GlPwKhUYOGk35VpC8BWF8xwqh4RcGiC5cAP5jcSGpPlzTOK9LCjk73mjzOT2fwquP4u/7wFyx4PZBSaAapAZyOJ5TPVQPleC22+iProsWiOVaFUhU17I1a7tuQiDNuTzQl31kCJDGxa4GapurY5a/HCEj6OurA4t54AYUAm29Mx8TPXXwIjDhyWqX9np9LNt3Zu+DTU2VKBdjcIES8I5faBJc1wMg2bLK5M5LoSpibNslHGr9O9HC1XuTNG97IHaOsei4fWhR5qsHmcPtqMC98AzmsSpOu+6Et9/l3ewx7P7qdK4n3j7a3QffzNxkKMnQmD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlksWb6OAfycL5R5Lo29ZpRkX49ckMUQvPzQbGjS8Xo=;
 b=KYeK4FumEY7qKWyCBG22KaVxR6nRLAS6pvWKxji64fDxsgQjOTxDNXZor5P5jrSbJvdKuFEWmIYmWw/tkcs09pyA1zszAANxZGJXwBQ6ex05Uuhk1LNabBovZdM1vnXZ1dTJVDkBeodov8zq/jdv6/Sdth+NEBTexkPC2tDV6lP8mTYPG1H8ejhOzy4EYTFTqT8ondDw7EBN8O75PqjXHqC9QmC9NuawZ78kGqD7qyVmsxEywT593/aV7qG8/Ahs5sYwgI4bx1/RXgf1OzdpZ5yB+TGTMcTdSkD5pJsP61L47+AjuQMgSE4EUVs00090gnioOJGkdctCWYqw22e7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlksWb6OAfycL5R5Lo29ZpRkX49ckMUQvPzQbGjS8Xo=;
 b=F0Uzt1d8E5DePrrV87oOg/lWYC9JYhyVNBnhNR1snst1L1YFovheIAKH6LDkJdRAr1cO+keTm3TN1Xy8noMB4Vh6VA8fNofsJ9fQMy1SfvCNwqRV6IbOJv6XUdx0QjKnuxD7e4rQszSaSp+/nSPkBWh+O8EcBhlloqkMkhMjD5Y=
Received: from SA1P222CA0181.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::28)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:18:33 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::60) by SA1P222CA0181.outlook.office365.com
 (2603:10b6:806:3c4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 4/9] iommu/amd: Introduce per-device DTE cache to store persistent bits
Date: Wed, 16 Oct 2024 05:17:51 +0000
Message-ID: <20241016051756.4317-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: eca275b5-5bbd-4d23-81c9-08dceda1fb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mm/IYWSD2kKLBAgiiykTYOQtd1u1FSo9JfP1l0GM4129iewhFgmHOKwlorcx?=
 =?us-ascii?Q?Z/KvCbr9p7msMPcQE9MCiU/lvCcSOU/nd9rVCgsVw2/3nJdnbWrdtLLkPJZj?=
 =?us-ascii?Q?aB4SgyubE5PKMxLU8SuEAeftRShd7baw8SijYPW0+oD6wUOzr5nWKGLSphp4?=
 =?us-ascii?Q?zYeoEbHtqciX60Uyye3XmR9zIcD2X0SMikgBSBPUJ9wMIOiPZCj8xsBaviTl?=
 =?us-ascii?Q?KKO0qpHyejfz6/jnEEOv9Rh4U04pIwl334wfLRX2FKZGkFIQSJQbWlE/mQxH?=
 =?us-ascii?Q?CGArlZT/+k5YB+cvHrq0eUJF7wKIfFKitbQLL3QZh6bLOwRwK0rDJjLXXuSZ?=
 =?us-ascii?Q?esCaS0hRtsrYnCwyKYtfbqdEbT8dY5J0IPyTjnsFlmw9Q9Ebp1lc1Ft6TG3g?=
 =?us-ascii?Q?EwXhrFC6JPU2MLK/kxw3uGpOPwP/e3b+lOvi2xVIFcn0Knj5IN7nyTv0Fct8?=
 =?us-ascii?Q?TwcqSog+6ZyRkUKUR6TXn+Fwp3p731jBh1oZu1ESwG+NSgPAkmtlQuDiafql?=
 =?us-ascii?Q?QIZVm59UCowPNrwwwu3L2uXDSQxR591x7TT7mmMDbANNLqUpt0pjEmng0faQ?=
 =?us-ascii?Q?uB9C35wCA1Wilq0eJD2DwWg38wqFeq2p05sZ/9RVRIJZBDy52/HkRDyKveTG?=
 =?us-ascii?Q?2Qm01tBAm08vvfP+yoD+s9WM6MSKytVt+qmzpbxTBiscRfracV28B2XVDoOH?=
 =?us-ascii?Q?93v9aQoray5JiXK/t2SAhbiX+R8uFfucbH4uYyUHlhVeB9Co1wNbXxMoZ+Yz?=
 =?us-ascii?Q?//ehiXTs9Cjiwagbb9f7DpBTmdT681jHVpfwqpAqlcGonndXjK7pn3KRxt2i?=
 =?us-ascii?Q?6ncM8kfctj/DsKF/U47bpbstDH7W95YL1r+Vvx2hWH4j0nro6rTQb3Wnted6?=
 =?us-ascii?Q?Lc9Pj6BipHS6GET0T9VQBNljZER1WcopMXBwFMuG+8wcjdaDjbQpFx/QXFeE?=
 =?us-ascii?Q?ga1x1ZF0wyPmhNMxdREug9amSRXEm95iu48LXBVK4xtodtIcoua85X9+CUQ1?=
 =?us-ascii?Q?rQMyK++cnjJXBm2s4tsdQ4NoJQ8n7dTYz0IQRlI/+15+KxKenou+D7lhOQLl?=
 =?us-ascii?Q?Wr21im0S1/+tIzx4WtaXGUr258YFw1wAYu1kaAwfwBNgVLJ+GKJ8Ajip5H0g?=
 =?us-ascii?Q?sCc75m8zH6RhtLHxBRutIM+1ppRaC+XJhYrtBlCAgV9HnZycGUyO5ai06uQ9?=
 =?us-ascii?Q?+xMxGcFZrBnvsjhGMDhRA05JpQlhO5C5hXsvY7Abvn3S9SIyOaG23E/zDoJQ?=
 =?us-ascii?Q?vYC4PkUfdCL39H84wYUyghk2Oqd833uizYDpyz5Ail+UfALrJvdpuldpvFAw?=
 =?us-ascii?Q?0tJARgFn5hBjdayXCpmylzrqoxRrg9XClM4GAMCQOoTumYfio1ZKlgZRx5rZ?=
 =?us-ascii?Q?zh+NIF4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:33.5658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca275b5-5bbd-4d23-81c9-08dceda1fb03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

Currently, IOMMU driver initializes each Device Table Entry (DTE) starting
from when it parses the ACPI IVRS table during one-time initialization,
and the value is directly programmed into the table. The value is stored
in the table until next system reset. This makes the DTE programming
difficult since it needs to ensure that all persistent DTE bits are not
overwritten during runtime.

Introduce per-device DTE cache to store persistent DTE bits.

Please note also that the amd_iommu_apply_erratum_63() is not updated since
it will be removed in subsequent patch.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h | 21 +++++++++++----------
 drivers/iommu/amd/init.c            | 26 +++++++++++++++++++-------
 drivers/iommu/amd/iommu.c           |  2 +-
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..96c3bfc234f8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -177,3 +177,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 #endif
+
+struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f537b264f118..3f53d3bc79cb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -830,6 +830,16 @@ struct devid_map {
 /* Device may request super-user privileges */
 #define AMD_IOMMU_DEVICE_FLAG_PRIV_SUP   0x10
 
+/*
+ * Structure defining one entry in the device table
+ */
+struct dev_table_entry {
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
+};
+
 /*
  * This struct contains device specific data for the IOMMU
  */
@@ -858,6 +868,7 @@ struct iommu_dev_data {
 	bool defer_attach;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
+	struct dev_table_entry dte_cache;
 };
 
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
@@ -883,16 +894,6 @@ extern struct list_head amd_iommu_list;
  */
 extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
 
-/*
- * Structure defining one entry in the device table
- */
-struct dev_table_entry {
-	union {
-		u64 data[4];
-		u128 data128[2];
-	};
-};
-
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a1a0bd398c14..552a13f7668c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -992,6 +992,18 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
 }
 
+static void set_dte_cache_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+{
+	int i = (bit >> 6) & 0x03;
+	int _bit = bit & 0x3f;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	if (!dev_data)
+		return;
+
+	dev_data->dte_cache.data[i] |= (1UL << _bit);
+}
+
 /* sets a specific bit in the device table entry. */
 static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 				u16 devid, u8 bit)
@@ -1159,19 +1171,19 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 					   u16 devid, u32 flags, u32 ext_flags)
 {
 	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
 	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
 	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
 	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
 	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
 	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
 	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
+		set_dte_cache_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
 
 	amd_iommu_apply_erratum_63(iommu, devid);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ab0d3f46871e..28516d89168a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -393,7 +393,7 @@ static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 	clone_aliases(iommu, dev);
 }
 
-static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 
-- 
2.34.1

