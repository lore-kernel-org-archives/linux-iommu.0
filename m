Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7815C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h668nEa6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX7FpHnSK7aHM3lcK2NtKHYVtqO0F9LPcksENgt0cn3cdkfxgETpLYZAdqd/TmGeH5qGqhXWoEuFi5JtSdTClolCE4+D9KYAo1AcmvZIsQf93Rd71cs+QnoVLCfJdOOII9xg8dMaLqmz3ymXn4PCRJRTzd8DZNxoaAmmcXET5toRMQj8dbqvZJbOGDbSATPy7xXG6PTShh49RBgRPVXeROioSrkVvbd23nqQ9CI5mHyIaUMAC0uWSKK6eTUDIqa8jX2YoG2Qd4jrgKDc/xJ5DArw3iSBSdTUEAAo2vrq79IlAcOtCUO+jbFyMxNMEuGhaj0k7Ja4vqLn3y+P4mfdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW1yplB1YjemYgpPQIvowR/JenlxdKMmQflGBoGKuHM=;
 b=oVdCJQyoAyQHroSGrsRybZ2URh9HtHAwansw+FC7U4gmlrlGiH31UPgKxrkh8mF/JeNRlV+ums22Lv3CL9diLV8D44t8/BzyMR7rDVFhIrNjYyJiyp7naMUekDwtrA8KhV1Xz4UdfOi36j7rxEMZtSVcooCzhVHPpFlss9ZM14cy2Bx0znQX4ZCEuuj9iN5ANgs5F4+oDzE4c2uBfDJyrwtM4DeeYulc8cplsQQP5Mp8lNda4QoznGm6VrdrXLNY2DbGZ1MSTz77jaLsUS1k7Impk4KXdpB8RNpwDWpo6Y/xeMPUHdUONsuH76sVxPwMDtDFZCnnXhVOCqlTkAq4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW1yplB1YjemYgpPQIvowR/JenlxdKMmQflGBoGKuHM=;
 b=h668nEa6xM3X5jVAQINiTEOBQfHlDCT3NpeaI9VG4rG8dYl30OS6xf/1qQ/e+rqj1Jt38sQFQ7dnMkS4g3qpDVs+lJUuEsh0nFJIjksFnW0nNOkNItSeCp4GRrcSvHFBzwBM9QhEof8ocrBAQad//ipu0WPUHrE+msN7giG9GOM=
Received: from BYAPR02CA0038.namprd02.prod.outlook.com (2603:10b6:a03:54::15)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Fri, 6 Oct 2023 10:18:18 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::db) by BYAPR02CA0038.outlook.office365.com
 (2603:10b6:a03:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 10:18:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:18:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: [PATCH v1 05/13] iommu/amd: Refactor IOMMU tlb invalidation code
Date: Fri, 6 Oct 2023 10:16:16 +0000
Message-ID: <20231006101624.5912-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f886e09-cd6c-466c-5f36-08dbc6558f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3teMN0mYMgPh7bt0xVflVLbz8PNM7YflUK8zhbEY8CDQTkrT9Rc2Cqlwx9LI94z825SL/GXowqzd5h51xan3Sqr4hiwNO7F3jOuCacv9tJqpJm/SOi6DgYkZhHOdSHSsozitzrUUh0z+fTE177HNPmUh8jcL837U7TbZDHVzGmTZRH4sJxwkpAthTNrC2fe95KyyWKm7b0A7l6WvcofS/xJJd97f+BWjSFh+zMsCsWYK5kGFN7/L3c+ucKkKc+uhbtYLfkyDlZ+gxm73uwxZ4iqXIbAmM20zGaLUVIPRd8GqClIjcGLVd0JMgnrM7NiOVRb1p9TWidh0J1e9Sf2JTBlW4cnw0n5uplWcmQA9LjnZ39QMYDg22bBAiuJb0KFMoDHgFMBTvfAA30ebscbrCvOSNW6h7HeHUZ18Y0Kpz/K+obREQkfmFzrwSS3Om2vxt0Su9VPP3/F2xjOlQ2kSptAJYAx4yJljxtvPI2Q81Lt32zO1pWurTSaDDk7i0srmoelZqFfKq5ie6lqttZwhpubMgxNNe8q1BQhvGCDpK2MjBCJE8SlMVwL0KBPmh43pExWh8B6i3EiO884sgZnr0Us71WPX913+YlYCQR5bcqzXcMZ+GHkfb5CGoNYZrkxUIJKgabPln/7ASdsWtXiSozPGpIZBzT6Ci84ERzj7+q+A8QEcbajPPZH81JOaDGcKpvSZfacDYoUqnozbEzAkdY4yaGjZEEgTf7eo9rraG2NmqHqEbjkVttmz8PtAv1yPDTTNm0qfbtCX38WT4AK1qg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(40460700003)(4326008)(8676002)(44832011)(70206006)(41300700001)(54906003)(110136005)(70586007)(356005)(336012)(5660300002)(316002)(2906002)(16526019)(7696005)(2616005)(426003)(36860700001)(26005)(81166007)(8936002)(47076005)(83380400001)(478600001)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:18:17.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f886e09-cd6c-466c-5f36-08dbc6558f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

build_inv_iommu_pages() and build_inv_iommu_pasid() pretty much
duplicates the code. Hence enhance build_inv_iommu_pages() to
invalidate guest pages as well. And remove build_inv_iommu_pasid().

Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ee81ce65d25e..aa1bd45f18b9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1122,17 +1122,23 @@ static inline u64 build_inv_address(u64 address, size_t size)
 }
 
 static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
-				  size_t size, u16 domid)
+				  size_t size, u16 domid,
+				  ioasid_t pasid, bool gn)
 {
 	u64 inv_address = build_inv_address(address, size);
 
 	memset(cmd, 0, sizeof(*cmd));
+
 	cmd->data[1] |= domid;
 	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[3]  = upper_32_bits(inv_address);
-	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 	/* PDE bit - we want to flush everything, not only the PTEs */
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
+	if (gn) {
+		cmd->data[0] |= pasid;
+		cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
+	}
+	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 }
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
@@ -1149,22 +1155,6 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
 }
 
-static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
-				  u64 address, size_t size)
-{
-	u64 inv_address = build_inv_address(address, size);
-
-	memset(cmd, 0, sizeof(*cmd));
-
-	cmd->data[0]  = pasid;
-	cmd->data[1]  = domid;
-	cmd->data[2]  = lower_32_bits(inv_address);
-	cmd->data[3]  = upper_32_bits(inv_address);
-	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
-	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
-	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
-}
-
 static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 				  int qdep, u64 address, size_t size)
 {
@@ -1335,7 +1325,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-				      dom_id);
+				      dom_id, IOMMU_NO_PASID, false);
 		iommu_queue_command(iommu, &cmd);
 	}
 
@@ -1346,7 +1336,8 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 {
 	struct iommu_cmd cmd;
 
-	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, dom_id);
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
+			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
 	iommu_completion_wait(iommu);
@@ -1475,7 +1466,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 	struct iommu_cmd cmd;
 	int ret = 0, i;
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id);
+	build_inv_iommu_pages(&cmd, address, size, domain->id,
+			      IOMMU_NO_PASID, false);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (!domain->dev_iommu[i])
@@ -2521,7 +2513,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	if (!(domain->flags & PD_IOMMUV2_MASK))
 		return -EINVAL;
 
-	build_inv_iommu_pasid(&cmd, domain->id, pasid, address, size);
+	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, true);
 
 	/*
 	 * IOMMU TLB needs to be flushed before Device TLB to
-- 
2.31.1

