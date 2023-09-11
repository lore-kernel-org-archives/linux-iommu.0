Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74193CA4D
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwggw6iKB8sAh3auQ70prl190+MbuvDKSQP2A6i0oW7fTv0/L65u10oH6B2jCFNAccj/XHahP+6UY1q00fETE4dl2W+iI6PznYx+4GA92vkV8q40KBLDXJVHLVWSsFbhZgYFuIgNl7JFD7yFzqA7ajT9XKG2aeA517pnH/SkXK4HkTOGRzuko62cQkczXZZrQW1ds/YMplm49/9TRiGXigxYvr+m9qk/s8XVNijZM4ZKjwLONomAFYCcRUKIUATPcH4pxdIewLWh+rBsSAHXhfW7x12e0P7QN9GNLtcwb1zZjhKPL1afXAmc/c5sN2TTDLwwfNCA2bXJKWpYCx2kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTN95R2YWx6ADT/K9KaQYijCaI2rHLWcYiL0Int83NQ=;
 b=mm9yhUXd/F2zdaZw4T2MBEgKlkg3bjugo9esRrzzQ7hygOxGpTkXMZUaC09wMtwvWV+7iSOfa+b+Y+/0pQ6rcgQ5aTGd1J0lfSKo8y88Mk8ppP2/ySz2XXSvaHieEt2/deNgWo4O5PZxzuumwSpFlz/+a0tgiGN/lXzrEI12/CE/DQvwz0xgcbm5RAubm5D/gYlZPcjZxfqXOGoNhp0qoYi6GrXh8ID7bu4qX4VQI250lE+eBP/1PqYuNMn/xfLkWdVRtpGAh60LbKvNCx4XcvNagP94FI3npAqidX3TJZEjQ2FS7u0F7xA7LWUFduvdKUumUHowj+NMOwYi1vvvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTN95R2YWx6ADT/K9KaQYijCaI2rHLWcYiL0Int83NQ=;
 b=nbw4FeB7CnKXtY0/lwyTIl3khe82UW5Ze1an8fGtAJ8XxfeOKTOloqhbFj8MkgiIzmHxcU8O9JgnwUhh0Id5SdSVz7KAHYvHNJV4TLXCvbGaxh+8k7KtbOk2hjb0OKHLPlMdPoxxIgg5EVChUDZzeyTDvtyqxcbr3wcUsesFyvQ=
Received: from SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 12:12:07 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::fd) by SN7PR04CA0012.outlook.office365.com
 (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 12:12:07 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:12:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 02/11] iommu/amd: Do not override PASID entry in GCR3 table
Date: Mon, 11 Sep 2023 12:10:37 +0000
Message-ID: <20230911121046.1025732-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b6ed7c-9a52-423b-e26b-08dbb2c0516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	43L7hbIAopKTc/9Mp5DraDW1LzrmqIo9WW7+VBUEPUd2r3YWeqPiubdHIljh9u8oBzbtqQ6Mra8MrURTmyYlbP3rBmgwlQ3QUIj0gRU74Ld5mb13RlDtO93+ZH6ug20gheDEup6fR0JF6jiOBS9+qdGt1xw0WYrWxt+4hSvsm/Q4UQFdTMV7InNWDetssvx3BSdDhf6+Ut2WVEmtGsW2AUjgMmeJRpp82f1EmL52lrOyD7qjF9ZnS8TGoijqTf1Y4HxUoIt+lQtSLqQk4baEu23HVJjdU6mlNwyWukR8RnBNevZYMatVr0D00RCEg4L0Qh7h14M4wwXi26QhavHr37QkJu9sG6s/86tiJ/NN3pZ8M98SRbMxiKNewMykCc6qVyORoJw+U4DH8HEcAfDcevrZjIXfKxsxLc7nAELN7YpZHkVWtV4IA8eg3BsUuOj3odkeQQL1ScObY6XwpjlUEHxk3GM1MGXsWCrDcHItDArfoH5WueS2Pzvy4V7yck79gaMmZnbceLaRZOQCz5jpIYE83IwQ5+gRTGhWBtpF4pym0NBxYEK1Nzwy0QmaKaUPh/DrNpL4cWxr9J2iIIVN+0fyoX58lv7m1RC4oDQ9KeH34+XBQhwNYqTv/LEqO4DPzSTFIcrinuYelFUTEht+BqUCv4QQ8oiC35w5kANt/DLEa1N40vaBtF1IHWUCJikKfobb7KbiHqcUm881SXcsrxNBxigL3Bjf8uNjMjS7GeqgKy50NR/B9T8ZifFW+WwHUoZZkhzqDePX/Xjy9KMIFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(7696005)(6666004)(478600001)(2906002)(2616005)(16526019)(1076003)(336012)(426003)(4744005)(26005)(54906003)(44832011)(70206006)(110136005)(316002)(70586007)(40460700003)(4326008)(8936002)(8676002)(5660300002)(40480700001)(81166007)(47076005)(36860700001)(86362001)(36756003)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:12:07.1987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b6ed7c-9a52-423b-e26b-08dbb2c0516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342

Return error if PASID is already exists.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f977b423d216..d7edb2d63fcb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2732,6 +2732,9 @@ static int __set_gcr3(struct iommu_dev_data *dev_data,
 	if (pte == NULL)
 		return -ENOMEM;
 
+	if (*pte & GCR3_VALID)
+		return -EBUSY;
+
 	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
 	__amd_iommu_flush_tlb(dev_data->domain, pasid);
 
-- 
2.31.1

