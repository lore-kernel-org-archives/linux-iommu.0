Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3A3451C8
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555714; cv=fail; b=qdM5clVSLx86ex4tb93zG3mBqTKDLBLinXpBz3h2Vv8ZCAdLDY0azMvTMbj0MQC39FYG5F8lvZtuHpQjKqg2Gp9m4PVL184h1nWiXKgezf3hZD0nuI++Yxc/LW3cY93nlULsa4LAIgPEeSnHxu3azsSjRdqQ6GlP+lSr66MHeG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555714; c=relaxed/simple;
	bh=AwdB2ylh41+rfwi5Yz1wDWO5IXfZ/Jh86gXRPdcJlG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4HrwJBcF+eTJ0RSZrrFrAIbZ56GJIMv4YP7m0bil4baewNkDQvn1iA/hcbXUVRm7JX2NyvvWnBYQ2V0BU9mBZqAFJXC59sdiBiFyshiwfkjJ5uNIfNRMhxoJezNP6bSDwjN7/zyz/NZWwR0z2jvrvD1MruesFxUT+o6TyPcXgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEy8YgaZ; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEy8YgaZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaCjuszFKUK+r30XK/xX3RU7aEtxN9cOfkfcjcIx6FE9B7RlvdigWR4Eao0D5rR8Trlrg81BcTGZjVLwOVWrxt1G+VfDcbbZ8McUnZKgHpvC3qn/ieaNdY7dxkk5Hyk8t5X3Rt1xDKSy+qWVneNkLDNwe9xzOdzgwNa91sUTG1DvkO+vcr91MY6jx5mxsFw5nD1WbJz02sKfrqn4Kvo1K3YAozD3xa/CZoFtv3jCcgOiIPirlhNJNxebTtNwd3SjqrH9CoCR7kYxA6JVg6wDylvglSfkW3/dOi2J92lIpqCBTjO9EJICHtA2QsUEQOeO+x06Gj6xZyny9h36EEfddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y12mwetR3+q08LZG7TBwgev9sGFf0doVoIzcX572bTM=;
 b=j9l2rs9kL4q5NU1T/24crVoqo4g/SO/taLSgRhPoZDsbhdtIPeEOTwTgAmbdttwVgq9QX7BWsISAsqJluECLOeN01RoxFtMppOpg7bjFcy5TxfBCEgpARjQV19bXZEpu3MAOqL7Ax6kFjdV51tjfdnUsVyy8DWHW71v3HXl5xbe0irsx8Y6xlLqE6vxCJ7FWFkfIUW+BTJfmnS5kUMbolnuIM5HzlDsZ4ilUGf64Pb8yZzOqlKzg9i6SCR0hdUGog2o8Pl4IYXv6dpVR1r96TPPjuZFWpenaLXP5a9nrn9t4NtD+okCu0w51Up11pdMUEKXwNHC+MqdLbDMayD7mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y12mwetR3+q08LZG7TBwgev9sGFf0doVoIzcX572bTM=;
 b=AEy8YgaZzUUAfrlXZKIM9GQZeVmeBeHNAsX5JNBLYU1wVtzFDMhx2qqC8JY7O0653xWlcsdVLqrU1LVyIXfEmILLSM7ymVJ8POjEdZyL3NBfDTbM4D/QYoIR84Xnx14BbAvNT9cgYvN/zVXrL59kSoK0AT6oofvI4OXTYKUw0udli4/HkBenNB54QkUXUQJpuhLL7F7ZpHxH18BcP1NoBgHgN67bvg0QyYW44VqXnQX1woKT/ZdU/XYlmTAbOaUAJ1wjJTKWdquIdPnQrrm4d9LP5EvUreMsPUPNnFS94rSSGzeHCLMLYW+M6YkBNYGGfUsQeOfWnri4a8KPiOLLCw==
Received: from CY8P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::25)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Sat, 18 Apr
 2026 23:41:48 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::d4) by CY8P220CA0048.outlook.office365.com
 (2603:10b6:930:47::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 1/6] iommu: Fix kdocs of pci_dev_reset_iommu_done()
Date: Sat, 18 Apr 2026 16:41:32 -0700
Message-ID: <b503d422582900fa0e856aff8299c3e5a47d0284.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776551790.git.nicolinc@nvidia.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cedccf-7aa4-4408-50da-08de9da40f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IHFDtaxAaaUY7zUOBp8BU5ie2oIxxd7wyP8BY1bPdKe9Cq4clfHqznSNUEnh5UglKel3LiGFKH6lhDv4vjHG5y4cONNTd/s6ZRJv1RfCjQOOnmuXY35pgXJQWF1qWrDWu+DOzJ+HiDdb0ZZeBl20SJz3lEakjL9Kvikwtc6m467jJVPPriBxgtsXwd2zlZE4AoM72PD0dDsNIlE8pUAPllGl/xvAk6p8FVTem9OMq0y7wq3MxFCo/CmO5NmHeiWrNHcKxBvIaCYiu1V/IkZpVH6SrnDOOjMIPqScwn1BCAcjSHhFzTrfg30LcB5k/Vh9x+5S+RBJwX6bttYcIei1TLhuaj2DTm51tShDKekal4n5Zml8vvjpCpmsZu8AVET0YL8rJDg9GLi+l1Dw4sPPcyK4LuGbS4ldZog/ZuguR3e69vm/qKpLWzOsY6Oqn/QAf6GU/dMs2vd8tt9Bsrm0iCgiZ2eYp1Ny6Y86dt/KMzxALMfaggR+jaPCWUY4sgtxlVSbx10fG4ep8DhHZ/Hwp7Csdj/T5Ex8XWECFFypSQqDO6wecffNOLpotUhoH2tcPH0CAE80FOQ9RVoQ9OgNHHOawDQBHlaS+Ir10kHx9X6u3b4+FYNn6DFPv+ZMJ5MkkDrz3OZ9DDweNAJv0UXmqjzaq2j6LshGvl4CvHEJyFwfnuEvY86UtMADhMCMbf4byiPdOJo8tzta3EB0OSOulqlAZQw4+MekSdX6z5OvbtltUHxr45YTodJP0PJmncjbZRdNoOucJ3nPhBYMstqYxw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sDQfngd/UPkwRwcWO3q57xOoxQ2vHH7xtQx8HPhj6rjEGTtapBKexHcQg+zIxbAvyimiEAdAUB4AFNKrvP1RunL2WS/2hjTfWWedvBkWYgsf+otR/76T2WU3XNpMd7sPcYDWalO9V+uATknGqfOEYEQFc3VF+kIjS2hJkn1VDI+YzvsSwTQ0y5Q+lYxhbsxBIK5y2y2q4Zl+zNbLPLJV26NJPgJeLayWbhlKMyu6vnnK5wQ1KSxqfBGlAZSulQuwqtHzn40evWgD3B5WSZO2mtPtjKuZlC9obPWIWnorc5Uw9gVvX7NFKuI0LPTPFQJWtNCnHZVJVfrWcV6mxqqF2P63d7ybrKc2Ety3Hqj1oFcaHcdb+ZUewIdqTXGkGFnJUD5nGMUWuagmuWUjml5Dgdx3JxgfMFi0jHZHnqRPoKVbM7reug75kew2FpcDuYVI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:48.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cedccf-7aa4-4408-50da-08de9da40f00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

Remove the duplicated word. No functional change.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..b950e7be1a3ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3997,9 +3997,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * @pdev: PCI device that has finished a reset routine
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
- * IOMMU activity, including new translation as well as cache invalidation, by
- * re-attaching all RID/PASID of the device's back to the domains retained in
- * the core-level structure.
+ * activity, including new translation and cache invalidation, by re-attaching
+ * all RID/PASID of the device back to the domains retained in the core-level
+ * structure.
  *
  * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
  *
-- 
2.43.0

