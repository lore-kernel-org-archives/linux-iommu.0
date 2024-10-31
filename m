Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C1199397
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366240; cv=fail; b=I3PoRWA/PZcNJXEzpqJrjmgVChqwGiQRFEXzaq0jxIYH7v3vA2983wf2Zndhl2Am3qFAiCeommFofBK7mqnnhxS5+OIkGbZ3Q7l9wCyyhR1S6Nyyc44uZdlMpLnijgXYbRwNGWu60NjOmsM/EJHlbNmuxr2S4mTbusa9BYkKOAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366240; c=relaxed/simple;
	bh=tZ47vZBh9OhFFaey/i86tdeh0q9vSBPjtbwlWtV9CSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUVEHL3+hwRlFkga/yV3fPfghkDU4wH+b5o6LhUOIgbzhx+lJ7uE9OdtILewa9GpLYZajwdvJgcVp2AgiGsf8cJbVw9bWA2IQJ3zanMzYRPlvunYw8Kl1RRqp05QGrjU/XahZabWNuPjtb5FYm11LQSajVoB0TwubUdwHc85+W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CnV4c0Ax; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CnV4c0Ax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Caeabh0Txc5+juAEX8ojdbjZzNP7RTkPojfV/yOWEmrldaS3RHwpCUqmPHRuyk+nrDKbKHQ1x29v971QYtzkhAtLmPQFmYpjdrDMBWuCRaYFzkUH+EwjVh+OQYyKVAdwnZdOJOnG+LHGzLYK3r+rCGmsZqm1gZqSfqjHfUWIzP40FwjXKk0lwhaoi/kyDhQJTkVKK8bcGXVf0YOoIqCDKixUY5EZQIOWAF44TV1oAN1HHORefNrm2LneD0RAquL5KCCc23oPvtC6bmQ+HVVw4DjEk8ApVSJOnreChqfIPig9TC374/bym4a/gqRkqLrX+Yz1ZxVvlB9Laumq0KWEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFfBhwF42Zs5yWuL7X9+FvccHU8CMdFTLcHr+lNPFhY=;
 b=YlHcVjmlaIbegfkKVEPKdOZac6QXVabDFDLgHWe6UM9J9LVjX+0YketVamQGQXdOX9rsT9C1s+3R44Vprj+jGUdtWq5xGxWuWQnfFulTokeOflqj7xWoeSv+njxDFDfmRrs6Lw6939tnSmsnkEglsjclWMNxQGgZXqteOFmb0Hz9FI1yxyKLQTKcPsExafW5DYzxalhhtoVtcHSqjU99eGyzGmoiTha9lnZtpA40gczj4Xm1WOuHfdQcVlekSkPZN3c+NAnR+XgEL4r/UhQIULVVQGXY5XA7fWmxGyx3Vh7YjFd4juLpBIPAGRutNUIqJ9rhFoxsjCuBlADgBgdjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFfBhwF42Zs5yWuL7X9+FvccHU8CMdFTLcHr+lNPFhY=;
 b=CnV4c0AxyjSp1rMz0x4kc2hOMaMNmc2ns9vZkliUxRh5HrirGFaUdnLtXegnO8MuTFI6nIsGj6KXCYgZBfdm3sye0CP5gc5eRuYcPCYXUxg/a0yISsIHFOJr87qYtGUho3InVtPcMUT9CTbsnfwvbh+1ktPQ4fXYrE3APmrXAGM=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:17:14 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::a0) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:14 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:17:07 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 08/10] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Thu, 31 Oct 2024 09:16:22 +0000
Message-ID: <20241031091624.4895-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cecad55-7a2c-42b9-817d-08dcf98ccf0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrHNUypCBIlTTFSNLe8M0AFL3Z1/H14eodsOLyLG5zZ2Fp3VZr5Yau0d7D52?=
 =?us-ascii?Q?E12CJYtRnABWdb005fmjMcpShFEKf9GUYUfqUTMSGk+Fn4hvtonpBkQZwRpx?=
 =?us-ascii?Q?/xuyKagr4goQWbvAVD0TBjSqB7JW1CPnmgLqvdnaJm8GNOh5BIM6YyVvq7Ky?=
 =?us-ascii?Q?dVaZ7tFfykP0W/R4wqNjM+EyqT8M8F3azU3u/x0oAyPoXiroH15ECVpM4MDL?=
 =?us-ascii?Q?w+hguNqZ49YKb2oF+pIzBRbX33nzVfLNOKWfz/J1exmtRYANWit2XIBEJA1b?=
 =?us-ascii?Q?CqflT/KQ/jrnJL5VpYEnsWraT6jHQDD7gwnoW6lrleoCGeWc3bPZ2Qjqmsvk?=
 =?us-ascii?Q?gBWGciDFc/3iQ0xcqkNpq6vmL178VrJyeCZUIAQNVWlUM3LIAK196cJRDdYF?=
 =?us-ascii?Q?AujJgFs4wqe25pyqiaUNcUi+zqM/HQMSb3Xj5+T3Pfarc3LPZicJWEjTwZut?=
 =?us-ascii?Q?GYUMKSrzwrA5Ep2L6CO0mlVLlmNYv1+tif+MrSNXde0lS1mBpxDvGcDVnV8S?=
 =?us-ascii?Q?Ub1di4DirCB7gg/tbq44VGnc7ukyksrp0ryfWHOa6pruYaGpAw1kQqLeO6Ql?=
 =?us-ascii?Q?cGeDLA8fUpy1C79txAq3NfcY20+OWRpwja4S8uf7NKNDjP4u83yQiWZKaH9d?=
 =?us-ascii?Q?vEBPF19LAGNzCHjK4bgQIWj+XewF9cMJjwebMK0PZoH8I2qFPVbuuggqEeCl?=
 =?us-ascii?Q?W72usfUsetqiLHd9ELEHrr2wB2Iq7ckRIqPzdRyXIUKJvZ6MVUH+qRNut26X?=
 =?us-ascii?Q?8Ff/fu1jmT086VaiBBZm5PnUe6ANeksUnAPNW2cXfmxeWlFZEekjH5th2eW2?=
 =?us-ascii?Q?S7sizDWKlUkB4G/zlUb/pQAUUbLYBKHFCP7Tso0FE1qaIhGQaBelAkvEGU1V?=
 =?us-ascii?Q?BkpPSOPh5Wfgr4mCxyzVCVF+HeT2OT+8/diEMKWxm1LNKwi5omOU90nGmpkB?=
 =?us-ascii?Q?i8rDrLXI8xnttnoaKEcLGghPyfA+JKn8sHSQyEqy/66BrKnkuEb9aQCZtoIS?=
 =?us-ascii?Q?m4xUimivfdOCM+yje9SlsgSItwJ2JElvxi4v6HLl7jh7WR4F4VAwUMAGcdQi?=
 =?us-ascii?Q?dPoXv41TnIAqdWkwZKgKG2mqFI7y90rVjl7NerVNcTYazgP2KeISsYUQqQ0b?=
 =?us-ascii?Q?IjJ0Cwb99kJaN2LMaNe3noPhzPzwYD8DvsCvRooPT334S62AEQr0s8Qsoo49?=
 =?us-ascii?Q?QVwk//qKbw0b2ROOIEiwRcF6SPqOX15LVQ7ayvrR1/gR74mm/iUjtKRsb5ad?=
 =?us-ascii?Q?8xAvBjhzNr20nEI1LoQxrKcYJU6OHqHb1uoHcWxBmEfWsADv9gmlVOh6LTAc?=
 =?us-ascii?Q?P3h0hU+z2I18AxTE+qhrPiBJgWfWWNs6hEVMxG4SubFvj5eV0XkOIUPWYk2m?=
 =?us-ascii?Q?rQvRM+GhW9gt1U5E8+aPBXxGhSGTtCtc+9xauylYagluYPhavw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:14.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cecad55-7a2c-42b9-817d-08dcf98ccf0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

By reusing the make_clear_dte() and update_dte256().

Also, there is no need to set TV bit for non-SNP system when clearing DTE
for blocked domain, and no longer need to apply erratum 63 in clear_dte()
since it is already stored in struct ivhd_dte_flags and apply in
set_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c8b0be83ee9b..b71fb22d001a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2111,19 +2111,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+/*
+ * Clear DMA-remap related flags to block all DMA (blockeded domain)
+ */
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
-
-	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
-
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	make_clear_dte(dev_data, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2134,7 +2131,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

