Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05F2BD001
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054382; cv=fail; b=IiHraZlMxlOSp+HZoYMMLNtmZq5r2USOAnB9KKzdxgRISxqhKi38+sGdZbHzSSiK4iMm8+4ymj7Or8YU2MZMuzRUsDRnfg1LIlkMICxMqrbMM1imTOp80cl1oPWcaPd7e7EeYcrOAceqVeWZdTbd/MX0qL8J+7vA02YIThfLao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054382; c=relaxed/simple;
	bh=v4WQ66kiK/wSsxL8TQ8IIz12Rfr+cKNGiK1SP4jrlzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiqSb2PR+VduWU72fDhirlTE9vIyugVxHfQUz0cL8Mcbl+MNF9fZ35R+J1NRxZ91SBreKh92gG+WFYZGkHFhAsVrqVInF0goccmw8ESKCNY4WWU/zQylQoUszHn2WkuF7pS/rxNkB+//7fzFlCiyE4Uwym1se9QKB6PY1yJR7LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IXA4yU4m; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IXA4yU4m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EauyUwIY1W7sMwPKX3vIGeDbwEcHO/8Dm+OiWJ2Lk6El6B3iUVhTy96ZSPKp8E9OpuXwVmVMT2q1fVQswHRP6/uKd+XRQDcoyYr6dqYKe0UyeIGN9U1AJE3WYxm1Aj6e/NKK2jcQadM7ikUiP4ERE8zBBqz4KGyL07K2vyJ3DvcoWlvxWi+5EuyGL4z8TikQRjreohiYSqaM5RPvKxG+3iXrl6T3VTC2MAiVfdrx/iunAUrQXm6grI/8815qXtzUW4ZFe6BMERUkM5sukm+oNVcvM6HFese4USocTiqKy2p5M6jl0Zk3VB8AORXOPomZTGpnLguEZZb3BO1yj9XGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBQN1ned3RgcZgSbZD1XVPU8mfQuhTST/vxm0Z+MP/4=;
 b=aFbZ5PF2b6Dc44qQee6551/dpYVYoX2daD+jyoxxkncxsq/vvBz6PmbgSWNMD9BOPNX5CdjVO6zXblBxLi+JczRIR/OvCluE7T+uguxZyYY3PM08xJ0PiqvME2RMSM/y7VFCDUp65xk1t9AKn3QNIcdEfRTxLcdF8nCViVk3ZNP0I+1wuJjwDlG5r2fYS6NmKC68Z2dW3sTwmAGKqbrGeeXu+AbpNE9Dl4IyH2j+cIeSuQgvL2kPkx0MwBwL5O5JTF24Vy1r1gA90YoPjx2eOfIBRHPdoGoFkFTVP6xZHPu0OKPP7S/5moZ5Bff9bCgvDUzfTChB3HD/mWzboD0wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBQN1ned3RgcZgSbZD1XVPU8mfQuhTST/vxm0Z+MP/4=;
 b=IXA4yU4mnyqmi1hdNXByFaK4fz46fu/9C+aQAcip+knuNJDVxneSDIIHl5ooPTSwCHcJCNf6t45miHa5gLzLTrM8bTDAgJQz2R5a+J9p3ZSi9BwrvETn2eqHjFRUzHEV117bcBPGFeHuRKS8iMDnswMUA/Ye0NlGUi2ULtkwJlQ=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:59:33 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::68) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:26 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 14/15] iommu/amd: Refactor logic to program the host page table in DTE
Date: Thu, 9 Oct 2025 23:57:54 +0000
Message-ID: <20251009235755.4497-15-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df102ec-a33f-43b6-26ef-08de078fe4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E97z/iw0C1Dy8JJ8z5vAXQGvgPi0+0Kt+tP3lB2kOeI+LNqjMtgXqDvlx1P?=
 =?us-ascii?Q?0tuJzdPq8sKBaAGY8hoHuUayfrfk3d1nP47mzffkxkzmEZ9rIEIs3O1WMObI?=
 =?us-ascii?Q?PYnetuCX/PuWvEm3e57/jTKJL01hCsY7z/eq/0VMmWJy58ClHVfT/Lm5My5p?=
 =?us-ascii?Q?jjvUu0dGCmxXnVI1xgEd7uAojQsgkaQ09D/0m8fbtQy9oLlZ4mw8MNOZMXdF?=
 =?us-ascii?Q?l/KyfG3eShhCyFDEyYH1lAknjaTzwo3bg8BdysMRihjuhDcmq61o6y14pULC?=
 =?us-ascii?Q?kNInUP4zgnUrkYUcKAQJbAeogtb1T8eSVCM+QkQL2/l8oamTCowxckAAmvDQ?=
 =?us-ascii?Q?K+kAP54EkWLK31cXIjpdwQuX/snhujv4Q6yBKHoqbua04Mj4GSh7p64+pQAe?=
 =?us-ascii?Q?foRmTuZVPFjxmwyf7+bSGncGmdrjSNSPnYZbscyul0QTcSDDiopZrjY6m/l0?=
 =?us-ascii?Q?Q4uNNXvMpkbke4/rhMX5KF35dK0t6Mkk64nQaH5lcAq4kTauaiZFn/bTVEYR?=
 =?us-ascii?Q?vuOz3R0YkVMVptUzmycuYhRl1VkvAPiDUZRljPQc8DOTyEnTXMjEddPTNkhk?=
 =?us-ascii?Q?8L9JY0w02FvYq66mutYzAHCeRri7u+UouVsmVkAreIrIpRV6zAH6dss+MDiw?=
 =?us-ascii?Q?qK5l37JifPYof6MDSt/cLX7eRtnyjITObFq+ZabirWSjqE6/huncqRSCGuXY?=
 =?us-ascii?Q?ZGRe72jtCWCMImvzRF6E3Vm8v5Oh9c1UacST8pIpib38CBWre6US8ugBaVMH?=
 =?us-ascii?Q?4w7PX86j+r1lwRZ3jCBbBQ10cdVt/e0NZ8u0palvceTiHnw07FIhFa0jdxUQ?=
 =?us-ascii?Q?+Zap3kycDaYXCDbVmGHqWkKBUVV+N3hTXBfWjUfwwwtQ5k5TVNbkkrSkJSEB?=
 =?us-ascii?Q?wJrxpNCs5bVZ5uGxmQoy0NezntRD962y6D7nME/RpVh91coeofdV2Gz+baKn?=
 =?us-ascii?Q?/07cks/qXjMAoZ8E7wxXU34dCC3AeMB4THl8ihyS9leYmvllmeCDZe6FXNgd?=
 =?us-ascii?Q?lZT08ObM231OgFtLu6CxrKwWdxXxiZ6hzh6AD+Z3NpfhL0YkaHhyBjvb014M?=
 =?us-ascii?Q?vXXdO6ptjlutl6mu/4kFIEbNXaUmF+jpyCoc35G0R/Wbgmb0cv5+MGzCZmCK?=
 =?us-ascii?Q?RlHVZ0CLk0QMq8XjJyUnyhIoMSpE6jlpQykkY3dBZDZ1m2i9UcAHXSf9j6DO?=
 =?us-ascii?Q?Zp3h9ClRQ+Q/4V4C1bQX6wJPcaOjKbzkx4RD7dA3w2gGEVivwW+OdCtixoo8?=
 =?us-ascii?Q?TOZG3ZmA/5bzcPjTJdmu0C8k+X6VQdOrwASk4oESwONRilisr+mRN4m/GJL3?=
 =?us-ascii?Q?Lz7XYu1WxF8CxGZSaEpqhqPQ4Gb+5ZwPv6igkYvqtFodGj5wuCcPm7C9pczr?=
 =?us-ascii?Q?kzc3wFiVS2rRZr9QSX13NrAihMenH2cA8BwXmlH/3Z7brBLZh+mDul529HD8?=
 =?us-ascii?Q?4oR4xa37ncEPYqLx52c6vLNPtNJHFiON8XfxTx+DUDh+fJ7tC4hOkJpGzh/l?=
 =?us-ascii?Q?JAR0CS4k2p6Q5InYMEoar5m36rzJMEPvJW0xBnyQewP8mFYy0H33fniU3p1P?=
 =?us-ascii?Q?xIT11dnrpk8hTPDUcCg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:33.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df102ec-a33f-43b6-26ef-08de078fe4d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Introduce the set_dte_v1() helper function to configure IOMMU host (v1)
page table into DTE.

There is no functional change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 54 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ffb1adfd75c0..2a536d02aeab 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2044,6 +2044,32 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
 }
 
+static void set_dte_v1(struct iommu_dev_data *dev_data,
+		       struct protection_domain *domain, u16 domid,
+		       struct dev_table_entry *new)
+{
+	/*
+	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
+	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
+	 * do_iommu_domain_alloc().
+	 */
+	WARN_ON(amd_iommu_snp_en && (domid == 0));
+
+	if (domain->iop.mode != PAGE_MODE_NONE)
+		new->data[0] |= iommu_virt_to_phys(domain->iop.root);
+
+	new->data[0] |= FIELD_PREP(DTE_MODE_MASK, domain->iop.mode);
+	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
+
+	if (domain->dirty_tracking)
+		new->data[0] |= DTE_FLAG_HAD;
+
+	if (dev_data->ats_enabled)
+		new->data[1] |= DTE_FLAG_IOTLB;
+
+	new->data[1] |= domid;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2061,36 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	amd_iommu_make_clear_dte(dev_data, &new);
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
-
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
-
-	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 
-	/*
-	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
-	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
-	 * do_iommu_domain_alloc().
-	 */
-	WARN_ON(amd_iommu_snp_en && (domid == 0));
-	new.data[0] |= DTE_FLAG_TV;
+	set_dte_v1(dev_data, domain, domid, &new);
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	if (dev_data->ppr)
 		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
-	if (domain->dirty_tracking)
-		new.data[0] |= DTE_FLAG_HAD;
-
-	if (dev_data->ats_enabled)
-		new.data[1] |= DTE_FLAG_IOTLB;
-
-	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	new.data[1] |= domid;
-
-	set_dte_gcr3_table(iommu, dev_data, &new);
-
 	amd_iommu_update_dte256(iommu, dev_data, &new);
 
 	/*
-- 
2.34.1

