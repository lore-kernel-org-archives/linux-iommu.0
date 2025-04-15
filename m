Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625227584F
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693125; cv=fail; b=rqlQEnyUgMDtZtlpOs2TNliiDeGVB5iZAXmwgEs4DktpDXuUFuu5EcOC365HPrURn4lj0aqQtTKH26Qus2ckl7P81lIIZ4U242UC9wE35pxr3TtjgNIsonNiVAkhZpmRl19BTkNJl3rubYwZ2IZpq5pXKKJbm0VSRnoxnltDCrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693125; c=relaxed/simple;
	bh=SYTCocctqEb2D9tTXjI1X+R2C0xUe3QizxXUHF+J9sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvRU0g8+jdIEHwXRYOkhwwayk8LB9Y8Ay6td5EUdGkcBVvfdwgtRVeGKDGmRIit0bUpelUzW4w+vMPRAECFXxZto1drSchAV822sjFe94rSGv6YCMvIPiCru+xMJqRUcfLscVMwYOkSbYiJY4S5vd6gXOObQtepnMwA8iYGn0QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/Ahjx0t; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/Ahjx0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBRbtVYKtCGeQg/Dh4wyDKl0mnsztfNrRGQTqjEoc6p4lfEOLzdrip6G1NRkK4dxZDDOzWli71ucwXBYk3Cwxk7KJlx6Rde2wPkccGAZBCaFD9b9+91mIL7tVPhiODPhygpRODjXtxf627c1l7X8/nC/DAxjeKUxILtJuEWeoD/q4XU2GTuH0I0BcLVep0ZROtIc5yz/uW2RvEWQOXMXS7yr882bX8O1a81YAYK/McO+I3AV6jQPdAxJd0qNhL30WKxOFcuRhP0dA1GeR8fa++pojyDiNH+PLpS3DafcUmJYQC7W2IJHXdZUvxAuBbFt/A2LCKqKCwIZznVF64233Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZWbtBHZnDON8aPXISxmyG/yHAYHK5hHCsTsyINiglI=;
 b=Am52S9vLo7bPh3PORy0IQCCP1e/+661rev9Wj7h3Xez1046opUuuIhkuI3N8wBIkaweMRm+Riukq+/iad7ZI1CtXJphUWuX8WOcsKdrAw7gZuhIm4Wa3qfvoAlIOzXWyamnSGYZMr80GkzPfxxeZhPgfNzSKSP0j9Y0dcksFacZ062HOmN+glQ5yElX9wh3pwfm5XJgi+GnIEE1w+Ox4O2AkgNC4doXn/D0eMqaGzqi70AHPRytbL0Vbndg16wzFwZ1RSZrujG0DXguKWq0A79ov/CXBr6NsGkq1esT2ZzfOwW7pcTrE+QgI7hPOwzhG6CCJ/SN1EZcJEJl5YZdEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZWbtBHZnDON8aPXISxmyG/yHAYHK5hHCsTsyINiglI=;
 b=S/Ahjx0tWvYAM++XX1sL1eqxAC5AC0qgK2to2JlQjcoTGgeTkcRyACHyTw9xtSrjMu2XBd1cUPDSPdmmyy2CuRf6TuRMGY3PjlyuOD19D52DWJD4NHRVyt+Y9F/u8gUrEq79F6aKihs/MN8WtLfkhtPpU2Zv1uFmwAHcs3tN4BUJMyPQ9xD2hEZqsxo6CSCIzE7Msmb6tdVjaAlLTQjd8UYWt5KR/BywYXfVqJrZE9oyRdl6sUHuZ9AQ367ighe3eIIvqjsizlCJ5NP1glfizTYlGkfxe5rfNFwlkCiY+9rTmxFO4svwYC/83k6O5p5cQfbG5BLNJOE3i/m9S3C07A==
Received: from BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 04:58:37 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::64) by BL0PR02CA0073.outlook.office365.com
 (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 04:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 09/11] iommu/arm-smmu-v3: Clean up nested_ats_flush from master_domain
Date: Mon, 14 Apr 2025 21:57:44 -0700
Message-ID: <c90ca01bcf0e61f2e9a7706d0019f6fb21895b78.1744692494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dec1d7-abdf-46bf-8ec7-08dd7bda2eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poDcloyORX+DANuBed0lSD+xM+nvgkTl3Qe55aFFfccS/UnJdCvI7pD7Drck?=
 =?us-ascii?Q?j3Oh5hkKGFgVtjJ3IKrGa3b/ZTwbBZDZg3OKZWN7FC5r5wUME+RvM31JnqmQ?=
 =?us-ascii?Q?nE62ySH1JciMr4KKXPjqcIlNcNKH4e35escaE3HulJ5goWOTtvGBRzL7Humm?=
 =?us-ascii?Q?7QWsO19CdgDKXTSemQ5G7TmEN0HQmI6oOp5tlu3YwysfD5HDOIrQBWgfMaAF?=
 =?us-ascii?Q?hq5tCYxws+D8dKBrbXM7LY1R/M2IsIHYA+JbwIHxq7AGhfs4bZh2cQ3LwJTw?=
 =?us-ascii?Q?dsjCXQ3LlMYqynBGANcQteIgyo4ClYotRye9HWmdF55yPPV2qymw+amvhw15?=
 =?us-ascii?Q?Xf0i0pnX10X8HdYlNtiN/CPGn2e8MsGJeMG7zURyT6mSlj4QRMvH/Lx3Hevb?=
 =?us-ascii?Q?NE/nNSEqE6eW3//FQgd8idonbGufyDBuV5oCR51n1P3norTNhrrQYav1HVrV?=
 =?us-ascii?Q?xNIq3eT1y6lduSPsONbyXm5KSoyalBOnfAdV2XITIi5OzzoGJKe6uoSV9leG?=
 =?us-ascii?Q?030EIA95CAnPnfJUG7C0tFP8rhY9HLDtxpt4KzxWbmt9TY/FV0rigMaMaSXN?=
 =?us-ascii?Q?q01KFmywJynebEDR6nVAGXC9RJ1NBdB3Ll2u91d+rRR13Xq2DpljAEWLUCrk?=
 =?us-ascii?Q?Q0SsGwND1p2YBHqAFg+6k9NAvLfk+4GFK1iSdEaDONFB5cKrhGB1ta+7UxK/?=
 =?us-ascii?Q?uX0FNw3jotpTWNVdjIQ04wOqo4R6t/wJyDNL29EsBoJRaB+UpUJChgikIRyJ?=
 =?us-ascii?Q?u9jMY99TdwAfmMGjAn5KWn2HUGrU/hEklQJkZ05Asd8pI/8jYkSd4KYZHLHH?=
 =?us-ascii?Q?R+X3NhKWSJd0KTyxSsNSwfJu0kPuova/tGpnVwUSilbdqYbfGMB3jWfQUj72?=
 =?us-ascii?Q?GWALUjzNmwgzsx7XK+SaN0dSYJc9UX1+i4+HhT8MPV6wVHI/2xzYhq8mc4H9?=
 =?us-ascii?Q?oskwYJEyw3GKPkVDxHOjEWMmqYdLsAK/JJ2IE5wORHEBbsA/1LGYQI6PY8Mw?=
 =?us-ascii?Q?T75wBSqcrlyr5Cov7o9Gatx+z14KEjC2xrj0uveUKvELdZC8DnA9NRpPa8bJ?=
 =?us-ascii?Q?LmoZm0a2iBY5P29kN2DISVvI4LYkbbjBQp+dn6lGDwyNGjOjnO3HBkYvq++6?=
 =?us-ascii?Q?4EzVlUNkRgpZsxOKD0Ho4ZI8th0prlB5EehVTiKC96mQnTG1mPFb8ReniszN?=
 =?us-ascii?Q?se4bVtCQUAJTcy5qYYCpSPfRH9K4PfPqOfuMIGLlT7GjGUgiHbsqPgRtLlBT?=
 =?us-ascii?Q?s41T2UFw8+A3zT2LvRI1UC8yuvsevWS4Un4ZRiGrbzetfbVx7vMwnOr8+K6r?=
 =?us-ascii?Q?aJhNCpeplHOdqPWKQQwD6xNAGJGdfqTjXkob3xgUjJeCamkoP31YN/svy1XJ?=
 =?us-ascii?Q?8xQx7U0fgu/SsyVMMzxUT5j/F+Dn0+baB8lCkJTGqrAKB3VhkG7mIJ+P7bJr?=
 =?us-ascii?Q?RQOsEELXyd+M3j0neLW3OLeNJhkzH7nNnY21MFAjtcCaGJXldcKX7bDcwl7E?=
 =?us-ascii?Q?aGUPRk4GzQRWWZBkAmejyVyzhYSkCRsbd8VY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:37.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dec1d7-abdf-46bf-8ec7-08dd7bda2eb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

Now the ats_devices list is maintained per vSMMU, since an S2 domain could
be shared among vSMMU instances.

Drop the nested_ats_flush from struct arm_smmu_master_domain, and clean up
the dead code in the related functions.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++-----------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c9b9c7921bee..477d4d2f19a6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -921,7 +921,6 @@ struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
 	ioasid_t ssid;
-	bool nested_ats_flush : 1;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 483ef9e2c6b7..4b9cdfb177ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2221,16 +2221,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 		if (!master->ats_enabled)
 			continue;
 
-		if (master_domain->nested_ats_flush) {
-			/*
-			 * If a S2 used as a nesting parent is changed we have
-			 * no option but to completely flush the ATC.
-			 */
-			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
-		} else {
-			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
-						&cmd);
-		}
+		arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size, &cmd);
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
@@ -2717,8 +2708,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
-			    struct arm_smmu_master *master,
-			    ioasid_t ssid, bool nested_ats_flush)
+			    struct arm_smmu_master *master, ioasid_t ssid)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2727,8 +2717,7 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
-		    master_domain->ssid == ssid &&
-		    master_domain->nested_ats_flush == nested_ats_flush)
+		    master_domain->ssid == ssid)
 			return master_domain;
 	}
 	return NULL;
@@ -2759,7 +2748,6 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
 	struct arm_smmu_master_domain *master_domain;
-	bool nested_ats_flush = false;
 	unsigned long flags;
 
 	if (!smmu_domain)
@@ -2772,8 +2760,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	}
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
-						    nested_ats_flush);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2853,9 +2840,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			return -ENOMEM;
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
-		if (new_domain->type == IOMMU_DOMAIN_NESTED)
-			master_domain->nested_ats_flush =
-				to_smmu_nested_domain(new_domain)->enable_ats;
 
 		/*
 		 * During prepare we want the current smmu_domain and new
-- 
2.43.0

