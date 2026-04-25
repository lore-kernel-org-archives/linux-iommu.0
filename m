Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CA13959D
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079759; cv=fail; b=KcyQkfzzUUj5y+J/rjbECmIiJxO2mnjvshkYFa8n2SD1PnakYpDzQFmToI0LqadAWmFimE3ITDqtJfe1Q6c68lKdmtokqN3aBGbXwyNZYF68xgaGnTGTdqwyg7eZmJmuH+SsADAPin49pW4+uYIIYmPQY1CJ35rUZ/86x7961Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079759; c=relaxed/simple;
	bh=Zh1DbHvEPUNhdx24KR7q11vqMiVkQzrbID6eYXtbq+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVB8pQSlKqdsq5iqSQBiLyxAj7LKS7pC/VcmbmbTt7ZeJ7KJy1YDMODGmCMZZCoUOTRgMhUusm1AMhbIMWI1IUN0ZidFRRIgbPMHEJGGyvm9Vv4WQPm12Sll/jKaiyTiBxZ8vQsZrmZTu0xFwjprGgWL2rJlmM3MqkfnR2K8YkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cozFvRcs; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cozFvRcs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZkFiSETvZnDRy7KNqiC3vSmi6i1N0ps0wYvCrSr1RL+ZSap/ejK+BOPUTH4dK8rcQJ1jE82K70T5QDmICmzz/JZ7He1NN1RH4pG4dBicpp+IKZuxJv/eIWA3h1xNUpQrKlYWcJnRZITyoafGn9cS6SeoiJEjq6D53SSmn66hZBUchbL8veXAMPQiXOW4KG3NuHNUKeOmCTwhb5qQAzs3wYjiRH2IhArRrVm8OcYKJdlzGcV5UdhvEtS23FUtPmU8EzB7qHpW3dGfYD8OBU2MF8RbhGNkmJbULGoUzPC3IJLu4uuj/Y7vIbrrc6m5e0mDPP/TkV4bht6gmvFX3TEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sYxYcxMTMcvI6sx0wMXPWwBZDdhrIY/PVBOMwcZ6sk=;
 b=ZkmAIKQTfNfovzzAqkD8RrR268AV0BMAzkbzf4VFMvFQ4v0/8U1vf/xAet/lcZXFxjOOKck6pfzpZwUrQT+NStSQXBcur0uPjNOJh0sn7Qve6IAz978myKv1kk8Xjs8NJNrcxb43FnE99tsCbOYKlF3j05fhkRFzG96mey6fx+xHkQXLVmXcod8U+p1ymOhokH2lTW2lhkQhnEl+wH2V0NtL3EViuCHlD7OczvBrzRC7XrudcTh6gThq6BzUWGdH4NIdziRxbgNUCCRXNHt6eVPQi+83oh7sVWMap/x45szSWSkW/JKHX6iVCImDSUH/wAljUvJijgyBZpqxW85gpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sYxYcxMTMcvI6sx0wMXPWwBZDdhrIY/PVBOMwcZ6sk=;
 b=cozFvRcs1fPM5ptoVASntX8wCx4HPw4x2Db1OgggAVHC5HBxSpyoQbh5rm0k+4+lE3dQ7ldZnAdyyDJu5VRVvcIBh5UIb2c5HSnYO/Lmr9mRrGi7rS8oIFS7fjGXv/d0cc/dH2dfjLUFWqTv1qe/aBgC5SRQfAkMhiqxBz1pJgowQMjuhxagNKLp00Ahw7tHpZbAHL5nQmifBkwDBkQwXMrJX9qmiBv0A3qglLKtumytUOUVaD6AYcwIWKFggOEBujQBBVtN/+amhn05gCvx2e/GFPCnlcVgE/ctGqNQZ1Nh+RFsdbx0Lv1BwMLayuJF86uYztUTe+dHi984DQjywg==
Received: from CH2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:610:4c::30)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Sat, 25 Apr
 2026 01:15:52 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::9f) by CH2PR10CA0020.outlook.office365.com
 (2603:10b6:610:4c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Sat,
 25 Apr 2026 01:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 01:15:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 5/8] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Fri, 24 Apr 2026 18:15:24 -0700
Message-ID: <0c98498aee847ce9478487195b36cbd122797d63.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d3c7d-ef82-46d9-6188-08dea26831a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CmpyXDBR8h6siIJqcXyVfivoAGW4lwSAGU9a/q/BKby/lNVP9s+Y6NO5z8Q8yIgXv09a73hiJYYBBgngikV/qPdaC/vLmFnh5F9/x38GWZ8KJp+leWqaCaORQm8rQMIp1vuaFNhUWEfP+7eCEH2nv5AOteur7CSAkjnhoa8vxOeWzeyyR5E19gnXpJWytl9IIaVOoIkmZtviT+GFUaNtaYE1qDNUn9jgNb3x2FxUrvVkmL3GWhqu21sth1RQaZT+ZpnLE4NJU64J2XpkD6Xq+kfoJ43gt0d9yY5yyCEp7h4/+iQwuIBBkIQEMg5BOuJ5cT5onb7EtSHCJLcYb/ANVCl2oRT8kAL3ZBQBFhclP9cMDiNcXvyF988pVEed5AI7KBKTGWp2ksMyiqcawtHeN3OMKyUztHOF7Jf89lTXD5IRFsp4l/IPFUQWaZN2ML8sLeV6F0I0DLXONx9psbGiPigJrrhrtrPgaAYs81rDu0DT+fhlair2z7dE2ZbWOwr7KQYp0chg+NbXBkgaabSu1s4mS33V9oAo/Aqe6jHmQu/3XgyQzXutIFZUWgveyenVD6n8bEDAK3V2QNXgwLg9vCZXC+cs4VI7kNyzBwRqrUy56C/8RB75TN5Z7Nc6bjmmvG6U3piUjCh1Rhtvzll5D/UP5gc1+Tdz7VcGsXZ2mFZYKtpL9vf8OEaVzkwcw0iS2r/sPhHvz7HW2b8tFVljJKHqrM4PMZrMWfweIfaC7stmTO2YNB8zRTIN2ftG5SnLet8wqD2l3tqt2CNMy3Naow==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	StmUgGtuCPk6bCnwABDheyD8DkRv691vXnZND8gaDBR/r105Tr4mqYuEuJXe7/k+8X8Ef9Vv9epgB3udcjg44q2Zjyk+CHPQAuqvSPLbg8ciFT+w4ZpUFwJht2sLxWfH64rxnkAE51j3wn7lgnsI6xgw4izHq1Yv3qzNBJyw8kVTokr5TxzynFI+F0FNUrsrOsviiOJ9BvUrDWpYg1u70cRN1jRiKI+EeKmcXFuNN/1FiveaFQzkIoN/YTUHVzmPIM+GVZnHxDSG27XCxEGvJBoAIMq9G+xGT8b5rxlaK1uOsojVfpuq10r4IX1nAcnwIuOHi1KDeoC4p5O+b3OqlTUA+8h3CvA9F6wDCdMshwhoakraUOE6BDUZlmdkQAx3M4RZ9jJZhirphthXXc0yTzHxFGp11tw0NV3HeJzUpk/gxRarg3nKiUul0XpJESO/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:52.4655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d3c7d-ef82-46d9-6188-08dea26831a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
internally while both are calling pci_dev_reset_iommu_prepare/done().

As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
device reset.

On the other hand, removing the outer calls in the PCI callers is unsafe.
As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
execute custom firmware waits after their inner pcie_flr() completes. If
the IOMMU protection relies solely on the inner reset, the IOMMU will be
unblocked prematurely while the device is still resetting.

Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.

Introduce gdev->reset_depth to handle the re-entries on the same device.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2907d76c39c68..7a5a5d3aabb65 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -82,6 +82,7 @@ struct group_device {
 	 *  - Device is undergoing a reset
 	 */
 	bool blocked;
+	unsigned int reset_depth;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
@@ -3997,20 +3998,23 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (WARN_ON(!gdev))
 		return -ENODEV;
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(gdev->blocked))
-		return -EBUSY;
+	if (gdev->reset_depth++)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
-	if (ret)
+	if (ret) {
+		gdev->reset_depth--;
 		return ret;
+	}
 
 	/* Stage RID domain at blocking_domain while retaining group->domain */
 	if (group->domain != group->blocking_domain) {
 		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
 					    group->domain);
-		if (ret)
+		if (ret) {
+			gdev->reset_depth--;
 			return ret;
+		}
 	}
 
 	/*
@@ -4070,7 +4074,10 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!gdev))
 		return;
 
-	if (!gdev->blocked)
+	/* Unbalanced done() calls would underflow the counter */
+	if (WARN_ON(gdev->reset_depth == 0))
+		return;
+	if (--gdev->reset_depth)
 		return;
 
 	if (WARN_ON(!group->blocking_domain))
-- 
2.43.0

