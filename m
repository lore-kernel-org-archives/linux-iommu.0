Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48813D53D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843539; cv=fail; b=bNoGDHMoLKKgDggVI9siDjQvrzap96qrx3FTQ4HhqpnzJgdEibJRPGEG3SQvPa2CWDcKkphmaT00cCDkWD+lJQX/EASS436/vleFk1iEJHq38ErQjLjsxar4lwEfCOWO6/IE4O028VnZB4Exj8fj6U61QHU/YIAIkt3gnEKyIbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843539; c=relaxed/simple;
	bh=zke7UqSBFsvQEsbp5487XhNSZ1NbVTzC4tS2h+EEBJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuefGBdQg4R/YDPtckzZGPz/+l9eTdp1SD8u4E6mz1YukavZNVq8mEd3csJDnoBCrBNjiDOBG7fIYeJE5faxFX/9dFVLWV8A09bbhT7fj65YbOTLoTHUC+aSuuT9LrRQH6T/clPw7FLKonnObAg1uTCDk6r+5CeAyGm2UbYTPgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LzH9q+7J; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LzH9q+7J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BifCwtzIYXAozofgbzM088ZVSVyXbcKdfy7L/DaeuhFD3kn+EpBnVp39DsMHKwF94Yj7ELsJzgrrnyPhQUF+dBgICN0pHh9J33+wBfQlfnx+1gAliWVW0Ovmw6xOikzRo3TleAUfsjJQQkMJ7JjpfO9WhV2nbXbx3N/fHFsFEYCMCZ90WN2brxUKOpNlKQAAdoRRh81gA1tuGe77/QIDwaXSopvZAFD6CCkxIPVkzLT4Pc0tOYgyhEsNCbee7+xSaSDsUdgyGZWx4PsoCVTERZOYbrziE2W0KvELt8foo1Dv7LGlkev8PVAofpOi6QslsnafmYPz93/uHQAenm1paA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Hi3OecsApW3MTRK8YSfWtmhzUWk9JaXSKkaHHxYGs=;
 b=syplxQPrtok+RWyAsYmOY/y4Yfj619cvAWlPj9j++CUXJUggX/4h1QKvo1aMJ4gGPiFEtqKq6rVikEaFbj5hpmKMK8yPU/EkWxMgXwmTJPrDCkeY+QDeTnREXyxSKQwhHy6sj9muZd7HIBleGdo0gPkSplZQTyeZxQ8sXMafBYLB2Vf0NDjHlWGTUcrhHaf17aGiyWHW62szv4RC1dpJn6ozq6dE4bh8j1N6SNULJ3cIp1ECXG8LbQA0DWQD56bvEppcqkmaupq6wp8dsf2tnTwaK/ti7sC1Tla2/NIQKd5A04C9uDOgk/S1Kzd+ggQWnZgXUYqCd8FMc87ODVCAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Hi3OecsApW3MTRK8YSfWtmhzUWk9JaXSKkaHHxYGs=;
 b=LzH9q+7Jmrdw0F71UD3t8M20t+s3Yda13zZmJCJKih9h+sILVj5iNSplVqPSQjLeE64+MbbjO8NVLoBVuNRMv8c8ihAMXsbm/+0YKvw67Y24tnw05JWN5xTanT8S7Gh2ONkQmylDdWmJL5+OOuJ68PiH74WpZsRebzxQHn6uKWk=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 11:12:15 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7c) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18 via Frontend
 Transport; Wed, 28 Aug 2024 11:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:12:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:12:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/8] iommu/amd: Make amd_iommu_dev_flush_pasid_all() static
Date: Wed, 28 Aug 2024 11:10:26 +0000
Message-ID: <20240828111029.5429-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fdcebc-748c-4be1-4d3d-08dcc752457c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJcY3hNvAE8Rj8Bd5tEH1FieY85PG8dGLr1tYD7cZnhn3b8BkqekhPQGt9p+?=
 =?us-ascii?Q?F5jFikNg8mOfX+HXDcJV/nSiDEtMGhWIfaGZT9kD7E94+PLqz9G5lnlfAkob?=
 =?us-ascii?Q?9P2k8jRbJKd3f6sqvt5RTgDo+IeNYxtLnt+4PpeWoT/YgH//WfDfVQ1lO35C?=
 =?us-ascii?Q?3VVwGArRNGzKRPW0dOgZ3hcb5A8HeVQ7RDJX/QkYlDelxj0Qc1+9zeTX/LUZ?=
 =?us-ascii?Q?t3TiDZYwLvteanbyfhfEd8vs01/hbjRtksrLVrcPoDKd/bFkDZHn+wssr14/?=
 =?us-ascii?Q?hhv8mfV3KPSxL38QZMU6l5q3vUHa8coo4CUpR0BFG+MMH+nWhZ8IMzC2q5mh?=
 =?us-ascii?Q?3usDXketwmLQfKZORcdHumHVFItMJrBQwhHSCUzh1i0vJJLxJR3xYA8ECBjc?=
 =?us-ascii?Q?aJWkUMn1CpD1ZHz33EmVurHv3qUTO7GPb25H4hTMSUwKOsgcIhQMzSUjBwE7?=
 =?us-ascii?Q?Y9ZddELgRNJCPUQSqcccDeDlpXSg4agZh5n+10svDck08vNQ74hecBykdyZb?=
 =?us-ascii?Q?RSk9pVMhkShJ0+IeGIxBsufHEZI5rIn9uc84bxExqJ7UefotpY86/sl7+6RD?=
 =?us-ascii?Q?3jwhM2jBbvspMLszRuZOCH/NNHarjE/TUL8PbcVRAGSzcRCPo/ulAMMAb7wa?=
 =?us-ascii?Q?BPhcTL3tA+nDCmVzDEwGFkrbI5oLnDyEZbHGxlumALpe5az2OK7NQYvG7EuH?=
 =?us-ascii?Q?QFekwShzjpmo2vfVh0MDegu2lhwFJlaNMllKnbYIuq5Wy+xmAOWSa1I1TBZa?=
 =?us-ascii?Q?HprvPJ+qOTolydTxS4xii9ffBNHXAr1BBBd6Zi9RX8jbvCPZ0ek5gVAr8cHV?=
 =?us-ascii?Q?rOwOzMEW6fSL5TzIjOgBCeo5b2LGV4y3uM2VR+5Y930yEOBTeLAv1E90uDGx?=
 =?us-ascii?Q?voZdXjVY/BsTRgsk1oqNH5AJ0237ArTXZGtHYPMfWlf0R74KRLo0mjvEO9RC?=
 =?us-ascii?Q?diYId6bbDjnh8MsMOWY5J4t+DaBF/wdW4Mx8z4bpNI4+nFs9kfZLY4fVPxB+?=
 =?us-ascii?Q?J9myQl+4tsPp/aV7q/+Y29OrCDGqiJfGIwweiVlEvO9sBXSnhNhgdD8NkjOO?=
 =?us-ascii?Q?Pi/XssJMMcuxXBB/BBYsKcXx+cn65IrSXprZjNRCPZjZtsAVcnmm4DDDD8DG?=
 =?us-ascii?Q?3Xozx/9V400soITwRihy03K4O+Uc/G2XLGg0rVJ4+h+/zpCzEpHncUln6TtU?=
 =?us-ascii?Q?5URgiUTms7wbizAZ28D4mDNx/samShkkJo55lk+E0mVGuED+keCBgcwcLJn7?=
 =?us-ascii?Q?hb5OhZ9CVGqfJP0wIZzRg4WckmwNAAfjHDcyiP8SBQhwv1d1vHEVXOFLiulD?=
 =?us-ascii?Q?YL2Ai2S9jLDMDEWixEKydTNf4AEl9VYFbFEMODt6We/xE+Ympv/bUdA0ivdl?=
 =?us-ascii?Q?39jZhE1sj9yUTACi4lC0EF0zD4teLR/7+7nFi65GnxO6JPy51KpktLy2cOKP?=
 =?us-ascii?Q?kkewpYBOIFDcGymV3MkzeDdIKIjhkfQW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:12:14.5381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fdcebc-748c-4be1-4d3d-08dcc752457c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

As its not used outside iommu.c. Also rename it as dev_flush_pasid_all().

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 --
 drivers/iommu/amd/iommu.c     | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a9e207ec2bbb..d0a24ec3ada2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -93,8 +93,6 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
-void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
-				   ioasid_t pasid);
 
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be31a263ac6f..c06189a811ea 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1551,8 +1551,8 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	iommu_completion_wait(iommu);
 }
 
-void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
-				   ioasid_t pasid)
+static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
+				ioasid_t pasid)
 {
 	amd_iommu_dev_flush_pasid_pages(dev_data, 0,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS, pasid);
@@ -1818,7 +1818,7 @@ static int update_gcr3(struct iommu_dev_data *dev_data,
 	else
 		*pte = 0;
 
-	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
+	dev_flush_pasid_all(dev_data, pasid);
 	return 0;
 }
 
-- 
2.31.1

