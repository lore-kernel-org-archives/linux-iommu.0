Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B22D46A2
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957882; cv=fail; b=k+ble7uiShw10GshZX4GhG6Qpgyld52+XjFNJV/MTLSuekr5Klx9wGPX/Gc3dh9uuTPJmZcTMtZSmP2gf7fYycdtv/2LZlizsHmRZZFVOnKuXM2NduePwARTtFIYUdA0Iiv5+BYlLC/xn6gprx0dtx/Xm1//NjxyutIPF2tqkls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957882; c=relaxed/simple;
	bh=DX+agFretEc5ixHDqmZQQGzafJb3z2PzP3pLOZK5MkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4OlWBztKXWioFuhDaVWZ0gossUXR2c0T3c5sOevkkhdG/TF5KAOZeSE3arfY9L6nuXcbJV/HlwvtJpDkU/shwHjZB6MiYHCEtluPHxpr4NFSA6Dp6Fouc+YJIZFd8r63w533hURDEM4kN/64CrpEpHZvx4riWO4XAvkk00K3zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qF7YxVMg; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qF7YxVMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZO/rLhg56fDV/loqDdSS7/PO6GR4lHZxAS5vRzDpAAKmxNMPJK+tYJ6mxx1g6t8LRR9G6NAWNgvKj4QsEeVXrQbIv0EOKGtoXQWAk7kmCw1tzCw7GN2vBebA4s+diN9+/s4NWHcyCOaotrOeykcpVALR8S2TQTFFclMZFbYtpnk6PHzEtJtrLes4Af/MaLPWRHS8lvndWE5KLTs4nPVPkv4iW8mgUQPMbaEZ50M+1Mx/vEUprcEOLiAuaKGOK08cJhM5RosxpVfmpuKfgKM1LsMdQZaxl+diVTbgHkm082fIXzvLrgcVN0NSu8KqlJhx84ioqxaLseRnvKqe2znQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDNYPNVSiXYimB4vNDY/tSWIwv1p6imorokrtljh2aE=;
 b=PGy+kvNqhoo3T4mrDoJYARdAwnIZYG/sNEKrkD3J+xJeMgspT16BlYWv4rSms6pnnxPK2ApgvacF1nVkAuY/2E4VXGSVCRiG4BHrLVI8OJDJhUJwvRxTmCvvZtJxQ9ioSVfXdN0vG1rPtUysTCalz0FpnGpgN70TXLMc8C04UVM+xTgbdgkrOkat9t5Lds3TFX2+PKq1iEUcHmJ4TQPqG5bFSCH9aqNL4RaU8YHyMMwDK9I8CavwWYnEwrtgOHVGn/k9tHM14UT7oMMNroJx7eFCeP9jyO50r4c8iy8UGqLif9bJNzcn83M6M6WGf8O8Xtsh+NVpwsgpXzU8mydl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDNYPNVSiXYimB4vNDY/tSWIwv1p6imorokrtljh2aE=;
 b=qF7YxVMg8Z+YS1EAbASwQYzBf55IeIc6ETTtQZMO7MxC2GZhTlUrtU3GCdcVhlnETaYNmNBCqkMCAAoLOo+fplCsDaVKvdMeWkJG8Q9dtuX5f00EhL4FkeJNbWt7HGO9Lmm/3qYnqwxnD8Zo85pJ6wAiwf+UTp+/gx0ghqv+57U=
Received: from DM6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:5:174::15)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 24 Feb
 2026 18:31:18 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::e5) by DM6PR21CA0005.outlook.office365.com
 (2603:10b6:5:174::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.6 via Frontend Transport; Tue,
 24 Feb 2026 18:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 18:31:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 12:31:16 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Feb 2026 12:31:16 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<vasant.hegde@amd.com>
Subject: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
Date: Tue, 24 Feb 2026 10:30:56 -0800
Message-ID: <20260224183056.2628698-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e390a75-c82f-4d5c-a582-08de73d2e618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYePJ5EjnXmwgUoVq1Bfnp1+DhEBBeJ2ndXyZysS1pK07gN5Yxz//8NO0HLb?=
 =?us-ascii?Q?8pKbr/5+w270kH4hUPfNy1lxp8WvM4d4IuR9OIhhHd3iTGMtjhV5ZNlJXeTJ?=
 =?us-ascii?Q?w4LAzf5vnR6ER/SGb/z1vsoUeX26TIWXW+ciV5QNTHc+zXXYxAdUB58Bn1cm?=
 =?us-ascii?Q?CkD1a64VlT9iVTELRdcXOC5gXBbvQFwbj/7IhVgc+AhxFd5/EqZPa5khbxvL?=
 =?us-ascii?Q?TL7VpXm7bGJwOhFubjeHlhXd8Zo0bebLuaBi2IGTOsFDt1s7bIlhm6W6oGSH?=
 =?us-ascii?Q?BdRFNk+ujXTlernbUgCHuIY8i6ki4R2mFf+HcjCXQh/bWPp5yB4TY/LhhwiJ?=
 =?us-ascii?Q?1rXCC5AMTviuyLVS7FP/E9QH6Vcwxi0sf6VBGfjqQxrMzRzLx9Qad5b8VkHL?=
 =?us-ascii?Q?dzStG2R8Rdvyt9WBO+ym6oUuxUipj2jjvU3bjtN1za9MrbFRhBYAofIxt23r?=
 =?us-ascii?Q?vmSQB/atowGYbyWdB1wARcj1o7X5im0nE0W/jaupJuMTY9NJkhJu4dBL7VSc?=
 =?us-ascii?Q?aDQwUQwnLSDUdCD6Rf0FSX42Z0lVcHIbhPURnk1871Pt+IhPhdJz21XnKIdr?=
 =?us-ascii?Q?sw/WKwYK6DVpqxi+eRr/UHDYmnnkDP2Cym1w4pLvH2VyiFiaVICy2DIKkScz?=
 =?us-ascii?Q?zU48PeWnkYixWpDUnGIQLAt+ioLpvXmOxBH8Bm/yc2C2Urx/IkUBPnDfZmQi?=
 =?us-ascii?Q?GGGtpMFDEkfLdFM7NB4rewVOpg3WCW/bCO1KnjOMvTn2LeQSpgrvU5EKNJD8?=
 =?us-ascii?Q?alszWyoP77mjFqAe4r+0Rchp0Ta831Ek8A4XCoklA2RrddxdFlHIhzzA7hRS?=
 =?us-ascii?Q?u9Hzz+o9vFJLLEHAu4q0UaX2X8iIkqdOB/xopD8ZTcm2O2fvQdo7Ve3ewvnd?=
 =?us-ascii?Q?HqdM9QIwjO49LSUzv9gdircVtNCjGb3OlfRuWoYqYrxP6MqKtDOUwYhHj4GD?=
 =?us-ascii?Q?rm5b6V+XxPK02dB10TnGMrB7kX1nPDPWXONx3ytWrjiU0JcqOFtJiBBb/+Pr?=
 =?us-ascii?Q?2nNONQyXJS1YUsjoUnRPWgt/Vl5dHmbINd9gEDV849hK12lFsYpHR4LgWrtJ?=
 =?us-ascii?Q?iJWV5C4pGjmob3ar0qa52f9WajKMKxHO7QGizTSccFMuURPBHDnARdcYNZFR?=
 =?us-ascii?Q?PBZcgqpaIBYLrLyS3qT4CCF13/9qwB4tTgGdK4AOB/7vHHN43lH+dRxcr/Kh?=
 =?us-ascii?Q?Xxcvh4A0NqzE0n3Ng5i9Biopeu86XycghCwsQomcTmcgrA6XoC5WoBkqtWME?=
 =?us-ascii?Q?RJN01bhUnD++8mQ1VsnkWe3cE1Zt9xREyaC9PuTT6HonhCCJ7JOFR66NM19e?=
 =?us-ascii?Q?aFp9mP2h6h6f1d+DbsuwQS1pGHGH9QybslHJVfp8nwwDWdDa75aDyZTf/n8p?=
 =?us-ascii?Q?7PKQbIcN7AxbJ5sm/fkU0cBholZ0gEwLXWOc4YgZPUQOkOXkIIq6+CeLcfHj?=
 =?us-ascii?Q?pjp2vBsavBuCqUzgBtO2BO788tYVAXnmlSq0ogYysfQqbwfSHmUJMGLuyaGL?=
 =?us-ascii?Q?riEoG8qnWipMKLpTfEkZwaSH6vwVvn/mTstuk7ISMvIG4zIsnlWuEq2q/u13?=
 =?us-ascii?Q?ajAqRvigCeq7GcliczJDY+gbwdy05Dn0ACX6sD0gstP6AXOt2dYAI2IG4ke0?=
 =?us-ascii?Q?DiISa8mNqtjPbC+0jrOy3fMTl4n+71Alus005PUV6/M3pix3r7bAmb4leMrC?=
 =?us-ascii?Q?M2KvIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M1qjsPpW4acxL9Uoo61iVIsSAlgIxOb7MMhJxYqkoQcq9RnKpMsXXzJaAmBYig7awcpACI8cCTTn/ervo95GSZrDSc9D5vIpfj7SuLnE6P2HKfvuLXNkxLzOdzW6NsuPUcdfgejcZJ2a6qMhI4KYflgOlapjfrjrKuQUaGruXN5pvaLA1qKHIFepNXjKAASVxgaDkeJ6lMpw6DRPzqF+T0Hn551g+VKokcjm+qjGpWVunkTVnjRxYuMRaMBIxTk4NM0wIzIq33ZY5TedMF4n70dkyJkP00NONFbs4GxIKp0qDtM9jEpcY2pTiLoOBlADDLrGni4tPFMY4XpS11v/Wd9LteikdS+HQCf8kxhCeTPLAInKC+w+4xafjF4v4NdSZtoPSrKtrvfPvNmNGWNx3KnUf5sc8mo59IP89CfNzFkj0Xer4Bj90kwon8fsAI6q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:31:17.3025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e390a75-c82f-4d5c-a582-08de73d2e618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28

domain->mm->iommu_mm can be freed by iommu_domain_free():
  iommu_domain_free()
    mmdrop()
      __mmdrop()
        mm_pasid_drop()
After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
dereference a freed mm structure, leading to a crash.

Fix this by taking a reference to the mm via mmgrab() before
calling iommu_domain_free(), and dropping it with mmdrop() after
finishing access to domain->mm->iommu_mm.

Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/iommu/iommu-sva.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 07d64908a05f..523b8c65c86f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		return;
 	}
 
+	mmgrab(domain->mm);
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
@@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		if (list_empty(&iommu_sva_mms))
 			iommu_sva_present = false;
 	}
+	mmdrop(domain->mm);
 
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
-- 
2.34.1

