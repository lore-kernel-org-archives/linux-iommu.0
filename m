Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DD439009
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747715; cv=fail; b=hJlk8sKY86x0uhv+aIzowtmYC1UIV3xXAlQ8ledE7g50hUARnDcOIiCRQppPuGhQUXw9iKNqdPq/haXd3b5kXGTd0Fc+UsXr+baOflHPS/YhispS+MOYRmeyT6mknIa+HA/V5oFZIaNxR5yNS404xia0UA8iqWbIfkVwPNscW3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747715; c=relaxed/simple;
	bh=uxzPpcaI3fV71R1uuHwDOXol7VQeKImpbPP6I2ZHYVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzDy/1h3FbGDM24oFRmJc3Re69aI0ul7knx+FaYeFSE+S0S/t09U0BLMvM4oQjQoUEtcxWMgURpj37ykc6mOIpXJhB4qblKLQoLX2oAI+Cavuo2y9zhP07olo/MQadh67PPuxawMUxeGFyh8/T07t7bLF7CqSSc2KDYIAY88bj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FltOseMP; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FltOseMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa777aeOmm5OhYZno4L2JnsbamliUrOdlZ8hmUB7rMug+8NwV1uJqywEUFYCVGgTu/8fbZQ9D4dhOqZUjAxpU3zfmzOdTaiNAmqcWH7/28ntuj3ZWW+lqbxt34aFpc3G+GjsRjWDESG98TXplWlykNL4be/w5YJcuKd7QkJ5KAnpByvllSHyDmLT9hdMh+5DuzLRLl760/uGM7Jx0uXZrfEqLDkzSBPhTCkI4y1skG4ccoIqN5bpJK1FE9rfT71YgX1uNk/HfyInM1sFoeTR11clXolyuhc0AH7Wi2E9t9/3gCfB1P6nmlyrtgVz9veTIyqeqFm3tYxJjuhGNGfTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0KlYP//OE+XX2P4ZgfR4p3pu5vnCBB7zqXhADynh+I=;
 b=zA53XX4cA5QochUMMY0d37TpW5cAVdt2xWEOhmfPVttwWglSr4EwjW+VQJYxdywYC9N4Pg+2QblA4t8HlhatBFZNwO8mygOCYtHfrmd0UqPDTynQeZLVHPdQ+OsqS3n7n3YSMvJ61zDT6CVxsZ9ak64yoDfnDnNpE4aFH3tWPJRaLluuwwIdE0bGDYOZqdDLc2KToItGOw5lFcmGS1LIPpYHP4oxy3mwY58oycju3Zv6tScIUcG/9Ksf9tseBNyW+dj+3bzA6rZs4bln9jPEFy2nDWDAUNPhmsA+0Er9EXUY30wo+fT9sy9fZHHzT50cK64E3XXWGWOE/36k2n+SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0KlYP//OE+XX2P4ZgfR4p3pu5vnCBB7zqXhADynh+I=;
 b=FltOseMPn15oiKIRY0KqOz0KI5IunzKekA/LOcBOk3b12dEOKBy9kuKfxPR0xsxB/G5X7k1TfAbO34U9UDO/oCMzu35de2RbspcxrPUvnkpmuosXwg+64ksx0R3FhZSv25hRzUKcsXtQs+kS4/2/acUTazHt8ER0FsUBrUV7uiw=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:49 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::99) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 15:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:40 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 10/22] iommu/amd: Pass iommu to device_flush_dte()
Date: Mon, 29 Jun 2026 15:35:23 +0000
Message-ID: <20260629153535.15775-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f06a87-63ec-4c92-172e-08ded5f4eefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H0zxhlz1VSRQADuhEG+THlQqRRj/HJT9x6orw72Cieq0oMDYnpYnRCTlfFQ5L/qvTYx0W/X0qkH7MrM1QZAHXZeYr3NgD8NPPP+nQDoQG1Z47HqRE/2aAPTfmPSTKTexnztMHJPy+++Kt21nrbcFMwVGPNLk4QqA/hIFdE5K4w3yzwlSiIr/gtOtS8cXyxykgZQ1IbVllLrL/8R2UhFbE7qbEDSI9mlosrQZiXY8pR7W8KtUSRm10JNhp/uQxxLroIOpwQ2XuPdTr37RDJl854JdU0oTJazY/EjSm1MwwW2Zs5TUpPTljTQCedllw8OCDFvS71zHfk4m28tjd/BqcS6Qjm0fSu+N7BxEBu0u3p3iRQKrWQCt34pYa4itys03KOjOFW1RY23YQW68jDAOjndB4e2CivU2KlldGo51a0gd4iVqfpfk1SJ0tMmWKKcqEbuxIuUzOKhkQF3Yhy4OteIKcyHk1/izt5t9zgXPpJLaNezEcUyoK6FnM42mM54b23ekD+3gVxiEmyONr5Q+LFAOhP6PkrkfgumUvxPAw/qednToD3Nxfhalo9Jj/YL733Cf2+njd/tG2GN4NCFWM+v5lkZfBS9GjelHfecpj5b80VAEay47jeUlRWMn+kXJZf21sXILkvBtg9BXU02MvOLtfQqkSpDi0MMXYyr7LQzVjtxnD2GekOrgu86z1TKfXzvROqPXhfSM13FU061yBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y/vDfixUPR8q5lcGHiNQkWkxP1R2jZszGp50UF8qWttQnR5Y+SUgaJTpphczX/k72D7FRzSd9SEq6DNHb8QDu27lPXbBhkSgNtCt0lJwLSCYrEeaDAJO6RiK1QDW/KYZZ1rbMxZ7lzavgbtToZ96M6t7/SYdZ1KsUdG4GrqtsNYO6OQP3FqknwShg5VdX9MWrtX7TmXH5o/3Cp0YiIpXsRZNz5ee4naSp/BOGJL7p1N2Ds0xioTQ7DAdGdObzxjTZGvompVRYWtWePVMzATR0iZIEKSqWV7Lm6WMuArbnD5HH56K+xdgFeuzYgYKMXmTnYflEwtaEzlvhlWIScUDflHQSdzx7OWyFz5yLNjU5Pt4hgBIArfoP8dvBjBZ3x46kC0sLWghdEufh7jY54r3+YybofxcWwqFWh8nzZyYtZ6O5CpScC1wfxFu3mJzvmC2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:49.0404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f06a87-63ec-4c92-172e-08ded5f4eefc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

Take struct amd_iommu explicitly so DTE invalidation is issued on the
same IOMMU instance used to program the DTE. Also, flush each device in
amd_iommu_change_top() immediately after updating its DTE.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8b441f68bc47..3eb7e2ac3782 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,7 +76,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
-static int device_flush_dte(struct iommu_dev_data *dev_data);
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data);
 
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
@@ -213,7 +213,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 {
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	device_flush_dte(iommu, dev_data);
 	amd_iommu_completion_wait(iommu);
 }
 
@@ -1716,9 +1716,8 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 /*
  * Command send function for invalidating a device table entry
  */
-static int device_flush_dte(struct iommu_dev_data *dev_data)
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
@@ -2691,11 +2690,9 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
 		clone_aliases(iommu, dev_data->dev);
+		device_flush_dte(iommu, dev_data);
 	}
 
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
 	domain_flush_complete(pdom);
 }
 
@@ -3127,7 +3124,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		device_flush_dte(dev_data);
+		device_flush_dte(iommu, dev_data);
 		domain_flush = true;
 	}
 
-- 
2.34.1

