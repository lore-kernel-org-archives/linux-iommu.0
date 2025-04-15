Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0B274679
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693114; cv=fail; b=bBCs5gZr3/nOwgr41hpF2tRTutC2cP+JlGUjCbYB9Xiw6G0ScX1x1eUftlAnZoqeZR9uZZrVIO5BlgayFsU/ySm8pMpnc9cZ/l3Ik8p6ANLNmvBdMxW7QmfpBIrgRD627xH2A45o4TmC72JOfJR2x06vR1/LaKXrCqmPZuW5S7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693114; c=relaxed/simple;
	bh=pNY/YyXBqriL8sNKcIYGtMgQvk+po5KO9+82hYhEicw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNstlUGECh6MTOpozSnRMrUdyi8WBDaydShMcqmofuOuc9GP9dEqqHiKTSTUnY+tqs/t0xpTcfxB2LhJENAOTkN5+JWkQh07e97DII7pCY1cwxS3gHFoYqR4eP4NoWMNERRNSVVrZF3nLBKuOMpHiKy/8d5+agzD2AFnKACIP2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWbbqcbH; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWbbqcbH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP7zFjBsXECXV3R1Bg9Jm3JxWNRP+BqCiUU4k9xu7mG9cuyxIcBFWghz4MokTan8cA6s1bX88P/vttfrZQucNw05y70DWTR7LwTyWZpW4SEDqsSEwFpzMvM58WUVCA4bjtx5rRTRjVV8y3ZvZ7U5E64DW6N4YZRxMBcrl0pbNJNM74oG/tNzDzPZkxbWeM3ZrfDHK9ONdSi7pLn8HqiJDdYWtMnhk8D+rrFpaaGVaif5lrguamGeSj0poPumUdzjYBoMKTTX6d7fSD75T+Jh2v/YizzUavYTFN2UJAFDQJECfhJcYutayYheusgGUgo4TOCPWKsQDTjAAj+ZKe3/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uq+7w9FcbqkqiuGprKBhaIHnq87wEEktyCmxauxDN8=;
 b=ILi0kUvqc35Q4M5XGCOBNZnkjsHvc3p6ohlk5fJu2+YxKwgwHY7S2ovrnwzgxWoz4Ss3wGxugyiPo4TcA5Iwj6VX0H0r8IA3qxJY0c72TDxWK/NOK9MLOx4Y682oFXqw0GluISIvewyIW/9EriSAvN3FKH1GhMf+0p3KuuBeCbSR3PE3QQfTz0P56JeZijJvEB+LC+WbzVey8eOt5wjAojdIjyA1lrjTDbPiztQ/3Yrn/SruEcD7wWJK6eCJVW1+bO8v6l+mEOJWd6fTbz+5ezI0ftPViDY6IZ1SLQHWE+fAnY8Tv2HoQHu0aDMm4B4CdLO4GcqWYIKHoQ0Y0VZdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uq+7w9FcbqkqiuGprKBhaIHnq87wEEktyCmxauxDN8=;
 b=kWbbqcbHdCRDzqrGpMo8AovJPAVXMfr+3pNkq9PKDNw4qSfdsTfzWVTXXETZRa+1kgEc583SqPFFa9/Mu/6WCkFOhq8melBFy6T+XoKR/OnSj4tFxmfJeN0+Sk1Omaf7C0GCZV6t2k+bLrjJh85jTwaUlYSHHW5FCkTRAoNMBDRtqI64knAdjZ9OYY1Hc/JNa34uvlLLqpc6ymglj21+l4DjweelsADTLmPXN44ugkUaloqq5c/EZ4dK6jZP3BfT3rpBqnYcOT3LzAvDmd1f3y6czijF7qSm7tig62+77qLXNkqCU0nvYkmNEvqpbiyUMQBwRYKPM2fKXzb2Xn5VfQ==
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.46; Tue, 15 Apr
 2025 04:58:27 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::ac) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 04:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 05/11] iommu/arm-smmu-v3: Rename arm_smmu_attach_prepare_vmaster
Date: Mon, 14 Apr 2025 21:57:40 -0700
Message-ID: <18d99aa79a024a80b51a821ff3dacad8f7276969.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: c5edb401-f33c-457b-fbde-08dd7bda28e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvQ2vkABlAmmTXlCPrunUIeW7r8hxscEOFqKDg/D6S4PM/hXM0TRwuxTmTvU?=
 =?us-ascii?Q?42xMj3D11gksCXXmEpOvPZ4VQtZGoJqw/XgPamGEJg8l0hLm+djl4CMBCceN?=
 =?us-ascii?Q?C01mX0yY/1C00GBrnCpUdRPTzBgRhqPYy/wsI3zucVmU+77jafVlfArzXH4e?=
 =?us-ascii?Q?oZnTIVEyQy+5ud1EXt+6zbA/3da7sJZa4gKCU99mFJMUZ5+9I66jBGv+1OXf?=
 =?us-ascii?Q?kcXqu+RKDuvmX6xd94t8YAq9UY/kpXmqlH6yp76AbicZatlRXMV0t7YP4VwY?=
 =?us-ascii?Q?p0MVK8gATWrLqfrYmk3dHx+1tIATsQ9eFXRC/28mJZ+J75yupp/56O5cg8Uh?=
 =?us-ascii?Q?PyNdAE+dJaUvk4EpWNfAChUAEn/mT2Ne88mmHrJ0CdKwjbd9djQi+lpVDMid?=
 =?us-ascii?Q?L150WJQyu82IMxtRAtZl49U5dIxj8oOOeHxjOO5ZqrfiEHIh1c3OQiFQHqeB?=
 =?us-ascii?Q?f5ssmgiRpOv+9uEb5tFTwENCuHwRncnJ3Zc33cOr1+2PhwjercqG2hdjV/VV?=
 =?us-ascii?Q?AER1VMSQTRpC1FMi70vl6Kl1ZeNcdMjNaCbS88oOxEShWCyEVKi2Z1TjbmHy?=
 =?us-ascii?Q?d5cULVI3Ei+X67lXxlhqUhjqiCFnj1EyGViFnTBargZXMik4/Wx/j7BpmOOm?=
 =?us-ascii?Q?zFUZ3EVmgcD4AGxLfEDwFzCrAMcQwS9udal8LSBI9wLCx1TkEcKC7EWK0rSb?=
 =?us-ascii?Q?d7kcpZU/+AxmgDmZjVj+dQm8qGKy4Qx6sziNi5G4m7XsyhjY5c+kJAtTpeMZ?=
 =?us-ascii?Q?7mb1auB9/2+W+1Le7Q+FYGs2YB0c63imMDYmjO1q8/ZjSuLxw5O+fAGUnO3W?=
 =?us-ascii?Q?LgfEpvWOXwEpHtvraqlje989jtfl4AT0lH79L30Y/PAcbUsYgG35mP/c7iVi?=
 =?us-ascii?Q?mmS/6+MK8/l5psq8i27AVY7EZExeiiD5O5nKB5s5NpRF0NAjyRY03MdmxZqj?=
 =?us-ascii?Q?rZQsNi9zw+0TsLg8QJYPLeayJSAPYYDf2GW08cSwtdB9+I7HS2H8uSdudRnx?=
 =?us-ascii?Q?q6cWMwLqxav21gD8+NTgLrMSPNnTIk4BwzV0ZXvZNFqqT7EYI7e7ajGsB5eW?=
 =?us-ascii?Q?cc74Var0qk4K8PlAA4fmWs1pyjIgKv1jZ6O4N2paEwpn50zE5vzZuPazGfLt?=
 =?us-ascii?Q?C71NDLA9kwMiFQLOf+lBZp2YKEsoiQNSgoaPKds8C/f9YfeWVcJk0xXyXa1G?=
 =?us-ascii?Q?iYnDBLuc0APQvYcPzknZOKXWEOFERh6cMU0r+5bV3ey5HtNmSql6snWLUzIz?=
 =?us-ascii?Q?6lqIqY+tXKpqqKqhrkrEYnSiATJ7w3TYm9oboAaPMCeWmn75tn1qbjAYhXkk?=
 =?us-ascii?Q?mDSRGq0YFogPtK6yC220ziKBGeSXD1wxuzeqphJ8B4UPtT7CuK6aiPbqZANU?=
 =?us-ascii?Q?Rwtp//I/QaMYMY+IEyJ7/XzrG0NVD0A8pIysIi+ly7eF/UAyOVtf0u1BxXo0?=
 =?us-ascii?Q?STd3FhvVs3I+VfPvxe3lOBGnd7oWE4zsA7nO1Tmk9FnqWPJ00LGgdyS7sjpU?=
 =?us-ascii?Q?ZXoMk1+DgpcrwLQx1f4NwNLfu6uaIyoSyRPL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:27.4672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5edb401-f33c-457b-fbde-08dd7bda28e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953

There is a need of stuffing more vsmmu-related routine into the prepare().

Given that the arm_smmu_attach_prepare_vmaster() is always called when the
domain is a nested domain that always has a valid vsmmu pointer. Rename it
to arm_vsmmu_attach_prepare().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 9 ++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 5 +++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2f8928971716..7b47f4408a7a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1089,8 +1089,8 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
 				       unsigned int viommu_type);
-int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
-				    struct arm_smmu_nested_domain *nested_domain);
+int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
+			     struct arm_vsmmu *vsmmu);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
@@ -1098,9 +1098,8 @@ int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
 
-static inline int
-arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
-				struct arm_smmu_nested_domain *nested_domain)
+static inline int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
+					   struct arm_vsmmu *vsmmu)
 {
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index d86dba6691e8..6cd01536c966 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -89,8 +89,8 @@ static void arm_smmu_make_nested_domain_ste(
 	}
 }
 
-int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
-				    struct arm_smmu_nested_domain *nested_domain)
+int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
+			     struct arm_vsmmu *vsmmu)
 {
 	struct arm_smmu_vmaster *vmaster;
 	unsigned long vsid;
@@ -98,7 +98,7 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 
 	iommu_group_mutex_assert(state->master->dev);
 
-	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
+	ret = iommufd_viommu_get_vdev_id(&vsmmu->core,
 					 state->master->dev, &vsid);
 	if (ret)
 		return ret;
@@ -106,7 +106,7 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
 	if (!vmaster)
 		return -ENOMEM;
-	vmaster->vsmmu = nested_domain->vsmmu;
+	vmaster->vsmmu = vsmmu;
 	vmaster->vsid = vsid;
 	state->vmaster = vmaster;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bafe7c7c2769..07d435562da2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2839,8 +2839,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 
 	if (smmu_domain) {
 		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
-			ret = arm_smmu_attach_prepare_vmaster(
-				state, to_smmu_nested_domain(new_domain));
+			ret = arm_vsmmu_attach_prepare(
+				state,
+				to_smmu_nested_domain(new_domain)->vsmmu);
 			if (ret)
 				return ret;
 		}
-- 
2.43.0

