Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AA266EFA
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480956; cv=fail; b=gY2krCjl2ap9einJ4Mi2H3i64Zfaz/mrMDcMfNLOymceT24kcBwQUtxivlA83YX4TgMNQBGyL1PZD+CXd9ZWJtVCrHbopYNrSepBOSfaRrBhvCN7ymAiVADq0T3lJsHURTjtle5K68qjxpcQkdJsMkrE2aQ6QWZmXpmVmENjmko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480956; c=relaxed/simple;
	bh=iGKMV2zKZkIYsxrEjwoikni56YV58zRJ/xEO9vV3xpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVWkQ39Lzw+Tj0WTIZ4Vv/q7+7q/z6LLfyoYWYbNESsq3fn6bg18JGTK9W5DERw4uDk2NXay7WZl0mlLxYcfBCx56dL+7tDxXvakt0gUkJpC2yzwqWp9gSJ1n3nzC2ghtHzvRUJmQob3JUqlSPmv5v2aDv5rLO7kAfoWzT1Yuv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3x4ihVJM; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3x4ihVJM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgOc7+qfe7Vnk1aCU8hOw7eQB3qevTZFV6JvqeM/pEXpn3f+KY6/nqBkGCARn/NC+MQdmC4TTzExnmCbYI4GEI/fuSX1ga4k5P3aW53wj6a3yYqhBc85sgtnjAxz3SeVTI7cR24ybPRuhXjwd1loNOMMxmhUjooOMCRv87IX4nRkw6EW/CzjRiKqXMZ23J8DpFwil/r6v0kQVaaN/byJ21lqXdCQ3DWxYFpaSL0iuPaqbthbISr47U9nWs3ZF4md39puRlp/rqgn1YDHBfuXkMe0Nwau7KaxAVCAeMkNfmxVlqsp4b2464m+HDq171V3YRG9/NBG1z3SYAQBsxld1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeqehGucCV36aIeq5mzQzfFcZp1B0naDdWu+InDKEXM=;
 b=LE9bzC1hfzs+drukZg5SFyRLi5xLRaYDT78uiHQDa9+MTpLDd5BrSyYc/fZiXTysq/pUdWuKovu/Y6DRsztPai+K/XUJ4dW9mg3WkjktOTBbfLmrMM/N6xFgr/AP5My7OY8hymakOuxYWUGiONQEqG1YS/5/CPBSml7eDcEFUXYSH9jZHUcO3bu+ZXJzcSgR6L6UdZ8+q2zL+709rcxSKkLaG+pklG4mwNw83++m0o08LltvHHJBGJITK/mHp/TnGbgHe45d9WOoA5X7jnZNt/jUroRnfJlI82zqfN36QgF6Ss97h9XfFiZaIg6FNoCxUDtkTXbdvH9qkZvcNtVbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeqehGucCV36aIeq5mzQzfFcZp1B0naDdWu+InDKEXM=;
 b=3x4ihVJMyOmTcSh9NgDRufUJA39T8SPUrDDnN32EVK++iDKSi7LcrHyfAP9E9jowe+TKr3BfWj1JRLWqEDIgKW6tDvtkM+G6uyTh669FAQGCeVWF/+RbqgF//IHenVRRn9V9OHsNrV+rZbsCTI38p5PvTC2qlWwcGkflzFpN7T4=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:55:50 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::94) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:55:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:55:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 7/7] iommu/amd: Make protection_domain as static
Date: Tue, 25 Feb 2025 10:53:45 +0000
Message-ID: <20250225105345.52143-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fbe0e5-5d3e-4c8e-9e18-08dd558af783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQZwmKKvGvplFkj/b5a6o+V1C9GgXQ2qUi8fpAsw6ytmrq7XJnfAL/G2K3Vr?=
 =?us-ascii?Q?37dBoA7JiITatK/yQbPLVBe/bVHCIYbeQoNU1XgqsRCabSAReZ3ktZ8oMBr5?=
 =?us-ascii?Q?Bo8AGaF0hMVxXK7EYurF5egDpiyPfw12wwcKwQi58fyp0gyFm5c4N0x1Y4Sl?=
 =?us-ascii?Q?nQRNmnb+ayOvxTk7v0XxcLoYu+FJlXD13XKlfSy1V0DXm0cPUTS9OOS5Wy6r?=
 =?us-ascii?Q?EfPmT9RC5dPzNQMf6HCrYelVeWwBSe53erBoQJg8giusjMcz7qkhHqwu9p+1?=
 =?us-ascii?Q?HmE5spvOGedtqwda+lQgKM6lYf5fm0eTgy1LSn/AN9vc3EvklGgOzl2kQ1K6?=
 =?us-ascii?Q?nKeay/KDzpADLXIEcYSxAyUvRQVGFR43hTXt8xyxsow6rAMrHQfUfLS1KVsk?=
 =?us-ascii?Q?5/JrnxXEnGGquDIXkE9KKtrRIop1qjoYilRK5Mlo0U2yqeg9EBMyd7Irybnz?=
 =?us-ascii?Q?8ztqB5lvwN3mZAqDF82D1RrXJbVJFkppPnKA5uFIqZYfOVvnun7kEtXH+yIv?=
 =?us-ascii?Q?pYto1v1BOCDpvI5dXo3unfvM6T494LPzgHkHaIlx4L5CblafRm9I78DpfG5e?=
 =?us-ascii?Q?vyOWxYEJGeBt7JxeC+QfxD2NHSWs+3JogX7KuXysvHKSwN/0iN2sQiRcZxii?=
 =?us-ascii?Q?kZfIEi8Y1i67wsXzjO0EzMcF3OLDAYxA+Ub4iyu0KKQaybgjWjjcYLzH0828?=
 =?us-ascii?Q?dZwB62hEYY3rgIZYwtVwdLC/JeufHOYGAi721ULEndEp09t2Y7n2AzwSF0CZ?=
 =?us-ascii?Q?PnVFFO4sF1HtGp+SFpeiy1f0WHWLFy2wwAzqFTgT4lLygVOmoJwCy/INxrFK?=
 =?us-ascii?Q?8hS+2QwhJqL1w5DTGuIS63REBHfXGC8JeSi/f6u7kV412Ppau+WGa1mJnLiN?=
 =?us-ascii?Q?H9r5pA+pH3V6VSIjbsngf+LztRUp95q0FH6NXLpXorO4vCiaBvUCJ7RD2/uu?=
 =?us-ascii?Q?ZEtbWPa5h/dqQT78fFoBqM5ldvmt3OiVJaVjRyauxFrVa1xDX7fUbnrv5huS?=
 =?us-ascii?Q?a6FN+TI05P3HOgtuME6SfgGFTZ0EDakO3+i+lPUTIqiYqb6zB0dP0xm34O7P?=
 =?us-ascii?Q?pZwnORXL/VMs8xY5JulLNe1cDXfw++L05bERYr/w7nJZysATStPTHagKXsAT?=
 =?us-ascii?Q?LFuXLQoCOEIwGa9TZuldhRGvHlK3dlarBcqgrhUYHiE77/8DqWmhVxfaY2sr?=
 =?us-ascii?Q?JDee6GGeWYzpNqfTzhrJxYsOdMHG8Rmd+BIah8uOpgFrQ+0wshGhJY4f4Wne?=
 =?us-ascii?Q?PwpJwPTlI+XwsxjZoEpZQpG5rgimx11J4rSvfCWDsgexVYQ2RsVHsPuBjxh7?=
 =?us-ascii?Q?hgElDeeX7E98WI/Aj4ataYeRX/NX+brDLOMcbYJQ0K6xnKtlfFlylYBJC2gD?=
 =?us-ascii?Q?XNHrkz8kXmnlRrqsCFdKmqS2m1rqzMQPJDMp+UPq6xN9Wxgv5CzZqNvhfqX6?=
 =?us-ascii?Q?4aLHX7iMLaTQMXLyRzyBX9ODlow19Q0zF0W2wt4KaiJX7GmOHr1HylNoiRdQ?=
 =?us-ascii?Q?nLDSiDm6VG+/MMc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:55:50.1986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fbe0e5-5d3e-4c8e-9e18-08dd558af783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

And update amd_iommu_domain_alloc_sva() error path to call
amd_iommu_domain_free() directly.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 -
 drivers/iommu/amd/iommu.c     | 2 +-
 drivers/iommu/amd/pasid.c     | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e3bf27da1339..220c598b7e14 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -47,7 +47,6 @@ extern unsigned long amd_iommu_pgsize_bitmap;
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
-void protection_domain_free(struct protection_domain *domain);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 797c8612966a..f4c12dd10adf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2434,7 +2434,7 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-void protection_domain_free(struct protection_domain *domain)
+static void protection_domain_free(struct protection_domain *domain)
 {
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 11150cfd6718..77c8e9a91cbc 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -195,7 +195,7 @@ struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 
 	ret = mmu_notifier_register(&pdom->mn, mm);
 	if (ret) {
-		protection_domain_free(pdom);
+		amd_iommu_domain_free(&pdom->domain);
 		return ERR_PTR(ret);
 	}
 
-- 
2.31.1

