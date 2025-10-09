Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC9296BBA
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054376; cv=fail; b=QYLPYiHgDTJnmtgKtt4LnMvewWIUSBOiS7fuirRVVKaqUEAbbvRUKVVzLrb5O2zp5Hij0qBAlXN478CS9H68F6yuVauqMGByNRvzdaQOIgaLnwpAgCOhQewNtFzJ9dQCfY738tA6zZMMNn9/cX/gkCB3/7+tpMcf8AxaGV7i0VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054376; c=relaxed/simple;
	bh=wbLO+eea67yOh+nlVBwgvQaM4ULGrkcMBT7dLEiQYTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdnV3JfqRftO71x1GX3mrgp5G7rlPtVQ2c4yPaaZes5pRlZHuOl+qJubHTqT34UvcuQXvJst70jfPJvVjI4qtUUj3pucHBtaKD/n0TyPVqOQsSC9NBUjoMHvi4T9f9JzTjxyk82F8TERUfqYra62muBZVUfMR7tJkphvX0BQvO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XHhfoHGQ; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XHhfoHGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1Hm0A2n9geWfvKRKT/rOj6Gvzsh7WqyuKi6xJx/MEwM7dlSnwpKAmeC4MHG2jkFABQ90pELxeCn22lqzEDm3WzWgiwF26jRP11OFRxc5jONxWlVr1INXlirIvCN9sGCtvX+WYmXy+LkpVp82l0tXlweVlnWOQ+adPRCT6d4FqNClrjoYANJbeFxae4hsUF7t31v+CTbwgzvknfDNbj3K5UpJtkza+3UXu8pMU0CxPCxPqBU1r6RhlYmIS7pD9h9ucLC5377OtqhiIbi/p48KilBSP2pYgXycmWp2qkM+Y8ffiwX0jITmOP8wIfRB2Amt0NGm2P/bFGnk3uJEINutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E340rlk9aybsfWue2gzYVU56FfgO9MBJXsVwivvkl0E=;
 b=x+8/ffYRb2Cs7m1DiLk7W0ZF/Oa4rysQMppIkqZUwH42v9vuQUzip62Xhis/tzM6OWQ8tk2rVG5y9UQ3kghhOTA8Zf4h5sqyN4QalGk8SU1UzMcqdTVPDHeX4vXSHlB7Zrex6c8gTCluAEExrpkVA1Ribc0NPq3g9iRpzjH9jPEWN+E0GwFtB8HKeIPGBdSvdccTduOiDszUs1KakiGP9Gduzcl9zgTHQ0ov4rPkt4yupr2ZCE786TLGxHOkJeVv1GQtiMjgpFKmyjRwgcvnRgTlIvA6K0NC0XQkygZC5+W84ylzXOD4fOGc6E2Xte2466eRwyF9S/owc+Hbn+D4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E340rlk9aybsfWue2gzYVU56FfgO9MBJXsVwivvkl0E=;
 b=XHhfoHGQfrCuvi2uyVXnfUKeWmg54K7upow30grkGUddRT0q8xVL5SMrITNVEkthR+A9E3SW+XweHLXeOu1/2GzwNk1jiv7NpoIm/Ep/Vg046QaMHfsuJNkXnM0eAFG9jJ7mTY1u1HGH4hOp8S5VVBWgHvqwhHwvjXSPfG8cNOI=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:59:28 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::de) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:09 -0700
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
Subject: [PATCH v3 11/15] iommu/amd: Add support for nested domain allocation
Date: Thu, 9 Oct 2025 23:57:51 +0000
Message-ID: <20251009235755.4497-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c83a3d8-4976-4c5b-44d9-08de078fe1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sww/S8EUPRFSVB40VyElK/D8gqUjBMTqbIC+SepgjAFNar8HF7LhV5J/mRn3?=
 =?us-ascii?Q?OWnzm+NPKfptirVVtpChTzvI7Hq9nvMbFxP7rltaMCQtXHiVdqutV7gqSeM4?=
 =?us-ascii?Q?uGmRn4C2H4b5BNqxiMQad27H7hk6W1Qq/UugSe4+JwvtlxV4vqTNN0Z53iHA?=
 =?us-ascii?Q?Fo2CYed83DIBoUPCxmQpPQk35IlGyJEqJ63qGOPW25wwnxcKGp7QnDQcQlv4?=
 =?us-ascii?Q?BPC49jDpwPTeY2P+JyveqTWred7YiDBG8gUj9xRh4/1yOmZzq7V2Oy20qj9m?=
 =?us-ascii?Q?Lm925IEIfq75PHxiv7GiDyapAatzYH89YlWk/y+36jjzdxUQ9ciZ1NpUPLmx?=
 =?us-ascii?Q?9V4tCcKPeeebf4dUXuwALq4BoPGqgD1Crl5sEz9aP6FanpSz6ldp8qQR+WEt?=
 =?us-ascii?Q?Px0GbsW39EtSz8txBpT5ygQVCkKYnVKKMUJANd7Dc/OFMYZ2YGCsl3uNwpd5?=
 =?us-ascii?Q?Rdiv9+Yci0of937v0V8F1WZGDoCgDlt9XPouIhPObOWCRqAOrTV4BB/8QJh/?=
 =?us-ascii?Q?OIpgU39qKArFuEwtb+kizWuj8mrf3DISWnBq8SfMKJilxtAztKUNmkUwZWpi?=
 =?us-ascii?Q?zDkdGYLBlnGX3kXxwF4DABjPT7Jp0k3mm0DgVj/HszCmJFuj6HSWtaRgoDmP?=
 =?us-ascii?Q?hkeJgfR6Nx9O9Mpv9wqcxZHV1L0z6q/5tQQ9JBRAiCKvJ2mpzZiSdp7BY86R?=
 =?us-ascii?Q?6ZW87nwm+UqRXJav/IvCXf4ayc9z8OR90iDUCDCgzv2/nrxru8RY3rLRgwyM?=
 =?us-ascii?Q?ZFT8oH5fUjE1EduKsMZtUPnib1hYH2qI7Xv0kmC7JbaOOIclHXQth6cd4OOk?=
 =?us-ascii?Q?760aK/QaoBlpFQ8kLk7A8xEk5EZOD/n0kuelZwZ9OiXnbqaiXSjAc7n8lop5?=
 =?us-ascii?Q?Plu7ALg+IoJBzMG0QKjOJ78bWt6Fzl7UkwogtnPN/rMYn4H/bsns6A0NU3od?=
 =?us-ascii?Q?n2VhVvC840oPrHT20/gmrKkkm6k3eeHoKF+ybjGF6FdrOvzUhZLBQTuZbZzy?=
 =?us-ascii?Q?A1DiX8cOmE6JTSgjoyM6d7GxOgEaG0Oo7ttuDUtHat1Y/PJFBaWxh9/Y/utW?=
 =?us-ascii?Q?VY70VkPZRfIN2SeUGQ1GhlTDEmyLEcKeUws4tm0xe7XyAU4TAmpve5zC9AbZ?=
 =?us-ascii?Q?80dNgSoCChiK1Gy+MokkMCyRbvZ6F2bprm8kcL73ZD/YnBsAffBmtKzesVsn?=
 =?us-ascii?Q?ZPru8o+em48ZcIXFsRscc9mnysUj7vXAs1WoYx48Zu9096cINRbBmqMzcy7R?=
 =?us-ascii?Q?AlJfA+QfN/SfosVkd6mK6qawwz+xt9dhLMcRfIdOPIxL420NowLFury5TDck?=
 =?us-ascii?Q?jWykbmZLTrL9gH1C1oj6qObKLWv9fIag1EZuw8VQUN6lMs2qiyyCtFkgMEgp?=
 =?us-ascii?Q?KqYtY0Tm7jeGLwklgtdgeNYiHHTXFudcuarTY9s0KGft4XRhPAl76YV4ZKn5?=
 =?us-ascii?Q?ToNtlrMBFeuh3LGWsrA+ORcZFzh5qJqysJ5rDpNBy1ks3IaBEQGC5FME79A+?=
 =?us-ascii?Q?DaxJ8fA/mFssejTPJ+wrrt+ZBZ3vqdP0tytVgBVJ9mL0dQfir+ZnxvkrNu9M?=
 =?us-ascii?Q?baQPhhvYmW0y6yGmz+A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:28.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c83a3d8-4976-4c5b-44d9-08de078fe1e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
table along with guest page tables. The struct iommu_hwpt_amd_guest
contains this information, and is passed from user-space as a parameter
of the struct iommu_ops.domain_alloc_nested().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  4 ++
 drivers/iommu/amd/amd_iommu_types.h | 31 +++++++----
 drivers/iommu/amd/nested.c          | 84 +++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 11 deletions(-)
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
index c34604cf1811..9374e6f7a19d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -20,6 +20,8 @@
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
+#include <uapi/linux/iommufd.h>
+
 /*
  * Maximum number of IOMMUs supported
  */
@@ -586,6 +588,25 @@ struct pdom_iommu_info {
 	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
 };
 
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
+/*
+ * Nested domain is specifically used for nested translation
+ */
+struct nested_domain {
+	struct iommu_domain domain; /* generic domain handle used by iommu core code */
+	u16 id;	                    /* the domain id written to the device table */
+	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -895,16 +916,6 @@ extern struct list_head amd_iommu_pci_seg_list;
  */
 extern struct list_head amd_iommu_list;
 
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
  * Structure defining one entry in the command buffer
  */
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..0ab5d65ec283
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,84 @@
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
+ * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
+ * during the call to struct iommu_ops.viommu_init().
+ */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data)
+{
+	int ret;
+	struct iommu_hwpt_amd_guest gdte;
+	struct nested_domain *ndom;
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ret = iommu_copy_struct_from_user(&gdte, user_data,
+					  IOMMU_HWPT_DATA_AMD_GUEST,
+					  dte);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
+	if (!ndom)
+		return ERR_PTR(-ENOMEM);
+
+	ndom->domain.ops = &nested_domain_ops;
+	ndom->domain.type = IOMMU_DOMAIN_NESTED;
+	memcpy(&ndom->gdte, &gdte, sizeof(gdte));
+
+	/*
+	 * Normally, when a guest has multiple pass-through devices,
+	 * the IOMMU driver setup DTEs with the same stage-2 table and
+	 * use the same host domain ID (hDomId). In case of nested translation,
+	 * if the guest setup different stage-1 tables with same PASID,
+	 * IOMMU would use the same TLB tag. This will results in TLB
+	 * aliasing issue.
+	 *
+	 * Workaround the issue by allocating per-device hDomID for nested
+	 * domain (i.e. ndom->id). This require per-device IOMMU TLB invalidation
+	 * with corresponded hDomId on the host side when updating stage-2 table.
+	 */
+	ndom->id = amd_iommu_pdom_id_alloc();
+	if (ndom->id <= 0) {
+		ret = -ENOSPC;
+		goto out_err;
+	}
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
+	amd_iommu_pdom_id_free(ndom->id);
+	kfree(ndom);
+}
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.free = nested_domain_free,
+};
+
-- 
2.34.1

