Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7B1C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2v9abEy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6s715SpENUpdn5SGOlgqMr8iEmHWgA8sTUNNgmlLnk1xb55uqBMJNo7ffwE2fV3j1mKbSYGp4l5DQZ46SUJ4t2dfvOHjhVxJFYBywUeCKYvnt4hyQp66KJ9TCB1wdc0hurCT2B/RAFhoPDLGoKNRei3eNRXpltZiiN+oxFdDy8B4zI+7OAghsZRZtydzqC9M0cjuO//2Emc2vcaY232+uIwwNWniDU8/wEBL9oQmCaR1PKReKSAri02DTCxvbRTjR9kYDRGQ3gMVyvMuLTNKzucCzpBF5ATEgcRmNx3FLVdw/IO9ZrZ7IRV0BdNSNo6sjE8lXyyB3GXXb81Jwijlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNghOnD5P9NJthiPYxaWpBX/1FlLOrRtcOr2YH3hTNk=;
 b=KFv2h9sChRdHjUYtZYvsBc9deoEt+Pg6c7CHF4lCTFnFVRQozW2S3spH/HApPrQiR2Sypj01SOU5WvFJdK/QRjlt+jbhsGoou4WsF/488OjpSXtfozBPS/p8Xw/TJeNCr4RE5blXqVl5BlgSXzwhlKDUaBckGVxpnTj+ZWyQG77kIZQ/Ua4dWNC9Cdj783FbdDH21HkvE1mlHYoM1M4zfXoaKN4KJXpsJWE13sVVW5qB78ItCSfO3KQUkqq4IunHWai/Q4mUpQGEtEaB5rQ6LjKq0Fh0UheJ9qRlBODKQ3QklyC3ZHQlYaXX6gPvfjDpyvUTJ77/LL8vDAom3/rOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNghOnD5P9NJthiPYxaWpBX/1FlLOrRtcOr2YH3hTNk=;
 b=2v9abEy6ikseYXJA739hShF84XTcpJxc4IeBxJ0P7ItckBKjpZSDvvHn3z8jRL8lCPJyVlG6XQwj2m/Gw5V/njZWe3LnMKaf64EGlv9NgXyUAf5olLv5k7aQKTD8c/fpw0sckxyU6y53lMj7kFm6Ot95NAXs0ZIBmw4HT2/Arp4=
Received: from MN2PR04CA0036.namprd04.prod.outlook.com (2603:10b6:208:d4::49)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 16:57:23 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::dd) by MN2PR04CA0036.outlook.office365.com
 (2603:10b6:208:d4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:57:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:57:19 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 13/17] iommu/amd: Refactor protection_domain helper functions
Date: Tue, 16 Jan 2024 16:53:31 +0000
Message-ID: <20240116165335.6043-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: aedb4e2b-9ec4-44a2-3ab2-08dc16b43597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3P5kClZZhnVcZrRWb/iTZTcZG8o43A+YPwBNL7W3kbSEuAg47HrG3oZCHGBrZsAyNOk3/s5kt/KR50Cc8EEzNAnsBBmxYDR8GnToyr/dPouoSp4Zd/dpnfWHmkFgjLmrWyo89V7ATr9NPr/Ds/qANgk1wPWk8bsYKcevDG9opbeYQgmXakTCn621IgtyDSP+b6wqk1QwXdJxgM7bTqKHaYtxSNrAaBHdOHAU3ojZVJSYeLCFZa/3HIiQ4s+iOAuLqKUeuAKSlmXX+zyzp2zLUM8AGGH0MzjYlgNLIzLtGYsHgp3i6XrWUTPWeoosh4SqNhMcdAXEVLddGkcl4sw+dsV/bHyh+2nroex/i7TF15mSZdOCfjcf7IcL978ZCVv4d3CD+dNYiejwAtmD0Xqm4PyheFD8df5ilFkmjbu55k5BGCxLnZqtmxPenA9arlJklZi3FLqhRmn7UeYRaWXWuwwHO5Ee84fGgFUZTvYviNNJCDJfdnbSQ9TBPaMazCZWyjzRsWEvndWnAVQQpMPywvN4qey1qbGoLAi7MCNjfMDdxy5haqysXH+KBhrFeM3qAP6yGBmMo0Rld9vaY4W2w6r3Ii0MTY206IxMPEV0w7A3mI7c44x0/x059U3BqncatwtUSps9ceMcsPrw2x1XvF1mEeEBznjI1Z0twtgwZhEJ+omaJbd8GkyuQ/eYUxpV3B23Gq9dFbsEqM/evqR69GIK9BEWGm/RU8EMewHCurmCfFCwF2fwPUPqcqcyAUxeapOnOLushECbAh2izMjwzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(426003)(16526019)(7696005)(336012)(478600001)(2616005)(1076003)(26005)(82740400003)(86362001)(36756003)(81166007)(356005)(41300700001)(2906002)(44832011)(4326008)(83380400001)(36860700001)(5660300002)(47076005)(70586007)(8936002)(70206006)(8676002)(54906003)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:57:22.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aedb4e2b-9ec4-44a2-3ab2-08dc16b43597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b5347acee5f3..b6b7b55c3682 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2233,9 +2233,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2263,15 +2260,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

