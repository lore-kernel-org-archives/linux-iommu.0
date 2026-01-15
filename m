Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81402D979F
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457375; cv=fail; b=LPAHG2/F49J9zc9UGvv80SCmP95+OSeYbR0AxEzWORO000TgGsE6DWfqXajNKg7/VmezXDN/2cDGer2JM7/+LkOfFkj8eQdAu1XeFCpGB6vrqyZ3Ls1QbblWua1acRzQHooFqMM18K7a1csAJLwz1ttYLlOcEc5ZNpBoRx4D/J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457375; c=relaxed/simple;
	bh=SYLAQWdn26808DNlOMA8PVxuZirkHIxrBJaDac0Tk1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLHen0wNdtd1VrhzplDru8QwSaU1FrFktvsgziuphfpruPqPxwBSCUCJ/ayuRYJR2kauhwhvDWh9YHlC/4nn2e+h04tzIf4k2htxIS4DfDmwo5zyByqrgdwkUPpis80Ldwlw2OvCxJOrqOQvbU1Ipc0WLuV8p3eLMoXhVnZ7GfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=loX/9x1i; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="loX/9x1i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRAAmN/2Z/NfSwX++EC6KcBhLwRFNDtJYY5pbDRR8o1n+lQ1dGPOCr6kefOvnAFME/TLAFLr9FOmXTumv6S/UYFU4f6qBe/IBOHBgfGW7vG6k4Eb06pOrGc7NbHiaWFpkYCPYt5yZgq8yy2hwnjNv6AfLFLHpZMINff6ZWxdmLQAaj2efLlE7UxC8DFGVKEnDbChY0sHWIWQELENOzzkcJMUJHG9vwex+t6UlWd1Gv+B3amgL7hM3BNbm/+AchBFodKnHCV/Pg0uJUrNMr5wtzUL+bG4w6yO8lyT1o5vWEFO8WBit5PeUYiNweTwWdKP8rc//tRpk2CHKZItsdbL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnnoR8FHvmNEkdMi4SgwIU2H3CQmm3qwlcOdf3ja/iM=;
 b=D6Zla83ipJm0K9pyd1tRmTn5LmBqtJp8IjXrp4bWzTT2p0Pt0oqEw9P8CgujuW8jzp1tW1tHfk0qJEx3fdyBRaEKd89+hWeKDRzW4sPZxeGv4aL1Smcjyvpm4S8eMULKw97pHa35OS86b/Q8a++8OnRNRaS88Nx+HO9yVtGEa4Lk3uEKyBoGJaYpU9MkhOpUb7SHtr728ZYZVLMWL5NMngapbb6pApfLKVgcY+1RWzOssUzADfcLlzyrQXJ2j32jmCSShpy6vhHxcrzgeZwt7yj8aq78n+KTUQeU2JwiXZSaSauRvPCUyKswRGj9nh8SAPnGlDrWoO6VML8n6dYKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnnoR8FHvmNEkdMi4SgwIU2H3CQmm3qwlcOdf3ja/iM=;
 b=loX/9x1iV3DpRIIB9hgQ09bzJUoifbJDhYvFJ5jYNy+uQQKSFoOfBN/yILLRHY8HZntfnDLYVefU3wxgZvCOUUvENeoxsb04dXIfuTRhSFgORhB2CEq8NugZG47PT83USnJwa+ep0Q7QMgrgR9VeXTRTjc+dwcfQuZu3dWU3meU=
Received: from SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 06:09:27 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::d0) by SN7PR04CA0231.outlook.office365.com
 (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 06:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:21 -0600
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
Subject: [PATCH v6 09/13] iommu/amd: Add support for nested domain allocation
Date: Thu, 15 Jan 2026 06:08:10 +0000
Message-ID: <20260115060814.10692-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9463a40a-7b44-487b-30b0-08de53fca3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqgrJWs4VlrWhoSEllHAcdMuAI8QQgTFuCmKY/YTEZ1d1Q6AxW+S6rM5Lsz1?=
 =?us-ascii?Q?HjRUuhVJu32PwTP6uFIE5GwqEOueh0MFuN9K+pSdMgaCSX+h/EzZQy9i5Al/?=
 =?us-ascii?Q?hDPP3z9gM4zNsYhbhoSEaqX2W6+IyRWeTJxlvjcSJZjzgFAw8n7jIBlFFQVN?=
 =?us-ascii?Q?VC42s3PG4McLLpd/wAbWUcImrGyFlzGapp+D9bIosJKUHmnSQNOAMd9YjaTx?=
 =?us-ascii?Q?Cm2nGMJc96pIWwzX7biYiZbqAsuCnO1wQ5GdiPqlhRQhblNQPIBNyqWB2pIM?=
 =?us-ascii?Q?Os4tYC7x64iqo31Uo8V+zSRyXkNvmh7ZUUAAyI/DeDvK2ja214nBdjdTsiM9?=
 =?us-ascii?Q?i0LcM0XBlYV2b8TA1GPmhYACI3p9EcHRzF249M+Ouu+aVGTcpwBU2PZM6epw?=
 =?us-ascii?Q?ntg28gBtJPBdy1nkU3GIG42JGvf3Jckp/emQxpWxiq4B0iOKB1fgtDundUM7?=
 =?us-ascii?Q?CqkppVxm0PSxcO6zsuQMQTekSLm4FvJNUkzQkZ/1+x2A7Rq6tVm2Cpvgm3Nz?=
 =?us-ascii?Q?EaeqG5j6o/i+mG1oei6iWnRbOBkRr7wm0GVSMqAyG3AYU+pcWwFpYtwHP8uM?=
 =?us-ascii?Q?Z8yqC7HWZr25/NxIppQGi72coqCqB2BtYVTrAPjJOt8qdT8VdRf95Mkswfhb?=
 =?us-ascii?Q?O3IeUVkKbE7Xod8rLT7VWV2MHxqUczB0TXquC9Q8mW2n06GbDFBiylDvMe9S?=
 =?us-ascii?Q?n80BGMaC7lxD8T9kfwCzhwcjtcs3dK6ldQ3vYrKp6hOv/BdXMJprL/P+5/99?=
 =?us-ascii?Q?k3PFToyuRPH0UQiKn668n3e3usXMm9qg2FDEi4dlUT7U2Zn7Ol17/XpIHsKJ?=
 =?us-ascii?Q?ythyBXqP/by+Y+wlxXnAeNL1XD3/8bsqS0mk2MpOVO1AfHsuCJMLO00yLp3E?=
 =?us-ascii?Q?WwUogzZsF5kOHl0kf9je9cQoXpa/p7uJcbIyNp8KPt16y2YJJAaNlD1mZsAw?=
 =?us-ascii?Q?L9UabfVBx4JwhO9BwSPZjmzri/eajSpw49UCMMGndcLv9tXR6akIHMl/GwRT?=
 =?us-ascii?Q?alZMDtTYRT0AtrDwP4M8/s/+/IgoMsaJN+8fv6R+qrkHhn/Q5iFTh03EROsd?=
 =?us-ascii?Q?bLL6cy4ywVMoP6W7f71de/YFN1fNIdYflYw+hY53VEXFE6K64pfae31o5SJG?=
 =?us-ascii?Q?ssdZERW2mnB+eKk96ITszcAhKE2etZQQg4BDJpCP9HPrZABllH/SkF7nq1ev?=
 =?us-ascii?Q?Ubh/AxdjaPin9xRWZc0p8NUaZqIPRERh29rLC8kCq5bu7KlKrbkmW2qajJg6?=
 =?us-ascii?Q?KXWXZ+n53fFAmZj0K81ezi+NXAZTkJ3sa6ZoXBHayhetniljLbwdT2s7Fpqk?=
 =?us-ascii?Q?HvJJCFk5Zyi90cAFzbwvzP8fOoXZeVQRP3w1k3JJGdtDDrfHP6bot6MtwvB3?=
 =?us-ascii?Q?1KPhkiprmOA130pEo9hC9DOXzQBRl1rEWcdL77Hps8b458u2oR1VOIaw/bky?=
 =?us-ascii?Q?MxDKLLwetBYSIfsVTVQ/Qwt+ab8kSc5UTj0fED+H0hFaf/e0K1seeTGa5/+i?=
 =?us-ascii?Q?TheDB62FqMPpRnr5brKZeY7rEZuQ+T47CsjyMUsT5GqjKkhKC2z3wNDjouGy?=
 =?us-ascii?Q?VWCtgs7ad+GDNRuKxMRMSuwDtgYVGk7tgV5EppTyzyT1LLbMBBm6FZnQlDv5?=
 =?us-ascii?Q?MR5/cxafaeqk1kMPbceTwXHmE+0BPst2eoPczxugrRMdqQbJXz1jh1w4JsPN?=
 =?us-ascii?Q?zWCL6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:27.6258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463a40a-7b44-487b-30b0-08de53fca3b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357

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
 drivers/iommu/amd/nested.c          | 110 ++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 41f053b49dce..94b8ef2acb18 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d97b9b6d76d3..aa29afe96e90 100644
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
index d5b3393ab3a9..487ee6123de5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,8 @@
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 
+#include <uapi/linux/iommufd.h>
+
 /*
  * Maximum number of IOMMUs supported
  */
@@ -353,6 +355,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_MODE_MASK	GENMASK_ULL(11, 9)
+#define DTE_HOST_TRP	GENMASK_ULL(51, 12)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
@@ -501,6 +505,16 @@ struct amd_iommu_viommu {
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
index 000000000000..a8c0bb4dd733
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,110 @@
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
+	/* GCR3 TRP must be non-zero if V, GV is set */
+	if (FIELD_GET(DTE_FLAG_V, gdte->dte[0]) == 1 &&
+	    FIELD_GET(DTE_FLAG_GV, gdte->dte[0]) == 1 &&
+	    FIELD_GET(DTE_GCR3_14_12, gdte->dte[0]) == 0 &&
+	    FIELD_GET(DTE_GCR3_30_15, gdte->dte[1]) == 0 &&
+	    FIELD_GET(DTE_GCR3_51_31, gdte->dte[1]) == 0)
+		return -EINVAL;
+
+	/* Valid Guest Paging Mode values are 0 and 1 */
+	if (gpt_level != GUEST_PGTABLE_4_LEVEL &&
+	    gpt_level != GUEST_PGTABLE_5_LEVEL)
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
-- 
2.34.1

