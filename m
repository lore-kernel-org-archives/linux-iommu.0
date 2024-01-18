Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6FB669
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563408; cv=fail; b=YBXeU5PYtchR389Funl80GlAQaVh1eNJzc/HAUkgw1AaZLUxAWZzenpil0OyK17Mgr3w9/L/dVdh87JEMN5QKTRYaT+B0XyfeR4ulcrQs0FB2LMGLlahlk4buwPoW98HoEhk5f1cZBjoby3G0SzRQkAMOd2edC1UWUDkWfw30zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563408; c=relaxed/simple;
	bh=02M6eq8IH5hpA1pGRXoorGjIF8IhG5V0Al8QTcMEfj4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=QKVLRywvDXYdN7Fv6wvofT8l5CX4uqJadTC+mJdwMpz/oYlXxlgmu53zO8cma1Wi1HWlShb0LW9O3AX9eST7bJUxFbsdT6nipJ9cJeJ3bSgs+ZF+5DjUQyORH4hcyXfxgNpd6QGYr7hZafdSOKLNRu3I8Xt8zPIsxIDTAn3l6NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oC8CuVDl; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oC8CuVDl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+gDcYm0Ru20azSRRJttG1de4Dkk4qnGRhlyrVJGxq6JXNrUMQXsZujcvvRElAxpGY1GC76xY7FCxTOa5N/PqTDMjQiURHK2WpulwgN0cZKkU04RmfeWq3lfXuXLFAH7gsmJL59Ksf1lGuA6bir5jXqdliV6yYfys9Abzzxn+mew1aH+F0IN6erAkPT5RFzfT2RAQE2pDAXFIYdoFartUoPgFisNqGAAqRVVQFufQi0D5JA7sAdoCkCl9gyvytgfqTqYWtW4SlWUKggF9GZGGsY9Xqc5CA1JgTp3PGrjJgHfpcLQBFhcOgv6aD5bRFkKSqUsnCkggKB+yMH3jFFcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzaDGEwcVmp+uNIB7N3OL9SDJ3hOPqJXDJmtvitFZSs=;
 b=JsBYtBiQfn0WRQkZd8kcFy1ID2MAAgO1HZNHxcFBwIaa8O1sWxaSnKSukfnGlUJvP9LbxdJN8wCTqHmuBc1eMxG1K9KXdb5VNlrxe7ec51lEjf6Qu9uYwWJTAl7OIP6w/OEHyDzGkwA6/eCpm6zHJwacC4saE2GTa1EwEemgS/W1ETQ2aq4RCkId/5bb2s0litRD4u+kIh2/txbUCA8dRScYOB18y3O8uWnQlVe1ZiNrCGTnbLGWVOwCo3WHRMwPnGoIYh/w2rf494Fpfe10iTyYUol2dn7+QqcBGMPpQPl6Qhj4PA3Oigkb4dFBdsZsYuc8C4AspEj/CtOI1ruEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzaDGEwcVmp+uNIB7N3OL9SDJ3hOPqJXDJmtvitFZSs=;
 b=oC8CuVDlQXAcwXSAbu17djd9l/tMF4hZMhgQ+lrKWkY8Igs4MjY4621mrXMlzTitLIZokWUGz2qprt1gAK77tvPZjhDVeLNbSOXtb9PQfPivEJM2S0us0d4RQmUecGUvzgiMX4Aihzh2hbf1Gszx8YEtWnufFbpkG3DzSEhn5AI=
Received: from SA0PR11CA0035.namprd11.prod.outlook.com (2603:10b6:806:d0::10)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 07:36:44 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::5b) by SA0PR11CA0035.outlook.office365.com
 (2603:10b6:806:d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Thu, 18 Jan 2024 07:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:36:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:36:39 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v5 05/14] iommu/amd: Fix PPR interrupt processing logic
Date: Thu, 18 Jan 2024 07:33:30 +0000
Message-ID: <20240118073339.6978-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af38164-6089-4d2c-861b-08dc17f83848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+Z1GTO8P6FgsWiKP+h4K0g1V3wJD2Q4f10R5ZI19gYZ2PqorWPP7WYmeaY2xLU/aeQByEOh6IdA+VF56TEpKt8naE4rK4Ze6BF/9JPRX7Z9WZEOJumInx4iDAIBhTW2l49LE7j81UUyAwxSRKvPebKruzGw4yxBAatjnCk728xX/FMfD4/sdnh9iqySn1JWpTUzx1auY4h5TL8YfSDQh8PNADuJwlTjJnqoqM12IEpUOf1HFCvoVJJXe5QCg2bnMKYzoShH7lTwOl9w1WIQpg6KFQuNMzGUYnDKHhOv2k1o2nP2Wj+l8Et8IpWp2m6M0qcTKIrVb05r5iVuZnhEa73E9k3HZ0ApxsAovxknCO3HFo13awwA0PTf3ZmiOZWhsqPyloA/PWGMM/S1UVFY1w2nGjrGJh6kE0Wg2v+f3wQAf7B2PArbmq69XhQHDO58NyHt2LPfuBlbKAO61MRXR71GyTxUypwN5IBSCld160F9tnU6fvk0wkjHpGcWHzCAeVjO9jLtbK8Np7dl2wn+ap8x7ZUtleiUb/nxI+LB21u7zrzE+mz2K8jWjPTBopDExTxkBLuXqXp+oY64YHXN2/EPI14748RCARQCNMJ6XQm3fevR0abZ0O95iToxe1VYL67GRDmHpxH3bHfIULNkAnTFQfhgVXxp1FigSob3o1wUhOGTVBcKYQoWTUsAzXt8HmuUJzx/yaFzzJw1ZLKoiKzqHJdL//EOEoxaxV/WnSGzY0guOcIrz+l0aNWkuS3ENTAbruRoS5ibGMDuid6Ocw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(8936002)(26005)(478600001)(2616005)(6666004)(4744005)(426003)(1076003)(7696005)(336012)(44832011)(8676002)(70206006)(356005)(54906003)(4326008)(86362001)(47076005)(316002)(70586007)(82740400003)(36860700001)(83380400001)(110136005)(16526019)(2906002)(36756003)(5660300002)(81166007)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:36:44.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af38164-6089-4d2c-861b-08dc17f83848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357

* Do not re-read ppr head pointer as its just updated by the driver.

* Do not read PPR buffer tail pointer inside while loop. If IOMMU
  generates PPR events continuously then completing interrupt processing
  takes long time. In worst case it may cause infinite loop.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..d43a616c0c36 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -104,9 +104,5 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
-- 
2.31.1

