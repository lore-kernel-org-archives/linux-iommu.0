Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F52BEC22
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689475; cv=fail; b=QqcamEh49/J+qe1cF7ww0xFdFnPl8dVjWnrVr0VZFOztSdpmJbUE3fVHx1iM5RT3qeT53pP3YcRQMMjKZKpBgjehACOJ0E37p1wmrh7ggqVpB3oDh2gSeT+wn2TGBjVxGN7LZQrwJcaNDDicCW9BnWXzO+IEXp7KG44gaZDj0Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689475; c=relaxed/simple;
	bh=QUIwbAJO6Yw+Rk02l6krgNJqXOjeSzZoV/Hkwhgh+xQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8X2STTKcjysGtesWooNiut3K7rv9idX99sHJMSzsBGslh+MtkB5icseHXEsaaqejJqmP9uuDfkKPJ27Yo+ZMEjMPbNf48HeCd9AvJT96XTCjdQ6sEn5oKTS5LO43HQsqcyNIgB8jwsi3eNVI0bJ6jcxob6KEjgDhKNtHRP5HRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=clUEc8au; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="clUEc8au"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWsand1YObnv5HTdijwYLWARa7iTVDimEfkWB+/P6U42DxA6IBafGTcJARc3Dwn+nXH4gptRr1L9gRf3cjs7jNeNXBNGCJ3iitERIAoaHAcoFva7G6SIRp/Ht5pG33xLAu/T9SNeu43jLjJinUJwTUp2tCdj5mLU5vZbBgx4KC+O74rx9Ycuvznw8KXD8ZAcvIffAZPQCxxvzXUcTDSXcx7kFEiwrw+g/mTnWJNTqDTaru/eug04YQaGDLfX58yYRSEK/NIhG6tyZcgeu149rHpPECkEnjXzI/4Ucxz8EMbcwXrCMBn3rDrNWbPtpTAawyvjzktaVbk6JckNI+myUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBYyCFxBbDrAzCAWq11jWWx1cGwAyOzYRlODBenSZeQ=;
 b=LU0Bss8V6MTNjj89/ZFox1jvKQrrq8Vb1QNDRkinfUO47PXOV3XyW1cxk1AcTQtOi83HsDE7tTkQ1KNJ/rjrq/k5R6TV/cqiil4ODW55d0bXLyoa/kQ9ynC8NyNsvBNHtZbg80kYtWHb1nLiHofAyEtd9VS6hgAc/aOufAMd8UGd5ari6oHrXrEuwmn4st9XBihPYTbbd0Ljyk2fRkvH+j3MNEXohZuodEke0R/IIXKQ56ywUGpVbzn4UZyc3lJj54emi6aM5MCJeEES5RJ6hzE89BoyW2Q7XJU4PJsjPyUkAZaPBzWq5HCUfHA2xYDoc9vAeZo61eT6CGpR32jMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBYyCFxBbDrAzCAWq11jWWx1cGwAyOzYRlODBenSZeQ=;
 b=clUEc8au5rV0feI6nz0N8WKQUEpomgdjZIJwqSH8urM+/+rNiuostkAu9Uy+2SBDw0eZGfmqsK2anN1HfVesFhyPeqLTAtZNMEjTtp163FhDnxMA2w/yBUqCvRZlmHc4gy+JRp5HIrCoQUVfKsTy8Nh8nnfPNsNv6zVUs7rZQi8=
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:31:08 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::24) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:31:07 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Date: Wed, 20 Aug 2025 11:30:08 +0000
Message-ID: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6679dde6-2f80-4d4f-fa2e-08dddfdd0e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NJhpOUSm44omjC/33DZwMmC8W680UFdNDjJCxA+3eLhosYnISt2mazy3fsU?=
 =?us-ascii?Q?moXrUMqGvQtTsCDdnx/F7EkevAaDYcwPsiNQ8IU8+uoF6ihppi0fmjhqcKBo?=
 =?us-ascii?Q?LvXpURbTyZ5eMbZ83OUBWdAsjSvxr4bVq5uiVHQBEW2mGIKVgBNOuWY+vF4W?=
 =?us-ascii?Q?p+/BV2EJu4eUmsD/R/Wrn5UZ6be8W0tjS0pgDmLJTrRuoV6yPYKUN5xFj5wI?=
 =?us-ascii?Q?fOXnT0TR3U2FFj7iqtNnQvXl+24dSCFkjuOvgt3CsykYQI8La+b6IMfLWIkb?=
 =?us-ascii?Q?x+vJFfSs40HBmGplS1TsMqRu3MRm8eGL6UXpdoWnw3MLQBdbUpiFdD+9q5Be?=
 =?us-ascii?Q?9sxeHFVWZkSyOI6BbTLR/YgLmmhB5BsKd9SJYeKoaflfxaRWjRgG5sY0W7lM?=
 =?us-ascii?Q?eVOOU2zzlx88E06csXsf2sqv8YVWlqj5SoxR0zO3gc/BQiCEj6oibWWJjvL+?=
 =?us-ascii?Q?DYuYrjbqgvwehxc4ve4H/J+PadXjqYZllmRxXWAb78re3iCAcm2Xs50QlUtd?=
 =?us-ascii?Q?ccBJ0mdPgbrV7PSOtIyH9IY0oiWfWyEPIZ6UQ52iXtnPsujxW6KyFMrV+sRA?=
 =?us-ascii?Q?CfQHGMGzo82VWqnG+w6r/XQbDrYr2ktPjPEyrQYlhh8iTEpKaCqABuqLiUEG?=
 =?us-ascii?Q?3uClEo6nH1SrvqvgDk436GoTp7D5kSic+MQzEkFDV1/OtmFli4Yz3rmiu2MT?=
 =?us-ascii?Q?KzdQsxx8QWXO0Bn2CMeG7iFLMBSXvHb22IUVKvzrPwlfJaKju622pKuIeI6s?=
 =?us-ascii?Q?632LGL8JVG9KDaIiwGqIeETcESbVaujyq1ErvWeWx0a6eXfpRCGvD8W4WduY?=
 =?us-ascii?Q?/h3mIXjXH3zGK6/jFv6vNz6xP0URzQIDPv86jRdEsNqFzsKIWij9LiWHdV1/?=
 =?us-ascii?Q?0OUJc4haOwcvDBrKSYS0v18MAAX7vQ50YFWzAhO6F7mgm/Jf+XoimGE9htya?=
 =?us-ascii?Q?I/x3l8M7ZB40FzUBE9yNUyI33B9wnutAZeAlRt/VELHBsDaCjyzHE01Seq4T?=
 =?us-ascii?Q?nNThZi0PZwrKu3e0HN+8UYyF5YP/XdV+7UdrCHT5iJ/FYkArib7vCd4RjPdj?=
 =?us-ascii?Q?v2m58b8UalQcVyG39vKR2OpmQ5eX9zIEa8uVQWmH3VBJ2O/7Say1UevnU/8i?=
 =?us-ascii?Q?bqSR+HAIPXfIGUn0dDK06gBVKMzM/kvDk7YY/MPvH0Ul6cASmYjz550ffBNA?=
 =?us-ascii?Q?BEm4RBrtMZR5JFwb0RSEf3D/S8muj0uft9gfiC0I+mRhtRwo3HS2+8EgeOsS?=
 =?us-ascii?Q?/rc+mE2zi21wJY5pwEXozRn6UN1CACj7y5n5C8IRw+3S1/6qZIsi17rV+Gp1?=
 =?us-ascii?Q?qzg7J3ORNMDqL3+h0f1nh/BMgKAoDe/S0eo4MT4NENzeQqkhfPtSLKxwvy6j?=
 =?us-ascii?Q?FePjxpoj7Jl5dF8ZacYScxmOtwtE14aWlMfnFwqcWgtGWMODoJhcw8zX7hZ9?=
 =?us-ascii?Q?g9mqRT02lvzqZHP9WxOoZn7nWN31IOARCxzLRE8KaRMaGJpha7pOMroBDEU4?=
 =?us-ascii?Q?7FxFOGuMcwm3FRjp2/R0JSjNiqyKIrYXonrW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:31:07.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6679dde6-2f80-4d4f-fa2e-08dddfdd0e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

The child domain is allocated with IOMMU_DOMAIN_NESTED type to store
stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
table along with guest (v2) page tables. The struct iommu_hwpt_amd_v2
contains this information, and is passed from user-space as a parameter
of the struct iommu_ops.domain_alloc_nested().

The parent domain is tracked using the struct protection_domain.parent.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  5 ++
 drivers/iommu/amd/iommu.c           | 22 ++++----
 drivers/iommu/amd/nested.c          | 79 +++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f398..9ccf9d61810c 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3ff380afb9f4..8e86d5b1d915 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -8,6 +8,7 @@
 #define AMD_IOMMU_H
 
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "amd_iommu_types.h"
 
@@ -190,4 +191,8 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+/* NESTED */
+struct iommu_domain *
+amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
+			      u32 flags, const struct iommu_user_data *user_data);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5343b99913e4..94f51a09b364 100644
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
@@ -605,6 +607,9 @@ struct protection_domain {
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
+
+	struct protection_domain *parent; /* Nested parent domain */
+	struct iommu_hwpt_amd_v2 guest_hwpt;
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 46682c8ba28d..ea790a8997ee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2616,6 +2616,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
 
 {
+	struct iommu_domain *dom = ERR_PTR(-EOPNOTSUPP);
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
@@ -2626,29 +2627,31 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	pr_debug("%s: IOMMU devid=%#x, flags=%#x\n", __func__, dev_data->devid, flags);
+	pr_debug("%s: IOMMU devid=%#x, flags=%#x, supported_flags=%#x\n", __func__, dev_data->devid, flags, supported_flags);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
 	case IOMMU_HWPT_ALLOC_NEST_PARENT:
 		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
-			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		if (amd_iommu_hd_support(iommu))
+			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		break;
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
-		if (!amd_iommu_pasid_supported())
-			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
+		if (amd_iommu_pasid_supported())
+			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
+		break;
 	case 0:
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		dom = do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		break;
 	default:
 		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);
 		break;
 	}
-	return ERR_PTR(-EOPNOTSUPP);
+
+	return dom;
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
@@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.release_domain = &release_domain,
 	.identity_domain = &identity_domain.domain,
 	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
+	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..09f2a455af33
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+
+const struct iommu_domain_ops nested_domain_ops = {
+	.free = amd_iommu_domain_free,
+};
+
+static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
+				       struct iommu_hwpt_amd_v2 *hwpt)
+{
+	if (!user_data)
+		return -EINVAL;
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_V2)
+		return -EOPNOTSUPP;
+
+	return iommu_copy_struct_from_user(hwpt, user_data,
+					   IOMMU_HWPT_DATA_AMD_V2,
+					   dte);
+}
+
+struct iommu_domain *
+amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
+			      u32 flags, const struct iommu_user_data *user_data)
+{
+	int ret;
+	struct iommu_hwpt_amd_v2 hwpt;
+	struct protection_domain *pdom;
+
+	if (parent->ops != amd_iommu_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
+
+	ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pdom = kzalloc(sizeof(*pdom), GFP_KERNEL);
+	if (IS_ERR(pdom))
+		return ERR_PTR(-ENOMEM);
+
+	pdom->id = amd_iommu_pdom_id_alloc();
+	if (!pdom->id)
+		goto out_err;
+
+	pr_debug("%s: Allocating nested domain with parent domid=%#x\n",
+		 __func__, to_pdomain(parent)->id);
+
+	spin_lock_init(&pdom->lock);
+	INIT_LIST_HEAD(&pdom->dev_list);
+	INIT_LIST_HEAD(&pdom->dev_data_list);
+	xa_init(&pdom->iommu_array);
+
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->iop.pgtbl.cfg.amd.nid = NUMA_NO_NODE;
+	pdom->parent = to_pdomain(parent);
+	pdom->domain.ops = &nested_domain_ops;
+	pdom->domain.type = IOMMU_DOMAIN_NESTED;
+	pdom->domain.geometry.aperture_start = 0;
+	pdom->domain.geometry.aperture_end = ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
+	pdom->domain.geometry.force_aperture = true;
+	pdom->domain.pgsize_bitmap = pdom->iop.pgtbl.cfg.pgsize_bitmap;
+	memcpy(&pdom->guest_hwpt, &hwpt, sizeof(struct iommu_hwpt_amd_v2));
+
+	return &pdom->domain;
+out_err:
+	kfree(pdom);
+	return ERR_PTR(-EINVAL);
+}
-- 
2.34.1

