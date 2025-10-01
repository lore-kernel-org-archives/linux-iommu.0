Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1712D7398
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299056; cv=fail; b=fEUljgX0QMvS1PCBuYO/9aP41KzMDrhGf3a7g+lGcbpeCPFURLuxVxqm9auCf86MxR34KoJ/n9TO1KghrcsoDZieCVJRAPb2wuHU7QnHP/o6Ai0Mzt+CPLoefRToQybcH7KgbQwmetSPetu134ktmsBF86hIji8A6+8uhEcEBo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299056; c=relaxed/simple;
	bh=xu9CB7YHPyw6eyf4WiXDZwsCWjTbDOqffWkW3fVrg3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTc06MMWBQ5GPGSxbJGIboZz+qHBuJrI4KKTojetloVdV/nnoyNRLGoRrcoL+WVnR9ivGmFh8E25T+llffhVbVuYvlJnIxhm84J7Qt0Yx7QtzS2WuPhfuun64+AqabCMMwdulaYye7b71Yl5pKh4WSB+D76Z9TvUTwimX9VsEqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z0LjwoPJ; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z0LjwoPJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+4pPDWK/TIIoP/JJGBnY9KHo59m1SFlcwBASAzq14yS4mvlf/SHkFXAr4xZm6L1ZSbbStFpxd+ajNM3lCzzWIMWhVUJyoUOm9adWF99F2NpktCe0m1szt4xHuX6I7xPnZ9zl3jsuE/CqBBYas6RRb/eMot+lfDMO60au832L4EAo0yw1VuygnFx2qfyRtevKIK8xv4dtm+3yoL4r9tWQ3OktxWqmAGQ3kp0ybnJoOFvffNkcYWT9yINxpgRVlcwX9SD/gn0v7R9oipWxRueABVOnLFYpTyyR2ZSKFuN8v9mYvD8IPQcLs7rj8Yk/U1FVW4Io2ochfD8CMlzsWvPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3mFSptYTe11Uk9PXAdGy82+dHZrSFreURjblIP/2DY=;
 b=rpFfmQqI9bkWtikwfbZCR3CJ8t3txnxZMlh5I502RFxs6AjkGBsjS+P7rZlSPoBvMmazbrjiqPhYwxhQAsoc4T8Zsm2CpQoNaVkQOOm9LtzxrPhziPGAftHt5tWwV8bIpAW7A9luKPfuY826+SdRdCQwWdTZxYiSYp1QLZJzFlzxRVqFlacDt+doQmMM5dRz+gmp6OSG/UoslkwHyZUOfc7T4ivx+CXHru+C7z3weJ/DEEHVk6bp3ryhhymZrLPvjDIaqUpYh1cHPOdGX4MvIbDgsuLL/CIoYWPBttvQXAbsngdMySVVlVsf3wc7OF/jn2nk/Z6vUD0EzDFWsLDrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3mFSptYTe11Uk9PXAdGy82+dHZrSFreURjblIP/2DY=;
 b=z0LjwoPJUVMpV4xrzyFgAMVeiIpn1WJpwX3uW0k5w+pP1tDzYnC3Wwj0AF4vUgdbnipOOty59fuOH06A1xLR6NJx/c4JanZu8X5IEHifOPsq7cBT9m1S8jacsJxqZtBqj4Rukz65W9voXwU1TMJxOI+D50PX0mns/D5iYKzD7QQ=
Received: from SN7PR04CA0103.namprd04.prod.outlook.com (2603:10b6:806:122::18)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:10:48 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::9) by SN7PR04CA0103.outlook.office365.com
 (2603:10b6:806:122::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:10:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:42 -0700
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
Subject: [PATCH v2 06/12] iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
Date: Wed, 1 Oct 2025 06:09:48 +0000
Message-ID: <20251001060954.5030-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8a04b7-8fa9-45bc-cbdd-08de00b143cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXkWxfNDdv+hEYwTubW2c7ugRPtOsLk3UhvIvv4TULnnHZomKCgGSliTZ1Ej?=
 =?us-ascii?Q?HlTX2ja4xiXohcj7+UfGqP5gQv4zHM9s73kGYKo1ripc6xwWNYnNkvJKmgUe?=
 =?us-ascii?Q?8qZJV8dMZPTfoBZFRQc2WsCZPUOz/RIN6vyUfrZiFd1Wh+4YmUnukN+AFYcY?=
 =?us-ascii?Q?czcrpx5NonAD4L/W/dHUEbCJmMb4OhPI/QvHQuCDVMQGsk0kGpoJ4DcpYWNw?=
 =?us-ascii?Q?eiWCF3wEkZzEWjNSCnPBO/tgnnFB9iNtb9JSsfGohyGMFKp8EKnCh5CQ9m1y?=
 =?us-ascii?Q?41xUXqGcqhPtkfgFlQFYampAECTy4xQ0th3/LHRfOtPk39nadrEB1zEvyFRE?=
 =?us-ascii?Q?o68f9yAx+BRnVXG5TMI3Ei3pPcB2Ma4b6Czv/xjdLOqHpdsTSJ2eTBjnGmEn?=
 =?us-ascii?Q?Xe4WPCoPC9JyzrBnoytRG46llrunykxp36CJ4a0IsJaHsFhB/s1qZXcjrjme?=
 =?us-ascii?Q?AgNEFVvYdPN4mxxe1t9kMLAhNU44HdpEOG3WG8/fyn39HRZpt5nrBUc1Z3BV?=
 =?us-ascii?Q?OzEImwR9VJpAlzgWhsiNFgqWRex8KNj9pI0cFLNtsQNBWhtsmN2bW9R/R6Tn?=
 =?us-ascii?Q?pNY87c3ku0rI3OggsojIGY8QWZgr8F4dakGGD7r2c8PyvhGzau7CGYXA06Hc?=
 =?us-ascii?Q?WAsBFO8CpizVSHEyUYDn6LA1RiIo81hPMgbtGfynESGZi1ZxBXO4R2bA6O62?=
 =?us-ascii?Q?zLs9Wx+zjj62xHwLgaGsmS214/W9HLtfEn+Q+i7wc3BbVsOSAIRQD7PjNGyF?=
 =?us-ascii?Q?eEz4ugBtM6exyCTleivddnbhvELOkWBK/ATq2qwtqzw6rvGdNqe3YbyTt2kV?=
 =?us-ascii?Q?IxNj2j4120PGz/hzT3+tlwI0RmO1aBD0qv8LqmeAj9rSx/M86ih4jYXqNmA2?=
 =?us-ascii?Q?xXLnjKtVIarvPikUw+ZvqHEeGcWvtC0KulGb+vjf+R/pfjg4c3XGjYfMivZd?=
 =?us-ascii?Q?jG+0dNuN+TPktogVlNksONMa5c1DGkix6RCgEFQmBjDr055mnGiJMOs2u/JD?=
 =?us-ascii?Q?LEhMVv/j2NiK/9fy5Lro0FZRjg/Pv4XXFk2Dm7wle4paFr9ilbbZXReC40SS?=
 =?us-ascii?Q?4PqToXF+fDnvDM2XysQH7B5PjQo1mRNS1sJq3hbbKU06WOFh8yYyRNYzm+BK?=
 =?us-ascii?Q?a/FPuSndxFA+kZcmIgwe5Lo/jaq+RnCbTCUyVXNqtiUXSUwzjc+F02YL5Za+?=
 =?us-ascii?Q?GkPvIXeU2lPWGDJtVdDrcDytxr0HwuXQal8f556z4gUzvr4TKzhuP84HQXtr?=
 =?us-ascii?Q?tGc5lPqJKcKtI9G/pRHPVoziltjZhra9NEq/8zW5Babj5OnkiUTnLYRrrxbn?=
 =?us-ascii?Q?tNKICt8fhotopQiOZz17QdQ9+XRv8kdPOi64ck15ASUst/mvQ+5VaZMCBFpL?=
 =?us-ascii?Q?92s2n9wccbnAmDFeTrlmksM4oZgNSEywO3O8f7dmuwqwcXcY+BFgSn30Y+JE?=
 =?us-ascii?Q?5p3wowstDGbmw4K1ditJszh6m8ELYtU8jmh0dWz3yyNCQnsjzJdAh7AZZ1YA?=
 =?us-ascii?Q?Qbzc1pzWK8NcdT45c/7pY6xiEhNkFIVA62GeqvIIsTFJMjuheCn+zoqleQ3O?=
 =?us-ascii?Q?sOeXaSvNu0S2/OaI+kM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:47.9323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a04b7-8fa9-45bc-cbdd-08de00b143cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

To allow reuse in other files in subsequent patches.

Also, remove unused function parameter ptr.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  7 +++++++
 drivers/iommu/amd/iommu.c     | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index eb46e8914eaf..c7cb4a80d44a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -193,5 +193,12 @@ int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
 			     struct dev_table_entry *new);
+static inline void
+amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
 
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f2c61509b60..386ac96b2c02 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2008,14 +2008,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
-static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
-			   struct dev_table_entry *new)
-{
-	/* All existing DTE must have V bit set */
-	new->data128[0] = DTE_FLAG_V;
-	new->data128[1] = 0;
-}
-
 /*
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
@@ -2068,7 +2060,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
@@ -2128,9 +2120,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
 	struct dev_table_entry new = {};
-	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	make_clear_dte(dev_data, dte, &new);
+	amd_iommu_make_clear_dte(dev_data, &new);
 	amd_iommu_update_dte256(iommu, dev_data, &new);
 }
 
-- 
2.34.1

