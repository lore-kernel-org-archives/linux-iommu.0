Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423952D7DC4;
	Thu, 23 Apr 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971736; cv=fail; b=uVCTS2I90tCGppHVHWBv1pDphUdjlEoJASKkkiI1xal91524rDjth4qVsKuX39OE/jvgtHNZ/ECI84pPa0tUyewiCBp3R+Tqt1cK4czihyW9C7uPiQmbWQamQxhcO/HdWkyCismLnEHxL9X6pk3SrCrZlT0qgSUjl0psTS3vv94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971736; c=relaxed/simple;
	bh=9CpDe3jtEdoRavMLddgJojauFFRHL8ehhKEM72RW99g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReQZGnrXOJywkodYe8bMmWpdD0EVKPMYz6lOyE0YZ/Kw7JUEoVBx96Buiv0LA1XKTG2Tj3SB3/0CFCHmGwptLA1Yc2jNrr1Oy+4po3b6QZY2XQ5sshmzNwApaL0+i6eMucU5J858u6z19sI6vO1dukwXpk+1/4upMvsOvoCgqPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKw7u9PR; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKw7u9PR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWZI60RlI5Yda4Xn0NJryesoWfswMvm656bWbuIgJ7MqCj0fIybW84jGVRL7i5sYutSpGI4FhiYqvRJB9qR9/fJDCcU2RaZfPgaZX6J49HY0qwc70aVPrQACKcI+wGH4iybVvb+VavL8y0v9Bix25kA3LeMoGDltcCS0bu73DNrIef/AWaNKA8mOKjX233M9MnqqzGJO/tjjz2yqTgHcN7hRJ7cigMphP7Pnk1puL8gOVxTso9uYmwJmtj+QnSCNd4ZuyblRBecIB1pHgPi+d8UcFrVN35xezauZkPocOROI+HlZ8zJ5hQpFF/p8Fj2t0awwu93r9ADLmvgPHECm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF0plsdI/x1HauvSgswcK3YreXmT8xMeU5sb7rtu3Qk=;
 b=D9pegP/M3pk0r7v/q+RWm5Ems4a5JJkb2LqXMjDwwQdpQWuCV50sOZ73zVoy/qxuUZ14AmBjBp2Vej4V+jLnLRnZM9an5YYMY4L1yQ1KcDlOzp4iiR61REpzqXlgmogwJXk8/+2ZsgaHbgSb7HkzkHZb5JD2KoDvL7onS6hAG1wteAP/ylVsCW2MFvqjVraD5+7PI4o4DKR75zj55xyymIj2Jdf+lNbsmM2i/Vsjoqet235jrIor3WqaE9+jRzuhyuQcfnKVIAtsv68RfFdSNpD5q/ISKkXbpK+BPnW/7cKuDmUHLFMJasOmi6Kic6sf6TOh2MPYfByn9Gs2FA1FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF0plsdI/x1HauvSgswcK3YreXmT8xMeU5sb7rtu3Qk=;
 b=YKw7u9PR08ZJQM/zImDrYWS7MY7ovB2vNQ5t10X/tJWEr/1jPqrbQQaTHbTbq+66f0JzVfKAFjbfnh6pPF1uOoLH+KQgmiiQRnmKrZGFWRxXonUvzm8eLfADB+nI/HkS4k7H1wYUMUhAnveIunmwmJGAXZ/t6Z9auX519U9iZTLnnggfg6YnukbdltlFxl6ZatYaJ9xBsdEZYKemh4FwlitHYA5FjULlWGE7WufKHcjNpbLt0GCBqRgSzQXwj9lQg0UYkIoVsFv6BIlmnEHf23ssCPRxmjSkaousB2rJ8SEYkU/aFUoyYVLLkmWaeYH5x6uwIxz5POk8EMjKMeMieQ==
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 19:15:27 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::fc) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 19:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 19:15:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 12:15:08 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 12:15:02 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@kernel.org>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <nicolinc@nvidia.com>,
	<praan@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<sagar.tv@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <acpica-devel@lists.linux.dev>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V1 3/3] iommu/arm-smmu-v3: Honor IORT Root Complex PASID descriptors
Date: Fri, 24 Apr 2026 00:44:17 +0530
Message-ID: <20260423191417.2031652-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423191417.2031652-1-vidyas@nvidia.com>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 9915348e-ce9d-4443-7998-08dea16cac8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/jsowtGX5uj51O5JDRjJ487V1QdqpexwqLkYOH5szqHQmlB5RiJ2BkSFaf4DvuoUi23CT+7b4PqOFIgEBujOA/dMSWnrd1LFysQGZV1fCnSjx8Cz63GF7plwH/0+D6eIdOHAFkGai5sMJk6DEbePqwMPSniYx5Xo+NM0oMSxGV4UkH/rmdkuyeqkPwf2wu3wiDqHcNn7010y+ZeLOObNT/D71EyBDw4g+4qdz/KlGVzSyZeIjWhTLEzCNN3Tg1Rf6RPGBUJlLJYzRFndQZ2/UFgX/ORWpPHYLF4gh+Yl4JySUOWtD2FDL4WQoSDt/3qOhtVDCZZu+Vn0osO5A3vQszP/HihJ3Q3EaNm0YWo11tBkbkfNyegC4ekiCTHveLo5pECJBsNRzVyrpEEInM9iSOPXAJk2o0lDVuKGVA4P/CnUtQf0HDom5ygnjaEEijsJliodu8vQSNwp2GsVdIj1kIDtIOVFkvxiIlINCED3KDPkLqFu63fpGys3THzYwF7hdfN62gwL3o/jz72SpFQidxi7V6W4DXnbX8GBQJ13slqwIVXVxWTU0CbXpglr52PRiduiwdOAH4jF+rdz2nTYshDzXG3ILIye50FKmuWnzrTaLhFiYQ3GyLz3tbyBojW5aC36zOicZizC0rYZcyx4BnxYct5KbRZY7HpuIg5zStBQZq1vxaRBi/Ne4kRU0qt42BO5i3jSUDsxkAhL3Q0g2fOhMAJckjdmmK35JPli9efmUJuOHlFnsfwWvGHqAsRDSVHjYhGCiW8NueLihZP3ZmqIEzsSaitvpO3w8hudVB0zZ/C7PH+X+C5SCmMnCaiY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LAcz/Ftat0hx+VDuvsdZcpa3LoMmoYddBfsj1r4tvB0pr8zYl6XG4cZ9fVJ/U4d9laP/sfMTWMj5jKpCryqjkqxHR8Aoy5xVp3j3wJvxL/loSX+OgiZSVvJ9WYyQvVrTB1IecXA4wJHV8WfIKQVu+2ZK79Cldj0MYSgcuUepbwQPRusbYsZDgZLBbQNsT09Om33IW8zqdnHmQCr4fH82Enks1icKfpgrqRQf5yT2DMBn7p0oC9oEdWnulYW71fPOf17a3qEGvztaHP/8ymd5chP4U5ADs+8m+9ZV/W058B9rAl0XzGG2nkFnf0sApqcjbclt0jtOXhcwFJ5Al2QUHqBafp/d+vzePq4ecV3T5yNMhfVuRoyZTwadTZ2809UFzReaTUNARjYpPYplPcjgVjadq2doihxd3NGLy8B6YPqHOgHWvBwvkRYua+jUtCWP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:15:25.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9915348e-ce9d-4443-7998-08dea16cac8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

The SMMUv3 driver currently calls pci_enable_pasid() for any PCI
master that exposes a PASID capability, regardless of whether the
upstream Root Complex actually supports PASID and regardless of the
RC's declared Max PASID Width. With IORT spec E.c (RC node revision
>= 4) firmware reports both, so we can do better:

  - If the IORT Root Complex node says PASID is not supported
    (Flags bit 0 == 0 at byte offset 36), enabling PASID on the
    endpoint is futile - the RC will not forward the PASID prefix to
    the SMMU - so skip pci_enable_pasid() silently.

  - If the IORT Root Complex node reports a Max PASID Width (bits[4:0]
    of PASID Capabilities at offset 33), clamp the endpoint's
    pci_max_pasids() result by 1 << width before computing the SMMU
    SSID width. This prevents master->ssid_bits from exceeding what
    the RC can actually carry.

Both behaviours are gated on iort_pci_rc_pasid_max_width_known(), i.e.
RC node revision >= 4, so platforms with older IORT firmware see no
behavioural change and continue to enable PASID purely on the basis
of the endpoint capability.

Use the new IOMMU_FWSPEC_PCI_RC_PASID fwspec flag (set by IORT) for
the support check, and call iort_pci_rc_pasid_max_width_for_dev() for
the width clamp; both pieces are wired up in
iort_iommu_configure_id() by the previous patch.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..2b269307fd33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3071,16 +3071,28 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 {
-	int ret;
-	int features;
-	int num_pasids;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 	struct pci_dev *pdev;
+	int features, num_pasids, ret, rc_width;
 
 	if (!dev_is_pci(master->dev))
 		return -ENODEV;
 
 	pdev = to_pci_dev(master->dev);
 
+	/*
+	 * IORT E.c (RC node revision >= 4) reports whether the root
+	 * complex actually supports PASID. If it does not, enabling
+	 * PASID on the endpoint is futile - the RC will not forward
+	 * the PASID prefix - so skip silently. Older firmware is
+	 * treated as "unknown / assume supported" to preserve the
+	 * pre-E.c behaviour.
+	 */
+	if (fwspec &&
+	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_PASID) &&
+	    iort_pci_rc_pasid_max_width_known(master->dev))
+		return 0;
+
 	features = pci_pasid_features(pdev);
 	if (features < 0)
 		return features;
@@ -3089,6 +3101,14 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	if (num_pasids <= 0)
 		return num_pasids;
 
+	/* Clamp by what the root complex can carry, when known. */
+	rc_width = iort_pci_rc_pasid_max_width_for_dev(master->dev);
+	if (rc_width >= 0)
+		num_pasids = min_t(int, num_pasids, 1 << rc_width);
+
+	if (num_pasids <= 1)
+		return 0;
+
 	ret = pci_enable_pasid(pdev, features);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable PASID\n");
-- 
2.25.1

