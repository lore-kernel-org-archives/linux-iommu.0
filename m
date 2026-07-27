Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608C41B356
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159107; cv=fail; b=uMU3Kf0qlo4TyHcexu/Rn6ljKApMkcmJ6dQFxakotnhMY1pubeBPKFbrKjRvMV5D6eJX5yfuTVgWEeuLHckB41ypjYSk6Mu/HVsYQBlCTzywf3G0aj7FtbN/R9XVOhn2gHlcWNcC/SDNd4GpQSIIeJMLllK7R96HkXOgxwwDX+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159107; c=relaxed/simple;
	bh=H078anDm7hAMCsX/4yvGnKxYCcww/89DzZM2rAH7Hso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgBj6/TfmGJ1TJBKRuQNFbtUW3wZBYYHT+tl4YoH6IWEpxxT4AtIuLO1cnfVnPMP4B9T7/xtOMSUvJfBnm48/IlyLpMB+pzjBgCDw5/ViyoKk0VpmRSQSmyzc8pXgG70TmVv1MhOvlmSEMXa2lTEHqegCeDSX3OKWQ5jHaUpG7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uAS1Hxre; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uAS1Hxre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoLJ5iCfTz5tb0T1g0UuEas3LfMogR0zvp1q1pfteD/mQMyWHApw8DgcsYmLYUfcmHFue9iKbgt8UAgVtSr+NP8nspnp0v912YrIOjcZFOJ6n5uJrQE3favwyzjNmRVylZ4UXkgFHz5k7aKwmEQogN85HOU0ncNdfdrViJvqa17DII7bx7VHZSQKiG73Ms3KrYcxhLsFBCh7An7xevkEQSZSCrGUwYDsXLMXzZ9aiwVJy1CxtcUOQMYnad2OU4CPKbAEpQZoRUwZPON3UsyIOkiTc0tDh/np3c5Vuu2qcPBUjdS7Y+9QD93QUHbDt9ai7qU/8g7c93//6Ln7sYV+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYGznF+UtdRQapVpQC7bkQmI5+OzYMVtngsvLbga224=;
 b=maOyDYX5GFdcnPDh7V8Re8TdKdW1BnN1gfLvejQpz3T19PL6OmHJ2RfTMgrubneH2pokGkT4wRdcNgKsqy978Of+tp15miAk+zs6x4Ux8eZVFwvHRTYq3Hy3U0RMsn7sEK6dPY6YNtOHCuwE+8SuXJ18b/T1DA2ohtFdw5ZSoCzDL4xSxjmnNkkqgYxQ/Dm+GMC51/JI84OKSO5T89Ed6nmGltjb95BbPTGHJwefL9t/zoP/SuyLssG+GoU9mnrM93JUHSO2puW7oun5gGa5Yolq1KrQW1ZvxnLzNMYN0IfGHlVOwczoCF2win85dL56jTb4QGTuBYmWRvCPsWNFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYGznF+UtdRQapVpQC7bkQmI5+OzYMVtngsvLbga224=;
 b=uAS1Hxre6lWHYp/Bi4voYW5IwN9zEqOzrHYeEQC4vH0BPSAammngZyn1U8VHTPy3J+RwU9JCCgI41ufs9eCSAgX+8nM08WUxXduxeQI8SkgJRJFogg+4W/GsEqECghOtjLs9/aPd4xPgqNJufwMqIC4zAgrvwWgzeMf0UDI3aBQ=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:34 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::44) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:34 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:16 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 14/24] iommu/amd: Add per-VM private IPA alloc/map helpers
Date: Mon, 27 Jul 2026 13:29:03 +0000
Message-ID: <20260727132913.22475-15-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a758939-3f29-4b32-48bc-08deebe360cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|7416014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rmwTY/rOAN4kBcJKDsU+fmdcrLsnGvcIjiLYwO9scyzf4XYw+9HdDneJlTT0js/MrDjw3gO4AyVq07x6Hf5y8bJw8s1DB14LQMKTuo0p4b0ZZzqs2HRZHaejfiqglsRiLSrjPCDxcsayAAzipZSRwQ/eySZ/b8bvQXoyv0k3YSj/uhVBl8q7UqeneLUymkSVipV0/1GKOcbk85Xu2WWs9uVriKzyQRlsg8cj/MjBJjJQsDsNNpMGzS3pXpnt0lhmsxFpjK3vP8jfWtZs6OGX7pdnIUm4Av0OPT1/iZVqkIeTzGStOhMg2a0jl9ecW56xJNJdtOqpLS2ZRGbHYlbZfy40mXyH5lYZzANPw+WjLvJiEKDt6y9h5KR9Qr20A7X0zGdBM4v5Qz4fUQoIvObjDod0IPbRyVjTsiL0z9E45T5GvpaojsyJ3GTBxwLXZaRvH2ESEzyAys/ATaM8q5/+0924J85wQY226v6/5BMlBIR8kUEek05fzLkotrq41cBvxm/PfH979GefdCV3fPvBlyq6f3M+gnO8F2O6CdJnAicAWZSq7hWQtNWFR+kMPDUUZWWLzqg3q6K9Fn7WYMfkNYaSnjFYf3QwOMDlxVIFH9kHjOLgdQ6rzroQkX7/MrbZkFyMV/OoFTl9OPlbg9Ln7f7XnxNYCRpJB09whozIwE+1H/C6EgqRYAIyy4CJXjVFNNJt1Akpbx/dQ++cQW8ezw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(7416014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5y2ZnJpYMtARkovc/ETk0gXmZq9ot0pPcgFgEEchtMAuJY/o4bC7lp7TizNg5VbEozjHlg/vDJ7mTwy9s9l9Fq2FGczn7nRiOpy6H86yKSPDPzLkbI7CGVVwbqABAsp+hXcBIivstL3Yd8ZlSCNgi+di8RGaHGbbn5EFIn3qodCx6U/Z49rLd/sgufkLtZ9Ci4Af1SuAHf7V1GkiRCQQGld4nSrw27DGusjvVQy5U7B0w5hnNIy3nGEYLmssfCkZM9pcw/NY5exJZ9AYm1T1X1O+3TUITiqtcnxntHzzUeRhLDxE0RZdc1LroLm7NKxEIFtutqSYx+HXF8/NpX+YlDwc00QvNgpNnc+YA5r7BEBwcZQwC9ZORD2FEjB3OUuVqlryh52kwzW2v7KT5Sm0ipxkwWzBLtJxKAwFSZ1UqO9HjgPlbIbMy34fzzBcn0x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:34.6662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a758939-3f29-4b32-48bc-08deebe360cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

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
index d2782f9070ee..2c1a267826dc 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -367,3 +367,41 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
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
+	ret = viommu_priv_alloc_map(iommu, addr, size, GFP_KERNEL | __GFP_ZERO, &va);
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
+	viommu_priv_unmap_free(iommu, addr, size, *entry);
+
+	*entry = NULL;
+}
-- 
2.34.1

