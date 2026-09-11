Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D53EFFC3
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115682; cv=fail; b=U31IWMiSuZ8L6JTDMD/uXLhezLS4pNwt2CxvgFOFjJFkuZmjcsCyzKjFCII4VHCAYf/81HViZoW8WlefdFwRP5KSgQsQZpvion5ef27a4OUhuCwfVMdSuKNxfmJrv0io57ZsVSh4OdxVMBtO4YHI6081DiCq67oJpi73i/Zki28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115682; c=relaxed/simple;
	bh=RPu1JgEgxs/DLrZALp8ClwI7j730EutgKaI3SLxOVUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ea1RbLbECUsFuMELNUywyohpP1vw3HjC+il7ncXEx/rnhDjupgUsaZyDsCLt55vjxy/21ku8wKh3movtREUIn/Dcs5O8BjaRtDKGLN4Eva8N8K6j2v7z/VmME0kx0rwSp3Pbu/scGpk3V/ZEX0hnGeTfKK2q726PqDnsG+d2ZXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rr24l6G/; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rr24l6G/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V75DsWTgiA68FlgSDzX25d8KNzJfVeQagOwTTVYXFs56aki/QqzPBaRV3Zf7feT23XcLdQ4m9QhUnbB0CJxab/yIwUIBa8/A1WBs4c1SUMccdeUp3YiAd7bf22Er9xHijXZgCwfZg+3GldMXXOdKzS8D4vT2MsHhvonawfzgwXwM5F3iEbjrmkOrZbo586QBY1T4lf4i2aI7DGtDCcVpKxx4p7B2YS0hzol6uTzBaC67kzaqUvgQVrkcGYwDAOfip9QhuGpNelnXPdnlf/Qu8Dd1Ikhv862kPpmlgA8GWTB5m6uZncgC4T2QbfwUgpw1X+w0PhGj9a6uBu3x1SiwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxU2oAy+opL1kbzyRwbq/patte4Dtt06jvnabTasC3I=;
 b=CP1L4xa30nS7pXc6YxQY1krU2e9JmCl85TDIbZCGEhCHZJdzv36q+JFXQuDF/Mwtu3KveBbczVq2XtoEeysvx8x7sP/7ao0HQEAp0hurAUznAhr+gYypc7qo8YUdRDQU6gUBEN0/TG873gsWxL05H4TIvZ+Ot68s3rE13t6geFVshHwhzLU6NVhP02dKCw3qeG66gJvBMXf+UNGji6tlqZyTIu8GhwqKZ970+2K8oo4rDQZA9QzPOids1/Fiq8aLxx1Ahc35mG2/Ftf7/F0g+1Xyu7drcx6US8V6zFuEyC3+ebTastK4Vz+/+RQjAwRivtJG+Rn963CbOGbomJPZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxU2oAy+opL1kbzyRwbq/patte4Dtt06jvnabTasC3I=;
 b=Rr24l6G/W1utfkwzqUAGyYodoT7kUnUE9R3EO3rQcOOejzIjfSZod73YVJC+EuLtStaoQfWhYV+FU9tDvrm00+Pc9TTVzb31HIJ8e2gGtZCQP4a71d4JdfapDltYvgKwNd19ZTbja2eVJSZXBMV+bchh0j7+oBrQsjfuBOeXYzE=
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 08:34:32 +0000
Received: from BN3PEPF00022BD6.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::77) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Fri,
 11 Sep 2026 08:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD6.mail.protection.outlook.com (10.167.248.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:34:31 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:34:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/4] iommu/amd: Make iommu_sva_set_dev_pasid as static
Date: Fri, 11 Sep 2026 08:33:50 +0000
Message-ID: <20260911083353.4812-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>
References: <20260911083353.4812-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD6:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 73697640-183a-46af-67bc-08df0fdf803d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	RKB7AxQilTuwGniFjV8UFv6DyKQeLIRF11/RnOiEmU0P7puvIPA4+EI7hegFgITP9+7yCVL5WFdulPsFjymt3KnP8RdaXs7Q2GT9SQdzCCBWo5iw6x7VoXVdPtIhvI3a/RLX8pEq/+btIDCp26SNLCTbLDlWP3ZLhVpy+eBS/UI1p8lP54b1aJ2LD97RxEwC7xcVCPX42MvBefQF3/JNE/xdpzKdpCCEPQ9kn2V1Ned8IkteFzA7oIz9RzhYRauvesUuRYTnvJW550y/CBZdkMBy23wohiTW9Q8HLR4lyhzOE8JFnA5ZRSHPxf4AyKfYjnogLlf9Q/kyCIKVLH0dcn0s7Ba7wg1XMcZlTy0PwjdqBlyqOVkd6OesxB7Seh3cGL+0YvM/LMqpaBdGa+aw8G0Q4/jekC4DcgTfP/i48rAiRIXrQwKZHv5I284qeC+yMKBr1+GsDgGY4HPcPBOIZ94IGxXnb2NmAgkcu+8vtDVmbeYVnCIsH0XjqbJ+Gn5rxmXFmIZqAG6fOaDAGRH6DYqso/MM6SYN47SCDNHa/1Iudf9Qar8sw2FqLHZ2LGKDNWGB9/l5ZncMxrp4rb/6VU0OWx6HuB5329F0mFBwYYFwhkQmQOvWvrDud7iDuFy/KEtKzS3ErV+TBetVjR/aO5a5/HB+b6fFzXfmBEXY3ymIssFTOwP6JvAYYFvq7BwZtpU+HLncTsoqiepn5xKy7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H6xFzrWkCZM+V64rEEYqgf8jlclaMMTqLNiuig0cWSAyRLRMLLigGhCda/6N/eK+g2l0KP6fyTo4UYd1KJoEluXsJEzs76s2XfzzJAkMYZnUaGZoLiXwBxiPMM3D7fcUmyN9Ra/h+EpO9Wu5fzoDZsv6YqqZRebo2HGVbeK4FL/rsnbD6CB7IwxjZoT4c+SKTtmLM20dqTN8Yhsi5y6QzsFsgLPviuHTV6ciOusFUjEvZ1dHRtqA7OJQTsGIL11ZraNqfGKRQcXIyivGS2VDVHkj449S4W81lRaFcG8glW2GdxJ88B3CxnndwadlAXZC9lzVy51PIdQUJY+P3duhRNop+CtlUpQmtYtG3HxQREAzXfchXaXRTTSVhIIu1ikVyW6v0C/yKpGoWUMxohA7SdWfQrC1EIEpJrB6HaJ6ixn4tgFbhg2gjyLRy7lrEWM2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:34:31.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73697640-183a-46af-67bc-08df0fdf803d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

Its used inside pasid.c only.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 3 ---
 drivers/iommu/amd/pasid.c     | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a2fe804b038b..71113e860859 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -54,9 +54,6 @@ struct protection_domain *protection_domain_alloc(void);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
-int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid,
-			    struct iommu_domain *old);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain);
 
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index d708c6532480..40be5902087c 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -99,9 +99,9 @@ static const struct mmu_notifier_ops sva_mn = {
 	.release = sva_mn_release,
 };
 
-int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid,
-			    struct iommu_domain *old)
+static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom = to_pdomain(domain);
-- 
2.31.1

