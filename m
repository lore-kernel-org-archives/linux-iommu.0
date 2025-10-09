Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29D19EED3
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054318; cv=fail; b=C1+SO6H5bNyaCXKiyZgO6fSKxKox0QPPKGPK5/0vPxjZvcLvuDu5PWI7MU2Knb6sWPp9MZeqHoM52kIxZDmPp5+X74929Fh+xO+tGj43ycenqJs3lUvVVsAWh0zHYb4wbFnrPTbDs0JfD60OiSgJ6jFOqBtBaiBgcD2TJhqYBns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054318; c=relaxed/simple;
	bh=IFCBuqhggIF2sS15l0bY+H4I8w6yiWBseC1OfE93gCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMaLnUNJcL0duI9PE39hzFcXqW9mNSFy7c4U5AxhKK+BQWA4NjzdlkF9oRQcCy0LlOzoxdgfbLAzL3mhBrZBFONxF7Y2rxMNUOOqwRQCAcvp7RxPW+jr/uHL2hgW4NgfPYpfIQK8id/l+LtiCY2PqQnMxXD1WlqemwOlIgTnWRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+lD97/E; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+lD97/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmjv2diJK2mADxEptiTgOUz7Hqg8BG244wutoTpRAccLXo1g4Vw474v5FSMIbSVwcewg35+TY45czMRZw64/s2VZ+R8B+QrJrbN1+iEEco05DZaocn15wd8x2CUjPENOdhl5Nsqv3bG9sVxHOAYNUwiTC2Ww/UMs9oJIS9TtacdRZV7Ejm5lXMhi5LwgAqI9SxNwcgp4jan5j64NK45V7wwCsEgHg91vxz+tmNRlxSZewUG2BRj9zMW01IuzLalLq2drvKsdhhn3VWGJ33K6hipeLbVxve6stJ4QyGeC6GvjeuksNPpRpdeqGapnGdhNCUtAqMmvd4LBx61EffMIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBHZojDm71ybcYgHUqHxnA1QW+Tzcd5PZdrRem0KGsc=;
 b=tu1Xs0uN2LAvoOD3r+gVHcx2FzKYzf5bICY9wvWEyMCXNQ0PHKeGrZYDzSpDX9sDr4EeYa/iVjzhIyXBj3uUnxFQEgPpmPdEYy2ayObUd9/NCt2OM2osvLu1bVvuYTxftA6ZNnIPm6wHMYW1WLzUN5CtYh2PF6YXxpxTuhfCXRqCtLip+el5PIIIkGdoAVq/QebJerNMQeuqhJjdgFsorAn+dqExZywXUdF7V239xLHQ22DWRCT0XczclNE1u/FELzBL5L7oAkN/XUDEywPVTrgAB0ek/7RSBPODFzOxXax92D8bUUCu9nSDSjkfUgYNiLoQyTbnra/eG79aQCHTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBHZojDm71ybcYgHUqHxnA1QW+Tzcd5PZdrRem0KGsc=;
 b=v+lD97/EeozmqxdDNshDdIK3r/r6QKOZQsiub3m7ayiLUf0acrjAz7GIVw+wzVoOeIm9Nla3s7MELYStFZZWt4aRnSR17wfsk4aJe2sYFQjePi69iizHWibJwqZ0ermfpYH319gYBEAxEADuKtO7qExkVU61p6idnwINEh1eIdw=
Received: from CH0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:76::6)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Thu, 9 Oct 2025 23:58:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::fc) by CH0PR04CA0001.outlook.office365.com
 (2603:10b6:610:76::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:19 -0700
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
Subject: [PATCH v3 02/15] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Date: Thu, 9 Oct 2025 23:57:42 +0000
Message-ID: <20251009235755.4497-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d097525-14ae-4324-1594-08de078fbe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQaR79YrYAAjyR+yL7eyFdEwCXwrYc0J92zAo5FIglhIKuNAnaTWuozwutnr?=
 =?us-ascii?Q?5a6watZtAutR9TKN1fFkDkG4zxx2/qzeWT0ML9W+IpR3dIWHmib6yZrRBvm0?=
 =?us-ascii?Q?PhLUtzvv4ni9AlIuCybbAMjnomXUZShmj+zRi6aiD1axVxSAIx7lgVqTNGg2?=
 =?us-ascii?Q?FNfN7Kp3+eRm0+52xsLd728xnq0jCi9C+3t8DLOe3NKTsOZ9mlhzuWpQpYNq?=
 =?us-ascii?Q?R++G6C+O7dHTihk38/sAkOglkiETICY5q9uuezTAQmGmTBtlpbBnGz1/qv8v?=
 =?us-ascii?Q?rrUbstysI5fks7vHp6ceekWDDN1kjfiYf0AWtkEr0E57t55PPSUlaYOZBVWw?=
 =?us-ascii?Q?sub3nnD/gZZBsFElFwAuJyGwM/lXr8KOYxTa5Vs31U5WkYKvLuQ5HIloT5EQ?=
 =?us-ascii?Q?tqi7BRRjWUBfTdKddvYIFAAPEXPCUw4JUxh00nBPKvhMRA/9n3RaoMRxjNL5?=
 =?us-ascii?Q?EDj3te/VUwoXFwnqwL9SmwJNqkXDN7GwmckTDxhMtBBZDu4brm80zAZ81992?=
 =?us-ascii?Q?60vAdKAvdFbx0+9u5sqzy6q9xAGrlFU3flZiHOPoRMwUlk0O23NITezvm0sV?=
 =?us-ascii?Q?tyDePPUfeTeE6ECfkvTw2uwH/nTU9WamwxItlG1273CotxgS/C8OT4lZNG3/?=
 =?us-ascii?Q?uha6oZPvmZZRWDdqeVxHAo/0F1XImgrvZE7tQHBcjJHssSz86vCVLBYD6B+v?=
 =?us-ascii?Q?fIePHBbUv3RT7vYxN2PQbeVaO8v/rF4mqEc84LqjFWzbHOv6WoMbX1peeAfk?=
 =?us-ascii?Q?AdYRXRg0D8bB4HZs6g+HY3UTWiWcIzSjMltQPFIlJruQf9Nac8kne8SQPy9d?=
 =?us-ascii?Q?XMc5upIzZ+0BEd3T+HXi8+hoGfpa9XSz2HLMH064dGg4kz6LROKFfmpetfY/?=
 =?us-ascii?Q?34bRKReEl1hfUI0D+ZlFKNIkpnwrvIbuRUa4Zl4NC9vJoYBsRZbZTTsm6RF0?=
 =?us-ascii?Q?E0nJQmk6tGaDXbxlyutIamjYsG0Ui1yA/rhb8ohgEroP/s9Qgt77am00gogu?=
 =?us-ascii?Q?+duDbRE9CXVnh+2ZdPBhqBmY6ZKWLSh/hhqNblRFgGVOLtBiJPuOV3iTFnRc?=
 =?us-ascii?Q?wybX/MZeHqsquGwopJPoYddrvvdUeosEFrwsq/lx4WFGG1IOgKU3ugF/CH+1?=
 =?us-ascii?Q?I+Ep6/KArMnAs/vJ6GxLWMvCRb3jmVU4lgJ9CN6tEfD9Cr+hdTAABmJXYsK/?=
 =?us-ascii?Q?BJ2taclB6NzL3fnQd2Zdv8T4JZPiye4xaX6pRHXaOOl5mt1+xeezQJ1Vop/f?=
 =?us-ascii?Q?2dBX5IUeUlkE7XgeAji8wqbHs7w0v75Ymdx1xzYltEZKIC5RDxjtmRvKuWPR?=
 =?us-ascii?Q?+/MJOhYgDA1VsJAgF9ghKZ/wf3HFdYoITXQfm+8LH/ij5CmwCmiQuGMPIejp?=
 =?us-ascii?Q?3BJf3wpjzUJXqDCSfXvkVQCNu8NQgUu9pE5oJ0a1uorvRQmuBO7y/EXBvKRm?=
 =?us-ascii?Q?prHbnqwfnmiIjW28LCZMpYA8CU7y1e7LBAhKKj+Eidpco6Kbqs59h3w528ot?=
 =?us-ascii?Q?MWxduq2JJ9Pk9cMCsGtdrGRITojky0NGluBRJZyAHcduhxOcePCPXZx1ELW8?=
 =?us-ascii?Q?SCm/ZEyaLMfxpPyGGIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:28.7077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d097525-14ae-4324-1594-08de078fbe51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

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

