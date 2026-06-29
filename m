Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C615383339
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767825; cv=fail; b=Mw4wroSWlyTt4ALMB7ZGnQvumyYsW/6rDatL5yyd0DWDfLBJoJiZyaFfv3U8/Rb4bPquDCbvh71hDLf4gSrtti4Cz+oK7BUTPB+1uDfbgxfzAroAUnSTdIHko3MHakmkXgaX/21lGGi1P9KDBXFddtS8uEYtnS0ajvFUIZM2KHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767825; c=relaxed/simple;
	bh=kuRNH58pHghomg+X7ygs5fFyHE4mNTd5gmnct2p0Yzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvc0H7l6Rk2MzharhCMZdnWR5fVS3J9S0hfYcnsoOQn8FZLwrZwl7+ZCLw2AK5R+xDxSftOEe5hmbTIgDNhjoU1LCr07exW8sGlS1fcrE+/Dz3/3o0W0sYwT9NAdxMMx83cY9+Tp9YXhFpnQQ5Ez61q9GBslDFWwlseb+AqO0q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDZ/0oIK; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDZ/0oIK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5ywJ7Wo9IX4IutD+JgnzyiteOniFAVjngQuPfGSZB6hYJppLrWIGX0GJzNXBtBXKTlNqswdposPYNhKffRfsG/LmDLv3ElPEZkK9+kYfG4M5TwNfkFZNPgbb1GBGjERs0V7LfeqJ9qHZWVge9Z0vab6uegsGfTC0Go0MAz7HtaoGYxJeXRzT+Kr5rjm4dJZ27TpJKClxi0FFLiAFJ7pmCLDSmTIFMXhdkAF/WBvxKvM2NxeOJGLDjP9Vlp5LvdfA5AKOeCeX4+9Hm3ZkFELG3bB42etRDVHT+4EHOSO2R3Szsu4wDRIDonnyewSRz8/lhXPtGzDsRs62NNE3kZOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub6PHmo+gP0p4Qzh6DOHB5s5KCva0uoFSwRpdFQ4nFU=;
 b=yC1ycty87wJogXBh0Nh0guGS4cA5POcmUnjId7/yVN2CpBSe7ndFUbdCqIfUBf4XAuUTyd/HdR8eqp3tvKdqSy5TdFqILFDNKeHBpDta9FavdHiOFVRTTQns0d/xzJ7Tzv1g5kHCZr9Hx7Oc2C0T+3mNu/KOQRcjYf+Yry994CisOKs/ANeL7R/k839wykHXjSgmLTIOtL0jUMa8BtgeZG4eUrYVGfijRArmOE8+VZbZi0CVYEM3O+CuHo1FqO+FV9rrhvsELVvfMBU5CZkX8qV9qZ2XvVwU+JutteA+RoRYK/0uvP4fOyRrCINyRV+WhkxzAavRXkZWyk0gEe4jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub6PHmo+gP0p4Qzh6DOHB5s5KCva0uoFSwRpdFQ4nFU=;
 b=gDZ/0oIKTONwoywgvuX8vk0p164u1u1PAQi5J8GO8NY5R/JZRApyECuCTBpCTbzBTnmfuDXVZ1TcZEsPgQmNWwut3jeFYe7CH1Jz61iRV0s++K5ii/zySRsU+7ex9AGe0m2zgShZBKG4B/WgHxaiMHZawY8ckBg/2wGlr6j0NOd9mp0rTJLVm5ngPQj2+z+UuJ9TVPYv7OMqRlSULRjNceXTXoDpGByCUY2SXzH65q7UwLZGBXR6XarBgChQjWe+EDJFOz0UXMPzPajaDGWZkgLxwZHATHf1mxiGX+Ba2q91y9gS7JF92veCXyGUrzY6jCwg1fmntUHgeR3yJTLELA==
Received: from IA4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::16)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 29 Jun
 2026 21:16:58 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::78) by IA4P221CA0001.outlook.office365.com
 (2603:10b6:208:559::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:16:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
Date: Mon, 29 Jun 2026 14:16:25 -0700
Message-ID: <8f29de140d86bf507f71c6c27aee8e23e1c3940d.1782767110.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767110.git.nicolinc@nvidia.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 552463f6-a9a2-499a-15f3-08ded623c0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N9PZuHc5lINDzTj3LKepO1oiVwC58ujpaAn8aRlrMoPr3LoLYGEjRo89VqySTAwxuNLPWpDdH15Z4zXPo+bLYoSJ7PHbzJ7/4Eli+m8HtI/BRhLB5g8SdUVO5ZKO1wtYbGVEue+7F6WXWlat0gU1OouAFtK9N1B4JDQhDNa0CIumnVpa/ubxd0tQ2INcPBomp6fj334Jv7jPQELfDCRylMdHZ8uu+eBTC0Wtk/I+Nh1jjSmU5jeRWp5rpF4eD2x6sQyCJe4JkKczwxP5ovuMTR8Mum8xF+5AK/6j20kcChnj1XN4qKkdF4pWH12zQt0PzSHUwYy8LHPRJt0ly5aqnjFRkkVoL5L8OEbA3aoO8lqiNcYvrxqbmfbrP3R63y9cbHMms8DxNmcs5OBTbgMwg+coiTP9ToP2KB+jLmg6bV+Web5OgxGPt74RJfYhz4wRrMIpuLaneCtHeyBI+Rqm+UpJ7Zqqr5eC9BEbEYAeUtz+Eq3R3X7RgzpgickQIKqMJ7P1vj3a3SPrCZGuh1PBcR9DQVbkUbXbCvcfcp2KWoV3SGA3HuPTVw8jJmy0+/fSWLiFQ5ureBTpaG+bRMsMdK7F44VducS0q/Fvk21Xp4Atg6tGS3U6mIUrMswC8AHtQRELZMyla/zeeiiHu23osxvK+gAsHbIz8Cuvu4GIqtwFMPz5QRIO69P+qeuxIDRtq0+CUPFG4TTm+kz9owxxUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XrsPhsGOLPphzmoI/qPH9z30k3qHcFCV8QmIzZk4c7Md9RJCsprRhUk1LZhwz/os8cilzpXzeXViw7tacYqHK1m3aPpYHGm1MJyqDC8/tDldLeSzfjVlgIVnH2S2MOttpkoaS4C4INc7HOrzM1ONHZM43F6vGtPfQe+SVf0DtLuekaxgwv28ush/Dt8Dgt6/hPRBltCGPsX/fFT3+3jInUl72F12rQXQh9MNrHimqrhQWGYHSGcXRN9Atm/T8T24FDfmDMhELVwxU8cHEIL2fUaixnDMOTr2EbU7li1f0pj1HAMT9MRnYBY9XAx7yGR+yWi9ArpT+7CzDLyMgqlg74a5MIPkxD4+K+czBsOUZof6T+uDgYrYB9+tkmkLUGNBW5HgYSPVRDu0mIvsiw75V8ixZhaCWf6sd+MFJ395C44edw0YiCoqT3at43GbvvzJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:58.0681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552463f6-a9a2-499a-15f3-08ded623c0f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

iommufd_vdevice_alloc_ioctl() adds the vDEVICE to the viommu->vdevs xarray
with xa_cmpxchg() before the driver's vdevice_init() op runs. That op is
where a driver validates the device and may reject it, but the xarray entry
is already live by then: a concurrent IOMMU_HWPT_INVALIDATE can look it up
with iommufd_viommu_find_dev() and run the driver invalidation path against
a device that vdevice_init() would have refused.

Reserve the index with xa_insert(): it stores a zero entry that reads back
as NULL, and returns -EBUSY on a duplicate virt_id. Run vdevice_init() and
store the vDEVICE pointer only once it succeeds. A failed vdevice_init()
releases the reservation, so lookups observe the vDEVICE only after it is
fully initialized and accepted.

Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 0c12c7e352a14..5b40e924f0782 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -143,7 +143,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
-	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_vdevice *vdev;
 	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -218,18 +218,21 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	idev->vdev = vdev;
 
-	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
-	if (curr) {
-		rc = xa_err(curr) ?: -EEXIST;
+	rc = xa_insert(&viommu->vdevs, virt_id, NULL, GFP_KERNEL);
+	if (rc) {
+		if (rc == -EBUSY)
+			rc = -EEXIST;
 		goto out_abort;
 	}
 
 	if (viommu->ops && viommu->ops->vdevice_init) {
 		rc = viommu->ops->vdevice_init(vdev);
 		if (rc)
-			goto out_abort;
+			goto out_release;
 	}
 
+	xa_store(&viommu->vdevs, virt_id, vdev, GFP_KERNEL);
+
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
@@ -237,6 +240,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
 	goto out_unlock_igroup;
 
+out_release:
+	xa_release(&viommu->vdevs, virt_id);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_unlock_igroup:
-- 
2.43.0

