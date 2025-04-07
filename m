Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB122A1D4
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014930; cv=fail; b=JOINWaC/Pjg6Gn02gl45fQSOv5wpF9S7tLw+LzPA8fWQ9cV/UloW4D0NprWKOkBBBEMNmxbDe08ADNuIRHu38z6nWX4PpBjJbYnZUsz9KG1vM91LZWNUjD1eGosQ91NUVDYEolmVz9YDZA1OeO051O/klM/WlsRaKb9+tytOc5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014930; c=relaxed/simple;
	bh=gGaBGSLX4DsU5TwqMSB97LCOHiqHAlRJTwi1xyc1x1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNEa6xXl0d6mdrH33lY1mAVAoXzmlXNNREXmGSO10ZZRMM/po0EoXbKZZGwxxjTwGZrxBnKnJUR1SnBZWkfLUGk5j0YH5oLtHbEZXA364unOjFlvyNuMbsGlnH5fqMdw+KEPLy6VOOBmNkvHmRgzrlrwgmEXShVDKev51YVVaDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AOXZ15nl; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AOXZ15nl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYnsFyhcB78AHOILKGbkc4PdQ2QxS5SY/JgU0bnJPRbJfQnkfadGe20eVDW6v0K9lSf1GRWE6Y6rD9MZeWgFJSwYLJbprB3KBQ5IpUqdn3GQsDDkYjD8O+CiFiVUVF5dHlB4tTDXf2EHCFF/wfU0eTKM2LDlrp0pPq9gj7hUUwV4e81Nsb5OTTq2zDtI/fTGdbB9HQUwJn2ljh82qSr24x3jj1cJsN5sbxz7i/x1jJD6M6f0u1SdetQfRZdTnonoESQpbGV8Y57rkWma4nqjEWmbakTl6Ce4a+5vM0IRRKxozWt4DnhdFw9nu2XSH7pX8DxuM4nxw4QE1y/6j+xZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SyXmXO6szq7bDUu0YIaQJT7L7ctVklczaADsvt1CNk=;
 b=qbfMYNX0q0YRoRRLlkZE7pIeMFX1ETiGxh3K28q/B2OWDoESYtJUWkJ4QKyJmHlHDvSNULsIHKrANlIgeTE6lC40V5GTcXERq00BQwuf7ykYdRO9Q4rSkGcCds4ODwfmQzqgCQaMeN0YgAIbaXz8kZyXDNT5eFQhQ/5fIb27f8Kfq9bMQTRx37anyfxds/zB7h8PhOyMugRpLy0JUuegPXL/w/kM5u8HllIKiecyFW2gZiGnPjtqeUIbwjEqcYaRSZxaeJBM23fyWOEDv8bC+fY08HjkvhjH4dB4fxBVGX5CZPRhwp+PVhGpqwAnCU5PeKzGYJy/nAXk6AmUJuSNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SyXmXO6szq7bDUu0YIaQJT7L7ctVklczaADsvt1CNk=;
 b=AOXZ15nlEvxZQADUB44kshUUyIFAAu7l+KJyq8BDJtYeE53QQzKKOp7sX+wJaRVYZJgm6YNGXQoKOvtuqpAZP8XQXHveHSFndZIh6HYOu0W2/LNGGF9s1EKGsY7B2l0uotyn4U6++T+krLSDEz29IQSZn4tie0o22sWTtqljetaMAMoCO8DshKX5dQpLlRX0iXyemkS1mlj3kNzDVIxR5I9W1iUQbwD2+EZ+j3+nNbh5NqXnxbDixfsLtCynyTBysuAPd/qD09r2dmoZoOCri+vJ5PfRtTTpRRlvmb+GWoOMkzRCXiPBFDlqAboZRViVTTcn2lVeWmPhNSaOC+n8eQ==
Received: from BN9PR03CA0144.namprd03.prod.outlook.com (2603:10b6:408:fe::29)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 08:35:24 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::c0) by BN9PR03CA0144.outlook.office365.com
 (2603:10b6:408:fe::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Mon,
 7 Apr 2025 08:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 08:35:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 01:35:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 01:35:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 01:35:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc 1/2] iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()
Date: Mon, 7 Apr 2025 01:34:59 -0700
Message-ID: <a92f259bc18f8a5acdc067770b485ea71767100e.1744014481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744014481.git.nicolinc@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9815ef-724a-41ed-0a08-08dd75af23f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bz7W3An9AO1RVHyZhNpy3pSVY7WsI07cwT08FIV3iHZzQTGXoQJdSIxDVhQi?=
 =?us-ascii?Q?Qlbw3PHeCH53RjId4s8ZjqNGk5pCVedeSK01uP3IRMpKiktalA+VVedFVoCz?=
 =?us-ascii?Q?YGTnkNtxupfJf/gGe8mnr3zFUHwznC4xEPoQGWrxInHu1MYDaD0GFG5s/Qp+?=
 =?us-ascii?Q?VvWEPLsl+sKAamTsk001NJG92SJh4IRwsztERkK5QFQjrfZVmtyA85NeCxaN?=
 =?us-ascii?Q?jt0djkhV95Vcl8GfLPhkVzjDz0/vPw+XOERIBHS5LrowsqNMjojnBLjyABYm?=
 =?us-ascii?Q?TzKHOygfhcpU6FLx01e1yeAjc+LGXHDlJUx95J3DJKHs0RDlLik4vDyVtL59?=
 =?us-ascii?Q?wUBaaCe1h+8P7/fxmdylQKrj1fn6neTQMABeSSOtmh+gaEUDqII3gBahLi/c?=
 =?us-ascii?Q?pHqgqI3/GNW4kpm9XWrVGltPqsjNCJF08nhnu973I+zzAU3MxPsxZp51ySAc?=
 =?us-ascii?Q?abApkdHhmSI70DGea9zz3mvSdjFxuAL7mrdywQ3g7n9Mk39yehRF37NGn+BT?=
 =?us-ascii?Q?WYFIcEpnC06ZUw1EkR1k6atN76dlGmSdt7iFczGSapzuHEYaa7KvflwTVzso?=
 =?us-ascii?Q?sTV0EsxO6aqgH15cVd8G1ErxwmuWpXGRjgYQ2wX8mnPyJsXuM9xEAuIHEJ7s?=
 =?us-ascii?Q?MNG3x8aqDPUggbaAsewvJEuDQMXryacCK3QGF/82UUIKv/B4USHOBZ58Gs6Z?=
 =?us-ascii?Q?W7XeIRet/gyoQ3eY3bgl4aJQ/C9TsMYZZAQjnTp9epy5zwAXBxniz4bKCubv?=
 =?us-ascii?Q?gNuYeVXwCFxURDemeCkEUCMDFNVmzcbmFg17tjAZ9Bv4w9ETUQUpDSVmWvct?=
 =?us-ascii?Q?5jMIVa0KbA1r9RTqkQXF5+tXd2wouNmaLgOfYeKl+6HrcaXJEeCoFPU6KcU5?=
 =?us-ascii?Q?A37hOWf4NIZxP8pTs1MZ98YalXCfqR5l7zkB4zEWkVJ+dnIM8m1HVmZpZeVI?=
 =?us-ascii?Q?gGUOtljHOs1EpjQ1MOjINCqv9uSTMnXNRFn6dI/g61WKmKIh+oNiGnm35Ev8?=
 =?us-ascii?Q?E3VLwTwV/Ck5PEfnkmRKWmC7nVhoHGvAlc36tSIBs6msXBonoFKjvLNwOiQS?=
 =?us-ascii?Q?sB/tAOY7ASzJvG88tAg/HcBLTt46GCTTdr5KP0f5uBklfiSD2DVFg04ruq+G?=
 =?us-ascii?Q?+i/OdUmuN4JCCobSBsQnRHhc8zz68COqYtfaFl7cOVAHBSZpeWqOQYroHmVD?=
 =?us-ascii?Q?QtZVMLrzwNJ5kQpg23NFsziFXx+WPd9tsFo3F1LXPeQWl0rYkkNVfgc5bQu9?=
 =?us-ascii?Q?6kOvAVYM6bpTOlOJ6nllIEDWfvpDiaFVSUIQPhFTc7uvZ54BvmSx9sT9utBh?=
 =?us-ascii?Q?vgespyssCkFAA2Kv63LqImfaNtsCYF6P8fHvCDgg5v/mlq6xmiRAUAkm/m0j?=
 =?us-ascii?Q?+g0093uXw7zWCeA9oJVqSZA29y57KEWfmdlOt48ls0PzR7w25JYq3tt5tn9J?=
 =?us-ascii?Q?xD4FPjfVyXxa6aLRYs6yVLAZbabeAWTIIHPRl/1kqRThuzBba2TKhh4WEaSY?=
 =?us-ascii?Q?YNOndv8z+ajXB94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:35:23.7369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9815ef-724a-41ed-0a08-08dd75af23f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

Two WARNINGs are observed when SMMU driver rolls back upon failure:
 arm-smmu-v3.9.auto: Failed to register iommu
 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
 ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
 Call trace:
  dmam_free_coherent+0xc0/0xd8 (P)
  tegra241_vintf_free_lvcmdq+0x74/0x188
  tegra241_cmdqv_remove_vintf+0x60/0x148
  tegra241_cmdqv_remove+0x48/0xc8
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40
 ------------[ cut here ]------------
 128 pages are still in use!
 WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
 Call trace:
  free_contig_range+0x18c/0x1c8 (P)
  cma_release+0x154/0x2f0
  dma_free_contiguous+0x38/0xa0
  dma_direct_free+0x10c/0x248
  dma_free_attrs+0x100/0x290
  dmam_free_coherent+0x78/0xd8
  tegra241_vintf_free_lvcmdq+0x74/0x160
  tegra241_cmdqv_remove+0x98/0x198
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40

For the first warning: when the main SMMU driver cleans up its resources,
any routine in arm_smmu_impl_remove() should not use any devres function.

For the second warning: since those pages were allocated using smmu->dev
via devres, they should be just freed by devres.

tegra241_vcmdq_free_smmu_cmdq() is called by tegra241_cmdqv_init_vintf()
as well, cleaning up all CMDQV resources but it doesn't removing SMMU as
arm_smmu_impl_remove() does.

Add a removing_smmu boolean to skip tegra241_vcmdq_free_smmu_cmdq() when
SMMU driver itself is being removed.

Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d525ab43a4ae..ce7be8eeb43c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -555,12 +555,15 @@ static int tegra241_vintf_init_lvcmdq(struct tegra241_vintf *vintf, u16 lidx,
 	return 0;
 }
 
-static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
+static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx,
+				       bool removing_smmu)
 {
 	struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 	char header[64];
 
-	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+	/* When removing SMMU, the queue memory space will be freed by devres */
+	if (!removing_smmu)
+		tegra241_vcmdq_free_smmu_cmdq(vcmdq);
 	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 
 	dev_dbg(vintf->cmdqv->dev,
@@ -641,7 +644,7 @@ static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
 static void tegra241_vintf_remove_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 {
 	tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
-	tegra241_vintf_free_lvcmdq(vintf, lidx);
+	tegra241_vintf_free_lvcmdq(vintf, lidx, true);
 }
 
 static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
@@ -792,7 +795,7 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 
 free_lvcmdq:
 	for (lidx--; lidx >= 0; lidx--)
-		tegra241_vintf_free_lvcmdq(vintf, lidx);
+		tegra241_vintf_free_lvcmdq(vintf, lidx, false);
 	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
 free_vintf:
 	kfree(vintf);
-- 
2.43.0

