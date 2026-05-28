Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38622313552
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945536; cv=fail; b=TLvmOsQ9u+O8UPMk/r3+ZplgT0hzKnSr6NBbSHiyqvfiB23WAQORP/jG+/SrnfylqdquQKQeZfwLUTE2jcCu7V7LzOOqWWy2l4z1N6kzde/C7Kn8jandUrC0FIsG6uBy9wzScdzXM0BWOWZc21D4UM6y5P5Ah8XAmJyjEBIR0Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945536; c=relaxed/simple;
	bh=Y7gZpdYAiH3pTIbSvExUPIP1HKpd5h/Wk71QgVUuq9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZV39Fw1xMkdJ8rhnaKQXFKqAAlVlemmZwg8js5IseU8RQsmWb+YWZm8bn8pXoO/tbTXJ6aD6vsVXRoeYCatqBm73cCQKQtdcpBXC7xXpxhZNdjK7bUnXP7YNXQSilowZUGgJ4QjOJb4Bnw6+f/dZMXOgg2MpHmX92HKVr0UMNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dEKBf36F; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dEKBf36F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZxvl6rx/nn3KpnJzHefBoadAo4wf9izCd5fSm9b8mXKNBWpX9aw9opixOkXMi4niaOz+AXYE4YYRgj9qMSxYEzZHNjkn6mZSW9nJqwK43IL1rcUFHyolHnHkdKIOJbsPCKF4bGYYmA1igjOAOa1pTgrEYgMUz+ZFxVEZl905sccHvMSF6IRoDvbP1aN2bcUirUe1U4Cm+ByawvGkW/DKvTqq3O3mF/2dYNeRRcxgrKJ96TRcgdDTInlcwqR5timltnI1VPCugqd1wbdASKkLtmcsESRYaEGYFIDDKTK+leNVLHTpJvx42SaB9w7hV2+YvP3rKindZtmFYZ6WUd7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdisAbtTTjI+vSDL7wCQdXt7D+ue6l0B9nFo94dCuoM=;
 b=vCNdw+2UYBCTFwnEbZBG0TsGKJnkBnGF7fZs+qodnJorrN6LgX1dqMjrINKviMhDVlzMFDs6tVR/m+s+JtEh8k8ZLhXPARNrkLtUCgr+nBU2IA8qBOG+c+OWIhTojoRU0RsoA9/6uuDyVCVu9WuvXS7YnUEvXsUfQ3tnMcojyLvaR7FM9YVXKvtFYw4XjTuUil/olk3HlhvbijaicZQUoTSXOm15vQ5EznGtsV1cQ7KRtbjIuR/nd3ynvUTGm734VMR8RPT3/n6CHVWMQJarDaFYzKiUJbF1OvY+htHz1kRHIul/MCLOCK662J9SMit1eGw0+HntGCzcUxry8paJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdisAbtTTjI+vSDL7wCQdXt7D+ue6l0B9nFo94dCuoM=;
 b=dEKBf36FAywi5qgfDfZHD/Gb1Xn/8f7C9S09txmdv4LwAUEPbVPhfrnvoc7SsFcNtTHapZxlQk6xemEyhbauaA1sX8HHPF4nDHbz00YWBI8tD+GDVzyrHFDkerJRPhRX2ahSABLDyTYkCeL+NMkfh/edOi433Q3TA6eNLCu4VgA=
Received: from PH7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:33d::11)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:18:51 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::51) by PH7PR02CA0009.outlook.office365.com
 (2603:10b6:510:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:51 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:46 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 10/26] iommu/amd: Assign IOMMU Private Address domain to IOMMU
Date: Thu, 28 May 2026 05:17:22 +0000
Message-ID: <20260528051738.596013-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 85acf147-2556-4a31-80ab-08debc789ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZTMC4C39mJokMYZbytbJmlXMysOT4K+fVO0wm9c74VoGbaAq0HM2GMneoijYQnIfOCKYNiTC2lz2iAIzHDMCAPYMujoSwHMP06kQ0g1JPYmFrehGzyXlQebnOVd0ZjamJFbfQfextsAGHKW8qxcqGJmyccsBnx24O4ohwSnD62Iv3FkseAMurIBtUnboUzJBvnXXH27gVacO76jmGpSi/o+w2ZMMhIVH0RsvOV1EnaycVUWiMwV2KE/UxAOx2NvxJZBGTajNz967AIr4KHhLuYFUt2Vno/NmXS4MDiRzEi4umlBStM73KFfwZ9O35QA485K3dWBku5F/PSyfnPijRBfTqsai9/frGqNG5PMddTfbs7SYnvQRr/9Fho3wJT6rD7SxplvkfOezWh4vpQymWU4P7vU7bZxQ5vpfrd3wjF196R2D5QFwUa3yHeWAHNhukbEJ+jT4WaaAtz0VXOD0ECzGpJDXn6TqWuwfB/Yc5C+DulbAPEJDAupl9yg/YZekkSgscjYiaOr9bsSGNwoxpDxXt0Q3ueNKHmJ0Ikkfk81HhSL0XEFpDaXZpz+6G3HXwFRH9/KHD9281J10j/Uwllj31Vep+wjKL0V583X099WGR1w0AlkGsxikZVs+ipREcFZ29PcmFpHv9MWozA1hnAfh774+tv4NdQCewy/X45Bn7GDqfr/aKakBGLbDkNaLtWvsw1dTYEbK34cY3zQr7Q51ZEOSnhPb8+cjV+fJAzI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m/jVm/r5vs+1GXRT7aSLqJ+QncDHRG9qziNsX4FOOohbrt3B5w3UK+eH5ss2QeSiVKEfzox/do+4fwEjiDdCk+Cge+7tMTzraUzLKbMWGXGkeh0Sqaq3TvgaZzSytrvesFK2whKU1xHQRtpWE9sabaYskX97bX1vZMDbFOrTK/+23Oo2iL24OMEAd+dBm1SEZSFQHkUFUMNNtyiNJVkqk5Xdj/s/wqfBP4CTnWOX1Xbdz17v+vzd0Y4Yr+o1fwdyiSR5LPhAmAEvENizNRnbNBdMW8UWsiBzgGWMym0VFbmVPDEOYGYrwmDgLRV92OFoCaetGBzJDlOGnozKb6LAcixRwvRdGMjMOE32N9MKw0VuI5n/M89yUKrb948/eBzzegGQLyrqeBlpVh2TV3s8x/yjvYuoNdJyIbQa9KXvQKrNuwCQo5pxOjij7QWehXnG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:51.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85acf147-2556-4a31-80ab-08debc789ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
IOMMU Device Table Entry (DTE) indexed using the device ID of the
AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 63360eef6b0d..14426649074f 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -173,6 +173,35 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 }
 EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
 
+/* Set DTE for IOMMU device */
+static void set_iommu_dte(struct amd_iommu *iommu)
+{
+	u64 dte0, dte1;
+	u16 devid = iommu->devid;
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct protection_domain *pdom = iommu->viommu_pdom;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: host_pt_root=%#llx, mode=%#x\n",
+		 __func__, pt_info.host_pt_root, pt_info.mode);
+
+	dte0 = FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
+	dte0 |= (pt_info.mode & DEV_ENTRY_MODE_MASK) << DEV_ENTRY_MODE_SHIFT;
+	dte0 |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+
+	dte1 = dev_table[devid].data[1];
+	dte1 &= ~DTE_DOMID_MASK;
+	dte1 |= pdom->id;
+
+	dev_table[devid].data[1] = dte1;
+	dev_table[devid].data[0] = dte0;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
@@ -195,5 +224,7 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	set_iommu_dte(iommu);
+
 	return 0;
 }
-- 
2.34.1

