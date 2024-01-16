Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFD1C6B7
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="09MgWStr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxM/d4pbi3Uq7kQRucp8iti/qEZ77UuA2mW3pT2K0GeZqTwDbRBDgR5a606wAFqJXK4YfgA4rUepUpv5nkNihWYcywTalgfE0pVxli8UJT0ola4iL2TLlVDhQsDmAetbTKxRyz2QiqQoNpL5QT3+OvDVve42J4oabbVN8xOuJaSXsd9dv5G0e6jP9YDRZfQqYF8uyRdouBp99yvULMTu1JGp3IH19J/C+cPOgJtvjpN8saLoON3+Mzf5zescLJ1fOFegEDQIZ1yl/sdsiuEX2aAduHz0M0phkOlOMCKAhtZ1kKQDD4QVMmMfyHRWGJvjiz8Fpnwgq3jySFM++3z5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=n0e3L1hkaukgB96FbJKH35T+BYFa46McoYIC1yCLTfQsyjQKvjUEOESOkHuzwO9YunqHvQ4T3/tRIWk45dwiQiHjszJgwXP/Vck3u7p4AhIkFdpG6ygAkGyJ2faDNSEPcl+gFptsRpVG++WYNngWkX2k2dz+kcU4y8soB36u6/8xlUpYcUDQ06Ruv0rGrPJ6Pt2xeRFPhJSTznUb/M6xk/9Q5Q1jfnnav4qoFznwdwzWNCVlejb8wYOzqp5PVWgn/pp5/AXhvfT2+QXLNo0As34stEN9C0aPDleekCvOaJBP0riqbPS1zSDVr4oLEwgePIo7hzNRnbHoNn4Xoj7ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=09MgWStrABnvTs4htNLwq2l9WyMbBeLvbdhUkVP/2MKUJ6QBUpkaHpO1p5z4qpbGkdgMW9PnqnE7P7RKdvbDIwWEry71O6C9UYykosntmTzSpLqLH+wE/womIwFoFe7N5X9Oq8kYlgFVH1II9TTxk8eOFqFSS0cKGXElXebvFZs=
Received: from BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16) by
 SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 16:54:30 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::89) by BYAPR01CA0003.outlook.office365.com
 (2603:10b6:a02:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 16:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:54:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:54:26 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 02/17] iommu/amd: Enable Guest Translation before registering devices
Date: Tue, 16 Jan 2024 16:53:20 +0000
Message-ID: <20240116165335.6043-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 254539e6-88e2-4313-9e4a-08dc16b3ce3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0EgqigkCXkRujO/wd+Uhz/oPUUhQ5vNjwFIe7ZF2jQMB3J22yhTz16I/PtpDwXRkij8PJHV3EuwHi0j4BnBvBSotWdZPK/g0HvmGJuFkJTe52zMxh0CtmHzdDwWJ2klwmJiXMfpsrR2ImBSUYN01wjRrVn7zk8q7ecHfocj2bI7Z8oPa5936FIkgil7vLqdZC1uG/twuTV8shVBKcedrhlZGqG6JKtwk9zc7iUi1st2T047g2AMwrmZIK6EcaIfJeZtUMNQ+T32ogcfa3cS6CfcbBmobA7UKQ4kuwPp1bsb1mzyKcI/Bvm6JZwX+6FgpzcTJTwSG0UVyHGqEOnoBCeB8I0MFqn4QZsHsiAgRRLkMHhBNU7PU5K+9fSpbpDE1Un8domYR671whmE2QR19vh1bBm89iphaSme57cZmkYzeS826h5dW7IOPYYRHoUkkugOxy8wyc0kFSLxuoK6TpKBM7mY/W1vrvDpjX8adhBmYdco8YwtN0vxjLJJCQrKjJ6QBcy8yMXRRdBAqrjSGDxujt7LQnerJ4lRBm2pVL91kJ8aHxEo09rUIXi1ukwCRPhXz+jZFATXW/2ATlQMc4U6/795r/w1zsi+z4N+v2rPkBAX+ypxHUT+4PbMSUobZ8CJH8b4PsA1dMNL/D08dLiabLEF2OsfcrcI4zGY0WQQHaU9JXlKmMPHQAjgT2fXurl5EBOH/0bKLITCFz6Dpp+svQ1z5VSBFVG+SGD/1XhgJkqO+xmXWjRS+CLWIzTzBoIogrEEjvuFo8yEuNcy9yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(356005)(82740400003)(81166007)(36756003)(40460700003)(40480700001)(86362001)(1076003)(336012)(26005)(110136005)(83380400001)(426003)(2616005)(54906003)(7696005)(8676002)(70586007)(478600001)(6666004)(8936002)(16526019)(70206006)(316002)(47076005)(36860700001)(44832011)(2906002)(41300700001)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:54:29.3266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254539e6-88e2-4313-9e4a-08dc16b3ce3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

IOMMU Guest Translation (GT) feature needs to be enabled before
invalidating guest translations (CMD_INV_IOMMU_PAGES with GN=1).

Currently GT feature is enabled after setting up interrupt handler.
So far it was fine as we were not invalidating guest page table
before this point.

Upcoming series will introduce per device GCR3 table and it will
invalidate guest pages after configuring. Hence move GT feature
enablement to early_enable_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c2a1c9..959820ccfbcc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2769,6 +2769,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
+	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
@@ -2825,6 +2826,7 @@ static void early_enable_iommus(void)
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
+			iommu_enable_gt(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
@@ -2838,10 +2840,8 @@ static void enable_iommus_v2(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
+	for_each_iommu(iommu)
 		iommu_enable_ppr_log(iommu);
-		iommu_enable_gt(iommu);
-	}
 }
 
 static void enable_iommus_vapic(void)
-- 
2.31.1

