Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F82701D8
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011103; cv=fail; b=ebUiAQ3R1PPaeINowo3R5LKdL5K+6cf+fPPORls1tWS5YUwxNZr3633fTo7wt6gPjYRl88iGjASES6pHVGI47HKO4rlcLSZlvY3zY3zt2sQ6gHKtc3yWyXxY91xiWfGbbACbWoUTZlBgWQw/JwWMCuhPcDKQo81RuogOSTYyhg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011103; c=relaxed/simple;
	bh=yBPfp1UQmc/E5UcM1jlOlu11zZILUAEdvWl1xFwXOlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX5fjF9qkyv/bTLQxlm+I8+ez3XeDupjaThCYT2nWRfj0HXTBOTnYJSXxMul6YWDeuPWckFPq8sFGLVuElLck0DlJBts1E/XN13fu8qkRmBBXvVXeYd6OiiyCVvWwQ8Sy72F3DFiu3qycuIGAWtuAGUIXRznes173EBcray6HII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D5MAuGoH; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D5MAuGoH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKgvx5l0C7X2PDEb8daGNxM7Gl5HQAYDaaTu+SgNHyZKoBdSngGGFvDn78QNtNuPYXP50NKfunIkxm0cEwpXUUYQOJhbONcwfS6otP9upWOo19fdowh/ll9O10ziwgphqxDipviqn8oBG+d8EHVasPvrxpkHR31aB3hVrzTLhmNPrbUOTwMsm3jgQwIw+cg+fbFp6I2T1M1fFflinTsiMaktNZcNn0Uk7uUiXyInaocGx1vYzY9yHFHMZOYmZnXjNALC7nf8Sn3pOHJ2Xc7EAzPnMUitVEmyWJuS254W7aidHaTSis3SBL8XaKfYRl3jnfvz1nj09deSBS8d0AQBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7huBxxPSb/VfC5GKGybo6Z7RmGjYtH/vOguKnnFvjOA=;
 b=ikjdYKIISQOK5IqR/8kJaCgHTnUuFYUODp2EM2Ruc8639L4inueuictN2/tHqxYwmF9CElvkDxYptvC2dHoCXDez4uvrLBKf52BTjRmZWSpVzOxVoCqcHgKz+7/VSq+1O8WWXXP/vv65xkK7/fqc+QRdtIsWdXvn+MY7dalO7iHr8gwccmnun86pU9tFIBcZgkunJcJXju25FP25T2KZPNcJemOq7FGeetCDbgj08zdlXuTXl1MixH02yQp8/PkfP1oG3D7XJ6tE7IoffpRjh7t15z6qiyZHvHDKzC5hQk77//5Vhuogi4KGRyFcmhKG2YLsMUgEx9ojoneDVr1tJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7huBxxPSb/VfC5GKGybo6Z7RmGjYtH/vOguKnnFvjOA=;
 b=D5MAuGoHUzc2DRmxZekfSZ3McszbU7YRUsIENuLb8V/3rot6+SkAbgFzDyjYeDWxcVDYe683ZsOWX4Ao+5n8wfLo2eyuFISvk/puYekxPt0ib8JQqZyvySQq8cPJLuanAJh+yK3cWB2lqSGuazpN1J9U6aktjiASrWQLbJfYvSw=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:57 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::85) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.10 via Frontend Transport; Tue,
 21 Oct 2025 01:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:51 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 12/16] iommu/amd: Add support for nested domain allocation
Date: Tue, 21 Oct 2025 01:43:20 +0000
Message-ID: <20251021014324.5837-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: c167d304-260c-42f9-c737-08de104370c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wrhx9XcxRzdqpeECmTYPNEkhgkgpNqWm6GjXjk28Cs798IDM236Oqpxt5Rkh?=
 =?us-ascii?Q?sse0FNRX+xJ0wu+G/3nHpoBDG1HtNKy/kcMGBFUbalSp/KdQqgRCjqAorUE6?=
 =?us-ascii?Q?Pp5Q7ARogcM01LpAhlS+pkl++eveBNFeCTom0Il5VBxvVJzOG56CfsxgNoaW?=
 =?us-ascii?Q?g7GhO8BlNB8Ah4TnT2gLn7rld0xpW9Zi7ntSOedzthZssP+KMcxRJ6u3QdLy?=
 =?us-ascii?Q?k5ZoIouyah0EuX6Km42SnlWqVEB0wxaX/7OQgpVu+HAwLTDdr4AQULmJe8qz?=
 =?us-ascii?Q?7HcPAZitIAVd+AmiKEzPR+affuvZYCLDg7e2dxyaeNZEms5MWa/LtTQSxv6a?=
 =?us-ascii?Q?M9MPAikGi5XnicBeLyPmV9bf828hGQS/n7sekR9hXEhlDvXs0rCGB1aaVwv5?=
 =?us-ascii?Q?1SsAaITP97ZcMTTh+iX9s0a7aIplLaPVM3ns9+CN00Hsv0WM+drP9OcAkIKh?=
 =?us-ascii?Q?+i8KUDOKskr4AWDsciS/gWzx32umoujBE4T9p5hev2oyQadUWAqNpOR3hklO?=
 =?us-ascii?Q?i8rWj+1Xctm3g3AG8SvSZUQq/v4mv9R1z7dBX/Zltht62JcektW1n+wD3VW9?=
 =?us-ascii?Q?zD1oD/fEnmZU11/u75uN5orAEK/7pPS6VxZJ1HFQERTwfjP+GFsYBVAY/BO6?=
 =?us-ascii?Q?3HXIPKKh0Bp9ZTXr/7acUPScL4wKs2qnfk/NQ1x2A6i2OcncXQ+z7T/rPZ0Q?=
 =?us-ascii?Q?cr14nCf+RXYiTxupYlWUA3HUeB/XhEfO4rWnZppFPG2hZckAcXC6SBiRY/lG?=
 =?us-ascii?Q?DV54EBW169km7dYYqebiX2Xdi3NN8xRYSHrDc/CNTuXUi72/VzHD9Pj78CdO?=
 =?us-ascii?Q?zGIpyFKS2h0ZNpZN3lL1FcjEHTQWyn1rdaA0kJ541/upyVEBu0ZRaOdSXM4q?=
 =?us-ascii?Q?X8PwIcAfYEfYbAF20po/Arc1nw64BzqnWXv7zmS+MqqfOWfhyQ4P+qRJzli0?=
 =?us-ascii?Q?1D1f1XQiVT85DFveSoqtslPTFEM3rh3XhUmuHFW/2D0/ra3wK8axRKIrdeX+?=
 =?us-ascii?Q?xqv60XeKb0/6Mjdebbor6LQb0AfbpC3Hzk5MbzOf6BjUm0ZTJiSkFWMhbXUB?=
 =?us-ascii?Q?84LQXnZ9RAgflYmyFzHq3sn/5o75uCkPNktjyTakp0gaBNmU5PYB3TwjjDtj?=
 =?us-ascii?Q?EHgjYsgbeFxDM15JyQbXzgKEchKnzSxnJD6GJd3NIOnjTrIUNqVEWhOqj6bK?=
 =?us-ascii?Q?N1Ptr/1+Zurm/587p14CMLlb5eKffPQYZGhLkF3XdItsJ6cnWUHKe0SK7W/l?=
 =?us-ascii?Q?jpjcQhQGzgcocEsp/WjQ2g7T6hQ/zvlYBxm/Yq2f1dlGcbUS7fmh74HNHi4h?=
 =?us-ascii?Q?ohSyKlN5NKY3NhJ5ZcMTiYfibnFid2OEiVyUuRB86bXZ3HoHez7bjAR/yWpA?=
 =?us-ascii?Q?aV8Hua8sWU1NMpaMGAbUOsel2nfLW1qMIWj6xZdBnoUdWgaXJYg02Yw2/+At?=
 =?us-ascii?Q?aw3X9p7fX4VGELGWB6xU4O6AOMt50XsCVqr52e9O6cbq7EC8dnLWdAXjzSqz?=
 =?us-ascii?Q?V4sZFsmXdl3eNk956vPbSNQNtl0GvSW6XPa3M9C6Sf4XhbyCtd/h7SwC/q+T?=
 =?us-ascii?Q?xOROR07H/HF/WZF3USI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:57.3366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c167d304-260c-42f9-c737-08de104370c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
table along with guest page tables. The struct iommu_hwpt_amd_guest
contains this information, and is passed from user-space as a parameter
of the struct iommu_ops.domain_alloc_nested().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |  14 ++++
 drivers/iommu/amd/nested.c          | 111 ++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 5ae46d99a45b..afa12ca2110e 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d533bb8851ea..3730d8bbe6dc 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -202,4 +202,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	new->data128[1] = 0;
 }
 
+/* NESTED */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a0c7e7329233..e0f0cd3d34f2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,8 @@
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
+#include <uapi/linux/iommufd.h>
+
 /*
  * Maximum number of IOMMUs supported
  */
@@ -417,6 +419,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_MODE_MASK	GENMASK_ULL(11, 9)
+#define DTE_HOST_TRP	GENMASK_ULL(51, 12)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
@@ -592,6 +596,16 @@ struct amd_iommu_viommu {
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 };
 
+/*
+ * Nested domain is specifically used for nested translation
+ */
+struct nested_domain {
+	struct iommu_domain domain; /* generic domain handle used by iommu core code */
+	u16 gdom_id;                /* domain ID from gDTE */
+	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
+	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..e7b6f69a9d0c
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#define dev_fmt(fmt)	"AMD-Vi: " fmt
+
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include "amd_iommu.h"
+
+static const struct iommu_domain_ops nested_domain_ops;
+
+static inline struct nested_domain *to_ndomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct nested_domain, domain);
+}
+
+/*
+ * Validate guest DTE to make sure that configuration for host (v1)
+ * and guest (v2) page tables are valid when allocating nested domain.
+ */
+static int validate_gdte_nested(struct iommu_hwpt_amd_guest *gdte)
+{
+	u32 gpt_level = FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->dte[2]);
+
+	/* Must be zero: Mode, Host-TPR */
+	if (FIELD_GET(DTE_MODE_MASK, gdte->dte[0]) != 0 ||
+	    FIELD_GET(DTE_HOST_TRP, gdte->dte[0]) != 0)
+		return -EINVAL;
+
+	/* Must be non-zero: V, GIOV, GV, GCR3 TRP */
+	if (FIELD_GET(DTE_FLAG_V, gdte->dte[0]) == 0 ||
+	    FIELD_GET(DTE_FLAG_GIOV, gdte->dte[0]) == 0 ||
+	    FIELD_GET(DTE_FLAG_GV, gdte->dte[0]) == 0 ||
+	    (FIELD_GET(DTE_GCR3_14_12, gdte->dte[0]) == 0 &&
+	     FIELD_GET(DTE_GCR3_30_15, gdte->dte[1]) == 0 &&
+	     FIELD_GET(DTE_GCR3_51_31, gdte->dte[1]) == 0))
+		return -EINVAL;
+
+	/* Valid Guest Paging Mode values are 0 and 1 */
+	if (gpt_level != 0 && gpt_level != 1)
+		return -EINVAL;
+
+	/* GLX = 3 is reserved */
+	if (FIELD_GET(DTE_GLX, gdte->dte[0]) == 3)
+		return -EINVAL;
+
+	/*
+	 * We need to check host capability before setting
+	 * the Guest Paging Mode
+	 */
+	if (gpt_level == GUEST_PGTABLE_5_LEVEL &&
+	    amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
+ * during the call to struct iommu_ops.viommu_init().
+ */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data)
+{
+	int ret;
+	struct nested_domain *ndom;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
+	if (!ndom)
+		return ERR_PTR(-ENOMEM);
+
+	ret = iommu_copy_struct_from_user(&ndom->gdte, user_data,
+					  IOMMU_HWPT_DATA_AMD_GUEST,
+					  dte);
+	if (ret)
+		goto out_err;
+
+	ret = validate_gdte_nested(&ndom->gdte);
+	if (ret)
+		goto out_err;
+
+	ndom->gdom_id = FIELD_GET(DTE_DOMID_MASK, ndom->gdte.dte[1]);
+	ndom->domain.ops = &nested_domain_ops;
+	ndom->domain.type = IOMMU_DOMAIN_NESTED;
+	ndom->viommu = aviommu;
+
+	return &ndom->domain;
+out_err:
+	kfree(ndom);
+	return ERR_PTR(ret);
+}
+
+static void nested_domain_free(struct iommu_domain *dom)
+{
+	struct nested_domain *ndom = to_ndomain(dom);
+
+	kfree(ndom);
+}
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.free = nested_domain_free,
+};
+
-- 
2.34.1

