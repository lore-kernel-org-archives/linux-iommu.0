Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2E1CEE83
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478240; cv=fail; b=dFjUvTV0Kcb6zDc2vjURJuhDedgux13pDqj/7GiRhKwPCs0BiQQQahb/mMQMorFKy9HPYA5iRhKlUHD2WZKQLBuMPGtcobWn3K5Oejgg+ckfJHLn/Nc5x7KDe3Qr4Hvf58v0ez+JSIoMf/Ckuh/GFsaRmv9opueAh+DaAJOl9Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478240; c=relaxed/simple;
	bh=p3BCtLShNRmmdDWXsbtOT+jScSArtWp4V+ODmtxuuto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Piej/yOZ7tMIck3R9RvcoOzvT2d/dr9saymDAf7x21W9fdL6rGcVh4VyIKiUUm/P2NHEF8/OFQ99vq9dWittcAKCARrhQ8p7OELLCvcsksbxFVy/udVu35A6yVrEAkg7WkH3u3xxvJnYx3ygef/wsO3Js36UQfp9rBAP7DlTsXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4PiQlBeG; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4PiQlBeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsB7m2DCgh8IKc3Ez6TkkI+jMMKypv1m/8IpOUp5sJ+/H9JPngRNrJkmRJOT4WCaflbZOZ11mcx3OWAgHXg/AIkRManN0CB0uDGZGWaFGQnqqJomHIkmuAew/YQl+6fBWgIe9LA/6a81UpR5xKN6EiobFyUfUEwJgWyV3ZEkgkRMiWKurA+lXk4GQQf/JbQ0jRx5bLqJ9RTFY+izs6/UYXBLmuYrIGMlD7ZlN/MR5EQGazeBA9l4JO0tF85gGdT5vdnwwClX9/9nYwKC+TAgSviiFUGTJCsP/dXUTNpYlT1qohBIKmSK+F9RWrXR/YHL/p7Il1S1ArnTvnS7yUVNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u8f5rQEZyGNdhnYsRxE4BU9KsFOQkkJi6gz/TmPO9I=;
 b=RwOb2E6Tsi1VA00YFyEBAsflHowGLGuar/jiINe8FxyAaaXGU9Y95nB6eqm5bQudH47oNSOcfJk77WPDIpEBY5j6+2v2zMzS9sJBs2B7JWqllcUR4to29/DG3G6o1fkvS4PES6XLRaHmFoOvxPPtjJeM2tN/RiiiBWGB9783yxMgt6wTTChek0wUTc41HUbgC4R5OMiKQr5BhjhsGrS7osaW2GAc5ea2Zx5IRTOFT9wFezQ8pa3c9DrKkF3twfn7Ywo3ldHEOx1Se+aomIEGtoBeTOJAam+r7oj12wGTIPin0czQALBmgz7vTKy2gmOKxBd7GxjbT2mFKKLI/kVzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u8f5rQEZyGNdhnYsRxE4BU9KsFOQkkJi6gz/TmPO9I=;
 b=4PiQlBeGV9uX30BtURI1a3jWKj4g4zWBzDjopZhZk4cXvKcwUV//tjz2NIgg3AHdkVZ50WSEj6uSIHXS9DX/S5bCmSBUJfnB5zZzxozxxrhfvtdspSKD7jU8iyZkpEaM7cKMLIKJa8lC/Rch43rA8eXV8ToD72b06FzrN3+CvGs=
Received: from MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 16:23:52 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::74) by MW4PR03CA0200.outlook.office365.com
 (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.36 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 08/10] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Fri, 1 Nov 2024 16:23:02 +0000
Message-ID: <20241101162304.4688-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b31bdfd-f368-4c7b-6c0a-08dcfa9192f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJRDwslLoIevoCiNyNWPiHNjfFGTnmF1CRfDlCmJaI1CSorTGaSKSHWh7muc?=
 =?us-ascii?Q?t5IGCAW2BBDXucoGJKY7GeHqkmeECg8omZri+YP+XyfcDzEXi5N7mdL528tt?=
 =?us-ascii?Q?CGR0m8w8IdNuKQC6MlqtE5O9zOL3hPIPVywTIUibMvGgCuxWC5SUPsLbEsID?=
 =?us-ascii?Q?d259cVEmvGLOehVPURpA3KwooOn0zhv3PB99bey6zgNZlx3Zz1U47Q5xokkr?=
 =?us-ascii?Q?eVn2pV8CAy02FZE/YjvBnSY+od10LhptxKheGPCOVpPtaEq+l8jPlBRfNA+I?=
 =?us-ascii?Q?0vSB2Q8ro/V6uxUVzyz5ygf5407DqpXpPAa0aGE3VdTIZ7Vqa+WLx1FOUP1O?=
 =?us-ascii?Q?tHguUMlsl2OwGXduzz0s79BvRUaLOHt3j1BTe8+IzhVE9xEADEDq+Pige9UM?=
 =?us-ascii?Q?a7EM78XBcldhgZZ7S7YRbZBcIihX2DsXLItlRwPlz9lcmO9bJAiRecgicDSH?=
 =?us-ascii?Q?TI1GXTgfZ4zhN9SJD9x2urRDDhxMElO5Do1bA0Mwm3bfxf5W0Xe991KYMTxu?=
 =?us-ascii?Q?Lk6iIlc0m2jxzCP65/TDh40wlcafy1a4D53H2rBEk8jP04/46dHaD6ICo6e+?=
 =?us-ascii?Q?XTiRISkD/cDMMkaVmnhTb3EeWGeFy/mGiFNEwFIUpyw4jskN3OZhwuAGRPA8?=
 =?us-ascii?Q?VlBmaDj7efYjh/6UQK9HMHn1yjt6SP5V71NAZvBc5CmjXKQo446pQDJRmhEM?=
 =?us-ascii?Q?xdcbLeYVAiKg97VAhGyHHtcw/fzNmitYyyGx6vk8oLbo4Vk4epxc3Jg5tmyi?=
 =?us-ascii?Q?LzzN7BBR/pHH771uRA8Y+oGcBIoZa1YcnDirzH/+rEJLTA8/Q/YbJjYbhgOG?=
 =?us-ascii?Q?6pEQPcmoij9w0iucGsS/ghtTUL7ilWDNljLN/XZLUpzmPHLtZgVn8RWv8QvH?=
 =?us-ascii?Q?6xePmn27HhPmi6JmvVs3dZLWh+IvubqgNt/QWiVF4yj0/RI4t2iEHFsSTtTJ?=
 =?us-ascii?Q?ecG1Mvpn0oZ8I2vVKO4w6MMPfEWTVk1zlQGW3Sfm7+mtY3TYfjl8pU9H2r/o?=
 =?us-ascii?Q?uovai22trvLJHaRUNqhx977Ff6LrCbE8TiAYSpEIL+uP1W8QnFwdGzrxEyp6?=
 =?us-ascii?Q?0pbYxy64lyher7jK7ClvcYcqVhejujsk+u8YKmiI27GYYCRgUbqJLIKNnRpu?=
 =?us-ascii?Q?reApNliB3gaKW1qiLBtloWECTK0TDWO6yVpi6nEPZ4YBPXWFEhqPEBI3yLjx?=
 =?us-ascii?Q?ub26ReWX6MPU1ubt0OceKP0khG+wuc0ztFmF0Hg4jQsKJMzV3uxQm3S5ldlQ?=
 =?us-ascii?Q?1B8QZXCTIwFo+cUcUXxZ4RQrS0Xvcf7smklBXezUXKV6tuyK+CAaUnAkd+R3?=
 =?us-ascii?Q?MjCcUivAv3lPTXwN6xlqSI53/sLW14DnwhoqSW8oxQPx5WHP9W8/f2fSZKvq?=
 =?us-ascii?Q?dSd9cJ9QNelCxmqpS4MceroUsCxpzhS2/+6Qi+hH3nnZ0Jnj5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:52.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b31bdfd-f368-4c7b-6c0a-08dcfa9192f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

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
index 4151225b4245..0a7287c41cf4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2090,19 +2090,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
@@ -2113,7 +2110,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

