Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC845C1A
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184920; cv=fail; b=eaebUMt/5JY9AWIgefpw1lFMJ6urp6teAdGGCI4s+9FQ5b5wUiE1Q8MWOTtvThNteXIfJtHBY1dRJFK8do5ufWL170+wTwzLCzsuvNw79gHERjlPot5hf4r2mlzeWzcgoreQuA0u19MlwpkgBPKn0VOYRJ/vUlvIXUONMXK8pzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184920; c=relaxed/simple;
	bh=Jy1dd3B6PO9vlkgzQqLsFVFm5RCqRGoxC7YoUsjiNK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHMoshjTJPaLdfGfw1Wwt9HBs9NmOaFbpZnJF+jYK7Glwao2BLahsunhvsqbUR3ahrL8jUsTn2RGo3SAVV5wNjOZFdu7cLCIZudZcMaiJO+HaQQ7b93dPhwiYfvymNugdq4Yqilp0GYqhTatV/3k/fQu2TqOAs0YQ5b/BhyIXPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3kwXfqX; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3kwXfqX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQdRjoHhGvWUJYAiGMhVE5+bgzBQLqW5qrF+Sp97ozw8M676EaXdp0kt5zlqqCb8DK2+LLt1T+NPJZAdnO2nisRfDRdHIDDY04eE0RdX/asUc2YfENbnZ1egLDls3X09IrJJOHjkHoN3CnSk2RJg4NsjRrgBeeQ9lZ6F+CL42zifMZ/h2c+vnFdCmhc3cAS5VWNx6gBLI/qbqVrS1Zyi8/oW/aDKj5QDNYX/J24MkE8WbqhYjtb/Tw9XI0Ula3XiwjYL+JxtxYiQPt9sd1U3SgOpAIiL3Q1mEoTC14No94kGO+XzyvpSFA1+xJNNj4RsAL1WSwinNzdOl8/9NLLssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RP4E7Z6Qdyg4V8CwVGqkjuLiCyhMW8IQ8CmgLV7Jeg=;
 b=cNve6t6sT9YbpCEH0gujBwHAWjp/XKSoFTxeJP0jxybBlnqzoZOxvsqX5bdsxMZtNyvNz1DUbkR5mmXH7XRjUfLiYzDQ3b+v6VD4oZmVmA2aHeL3synFG5nEzBvqQPJFz9FcYjEoXNcWu4yeenzkQ30x6SdEh/mUUKyNJ1HJHXUYE//g1Asg+TNqAvFEXVxVuVBjyNxmesNxydiAanK7aWMgmDrIg6n9pK63+Uk77IPWcRgSgt/u43ikMMpzuvhy38E+FXy18P1gGms5qS0O91A85WUeWfy2KBokBdiwelzWN91SS99muB5LWMoY/rRzmgdFfl+Ck71e8j/q8DU/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RP4E7Z6Qdyg4V8CwVGqkjuLiCyhMW8IQ8CmgLV7Jeg=;
 b=k3kwXfqXWufqGeHkwZJjjiq1hP7x73T8OLcUhhfs1/1kWPnkNHiP9cM7bewl1mwiXLosfVIzKt/QreNlf9qSIR7o/0GY3shIknwZEs08CZwpT/6bwTZ8vMKAbsMdEIVVMkOsxTcS+u1Ezu3oMGzg1o3ZGO08BahM8k+ucXvnyeE=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:15:15 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::30) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:15:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:15:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 06/17] iommu/amd: Use protection_domain.flags to check page table mode
Date: Thu, 25 Jan 2024 12:11:24 +0000
Message-ID: <20240125121135.8217-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: df9d5a48-b897-4aab-fcd5-08dc1d9f49db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6FzcW3Zq1K/z9bUdJ/0SwsS0TLfn7XH8BoJIgq8LRF5ycdboq8qZWxW8NbpTfNmYOp7IVFXobY8B/n/oPCrkBLrhOXQQJwbtqxsOu72VLOK8IBWvtDhwNGOpCilb2vB6VBE2jGShhBg3cNecN2bAK3U1mFo4qZJ77zgawd36UtD92qKnkY1iCV6C6iip0HDaVPkmxERy1CjN/AA8BwgZD/Vt37jJzAaIj/BkqFpXZGO4ABYHHPZfc8NGtohHreo6KMo5v8kLKHf/p0D1fx+Mkq2KK7GhcGfaF+/C/wjQRTnjYMyRHXFTNuxBRHt3zA2AeJvBwlmhT7j4d8gUF2/hFd8gsLepuzrAU5VI/dzbDqWGRW9jl9e8512mYElK/Ti5hj2ej/vOT0t80Qngz73cCqoPJyDkEXeZm9UNOOivenbYm1RuNRQVePG9Wc8btGZKmlTsln2rgsPklUdXKTwVawLPRlBRoj2jMWEiSP9JqGz9uKyjiuKJIkAbtGUXtmRSU7xtWwFUG6ax/GnlXywlaWGCOZS7YaDhFawZk57AKSZsS9nUq3FJ08pRkJr+Kf+mXL9M8/Xp2F0HCM5J8h5lr4LJpyNdGa7xW9YoxNm/07DfD3a2SImc3oKBbV6pYwQnrEfqkBFxU7FXoBSDFl2kZLFHkYevsXL6nmR59Uw3MARXfSll0yrbP7+e2ZhhFZHNhiu8ovi24glie+Q9guCkHYYS/s7LVMZlwJGulsyN4SHA4g/HTeEdSL/YHESFF12AZpzeHdVlAzTgGk9pg7Cs0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(40470700004)(36840700001)(46966006)(41300700001)(83380400001)(336012)(47076005)(1076003)(426003)(16526019)(2616005)(26005)(36860700001)(81166007)(82740400003)(8676002)(4326008)(44832011)(8936002)(5660300002)(2906002)(478600001)(6666004)(7696005)(54906003)(70206006)(70586007)(316002)(110136005)(86362001)(356005)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:15:15.4052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9d5a48-b897-4aab-fcd5-08dc1d9f49db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 88a536dafa7a..dac04585c7fc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2315,7 +2315,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2361,7 +2361,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

