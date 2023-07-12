Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDE200B1
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhe6mbzOBMhLKn3dKyoBafA+b1VsIhgP9+sm4kHpkesVsVCpwO9BhW3fgWIs/c4JdZBDl0ok45jn1Baq4gD7YMreYung0FdqNrAJHnxzHRTmw4F1phsGdz1DZ4UztdrWTd8tOZFVPLb+F1mAvyzGNpHXX7PpbcLwNYNsviiyI95n7/RLzld6AwsRlFd/c82RU3LR+whHV5go7OGkMQsUFkLm59lJF7GKNai4qoDZjQJmxfniDSYMpyaNbg3rlC0VAMhNbt76FtOoKHG24+GGGj7FC81GdsGVo2fE6TZTklvhXMz3fLbxKJSCSRXaCeg1qAzNigjEihWKTS7m6veIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5c/2yelWV4AYX6SaWqHSEio5wg9YH1eK3OeLbrNfdc=;
 b=YLAsz5OektQjEKbUwzuGhdl5E40cnKUxne5bmawlenVdPgvpeeIpxdnUUk4BrJ9oAOUjZfMYXaF85tiZbiopA2w3FkhlAzh9knGbtxEzd0ak7M3AwUorVtdS+9zhMA1J5GSJfxwNDebqA0TGXKxDEEQAXadwyCDt7Niw7Zyn4zCYm3BH0kCVqX15tFhPCO50SRLCTFhxWa8VFh5kVImxNbrRmN3kKhOQeHKi77/uvqOCkFb1rrV3uL7uOC3k9bQ7sqiWwc7QxElE/pxL0uJObnVQffpb4kC/yeNtu+Fwu+HpZyF0pWiHvh5lWqpM3rZnZXZftDbJmDHRwUCbUHLahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5c/2yelWV4AYX6SaWqHSEio5wg9YH1eK3OeLbrNfdc=;
 b=DpfX4mgvrcxwl6mz3oMotGeOQbW/unAewrmMzMkbXuiwCY03MIsliEycf1FV8Y2FK2DhEP0iuolqCyVaZD8KhcA7vi+OjjM/T9WNQQLREMpHOS8uQqmdw5vZMtbDvyeGduUt7WHfzhGZjFPZdMvjK2IAJQ/hYdYU00ro0O6V/ZA=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:20:56 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::39) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Wed, 12 Jul 2023 14:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:20:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:20:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 20/21] iommu/amd: Initialize iommu_device->max_pasids
Date: Wed, 12 Jul 2023 14:15:15 +0000
Message-ID: <20230712141516.154144-21-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e3f579-7231-4d97-be2d-08db82e33545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OwytSh8kIBI3wrYnf1wIRL37VV9O33vX/D6VM6rNhGw+C3eUe+tJkMpVX2iJknsoKnANzsc/k4DSdYJXowSRvmEn59rYXDaaWE7o29G3WMYO8lkyQFGhFfqni50YWWS/9amcJOtv3MKHvw3zu/n+p4Mn3sYDBsig7PNcetd7bBOymTreykJvUI88n0X/gIzT7wybozvi6x06OsAJN3t+Z3S4luFErFVstGgUwgKSbUANAnsYB9+iB7hgvXdWs8J0lhZj6YpkEjqzjKP4ICirkR1gwUvo8Mvms1lSJ/DIKWTSwmbEa2GmZCNeEpaIyREPXXeJPTQ/9owJY1juTzdu40nzPrmUVM058zhUBYQ67MVma0N3DY3m4XXXD06jGvWqSMbEkUmdxreoHzP82yFYRS8x+/OPOzK+4x+Hc2hd6dhekC1dUviB5d8UV2NEwY2o0vNHuIL35rH7NP6TmfPigrfH5NzWLAJcTPE4fO5cpjBwyUjfXvR+ogclw5SYpqtavhcrres6zD6Qjnd650EcNduyiRJwTqEFsJmiPPD0sftZXoVpsSMw0pc0QDq2pIOqkC88ptPpCEvDqe9bLAViUT7LQ4RoCs0+K8WEHCyOzxuJyRf+s/C4RnwPr8gsyy+wKIJ9WEOjVD6r/NCHV3L8iyzeFallFW9oVUvQiXNhFBN/O8oluCL/8RIKQMaCijj4zkIB1P7y3gAn2dH/uyjBdO3z2H3EmmNhVIdDlquTpkoJKAh9Fie8oMmRXU6RchnTnAzHBnrXXkYNpimzw1wsaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(4326008)(70206006)(70586007)(316002)(41300700001)(2906002)(478600001)(8676002)(8936002)(110136005)(54906003)(5660300002)(36860700001)(6666004)(7696005)(40460700003)(40480700001)(1076003)(26005)(186003)(16526019)(36756003)(426003)(83380400001)(336012)(47076005)(81166007)(356005)(82740400003)(82310400005)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:20:56.4601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e3f579-7231-4d97-be2d-08db82e33545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
as system can continue to work with 16-bit PASID.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ---
 drivers/iommu/amd/init.c            | 10 +++-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 64add3347a89..ffb1f98620c3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -887,9 +887,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1f56478ae74e..6441c81467ab 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2086,16 +2084,14 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
-		u32 max_pasid;
 		u64 pasmax;
 
 		pasmax = iommu->features & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
-		max_pasid  = (1 << (pasmax + 1)) - 1;
-
-		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
+		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
-		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
+		WARN_ON(iommu->iommu.max_pasids & ~PASID_MASK);
+		iommu->iommu.max_pasids &= PASID_MASK;
 
 		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

