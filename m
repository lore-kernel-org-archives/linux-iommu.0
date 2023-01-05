Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1557A38
	for <iommu@lists.linux.dev>; Thu,  5 Jan 2023 09:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPu9no9L0/kD1MIVIVcNlIVnj5Ph/vgmW/C9oDkoTClwpGmO/ZvoTdbllEOSHrRlexuFPm4f/ftAM99FIf676OwJNxAmQBXgnhCv6wYHxEUHysS8hldVt17FEnWadoN6Jy02NJqRRjQnyyPhPwVUhoR8MzqjDVap3i4SFDsPopRWG3mM+y4Au1BfxzFC7PbboSHvkdcZSJtTeobmYy1/syksJsAvRudPLF/1MIbGhewyNUei9cvajsVCkCPX/KpMEa7z5aJ512MTSOyCIWhuphFOFkR79RDhnBVVE3lSpYZaygUM6zksl1v+ZX3yGUZtM6A6NxzL+nRdLJFt5fDjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0vZgGoX32L/KGKBxwP3//FdZZqPz3OdCkPKag8caLA=;
 b=eWLsLO7QPBx4tQOBULLGcqoRdycmsSJBQzRI4CpD68QlXdVzoNDAyO8j2UYGV8WD4F+35dwLjmJyoy7f8BMjaeGtC7khAgQRkBB3hTjejh36vsq4Vfv2vjjZzy++JoE6mi+BNw9Azhp91+XEyiYB0UcvfvAOTadgPqthzohmAc56WIcXxRh0eawadPitLPVz66C4Y2C6JV8a/eZ7Vct3ZBXGTyVTFhe/7TnVIyFOiqMog322jX6Yk7XwsqByT/9zwquNBWJEKNXMXMmC6koIkM0gwb+3oxH15VcHM3EahMAjtIgbIpjPP2XcU2IBJqU5Dk+6s+RpNp8Wg2mwXZaOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0vZgGoX32L/KGKBxwP3//FdZZqPz3OdCkPKag8caLA=;
 b=SIYv9CvPDp03Et5yO2pbtNMtqmaj1ieO4IpIo+5y4SlQE2dSYlz7WpO1iKeOHaAj60Xe3BMeGbGQOOPqgirAODImwLb7B2GM9hDoi4dvmqxHGIEIUPH/cM9gA5IGhSeKgmHPIR4f4AeW8JfiBtUjTq47jPLzYj4jWHLkOY1bT/Y=
Received: from DS7PR07CA0022.namprd07.prod.outlook.com (2603:10b6:5:3af::24)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 09:18:20 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::4) by DS7PR07CA0022.outlook.office365.com
 (2603:10b6:5:3af::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 09:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 09:18:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 03:18:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Do not clear event/ppr log buffer when snp is enabled
Date: Thu, 5 Jan 2023 09:18:04 +0000
Message-ID: <20230105091804.42506-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: b2de6fa0-a0f1-4106-a7be-08daeefdc9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X/5u3M6wTJdak3+BhJmJdpYQKXIcg5j0JYelbP3QsYu0Pwu8LQ57IRRmIUAEnbQgDPpA34XsYnOeSOC2m2CjuCCQhOqggAZdiRkZX358sChslgGF8dr1P1jPvZLGL1tsoF1sDGKu7+4J66F7KoqZLy4HX0V2g0pAXX6gLVH2FXNKHPocnMUtMRr8ebpZPfSIVNLNnkSXhoXcHg/ibsLfR2OfuZfqvIMXv+xf+HQ/Vp/HIlGwmcTGQIwq358mdg+46zMcQp8tUyPnRM5NM8eFLpc/pm9Oqhp/2e5FdLMpfbnteUCRwDtSMpzM+d3v+KGGVmkdsO9q0YbS/IXR/Oq9n0sxL9/o+Kue3Cd16aI7r6Kd9Nin2ORltSwkwfbJhU+Nvx+AoDVDBOjlo0dOYWRSU4DApEedFrHwZZRZvm+WIJ9hrG7jaDKuVwMsBYbbWs/UeYzo8iOEqzWTgQBEJQwQjab0uDpTy10YKLVS7HdtQcuqky/M2kFc+QVE0uLzwhXrNJv8J0jhgCz4lpUDayDneDLoIqP7/oT0G3Wbz67ATLSnMignF/JXv/zTs/dtvMrTsuKh6WgCABMCWa0w1lgGRIDMW8xj/Hxo1OAeA1rnQQR3aOq7ySo5l1zqjxOHmuTDqCuhZmiSy/NQbaNH9aigu0d8BtRuyac34CXEYcYwUUYCgj1nF3KtE9HhDZd/lfX74DeQwwe1C0hooZIiGOG1yo9/k+1c248BZg/koUslunQqU6erjZ9y4VBFTVuLIVh9TVdCKcj49x3xOHi6g7i0fak1ntHThW3nOz+XNbtmD5d+gPHrETsKQBsSkujtXz9/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(2906002)(81166007)(82740400003)(8936002)(5660300002)(41300700001)(44832011)(426003)(36860700001)(83380400001)(47076005)(86362001)(40460700003)(110136005)(70206006)(70586007)(54906003)(966005)(356005)(6666004)(336012)(2616005)(7696005)(40480700001)(26005)(316002)(82310400005)(16526019)(4326008)(8676002)(186003)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:18:20.3106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2de6fa0-a0f1-4106-a7be-08daeefdc9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

From: Tom Lendacky <thomas.lendacky@amd.com>

Current code clears event log and ppr log entry after processing it due
to hardware errata ([1]  erratum #732, #733). We do not have hardware
issue on SNP enabled system.

When SNP is enabled, the event logs, PPR log and completion wait buffer
are read-only to the host (see SNP FW ABI spec [2]). Clearing those entry
will result in a kernel #PF for an RMP violation. Hence do not clear
event and ppr log entry after processing it.

[1] http://developer.amd.com/wordpress/media/2012/10/48931_15h_Mod_10h-1Fh_Rev_Guide.pdf
[2] https://www.amd.com/system/files/TechDocs/56860.pdf

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..acc5e5e4f9e2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -667,7 +667,13 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			event[0], event[1], event[2], event[3]);
 	}
 
-	memset(__evt, 0, 4 * sizeof(u32));
+	if (!amd_iommu_snp_en) {
+		/*
+		 * To detect the hardware errata 732 we need to clear the
+		 * entry back to zero.
+		 */
+		memset(__evt, 0, 4 * sizeof(u32));
+	}
 }
 
 static void iommu_poll_events(struct amd_iommu *iommu)
@@ -736,10 +742,11 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 		entry[1] = raw[1];
 
 		/*
-		 * To detect the hardware bug we need to clear the entry
-		 * back to zero.
+		 * To detect the hardware errata 733 we need to clear the
+		 * entry back to zero.
 		 */
-		raw[0] = raw[1] = 0UL;
+		if (!amd_iommu_snp_en)
+			raw[0] = raw[1] = 0UL;
 
 		/* Update head pointer of hardware ring-buffer */
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-- 
2.31.1

