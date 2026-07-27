Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45D3F327E
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158990; cv=fail; b=DfIAIn7yojz31cDnhg9yXismcbVdrTDrkGNBLb1Kk2SHBjcvqg/zjVc5h4rx2vDO4cTYSrN8C3i4px+QimwM2I68k7p3MqEidzRPXtsPK9HiMhls5ziHugLUxmBPTCeBbFfNyxDVTL28OeTMoLHM0jbJEJIcacYGLOxqgMKxOgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158990; c=relaxed/simple;
	bh=odHT2BNcAHB4NqygKFcS7aQfHDGVKq4cEY1M4C1kjKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYABGIOT2jMGrqKCJKDDvLSZSiuaDtNP/v+qd9JVQF/JcT01h2r7vxqUCRPMk+TedBf+JOOJYjVKRYWhxVWTmNHVffheNQ6jUqrH+YKTrGYa969IGiJLkbQzAq/eauJeV0yy9foKatLneuVSXL1mcmYDthWxxXvjNEXHIAaKvP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f1S7WE4A; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f1S7WE4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxxCZMNxRehYMk9mz6dFC6/E3bjRoc/swgTCP+AUod9c9YHkus/ThN3RiVVhZ/8YhuQySZzXVkJqC8eJV2DW3Y/wqChruZnJliAOWVu0s7dzDiJsYgYImgeJAjmmKJXsM51RKC4dofHZsZ5Y4m0+93CgGoqKep2xgNJ6JLTeFfTkQVEG7ESSlLClO6GdRfVIjT0dcb8CIGB53sQHtjcbGMrn+xXAcV4uPdqYkaJUWuJZ+V6TL6ShNXuIIkkfY5uJwbEhUqTjkAbvNAtZc+rFPVu/nlMQ9M2FBwsLlFgDmoe6QHWefxc+qfmZxmdgf5GtdYRnViIfboC/rU3RnoDwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=rHcnAScylidLBsNMqP/ODPs1D0SVMbjywHdrEhBCG4Obe9OqpGFYHBZf9wvdzlm9JsfsbTzQxxohRYldiyZVwxpMUtlZlS1VRGSe6lBV8I/jCPE6EC5MDPFQZflgByQtJ/tsGrmRRNnLAT8/1Vk1IK/SO+PozefZwGc8YH+bfD7OsirxAZjsSUEvycX6VRsAhBIExfjubh36PaL99LrlmFP+ZoeVm8MtdBakrGKRw+AGQpF0LsFiTPWqR2cnya8WjUlh/MRnKlCNEko5NMAJ7FA8Cz1HjAyLv+XflOQQFCfDXMtinG13KIKt3PxWpjIHgn+nqGheumQtTgF1oFD1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=f1S7WE4Axo8/Z68C3mTIwkdxf6r7H0cWhKnT9Az/s86971vHjdqYb1oEPKtLOGw2KJ5m/7EyI1HYsfehGQozDG1KYoIRID5sGm5cAi09SveIrZF5Aa6IXjA0Umsb06qgl/eg1BZzNwAfO6970iAvdqkPX4hLQzXuVRK45/HV46w=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:29:41 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::11) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:29:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:29:35 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 01/24] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Mon, 27 Jul 2026 13:28:50 +0000
Message-ID: <20260727132913.22475-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a5b8df-6176-4fd1-20f9-08deebe31ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|23010399003|1800799024|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p2/mXFjCP13AUyk0iBxYHEw+jMbvOsGA6LHqIPrVx7DN74RVPpXIcFVgHvJ6/p79/dXWcNhSLM/72lt01jcETIgEk4lN/yyhlkqjoygmfhYJn1s1aMx5rMkmarO2UC64O5RtP/MMih+vh9zFriBkgWNGjuCrgMHAtmwomLZDWu3oR7E25SPEL9KpzgIwNibf69wyTSpuCH+OiVXjXDKPl7QHIzEvn0nxX4N3XLyreYaWHyx9LsW+X0XV+RuyG0Cm3yFGx8pZX9rZ2qJLawlx+ffKnZ/Ou7mR+OOWNG/KP7rWZGSRk3AZQbRbg0yv5vnrvo+nMAyvWP2279pc1okaqYYUrE7ynNF+C6eVp7lj1rhy/mG0mODjK0Xr6l/mywDgizlu15Ok9PE5b0Emie9yUgjZ8w3pFXNVFGPp9dfi0Bvor8Cd3HBr3eyVxiuWgttwKRY3U8OtNgNdv0yR1fQVL1ypjsdx+Dlc6XoJEUSaxirNRxtjT0JOq9vzMVf1s+FZOt8kH0p2ANpeGc4e/XAAxQ+yzQO9Bq/VU9/ernnI5q9l3MQ/2lcbwLjB681WLUuNnMRfvooUCrOTV7ik/eio6i60MC4CKgFGc3i/UIaq13cjVj7Mn/OhfMAuMymwnUidSYuoPwGVZg8FtA0tR/0KvP9o5SLE395oO6q85/X5kepI+2VQj0v+bD1FCqf4Xe06E+EiTPVHsbavaRjTcXkzVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PHxupxadQGXrAtV/9xcoPFz5+kBEqhUql8GQDAi3cX873FFzEAwjC5hb129krjxGye3RPjfmfddX0iC7z2HVIE7AIyJv+RqlcPNfj0WoJpQv84C4ginTpHDC+WNZ6Ihsqz8lfZGX7ZnZ0jHG8am7UeK1NyYFcxDZxFjc6Uz9f9eLofPKFbIxxc5IDCIYo6qiXlWsmr+c+9sgEB4WiQYXpNgrhHku91drA/MlFBsMjrdQDp6Jpt8emT4ZvH0P6EgbJBXnG/ce5RndSomdiBcoX6N7ouz/Sg7CHAiH0+i/aRmpnu5A5DwX1uqMEIQhsTldu1lKHfn6drb4u+rYRJz6+lkztZIE/Tu7oixi1EFVc7XufsmvwG5aJneFPAu3YD2so3wo1vqRFbXOJ48FuPg4cPbydgiHvF2cgg/MtPQ4+slQUyNGZ7NmFjnwTJM3RXch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:29:40.7146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a5b8df-6176-4fd1-20f9-08deebe31ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index af720bf14914..9f961ccbe3b4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -199,6 +199,7 @@ void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
+int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..4b4dd20ebec6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,8 +90,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
 
-static int iommu_completion_wait(struct amd_iommu *iommu);
-
 /****************************************************************************
  *
  * Helper functions
@@ -216,7 +214,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
@@ -1449,7 +1447,7 @@ static u64 get_cmdsem_val(struct amd_iommu *iommu)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int amd_iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	unsigned long flags;
@@ -1487,7 +1485,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 	 * We need to wait for completion of all commands.
 	 */
 	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
-		iommu_completion_wait(pdom_iommu_info->iommu);
+		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1505,7 +1503,7 @@ static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
 
 	ret = iommu_flush_dte(iommu, devid);
 	if (!ret)
-		iommu_completion_wait(iommu);
+		amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
@@ -1516,7 +1514,7 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -1535,7 +1533,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 		iommu_queue_command(iommu, &cmd);
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
@@ -1546,7 +1544,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
@@ -1582,7 +1580,7 @@ static void amd_iommu_flush_all(struct amd_iommu *iommu)
 	build_inv_all(&cmd);
 
 	iommu_queue_command(iommu, &cmd);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
@@ -1605,7 +1603,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
@@ -1841,7 +1839,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	if (dev_data->ats_enabled)
 		device_flush_iotlb(dev_data, address, size, pasid, true);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
@@ -2495,7 +2493,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
@@ -3392,7 +3390,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, alias, table);
 
 out_wait:
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 out_unlock:
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
-- 
2.34.1

