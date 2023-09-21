Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84358F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk7JtQ4AdbTro2+W5XvJrUqaGkK1rEJGQJgjpTGH0ap8s+eMH/os0nxKkHkgkPj63JGCKGMuPvLxxxHw+7ODkJOLojXe6DQc50lAjCJ54Mq8jAMJRQ258JfWPzH+EQkhcw/noJRHOUIS9nxhjjPK+P3O1OlJX5Rfd86ppoCMj46Yzac3fw0Aq4Ipu3bsm2nrCJcXhfkg0f06VA4wqqBfay53iJwZUSCbIJuOIFfLe+HQeXLF1p1z0+REFxzOygBmpcYg9FuviqkOGrPNZGUNa6c0WwpDvU4rP5XEepOvDDBbE2FZH9/ribo4/4K2AzVd3AwsCI8K+nzLf27UCRM/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLe2ecKfcOrDm2fOq3cGdUe5/aqlG9zBOsUgu0AgEZY=;
 b=H0K8iiqv8Ei1MSgr+kmXwgoPacmZM2j5V172GFw5hQO+VRMCdJTkrwslrRvEK8E5MmN1T0bnsiEt3TIiFmRo1GS8zepdeT7OrgW3YhmHncOxyzUa6yksuhRZpk2QQEXQH2Ru23ZgtQDJFoUOB2rOPTLbhNnhuw9/IdZNBBk4z+czvw2OTmSJxU3/oLpe4Ep+0gmbqRGxH82Ki1nebEgdLhf1kv9An5bYQ4EZkBl384MjgUIlHkh1ARCNdr8EBw7rxzp4F3u8+MeLJ9+V7oJHfPZyfP0/vQcXzlN+Pl7dDv4JEnEd1ryrwsz0gzsF49f3dBAhDqtDR8MfUIyt4JceAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLe2ecKfcOrDm2fOq3cGdUe5/aqlG9zBOsUgu0AgEZY=;
 b=yACbjTOC7ryH+SrcuBGllmUmJECy1+3SojgFEG41Kfh8wumYD1Vs6vFH8CBBdZ19m4ERQuHlX1sNllNJVEZj4c5dL6dE/09YfEZzuGODkyoSOGj2J/DD/LeN6ckklbWbEHJOL8BNloL1mf9dLgxrWl9o4OTYEXyx3dQs2X4RM50=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Thu, 21 Sep
 2023 09:23:38 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::34) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Thu, 21 Sep 2023 09:23:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:23:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 03/14] iommu/amd: Consolidate logic to allocate protection domain
Date: Thu, 21 Sep 2023 09:21:36 +0000
Message-ID: <20230921092147.5930-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 996e2840-39ea-428d-34aa-08dbba846fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A4ZJAUQcMPGVIlZwNU0h68eU1Qch9Y/Hnvgd1QINv+MmZX5zQe301lPhLlP49BUpjB5LCRtVi8BtawHcDLt8sGTcewWLsItFK+88NA7Yg76bA4CFU89ClVzHnfyWbVzu0jltBVbAh9i8gEELrhswXavwdkR6tZhxyOnPZnEV1fRz85fbiLLcARtFWSjKn8A1tUTK07I/Rwz8pHiSz7v2svTlPEVyRlHtwPomqXQ9tJOs3A/mjMkoJ5xV1ImFlTzXv4U+cDZj8x5DPUd2ZG1O5EJ9BT5y1FDK2s3sD4berdJbJj+lwQLvI8fxFmn+JvTWwqPGxfm2jblAyuHGPRw0CzeOrdDljc0T9kibwvB2ES2zfTJo5me2uboJExxx8e/oFFnYyCFn9uz6Ox6uWWar53W5HVDq1rPEMuABf85GFgnBjfRbbDV5LtMWMmxTjWN4bxAc9cFa0W6vpFhmrK/NAeDnWkEyjLipeeRp3wc0CDnVv9kGCS9j53SVklKwudCpmaSFPI+/fdnav9pAAUeHruSepoaHrAH181wCiM7r8Y3l/8dP/IPpsLnHx2a7zMs4xcaSsImgoZDBdYgX4IvVTVNCAu5pq1zpKjlk+1BwJIJVP09z64ssU8Jkch/dVPP/vrbvjzb2r8nb75/5aOKplu6mPDIb64y3SybIvVXadTBxUx+s1TT2f/3AqAnsdrK+a27goPk5KoXRue2tX3FMQcw5a5PMyQr+h7r6Ps5fjP5C++Op88ucnpTkpGFg6ONt5Om86EFukobzwaZSnefurA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(7696005)(36756003)(81166007)(40480700001)(86362001)(82740400003)(356005)(36860700001)(1076003)(2616005)(16526019)(336012)(47076005)(2906002)(26005)(426003)(83380400001)(478600001)(8676002)(5660300002)(110136005)(44832011)(41300700001)(4326008)(40460700003)(54906003)(70206006)(8936002)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:23:37.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 996e2840-39ea-428d-34aa-08dbba846fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Move the logic into the common caller function to simplify the code.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6fa6a0527d7b..c99611139ab5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2046,12 +2046,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!pt_root) {
@@ -2067,12 +2061,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	domain->flags |= PD_GIOV_MASK;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
@@ -2112,6 +2100,13 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (!domain)
 		return NULL;
 
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		goto out_err;
+
+	spin_lock_init(&domain->lock);
+	INIT_LIST_HEAD(&domain->dev_list);
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.31.1

