Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFB2673B9
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481127; cv=fail; b=YhUne1zAikvhQdkocVOYxO1xm7yYUA7UyG6/z00LcDf0wYnx21Ac7a8RFyYNZBtHXtdZSr2S1eo6MHJWUCe7J1ZuDKoUTMAjrrwPRxLvEr8FCDvmTlC0AvAEO/KvD1ZTY5KpPQeFG14XUkQbEedFw+WKkWuxyRCIQnUIve5PMB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481127; c=relaxed/simple;
	bh=ji69ZFI27IFduBC1KnF9/7Ai+WF7kOtz+eMJuWLDJyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcIpahes+0/xpgRsQRcRLyaLuqgqwXsLaC8Xt5c3i8NtsljYSMReK/cSjPFI0lQweGNffoNlfTlk8St7LlhReinKqHZBIk30TnJosiPPF1GiGrFEOp4OsP9nXE2sBvkmvFueVHBZS38EF8VtL56PRyquTyrp72G6Mg4CpJBxlFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dXCC0Ajm; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dXCC0Ajm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDaHqPMDf4JZ8poVEXxBAXAwM7fuODBbUBuMzcyFvHt7kbxZ/7HSv2wg51wVCalWYUosGJOZd4n3jnW08LZygee3Tv59CIWKsusoB2pDLtrFBJGwm39Bhi+xsdnFiUC5Ly+G/WomJ2p37hlkodavd51IxEmATUTaNr1ypUJfCke7hDWhOp98TaS6F02nTN1toWHh1/VFpcBpb68vLQ9s/KWvpP5fQyOucSCj0n2dNu8FFnEE3rLqRCw6GRlP0BUOxJom0BZb7/psko5rOcuMIZDkce7WyWVmfHghfcjOaFzKssvd1Gc8ZmZCYKprvy2kHX/qC9bhamOCytUKpX1rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUTFbwhXKiXX4m4T/3E0tw4HJm+Ui6pWshS3RRaKy28=;
 b=e3dX1Xjwc7kflRUOtnP3jk7wuu2mPJSXWX8OzZ9/ThSAkSkKyrbP30nQOi4CjFhE2MAwOpbelq21UI6G9RxRp9YX9+TK9XycJQ1npVGhwhvzMCSLsPqyotq9d9tqZ418zF8Nkz97djGcTyEmisSc/CiVZCfCja+ipemjNGuSR70ZUvFt+2OykrzKZEIL13mb/Gso1l6gKW4ntcpGZplP+Cl/o3PW5ViVKtlyQVYFhH95D+Cpt3HgFCLJGlTTuIgl025sJg9wX+c4KolyervMUh9ID5c0cDuIe+ZKLiVkz147ujKRBtbRvIv/fvfBsTF84CSt+jk+AQzT68V4ikVPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUTFbwhXKiXX4m4T/3E0tw4HJm+Ui6pWshS3RRaKy28=;
 b=dXCC0AjmiZ+nqpX5kxRdxbPsqsY7ntGcJuNN07qK2dEWk7WqjZLUreSqs6mbfssKtScgOyRRVU9L0lSH6Hxmcu3BFZ2e+zAkmwqorrpCnEEcGd+SV2DZkpwox+QbfXHn2Ung4/jnyoNQJ8mXg90smnBNu9IWf5pWZjhC2po/NUo=
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 10:58:41 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::f6) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 10:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:58:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:58:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Add Secure ATS support
Date: Tue, 25 Feb 2025 10:58:29 +0000
Message-ID: <20250225105829.52223-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: a01aa472-e44e-4e22-14f7-08dd558b5d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTCA6nZOi2UNzP9YKUwSVEnDifK38d0q2VAu7oNLM3nJrxMEuzH+bH9Hxcpq?=
 =?us-ascii?Q?MdVrOINM7+JlzM6mmmuWm1ejVxuaYbYyJl9uYgRgepz72ech6RxePvB+d/l+?=
 =?us-ascii?Q?7SypBy35WpycaYr5ZH9p+8lgGjCuEQFRNnJfHpLj3xjRM3d1BvjcdXhJtF6L?=
 =?us-ascii?Q?oKLaoNEl3ds87wY/wFWnq6vhlvuaRxwXB5u+MtEf3Y3MvqgUkSkoaZImUcL9?=
 =?us-ascii?Q?nUfUNwazDl1J1XhK02iVug33aMKaDF4u6QWJIV9fv3mggyvVmRsEJOHOKaQR?=
 =?us-ascii?Q?NrPTgbxkjQot9ydgtQRdWq9ukkTLZjpecnvqq6k94JlFZH94c05kH88H3r17?=
 =?us-ascii?Q?X+1sPh3/N/Sig4iqE6qngIAJi1mg3aHTXnJwkhtdOkb9r87vtI60FV4k5mtm?=
 =?us-ascii?Q?kWCiHbHjq7CFPH3vuP3XymAYVt0aj0PX4p7i8/Vk2gQqIktGvNP2DX5SoPwu?=
 =?us-ascii?Q?8ydzixG4RMSjyzJgxtHBhBU1BTuqoosmgRdp7R5sTwwo7kJGgi0vdpA3xOlh?=
 =?us-ascii?Q?OeHuu5tDY2V1NNXUwEs2RRHAm+v4gcWOPq1uNBPwY73hX/VpsyrdJpvby0oE?=
 =?us-ascii?Q?2X1teZr1V5p7Dpv/WZPvQlGlEfcwSlUup9gHHzeYm7g27qwNVVWk0+230wYC?=
 =?us-ascii?Q?/33fXxDt524U85/NP5Vh8SQysmj71iXlCk3xlyRvTi6HKjVhNJYyasA1F5T4?=
 =?us-ascii?Q?1KnrLmhLauPrbYZN7+yVsnOteaS9lavPWG5cej19NikKRLAcQTQ2vKjGXfBJ?=
 =?us-ascii?Q?IBijvbv1BftOd5OTsL6qSKDlbMT1VdqYQVUynebX0V3mcNdb8WPVRNGIlvp9?=
 =?us-ascii?Q?GGC1dmpF50GMBv+u0Jg5wp8mIC05IyggdMV4YgwORgmbt2jToSQq5YcweoFH?=
 =?us-ascii?Q?HImyDkUljEelhfZzZ1tD8/BM8NIlHqs09d2dY2cLUcQ0wz2cu0N14IteyG1b?=
 =?us-ascii?Q?d3ujESNot7tj7RITpJDHSb9xzVeSa73c7w6Q5czaDjlqpcvTT4zp9USL7N2X?=
 =?us-ascii?Q?xZemWTorKqITQnD2gHgotGdNqELybRqo6jnK5kXnXodGPiAxZHac+IIvVB/G?=
 =?us-ascii?Q?FNOCvNU4l1xPcmz+gAoN262bhUShRB7+XlTXP/pSuWgbbQKu11Ii9O/Re2Pv?=
 =?us-ascii?Q?b+PlI1OFVcaqyO0HG+mDJa/b63CBsYjlKhpJVrDvhb6PUYwXj7kR7HupMp/h?=
 =?us-ascii?Q?XYmdw5H1KI5jmjECwbZk8oi7KJ4BCBCgQtB0j17FkkVt+Cg/r+SFK/a6d8wH?=
 =?us-ascii?Q?3fXNO+VLZUgdWS8eYkHwohUDLBl5EtEVrm38apA+6IwiT5J9thk3pDgYqVxr?=
 =?us-ascii?Q?ouKn4NJKJst1k9goVL945o8YbSQWp6sqwPa1ipl6/1EdPCEX7udyIOPPkj3E?=
 =?us-ascii?Q?tolRhH28zFhs+ysr2SV4RqShJhTQo+yCJXLbRswND87Ily3fuAT/1QDojhcj?=
 =?us-ascii?Q?zyzWGUjnLpXNPVu4yY1Z/48kNtuhaikoUyOHTbMeYGJVTo6cWCh568fWErtC?=
 =?us-ascii?Q?3377XHWqvW0Wo89CvIJzMLZAPWiXtU5Cs4Tm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:58:41.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01aa472-e44e-4e22-14f7-08dd558b5d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488

AMD IOMMU supports processing ATS requests as Secure ATS requests when IOTLB
is supported and enabled (See section "2.11 Secure ATS Supports" in AMD IOMMU
spec [1] for more detail).

With Secure ATS, for ATS requests IOMMU return GPA to device instead of SPA.
When receiving Translated DMA from a device the IOMMU performs in-line
GPA to SPA translation. This ensures that any malicious devices or
vulnerable IOTLB implementations do not have access to the full SPA
space even if they can generate Translated DMA with arbitrary addresses.
This provides security against untrusted devices.

Introduce new command line parameter (amd_iommu=sats) to enable Secure
ATS. This can be used to provide security against untrusted device ATS.
Also enable Secure ATS when SNP is enabled.

[1] https://www.amd.com/en/support/tech-docs/amd-io-virtualization-technology-iommu-specification

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 17 +++++++++++++++++
 drivers/iommu/amd/iommu.c           | 11 ++++++++++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 68debf5ee2d7..b9a6f5844e50 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -43,6 +43,7 @@ extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
+extern bool amd_iommu_sats;
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..bffb6ebb3d3e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -99,6 +99,7 @@
 #define FEATURE_GATS		GENMASK_ULL(13, 12)
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
+#define FEATURE_SATSSUP		BIT_ULL(31)
 #define FEATURE_PASMAX		GENMASK_ULL(36, 32)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
@@ -417,6 +418,7 @@
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DEV_DOMID_MASK	0xffffULL
+#define DTE_FLAG_SATS	BIT_ULL(42)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..9b28c1fd32bf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -156,6 +156,9 @@ enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+/* Secure ATS support */
+bool amd_iommu_sats;
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
@@ -3093,6 +3096,15 @@ static int __init early_amd_iommu_init(void)
 		}
 	}
 
+	/* Secure ATS supported when DTE[mode] != 0 */
+	if (amd_iommu_sats) {
+		if (!check_feature(FEATURE_SATSSUP) ||
+		    (amd_iommu_pgtable != PD_MODE_V1)) {
+			pr_info("Secure ATS is not supported");
+			amd_iommu_sats = false;
+		}
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
@@ -3231,6 +3243,9 @@ static __init void iommu_snp_enable(void)
 		goto disable_snp;
 	}
 
+	if (check_feature(FEATURE_SATSSUP))
+		amd_iommu_sats = true;
+
 	pr_info("IOMMU SNP support enabled.\n");
 	return;
 
@@ -3526,6 +3541,8 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "sats", 4) == 0) {
+			amd_iommu_sats = true;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..c7c9b5112828 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2064,9 +2064,18 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (domain->dirty_tracking)
 		new.data[0] |= DTE_FLAG_HAD;
 
-	if (dev_data->ats_enabled)
+	if (dev_data->ats_enabled) {
 		new.data[1] |= DTE_FLAG_IOTLB;
 
+		/* Secure ATS is supported when DTE[mode] != 0 */
+		if (amd_iommu_sats && domain->iop.mode != PAGE_MODE_NONE)
+			new.data[1] |= DTE_FLAG_SATS;
+		else if (amd_iommu_sats) {
+			pr_devel("Secure ATS not enabled for dev 0x%x as "
+				 "DTE[mode]=0\n", dev_data->devid);
+		}
+	}
+
 	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
 	new.data[1] |= domid;
 
-- 
2.31.1

