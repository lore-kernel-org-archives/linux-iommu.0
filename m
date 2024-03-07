Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30331320E
	for <iommu@lists.linux.dev>; Thu,  7 Mar 2024 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789287; cv=fail; b=Vkc78s1utmQyN78v+iW85RQfRYO0uLDJv59g0jQ/L/9X21YnNWEqkRQYY2zK1peksmPlUTLKr4I7A5wUYgZ3X+cr+2pz6z1PfLLUSJNfogb/3UwYLYKT1w5yPMzh6H2DCCgcFuRW2ZVkqMpgmoWtAkCR6Y+Hl0VrubpeH1I+1tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789287; c=relaxed/simple;
	bh=U/V0UrGrgIfelqahF0HgC/0m1D5M/7ihyjzreBaoGgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=membrIq/2wgrzvuBxRlHWk8Pfg2ogwxVEL3x5TJ1Keb7JCBjoS66kSsUqzBLj8SpbXNwgq8nBWoDhyvMrr59b1SWgkNX5v+Io7Dnav9jimlRBHMqYVB9CLGuqdxPKDukCeGBpYLTwEIfLqBhcxEXeGr8yjqbyrO7Gw1faOxnOBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U04UEQ8C; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U04UEQ8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuKlFiZhEqwJqYavrYHv7DgAAWZDLaVl9KMwUuFfGuY0yfhBI3PrLMWzfGDWdTakj7MW/JrqyXGXJfH/shWam1zQ5fnG3Sj+NTTYGVlHRVmWtYJYImWhhHdSGWwnFfKcwOF2jk8xQls+RNESKLGjC8w4UzBJCqP+JfsfzslutOiWds/RoR+iuenihPre02KwmnWISdDHeLBuyGdyJej2Zrls9CQnmBr1D6/zysg0wcLiknHRq1SB7ITpAxAqH5iGCD/IqplM/5sOQhZKPTiThjAYUZ/hJtjO08GNtQ4k5KCi9Z8wDbzq95fFMPVRZMFMYkbZ5vkBd5NME3ueYi2rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk0JvjMSOs34kPdH9ZQa5WvjnVm91Vb7SKfldgx/Puw=;
 b=LbexekY88tnhUikuvdchhW3cMLMe1L5nn6kJqW80tkRbFwKFToaJEJ7l9K9TnKRN5wm+EqdbRCsiz3QSxrNnvslEALMhineXAXI5qQgCFd7i4MtwGpjFlwV3xCfg2qLkRtwLKpCdKQ3UO7Q/l6nI2f53eiL6JeFB68EVrVCjgvhDKlnSP052tm6mcRuFgVT6rKoEmTqe6tkVO4lRNyY8FirYND5O3XMtOyZivV9JOxhCAfuDz6/i+TEAwuiPs6DG90aJb0Tut+5T+Xfczov2D4g/Ah1DaacWQC3c9s/tHqqgU63Q+iN7icW85htDsvpYJutURh6eEts+15ZIA9rpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk0JvjMSOs34kPdH9ZQa5WvjnVm91Vb7SKfldgx/Puw=;
 b=U04UEQ8CYfrh9cZLKUbDMyB5N0V2hrrxePJdvuLrQ8uD0EMMzMOPSoyGblRQWYRAyHXuusPu1H1oHClNifPuzMpYZAwSmSG8kNc/cVj14qbuRt/aLTLPBqhnWaGjV1t2R7oeqdoPBVElI3WgqXR6FcN5sZC63ETomN0vJkKF8yU=
Received: from BY5PR17CA0022.namprd17.prod.outlook.com (2603:10b6:a03:1b8::35)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 05:28:02 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::7) by BY5PR17CA0022.outlook.office365.com
 (2603:10b6:a03:1b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 05:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:28:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:27:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
Subject: [PATCH] iommu/amd: Fix sleeping in atomic context
Date: Thu, 7 Mar 2024 05:27:38 +0000
Message-ID: <20240307052738.116035-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3b34b1-bade-4361-83ca-08dc3e675b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rhSeDCfW59mJn8A8HhLXgRYBCkaHcSqwkluvGDaPBeye0kPwYBa0HGkVOYSBmitht0Tw2+SNKd8VTYw3EODTz4sO6iO1C8xK6vo50eJlhDaDX2GEe+ZAW3cZkQ1iZI0ZYSGKTjVMNuCVX740yaa3K0akzfQDroYXzBq2JZLuCg2Rwdzj984f3JcYv7sSkBW2+zuGzStcBZX3Qdh956/KU1Y/6UUmcOR5zXNBogZWCoefqnPFomuRqwMd5+kqBQdWAwR5q980LDxGtgqlPhRlTzn7ND9LTFTZoiB0Gve4mRgwZrMrbMFeJk6w6/4NUB+QggUw1Q+SmtFqsxM8z4BXLjkVHcXuBOOHjX7j6XI7xQ4x3pjnbQSVDQ0wfRihFszbY5eyxWWKvgMx30R1lUrPEr7AA5o2tNsoVCj+Pb4fbUZRFUimb4aRbu48TExBqsvzrdMDYyEzLf2W8sTRF8P+ulIg942VbyVvLuGrFhMuoUuDgmjt9PiLgizhNZY4G/7b/C90fmVREP4gLIBMw6FjXLmbe32cpQW4LtbGYHBvbzMstl3C7zxm/neqP70ZeHBE7eb0oU7IGltMqlaDr0zUg28GahGHsUWDt19kLMnLD7TmY9Dl9fx4csN9iZ5lMdYd+pmBdpkxKIhFTl9JmsHMdDcIes0Ifa4TqekgnJsdN7qV9erCDS6cbFCVxYiPtR1SPQcFtBbSG9ykx2rHGKd/kn2ggJIUggfJxEKpIJ3jdl6PDLLrd2NrDQRcMT3S9goq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:28:01.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3b34b1-bade-4361-83ca-08dc3e675b97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Commit cf70873e3d01 ("iommu/amd: Refactor GCR3 table helper functions")
changed GFP flag we use for GCR3 table. Original plan was to move GCR3
table allocation outside spinlock. But this requires complete rework of
attach device path. Hence we didn't do it as part of SVA series. For now
revert the GFP flag to ATOMIC (same as original code).

Fixes: cf70873e3d01 ("iommu/amd: Refactor GCR3 table helper functions")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f688443c2764..d35c1b8c8e65 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1793,7 +1793,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	/* Allocate per device domain ID */
 	gcr3_info->domid = domain_id_alloc();
 
-	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_ATOMIC);
 	if (gcr3_info->gcr3_tbl == NULL) {
 		domain_id_free(gcr3_info->domid);
 		return -ENOMEM;
-- 
2.31.1

