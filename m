Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFD3A4537
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555716; cv=fail; b=Y6qIoInygiFy06yB2Nk+HEJm2qvHt/cqvGOPoe+sy31NIvHZGK0gCuDp7MSpHlbCOzM7DB4OUP5AY5BBh0awr7OHFhlU6eL2LLWo58ws6C9CtYxS5O11Q15eckGicBrc6hdQL97OYiC2XviRcOt92f3m0JjFcCBA6xu4uBqN8Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555716; c=relaxed/simple;
	bh=ZpoE5dIbh0HPxnqSCv5SqLetDK6/ERwAy2SHom/kXmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1Hyv6pwm0t/57hzFC67OIQ2e/ORjNie6dJbLyRVGqnKBsciKpMAhwkGp+UB/R/C7EIumY4vbYIUYcioBmDZ1Ip2yC0X8wC/3iYQmJf6sKzASmHunecuGukQ/xKWAHBwcQw1ky0U78hLsdxBHFhFBAJEzoRn6xG0ccLpmrFZyTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=As05Bqax; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="As05Bqax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi7Ivbo73Gx+2CLEadlpCUcoyCOJ11t/E512jnVT4iHohvOgfuhyRcjVRhAwcy459B76wciamTCXy8Q4lm0rvSKabnlCc8/TmPPUu2dojwEyIWvOgWp05PwDtqdGrCFfXLWONtVwfZb0UG/lAob/RrXeu0msqvnD7sRk934VhuLxnONxMyRGLajQCPLMu8wwTBfvNodswlmLa1E1A0U0wRILdIFG5Xq/SJqY5KnObDClYYyaWbIoihk8oLY+qhnazmayhCjGzW2WN4phx6J/RgznUu4PupSGzgk79VQv/sNelli5ZKxQl2UhY7nr5em5lv+Xn2RT0AqzUPjOHSRG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAjvZk7QDbJnwJ4RYtMHTg0m01+XH1IBHlzIubMc+h8=;
 b=xwd35azx9T3QR1dZqOoY4t51kZMhoMPVXyu5vJN2NHl+pN7RA+4JGEu6rw/LDyEDwP4SIy8FHFr7BSnxszDP1dDcTrdbEo53guQnqGUlNV2JyDnmJaGnh2q++Una+yxOUJl94Pn4bOKNAi/88ljXeGIAM6Dk3lemXr5ps1DJGAX3dMLiH9JaPCNjWEGv6qIKOBRLghnZzX3FIKJXRA+FuGDglFNJI/V42QS/oGTWheSkblv3GJeZvYRDJQXx62MJY8sjvUWP1dsZ5cSFqFa0WLeTENx7nrMJI0aRhOhECUiuDPgKo7o5ydgX7mtZ7Loe8BOXXUclQFwr9BPVjSxuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAjvZk7QDbJnwJ4RYtMHTg0m01+XH1IBHlzIubMc+h8=;
 b=As05Bqax8yH/dtslDntXbEzRCNxrJJckYHWryyaRNa4ukiR5Z1A2cGRm/7C67Fhi47U3Xs+a44Sc6CDRBtYOmYNoG5M1Ck2QQdpUWoy+6+2XpZExUS8NlEH3PB2PUpYvLjTcC50BnoUR7zoKN2FOchI2rHN/9cDaP+UOrU0ilCwb22aAqnURnvjNn/epKhnqX8A+OZXjkB8ifiaIWS6QM+Bcicei6jnICPrvBVoxBI4Dh3uR3Ddw+Gby/pT4hqghYG8IThhWwxgRhcdbGUO8IBKSRhPxh9lIzaOQskIiPHZqCL8hUwsuUDJYE9qTXSpebpA8L7DIPXuZvcu0vqob0w==
Received: from CY8P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::10)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sat, 18 Apr
 2026 23:41:47 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::24) by CY8P220CA0040.outlook.office365.com
 (2603:10b6:930:47::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 0/6] iommu: Fix pci_dev_reset_iommu_prepare/done()
Date: Sat, 18 Apr 2026 16:41:31 -0700
Message-ID: <cover.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec73deb-053e-45ab-1d24-08de9da40e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZZfK4rqDqU5UJq3VO7Dbqla6euDtn4n6T+f+75HK7b8C8imcKO5NpOysLvyI7p9OJ1PJeVGk0yuFfIRtPOPArZCWzLUGpv//e5qoWw4f3V6jfRgfuyRiSuUw88cXQZDIU40oRW4Ke8zeZ6yApzMSree6Vqc47GqyaD27rfCo5SrLbJJmR6T9i9GcaNggCM5AQtep5RfBidxdNwQVYqyg539/5BMgGNpx7pL43JQEmjlEvlu988f1g+s+kR8GKTSR1DJkWig+TgisFEaoVmS1P2B9EGQqqBZZGK21Z8GLhJZyRNlyI19bj4T+VT69DzBVVqRe+9FfxDRJfxDJs5IV3f/bCdvu4bC9X4R8dwx/xC2LzweoMiUeFecPfWaR42bgTJbmkZzlLQOLRVFYSYzaIPPn8oojXEEnu+zSd+Ue/Uvi8BcgTMPg3bp4a58La1yPZ002aVBaFWidAOV3T98PLaJO7em0DYEY6IHnTsIr2hVeN9QIEfjJabjoVhIL1u6s/6Xc04RVI2glqvaRdXdO23D/LJW9ewRoGdSA+w7pypykFp6T6hm9BRhTf5niCx/JOkiPBhUj61Kj6V7NBcb7L2fnXgkKERTt+n3Lbfz0VDhozPc+0N1GXLaelgikERCU4aCL5uZ776J8ip/JIc1iMUf6s1SgB+8avG49WyxiEHapa5LLw1YYu2/K+XSnFez2D+JbrQXnyJpNNLlrkCQp2U15Uwkzecetq3pfIaof9iDaCc7ssrNQm4f+SMFZ41MMPiMlWSY1q5+NT2smQFSa8w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(13003099007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bT/NhQ/YmbrEwHGybANPQVBDrWhngedaJfV5akue6kVSNgAQ27GdpdFnjpGNGQgi4r3OvI/zoC1DJ+jNsHEsB/3Lh+UbgYTAGBoVTZI5Lun84dtQJmDFPXs04GTQzFkRzH4blmDDDf/FdSwiXOFezad1xMHUil7r695eXgNuSizncJ3PWDaozGfIgt4+6msdRoGoCXKkZB8Y+uiBzX5s3m3pbZgZIPy3coKaBFn32Ypu9AhArdUDbegkcakJXuV6LYH1F+vm91HnhDdKiEYwB+WxOUP18XoIcgOLwiu0f5ZN+BzubmL+O8me8nXzmt/jm5Yj8c5xEZRS5qZpTYOJoqhhewkhfMrRLSmJEiJ92q+XRmm3zWiCvHBZK55OH4xKG/LjIQXzryORhvzWPG5a1MG3XjeoNweMoQUiLkd1yTtW87b/3Bcy7Q6xo57C816p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:46.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec73deb-053e-45ab-1d24-08de9da40e2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

Shuai and Kevin found a few bugs in the pci_dev_reset_iommu_prepare/done()
helpers when used to handle some corner cases:
 - Nested callbacks
 - Multi-device groups
 - UAF due to concurrent detach

This needs some substantial rework by tracking device reset states on a per
gdev basis. This series includes a few patches addressing them. Most of the
patches are reviewed previously in a single patch v6. As we found more bugs
during the reviews, I split that v6 to smaller patches so each of them will
be cleaner. IOW, the git-diff from PATCH 1-4 is identical to v6.

This is on Github:
https://github.com/nicolinc/iommufd/commits/fix_iommu_reset-v7

Changelog
 v7:
  * Add Reviewed-by tags
  * Split v6 into smaller patches
  * Add one patch to fix UAF during detach()
  * Add one patch to fix unnecessary ATS invalidation
 v6:
  https://lore.kernel.org/all/20260407194644.171304-1-nicolinc@nvidia.com/
  * Update inline comments and commit message
  * Add "max_pasids > 0" condition in both helpers
 v5:
  https://lore.kernel.org/all/20260404050243.141366-1-nicolinc@nvidia.com/
  * Add 'blocked' to fix iommu_driver_get_domain_for_dev() return.
 v4:
  https://lore.kernel.org/all/20260324014056.36103-1-nicolinc@nvidia.com/
  * Rename 'reset_cnt' to 'recovery_cnt'
 v3:
  https://lore.kernel.org/all/20260321223930.10836-1-nicolinc@nvidia.com/
  * Turn prepare()/done() to be per-gdev
  * Use reset_depth to track nested re-entries
  * Replace group->resetting_domain with a reset_cnt
 v2:
  https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
  * Fix in the helpers by allowing re-entry
 v1:
  https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/

Nicolin Chen (6):
  iommu: Fix kdocs of pci_dev_reset_iommu_done()
  iommu: Replace per-group resetting_domain with per-gdev blocked flag
  iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
  iommu: Fix nested pci_dev_reset_iommu_prepare/done()
  iommu: Fix ATS invalidation timeouts during
    __iommu_remove_group_pasid()
  iommu: Fix UAF in pci_dev_reset_iommu_done() due to concurrent detach

 drivers/iommu/iommu.c | 163 ++++++++++++++++++++++++++++++++----------
 1 file changed, 124 insertions(+), 39 deletions(-)

-- 
2.43.0

