Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869E6AB88
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZlewMr3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0g3Jbfx4+6DkFbnF/OFH53+hYmI5cbzAdhbmIEZ8zPkWDdyy3iSBuX6uKavYpdn+AFLna/0sVY3BsqWJqaj3CLqDC7APJouNFjxLSsYwVdX5iZRC8ifkdNyaQTIthhAosJrfEVWCFQzkLq5f1RplCWPqk0+nYNT9t+L3n9NzJCe1Z99CQRg0RByQvVDTMp3JDWHmPJNHff60B7iu+zjCEbtt/noqWMgn4rSWgf7tn36rhsOlhT30X1HxKofd0/INozNMqlvgj9ESNchTtgFK5SNhLaFA6sfqHmU2kBObDPQn3zNynGZUxdcP0w1nykd4Zqn6zEeYRPKHdYthjyB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbZlPf24D93HwlT+OpfnhTDGU9tR3v+EWjZJxbbQ+Eo=;
 b=UIqUWcZfD8jwyh8tjNofdlQBTS2FUIE8CUCdti8JfQ3NMyvLy1RLS+YgsVxDLaPV1w/mjqtP3qgvsgTTiIJv9VqTi8TxblVrLBKaX/8XAqOKZhYDXzYwajcKRk5mk7CFVImjzgd/5hcbCPm+IMCiy9eKO4kxyPMwPPx/OpCWY0/Tt27WAiixFzYXKEGi3As7pZaBjNSWI2CVWn5nFk1vNqxdKPL9lRkoE9FT7SfWGZhNORYE0MEHav6IMeAvstUh8LNwMVZIRlpSHpzx/FaIG0wy0X29sarcFFTYmUtpme8N8yYBY3N9Xm7Xahvq9KRiLjsjZTypHsKlh+Vi8PxycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbZlPf24D93HwlT+OpfnhTDGU9tR3v+EWjZJxbbQ+Eo=;
 b=ZlewMr3UGm6hJnP7FDdrPs1F9R7hWTzHM5Z/RLZ5Dn91RJsXJa9HMpz540Qxkt0Ukm/YqQfTrpw0WP4tg8ND3OZvQn83+j+VXIgzvNiiIZLsFkC7n8vijgxPQcN2MR5dyaZXycUqfJhYpQS+vbc17ByeSMo4Pue3xz8qcwZZ7HE=
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:16:39 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::5b) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:16:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:16:35 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 01/14] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Thu, 21 Dec 2023 11:15:45 +0000
Message-ID: <20231221111558.64652-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e43a247-c48f-4078-f32b-08dc02164d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WdqUslA4E32dgSTNWsUarQN2VOwklToXABfIe1JHidu9RYLSSNbmjZUZHy3NRqkDZsObLSuOxrVC+mgrKHJo0eeGsVEhQK0IwTRqx9x4kN4OyErORoh+ndeR5BXd9234GfPEQYrDayfoqPuiKR89x9sk5g3eMD8PHToU6hBHr8mTtoyx4umYKlrr+CyvHv6+pqGdLbmbuV+09R4yfOYZGBRfSI8zBFOgx+jNubbiVOKIqMq6exRQwbRjCXTpOE8mHzkLyS5GtHD5/HzMcDK7M0KEuD0lsQ93AUHyvp7WKKiKiNp5Qyi1gCNc8wh/xoR0tBXy5CNDQ89LgfnuJFq25zwXDroFszymmdD+rNtEdvzRBW+Bxg2gKQi0BiSpXNiBofJUit5jt+SJt2J1VnZLNuSQULuyv/4RNSpmBKJdut6F1gaea5ct5Ao7UG2DC7CRv2WT79r6D9Q9EexBDjXYIuHfZNETdvP+3gq9u+6zad/U1re+lnON37xhxBvuBrL50VWKuD7vesgjhRWOWQzxxWfkcVtQ/qPtGFn/HQ13texBpFk9G+fa5fe8ezgcgSKROmI8UdLNtqMlYvWyVpB2AtIAEF/P4W/0qMEPdoruy4lcFGo6UqFblwtnItmAJnJ8923iIdP2Fc56cJHP2sAEYCamZ3kBvj9jPA1qac9ercVtrAqRH0KSNeQbJMuQpnC92uh5zuQaWwNI9jxZMBwFXz4WjwKQf3+WSfo3hN8+MktZft5Z4n5YiTghS8vTAw6lFsZkCsCN8Bl9TdgURRkzqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(86362001)(40460700003)(40480700001)(478600001)(70206006)(70586007)(7696005)(6666004)(110136005)(82740400003)(16526019)(41300700001)(2616005)(1076003)(81166007)(356005)(336012)(83380400001)(47076005)(26005)(426003)(2906002)(316002)(8936002)(5660300002)(8676002)(4326008)(36860700001)(54906003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:16:38.8088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e43a247-c48f-4078-f32b-08dc02164d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bbed268e8abc..2f6fba75e0ee 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_pasid_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 959820ccfbcc..62f695c519b5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

