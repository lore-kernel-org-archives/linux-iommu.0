Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F222417BC1
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159068; cv=fail; b=MR6QIIK+A3+lFImoSEldMGifLYtVymA6YtZ5oszH8Jr9UYJiVU3NN6JjZO5/AspesgTsvZCc3955vbVOUDAxQnbb5WbLjj0iOOHCFZrfZvlRrSvIlFzl//nE8lS51bdkvXS2uqfIUVtLpVB9xDK14egpfVLiW+km4I/MS9ZFNMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159068; c=relaxed/simple;
	bh=06ot+dgZ8x2waUdztlPNV4ut75CcTy9pr5xtfC8hNHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXN7f0IM3WEnglOyROolc6nLTzStfgZ1ogwhTxhykITDAQTyF4QvSDaezrvnlDwSzUBieIizG0EapWHkfix4gQ3zOmAXKWpwfjLlPrOn+DcZMWERvqQpdvL/2i6elHbHlgl1aNaPVndnV0LGwxp0WybcqyBAVkPBI+qs9HGYVdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbdzGXL6; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbdzGXL6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4EzsgM42ARP5iIn6akYXBoUi2DmaFlpQAxbnLRAehljlzuEnpcPGPk9AUgt+HXxYTONyRbXe5/+caFIs7IYD35FtIrEILvVvgEF+y+0rO4si/uydYBo8xPE2dp9h+qAFXU0Oaieh56pM8bgBG2Rx/xYRgoN3iIdhEfOEP/ftj3U5M2SA+mZcY6BSaFkX+zZDSS8v9l606IpU673gavV9j2x1/c6Tsib5lNwYXCPj8WTT+5+Y2yg8aLN66NZ0ODaSqSV9p+Jhd5HD4kuXRq00bmKh8CFN7k8g9H1ZcG9bUaWxV32ytrHO5hiIG/T/sRyynl7O/D1PFB915cGtazL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zaRpmVedG2qLCg+68YMnmZcBvGUZ3PpSpUwmcAEV4c=;
 b=QB3x5TGeo158ynGMRJdPZ+TpeFv0QMF4YNSMC0vIHNqQ8Vr0gz95W24Sk8KxBHWamV8otDHpahXhORxCY30FRyApB+0RlR2jGsXxFwxRvFp9fVNp0kvKnC6dKRIRbNyQ9BqRn2oMTfd4YZPPCg0TLujqaib6jpDPGKdnmIfiFMQb1dE8wYAC9zGu+AaQibAvB5ZRiT3dAa3Y/aF6t6pbOiRJztuFxpy01oxG1NKsVTosf1ks1R5s/wkYNYK3OcoHyip1AjO+PlJvAFDBgvg8tXR+6QA5fWT/xl0mSvxy4ZRoRUMoAKxwtvsPGo4xjePstIZpWEp4LO4LpR4x0dblhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zaRpmVedG2qLCg+68YMnmZcBvGUZ3PpSpUwmcAEV4c=;
 b=FbdzGXL6ybIr0eZ561xToSYHup8r4C20UqPyxQaCLM7ryoAaAXbt+E/zQ7+Z43FP8aTF5gym6PsFmO8h9lll/a+G9LiOUHFL74qfWotPQ79tZcb4sF0GR/0jcwDfgSFOAkvE+M/kTNU3JgCGadIWXchDgRvQAQcmRfk8Vopxdco=
Received: from SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::26)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:00 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6) by SA1P222CA0178.outlook.office365.com
 (2603:10b6:806:3c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:54 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 10/24] iommu/amd: Pass iommu to device_flush_dte()
Date: Mon, 27 Jul 2026 13:28:59 +0000
Message-ID: <20260727132913.22475-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e315dc0-782d-4bb9-11aa-08deebe34bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wvYxVIy6PqI8BRNPthGxsk0T/NgdRqmuB+l6G2T+L2NF45+89zgq7PyUGBhOdOBVGjW76qDWwMy17vLpSH2KNm83lBTMaXcOPDtFdNn63ZBTMJ+EEFdKur4ZxcxZEMbdnrLIBtXHKV1Mr6p5ZDG10KFgPVvMYs0rFN83EtDcys9Kj8j/sT7G9or+NfnQp+JquD+V8mbLDURXrPRqPZrAk+/N3KmMoRDdYwVTCMpJO91DpMysR9AgYkiqdcZCt/aRmvGir2Nskuu9U+ZVARH7jPd60Hc+htzliZc37434YdJ/dL0pSiOWtrFEr5fYvVmKhez3h2f/iKBMDXMnA/2yn2uTyaFQLf2D8G0RfNgFzPrHvkEB+Rl01NCp/5r0Vyh8vxHwhknxQykm5yK/KegokIlanZ+k9hzGFGH2TOHC5g+a/CUJs/aBTixprFzcjJwcUmsVja5A/yso+qGFZWxYYjQECRYLHZTmABxKyjHzSJGv13LaswcrA70IwUscg1UwbqDcs06vHgFn2t8D6St3zSbr4vpH7A6qfrIaCy/E4MU2QAIai2DoiO8VYRHZOt9MXZD2N1VIb7c6k1IGiEETNhYvbqU+a2C3teKFE1V+S6/kwcW+tu1SYMCZFhF402wQCQcbE/fmuFDbOj98KugZB0rQZgVpPJYnjbTwaKKASZ5zGxx5MbNxMjmvGoWBo3cuhwL3CHTXxdNMMylcRg667w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pOBYFdeyuRK+h2qCTBl5OMP6KqBEMJSqzWBDeP7+1BhKoLyTRLj5JXTx1PQERpeVcRwtHOBA5UpfemoOTOqM1ibvEobcSdjQ9p+7zgmC9yqp9HxVdhC75Jkhx+jjHS1HbPi3SHhwT5PzUfS1fGoxVmrsuH147fxGQiADapflK+0ruy4IDBw+Fp57A1k6xbbScxVRIUDfHulVXFlUV4uOh1z9xrBeweszV/F34mM5IxAikW5HI0/AWnWa0KZno+7w2oLinmnki7grFfnHiaGr68b0MSuTaa2RuY5nWuTEjYZBuCbaxUc0Rq7gSb1OnF2yuurZqFvC5DuVLBWBZM3ozW2e7iVUyjjtFGmrKlbzLXnw549QXackP53TfkaKVrUNQV4QGU3jD11hfufdB+BOQSQwx3+80YEKCJ+BjoVtkuPCwpNUjDVJlQlWAy/rurY3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:59.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e315dc0-782d-4bb9-11aa-08deebe34bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Take struct amd_iommu explicitly so DTE invalidation is issued on the
same IOMMU instance used to program the DTE. Also, flush each device in
amd_iommu_change_top() immediately after updating its DTE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e5d26d6d4715..1bc232553c71 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,7 +76,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
-static int device_flush_dte(struct iommu_dev_data *dev_data);
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data);
 
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
@@ -213,7 +213,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 {
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	device_flush_dte(iommu, dev_data);
 	amd_iommu_completion_wait(iommu);
 }
 
@@ -1716,9 +1716,8 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 /*
  * Command send function for invalidating a device table entry
  */
-static int device_flush_dte(struct iommu_dev_data *dev_data)
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
@@ -2685,11 +2684,9 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
 		clone_aliases(iommu, dev_data->dev);
+		device_flush_dte(iommu, dev_data);
 	}
 
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
 	domain_flush_complete(pdom);
 }
 
@@ -3121,7 +3118,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		device_flush_dte(dev_data);
+		device_flush_dte(iommu, dev_data);
 		domain_flush = true;
 	}
 
-- 
2.34.1

