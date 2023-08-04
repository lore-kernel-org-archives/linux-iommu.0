Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF61FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LquS2TI5Jn80/IJlVFBntaA+zVHC+m0JK5Sc6b/5RgLK1IykyA73PaTruvEsQfeUDFBze7oSvy/ita0PBg4Th/TXd76QIAQdQykFp41O0s2cksjSFS5l87FsIwyJrR8R+TSVBfhaQgd671P2sydrMWUdM31R557A60lX6/qk+FDEzklVpVgQZrmY/cvA5wu9Ry/kPUUv6qX2nctJMcl3yzvK8EH+CYEZs7kyP3at1gyVXBz3ilEO3Dxxq78Z0r00DtU7Fnnk4vXrfGzCb9kgDpkCSqAz61mPJ67XHOliCcWyUx5WxaiKjX19VqiG00W4SgRowvP9Lux/AT1JBdQ7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJgfp1W21FY1hvXTn2PDYjkNZns6aIfUqj/8gIJF62I=;
 b=ijEfu23cvC7e8BmV2yxy9oDEjebrydypFeP2Xo2f8EM1lNl819mElCuN5c39QkttWqqFsNuGhAA3DHwIqMN3OXCxaF6Hhbqg3j35UgPMxumNDK1XWaf2eA5l/S9DhCLT6rJVqcvwqJ/NmIGUIuk1K8/x8976pXu5bgF64Zh0d0Am7KaYOSP15hjbZw2foIQ2bFPRJYSmxdMFwo12YwTUq5qrbHrxBV+hCUvkc4rugs70oei4IUfMsVkEBj8G0IYFiV9o9mn1BvmUKWWFfMm2rLu4LlIWY0VjW03XzYkWs1DVGlguQFsnhvsoARBorSgWk8i4ruxFzccK7E1KVC6Ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJgfp1W21FY1hvXTn2PDYjkNZns6aIfUqj/8gIJF62I=;
 b=iAZ/pr6rYA6qd77AubOXjZVTfq9EzMx04yXWAQ1MP6/Nc+pT9w2hS16PUUl9F2Zi7Oddwdcue6Up8y6RPVVdKPZrvQWbhiJoxNjgZHVypGGyi0E+1aaqcjz/7sQfC+xVcWyp8bbD6ZBLz7zaVA6zNwVLXQl+YhxXR8VvogqOJEA=
Received: from CYZPR11CA0024.namprd11.prod.outlook.com (2603:10b6:930:8d::9)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:47:15 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::aa) by CYZPR11CA0024.outlook.office365.com
 (2603:10b6:930:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:47:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:47:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 15/16] iommu/amd: Initialize iommu_device->max_pasids
Date: Fri, 4 Aug 2023 06:42:15 +0000
Message-ID: <20230804064216.835544-16-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: e34398f4-7538-467c-5e87-08db94b6a3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fH+2P2U+rrPw/HdU0a0Mo4wREht5xntOB6XCDVxB4x3LxcSDjjGD58wEiBf+agY9uti7hirgNlRMIb7kZHsic4HlJkDyB90J8Oiv6KvPUNwDgsfAXRS67poGxJ66Rzy9ywJSe2HCHitp+YzX8RWOTVQ+zeVqoq34yJQTcfIAo9FntG4ICzJ/SfDzP0cv9miiYqwhfRQxTwIoMvSTxhxugGqw1Y0+kft90kh5N0MtahDnHlUGzPA6AoCrNYPoZjNH8UvqxcT2fwhVU+5tYxsHDVwh+l+O1yrB+ahBURwoq0AiCts09yVneTybbGvtNaZMYRzpkjyNr4rxAeDYormmPUKYQ+dCLD5Oxsxupb5sfONf0wVO7iiQtPwA6jBrynwIMLg4a1oD9juJOAIkuNGWYh/BqImwBGD6DTZr9ZTU2xZ1KhQ90EPwkEZf0B1z8Gtu9ifirQ1LoirTgNpqnCa9qnZcwIHI/OP6iNhZ1TMinWicCBAYfUND7FK+jEiRjchtnvhcYPaSrvRHxYd6gwZV5essQrZtindJ6E1IVUypcVNOmrqzrjdv/UxpAKIeGMfqTtcb9OYMYnvv2A1cZW7oELtGKz6j8bDX/oV7w6f7gArSxELJKpKrEkMv9Ar0POctxaKe8OnLS6YmvKH16cMbjpAB3wzKo0UvzfvI5QjzbNP/YQn7foyUVWgcWm63DvyksCsMbjiNhq/U1R8ojqiQVthfaX+m7RMssr1tnSp4uRSXPw8zCSJqC8T+XBHQYp1fyCzYJ5xOJV/odGChe+oD5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(186006)(451199021)(1800799003)(82310400008)(46966006)(40470700004)(36840700001)(7696005)(40460700003)(86362001)(40480700001)(1076003)(26005)(36860700001)(336012)(16526019)(426003)(2616005)(36756003)(83380400001)(47076005)(356005)(81166007)(82740400003)(70586007)(70206006)(4326008)(2906002)(316002)(5660300002)(44832011)(41300700001)(8936002)(8676002)(478600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:47:15.8016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34398f4-7538-467c-5e87-08db94b6a3fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e114e4af0f05..0d339e022572 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -895,9 +895,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1f56478ae74e..e0b0e48d3d38 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2086,16 +2084,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
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
+		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
 		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

