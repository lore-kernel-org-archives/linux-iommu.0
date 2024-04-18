Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D688821
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436485; cv=fail; b=f7rXI86cBZFYMF/cehXX/uz53uty+kkudK4hzO846Nyr+pBJ1ZvDIWd6k/2EERbW7zByGowMUPYwxkLQ32m1WPSUbJ7aZzqVB0phsAFvsC+IlRWVCgy4uSJ+gGD9HJtEf4vuD0cASBZJArG3o4/ya7DGvROAwqEcSWh1xT/sxnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436485; c=relaxed/simple;
	bh=na/g1+FutaTONDfdPvoMzP5gCwVnli4vPbdKoJph0jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCWKW0kRPEOWcsHXwPYfvkMCnF8cinMBp0BRu9F0Yj9b4aeqRS1k44PCh1kDHWJYiPGXvfrQcRtHZB42EMJKX8iwX9Ea1w3sX0TBmAPY0L+YA9YkWvwnsZfOk8b9Rg4K3/J0neRlpndRKJ96p6mg8znPojJVc6tRZ30YbOzI7SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X5WVu81F; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5WVu81F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP9n+xGrIFH+kzQ6nktlI07tQbHhqhLkX89wr4KYDdP/AXeEedDu7FkjHQtawHknMu57KETM8BBciwIPmW6uk3ISqMiw5h7D3F1uZV6f2iEWeEfkj52R3gUjrk4EHe6QuHibbvlmNIPCfqWz3fW8qw/f6u/I8AYVYKU5T24t6EO/lOswhl0dvor2D1X4cUbiUWbwalIyw+3411XSL4NpPHO3t2AaylKJWmN8d9DGCqDvjw0WwDO4AjFGC8qzfco9wXEWqa/nww022AKRKV5gs65c+4vdNDBVHCwwuw8XeLxPeIVX1WtprXO4PyfS5qch6tEH8UbypMMaQA2QBj4H4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhfpBm7KYhCVENLdR62gad5ujdf9CyckHpTc5a8Xy5U=;
 b=NHLkQlj/95HdF83xIJ3g+wLEHYug3Snqaq3XMmdLwl4WDzAWjYbT46AX6sEktzYoRWUg0tEkjXaeP40KeZjfWurNKirnSu7THNRE7GhPpgYlvV/GIw3fMqX6llB8l+SVchfdvVe6ENsU5lxhg+0zjH1hFzw99KNDp9lw3EqSaPuryqMSrBi2SxpMQ5xvyd8UvajNcXXZk9AfRDBJGnD/cEO39Q3JZl6XIoouArg278TfRF6EeaQ3yH7sYaZYcDqPQBcb8ZIWhHMVuPF5xn+1EnNaMmPO+2cX0woYCEo5UnMiK+LSnz/lu/qnsIWwjYXp9vxQ0uAhD264hem6HwvF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhfpBm7KYhCVENLdR62gad5ujdf9CyckHpTc5a8Xy5U=;
 b=X5WVu81Fs/6cK4fUK23iAbuJv++hOhTUqsCC+3oTTW31oNhHaZO2N7Voty7BAUULdBXGi2gpk/1Kg2walj4pRWCIBSPF7Qo+wAyXgLtCtJDuv179nlJlFjjsef+jn+kFRn2oBGhbDUbfuED+Wvt6kE9kxSzkwqzm0gpqYXzSHto=
Received: from CH0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:610:b2::28)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.40; Thu, 18 Apr
 2024 10:34:40 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::ed) by CH0PR13CA0053.outlook.office365.com
 (2603:10b6:610:b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Thu, 18 Apr 2024 10:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:34:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:34:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 01/15] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Thu, 18 Apr 2024 10:33:46 +0000
Message-ID: <20240418103400.6229-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 942e394e-accf-4ebf-913c-08dc5f932750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FExMJNMKHqOaBYNoUjmwkLVJX4N17BFQJ8AWHZdTz5goEc73o22p86XR3G71hUvMmK8n3shzdnTtjhaNqddYGSWv/SU477bZEljuuIfppdwGRIEADJVv9GS7LRZMywMCaAlz9lEtIeaonN9mCJVwM963I1VmJEC+NUXv4OGf2/cA5L/xcKBnexCxp80NPoBWEVNYMqI3nayd8drx25gzht4/LpXf/oSGHWFEczw1U5MAuCrJw9u11c2aqBkdwJf0Co7/I66DuAb/nmANBu5PCNMmlUZu6L/7iW5wW2DCEeSXCrmkrXw2cUHZl4FKiZaibFRWi45ketrqw+o2E+4K5wkHR5YfGPhBdYDhZZnx6FU7awT/pA+hgJO3iXd60TTX40tmZhjdH6v3RNTxcyCI4Br08FwmU22wGfX21tk7bj02i3iMBH2KMovExNjeRKJfh5ew4ZlokdpCyQZMQhKy3xWnV9gLbZnru8pjU4QJO+qOj+v4b4NmK6xmFQBeZLdhdRQwGEgTxK8q3z09DIChDHthwjfyH6Pixqn+pPBG/3jChGEYXXTJC+Vbqn2My3wrAUrCMib73RSV7UPaQbSV4Ro8EiX3XxWIibMVS70fPVFM9Xtz1yTTWM9jw8EnVOe7UQfOrEu5K+xhwsDY/TPb8JIqFZ3tIsEcYcnGO/RCGnDIjarDBau1HD1D/UVH2lzdkk9bYqbhIqlg4E9eOaUlImct0G/ekMUm9ON1r3WJgWk6WGXGHUd/2/tUt5jb89Lz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:34:40.3253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e394e-accf-4ebf-913c-08dc5f932750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f482aab420f7..d77660551f2a 100644
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
index ac6754a85f35..5687c19825d7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3690,7 +3690,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

