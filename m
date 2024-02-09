Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF152C6A7
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478233; cv=fail; b=CMkVJQp4j51HsCEcFeJZjkX7v9r1fcU0FAetoARlPGziAhrLRfrKuQKnQwpROlJD9GISZbyHufIBxeSsI/mWI6Z5O7JX5MFdPnJJFD0vpYRIuIACBg5E/0MzPxtp059GFK9jbYxjcE5XiW9uYz/PGm0n+lz9NJMN1hL8uv4PmII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478233; c=relaxed/simple;
	bh=K+vPyhA3t6QEs14uh/21zk1eoopDq2IiLf61DDeZo1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+QbzzhO5B+HtyHfdt9p//1GAxb+wE+bKBltG1pFaAuiU9EQv0ZTzhkxs3Dnao9zbNXNxsdovBmcoZu0bAnB0Lka08PbcZzuBZd6iPXwSnhAm+B4gfM+k7FR7I9TUSLviNm9pZhMgkQ+KmWU0vw6jOWbvs2003CwPzMr6wgHm6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbaVF9Oe; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbaVF9Oe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StZTc5E5X55fGViipcodJS2gF9nqxxwOv9mtMhegKwT14vsEQ6CyCoFr3Z4lEOTKz4v+8nJfaAcwuOYE7cBlft+oOqOS+BY87t4jJy84np8v7xiXsihHRG5TiCmD9VtVEUs30T60iSITrDQM26sYi0DH1qtawlx6d7Muheg1vRqNqL+7POCTaw4zINztrJGhfL/NdYpstEG4jYqNze6Tw2vFsZObZP8GIHfMf2Wa96iD2W/CJHdBPRoqe7631AqwLx9trApKSmAQ5z3yG6XJJYGonGZDRSGJ6Torf1XMEhVAZ5OpW5Blp5Rav51jhREttLWfn1bhQpnNvOfnEk6rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFImqmbU5DNz6jU1oyEtCC3B4s2JWEJTNCj/loCgIEs=;
 b=fC8KFs8PugX32iYvJblzBdkfr4NNcbL/TqdsKjiVXGyMk5i1zxRxZKNwGvYGTRo0oSHceRbueOLwU5cbq0pkrKdVjsJad0Jvj3hhiWEQFmDKymHsXsTtzPCw2X+bcXY74gxwzPUBh/lNrKUO5/BB6ax/CHh5mBkPfu4H6D2pDHI57g6hOXSYbPQi/jq8Gt1uZZu0OBLGQa9xXYRaap3xxHTvRj5FaIYmZC/G4QzFmgCSCn17U36b1p3KDsFBE87lrE8C6ggjFrmdDwN2gLam7y1u3ZEf5xiQ5If7q+QuzKIILr5lPA0oadDSqx7colFtOLjCk8rjyMr+nnmeP30lpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFImqmbU5DNz6jU1oyEtCC3B4s2JWEJTNCj/loCgIEs=;
 b=fbaVF9OeqvnuhNGEPiPLIUvLR8FaGw/KJ2cYCO54g90fVzhJZ1aJSdSu8zxppfvk8i4V5YMHDE3kzQhEnnMNLPllxiqsVVeQJ5C8xrjBLsbl6SRbOQu0Li1hpyNB2Bkd1kCk+9d8UKR2HxpwwPMshL6CuLJCBKXnqdGPIiW4e3c=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 11:30:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::8d) by DM6PR03CA0029.outlook.office365.com
 (2603:10b6:5:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.45 via Frontend
 Transport; Fri, 9 Feb 2024 11:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:30:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:30:23 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 02/15] iommu/amd: Introduce per device DTE update function
Date: Fri, 9 Feb 2024 11:29:17 +0000
Message-ID: <20240209112930.63663-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1329c7a8-0810-43ab-a8d6-08dc2962837d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxgID2ukvgJ0fwXcvAGERf415wi22Zh5ZsmXHW8+OhzRxyatRq0Lh4JTM28MEaKpWfQYlUAInTR0+Re8avX+Dwk8HbPECpBGwAE3VExgyeYjnUTkHrMt/MncaecabPhVyrcA29HU3WT4EpqOKU2RJ2VkdRhNOM+9sGNWSFsX7NR5LICd/qDB/b2DuMLdfQCbE/oOKZvaFRuZQ/tRVD7mIosjftsOmeAZwBLsCvJlvkDJss4idRa8kunhsbOO1joYec+a/qTgrhclyjUYWrh+hUxMAEuJCLRlTddASW+nwwKglTR2K7+MSuh7RtVPoqdTT27e/F06G4G3+gSCjg9V/H+JaEcmWEzlpkSp/N7n+L5e24+kpNnLGa3DSWzV+nL8FUnracWooBnqvyzI886RN9vQPHZee8R9Lp6QX/T2BKgEmohZpPw7cjL27t0wrytcHr4Q6XV5kVJrdI0yGXG184CWz1XfZD+shw4MW9O2DxFFeEU+/xLMfoNglcYn9VJxxliBPmADuZL2ObQ6aAovRGi7fwnF1BXz0pSYOIMzrRXANQyioGNA1Akhggoe+QFaotfgDYOVymy9rUwbEw1plTx8BL6SEjd2QiMeFoYzd5M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(86362001)(356005)(81166007)(82740400003)(41300700001)(15650500001)(2906002)(26005)(2616005)(1076003)(16526019)(336012)(316002)(426003)(6666004)(83380400001)(7696005)(478600001)(36756003)(5660300002)(8676002)(4326008)(8936002)(110136005)(70206006)(70586007)(54906003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:30:26.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1329c7a8-0810-43ab-a8d6-08dc2962837d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

Consolidate per device update and flush logic into separate function.
Also make it as global function as it will be used in subsequent series
to update the DTE.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 334394d14753..24a04731ac8b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -64,6 +64,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1769f3860ea7..ed8245e66098 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2003,6 +2003,21 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
+/* Update and flush DTE for the given device */
+void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (set)
+		set_dte_entry(iommu, dev_data);
+	else
+		clear_dte_entry(iommu, dev_data->devid);
+
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2037,10 +2052,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data);
-	clone_aliases(iommu, dev_data->dev);
-
-	device_flush_dte(dev_data);
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
@@ -2059,11 +2071,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(iommu, dev_data->devid);
-	clone_aliases(iommu, dev_data->dev);
 
-	/* Flush the DTE entry */
-	device_flush_dte(dev_data);
+	/* Clear DTE and flush the entry */
+	amd_iommu_dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_all(domain);
-- 
2.31.1

