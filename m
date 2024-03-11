Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD417557
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148171; cv=fail; b=iEHXsqtxOrnuyS6Fiqbt0rwcI5ixo+9SFnPEKTnbdvKg32afJUIdgSyIDJBUQqyC9Zn/OcHg18MHLGSrZctBLAfIOvc6mSG0VeHR0PnoL3tK/5spKJAJgKIID9+Wzhy709qwf7X7ysqHRws9Z7ZqCk1cMU3VOnpGdxtv0UzWzOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148171; c=relaxed/simple;
	bh=X8EuqiwL5YTdqK4631Kk+IyiLnLWCTyxAhUqYrJ1zyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+pZyy76yMIwFAE3Cmym4p0Jb2dPGfAf7U1bV+rDtTQ39C6AEog90NjrQasmiRK1zJcidrfHWpybEeUDwsh1qlTSJjjY1tClUcIr6FYH+WGPSu2yBpHkWFcX+R7U4jCWKgYVPqY8e74Vve2gPCc3+VqSS2b+CRxp9vWl/tYGSQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=anVpXLex; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="anVpXLex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb3pIf0KziHClv1WjSW5mDrs+bAb4CuDZSDbZWYYAtiq+IKcrwxMK5Sd3KFzFCldMk79yj90SxFDuhXtttjmAYAxr9InBeKHvmLpiJtFGrtBUGowAFSq+O7p7ZCFJxiJSbId3/Yu4qtG6Pff0WPnUTxUuS+tr6RzP9Gonf4LUrRS6fB6LFjeaDbSDlZLkcPt1MB/FBkZDHU6fjHK0AbST7h+OyVgEdj/WDId9Ws/BhVlYn15IPnarVsoF/AwMFbhmd7BwM0REepEq0dQCjh0pf6xPlXpMwxltU+OgwIQOz582hasGDuxLOLr7skmWkZkrmT3R/h4elnv9/8IBD1gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPFSNtaHsELPDsFAdz3tRoRriXHnzFuhB2vkROqmw00=;
 b=WsKEED+xdGOlEGQlg94pK9DMV6QoaDQRhFQFWWiaAFACjJ+VgEvF7VSR0yD47MdBOS/YoMIkogJiINLk8bx3Zz3rGuXlqTAy0wmtQ1EhsOmw8Dof2Ed8EHzGtBWsGtKR8T+9rll2tjNBnX8XJDwY9yhnW+SNCH6dv4mByjf2+aQLi8pjPCLmcZAAaK1w/o8Vj8SiJ/OMzhT/OLHAtrBZ2JYXXyUpTfbDCEVUHTrLORyANiW6DrXiD6mRnnYNSC8ayFLDDHhK8PBAkm+JRE/KWHa2Lnl3Ex+3V0poujMDsACt9aaL0m7UCpfubfsOBDiqWCO1K+BT7gU5HM1hn908UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPFSNtaHsELPDsFAdz3tRoRriXHnzFuhB2vkROqmw00=;
 b=anVpXLexXqgM5aZh7GaGHw97+GdeNQ1WvOc+u085CTvxvW27J/PTi20rnynSJ9asEZEoCHLGhGVrVh4zCTWIiwaWZGkDwtvC1J8z1sj17CZLExwUuqzqtCaYGUl7zREKaXcuSHES+pv2o21YufpYz2PBgjrAxsbRRyn4nGS/WP4=
Received: from MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:09:27 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::90) by MN2PR07CA0001.outlook.office365.com
 (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:09:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:09:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 01/15] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Mon, 11 Mar 2024 09:08:29 +0000
Message-ID: <20240311090843.133455-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d05ede-0e3a-4337-c1ad-08dc41aaf3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MkHiAvpf2ahYRI2Kewe37q+F2ZBZaD8VExSF7BRvAZpXOhVGBHjRQP5h9xxrTVn6PW9xoOhKdmnuiRHvQ+WfQbEM+LZ+hzUtn3WhEhayap9fQcN8rt3ictDhVykfktedbrY3J/Hguef+te2giL8GaKJCEX+VTj4ydv0Htt2LNXT4/7GLQGGdLP+ausP/LHBHma0CV33rE2uxPMgebIVkbUUGXZ8q91O/RKc3JLdYc5xJLS1o18irJvSBJnfDhFhZi6ilorajIyuqHATadUQGIRqhQRcTZeIJoSaiycL9w5CKdY1A/EqGSfk2KciOpBPRcW28DfVfEVFExvVvxWxL/nVL08kAdgdi4He+r22e6KnaldAZEP+nQw2oA5kixOOcmFABAOpRcvUpj4JQ4VrKtUAA3LTGq6otmLeKkkCD0ryTX09MG70ViCw2d7i60la0lod/XhW79pn5a8whMUYMZtNU8AIwbCWoDueKV1LdJ7v2wq9NrSNo4MwI8jdU62rRxeeDDm1AtwwbyBA5clyyoSdEHYuxodbhlRjTShjrSsVBrAQw95LJXcB6Y7sPgNsBT3D4p0C4KexRguXXMdDjfDg1mkejZhcY1F/2KUKvnWE3SeDbi/Y41AcIGuZoRtFLYuQWKZld7y6CaHhKIdxn+eIsy3PKZvtQu8LikMLBUYgc4ohKVdomxrEPCkqF11LiWAfAD5HMqyCBFdQWQ1CsBzuivW83uf+LBZv2wvl94t6IoHjEqN+mrFQdogjZ5EU8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:09:27.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d05ede-0e3a-4337-c1ad-08dc41aaf3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bea910d9ace5..8849955253a1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_pasid_supported(void);
 
 /* Device capabilities */
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index db8d563af444..3a660d6c4ced 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3655,7 +3655,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

