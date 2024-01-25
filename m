Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CE45030
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185043; cv=fail; b=Pco4l1SfPaz11c8Jk+7mGfk32flWmpcukCeMRhVekO3EqlF7NqhHQqr6ADKILVouJVR+u0TlpcDt3K404KKS4rkU2knd+XPk6G/lOFpDGDx/bA2++2eOvkrn/KnJxM9y3lMXkM3F7vgt87Oi3rQFExHk+k9qgObnUep+UDJVsZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185043; c=relaxed/simple;
	bh=ox5Jd8BtZ7A87zOjb4QKQzHPmREnXDnQxInTFJBMBT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFBnIND1oWeXxQG0LXAk1l6WEzrTWt5gxQKgt+15Rgq1xLvR7np/9Wbo8VzPp1LmBZVO4o2t5jdopY/7XUsM/xGn0scSiCbPpnuD3KP0Ab1TlWlm425vts5Bj8kcFBLfrm5vipTzno84OKlq3m/fB/4y7d5nNbViszY5PBGIPpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ZicQuC1; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ZicQuC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEzoPbitd6NkS4uRM4178EHzluiriwDg4k8gPT5owlx5t7piWm6wHXxkt+uOAerjiPBGU5sxGwy+JFPGA+rsb6ts23T02a0kx5SBmLbK21vUvcfO2KA9XaZMNC2resBsnKiLgewX1yMcIaMUZFHvjz5PFpP9wcogpuoxZ3ZI1OuSmN6prpBbonp5fznQh3zdQLOSSFzBUMUE2FVFChrFgmyJCMArOuDM5K97+LHbsyNI27LTmsVL3m+uXhM3u+kAFdalXIayoFZkW1ElUCCyb5+jxkZvDEynsz7VhSeFA1lSMzS2X0wqBO+tGVqI/IskzBX9DdL1UkiyQehDbelBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d3vtm2epSUqgK4Ga1v9Cx6TVlTs4TH4nfLBDnhXoQc=;
 b=EKsEjzGuwvnW1lRnhBUqz7SnTdaLdEOuCRSKZ0HzmZNAmCg6pvTbLY1txhPFj3+31b4VYsXDAwI6ZMQTIeQ1+lBo0V6wKr0wKE9EkM7FIr5FaTGLWuJu1vj8AGjpyXJVBiXQRL7tW4bCl/6nuTqTrQtwNYI4KMrwu0/cIVkSLzs8sFGquL21D4whQrP1PqdUxxkysWkeMoqA+/P/uXRLGIZlOFZ4VmtsITdBAkfsr4e8NTcKZJgE/3kd84V0m9Vt8K3m4lol8mH6QP2HgzXYO0qJvp/h+CAvrSiOVm9vh5iC13/MnXWvWOimHnx19TrUrerpZ4cmRwghCQY936yMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d3vtm2epSUqgK4Ga1v9Cx6TVlTs4TH4nfLBDnhXoQc=;
 b=3ZicQuC1OiWmkLgYJG2ACpVaN30vPWto9uL5+TeqkKpYT24cv3vwttZlrJwwCPlciJsQxru7TxUFlH3stJax72XCSm3jvhEXYVoWoW0h6D5Bt7oFBw18QDYu1l+Ng5NkPSX2RCXt3rxfO4+k3haTbw4Ubcf6ypVBWqUNMJe/RcI=
Received: from BYAPR11CA0081.namprd11.prod.outlook.com (2603:10b6:a03:f4::22)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:17:15 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::bb) by BYAPR11CA0081.outlook.office365.com
 (2603:10b6:a03:f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 12:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:17:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:17:12 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 12/17] iommu/amd: Refactor protection_domain helper functions
Date: Thu, 25 Jan 2024 12:11:30 +0000
Message-ID: <20240125121135.8217-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 055e711b-9026-4a89-b2e0-08dc1d9f9182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qc9PUNesIY4XrwcX2GVxuyrspmjrN1S5enY+AwVz8ce7mTD0dPF74o7Hqhijg6TPNwSxfoE0U/TTzdQ2cd1cb55lSw9QqsaAmQhP9oK+BPv6hKQwF60Z2urr1VQCABBldJWKmU77zLs3DwingiIOJrwPlLzrOiAPh8FxBhAyzjLcTiydOrlmUbC2s4a9H5RKEIZdmFudeB5iROokkTztd0/EbVPe1o7dE0B5LVcCQFG3pkt/UldC7vVA51sSxo9r+vI3xQXldIOPGn4IxNpMnyAkYagf1XA0hL13cBFRv9E7EIM+BwpckrSTtQVmi1ZDT5RhnaGmWb2B/3LCR/6EdArV0GNGWWafVmFNtkiSzsTsezPbcPjX2Iv3XoBNb9w53kLDi4oBv8i5tsWOcWw0mYWcLVGe/W8lhWLCRFY+dxLnQF6/AT5dAgHRgzxhoj1GNXyRNANjhjZxa+wK0y7oBXuchtKc22vs7NsuF4KAb0j8W2dWXwvpR5Qt6YLC7G0NYIjR/OiRqGg7tpn4XyDPq9YPhUny4GunfKEo4UlUDxdkpiGN84NvYE1MTS7yDECbgmmF41hizKh3p5gfiYW+VSZk3xrnEZmgvdGwBhKCxNx6mP5PV4RGvxl/287iBzfWEZS/O3cch4A4oY7X3vwZf6EwMThHd/iGJIi1MFVGBKsHXdVvTnm59ql3gfx6o5oR60vcCNBoTasqZlm7dEjuMO/vzPnfnbRVArV/IPYnqf7IfQr8poDFRByBVuueU87Uv1sKpAFErg/OW8c+2jiOoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(336012)(8676002)(44832011)(6666004)(2616005)(4326008)(5660300002)(8936002)(83380400001)(426003)(70586007)(110136005)(316002)(16526019)(1076003)(7696005)(26005)(478600001)(36860700001)(2906002)(47076005)(54906003)(81166007)(70206006)(356005)(82740400003)(36756003)(41300700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:17:15.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055e711b-9026-4a89-b2e0-08dc1d9f9182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6d35f40c7daa..9a78972fa8a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2179,9 +2179,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2209,15 +2206,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

