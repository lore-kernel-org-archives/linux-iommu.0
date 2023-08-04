Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C11FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4D/0CwKVhKpyJ9X/au1laGDCdCYAdJgoGXN3N1pzxstlIfKMfCq8VSksDemIyPHR7VpqCIUhiQnas25lRcj2KAfWyRwd3TDZjKpR4kgwZUnpTABuOoTrsvLqU1BTbCwl4+doPjMfbhXca1prIOTazY9Y/PARlZS82IZQFFjy7t/QqExT5Og3GeD6zxDPArf04wSP7PM8soNEbUmSOLMME8/pBbFJACc1Kf4o3ANYkjg1CWIDUvlwO0iBA0AUZrDuuZyX4B9xE2GMsvLNjrZMsR3uwh8H6nM8IBJ9ze4YM9u5rv2b2jqvBVxLOrDPQ5Diw5aNWLnlWmt82bNIGyytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP1w+jr3KpYTwe63+D3w/+I1rJjBdD2uSM4JQm8KP2I=;
 b=Kt5lCySd3JNJsl/Ft0clQZmwKyghkDFhFymmXr2xK8hc+dqnEmK9T1dDQv8MgWZ6+CtJxWgdItgvZfLFiRa8/47AowmT7VxGZhZanLwv8Df25Mu6w2Tv0IYwd03GVmLnle8WVSeEbZx79Ki18fcrNVY+7pMKmioKZ+JZ+xDw+BaFEiylV/+BkSZrNiyMRUfBImufu09KFMdMhqKFH+KLanbtIR6htaLamqurmlLL0AUNd7V8i4BpBRioT/fgldgPHSMZnYW1UuOLmUQ3xdFEaV98FDcvY6M8uLdrfwb1nzCYf24GuBYrpzxgLitbRqRhnlWn1Esu/jJ57elvXFtNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP1w+jr3KpYTwe63+D3w/+I1rJjBdD2uSM4JQm8KP2I=;
 b=Hsapju9yJ1cPaKuvvrMSDkdM6O0ZfpNv0lA2FRFEQBvEX7Z/Hrn37BumI6ZZ3xhBJrI+jujh5tB4aYAIvog1y/xyRUYA5MNwSah9f4ZCwECZQt93KPtTSz7qe8Nk0qmiRx2fwfnz4hzq4ja5pVfTdufDvOC60j26YobthoDy+ls=
Received: from CY5PR15CA0040.namprd15.prod.outlook.com (2603:10b6:930:1b::35)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 06:45:06 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::fa) by CY5PR15CA0040.outlook.office365.com
 (2603:10b6:930:1b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:45:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:45:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 08/16] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Fri, 4 Aug 2023 06:42:08 +0000
Message-ID: <20230804064216.835544-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: f741f3ea-6026-4259-774b-08db94b6569a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RA/qb67mD4B/fK6g1JdTNyDjE/cNFRicQj/2H46xRvsPdPgbN7tfMV48wnB5afD+WAtuZKmhVXTR9hQZ425psOzO7BfI3faPinoMrjOAeqfsjIC9lbQZjb5+rKd0KyqmK7GWQV5n0AQetbWa64iUo0zldzV83/hbGRuZJ3sRRMHPBplSGu/suTLloGJ7sHIzCc1aIDz2E5+dpTgaR/Fvz/YuKUAaI/YwAU8cwYqaiGNbwinofm2kZei0IBmmulKOjXu5uxln/3OKN9qBz4IrPHGawqDd8Dj5HojblFrYdXdlExuLs6wTTxrU6u7gY1ykJ1xZYV90qCn/3yKYSMFP/ndA2Vf2xlpvVOjJvF1JwK/HSwOhuw4Y2qtql0v6za2S2L1JUvZMwQTdmLlJnFhW3vRV3dZ3XPYg4Z0nReQCwpR3H/3W1OGJio4jSpO0zeRC8a6EbYC9KKAUvLOND2/RZDcCMXYCqUp+4edCWMACrOHOLh8Ab3iaaFkq5bOy/4pI4+hUrLYuVZliNwGipgE1GwqrKeWsh7SORUGgqCR+kao7XN8ael3qlgaLU03G1ITT+cMli0ao23SgbvEP3hZ2kb1uvSpxHNE4Qkh9xLbCpvRFT6DbUjcIARPpSXsac8rJfyTWaltKGh7u0d2jY9prH4/P2zs9NYD5wRnJ6aM0DTHF8xzMMXSifoteu7oXvzJv7vVdzwuf/REhZav2j6putC5JAW0zvUuxsUNF82m4J7j53PubINFQWvXmGt0e1pZGPd/mAOKaxlpVvnW+bEcvzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(1800799003)(186006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(2616005)(426003)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(36860700001)(316002)(2906002)(70206006)(5660300002)(70586007)(4326008)(44832011)(41300700001)(8936002)(7696005)(4744005)(54906003)(478600001)(110136005)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:45:05.9885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f741f3ea-6026-4259-774b-08db94b6569a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

Since AMD IOMMU page table is not used in passthrough mode, switching to
v1 page table is not required.

Therefore, remove redundant amd_iommu_pgtable update and misleading
warning message.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 852e40b13d20..2b01dfde6cab 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2134,9 +2134,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		    !iommu_feature(iommu, FEATURE_GT)) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
 			amd_iommu_pgtable = AMD_IOMMU_V1;
-		} else if (iommu_default_passthrough()) {
-			pr_warn("V2 page table doesn't support passthrough mode. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
 		}
 	}
 
-- 
2.31.1

