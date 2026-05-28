Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDC317170
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945497; cv=fail; b=B28odhQF1Rn8aSkH535Ed8fKoY7ZahO34csu+JP6r7WvBno9xNxDi554VqScE+UuNTYw/KUVPs6h1odJWVyk06uyJK5M1yfRCxYnQmysbbrhKKQzbwh9CLYN0G2Xdhc0+YQAmwaTqleCHu0kW6q+FG0RPSL8TRALUcR3B8FfUEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945497; c=relaxed/simple;
	bh=odHT2BNcAHB4NqygKFcS7aQfHDGVKq4cEY1M4C1kjKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWQzfeP3L42e8HrNlhT7FJo/IXf6Gk6csyzLEsjskEtNRGNnTHe7P/TWEuJmKHqQ8QRqRkAF+8qVGDGnHkiBDwF1mdUaIQIgzVWMhWw+lQx1ut5d0P0M2BRNTXsMcRzMM0OeUr5iKRWgBWBtd0JFM/WK0NA76AVD2djzTHxtfPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X31jy66o; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X31jy66o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZReykCrXijyDhZcs7bahr0YW9rSSMIAY07Dyu4hBEc38qU1jgWo2KgNjQZ+vY3K0k0xWzKwbdHwa9LxRGdTdOvQ68vglW5gX3AawTJWg3tOga5oex06y2XjN8IRiLGiJC+kPiGt43KsCXhpr/QuxvloWVQ23ezPYU1gcIRBmhl/pPZwGZU6VPJZaMuwECdMKHnJidrQidZ24OhGmOnBeFDRGXcXD09DbGJltxX59Ey8tNbsBO42ckFowhAHuN8ZQ2DZdLbE+OxxAAN4Wrn023xxFcm8Tw6a/+NDiGo9EvntzypXkI1oGICDSfWcIwMStuTP3OoBgnit7HhZtBG6kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=CFbptSN3k3s7wlrTAcOqCFhYErM3Qc9v+XJ4slH4mphPP1h68SnLHjWmc1htocvqM6qHo9fZdvJMq/O2OiJIAakS0pri2y35QANv7harWeodLZ9cc/zz2gMfPjDAaE9TiJQWrSTa/BYohHa2xsLfhd5W2PNdaHC4eHhXC7nFiQ8ueK0OTLQ23qK/ep2u+Wbni0DifRuxOcrmru4/IvBicspQRiv/DwdnDcyEFqC4WPM4awkHkJRot6aFSfeoDIu8Fo9EVCDSp3Sl4WmlCScwGhULf+On+V7CjMmAaBe/nXdlmwrBA5u7u1Q1SB51G6WF24H2VCk47U1kOzcGE96Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=X31jy66ohhouVg0P2Fn66n4qnXzJynKnB3O41zlFSxczwERQfGaLl2HiAnxTLG+jULvwkdz5fWUkTrdnldvL4UdftW/jsnXqMH6v5ftX1LkpzwCZFMLyrZTlnSakKtyKo2wdGtRlO1tw2sdJ2ivjU6KmCeYJ0Bquy+bUncqZoy4=
Received: from PH7PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:33d::33)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:18:09 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::4e) by PH7PR02CA0002.outlook.office365.com
 (2603:10b6:510:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:09 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:01 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 01/26] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Thu, 28 May 2026 05:17:13 +0000
Message-ID: <20260528051738.596013-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ee9c40-48c2-4c17-f74d-08debc7881e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|3023799007|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ao2wh+wPVgzbfbbrNbiUu+DNb/gX39kSAq7DiQDx6oXylrgjhr3pjm9wsHoP0IQzB3oyDwnn23N/MRlmIzpyrFT6582k0kmNYgHTZFyWwNGr2rPQgPbLzVOP0peRPDs35/1kAAflTmoUBExVCeHncZ184fSGadYbhlVvcSwBFEwE4wziTo4LFlKXN0m4fwJnTuJA+DlS54gEe4Ekee2EjABnhuuqpqRyRMyxkjJAtI+aG8MXBK+o5WY05wHNUnZaNxelqvgTVb3Pi2i3hrsxdAupZXg5Co6T4L5U46vSe4g4hG5/sVZBEAqvZRtgSQYnhnofB/+mVydWe8hTB3ENr4VPyJMCEh4K55wF+Y5JxNu3vkzFycnhUjqxYV4cGddrTmXgnfa4VyBDszALpX7Qeei9/N+UN090g+LvBYQnZMvw2afv7Cyk3Jt3UbX0szemWu4z0oiK9ygv62JARWZcVRADsfvW+iphAGXZHAaEiwvES9uxMzNwD+owvp+JaeELaEn/kD3scMgFyLOlioavChlFZy826tK/rKY9T98LFA9C2uHiEdwXRn6NQFwCZwcs8ZznWHo/GoNwCaVeSqs1spLRa0L+Lx+55NMQJNP9YjesdR0E7mpw9tiUKOR8KWqkFUUo8wBpZZZRunC2QPdxZUu4eu3ApaILg7fWg/q1dolVrvLAUvpfZk+wRisFCyOrOWbdqCYUK36L646LyMtA7uAl591+vWmDayroWQxQkw0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(3023799007)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nzVnMxmQ6CC/Ggel2b/MjjLdC+xYNdcJgC+Vm46+oLFbRB8apvuzQQkGl5qv+53pGYaJPI+brPz+xr6ghfX84IwyK7Ev/MuNjIher9sySA3XoW+xqruKx5ryI7q1NLym1aotPJABXHAm2kyOgwvevsavqZkiwClPUTsrY6YIZf/xaEU+spsHSPO1VLuGz2kOamS1xaJDS/SNQQy8ZG8EcpcOxAAzzFqyHn8kRPjHVv1driyY1U5V4LLGf2eurrFqoi9EhilVzQsuBaeabCp5mrRgex+FYEWRiNMO9VhP8gsUAT2l/vi3I6jKlff6rARmzhowdF4Ozw0vqhSi2RFL2rE/Mz2UqMOLTKl9MqZDPLlMzfyOtSxvGo9DIGRVvb05JMZAfSOXV8ar7vwhr4mFzcb1rMq7wyDUa9BCLqk/aYmFlVXvdymRcA4XNVi4wdk4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:09.3904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee9c40-48c2-4c17-f74d-08debc7881e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

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

