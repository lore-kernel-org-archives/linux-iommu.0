Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583C100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9X2G+dDyT54HZcjRbgSuDL9ueCYXWjXFMOVQwpzBOuZDv93UkEHFDsVt0RnouEtBHZB11d6QkuVavan+xyZF9s142JNaonYaHJzFg9P7HQwObxDgNy+1AsQxnHYJi5kaOl3HBRPKmIHPYQw1EvoBiNFDskUFP4OieQ9i+dPZpE7WzuuIQ6zRYdRzT8keoi8gJ1rVKBWEHyOVBZL0aBjz7p3877Jp/i79vMcj4LweGB46NZ37S8taHq8eSIS68K5FZjyttXP4WCGNNPGop/smHd4h9MfMElwPspyZA6LXhOcpQVcT4X1KVjBm1RJRiZDAAb1RV73XBbdWVLo0yyxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVUWIC8lJ0VmP7WkB1VDmEtM4H+eUE888th5DYm79Ys=;
 b=jYO8UHc1PtZ9QVyFe+RSBC7zOY9HTR2GuGfEQKsP/banPEberija55c2+i5A1OPABg3C4y84fQXddYH9av8rMB010r92umdt2Prlnnn73XJK9DYtAOe14dr5MO1/KwKfPPt2QReWMb2CJMXhmmNSr7kMruYdj3C6NnMj/VXq9b/Al3upCD2MM8tYDt7oBHA7OnIDWWB/i80eRMhdhpGtNnry1SNWfTsmub0GErjQ4qrBi8qSbg3KAOG/lZ+L3j2MaUEj61ZbckYVVUYW7vIABkkFZT89UvWr8svmsQ39ZSgaILw+ecTqeeWHtTgtVfwXxfRYIn8B86ii0c1Jyzriyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVUWIC8lJ0VmP7WkB1VDmEtM4H+eUE888th5DYm79Ys=;
 b=N/76CfxlRgDNDSsYdizAuuS++ZBzqBOP310r7JtPH+DgZl7T7t29vM9QsG/xhMyKc8T6rEH+2Iwf8xa773XDQLnHtX/pO7JlcDmr9usVr04zRWHhLvmYGO2amvieqixYHXkLPoG/CHM4BBLIJG/c0lOH1JuGlPU/fqIcmLWtImM=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 14:19:40 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::35) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:19:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:19:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 15/21] iommu/amd: Setup v2 domain with max pasids
Date: Wed, 12 Jul 2023 14:15:10 +0000
Message-ID: <20230712141516.154144-16-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecddf84-c71e-431d-970a-08db82e307d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	loehicjPROCUo8C4pp6nDX6kvVJI/PjWZ74NtFKhKD+lEIUhxuFfJycI+A83BIXQieBmanq5e3zjieFrIUJps2TKKB5WIi+PmZWtduOHyGDpYI3K+m+DZpLj/p1RRKQCQbii4bBDGcZbWM1U+GKG1Sjy9HjMrhU5LeU7JxRdKtdzWDXWNQXPKh9+qVGdfJ9vldzx+jjqMCve6PH/+jLKnpfh1t4rF83Q89SOCC3fIUgoxldyAraimZY7rX1LqqwzeR1ss1PJvDpXx5NGeaRhAm1EMHRZljBSFe5tuJCiufkKIejefO2WpYV0X1b4a0o3ngby0KEY79RYrXsFiOQvZAoi/PA6k7NDG35qAptjH7U/qHT8QfYZfpczwIZY3TU/YHKRGtWxC6bHrsVSwWJP77BQK6JGt16Th/UptOoI9doN4lQx2dMclCBvUJzDxIartE+S0ebvpJKBQ9lYF068zmGDAuDrutHg9XC/KZqzaYv+PBj+P69B22g/I6B+HTBuvXCacZkOjVPldrfgR4VcBMnZIZxwRt0Ex6UTKmosOhAbYvOE5hHrSMFlkAji1qjAr+HUCeWVogkG5CIf1Jxbx8lKXtD6EHJSjn75Cb9nur0WjGE0bVAp00NaCH68i0gHKeGRe+5K6DEg1hU+3XAYretcxwqueAqWzYCKOP9otZC1cFqlNQ70yqj0l2M33F4pwY4UtwYTy5q9nE1dQaNJTBtrCK7tngay+aXGIwtBEYsv708SANa+sgYkdMMrpjoqSH+LgZ6f+Rp3QoAOSjyhcA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(82310400005)(316002)(6666004)(7696005)(44832011)(54906003)(81166007)(40480700001)(4326008)(110136005)(478600001)(2906002)(36756003)(40460700003)(356005)(70206006)(82740400003)(70586007)(2616005)(83380400001)(36860700001)(5660300002)(8676002)(8936002)(47076005)(186003)(16526019)(41300700001)(1076003)(86362001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:19:40.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecddf84-c71e-431d-970a-08db82e307d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140

An IOMMU domain can contain multiple devices with different PASID limits.
However, the maximum number of PASIDs of a domain is bounded by the limit
of the IOMMU hardware. This limit is used to determine the number levels
of the GCR3 table.

Therefore, to simplify management of GCR3 table, allocate the table
with the hardware maximum PASID limit by default (value -1) unless
specified otherwise.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3c9fd2adad33..ce405cece3b5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2229,7 +2229,11 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
 		break;
 	case AMD_IOMMU_V2:
-		ret = amd_iommu_v2_domain_init(domain, NULL, 1, PD_FLAG_V2DMA);
+		/*
+		 * Set up to support maximum number of PASIDs
+		 * supported by AMD IOMMU HW.
+		 */
+		ret = amd_iommu_v2_domain_init(domain, NULL, -1, PD_FLAG_V2DMA);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.31.1

