Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0D1CF96
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184789; cv=fail; b=gGwG0JHz28dFL7h0Zif8WffLxM45oN1kMoQACNbdjmCmnAmKCAEmaet5vIBqz+54E2II0VJl2BbBeyi2iqL9H3M0YlK/8URDjh1n3IOOclylH+ryQYf4T3Md7X8Y3gPcN69l3awC5ctzdWXNj3DCwiIQ0hNnnrVMJC4ftoTUcFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184789; c=relaxed/simple;
	bh=YWIkeZqTK6BJ/juANmKaYJqGHZPhdKa59RU3JwXJKwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3BJMwviuvY/CB4QIiDeQUoklk77ZgKOyFohEyN2twlNscYJpbAN3TDrbm6YAghLw9TjpXy6JI/C+zorc9eUary8qfoJyF98InF5FtDWHLMYQdatQcs2kK/8OpzyY1gSRpgSVoZS2WMOSVjle1UOU4a52YGCEoxuTEEXHkihAj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GxtoLCu1; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GxtoLCu1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgK1DjXBqg/sCEd99bp7qUcXuhqjb4o9Buqy76Cvslcu81tR31sGT7pVlgN8WKsoA76LgUFENCbB75eyoQRUVnZ6d61iKEWuyZ1izSINQO8ZEO+wUIwymx5pTMfBdzl6TOYYiiEjEVptjHvLsirZGJVDwNuhde/4zICcRrDrHzPEERY+/yWXuyQ8bBB3ikjLcaH1i6G86hsoUvBvirnVtJh6BXsPwMCcCkrB/SjgOJPCNxzxx2PI0zDvNo+JEbEvlAUghD7OUcWmf5vrp5dnhDhdo7H2hIOqp/B8MW7w5Xd01DKB6/ARl9W5YxvvIzgMX93sS/BXZ8zjiP9XlZYeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=FY0E1qBtEaBC7hTn0eWVVF+h+vPwwM6lLbpj4mZaHQbNru2NkyFepiDK4IVwD5eatc7M8YiCmPy4R1hUKmp9f1pdtrNxO2h5/+KQW/zPYgWwgQfFKUn1/ug4irVpWpbyy9RTl7NCSepZwn1jGMYU1pLVHnXm8HnYXAYZXuKeCaXX0ejHGC06zxy7AvkxygpQM++CiZoOecgItx7JNMZzQEjhPZHKdQQPpc5N08TtvNizgoOCyODZ7KHG0aI16tGHQGYPNv46HQzv+7smp3RSPOVnADy1kUXfILn9O3QkI0Ff4sEDVkVKcmBiYrA+hvFJifgxAOPSYl9kTh6gnWN90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=GxtoLCu1NKjTCRDw5GrKb2z9NwLt+oL3zTnPqO9AA6vDEuFaRdClRKW56x8IAikwBYq68vmBK9k75HTF2/4PIcCoNQMSeeyw3xIxAYdeLgfPRldWov/tqERYVzeI6UIpNX5k30Szm1eHpkrZugMcMnIDvcA86IpTN3cst+U2rRQ=
Received: from SA0PR12CA0014.namprd12.prod.outlook.com (2603:10b6:806:6f::19)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:13:04 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::1a) by SA0PR12CA0014.outlook.office365.com
 (2603:10b6:806:6f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:13:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:13:01 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 02/17] iommu/amd: Enable Guest Translation before registering devices
Date: Thu, 25 Jan 2024 12:11:20 +0000
Message-ID: <20240125121135.8217-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e0f930-1ea7-46e0-a6d8-08dc1d9efbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxdN1cH2l+lfjycgqG8iZ/KJt60oNvznTlDcqdcTHD9hHkROwTg2rdWtnAYTDNGbXIUO6cMVgI1RB6VJLM3fL/ku2R2zikrRq6vaMQu+6HJiIM1gy92pjL7pOGv1Q/Db2rvW0HYKgZo7UrW0nYakxDam4t80U6X1zLCBiPfBH3VdAZeTd1jR+lXdZrW53CxY8/FD5viMhhD/DQJBRiN1H4C2r4PO3olaRCqFyztkP046EwULRiE0+VbNNc+wfUMa5vZEUPMOYAo42WAo9n/Jljxh3NiTdpVUVuE2kUiWxYm5VYXcDiGjWdvSbYZJdK6WM2bGBIYp0AtZJeTWi4DD5mFKYvie+AEqdl3NqenEY9uCq43DRrm/2flxn2IlirF9Y3bSTBU3CHk4ip0oM7zGVx2O41J9gextGwX+/n2LFyxEl9Q4kAPXmd4FMOWuRBfnOCaKkIM8uDIb49xoXNKv5nRw7HzLz94aoRXjXrj1WTmQq6QKg5Cy8lmHrrN6E01wBZ+N3fY1/8E83hif6eGue/QKQBQGqA/KeIixxbM8R4UwWd1INk02J1H4yb50KPouHkg9dIDFmS4d5w1TWFNi7b51GBn9s3UcZX0ycqaVCi9xL8JwD1axBpi0jSUa9XIGyuCXhpcWSn64iozyQBNDk2dEaRf35FrcAo62ZjuWRE4JU6H7K6KTEat1qPGp9lmuJ5IXhmQr/yJhJS62lE8Fj5YP1s3F2CI7mgcFt4p9yTG0oknjWeSms2SU/3suG6CY2lsSAMlDqo9gVyqpQ3Ch5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(44832011)(8936002)(8676002)(4326008)(40460700003)(40480700001)(110136005)(70206006)(70586007)(316002)(54906003)(1076003)(6666004)(478600001)(7696005)(2616005)(82740400003)(16526019)(336012)(426003)(26005)(36860700001)(36756003)(81166007)(86362001)(83380400001)(356005)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:13:04.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e0f930-1ea7-46e0-a6d8-08dc1d9efbe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

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

