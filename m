Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262C1DE894
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079763; cv=fail; b=XY6HQ8rG8PTlt4o7Z7Jvv/zpbsvMS4VT6jW3ujC1OcBw17fRLS0vjiPmkSF02C3Qp07nSBhcPbBIoTq+lydBIiQEVJBEMeSJiLieBI+BEtOOCsy8IQWG1TwX2KjVWrNuPhpJMPMWOiVtO1nbiKRTRcMepDlEoGayWZB9xctut6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079763; c=relaxed/simple;
	bh=0mANKf/FZprWRq6PK+B5+jEobfW6kGg5tGt+Svx2BKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db2WoxyAYLfytE6Jl/TBACi4UQfMmLlGqlWyZ9oNAGwh+PhmFlUc1zFm5kqOZnzjJyaeYagCuza9qBZ+ifinQWa2joiTisW8doxSsB89UcW8LjnYNSQoz4MLFlIrNrWC/B4WZdUjtskCZpBClcdKLHpUiAeuNCj5tqQwT0lQ4Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvCnc9lI; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvCnc9lI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeTHE4H/0UNR10RGYhforaA4V45H9ko8ncBUi7Ywp+cahboshIoXR++kbBZjR58Z2pRxuFQ4Tyjj+rdCq1cfExuLMabycZY1JLHqHOBtC1RgjsALsTVnziiD3FXLCE3E0j6JV7OPUM1UV1t6baOapXzGh2Y4eiMHUUdJqIzGZHGNeNGLFNKaOAqx8KtLCcHGWXXZRLC87TS6wNGCGazFt39HcHRa1+2o/zr6i+1aRY9rsAWjHyO5ndNL1P2R8Dd20OvjbjA2BbzlKC2S6oPoM2jnq9hAgD1QMTD7LqiowUTuBo/yZmeKEkZZ/NG9ps3u6gwY/xxpvLpSeSXEC8IRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI3FHWFCVtf0gMzeiL3LZ7sG0faSUER/c9EltOj+yGc=;
 b=LV5Zu26pJrZVT/40PbSFgwF52WIzSvJUz5SI3OhISBruOE8QlabbJ4OipJvKWSbbqoiTnH6D5wFk1qhp+DdJ2Hhj+eRwvDNi0ydpYppGWaXmMofNlswhyeBtvC4i3oHsllYmizffRTo5HZSvZv3ntZIFDSuJIPOvbmvollaeEDaMYloXt/EhIyrShX24iJcX76MfIdRMfrUJrT7/Lu/K6BfbI7f5E7RP3qe3CFdAlu1ghBsM9w3vmpYK7UqK6HMuK5PSrd6TFybs4EB61weL0wpBtm4SCcHfE1aV0Az9mNl1HS2DFuJ1Xp4EMqxQVE06LaHFWZGhk9jyAOq5+WH7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI3FHWFCVtf0gMzeiL3LZ7sG0faSUER/c9EltOj+yGc=;
 b=mvCnc9lIHiI7ONECE3cey0m143CJzd71EMNhx/9Bs6Q1sxsAA+KceycI1pUTlWKJuYvN7EJymWZTViLYa3hvt3xrCYMGa4HJgQq0DJf26DlR0511AOEgeJggS2/jMq0Y9lSaalC5mjzwQ4xpLjIWFXckpx0PbrZRXVo2WNLl9w4MTh/QvCbPcU4fXthui/2EvyOV6GCIyFt2G5IF2djFyUqnnB6wcHf2xw/uG/qpIYysMhpC8+ymNj0cBjLpxSUqweiyKXRWV4r3sxG9ZdzCbRFxCs/6nOdoC+Ncf/MSJnX7Rl7SulbEsOWjcy2ZxRGJMrAyLnWx2aSIZa56xOyY6g==
Received: from CH0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:610:11a::32)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:56 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::ee) by CH0PR03CA0346.outlook.office365.com
 (2603:10b6:610:11a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 01:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 4/8] iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
Date: Fri, 24 Apr 2026 18:15:23 -0700
Message-ID: <0496b91a776e10220ea84450e3cd9f781e74d396.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fac46f6-13b7-437b-78ae-08dea2683398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O8tFD+9UD24nC9wy4IceLh5HIQElyq/4u8t+Y0d9bBOjYpixSxWr1RNfpz4eIpqxKCTlZnnGQGQHF/VHpsBQQSwo44BHzFMRJm4al6nQ6qt0fGE5YOVN4rAl3iuQMSzqFwxY88oGZoNP9VIOFEX48du0CMSn/YnernbFWBw3Bz3yd+Ol9DGZR1wRgI+byiBYMxEik+/Fb93BV2ALBBedhh5hIQPhW03GH30+P/CwOIAPY5nGmp3dmzYeAekNRlxPCRmq9yyzgkaWGolLeg6FklBldOKFzWrF/QI1n9Nkb/B1KORnQM3Fi5E7r0OHv9P1ymjU9lc1DStkr9H2UCfA2/unqVBRwCIdlOJuWWMAaZvQqbIKeStNS7pPUP7oeG2iS9B21l5Ullyxiu/d1WVEkP3ZiNttgYOQo55xXS/5+VoRK2xi0ALygJ8VqgpKRzrc8xkDV891nna8HTVXj69fHLls0kBEYycwpp+5MTixLfEVC4xrWdGHL6lapK6yEb1yMnQ0HyKJETTv33OA+X3sDgPjuYwZ+G22AC7kaBXwn7kove3naR/KTlKLLR3ulF6FHGfIj9M0thp9+I0pmGbuOWaJ9WRq1muLJyf43ba/Iwx7gujdDx0MqiDcSXMUfLQWflTUgT1papoES5Qtj8zmneHaV5novva1cB9N6ACOKTPrRUOt7N2LKGRxor2xo7Oe2AnKdkb5H0Z2iGBDR8H5bh6ybOj5c0eUXi7E6xxDC6qtUDPquSjFSXD1Y21d2FE/s8LEy12QUZMndtLLpcewlw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HvTLK+Yo4HIslLP/6bkNpBn/3w9OEUP8w3ZvPMhjm0P5Fqgh0wgiJ7RDMwROYB/XayFKAZINP2ExrMLy9ZEI28YCbbvpCAU/B2VFIdjlDc2XbrILGzTJ626KxFzW2bByTrllk8/7EbLWScL2c9b4UjjrfjpsFShvkehenYJQyCj77GWmPtUEyPCCnWHLgBMw4YjQtTO74hmh3IdHPCvVIV/ZsWPaA6KoCaGMOoDsSIg7x/3M277F74hnyichLyM0vz7B8V5Rti6vY8zqF52TQ/pxO8/pHUsBRxFmrne120QTr0tbO8aGgSS2whC/ePvPH8c8n/VTgIOZXEFVWksX2kIBvV8W2Me76wFodwjkWwZtuIV6GWdCKYAChu9itlNrsAxL4pJC8L15/pT6lO1z5DQs8Kt42AaVmxkM8DMke37d0u16EILjsXhmoGBnsEED
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:55.7529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fac46f6-13b7-437b-78ae-08dea2683398
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

Now the helpers handle per-gdev resets. Replace __iommu_set_group_pasid()
with set_dev_pasid() accordingly, in the pci_dev_reset_iommu_done().

Also add max_pasids check as other callers.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/ad858513-09fc-455e-bbc5-fe38a225cc78@linux.alibaba.com/
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5b784e43ca592..2907d76c39c68 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4026,9 +4026,14 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		iommu_remove_dev_pasid(&pdev->dev, pasid,
-				       pasid_array_entry_to_domain(entry));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
+		}
+	}
 
 	group->recovery_cnt++;
 	return ret;
@@ -4095,10 +4100,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		WARN_ON(__iommu_set_group_pasid(
-			pasid_array_entry_to_domain(entry), group, pasid,
-			group->blocking_domain));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			WARN_ON(pasid_dom->ops->set_dev_pasid(
+				pasid_dom, &pdev->dev, pasid,
+				group->blocking_domain));
+		}
+	}
 
 	if (!WARN_ON(group->recovery_cnt == 0))
 		group->recovery_cnt--;
-- 
2.43.0

