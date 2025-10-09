Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C029A9FA
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054378; cv=fail; b=fJIsLfpr96uymE1IIaD7hCdq4jrKWGzqg12XQKttozmpBQ1a818ou5lWq2PplvB9k/LfZTxXqUX/aW1apsbu5nqw43eTZ0yqU3l9yzOjxkLjtqpHQXQ24BPuGpoa9QuxO0ZmYNulUC1LJueZNBWKGPL074flY/lth6D24JVcEO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054378; c=relaxed/simple;
	bh=4KcDhi7rRGz1rTw4/Jdwp2bPAaCKtXsOh7z2zPLnwG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKmYa1AdyNnSeoBNHVlVQYrCIiaST+BK+tUqP69Wyf7YkZ1mRiXcqtRQYuxgF6EiWs/TKXGMGNppa7T7G3j7EMHOu6qLfNQ97OY+Ov3zOV7m19dv6OiavcwwUX0u0p8bxGywMG5UhRKZKzL7r/JNrk7JECSX++hJj8v+gRilEEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/2CYniT; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/2CYniT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5jZe2TXvgh20P31h+HjojQKFdcWzrr+r2FI0qyRkF2LiLRdSU401SEvMMz29oNFacRBGKhU5tScksec/qzB9ELbu9Pflre3sVrQGUe7SC74HqoDvWbrxUnRS3jv9ZVvvA4agQOZ4dQ2BaEyaIqLQVqVFQRm9H2DITHghdzofZljghfIvBR9jBkqWemru7zBTDo3An0jezOXyMHn+gwtnp6SwvMZoPqLJriaMwZrvbmpkKbiqgkN91zyMLD/FNu8ORRkvYPUNiu53FpQI1EKS2dlq/VgQGO0sdszs1rGjUFW3er+K7CJyTAcBsA7AVe5rAoSv+4aQaiNayZlbtQZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+63goECuo5ejyUOG2zBZiza/vDlQE0qecXU0Iwf1cw=;
 b=hzPXD9itDbD0ElBooAtWfHUQH8bTRjZy6p9uatp24eroHwopUskx2yicuNyNCcT7TIwvXdKj1tmTYGgivt7pX4OksX9WbUoJOzIgWEZDSFJQVapPH5cbF30yGlyUwM676e7VUh+NbBwes+V1CZNW+OLjqfouRq8o0dquGzDISOf5IdkjxT81U3CrOnnhpG0tzaTOthxHfobWIHZHAZ5tTfqCDzK0v89P5Srw6IhZmPTaccmHI45s4vbGdz5xCG+3uZb0H4y3DVydXh7zLKotLKnlECopjmrHzIijRAzoEc7OmtbdAfb5tlkOlrPf9C29ZwVg4CwdlotpXHiVRmKpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+63goECuo5ejyUOG2zBZiza/vDlQE0qecXU0Iwf1cw=;
 b=G/2CYniTupo4AENZDNHbkDkPCCBMiSMpJqyguNIZO2QhUzBHdUpthHU7A7foy6BwnDSf1j2m+hOl5xIIkX3ZCo+lL5uKm7RSuQoF8oEiDpTgr7yKZC7o4JeyPZG4xv1bpoU0krB9Vi1tNS4wTm2pAN7eAb2WKvlFRwpxEVraIMQ=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 23:59:30 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::59) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:15 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 12/15] iommu/amd: Validate guest DTE for nested translation
Date: Thu, 9 Oct 2025 23:57:52 +0000
Message-ID: <20251009235755.4497-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b6334fb6-45f1-41d1-0472-08de078fe2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEu4siqZlGeGzzRIRY5B92x3kgSokjrwFKGYFJQ44qGMx+gEp1ro9FWHMyd3?=
 =?us-ascii?Q?kf6lUG3tYcU+UMXfMCgkpz4odCzArmWBeSjoDYQLgLGkOpOB+X6Q9ZwWFSCM?=
 =?us-ascii?Q?hZMtElG8I2RXLHfHnd4r5vBtmawQfB+3T8q/EWeviOl6YvGWFa27Ghhx9rpm?=
 =?us-ascii?Q?0Io3zdeLLpJ6Irs0Z2+MNSJW7KJ6r8OPZ17tCIKhjnr23rxsiUEqpqDQOQd8?=
 =?us-ascii?Q?zCEFlqeUf6yuK32bSorvLI7ZhF/nGXDmDEsyweXi6B/TT8WuwNY7htVzE0BO?=
 =?us-ascii?Q?UHPZxRH+G8pIyvBv3NLArrGYek2Vtud/i1lY/8nJBK8E+eyrlQzDfW7FhV1X?=
 =?us-ascii?Q?67CyJay7t4hqDnndYRe8TXHpKdYxARHNwdowFbyTRzyB/g7uo4vJ39dpSrCk?=
 =?us-ascii?Q?LLEntTpmHS9cWI4CEQqqbNGnpSKv2gDBFsR1MhkQLWezT75PAos3jbceffpw?=
 =?us-ascii?Q?ylxUEuQ2rW6ONqqOpZYwPDRYCtmAf6dZNya/+dAhSgw31PAXkGZzFG7ZJyDO?=
 =?us-ascii?Q?GGSPhD0u0te9hSejOfRTDoMiBgvFk5TsUzpMfO2zgZAE+4Pre0tg+DIJcMGr?=
 =?us-ascii?Q?S9cqWBlFKEFcowV60atVPwQy3xs3dYku1oHlBmAQ+hoRI8BN4ikGkDyZeZNq?=
 =?us-ascii?Q?pTG+1FppPpPltOLax07tapOEPmJiBhUzbkkpqLgyZ+7rkfvNUJsKRR9RYOaW?=
 =?us-ascii?Q?0Zm/N+zdt5gxLXwrQgXoLThjpG6L07UGKKNNp/A1LgDiMNiFBT9QUGpYIp71?=
 =?us-ascii?Q?jOpRgV9yLxTpfLd0aBUS9Y9StIIq0dMfZptcI81rwDS8gRVzlhuSpFT6ZMob?=
 =?us-ascii?Q?OSSP8D5xlumZe6AjfkCgXK2oibBXBrRjzKJ1x6PEbT0lPQFn8NAs26Dqc+Id?=
 =?us-ascii?Q?NVzxzgJj9Tw9rD7/GzgMlveYpti7lpd2BOaBOmVDlGRPgDQVVIWui+zf1ONX?=
 =?us-ascii?Q?wJgfz4X1xPdsgGysiqDWwfr/5s/tesyLnkUmo3QdCiD0b4gt0GOKAwIvUjxk?=
 =?us-ascii?Q?Hj4ZbqayvCn8ZzymGgv5lIm962b6sqTXIPDOfXz1Gdz7gZOYbJDsU15IrdVR?=
 =?us-ascii?Q?2qnn8eEG32S0yHwe+FxVbBvqD7F3VMg7lDmekfxvlsHYCQmmHjERffvaFOi4?=
 =?us-ascii?Q?ySOokeOy1jEmK6u67GN8Bf20i76zuOTN2EHaa3J975LrqjPkMQLV1MNne1+v?=
 =?us-ascii?Q?FInSnIYz/BLxHvnMJAcZOXsJtRtb0pPcdT7Ynx3M1zYgn07LVVsK4kXtDreU?=
 =?us-ascii?Q?29gonT71XVCVYhnBZe61Jk5Cufe5Mu3YevWUDERpDrrujE6tS4I+7SFmUK0d?=
 =?us-ascii?Q?vKxwsEt3RBUNspH9S3beEKCvyuWUcqfPvGdmI+VAPY466+ZhJknF4kuUdhXn?=
 =?us-ascii?Q?LOz1VmQu++oRlaNDxXD4fvT3lX7R5zcUPBsKwEmEdyJe1DZuQZx2TokhoYF0?=
 =?us-ascii?Q?eeolFL3aoLCMJnhii15hJpcx9IDVRbAna952gYBWiAlUDf2BwUtUze6A0Jce?=
 =?us-ascii?Q?DYGPWbX8Raj/ChBZsSHYW7ZDje+qn0qJWq6ecGReCOGk9Rf3O+fRIVReQm7I?=
 =?us-ascii?Q?Zg0IhdyxuoSWvZwI2Kk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:29.9971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6334fb6-45f1-41d1-0472-08de078fe2d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

To make sure that configuration for host (v1) and guest (v2) page tables
are valid before allocate nested domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/nested.c          | 41 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9374e6f7a19d..a68b5c2fc0a2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -418,6 +418,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_MODE_MASK	GENMASK_ULL(11, 9)
+#define DTE_HOST_TRP	GENMASK_ULL(51, 12)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 0ab5d65ec283..3307c925d3c1 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -17,6 +17,43 @@ static inline struct nested_domain *to_ndomain(struct iommu_domain *dom)
 	return container_of(dom, struct nested_domain, domain);
 }
 
+static int validate_gdte_nested(struct iommu_hwpt_amd_guest *gdte)
+{
+	u32 gpt_level = FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->dte[2]);
+
+	/* Must be zero: Mode, Host-TPR */
+	if (FIELD_GET(DTE_MODE_MASK, gdte->dte[0]) != 0 ||
+	    FIELD_GET(DTE_HOST_TRP, gdte->dte[0]) != 0)
+		return -EINVAL;
+
+	/* Must be non-zero: V, GIOV, GV, GCR3 TRP */
+	if (FIELD_GET(DTE_FLAG_V, gdte->dte[0]) == 0 ||
+	    FIELD_GET(DTE_FLAG_GIOV, gdte->dte[0]) == 0 ||
+	    FIELD_GET(DTE_FLAG_GV, gdte->dte[0]) == 0 ||
+	    (FIELD_GET(DTE_GCR3_14_12, gdte->dte[0]) == 0 &&
+	     FIELD_GET(DTE_GCR3_30_15, gdte->dte[1]) == 0 &&
+	     FIELD_GET(DTE_GCR3_51_31, gdte->dte[1]) == 0))
+		return -EINVAL;
+
+	/* Valid Guest Paging Mode values are 0 and 1 */
+	if (gpt_level != 0 && gpt_level != 1)
+		return -EINVAL;
+
+	/* GLX = 3 is reserved */
+	if (FIELD_GET(DTE_GLX, gdte->dte[0]) == 3)
+		return -EINVAL;
+
+	/*
+	 * We need to check host capability before setting
+	 * the Guest Paging Mode
+	 */
+	if (gpt_level == GUEST_PGTABLE_5_LEVEL &&
+	    amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 /*
  * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
  * during the call to struct iommu_ops.viommu_init().
@@ -38,6 +75,10 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = validate_gdte_nested(&gdte);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
 	if (!ndom)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1

