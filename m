Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D429CB24
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873762; cv=fail; b=RzvrfA6z8ikGNpiOgntzP89yY2IEFuAgIIHSV5diQYzUIhnNJHWp2sZsUPlNhKub87bMQM89GeOIrKSNABeJ9XYnIOEAEPDpMlRXpn0aB/A62V3IxNp3IpBtIrYbsTchCEHN/4I3XoM9X3uQfGdk7NsF6E9Zc8QDIKjBZFbmtfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873762; c=relaxed/simple;
	bh=cyVzTxozxqLqkNpzo+HTtLeLDSQ8NrEH3iNOyI5qnGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSMZ4R2ZwU0cEKCJreUKnHK8J6HIY6xGALxz3BS00CCJXCgT8OGUeDqrIm0/AFR9TKP6ACl+4WOTgtDWIiwn1CJtu4geGPJz9Fq8jyqb+e54bDIzc4TosNZLL8uPK3zubjm/lvIpZc88sj1gr1sKAfarJI6h675kuL5ARd7ao/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8njWm3G; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8njWm3G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSy/xFnWvwAeFT01tba2Rr8h7zhe3SzT1PX+k6z9ku+fmvYwTXxBMcsX6T4/r8PajOmk41Ddo8U6ftnkmX9kHoWBbNHKHEsp4xgXZPObnMkoezRcRv7P+EJwiOnVC3dhQGMAM4aGpnv26mDXx9N/MRR3rIPfqFo3b+TFjIMBsNq6vVD+kw3vhDFEv83DLnPZMUIKoxI4RIG3ntLA82W05IEAIKGvOot5vawUfc8NQOslTUrteBi8T4SMWmaKK+08qBQ/RLql07fi0zGq/fryBW41gn6W8SM1a49hHcBIDdaEGrzs1esZHdEOdEvRuKq09Z4AOelZ2fHrpjg6kAoqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOiea0hhHE1Nc6QpnaK827Naz4FjMQgfJlKaR5bDqi8=;
 b=yc20cOUHYWvldwGrV3z0zlmeLCQeNUD6/Gi4KU4ZtsQaIiZYWdK07MhJKhYeZxIc8OIBBD4XLHbHG5d2e9thu6Lx8MtrDHK7gLaC1pGkIFR0ABTJbcAz7acPkNTMQATPIrpMuPkiYrq4Mpfr/SNEwd4g2T2beYIiGVwiv+O34odB/PvnONo1dJXjOGSPW1op4aWO0deM/FKGD7ZLHjsmpIfdsQYjWRHQJHkOn8Epnkf8ClwGzVu4K7q4rMkmnunmvprxi0k80ZZnE2SYpoUVud0SjrNXV7zvKrvzCvDIgBjiG9FsUivnXej4DtMqBvSdij1c5oVpuG7pqVJg3O69LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOiea0hhHE1Nc6QpnaK827Naz4FjMQgfJlKaR5bDqi8=;
 b=y8njWm3G5SB8CR8IQew7kLMTCBlpp0Ouilria7SxYsUY9QGhx7aecEUqGO2E8G5woWkgPqJO9RxdhhNwAnKKDWXwZKQ4FQrARYhf5w+egLJpqWGXpg3+BJda68mP80WspAzn3LRm7ayN62KXJF+fTw/poTb/6sSUVU8Nr+Myjl0=
Received: from SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::6)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 01:49:03 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::c1) by SA1P222CA0118.outlook.office365.com
 (2603:10b6:806:3c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 01:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:49:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:48:56 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <joro@8bytes.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<kevin.tian@intel.com>, <jsnitsel@redhat.com>, <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] iommu/amd: Remove unused variable in amd_iommufd_viommu_destroy()
Date: Tue, 20 Jan 2026 01:48:43 +0000
Message-ID: <20260120014843.194645-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f00c5-1bb4-4734-2e0e-08de57c61708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JGvtLuM5nswGsRjHLqPPJPhh4NVjPfc+n3xD2jC2Ruli/vQdCt+cF1rIfZ+q?=
 =?us-ascii?Q?YTJMbF1BpbBFNhzwNvlT+uQv8TPSnNsnAZg8oCgZRIjRbPtOXo7lHq4F429k?=
 =?us-ascii?Q?VZTvCBFyJAamHcMIpbHQOD5qhn1/QlU5uLg/PeNyMeI0MS4+ORNkXwsI4LDx?=
 =?us-ascii?Q?WCSvF4wn3BanUgRM34GcYm5lbF0AMfb6/GyRsY+cZK84zA3a/hk1mZuxMZ5u?=
 =?us-ascii?Q?POlICBl+Sol3/htNAyzdq8udf/yEt+qun/j6zP1GY+UpdHadUnHYRhvRwLNi?=
 =?us-ascii?Q?TXvmjb/8DDrpCYfU1YmrKWcVo0y8romMtl3OFAS1fYDs0ci7wMhgIRKVOOrF?=
 =?us-ascii?Q?3jRdVIekLnkvtkEjWuh5Zngl8Pe/+hvgKwmSobsCcLgdwDj4Y7brXcMIvRx5?=
 =?us-ascii?Q?5I+9FyBa1dKcVdY6fmmocG4N6X/iDNHJrZl/wEDjpimRxU6Z5dxgz2NSH0/C?=
 =?us-ascii?Q?CSk+4yJdAYMGul+VeQWv+h/ZJmvAQNRFnH5f1N42Y/ywkNN0Cq7H0xuYXiTq?=
 =?us-ascii?Q?orZqkQux/NbC7gDkRuYI3zpwVW6opE62Q5XO4T3BZUOIDWjeOO7x1jSkoRlT?=
 =?us-ascii?Q?HUpZeoZ2YGubPwWF5WmOGC5nl2Mfrp+w6of7+Xm7EecUYrpghGv+oZisVULS?=
 =?us-ascii?Q?AziR2YWdo6cj/zxKIyDCrQ1eRNCeeeQ94vRWBLizN+p0bZYMzPdopFt2VTi4?=
 =?us-ascii?Q?PtqNY/OaPjYCjb5JC8Dqeo0KFIqg+KGVcPRLwkKngG89Vs5hRN9k2aqjKoOq?=
 =?us-ascii?Q?lhwreG8DLHxVFVOkmA2n4sGvUcDUeYt/fXLpifUjz5IY/o5zkjj7zULwlO5a?=
 =?us-ascii?Q?Z/zOnoEa3D/9TtbVJjMzP0V911qHKpKwAwfx1wKUgDcDE72aOSfxwUpZeKRo?=
 =?us-ascii?Q?NcOJQbqiucHnq/pz5ttcgqvE4ZcgnTU/x81TvGd082pMiO88npn58dBZ22xl?=
 =?us-ascii?Q?NiPRSRC8s8sJhql/iMvwDHBvj7+R41oTdp6rrtlyGxeoPHQzQEQioiRAErni?=
 =?us-ascii?Q?xwATPB0CQDVVQdzte2fyl4Dm28nt10ABejEbCFxkUfzlsenY4fwE6gZ86Sby?=
 =?us-ascii?Q?m5kzIDUxs+5pqowph9k1h1LUGv0Fp0aLjtr/hLd0gFnFzXi5bGdg+JuedeTS?=
 =?us-ascii?Q?zimVDSCDmOXtSxZFw5Y2ziHEu2ol+K9dV1VxJGV9Z9EbtGKf9iJWDpgxxkri?=
 =?us-ascii?Q?Vd7b2G40OtEBppd70aWtR3MVFdcF9F5hYwFNga3Lj/7YHE2PK4Wy1SlkVWHY?=
 =?us-ascii?Q?imIcdlIZSkpKPILxVXAPn46zV8vvPgEUnrydDDHBTHfi0dqx3SbJWb17EDvj?=
 =?us-ascii?Q?V1UrxmVqvvNxFp37jUVBMjGloY0YS71Pznlee+xb/EJvI5LEGOOg4/ioI1P1?=
 =?us-ascii?Q?AxXv80mA+DBio012r5wsi7PMrH1v7Q1AGOgQanK2irnt4j58Qm9nSHVWPkUq?=
 =?us-ascii?Q?sjKyzMlDGqt0ZQsPXAxQwkKgtb5u5FumlIkmv5+0eeS2o0Qy1y8imN4Ieare?=
 =?us-ascii?Q?+2mMe+m/GE/PoTlIH1ZNc+q4WdG62fYCaqty6C/4J0pzy3xDfxjTlFpdofk0?=
 =?us-ascii?Q?2UJ04WkVxpkKdcPMCFrj+pLiBBI2L/rnzHgtd986FbeiU23kTudQsUUTtqI0?=
 =?us-ascii?Q?2RpaWIySh1Ree619ArnJ4waLjpw3QL0paS7a4czUPnoUA8utygcw/KSxBQZr?=
 =?us-ascii?Q?mRJccw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:49:03.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f00c5-1bb4-4734-2e0e-08de57c61708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

This fixes warning reported by 0-DAY CI Kernel Test Service.

Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601190634.bl7Mjx5Q-lkp@intel.com/
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommufd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 2e50633d9c72..ad627fd5ccc7 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -59,7 +59,6 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	unsigned long flags;
-	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct protection_domain *pdom = aviommu->parent;
 
-- 
2.34.1

