Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDC24A058
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011050; cv=fail; b=WQN2607d0OxJvXeqmgurDI/vglxKjFD/15hiYh2LIhxUyd/LMYaXCxv/XDyMsfRM0ghlFGJGi+2QHZB7bAa2kVEKF01nmiZ9wKCTBFsaarst4mk+NmXWVdRb7JxVFBCfYLFdIyCtP2bYsC+twuCCF2e/rTfdU0A/NtV0eIljTLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011050; c=relaxed/simple;
	bh=IFCBuqhggIF2sS15l0bY+H4I8w6yiWBseC1OfE93gCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqo8r/Ee7zFnMjNn7Up4ZGEPMgkUYleAwRi369xdklo+8enSaB+3jwaPW2kcYUe9kEbRV1yY2P+NgocqFhtC/0tMcuLVniseMargbfPrax+QtIOqAs5w29dPBg36G3nlq7zRjJEx+uvBlBo6WD9UAnpBoFHnF5xFmI6BRQnG4GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b6YVdtF8; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b6YVdtF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuU5pV5eJ3NovrieRq6OmD3oc3MMxomUZAwBuQfMLfP5pSGJDZ8dC4na1d9O2mR19SvrXRjFLcHiBKzYrNTR+nBljv3GDfn+HMB2HITUDeu9zfI18SX7iGBU447FnroTLN5J6cOvjh80Rh00OAP/RU1rpSNFIIQQRjbMs9mg2tYePsX88qJXyCWFaBRurERYe2ARTjiRDuQUo6mwe1rGt8lvtCzoXeyAXc92DvSAIqamwetFhOzYEjYByvcMVK1dt0GmcS+QwXZZvpHoZPWBdCOJNo0wBrSFYKDoKaN3wgzvhFEonjwfp0YPbCPgpOZSnoJk76jyfXWKOIY+PK4Pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBHZojDm71ybcYgHUqHxnA1QW+Tzcd5PZdrRem0KGsc=;
 b=Hvl1umoF33EiHDen8xCsdPSuoB9nrvGrPYO7woU3nUBH7NtlidG1qopl+Fwvw+drIC4/teqweWNlS1aEYdH/qMHtey8raBUgQJLgMIF10Il7DjW021qOfioSKMU3cSoBFdIHsKqOzwaOt02LGmwzZlc1FDhqaxVXYCZbJjW1+buu3dSxNOfxoVwLCh4NHw037nP8B5M5jcKgTum3XbQmXDSNK5E7COx928Zp3whveTIc//nfiNMqTKxB02tWwhlMV9MDlXsuVyKVtz4KDVxnQ9fRkkMikXPFO085c9FDv8EOnzttC+d+ONt3ipnnC5KuK4X4EG01e8alwHM2FFNtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBHZojDm71ybcYgHUqHxnA1QW+Tzcd5PZdrRem0KGsc=;
 b=b6YVdtF861MkqMLelUtelA7akoIJ2dUZzU7Pf8igG/7XNYYIAfwBxjPWDje4mUEbdiAPImfH/JhAvGwfTg4pyqIZ/r+9B7XDkiiw/yArnLCb8FoiwhEz5aM9oBuD6pLk0pFJMvq4K/vF4p3wLNDA8gn12MCdMML6O1ehJBonZqY=
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 01:44:03 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::81) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via Frontend Transport; Tue,
 21 Oct 2025 01:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:43:55 -0700
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
Subject: [PATCH v4 02/16] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Date: Tue, 21 Oct 2025 01:43:10 +0000
Message-ID: <20251021014324.5837-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 749a840c-7aa1-4e05-21ee-08de10435094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIBqhyvytkcsQCgB3lAafWafy8jYsnwZSKJ6mnKs5DAL5h97ieTcjrgElI/V?=
 =?us-ascii?Q?YWa32zmT/6JMMgjGC7N1tZ/f1CwEYW4bbJtMjrstg7JJgSd4BUHUnWBMLm6h?=
 =?us-ascii?Q?o/tLWwtbmD8nJZB8ck1AIlqE/DtAbNQ7ykc3sb3/Ln83cp08HY8KJCPk7JZM?=
 =?us-ascii?Q?Btma4hk23W2rIc/IoiMBFvjoqnWlU5XIXF8VgxDurESQFmx2pYWbBg+/JIVZ?=
 =?us-ascii?Q?9zvQVXJz4TVTiZZLXRb4b5Fra8LfPsOghiUxP0K4uWWFqzS9HN199CJkPhLJ?=
 =?us-ascii?Q?5uARE7Qofsly5Q7Vj3Gp4LsS1582G9hA2pIpJ8dhtI8TdoteYQ+Dma0WcoGw?=
 =?us-ascii?Q?u3pRVmRtPg8Q/fmAI8Nh+kpGN3JYfwTIwziZEH4MbBkPL3wTG0X1pY53yS8y?=
 =?us-ascii?Q?COBopRBvRiyhCNL0Wn5fMprcXXkbe1USOG63DNKQYARyVyOBbTRauV+9e/a2?=
 =?us-ascii?Q?obL0WpkrME8dRWZ3yWHQ0uGwRSKZLjnXzRJidaNFDY7QgdSCzUHHaPf90gcu?=
 =?us-ascii?Q?ZKD9771lWn+WFUbuVVS9G7GgQ4KDrEzBWhqDQemREco2qK+XNCkJDdjKgsDs?=
 =?us-ascii?Q?RUp5oEssTHt69a9j5aCB0694s58fAdcA3PfH8oaTaarxxJ/MPmxT0pb20zEO?=
 =?us-ascii?Q?3nAgyh4D9O+sU6qRpN1Fpdqrl50DpA7GYxJN1JLMJKUKVkTUDplvwvBb9efE?=
 =?us-ascii?Q?RMB6ddvXYs/P10KWUIywxG33wVT+8cf1yv5z5NUECr0HieJhxZyr+o24s2Qy?=
 =?us-ascii?Q?zoi8/PpOa/5LmwSOwOyK41G3CuVI7aov00AS3uOQ4HjUm0PvAWih5Jm72BEP?=
 =?us-ascii?Q?VfSVF4zbCorfLWT+QIbcnaFnZqZfAr8hWGhJhLb8L2WD780wHZYz8pBzAfV2?=
 =?us-ascii?Q?K/LRJeq/r8gsnbFzV21u4Sx6SwIaPzBT1O5HpIcfixKON6Ka77cm3dQVXUMX?=
 =?us-ascii?Q?EJaj/ymj9p4YIodH1Jab62pzmcgaGAdtpi19kYNDSE6UMlTe7XdBdxRQ2im9?=
 =?us-ascii?Q?SM95u2QfhSVkBDwp5QVViOJ4O29R6i+OQIZrrWZVIDs+u27IRKbrjwbhKE1C?=
 =?us-ascii?Q?EBdvVlpEZGorl4BkFov+Lb6MqX/v9ey4Bz/f9Fdaz/8jAKPRUNQ/aSDVMXab?=
 =?us-ascii?Q?tmyWHvHa0+N2CPGPzKtx2raNfr3JDz0ifbRjNiRUloYx74askyXR5Zp/rsTQ?=
 =?us-ascii?Q?ELRQoaFRg5TSoiW50Y9IAn6Fh8C+jJRVyezcS1yDuYdwBveEiOPal+lNm/ET?=
 =?us-ascii?Q?8KjhA96D+ZmgtvJ3QZo1GR9T7NVUBKCXLBcBnnbzfT4P7E5Xo1RCZOOIUFq0?=
 =?us-ascii?Q?bvoFneVtVq7cce6yRdkXPghjxrpY+N54llFEQYRvxOHUGUxXwcrEsT9kugzJ?=
 =?us-ascii?Q?tJqsqS9IoCRonMQM+TNSD50I1DdI4ONpVS3RSyyFih6MpiwMBr8o7d6pB5Zm?=
 =?us-ascii?Q?lO60Heo6zL2icvnw+pZQUXbfjhvYZMAxKjAuFP7Cw+px2ehERsEVnutDa+0V?=
 =?us-ascii?Q?ot7jRpv6zuPFQEibYscXWiTYS44fwYEQchbtrTBxeDLW3S6LVTGWnvsOFopt?=
 =?us-ascii?Q?A0MuSALeAa0s+fDPnSs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:03.3503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749a840c-7aa1-4e05-21ee-08de10435094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b4b589a54b5..6ea549816a1f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+int amd_iommu_pdom_id_alloc(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a9b17d31a969..78b3e5485006 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1818,7 +1818,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static int pdom_id_alloc(void)
+int amd_iommu_pdom_id_alloc(void)
 {
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
@@ -1906,7 +1906,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
 		return -ENOSPC;
 	gcr3_info->domid = domid;
@@ -2489,7 +2489,7 @@ struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
@@ -2681,7 +2681,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = pdom_id_alloc();
+	identity_domain.id = amd_iommu_pdom_id_alloc();
 
 	protection_domain_init(&identity_domain);
 }
-- 
2.34.1

