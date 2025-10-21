Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E3247291
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011072; cv=fail; b=fTWpJAJmoqwlsK2mf9c4L5LNFa0P4SUdCDVxFI1dq+GN5sWPbL8HxdkssRzPSvz7BKNwXOLaldN1S9DAMeUMd2SxLIuaNScXz0qwH31mgjoaKv+Ksz+hiFAY9H95gXqnEemYTPGxpwcI7wCCpHPyV9CSoWDInGtqH3J9VvPEmJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011072; c=relaxed/simple;
	bh=dK78iuNw1GU0LUpbCsuLchi9/xmz8emrp0kXFd1benA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyrvIaQjuPhDa5jwQ2v4mQ14q/uJMfE0djt6J+loyxBxf/JaazZ6jopMjzUIGtlC2O9I0TWYl0Nm6IHVNvWAZv5GBg8pQrjqOMs4EoSVVmHiJjUzHQxRm1ZjMvqVg8QKV9sTWwq0nEenHfmiix3PkGMvxCcg5nHHBFKqb+8KAA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wv0yaqGG; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wv0yaqGG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyWuvHcAdV9F8C4ny2SBkCcn7KSTBys5j+u7cTQcRBG/xhsGcZPAeaiWPqwGzzHijV+HMQlvYI+OpHFtTU/HvT27d8jckDW9AjiV4ln8xTX/w9Ww5SFyBAhUVCdCADIztrlDZASNprx017h+7tYlkmhh/T+pinHGkU/uHxAvS6RDs9pcuKeKgnEMLNS1J7USaYA4pQ78XGRejlymI2+WWMUSh8mJxsGmkxu2zu9UPSyLBSdLsnrUu+NtepGpiyvK9dawC8RMmY1CY4TBtTKJK8YMrHiwwSK2Hjfk1sOxbNevIro+vVdWJC3S1Nn7NfibK1afv+8Tt8pn7cx2yezWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1rp0LwEkQtGMRq0olWXngTjy+D5DA/0En9iQJ/qp6c=;
 b=eYsdqpaJM1u4p0tlAcWi/4pJE4OWuLLxyC+drK3wxO/tqZV+5OBEekW7iswD/QZd5QmGdOl/U+wQLO6Fag6zyQbgL6zfHIkwvypS80wZBuBjgYLYkmiLeRoxSHEI2xVah4roeUmzUxnJT8qVDr6A0qVZ8WmU6TWIe819HeZv62ZBUvCCEteBNtqhKHStduZeZ5xpME56xRl3yMs+8Trd+z12+0bvTaqi486iEI7GTdBX9VTaG3UKyeP6rFvNkRD53xubwj1Pf80Q/JGI7gv6kUTQi0DvdrzG48yRVs3kmRvQX4sTwumdShUCqW4x0K6/9OVlxM+/mNhrgCF9zK75kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1rp0LwEkQtGMRq0olWXngTjy+D5DA/0En9iQJ/qp6c=;
 b=wv0yaqGGQJQtNyDWSUDiO9YzCbEpGqFN6DxxikzmbeuWJ+Qra1dV9o0JauADxx8OTL47zVMXG3f/wwLbOc4K1onEETHZHfOu37vA9EILMWtzqwujTcugAmHFTlI9vFrpRPUl64lo0XpgWgxECeaynlHK7hYRCDeSY4It4FIEt0E=
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:26 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::fb) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.10 via Frontend Transport; Tue,
 21 Oct 2025 01:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:18 -0700
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
Subject: [PATCH v4 06/16] iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
Date: Tue, 21 Oct 2025 01:43:14 +0000
Message-ID: <20251021014324.5837-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d9e682-daed-48a7-5fdb-08de10435cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uV68wZ2HEHs/X7j7zpYrtN8z1TYJed2hpBdJVqINwKdDFxelvy3EVpkpIFLy?=
 =?us-ascii?Q?N3wCacuj2pXf35NxfNe6uH+Wplsi+onX5zzGnc/vx2u+t2WoDSVFSLeQUoK7?=
 =?us-ascii?Q?AoxhsdPRliOHOyer+vqhMO5UudnQB+jlpsYDjW2RGD2AyXNMMA27khhlbAme?=
 =?us-ascii?Q?Wujm7Qm4BnALS+WPvn2lGCjxaxX4t5Zx2a/CL10mvLUEx/hyiMCU0dSuWJZq?=
 =?us-ascii?Q?lHIClRCQUvErsT7YBgPi/QQpmVnt67TEVsCSGQ7wpY6NuQBIds39JyeimNYM?=
 =?us-ascii?Q?rLW+gL9SbIz7R8EPoz8W7ZJZykLfKP8Tr8l7sehPirwiAhfbAlje4Nkln3ie?=
 =?us-ascii?Q?t8GoPvihsUNhRr/N3bWPYDeKyB0QSAg0SUjfTmOVPwIUxsVLzRMGN5KbGhO3?=
 =?us-ascii?Q?k71v4Nojaw4YfJubB4ILANIwNzPHOAu3VPf2+3ERDRZkriUlkX0uVi4ugOaj?=
 =?us-ascii?Q?t/iZEilEo2iGEmH/UuWjsLunzaNts2SLazCQAPeitGjYDcLrcAfX7mYf01Tr?=
 =?us-ascii?Q?7QNIa7K95qjA50hyq3PctTpQ0j24x8hptOO++KFtWGe9+ew8Dh+yJ5/6LZuP?=
 =?us-ascii?Q?olZdkf6y6f1Smuno1n2dfeuU2eKwpNDPImpkJhMDd7L+VZ8bAkz67iUskGYQ?=
 =?us-ascii?Q?Qrf5ltBSzXI/x56HgomNgz4MyqCeewcjERSEObgFSdWKrD4GKyL/m6UzQVCN?=
 =?us-ascii?Q?TqhNfcS69Gm+CYgkH/O09ngC1nYxz2qaNU5qJpv2lcLSH4jKeJUZyqtT7KxQ?=
 =?us-ascii?Q?DIPpEDwhyj/uFMMZ4WuxqPYAte3YyD0Vn3O4fWfEpBq7mt5UcvWW5gae8wfm?=
 =?us-ascii?Q?kYyMP6vXw4xadZBpBQZCJQJGidIsBBXPeSsrlKVsH25S+908oK3wsQA1rr+s?=
 =?us-ascii?Q?Zh1DoXBF3/RVuCzVjUIZV3Jbp1OiThSsCLlyBhDu3ZGddIllbyQVABzZ3Tp5?=
 =?us-ascii?Q?k+ABw4fQ9nV8EX+bfejUqgqYpE56uzMoAIAx+crrYp04Dd3kfu2GbOhenR0E?=
 =?us-ascii?Q?78WgoHKg2XdoP2ggp1sCElJ0CyrKtNH8P279Uoml0mfcpf+CUI/43VWc44yy?=
 =?us-ascii?Q?95Y2Y38OOe/SqQPW9DO/dTiI/uyJiCHJKJf2qxS89fIje2o6qzTOld+HpnGq?=
 =?us-ascii?Q?ck469oHONHWTiam3d6R+Wa37ZWfln3t1XaZBAGHUYO9LEAaJ8WnUcthC6L0X?=
 =?us-ascii?Q?YqG2/+chJWmQDLMhm3BF/RY1Nu3WN+fID3j3tSbnzrf/mzHUn8e5Fj0oROCh?=
 =?us-ascii?Q?+t3WpAVELCJoqAiFLyAOl4C8Jp+gfqJcufX2t14Fd5XPy3q1AF76DEw0fZuR?=
 =?us-ascii?Q?KI2mjltTPw9VJhZYL2i1tS+c6wdx3/T3LVodrO6XNM2K48IqiHot/8OzkAJT?=
 =?us-ascii?Q?yDDKORmW1x9oSWB3M12pw3vcortNi0hPbiP19qLVkWZ5CVyeavFPDx6eqPqZ?=
 =?us-ascii?Q?NGbFOXdxNc+70/00o3xsccDbaOJJVz5+b1SDJwzi0R13nE8fBE1uRALImY5m?=
 =?us-ascii?Q?VFwEiCK4Vl+gkxk4ZMy4aoNGeATkbx5QMEC71WRnQ0p4EQkOK5zVkjxFXrba?=
 =?us-ascii?Q?YLdJ61k5RYgDn530lOk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:23.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d9e682-daed-48a7-5fdb-08de10435cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

This will be reused in a new iommufd.c file for nested translation.

Also, remove unused function parameter ptr.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  7 +++++++
 drivers/iommu/amd/iommu.c     | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index eb46e8914eaf..c7cb4a80d44a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -193,5 +193,12 @@ int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
 			     struct dev_table_entry *new);
+static inline void
+amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
 
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f2c61509b60..386ac96b2c02 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2008,14 +2008,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
-static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
-			   struct dev_table_entry *new)
-{
-	/* All existing DTE must have V bit set */
-	new->data128[0] = DTE_FLAG_V;
-	new->data128[1] = 0;
-}
-
 /*
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
@@ -2068,7 +2060,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
@@ -2128,9 +2120,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
 	struct dev_table_entry new = {};
-	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 	amd_iommu_update_dte256(iommu, dev_data, &new);
 }
 
-- 
2.34.1

