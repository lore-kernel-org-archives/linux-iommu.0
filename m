Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF825221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057056; cv=fail; b=t/jBUteV27RcWlxjXajigm9g/AXeLAMgs92kNRjgsgh6uRCJMW1D7XJv8moU7tTHOt2GI37s/psRDboUZz/2wX8cIerUwYQPzKvCb7x0Pxx+hlzTbwwCq72RE7487pU8PvgYrBIhnNUwSH8zrh0Mj7WwZTdNyOm7lMi92h9qirg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057056; c=relaxed/simple;
	bh=oINQ51Y6jQA7zrqzzFoC3qJ+NWyGfh3bw5R6PXlym0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wudmkb8c2WTrQ9AX/zYoxVuy/JpopT1EIkao0tLwf/zOVQcsiMUszmyZm72jhi83+4s24LA9ottZcej6L0+F0WUXibECyTmdtZqd+WqxKhIxZ4q/tDjxAb6KTdw/mZjtUePmlIiKck2k6mMerDnpGlfeyplduWmwp+8c5cCOM6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HVi3jtRQ; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HVi3jtRQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdYyMG+Ylz3fr18gVRuEDjyKjCEXVdnfCKpPz7Tc7jNjgswg1Bxl16YVX3nyFPopgM79uKG+8mTfGz2Rc7/MrMD8xeCl0n6MpXFZyaJ15DHLGdmUnVagdud7zEMTOU711nVVXI3k5/jIBqfX85v8WL0wusC1lnnwK86QHiqcqBI1qoXgQgD6Y6YjLn8+s/XtZlqJitJ+yc7F6mkjj/L1O1l7seFD30d1aO3pvnHmrr0O5LkfkIiKBvGAXJ9py6DaMf6kN0+BkRbrAaK1QKlSbbPQVpJjPM88ovAXi3rrqXYicv/lmTUScXX2PzeMaiUGiRFMlA7DAr3OZ3EWvgQ2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS5s4iWJYDmww2XTKp/6sSYi9AAQGx/t2vTsQApGYn8=;
 b=F6sZwhdltw8QGNhaszgW2885h9CbRCyVNLeYLB4WWhYHrIQ8TtUT5e4Wdt0ZewoTJWj2/Yia8m41IdYjYgz09szGBFPkDWgMlk+xDFSx/ETxydUAwxlZtoND4vllD2/2b5lepe7PwJ50xXJ53cHs4/lHNhg4NzY25Hn2uU6VrDLxPsOGUXkGAYEI/IXe2QDhUGm6vPAMc+xfxCB9Bmks0nLHEidK2MyPkwJDQrulbkKyH6f7gAy3fXhE6KY0roggt8cSP8qOgvitU+7COdE/JsxDelIGxJYneI4vUlNkOZtzJRbzu7FX9NzFxM1udVr0UPT8qKtOrF+IOFvSXLRbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS5s4iWJYDmww2XTKp/6sSYi9AAQGx/t2vTsQApGYn8=;
 b=HVi3jtRQzLmVdGxBAG2a1G5/rPV2tSiuoncHwlM8rDe/+iwijVOR6DvbscEWOS+H+XEaXpDNEpj4waMtfiVTin+QKDyNkosvXC5QWoyFM6NyP3CCG/VarIl+WrmUwZskDC179XxICv/klwl6+oWTOKlX1wm/c0CUh9uAh9gkzqE=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:37:31 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com (2603:10b6:408:ee::4)
 by BN0PR04CA0026.outlook.office365.com (2603:10b6:408:ee::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:37:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:37:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 05/10] iommu/amd: Do not detach devices in domain free path
Date: Wed, 16 Oct 2024 05:34:56 +0000
Message-ID: <20241016053501.97497-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e9b902-5144-4bae-3463-08dceda4a126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKYGEXZAl1X2MYTIwDxBKD0Man2rNWsYYzBGyNuEvcTxJZ+4fAj3jhQA3qXT?=
 =?us-ascii?Q?QuuPd6vqTFM1QSXra5F+rBz1HHjLG8vPmyk3rLJX6+XMvZQxhcV0EVIWjYSK?=
 =?us-ascii?Q?6lCYFkN/HCrL4cFBIUo7BjCW17fsB/Cagzcz+u/RJSttTARHfyQuQCV9scXQ?=
 =?us-ascii?Q?SAJRLxDsxfz+YkzyJA0HPl4Rlxeg7+AcEyDbYjbx6adAEUMPf+5ZPR8t6/NS?=
 =?us-ascii?Q?Ksr+3+0/M8eFY5MBSE73nmuRAIkZ/GQr6FwfPZglrvjfwtAtLaBzLRO9hgHM?=
 =?us-ascii?Q?YKXwaNEQKM6QHewrRX8yydNV8SjgHkaPnd7hFcq9o6eBOCzm6+VWVWseZlMy?=
 =?us-ascii?Q?mFycK0ftcdUg6vAxOdF1sYK6L2HM4e+/fMYwbWv/Hncah+FVpR5TW6u4eiXW?=
 =?us-ascii?Q?qclV6/eQ++i55G8zfoXQy9qPn6bNWtoPoaB3NGu2vr3GXiygt7t6wIvkHZTS?=
 =?us-ascii?Q?hjmL7hXjZ3hkNPp2yNXXUyqdY5RYAcThZaFfb3UC9/W/RQdEIu9Lui20ysSh?=
 =?us-ascii?Q?IgObH3bCQML7wTpF8IMqiyy51drTVfEt+Xcd+SY7hg14k6OyGh80L/0p10W3?=
 =?us-ascii?Q?a+SDEGRqV/qROKMrurhUlh7NCncut9y04nUWfPMo0fgFFE2nhy3bKCU/yhAo?=
 =?us-ascii?Q?f0elqhNXtJ4hW5w5SQCtdq0hWJWQfFlupPjL2nVY9mFYNfIISkIZvmRGOJsz?=
 =?us-ascii?Q?vDHd6I2sMbM8NPemgC3AA0L3M9QtpQQLR31m7mEUWJmSbvn0ZFhdoPQMbnb1?=
 =?us-ascii?Q?9LzUjtL1tbM2ehsRZSeZ5qyy39Lt5lDKqjK3aHv8TR233SfFg21mDaBrfBq0?=
 =?us-ascii?Q?F1hVOJwMJtzdbdU2xyFCSAG4FVfMD90zRLaqbhOf0cVeuNLlGNC5raYb20yc?=
 =?us-ascii?Q?qXuWRoYI9hmWpUuFi63G18IOxQobDztKh9611tSIsK9p75okgsXDFmcQ96r2?=
 =?us-ascii?Q?U/V021/7p1KRMUieWbmuYSsGqUxMjEZUPg/eRwWZk/HEmIb21ULGp59xeRit?=
 =?us-ascii?Q?NEKS94cIyr/TQRfp4i8if/emTqWBEPmPyefq95jl4zaCQ8gbwHjqrl7Sa8bj?=
 =?us-ascii?Q?Ad7gHzQDY5JT8dUnCcqtae2ErUzHn7bfsOT//peSIvI84bMUWSRljmM31R1Z?=
 =?us-ascii?Q?j2WSN9qkiMZAiSWEk7tV5CM6PwQiciYweAoOfovv8rwhMOz8e921oZGsZKeQ?=
 =?us-ascii?Q?tco/7MFcABnSNjpqs4cKb4VpaZclt3ScVzbjF0m5J3iFDWkyCagQiZkhrzOi?=
 =?us-ascii?Q?upFJsT+TD8HkbZMkg928yohfdHIpWKoc7Ft+xxN48CKpQj3BGcw4bomHdGou?=
 =?us-ascii?Q?lLXoW2gM3W+1AyLG+Ge7lyLHkmWL8R0Ceow13Ktd37fEk6oAQ9XOBZbA+PhF?=
 =?us-ascii?Q?NsXpsOkoRCSAzQ42gb4ki+3kbtTX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:37:31.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e9b902-5144-4bae-3463-08dceda4a126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026

All devices attached to a protection domain must be freed before
calling domain free. Hence do not try to free devices in domain
free path. Continue to throw warning if pdom->dev_list is not empty
so that any potential issues can be fixed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 76af6304cc1b..d74d3b65c939 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2275,21 +2275,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-static void cleanup_domain(struct protection_domain *domain)
-{
-	struct iommu_dev_data *entry;
-
-	lockdep_assert_held(&domain->lock);
-
-	while (!list_empty(&domain->dev_list)) {
-		entry = list_first_entry(&domain->dev_list,
-					 struct iommu_dev_data, list);
-		BUG_ON(!entry->domain);
-		do_detach(entry);
-	}
-	WARN_ON(!list_empty(&domain->dev_list));
-}
-
 void protection_domain_free(struct protection_domain *domain)
 {
 	WARN_ON(!list_empty(&domain->dev_list));
@@ -2445,16 +2430,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
 {
-	struct protection_domain *domain;
-	unsigned long flags;
-
-	domain = to_pdomain(dom);
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	cleanup_domain(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	struct protection_domain *domain = to_pdomain(dom);
 
 	protection_domain_free(domain);
 }
-- 
2.31.1

