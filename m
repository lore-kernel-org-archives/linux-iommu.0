Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94D34CF9
	for <iommu@lists.linux.dev>; Fri,  1 Aug 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017334; cv=fail; b=LtuWlry7UWFndSA/u93NqQOlrG7tsDp+pjda8LwUTbmjSJD3ovQi/RTS+Q/BP8tjZ8bol2PJngVqB9WG6AzkLYeXR6KhzXX3IwRg+PR8QWXOYvTC6MBKpQhqXXEufNQ03UlDABJjRRP/yaYnONC8Abt0AMa+IFxVghl4YFGnVNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017334; c=relaxed/simple;
	bh=PC8HjY1a5zZdMNdEjldpnXsOTU9EXY2kXus+gwEFR1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R69r9/Fj4hWuFCABYd7VXOJ/PKSvClcBggzOZgRgVUSMmiR8l5LXWzjhmIXf3ZPT5CjEGtSYXQHOJONE8ClGEXjHvIwErjmDtPp1y30C3OG+Mq4zUVBJyMfihKCyIzHfvQktpkeDfp0H6SXI3AmfbKwksH8/DdlXZzQ/ko0ROaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPJNtJ3M; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPJNtJ3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwvmZVdlwQLqPka+6WZl7o1Y70O8q1uiioByzLBwxEXt+FZxUO4Gs15JavgwFtUOMKRmS/LdVeg9ytkpyGVmAf/msSsC+WMKSQJosF7hunH9rOCryYJLyf4qjymndLEpZxr9RWyNVK9ZiP9ewNMF3255WiDidWp+y7NjR6Z+CKbpSYzbJYZiIzS6zWuCBpTAE8Ig4W8GziYcFwKgyJO1Hf4orc+uq/MfXyyZtHaVzq41J+CGAL1I1lmtPff1uw4qA26YdPkyamUBNB4O9DT+1ykLgvRFplUhT0o5G2Ah/onC27/iTU2AIRg01bYsVqJUn8qgHwZbMOURqOQL7cPG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FapCBIQYzG9axYsvv2Pqe84YePrzfuqOq7VOhdP2yls=;
 b=YxpCWv36mmL2ckIJO4eSUKEhHyI4KBD4ZyTJxU/CtromgJKqKqnlICTv/xfarrxzT4tga7QOliIBS2L4XlBDoU6BMq7V0zqsfZ5BlvDphpll88HBFpJm8nE5+hmSFs3S/HRswO+XpOLZF2er4sqdnYrmS/LvqdCIJFPj5e15CshABkCs4fBmf7hEi/FC4/jKLS97krD0qZBDEpbvtdmjyzitZutquv2WTR9NXuazHmfSavOoSqJ08KO+RgPihkTXFeqcMjeOgw+KIkQKa4cIja0mD/qj+Q7XJAqLP69j8wzpgBLObQNZDMN0Q1Rk5wceN/dQe7l0gzZJdkTWAPK6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FapCBIQYzG9axYsvv2Pqe84YePrzfuqOq7VOhdP2yls=;
 b=EPJNtJ3MdD6VrNQs9EQJKQxP7gO9wyovniIv74S5BmdAuOizr3Ss8wUCJlrLD5dsAnZFMOugs9kg8/HYHYsMs/3uJWWusRJt8KeOaHwumBnU83JHpXqGyAYFGjwOdXGMJwrQ5uM3AbYG9DsNwhOxYfq4tOdiC9mCgvDYp42u/1rVhEOl8bfrRMFAR3gw987sFxz+WBYtSUlJXEaRv86y7BaXK7YOrXWhCnzfQKOHH9rrUFWAlJgio+vbYJrF1RZUy53fgrbusIhueORTTRv7zwj+xXBLlU03ALjJy/B1KLRnRqjpgTOQv4MP6bGQhyqfEc82ZGCcV+Oxf4eBdx2Zeg==
Received: from BN0PR04CA0156.namprd04.prod.outlook.com (2603:10b6:408:eb::11)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 03:02:09 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::18) by BN0PR04CA0156.outlook.office365.com
 (2603:10b6:408:eb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Fri,
 1 Aug 2025 03:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 03:02:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 20:01:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 20:01:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 31 Jul 2025 20:01:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters decrement
Date: Thu, 31 Jul 2025 20:01:27 -0700
Message-ID: <20250801030127.2006979-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 66158c11-6aae-4f0f-3c58-08ddd0a7ce42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnLPXS9ZmBAgSlBn4pwAgbcnEma9FWXsNEjsWe0W6P9urcaeD2iY2hkK1Dev?=
 =?us-ascii?Q?PuX7yrjAzt/cfFuLGOYTENw87vMpesxv2uMxgKkNm2EB0hi+22YsshNKU7GM?=
 =?us-ascii?Q?HZ0F5VKy5QCw6dVns/J3/b6W86xf14yi72O/IJi/l5+FNQd4LH6Fs6YzD/dK?=
 =?us-ascii?Q?xJQjpM8f6RUg2vpGoZi0YVvJGyHYBB/9GM6U45J6Hb35XDOilNNawKHgw/H8?=
 =?us-ascii?Q?kokmdhTBeQ0OIkh8r8JGfq/nHTJ2QZhY6xjptJadcAzuU74+CEKbFPfVdhD9?=
 =?us-ascii?Q?rXY3XPdfqLCPxv2kTD9vPQFYrUpjEdfRMBlJce6qts7GFbsGsGucqN0uzRyq?=
 =?us-ascii?Q?rHc+0Qtw+IUOwDNboZl9vcaGrVAUdJxw7U/H9TZY5f7rxA4hvWcQmZIoVVDd?=
 =?us-ascii?Q?hd6FpPGzHEfVSt2sg/ZwPGFsbZ52x2SIcML8gotHDo44DwA+8NwurLDGSyCj?=
 =?us-ascii?Q?Z1w9aZCph+o0CDhlUY1pBSGjx89JIN8lR15ZJqPHbjeOX8LsS4Et+fIeOxNE?=
 =?us-ascii?Q?N3bwAqA76X8Jy8g9X48E8oYrDKT6SUopdbDQ6NqRkcfexYNCemvnIUna+aOh?=
 =?us-ascii?Q?OJUozg1w7ReyrQl2xgKgjzbngsTGdu5iZoQ36q4EgyNh/gDn0wVJ+3MYk6hU?=
 =?us-ascii?Q?b9i81D/cUOmbGXZqx+6gHJAJgf2IqblOEvk7awNKcYGd2b4v47YhWUTi0qGX?=
 =?us-ascii?Q?WQtQk9E/9KGC+1pK3kceCcoGjOOLEZqmJ/ATpLHGq+zGQ89z1jh7q+JakOdx?=
 =?us-ascii?Q?SbKH0dkVo+sAD11bl8M+QST2c/6huynEr5cXEPo90Yew7bVO2S5/L6XYyf6V?=
 =?us-ascii?Q?MHsLIgqBSUoDlHEIVi0LjO0QBP0f1oron53KL7TtGT32MVPYFVYlZVxFo88f?=
 =?us-ascii?Q?IwHIW1Ypp1b9x/5r5K6wxznjKXx3oEB4HTf2WXX/KGNF94qmRJUoQOlxXTGX?=
 =?us-ascii?Q?zXIIIduHTIVjZaqDVG1TBd81/82698P+TbG5In0VS0ASiWgd96tp31Ijh2Dg?=
 =?us-ascii?Q?6cnA7u+RAmP2U2HPJT63RSOQqxY1G8rdkrksNZuecCjzZS9NnnqenAY7KcsX?=
 =?us-ascii?Q?LEUpLpdMJFXYe/zsDgARFsSRQa3tMhel30bnJza7SiVkahrK3OeCV9kLMsic?=
 =?us-ascii?Q?3YcGOc6wNdQhCnOPwmtecLhSJhGgBE4+8TRAJh4Y0vOVHK586zgMXHnGqvEr?=
 =?us-ascii?Q?JIeDgE7Psg9gYpa1B9aIIKKcUH4MRHi8k+ffyScSNb06fHJ5WpEm7Zqvwlap?=
 =?us-ascii?Q?yn7W/tm+LaT4V/doECl/mObZCqUg0ovUwctF8RVyGbE3gzxnjhrx8bTHmCTK?=
 =?us-ascii?Q?3hGeyTjQm+CCiQLF8mOU11ZI96tHf7nqhWkdX50NsPFu+KYqatmvqy69m9s/?=
 =?us-ascii?Q?AughXnLgCkSm8o3lWDbb0Nj1gXEC4kHjfrhZ+RIVt/fcTu+JPrVq399VW50R?=
 =?us-ascii?Q?38RYx/4DRJEtu7svFz7JFOWWSZRuXtirRN90eLcRBLnjXMCmgHwtyZH3G78w?=
 =?us-ascii?Q?tVkQs69mmNoxIxTbiV5LBATHRA14xCgE3FJp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 03:02:09.2856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66158c11-6aae-4f0f-3c58-08ddd0a7ce42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

The arm_smmu_attach_commit() updates master->ats_enabled before calling
arm_smmu_remove_master_domain() that is supposed to clean up everything
in the old domain, including the old domain's nr_ats_masters. So, it is
supposed to use the old ats_enabled state of the device, not an updated
state.

This isn't a problem if switching between two domains where:
 - old ats_enabled = false; new ats_enabled = false
 - old ats_enabled = true;  new ats_enabled = true
but can fail cases where:
 - old ats_enabled = false; new ats_enabled = true
   (old domain should keep the counter but incorrectly decreased it)
 - old ats_enabled = true;  new ats_enabled = false
   (old domain needed to decrease the counter but incorrectly missed it)

Update master->ats_enabled after arm_smmu_remove_master_domain() to fix
this.

Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 312bc31d7e8eb..3c81139faecae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2997,9 +2997,9 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 		/* ATS is being switched off, invalidate the entire ATC */
 		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	}
-	master->ats_enabled = state->ats_enabled;
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	master->ats_enabled = state->ats_enabled;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
-- 
2.43.0

