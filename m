Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3215FA89
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436577; cv=fail; b=Tu8mCxeyTHBhjGMDc6GbZ02r5dhCSgkx0bWLDkTrmG2NvfNvCWmcfrmyWJGo5XW2AjQ4AnDeHEs3w78xg1eWkAXzFVTcoGp+OUsT23kIy13zF1gMPP6XFssCHk7knHgsBxgjBLUd5pWt6iMyhbXzZNfmMcII5jDCdZ2leZdTQEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436577; c=relaxed/simple;
	bh=NCuet1iTudXWmL3qmFh3QtDt+rdaYvXXgY2COF8rau0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX8Hf4CZ1uEBqz8rnKneEroxZcSjS1m2gZuJ/k1kq+MlyMbaneSX1S2xMOmJrMDC1ZrOuFuv3aYxEq34p2keLIi+JpRItmklfBg0oaOv/jsX9LpEtLf6j3WcbqBaJHgzGbI1JVASp46ZLa5gqn0u6J3o8yxtfz8kmcMcwpHy1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBbWtdWj; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBbWtdWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfwuRzk2J1LbEauzpqy13/hivIWFF+13P394l1g6wmeuVMSs1a1WntEO/i7hs9V/71uer3xdsmFCHk/1HLL+/sFIwkeaWBWrHMleGU2RX8NiSA+E/0ku82t3ImkjwcEyFTwO4VAFCXUcc3evGattl40QLgT99XJxRbztHin5YwLBIBkvcJQl80z8PigAVPnc9V/rtE4VmxPDjYxTlkieODXPvo98oDTUSqNPPHMW6GMzusZWGAJXmUGK+CYgGNh51+0ozYBjXrIoOo1/D450SjDRiH2lmKXw9gkabc9swhvQDvexMG/dcSfr5GBZWHv0gF6Ir8gJH0skaY3I3G6TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX9teEzMBB5BLCbyIOsklHBFogIJwAwPSUVdIScGhj8=;
 b=oYp+DdZ/6d9kndyT8a0CZf/ijzianqTzktYrGnFkAKSw9xkoeDP6KPZzDDBxnOWczizHb7l3kDQVzY7nKtF9La/+q5jYT9opacLi2NfIq3ZecZbPVpNpAWqFZWOuwykeGDIsDYtPZZqng+bkgqLh+xW0R58U4M8XxpKSodk4fAHPxwVq1y5+EAolP2zDZitAepfpsiL8eBjgG1SvcprC6T+78/FfkAIGQ1VsKqXL5X0Cid/QfCmTq/suhxHK4vn75dRYcEBDZ1eM/Ds6f9zOWz8yn3aIpcCM2S31HyHLcSBnuoz8CC3aWE0YTo20L/bcYxZdYuWwyFp7BrFBJnrlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX9teEzMBB5BLCbyIOsklHBFogIJwAwPSUVdIScGhj8=;
 b=EBbWtdWjFO5vFp9i/biEO+8kMiJB38z87IN1CfVELO1GeonN8yMvEoFKFFDZq45P3ZYBxKEGpQUhxX5JcOjisFuRu6tcpjUY4Gi8ng87TRMQgBI2ynxtgXqDykoBy149Du5DL3g2J/tpB7/e3e0m4oC7zt1OSeohzEJ1OuNbKIY=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 10:36:12 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::2a) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:36:09 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if domain is SVA capable
Date: Thu, 18 Apr 2024 10:33:52 +0000
Message-ID: <20240418103400.6229-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 23575069-9621-4b1d-0f94-08dc5f935e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbA9aoT+Jb9I567KfFrMTFKGkK4iE1iCNCv0G47c6tYRssF4GYZEJCB+EnVccBN3L5cMrionH0L0RQbCaux0zA/wbrSK6/5lJ5VJ/jiIXr+YH5UVIF/IpluOrcrpk08wMS6iVbAvgnwVrwqRV19D+rqC1ZV8cNm/X056EZ9elRaj0IAEFT+OoRZ1srQFFmtWS0QSRkqnd3hmmF3ISXI28QLzLY562/25vSXix0o0LMsbDYKQr6inR9P7sBEzZeEJESDgEbdOCdSLs0Ic6JukxrMUxN5oVojkhuElVgDXyhrTf5VUh5t0IeA6xkvWZkcHhmV+1XCVHQLKPFONbNdj9EWntjZoJkv6oJAV8NTkDDxKm2ABkBirwfLrD7HLwHYO4aTOrtbp/zeemrynjCcSaCxmZwediDcswGq95n/xA+1Pae2MsekODLRkx41z7sHjglMYt71CxaMTNVSWiIHyyMFINcLrjM3Pz2hcuCxqn/s7qMv8ApOKjr6p4zWt6QVHymgG+CbTZXtXebFAvuntxMq0kViEAy3SRGnrd3MHPKgDbYiKdxtgRWNEpav0ztrCu7oMN8jCsOvNSRwtom3/WplEENRvQFXASuokR/Ox0nytyJ2Ps0/eb5FI0Ef0E5zq1XCJsRuulN37WxBuZJd0gAYa8jGGjINJmEWmlRUKPZzfK7SiDuzTgDp6xM+pPZ7HJH9P+lcKUO+wfvQcWgltQdb8pxNqOXid7NwqEBlfpyKM5ZLP8JsizbPSIDqby/ht
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:12.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23575069-9621-4b1d-0f94-08dc5f935e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163

SVA can be supported if domain is in passthrough mode or paging domain
with v2 page table. Current code sets up GCR3 table for domain with v2
page table only. Setup GCR3 table for all SVA capable domains.

  - Move GCR3 init/destroy to separate function.

  - Change default GCR3 table to use MAX supported PASIDs. Ideally it
    should use 1 level PASID table as its using PASID zero only. But we
    don't have support to extend PASID table yet. We will fix this later.

  - When domain is configured with passthrough mode, allocate default GCR3
    table only if device is SVA capable.

Note that in attach_device() path it will not know whether device will use
SVA or not. If device is attached to passthrough domain and if it doesn't
use SVA then GCR3 table will never be used. We will endup wasting memory
allocated for GCR3 table. This is done to avoid DTE update when
attaching PASID to device.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7daf6d75d964..288cf7485306 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -89,6 +89,21 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
+static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
+/*
+ * We cannot support PASID w/ existing v1 page table in the same domain
+ * since it will be nested. However, existing domain w/ v2 page table
+ * or passthrough mode can be used for PASID.
+ */
+static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
+{
+	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1964,6 +1979,58 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	iommu_completion_wait(iommu);
 }
 
+/*
+ * If domain is SVA capable then initialize GCR3 table. Also if domain is
+ * in v2 page table mode then update GCR3[0].
+ */
+static int init_gcr3_table(struct iommu_dev_data *dev_data,
+			   struct protection_domain *pdom)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int max_pasids = dev_data->max_pasids;
+	int ret = 0;
+
+	 /*
+	  * If domain is in pt mode then setup GCR3 table only if device
+	  * is PASID capable
+	  */
+	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
+		return ret;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * supported by the device/IOMMU.
+	 */
+	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
+			       max_pasids > 0 ?  max_pasids : 1);
+	if (ret)
+		return ret;
+
+	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
+	if (!pdom_is_v2_pgtbl_mode(pdom))
+		return ret;
+
+	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	if (ret)
+		free_gcr3_table(&dev_data->gcr3_info);
+
+	return ret;
+}
+
+static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
+			       struct protection_domain *pdom)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	if (pdom_is_v2_pgtbl_mode(pdom))
+		update_gcr3(dev_data, 0, 0, false);
+
+	if (gcr3_info->gcr3_tbl == NULL)
+		return;
+
+	free_gcr3_table(gcr3_info);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -1982,19 +2049,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Init GCR3 table and update device table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
+	if (pdom_is_sva_capable(domain)) {
+		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
-
-		ret = update_gcr3(dev_data, 0,
-				  iommu_virt_to_phys(domain->iop.pgd), true);
-		if (ret) {
-			free_gcr3_table(&dev_data->gcr3_info);
-			return ret;
-		}
 	}
 
 	/* Update device table */
@@ -2009,10 +2067,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Clear GCR3 table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(&dev_data->gcr3_info);
-	}
+	if (pdom_is_sva_capable(domain))
+		destroy_gcr3_table(dev_data, domain);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
-- 
2.31.1

