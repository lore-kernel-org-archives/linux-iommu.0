Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73579CE
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 14:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeJhPtUC+foWmj/vowALO3LNq9SNncXx1J8UASKjPcfyWx2gnd8QONQepiRuDlVJPAkKWDCprFNwI/cfSiYS8isVUs/m2SANMnYpRR+BxqgCv4r4VINnchlAoShuiUsn81oen7bP8OD3M02Cwros0Jte6c5BR1SxhTixhZk+RIOuZf4zXv+BaknPA8YvVE3gRYRWATGEtXGYfo8y7ibrp3q4JBg/kqGr1Zg5tHn8XbmGPKnxnq3KuBOYC1M1O/MXNueE/fRJWmgk1VyKWMCbCy2Jdp8qviR4l7EAaWlyUCyKHIBsKMmU1G34GUyPN/dtWGDDq+juMeko1FyCz+2oeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=m6Cnm5tMVTJic/EQwXvjdyJVSJdi+V2Y4Cd0XaXkV1Y/uoXGeacHicW459I/5mmkzHzxqIr/kVSc/CF7FRlRs1I4sRbKYY73+9i8BhB1cWVR9F5mMsTad/Xvgisw9Wdpm9n3vYOSQI7ZGdJyzzB4L/x3SYpb0XiXYQSY6sAu+7BglOyAJXmMw6HuulEh/QQluRQUflSilGzgoNMtka6K3ZQ7cm7pDA1jtcqNstvhnDiYkb9hADMohfZ5meBMAIjtsF4vWfXsh6kJNUBRAsI8g5WeJ73ZjXQAGN0k8i+LN8ttdfDDfByjNRezAJ1KZKLW+1a6HaDlynR5WJ7SCkTxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=BjMJ3wbIoC4DXVf9t8QzjpAxvPg1LgqIp6M1bK0hAN3aWEduxTiPra83cI7M9z2f1vj2hycGQr4unVBNlJvoDzPlqNnjTw01u0SJjhj+2ogJ4VcmtFZGAlEi8AEyfy05OJ6nP9SaYTuXp8Raxqd6wQde0AmZoFLRnyruiBkM+1I=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 14:02:27 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::54) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 14:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 14:02:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 08:02:24 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/3] iommu/amd: Skip attach device domain is same as new domain
Date: Fri, 13 Jan 2023 13:59:55 +0000
Message-ID: <20230113135956.5788-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113135956.5788-1-vasant.hegde@amd.com>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c65c83-a4eb-446f-fc2c-08daf56ecdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MQQFX09oT1M7cqYeAxXJmtbyvs1aa9Tf5jWxgA0WPAXVGC10fmxqpDpSO5y/p+FPGkfs0tQBtoDovax11QcIFosQ+uY4o6vKruButECcKPOR6sD7E/j6IZpVlfMjroBd5LezwiGuFgSb9WDYr9xuoach34W+JFIofoneJswsXGLiK5xX6R7Ct+rpo5aJT81bba320ZrcqPsdwf24Xdl8q9P9KW8ViGlD6bvDoOzfcA2NFdetD9EcVArGi9kWI3kr5fnSHoPlTeQ0SpsLl1WJF4baYXcAz7HYyuDgRiVE1iTB9+qhV7z7k3fKYL82Vh26AGBKMhlAtqsIuruCLnJ5TJ8xSrpq+025PsCfgapiKYpRrBuW3lyLpj19XVgTXoedT3hlJ0M+JW4beVOpqAFVE6GbQ8Jemgn7d7YDhWwKSexU0fwFYxZWXIg4HJD440SZQlc7kRtO0Rg/fDV/U2lvmqAa623xNARFlncTVQdWfQza1pDfyuPYMGQ3uiEfNEaDTC6bCCzP4YTrkLZ49nPWSoKxlkRBSFRnCv5pQpSystKBvL6XCQ01o153jRlnMlJGyGbPrtzGIsqY9etSezygLrSTYv8/9eTZYjzl4AhsEuQZLCYdDPFf6AzVqqMe/3yCPy61yQ8dHlysCP0irtG0UDEyA33ynQMUZqITIy41Fs1PvcufShCrZdAE4X0WjPbJPFdPma4HjwJeUM2trMsvhvvYgvBjMYXyiEbaEnObxIE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(44832011)(2906002)(82310400005)(47076005)(336012)(36860700001)(426003)(1076003)(40480700001)(5660300002)(16526019)(186003)(8936002)(4744005)(26005)(6666004)(36756003)(7696005)(2616005)(70586007)(41300700001)(70206006)(110136005)(81166007)(478600001)(8676002)(86362001)(54906003)(356005)(316002)(40460700003)(4326008)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:02:27.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c65c83-a4eb-446f-fc2c-08daf56ecdba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

If device->domain is same as new domain then we can skip the
device attach process.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f8c018e1ffd..26c96b821fa2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2161,6 +2161,13 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
+	/*
+	 * Skip attach device to domain if new domain is same as
+	 * devices current domain
+	 */
+	if (dev_data->domain == domain)
+		return 0;
+
 	dev_data->defer_attach = false;
 
 	if (dev_data->domain)
-- 
2.31.1

