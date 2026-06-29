Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932A3FB7F3
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747734; cv=fail; b=hroYJqGMLHtvQrZYp8rTfL4PSroGF1e5D53/cYt2SSOiM1OQZlf/KF4nuRHwAd+/Peqor7c3u7afAbLMI8zk15M46IIHQyIMHLPpHVihksOb+NPGlT2TVuvBL656s6FRQlzKgzKEW2VZQiOKtTz93/6FJP0JOzh+bycaRtVGpd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747734; c=relaxed/simple;
	bh=AX6I6zf7qJRE4JRdpNJ1EyOLYkZKCnM3KV5E3rGWWHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+JbNvWbjlbAMw4DNXvE8ylicP5zQ+LE/SRnHTWJ441hPKJiSQwvfFu59eDv5HvVhBbCRB2Gb/ZNWNIAaa+7EH4Z1Eah95x79btUGoDUobgOcEOlRq6jzcvln7vkoOQR0cJFjBHxCV2TkyMcZpIpl5/MxbhzePnWkMhJ9SKUfVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KNXyvvQ4; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KNXyvvQ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQuSGyeTSmAfOxPw8vzSYyAX0vF97DC3wnoduZ3IC9NOclfQGlE29ep+7YnUEPCMhULmPf0/taUPBv9VZ/mu5aDXiHtWHS0qWs4vgqfWtkxfMBa2lDvIPIg8o91hjS8eZPBTmPGU11yfzkzlN7UT6uztNPC3STDF98giHQ6JGA6196/WfJQdzw94nehIVQmyslM/2Ch7AMIRmSURDCV+UzVsd2Fxz3mYTBCBZ52kqd71W8Vb5hTEs2dr9M8KXOnGLyydsSaxfJXY8eEX4/LFnHYfwF3lX0Ea1sy4eoQd6h1AzkjzRmiPLj9d437lQI3apV/8QKz3CYXvuZacqJIcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIDVx0QtlL9aybbsbeIyo0QxZnjjbX37oVCaaZtjOYc=;
 b=oCaWWOuRqZjmjKuHT+akMKctoTTtEsn6ohnS3ua50Z3oaWNrnyGvPPBNEKB6RqGvLdCXCrVnBkaL1RL08bUt7YJxsdKRLgOuSTB2lgWX/4GLvBdSJsGXzcpCBNCpT1D5J+DotqLhs02jb867hQBWu0POrj3TJFURgsASnkigvz6iJ7agM6HTNC8O0EJyrCitUNhSYkHCKgPb+Q8CWvekHaEPFF5vO0rLMQXQY5LoK7/y/kP73u57b01nnrqzrKwUaslGXTA8YYhIP4vv0S4wMwms5fN84WxsBDZD8fV0WqXq+g/81wMTZzwszxPFkrxNLpL+wbi3U9ir76H0kFSxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIDVx0QtlL9aybbsbeIyo0QxZnjjbX37oVCaaZtjOYc=;
 b=KNXyvvQ4nKSQHoLT/X1oeUyzA3o19tNzfBaBNBSIJSDb0/BRgoU+rVYjnuB6g9J5uUDVIS3CJ0G35kVyqh46YrosU0fgXky5Gbm5g0NV3Ua+h88QLAw/1vq6Dwt6+GMcuFfr39xMuuTqBFGn+p+1qovH/Puq3g9S6hnSFoeTqFk=
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:09 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::36) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:42:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:57 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:58 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 14/22] iommu/amd: Add per-VM private IPA alloc/map helpers
Date: Mon, 29 Jun 2026 15:35:27 +0000
Message-ID: <20260629153535.15775-15-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fab788-b2db-431f-38d8-08ded5f4fb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IFESAwfN/ZnCroaOhFO7khAYlBElNbzDzn40mUMvBZZX74yRHGNbpYySbUSTV0zSH4s7UIyvgQlE43m2PExAjALsOTw9LTdvoluFcDVdWbGdo6cL48X8qm0pr2RIMREreUh4KAeMH0BDOnVDy4r1y3DwC2myFKjf9lFnaB2C7vfjMuJ0pHgDTmIdN8qH2v6xlvsw5o6bPO6kMIeOH1ckMQHnYIxglld5fYnrZEr4iCLnytW4jHowPxkgNeT3SRU2d9Q1BCPMAxwahmTuaJWQycXb+sle77zfUri+sh0HYb9P11MBmQPIfv+09hJ5Dvg8vrqhyfXTFsZwf2NUH8w8/TlRRuS10uodZ/fjBjDz/0WFrzetZb7Xs3wIKEAgDfXDv0Fcs6TfYLCfkvIgR+VKcrzoOwSiogRoz70AS2ovw/CJyOcLwfhrXYeXGW8H6FIUbU+7cEda7LGdwmEvYkBAeLYGbqU844RMVX7YhxF4+m+oIhAWtvyssXTOMhh7o8XQQEZmytYfSoyyT0qpURMW2Iv3LFLiUsYKkyTcpsPZomXfhts5f/e52a+4bUDwFaeYEAS1MLKkbKDPTj22OmwQu9qjNucw8zzFIoffikVNb+Q5+6IsCYZW3IGh6O+DRq1AaMBNCXSwHELYumTd7qjzGEg0hhmiGBuT5KhwW07c+b/EsYH7bjV3lS2Yau53ibdYewgyZZ0/AT+AMY6jkw2/dA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8/3NiAx6LIzS1nHEwq6lu1676atFMMqfye/Lfrq8sQr9b5GQypHrMi1ovy/Gsr1te9i+Qx2yi8lvRlac2ok1Fshdfp6YAySt8IKM/GNyqXAddwYDH2BYmwll/3H5ADRXWrglViJ7s5dvS8sipSt0seRUau2S8mcvQCE578If+FKPdqjC4p3JFtKKj5rYhdtK+/NWxQDMdqxw47n7X0c+W9KnGJbge/E7c7+3UhD46V0zw7kvE18KHjRhdXQ0KxjRzNOTnJrb3ydoPaAlPrZcdYUalLgv91h650X6Rw2iLfncfTUyYevnHrO08Po1CFm+Jh1yZ2b2KzCbdu14XirrfUB8v51rLsXJzVgY0hXeoaLzWDxlY19025lXE4BF2yCjRMWMS1FpTyDsnVq/fmP3o//dDJDQcOn4I04aBan7HOsWxoa3mV47PqwfjfApIyjd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:09.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fab788-b2db-431f-38d8-08ded5f4fb11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

Guest device ID and guest domain ID tables use dedicated slots in
the vIOMMU private address (IPA) region, indexed by guest ID (GID).

Add alloc_private_vm_region() and free_private_vm_region() to
allocate backing pages, map them through viommu_pdom, and tear down
with an unmap flush on VM destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 897355a143d6..808f0b304006 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -374,3 +374,41 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	viommu_free_self_dev_data(iommu, dte_set);
 	return ret;
 }
+
+static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						 u64 base, size_t size, u16 gid)
+{
+	int ret;
+	void *va = NULL;
+	u64 addr = base + (gid * size);
+
+	ret = viommu_priv_alloc_map_flush(iommu, addr, size, GFP_KERNEL | __GFP_ZERO, &va);
+	if (ret) {
+		*entry = NULL;
+		return ret;
+	}
+
+	*entry = (u64 *)va;
+
+	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
+		 (unsigned long long)*entry, iommu_virt_to_phys(*entry), addr, size);
+
+	return 0;
+}
+
+static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						  u64 base, size_t size, u16 gid)
+{
+	u64 addr = base + (gid * size);
+
+	if (!iommu || !iommu->viommu_pdom || !*entry)
+		return;
+
+	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
+		 __func__, (unsigned long long)*entry,
+		 iommu_virt_to_phys(*entry), base, addr, size);
+
+	viommu_priv_unmap_flush_free(iommu, addr, size, *entry);
+
+	*entry = NULL;
+}
-- 
2.34.1

