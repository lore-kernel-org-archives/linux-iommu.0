Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA12DC760
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299090; cv=fail; b=Zjo0DrNSdY8sMkrZKFpamtlPidgLzl0zhZe2D0BqH9CzirOfcHoz1LnSel8HZRaRkuzJTqbQRXvq6LTzN6nPYDndlsskmUqMMdf759dNp+Cgybh95xBPHAbykUsFE6GC7ygLrv6cQcJ5buiLYt1hrjLxeHZZwBWNyyIm5YDFteg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299090; c=relaxed/simple;
	bh=rBO9ocwE9SVn4DFqw5Uwffah4rzx+v9cD5HiqAiMtxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTLGTpgAnYTXzKv7STJ3gvqTgqHiHzEXDaIiI5ERai0R/ywmcxdkBRRBy24Ii7DFg9TE0ysw71Webs5omyD59evgiTRnWeeI+1woUdFVzyYs0USGCJbC+jeOb8WkCsVIhXfAG4ZeXKN/aNbQS/eZRz+TvVxmKyMJTWZFoJPRre0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oI0zcWPG; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oI0zcWPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6IcLc30zCisi2350vDXLy4JwIFcwZ2sQCaMCZDVHtEwjlGV6p343/o7ELiL8AubK/sXvUthnBk4YV021oYxH9UyU20bDgAU9RbzJTwXhXpjqwThl4wdkpaIHDQ+MIDrzG8Y9Jk1rDslcmRPhjIQ74u/G+j1PqLYztjzS+1Z4us2bmJpYByhLj/xk6XjpCaOlUjyTAXDr/OguLaik4hkRfv+BU+SHKINejtn5Q9WgbR18VyNVueHrjS1G4on1QAnGl62WXbuwZ5Oce4RwciSCJVY1uVnHCJS1dxhpNfX2W1P4mk//1nCg9SP0t6zQjUYQzjh+MP6+9bdcspSL8gl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI3vGQyXS0izz6kKtY6Np4CCF7UxD353yoyP9nNqYv8=;
 b=C+/SvayLRjudyfPTgvC9XJbqBlTqX6VVZmTAFVF2XEwLyMB0kgmH/Gm54h5F58UuVVLiFLLXIcicBv7u+iJUIW4I1eJUJpi13l9p6XUCjETnoDZJizJZkYLIxjg8cXtqGY566LjRp0H5tArPLQ0nw8MVgZEMWJoICYSTkZDNL3zIKyFymqnudNUa5q7dx0IeQzJnF0wElf7/utIn+18dZUV1WWpbFdLLFZPziQjkffuqxJcNYZrgxTuEBrPoRDC7bcGN5SjYKOFIv9ZttzNQ8OJempLi1tZ+7lhpoPEFP1+tN4L0hbcWUFjawJKHc16bDCdEBw67lordczBkRrJA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI3vGQyXS0izz6kKtY6Np4CCF7UxD353yoyP9nNqYv8=;
 b=oI0zcWPGaa+2BN7m010D8dYZ9PgibjcUyFk64p8Du0YQ5aLvZXDi2cON8FFKiYBqg/Ff/iNtT1bqFRUnletALKWa24aeVGRGVrRjAYMZn3H3nM9IBKSfHIC3lfCCh36aTQe/vY3RIpDLFHola2A8ldsWRt0b9VyTNkM6k+4hrEU=
Received: from SA1PR05CA0005.namprd05.prod.outlook.com (2603:10b6:806:2d2::7)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:11:22 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ba) by SA1PR05CA0005.outlook.office365.com
 (2603:10b6:806:2d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:11:22 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:11:16 -0700
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
Subject: [PATCH v2 12/12] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Wed, 1 Oct 2025 06:09:54 +0000
Message-ID: <20251001060954.5030-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbfc1ea-afdc-4f03-d0f7-08de00b15857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGDh5aw2ZlDiQdHbn0vfS3PSzRS6brgOZaUoyno5SwnqPKJYdiuDY9hamdl/?=
 =?us-ascii?Q?NIp5lcwGXBDWIqDxBGDpAsgEJ19KCTFBB8mtSs+69juBTdjaoJFxMFJ91Eoq?=
 =?us-ascii?Q?rDZykHHoMC1xKmuxyPxFBsZwnBehAmPa1f2TmzaicrGZW9mAD5K6nb7Y9zZ6?=
 =?us-ascii?Q?6DDYrvx2Jnv9u+aO+XlnHyDOGq+iBMrzYWYVcyeJH/9HOBxWt5PzLzeLeI1i?=
 =?us-ascii?Q?7lUXobMQTdoz+/LEMSwpT/JdvXdJI6Lhu03hlJMnHhIqf6etyq6XFpWi5o9q?=
 =?us-ascii?Q?KqY0G1tpLb8rA3GM2Xs3elVKSToie1lR2Z4bdf7JmO7qEtmVx9gA3Oo5UMzW?=
 =?us-ascii?Q?z3UAOWeyIIwlNw1Tz0U+xxSXDEcZUb4ilT6Fx7bwBkT+ftJVKHrVcNYPPFto?=
 =?us-ascii?Q?EZu0gsA3H4lYc6ZLxLn2EyAIPMOOWp4wrOB+YMSDQBVab7eQukTzxMfBzcQ9?=
 =?us-ascii?Q?sYe/hZ3ojr+Xt6m8M9Z2//f61OH0njt3eVGOusj6lHaEVCUwi9l5IeRnfye9?=
 =?us-ascii?Q?JDEjPoSBI+WfR5CM3Y/9esHNnKSK+LmlPo2nd413M6yByIXMkBPjfxGt/SJL?=
 =?us-ascii?Q?naaE7wy7Nj1yMc9AuRxJKQ8M93ggLqfALemB7NEQrokNv2j1qsDZjolnEQHX?=
 =?us-ascii?Q?Tdw0UsHSPobIrQAl7EyFVpL/uTNvGlOn90j+22DHBBV2j5NBE/gibcPB4fYC?=
 =?us-ascii?Q?7keHKqu/s5jsC8oG52kdNKEZmGdTBF2H4WDLqDOOzD9AgsWyIgAFL7V+J0Lb?=
 =?us-ascii?Q?nDs/n+jgxTQhkI0JThW+BXxB8VmxbMyvupEVJz2RZkmdjSlv7uozp5zilmrU?=
 =?us-ascii?Q?abJo6GoDdmn/Og28+oQ6/BoEyzxEK2BRuenhxVx91HIfEjDbMjR179WSThR+?=
 =?us-ascii?Q?ciu4VM5KXSSJ5D25vLPcENZorTGMzTL+U77J6fyBxtiA8ACM/0IVBBWjc9ke?=
 =?us-ascii?Q?GvAqJP1h6lpPfbRb3Is+j8fHcOVhL+C32hprI+ZigoGu1ZEkE9/MGIWz9GT3?=
 =?us-ascii?Q?4MKGMNwl+DgsPVjJfGzkRVnV0rtK64Tqm/shfgibhcqeZ7nrdhijFAxx3hpA?=
 =?us-ascii?Q?Evc9ueriJX15RaTUYKNBfm1xFL5zc2FYw/wGwubDvZ6dmkyyBQg8DwOxpUu5?=
 =?us-ascii?Q?Pez6R7F/6ThgMhwH0hyf8yMZccVlCra3Y9T3rV5qZmAX9w1ymz73xYXzOLL0?=
 =?us-ascii?Q?TcuOi7cJAHeDTgzK8p/MQskENqpk2lysY1wdQH6Z63gvZw7NrNyltbERPE3+?=
 =?us-ascii?Q?kXexcGrh0Tjp+SmQCDzs4Fv7AEyZcBnz+YrzBO/+y8id61JgzMiBTYdTsmCN?=
 =?us-ascii?Q?/AOYul2Q2cdOQbldKmbuZJTRuDEoaqNuVa8JfZGS0CgP2lnMHCptYEWh13lT?=
 =?us-ascii?Q?7Er+Oicg7lW+6+/seLzsJ4btEP8eURqGHPpu4hEJ3+tyz9SeELybFWGWBixk?=
 =?us-ascii?Q?3vsOJZ6eyMUhnJL3qrnUXgwpvsl7NcWUu73T4FidFSAM5g95FGdhfZ5pjpLS?=
 =?us-ascii?Q?cN22lMq7+BSrZ5bo2Ptj8RaiD0oAV1AQQAfND9BYA2WMy3AgPQEX1dloy4WQ?=
 =?us-ascii?Q?MLH8QkcjKX4JoUn4LvU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:11:22.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbfc1ea-afdc-4f03-d0f7-08de00b15857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

Introduce struct amd_iommu_vminfo to store AMD HW-vIOMMU per-IOMMU data,
which is initialized when calling struct iommu_ops.viommu_init().

Currently, the struct amd_iommu_vminfo and amd_iommu_viommu_init() contain
base code to support nested domain allocation for vIOMMU using the struct
iommufd_viommu_ops.alloc_domain_nested.

Additional initialization will be added in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 10 +++++
 drivers/iommu/amd/amd_iommu_types.h |  6 +++
 drivers/iommu/amd/iommu.c           | 61 ++++++++++++++++++++++++++++-
 drivers/iommu/amd/iommufd.c         |  8 ++++
 drivers/iommu/amd/iommufd.h         |  2 +
 include/uapi/linux/iommufd.h        | 19 +++++++++
 6 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 924152973d11..6cb929b657e4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -169,6 +169,16 @@ static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_dat
 	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
 }
 
+static inline struct amd_iommu *get_amd_iommu_from_devid(u16 devid)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu)
+		if (iommu->devid == devid)
+			return iommu;
+	return NULL;
+}
+
 static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9bc2e0e18978..dcecb5df2f72 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
@@ -1117,6 +1118,11 @@ struct amd_irte_ops {
 	void (*clear_allocated)(struct irq_remap_table *, int);
 };
 
+struct amd_iommu_vminfo {
+	struct iommufd_viommu core;
+	u32 iommu_devid;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c1abb06126c1..e3503091cd65 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3063,6 +3063,61 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+static size_t amd_iommu_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
+{
+	if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
+		return 0;
+
+	return VIOMMU_STRUCT_SIZE(struct amd_iommu_vminfo, core);
+}
+
+/*
+ * This is called from the drivers/iommu/iommufd/viommu.c: iommufd_viommu_alloc_ioctl
+ */
+static int amd_iommu_viommu_init(struct iommufd_viommu *viommu,
+				 struct iommu_domain *parent,
+				 const struct iommu_user_data *user_data)
+{
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+	int ret;
+	struct amd_iommu *iommu;
+	struct iommu_viommu_amd data;
+	struct amd_iommu_vminfo *vminfo = container_of(viommu, struct amd_iommu_vminfo, core);
+
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_AMD,
+					  reserved);
+	if (ret)
+		return ret;
+
+	iommu = get_amd_iommu_from_devid(data.iommu_devid);
+	if (!iommu)
+		return -ENODEV;
+
+	vminfo->iommu_devid = data.iommu_devid;
+
+	/* TODO: Add AMD HW-vIOMMU initialization code */
+
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_AMD,
+					reserved);
+	if (ret)
+		goto err_out;
+
+	viommu->ops = &amd_viommu_ops;
+
+	return 0;
+
+err_out:
+	return ret;
+#else
+	return -EOPNOTSUPP;
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
@@ -3088,7 +3143,11 @@ const struct iommu_ops amd_iommu_ops = {
 		.iotlb_sync	= amd_iommu_iotlb_sync,
 		.free		= amd_iommu_domain_free,
 		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
+	},
+
+	/* For VIOMMU */
+	.get_viommu_size = amd_iommu_get_viommu_size,
+	.viommu_init = amd_iommu_viommu_init,
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 72eaaa923d04..d81e4ad17d9d 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -29,3 +29,11 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 
 	return hwinfo;
 }
+
+/*
+ * See include/linux/iommufd.h
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ */
+const struct iommufd_viommu_ops amd_viommu_ops = {
+	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
+};
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
index f880be80a30d..0d59ef160780 100644
--- a/drivers/iommu/amd/iommufd.h
+++ b/drivers/iommu/amd/iommufd.h
@@ -7,6 +7,8 @@
 #define AMD_IOMMUFD_H
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+extern const struct iommufd_viommu_ops amd_viommu_ops;
+
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
 #else
 #define amd_iommufd_hw_info NULL
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 79d4ba43cd5f..e7084dbc5c95 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1038,11 +1038,13 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1061,6 +1063,23 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
+ * @iommu_devid: Host IOMMU PCI device ID
+ * @viommu_devid: Guest vIOMMU PCI device ID
+ * @trans_devid: GPA->GVA translation device ID (host)
+ * @out_gid: (out) Guest ID
+ * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
+ */
+struct iommu_viommu_amd {
+	__u32 iommu_devid;
+	__u32 viommu_devid;
+	__u32 trans_devid;
+	__u32 out_gid;
+	__aligned_u64 out_vfmmio_mmap_offset;
+	__u32 reserved; /* must be last */
+};
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
-- 
2.34.1

