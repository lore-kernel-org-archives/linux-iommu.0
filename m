Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075DCA4D
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiPWzimKAGzgBLqCE0Gql0KNZTp+nFgzRDDFPDAf+IYREFnt2wGGU8NpNkqKGB+Atj6g6M4aDJAdpPZsr5GWGKUXN2F5UAgX8y8VpKLodUBMfpiMQ4OCnqL938ej9GVM7g5LA7S+CPZfUKG99vjXRtXZKW54Fp99EmWT8soCJb1sFWkB/fb3Nf4kRLT+u8aS2RybHr+7zdxCFjpfHnHVGS5fDewliUsK3roygyelxYr8oxKdloYp4UzfOYO+dWjoEUp3wBUHJXQIAGw3m9gBG4Ol2ATx7lCRq+c70lXJdrr0+Q1vlWozwzVzpf9IRG9F+V3CfhpPPl9KMs1y/ueW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoRcaDR8EbfP5CqfRnZPJUIoG43p1aAHLM4yHq8xXCU=;
 b=hwAvbX5w8eC48v3LL42bMXK1uESt8/3VcPXmlX/4sHI0ZYeTo3l3+sE5jl5yEVgWhmSZkE2qHWWVkBfQSdMyujTNC0zsHKS/HzD7x31gyGNsxKZKqzm59G84u0/F+D6BGLX7D9T9HKeHTZmlLdLSvZpnnYAi5Twf7QqG57JPUju12apWHRLxlDmELD/Ay+G93bfgbcACmBVjHSVgt5gPK+YNdlsETHqzdoTO7hjan5Q2e2NNkpQZai3QN4d3KchrF+KQFWh61AEwO11dUSeM+4HV2nYSkiLZrDpgD8qkfsyXNv+ok828cplbvWbU1/5NTeDeorTg+LkJb0AwzNTHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoRcaDR8EbfP5CqfRnZPJUIoG43p1aAHLM4yHq8xXCU=;
 b=bmDQyRbhYGEjit4MuaoXpuYhFCChRlsG0lgZ0JfQEC3iN3JpJBtxi7vM8Jkx3hvmZhtOheLmbfXhVGNZwfimer7sMBib+OikCvKhtVq1tUwS7d8OOxx3DWFhtlFZI7r35s84cbjLk93dmmuaqfq0wdUBfU9Cv5+d0OCM1WcjVl4=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 12:12:24 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d4) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.5 via Frontend
 Transport; Mon, 11 Sep 2023 12:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 12:12:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:12:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 03/11] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Mon, 11 Sep 2023 12:10:38 +0000
Message-ID: <20230911121046.1025732-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb3b538-3395-4a0c-3052-08dbb2c05b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	++hvOqtohIBMWI0+CcAPY9sfKJqdSuJZa96zfYEVPXnPWUjNyPeUsBeDX9GhYYDtUAaB+TQUw+kMqepOcLaGlr/YPNx3ZYs0bIVGPbaIVhYO0KZuC+maP0G64bGe9ibUvMTt6/7IZbza5tDoPw7fsvJbzm8UmD2n0b5C3/w7RWRtx9xaaLWO+Ei0lJdld5kIzq2X9W3z7MVhLXURg3iK8FPTG19O4F383vIu8RytfeK5ka1kRLfo0cKf8O1BbBhSquXWrysH0mfLJQXTkpT08jTOi8S/xa+DOeLjOtc0gPZ8uK/7iWxG8rrT7R8qqdmtFyiXXrvk5uuqzpHRX4VxHp+KE/v4XZLzC6lruBMTW0xFo4udE1usKYAV9VYrL9K+TlrwBJuUBpq1tPbOefCA3O5ggyNlPpX3R4xdHtKpD+kyumEklIJyPtmjESvC2Boi2bPpXf9GYjXjksOKIOc89p1REFyw7tvGYpZUNb2jK4aB+ffBUyx/9K5X+56PKGDU0av3koQh5/gzbN8mO1DmXnqMs/39/EMDxgMro3hTuzS/aWNJFRooKRUnBwAgZDA92uhuvMcJdYBR2Ogkzza1a+t02Lb6SjDvZ7mrxZTTrv1uGXm420M/bTES5UOFu1NE078dqWZS0iOm9jP+RN5cdvx3D89UiT/oNVlQ5U+dKA/87Wa4ur21UKXLmhjXdkqLLrkh+caeNrarhOi3xruw+UV44+ABnQrFNwQEBr7U4wjcbyfvbE8drg/NeEux5ql8AhdQ+O5i7dW9Cs7CNzVPcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(70586007)(110136005)(86362001)(1076003)(2906002)(426003)(336012)(16526019)(83380400001)(26005)(7696005)(40480700001)(6666004)(2616005)(36860700001)(356005)(82740400003)(81166007)(47076005)(40460700003)(478600001)(36756003)(5660300002)(8936002)(8676002)(4326008)(316002)(44832011)(54906003)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:12:23.8731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb3b538-3395-4a0c-3052-08dbb2c05b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d7edb2d63fcb..a573e3534656 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2568,6 +2568,32 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+static int amd_iommu_dev_enable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int amd_iommu_dev_disable_feature(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2579,6 +2605,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.dev_enable_feat = amd_iommu_dev_enable_feature,
+	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.31.1

