Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739B37C108
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747755; cv=fail; b=kQCsR8Qf/plcJMoGb/KDn55o+CabXCTh+qrS1UwwQ8Oy6qm/b/mX4p8BpbN9PUjalqyLl2QkOh+gY28w8z1ujbzx8mbtZh0VseUEFKjpiVRS9HXcXHm6NPfEdbR1Ri60EE1l5s1rvBhasWn+pBodjkW7ubv166KXmD4P/tnRrD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747755; c=relaxed/simple;
	bh=Z6mTBBV8IGFRqbuJpq8lVhkLvwy5DyyVrLMI2FXIpPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0+Zud2y3IYWY6cxy0znMFNY5XKO3iirFCMHg7+dVBQMJb/ObICw0znJGwRAqPj50d4iQyhUTf9MiNVWlDa+pYszIYPVezNO0Md2ubIJlxIebDCmlZ7kL1HEILdMFrhiBSUi/tgzQUC21FOaiuSuY+NM8oNmgaHp1P9zzPP08DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tQWKxWvX; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tQWKxWvX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGyrjYnH+b8n8Y+86uTzVeTg3hEqdivN4E62Nw1yMgF5sdOKrUexDbDmYgHMfHgjdsPzdZBdgN7hy/TlmwUFENazgMk5FrM1GU5fxjDNNSwevb2hiQ9kFFYDZRQ3p45GJV846Kt8Egc2jQR3qyKrbcpH5O21ZjffzREuNoZTVLkCa/yk+kMibow+0wiK9bdbBigR/nwcFAPJHUsyX5xmKK6GXFmgT8yS/xeKdyZMZ3DXMHvN9Qsfc+po3Zgh2v4/ivTEtnDJib969yZ1oiuj5n4hmNqmyWtrCLqpZtxlKibpWog85YZjcDfq1ak9LOnRrcf3EjNfPwbEqOyyPYd5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcYo7naFGOGiG5KHWY4jLyQ3ObUHp4UDbm6+H5fPdc4=;
 b=T6E12TzPGVQgvfC1dL8WwcIws5Ibmjul0xCagRd9IXxsyGKXuCwqpA0zJXowPpOyUaKZvuxM5YoJcCdHJ2U3J+X9XnurYd5Ey1mkrtDGALwnI0GbytMBt2JXnSPt+xTzOcc9AuRTy0HnHPrpv9ek96HKrWGCw+6CpOCMEt4BS9ncmWbOcec+TTnE8zT123g6CZrG/d+p7A9sN3N/gOZiuAczzwC9I3fc6B/HGOfpl4mg7qkpLi5W1+L6IP24zbwu3zLlBlxhE78QblWWw97EDT0pQay222myR3MWhB5A/Uu2vYaCY2w3jyGY9bLbVMGQwgzbn6UQ11h1vz/EQVcXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcYo7naFGOGiG5KHWY4jLyQ3ObUHp4UDbm6+H5fPdc4=;
 b=tQWKxWvXqgD6oONvsD7eiohT5usr1TSQsmJErTgUurude+QKjfMcLxeVVdhGGz477UZT2uiiPHJ0c8+xI/1bdkOAxEJX6was5VT2wYnrJR7tEPb+D37w+c0pX1QhEE9c3tqVthr3XZvlwmU/QzUeQ4Kd4xpjMUNTru0E21NPGqs=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:42:29 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::6f) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:42:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:56 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:44 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 11/22] iommu/amd: Export amd_iommu_alloc_dev_data() helper
Date: Mon, 29 Jun 2026 15:35:24 +0000
Message-ID: <20260629153535.15775-12-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6e28cb-84ce-42d7-44d5-08ded5f506c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mhG2dLxrC3+Ja5kcyRC/a5SBbLtxU42sy/Ed+4XXrDFHJeM07z7uyPFiQp0KnHBbluUO6KNjlXd3EBt/JjddUK0tnbM3iT3kjIm8Awu5I9BbdqyfFmBtSOHM45dhy6l6QbeeSeUC5DpTjNOFMzco+ZEMI58yGNLE5zi+aN3REfJTCYznuWqnhHjLU+Ql4IRJbyCvFxXbe+5nkOCAO6LOWsk9D1AJkIKfIwKPr3rH9wlIgrX9oUl++D0qcJz5laX07DoiTHN/+TH0u9MfACkcxmcwQU5YYs7jHkE0xcanDP9znbgaWvJYkOgqDz985gqQfwOP9Y8vb2/zofUeUhs543TZ+K1ij0tYXZqvwHXIabYeTW/RvJE3yLYBweWcsxqpBA6Uefgj8AdL/HJqOVDdDGYYMaGAEIPuA3fcwloZABJV7QJNihyM4nMjqWPKEa+snONxweLzqu2RkXodEorJoMaFMR5JGypVsNeSbD9ZdVib6/fPJcSD3l85pcay8fKxOwoFlUaEr5HevM2ya0XxfmEMwZ7jMPdKnfDn2lcioDG3neCsgRPFR27UYgmYneauWI/ppHDBamwsfFTO9p+Xoclk/tp7hXFeKtyqkmRKAqEgbDuE4u3QFdk4GecJOvtRV0HB5pvfe2Is8ZvX9P4Y5APIjljV6cLuWVgHAOvE6Uy63iDaSJJmvuBDAIQE1Ut4Wa2YyJ+7sHskrZOmpFCF/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0yDpfFLBYKcexS+xVqOJHLu/AAgbAFNBuNkQXJv3hSoq+nI75jQ7fJWORi8LvT5PLEimNdwKLk9cEPT4eDk+RE6cwWMhNHrNdLriGx8RMMXuQLr4wXFUOKRKdXgo/fCQtOvdT6fYji827QkbJfKRm4oCRrt/kmas/l/CkiXuYEseauKhEBd7z8IGEXiZvJFEKS9CNN3rubJKApAocxAzLd5dsb7xkDrKLRgEfipan2ZzpBSwHRgciJNNGmTJXAha/TmyoaCLRVUILNVRq0jxI6BhUbfBLaBBvI/7xrJIqPxLwoYT/FPrqM2IS4r8YHTXfYI4HOSxLhYs/SQWcfzg4Utaz1CsuuOAclcIvycsbw3Mkj50Speda2dRRZ7tMTpBSuLh0JhdK06K1Jsu81jDN7aCeOns1QgXbA35huKgnf2CxC8d9yS2oBk+MESuwstd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:28.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e28cb-84ce-42d7-44d5-08ded5f506c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

AMD vIOMMU requires programming the DTE of the IOMMU device ID to set up
IPA mapping, and current DTE helper functions (for setting / clearing)
require struct iommu_dev_data.

However, the IOMMU device does not go through the normal PCI device attach
path, which would allocate the struct iommu_dev_data. So, the driver needs
to manually allocate and initialize the struct iommu_dev_data for IOMMU
in order to reuse the helper functions.

Make alloc_dev_data() available outside iommu.c so callers can allocate
struct iommu_dev_data for a given IOMMU instance and device ID without
going through the PCI device attach path.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 ++
 drivers/iommu/amd/iommu.c     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 279f458becda..20000722451f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,6 +56,8 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
+struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3eb7e2ac3782..55257cf12bac 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -388,7 +388,7 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
@@ -510,7 +510,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 	dev_data = search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
-		dev_data = alloc_dev_data(iommu, devid);
+		dev_data = amd_iommu_alloc_dev_data(iommu, devid);
 		if (!dev_data)
 			return NULL;
 
-- 
2.34.1

