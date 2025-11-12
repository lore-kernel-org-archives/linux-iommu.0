Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C673590D5
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972005; cv=fail; b=cvQ8+cBJN/Wbl+WABpiCx2/Ov1jas9mC3jpML/B+w2VMGM+mOr6ENnS0K7uPR4quV1TsgoFrIUOvA3E+b07W91tWwduFTVugUOmI16G52vY3sQWqxe1NWktvs1T9gyYJwvwx2wGk2wWS9eNJb+OyGC+lHekfhgfekiWS0VXFCK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972005; c=relaxed/simple;
	bh=c/sTDbM4CUJPlXwEacf5R8qh5WDKbOi7E1jiDV06geg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAh8pwNPtOj45RsuHIJnx/d9JRHD3sHQSMKQ4GqdXnD5bu0sVHMLLdK4XEmH0GgEFgkHx5OctBGc/d28P0NseKspJ04jB5mKFc58gzYaapeJUOyFjJThMAJVA1CyVI92rfY6GZS5hpDNsPqxiygtNvEY7pPYTZ3Ftcks13+Dzjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xDSXqeeS; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xDSXqeeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQVYVpsvnoZ6opoesizWfL98kktg7i8/Y8YI92nrOQkAw3JN1zrI/2wFR7KgwO72gDVP1wH8MPcxmxmYWi+btQ3ykQwT+z89wkrXH6Igb1migmQmqddF6vGgM9OL+PLckscDx6zruQY5MyyQ98hwlYz127hhhu0TfyxXjP0wENGhXutgLen2U/EfjoxF3ufiklFR2WqVYGT9MFy9fMyeR+/gcpcBMBqKnEvgWLzg+4vQPYGxi06PjFk9GSGseX6shMywVcPMr7rRxChS5jbiPgHvkjZkwH9aTRe8nhxE3349Gp71qtX6NvLRUNTz6D2q0FpZdtjCEc54GilPKRZU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+4vEhRU038R80vs/NljpViMCdlAAIlIxNi6LXSYqps=;
 b=jdV+0ZPR9QRQjvLVpuK7IEcQhbNq4vJ9yoKjDUfUVUzunpYioYasWbsoujBghNLxlUVt9DNiYWdysW4I4aE1DIKtDFqzG406kaVplwTXY+5TO16W4tFjxKq5+D4oyghuC6cAFuVKyrTkyLxtGEiN7PtLuyy4zxRyLdVm4yeueQlSu5zPS9re3g2Qtd+GU6mK+UnX7PZqVMsFWs72a8OL62+N6bzoe+mlsGrsigx6OEN583dYqEMaC/QCs/RTsFTUUoEHZyaDN8O+JkSfQukxjtPBdGKbJLr0H3H9nWle/hCOmPXMUmEbWXrTZcoFCoXfJRgcYp9vp2MVYSJWDy4AnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+4vEhRU038R80vs/NljpViMCdlAAIlIxNi6LXSYqps=;
 b=xDSXqeeSIP4BDtZ3gB+UaeGuSGKwLcTMHG+83xZvySTqroaZKWxmh1J7NnF71AhwttjdHJy1nVztvNFkui+0CQL89EK8udjC6zW/wDmMIGZauAs2YeLiHiMlPgPSw8fjhtzOKDe4K7kjjkQDQu82Sbjm2HttUS/UF4wW2GX+qSY=
Received: from SA9PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:20::16)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:26:39 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::85) by SA9PR03CA0011.outlook.office365.com
 (2603:10b6:806:20::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:34 -0800
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
Subject: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host page table in DTE
Date: Wed, 12 Nov 2025 18:25:05 +0000
Message-ID: <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5bafc5-3767-4fc8-9085-08de221905ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+kiWZ0GeJPh1WfqcPe2VVwm7P8LwrCxi7Wj6wrgo+aTC3UFdWyBYLSXv4LYn?=
 =?us-ascii?Q?ngAviAd07YV+EMzxFBPYqMrv4jP+Bcxf8EI/kbmG+AxP0uD76xZ8ZFVz9dT1?=
 =?us-ascii?Q?8+6/6SxXbTQ6ZuYEYhgzuBgdeeBFnjj2+lfB5OPMl0GwTTDISqD0rAIJcm60?=
 =?us-ascii?Q?noJWCyUgvE6Kb/BdCf0l8ICSvDj9+fjZv/RXuxTSJnSsopMBs9jR9vuHBS+4?=
 =?us-ascii?Q?0noIGsWi+Jd1hSNFIvlbwbcY/NExm676Ququekr3/DzEWF8NzRJG74VkUUSX?=
 =?us-ascii?Q?Gj9v6qoEKgZH7XhFsPzjoiVRHgM5A2lbXIKmMOMgBC5ZHu7nkImcc99iwC7y?=
 =?us-ascii?Q?5560WfwRhCxLt1QJfHK1bEKr15SSykY5RC7npLsFFT8d8TVwUiKOb4prrlw6?=
 =?us-ascii?Q?YbVvU/0bdeutBXs3PzCkC77r697j3c+Q2IjrEmVsAi/ZbahYCjkWS/4lj1Nk?=
 =?us-ascii?Q?XeLYY1D6wQ2QVBuxnhFUXZnsGAw0RycKeiJEFU+Zg9XUPnw0q7kl99J+TBGJ?=
 =?us-ascii?Q?UADN7ZRCS9u+llA6vs7OGpK5atHoFn/BAvS8kjLtbC4gEfoZQe6cdBXit5Q8?=
 =?us-ascii?Q?Kr9VblHJ8mkp+Iy6doScrRWfcdAJGHK03KEcvSREdZX3rYB9wIHiBeAIMoCt?=
 =?us-ascii?Q?4KBXeQIoxnRbQFC8pAtPLl5tbsy2i4bURQQbrx9i+ZoZvxb/1phbx7PtVbI+?=
 =?us-ascii?Q?B5y0nNEmLSvin1++WslPeRayn+km+8eHZl3lY4lwlr/caTBejyUuWs3/d7DF?=
 =?us-ascii?Q?NklTZTnc/FOEs8bZ9O4ZfjZTDagMWIZzr5lQC/5gHJCaMtkV8XdJuh7pIYy6?=
 =?us-ascii?Q?qEw0AS2H8+R+juo4QpWN1VwbA7h/0N3bpvSnzJtWTULtN9wxeAZwyInf6Dr0?=
 =?us-ascii?Q?Pfc2E4p9muIbZVGMWH6hPjxMEXyZEQ43YmLCXJQ+cgdEw49XNnukMzLbd1+T?=
 =?us-ascii?Q?N9vYTsCPBODY1APc+PhCjNqYkJNE7gVldZ6lkA6BB/Vq7LB+TdiUbzSoWfkn?=
 =?us-ascii?Q?AYunRK+8myO80Ge3hO3iBpHOesqUDYblM2/DBnXWBQXC0Dei8Pc9VOStv1B3?=
 =?us-ascii?Q?cXbU1O8x0WElxPstzJPXnEToD3vefwHYxzBfqUyKUl1Q000vkS2ntPoyxnij?=
 =?us-ascii?Q?5vWTXZUwFqgOnAW0Z+1l5y2JVtprFvjcRxh9iHivahCk64ZLXadYd3aha29d?=
 =?us-ascii?Q?IeEfbBCg2NC0N0W/jXE+rauFMqxM/+7xdvikUSQMYQwU0d6uoIYUOs5afKhe?=
 =?us-ascii?Q?IYYotts8EfnSfaoJ7M4ymLoBAaJTnf9YEENrx5rvbohgNWFFcMoNU6WQozsE?=
 =?us-ascii?Q?MafP7iH07ZlCRfN0+nG+eGesa/WMDjGlMdpEN+ioLjSvwhDqpr7b5p5Hae86?=
 =?us-ascii?Q?woYu/BCG/7oyDZ0UJmIL+wmRAzxph7Ptc9LRQPeCpfOwnQBJoYWvxv//FiGQ?=
 =?us-ascii?Q?zvgwbsrfKJmuvKn+PafLD2beOCm7H68JVJUYkz6uttI0a5F7+kgnA5wNVWfD?=
 =?us-ascii?Q?5pFeTL/5cxpZouanCWX6V4iexROEaSI3UgH5bnIkoRLHds0nzEB9nFdZQjzW?=
 =?us-ascii?Q?5DijJwVvKR6ivbz4yCU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:39.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5bafc5-3767-4fc8-9085-08de221905ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

Introduce the amd_iommu_set_dte_v1() helper function to configure
IOMMU host (v1) page table into DTE.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 94 ++++++++++++++++-------------
 3 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ebedb49c28cf..df167ae9e4aa 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -187,6 +187,11 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain,
+			  u16 domid, struct pt_iommu_amdv1_hw_info *pt_info,
+			  struct dev_table_entry *new);
+
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 734f6a753b3a..19a98c6490cb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -352,6 +352,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
 #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
+#define DTE_FLAG_PPR	BIT_ULL(52)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 24bab275e8c0..d392b6757f2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2030,36 +2030,56 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
  */
-static void set_dte_gcr3_table(struct amd_iommu *iommu,
-			       struct iommu_dev_data *dev_data,
-			       struct dev_table_entry *target)
+static void set_dte_gcr3_table(struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *new)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
-	u64 gcr3;
+	u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
 
-	if (!gcr3_info->gcr3_tbl)
-		return;
-
-	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
-		 __func__, dev_data->devid, gcr3_info->glx,
-		 (unsigned long long)gcr3_info->gcr3_tbl);
-
-	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+	new->data[0] |= DTE_FLAG_TV |
+			(dev_data->ppr ? DTE_FLAG_PPR : 0) |
+			(pdom_is_v2_pgtbl_mode(dev_data->domain) ?  DTE_FLAG_GIOV : 0) |
+			DTE_FLAG_GV |
+			FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12) |
+			DTE_FLAG_IR | DTE_FLAG_IW;
 
-	target->data[0] |= DTE_FLAG_GV |
-			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
-			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
-	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
-		target->data[0] |= DTE_FLAG_GIOV;
-
-	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
-			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, dev_data->gcr3_info.domid) |
+			FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
+			FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
 
 	/* Guest page table can only support 4 and 5 levels  */
 	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
-		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+		new->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
 	else
-		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+		new->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+}
+
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain,
+			  u16 domid, struct pt_iommu_amdv1_hw_info *pt_info,
+			  struct dev_table_entry *new)
+{
+	/* Note Dirty tracking is used for v1 table only for now */
+	new->data[0] |= DTE_FLAG_TV |
+			FIELD_PREP(DTE_MODE_MASK, pt_info->mode) |
+			(domain->dirty_tracking ? DTE_FLAG_HAD : 0) |
+			FIELD_PREP(DTE_HOST_TRP, pt_info->host_pt_root >> 12) |
+			DTE_FLAG_IR | DTE_FLAG_IW;
+
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid) |
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
+}
+
+static void set_dte_passthrough(struct iommu_dev_data *dev_data,
+				struct protection_domain *domain,
+				struct dev_table_entry *new)
+{
+	new->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW;
+
+	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id) |
+			(dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
@@ -2074,8 +2094,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 	struct pt_iommu_amdv1_hw_info pt_info;
 
-	amd_iommu_make_clear_dte(dev_data, &new);
-
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else {
@@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
 						       &pt_info);
 			}
 
-			new.data[0] |= __sme_set(pt_info.host_pt_root) |
-				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
-					       << DEV_ENTRY_MODE_SHIFT;
+			pt_info.host_pt_root = __sme_set(pt_info.host_pt_root);
 		}
 	}
 
-	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
-
 	/*
 	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
 	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
 	 * do_iommu_domain_alloc().
 	 */
 	WARN_ON(amd_iommu_snp_en && (domid == 0));
-	new.data[0] |= DTE_FLAG_TV;
-
-	if (dev_data->ppr)
-		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
-
-	if (domain->dirty_tracking)
-		new.data[0] |= DTE_FLAG_HAD;
 
-	if (dev_data->ats_enabled)
-		new.data[1] |= DTE_FLAG_IOTLB;
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	new.data[1] |= domid;
-
-	set_dte_gcr3_table(iommu, dev_data, &new);
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		set_dte_gcr3_table(dev_data, &new);
+	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
+		set_dte_passthrough(dev_data, domain, &new);
+	else if (domain->domain.type & __IOMMU_DOMAIN_PAGING &&
+		 domain->pd_mode == PD_MODE_V1)
+		amd_iommu_set_dte_v1(dev_data, domain, domid, &pt_info, &new);
+	else
+		WARN_ON(true);
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
-- 
2.34.1

