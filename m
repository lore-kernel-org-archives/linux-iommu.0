Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54D17F5
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 05:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsBLfV7PLsbsz7kfjikGiey+lVsKBS80hn6SVHGer0s1AK2heMwN1kAQWdPws2PDyiSDa3b1tVm3iDtenykkQQ+GTv1sYIEIc78LLfMOyc5oTxLvt3Pq8rvi13VQ8TufPGyRK5AiKHtvgOgGTKKTNSNX3i3wwk7yQSJvmQZhd49smU0xa8ql/8vCWHJ+G4H2HJn5oQwCf2C9axjw3/mQMJx9NM/4QYrEISx0xCWT0ptSLQEwKbzciF+dNARJCMmrvlnJaU2R9HrRwSLFKbhSrbdjT/GdYFekdEj0o/jhdNuQ1ZN53wDIKVon1FbMtZBlyywzbRd6h9HnG7SyvpJhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=OZHOf/KfOzRB0/o6gjDVJnY9WQs00Z6GPkoDciSFRfSJaYkxKbCJrzJAtFmDug49RZj163BX6Tx1Ffh1a3lFerdyiiREoxQ9eWJRNrODKONv5W5CEqWTCOSOvir7F3JnaQURxaKiikWvhUPED2uUt6xn1M3laInKG7q6IFf24CZan0Z8oZ0mONLzLbuAPqZCgYVVeVpNgBXkccULnLnzDzkmUVm4cJ6V/mIKc8r+yaPNSpVY0xab4uERLoEG5vDDa9PNjJWy0eBXvQzO8kHz309u2Qp36M9LwqRAloSpj0ij4PmGtMZK83FvHHgFNl/Azfs2LLQ0/sJGVw6r+8MDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=c58JMAZ+q9DMaXAzR4npUYu0R8D4LTyQAKEyid5mSVoD6jfPbUw8Bg775ZTqNFnNYJUbluE7zqkuA8NQs7omMoGH0tFhTF4f/D0DloudMEgUgEVNuvdw7UJJ7Riu5gv+LSo2zxzvOU10Oama2beEkQLq25ozbt1JUqms+PerQlM=
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 05:27:40 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::c8) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 05:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 05:27:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 23:27:37 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 2/3] iommu/amd: Skip attach device domain is same as new domain
Date: Wed, 15 Feb 2023 05:26:41 +0000
Message-ID: <20230215052642.6016-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215052642.6016-1-vasant.hegde@amd.com>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6eb8e2-6e05-40b9-115a-08db0f155af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ENySy3H648joFuw7wsTGXQTqHlas5hJTWjo0/Bx5ZjgRj04rNx3A4d6yRaEtK1VBBmMkmiAhvqMFlahN3d7Gb2smcdOCgajiAHjaTS1HEsVuwuQ7ZZzGL6pc0o4yqMw46X1bVLTE+OptpDT1rda1Jpmv0zAohd+/BwLpmdmIRWyvIXVqVzjgp/ND5EOr5RYuH8DEuVzCzuWvj0x9OKdCtvWclYJ0sqo8hNgGX72ELNtY4LEyRl5r6N9mlveF7PE5MyBINja/emC6dEW4QSt2p17IXgxvI+Gt12kFW0pqaoHair67FiFKH2oId0469OHzoz2qaWOMYFY95Ky/o708KzLWUuG2PV8C+0dmlPnk/5aEtDwYbXk0AnfP5+lOW0xIcimtS7nDsbUcxim7kOomcPR3eza9GO1V16C+MjATINGtOOTPcBQFtP4pFscW0Evtda3oY0rq3Wuy0TePH2ubVXOPpcM+OOvxllvHbNeS7P+8uadt8eZqyKLJOY8lNwCGlLUPtYjCu89kqybvOkKr2HggmlwzjUR4duSlXi9tQv5lpVoPqV9hb4C3pxRkBCfubMd9bSXbwEXnvUguYXDDO8DdY+Hg293ZxTjJh1M9tII6L/beUjr7r3wzBJdH7Erdmny7Xf8RifbhdCmvB1iAk6WWpLNKuHDFTDaJaykkQWdjwd7L6+kDWGUktJsfg6zBraiHi6WsT0MpEe2Rb7HOPo7A5YUPV5RPJ7vVNpGg1I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(86362001)(40480700001)(36860700001)(81166007)(82740400003)(82310400005)(40460700003)(36756003)(110136005)(4326008)(70206006)(54906003)(356005)(8676002)(316002)(41300700001)(2906002)(186003)(4744005)(2616005)(8936002)(44832011)(336012)(426003)(5660300002)(47076005)(6666004)(70586007)(16526019)(26005)(1076003)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:27:39.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6eb8e2-6e05-40b9-115a-08db0f155af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535

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

