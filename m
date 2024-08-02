Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A322097
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576927; cv=fail; b=G8U2/LG6zx4Fm17H+GVrzb+pJDgSrCh44h0/mxy7LF2PMvA5eVMVOL/WofDoloVhRmbFz66mOQOARO/baViiXqX1MihSFXoMyLI4jq2wmURAbDwWBwTLLtstup7pu3mieRkrA7vCj65dN/FvZi56NQYNllttJyedzYQVmKrvHtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576927; c=relaxed/simple;
	bh=hecp7ePGo0ayHOEoqke8aHNWGMkYF72aGOxglYi87Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TT4DGsiKJM8gdPcYqc+rWBxEFq9s7ufl37EVUU6MPChpNiwnW4C66hd0ZayqFKM5M8myYGSdCKrkvdCE9XqV1TmpyPXylVRrERCFbE9wcqI07YL5daI3FsOSd7Z5VWi3uEikuI6WoZAWN1rLyirLOOSYus79+QMIHBEGcmTdITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJOSDKpe; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJOSDKpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mX2fsaHlbuTc0Fxq3MPqxSOyziIYe67Cv/FfaHd9Sl4QFA6+OdJ16pA0Fw/nv1vrqFOPdHx249eS91MEXokrWnIQEYGuKnFr7Jo8ynzNUWreJd9GrRfT40651H+thclVfqpbWTYKxmwtdH83DsazaYbhRl5IDuAO/HUquYJmhFLSw7M68YI3AwWkGoOHLMH8u6bG0N1iTF+8KnTAbcr45fax+X9+Si8uBLtOphHD0/Uk3wnyJm7LMtz32l6Pj2yfedrqZdmT0YvSLILe7Vh2+xBGVyV8pyFjBSOm6tRuv9iFmiv0dEA/OpM3YWqAC4tIxJxx98QaP648Vno2Mfgx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1mwJahCpyUYNgYomjfS5dp02ImMyo5B7Hoeua2eEok=;
 b=Xvi2yt2DBQtkLc7aXHDLjJI8jVW67ZaT4pqPNdI9/u/S2LlZcVywp1ZZzaMWhij/8IvfhIxuPvcUzOcBIrixwKiUzC4nAHUeTH2KgcDeCyl7yR68KuWw8OVTcrHU4pUG0VgCSvAtgGkpgg8OpQF4Gob1qxB8fZ4EV4mMAngTbzSbT7BomhKjx9agcA9h1YFJ72qZTSXY02CzBjslWcWdty9j+iZIKltMeaCQmXZLqeq/NTwfeEklnHJsU7aQK+RGZohoEKcdffJNOSc2kN+x5YAvmRt1u2jtQxDD8PBxkCnn1NzWdKQQCAquVWDrjiaOxsC54KnHfTLOm8lR142GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1mwJahCpyUYNgYomjfS5dp02ImMyo5B7Hoeua2eEok=;
 b=ZJOSDKpetDq89I/w1nEEIUhhO4z50ui+UFY7o5WeGNhTcbzdWh5o1F8oRljuNDCXvYcNosmnRd/K+FxCVht+tpYVjXAvRk48z9lSRpJReGv3r7ZsQdU/HANUyZLe0cbTa3oUDqqwbHEXOlltuYzupLV+YuosmJ+LV21ZEBZ5RiafH6PsQFvu0Vn8YWv9c13TtqzSe8ofUAUb3y5UhqLNRRTveX659lmLJf0mkVgwtYk3Mr4AYyTENvpPnsRZ1t027xYUDhBNYcTYmmNx1SCdMewRAHj0NPMf5tpK+TKJLIdgB40rqAhEIM/35QbMoX5rcDSiWzSsBy+zlsNWthW77g==
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 05:35:22 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::13) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Fri, 2 Aug 2024 05:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 05:35:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 22:35:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 22:35:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 22:35:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd/device: Enforce reserved IOVA also when attached to hwpt_nested
Date: Thu, 1 Aug 2024 22:34:57 -0700
Message-ID: <20240802053458.2754673-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ea1a31-5294-4e2e-f8e3-08dcb2b4e73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W05h0+KIaZSqaoF5zzsKbGIE6iGDpgpDU1Y9KTLwVyjCzTCB60Ftc7EAGdMs?=
 =?us-ascii?Q?7J+WWCVWhqGBkh1Vef74V06o8JIaXN0yBJ991dOrYZeDhqdbKS3O3apWKy0I?=
 =?us-ascii?Q?h9Vy7lJmOaSxAJTLqIm391jo6c72iD13+63OoztqAE4ZP1Ouy283eRfoh+9n?=
 =?us-ascii?Q?tbErwky3VzxXkF68ZBiFJWMOoTXbxvZ07+zYrVZPwAh0W31yQfwQSfkkxA25?=
 =?us-ascii?Q?JzkAonXeNTAGXcchkpDu1czTzonH0WP6tq2+/UG0RtvDjRoMkWdSVR3v6N8c?=
 =?us-ascii?Q?wHcvW64HWri82m9XSwyFr2GZece9AeNpEOnQdvkMSg1uZx9Ei+tBJeCq7pMk?=
 =?us-ascii?Q?sZqGByXU0EQIlimAC8+n2YalLsKkJtIWB3m66RbOaR1TfOfQay4Da6D3BqsL?=
 =?us-ascii?Q?0XUhppptnFSDlAmG93GNTLKBCyMQMNW+voDpL0JvjlyRmJWeIcXs5N8OQsqY?=
 =?us-ascii?Q?By+JDhYbwGlUbzndPBMu34vVt3gS4BhvyNKCGHs58FoGlMo7WVnQYBtkPC9o?=
 =?us-ascii?Q?m/hKPPsI1odcqou8INXh/FOiwLgXbcbfPx2fuSTTpJN7qPQOV6gwd3LE72ru?=
 =?us-ascii?Q?bms+3QFto6EtmTOPhTwCP7s31fnCe2SjDiK80yyXuUqL1HB/Bn72BZhPcm25?=
 =?us-ascii?Q?Fj2ixIIBavR9V8Web0HKoPCLDFFc2OIZXsuplFdBmIJPltPITcTs8an96NmW?=
 =?us-ascii?Q?xure/d1zoQyuyNiGNcVEc6eWCNTZ2Bvq+wjg7/xTZIVD3/I9mS/VUqD52uqc?=
 =?us-ascii?Q?Cb4Afg5monKkT0+qqQL0TmzOHIU292S3NIoAxI11KmFcf3H3pcVn4/IwxgdI?=
 =?us-ascii?Q?7RG/+woNQ50JNmfkpmEt7jUg2ddeMi+7WUHKMlVAjh6O7UWl+VMliAwdMM0F?=
 =?us-ascii?Q?940ADMfDrcpioeHOrli33CGluCfGIpjKPjgtgIQw5YLStNneTNiyb4Tw2StO?=
 =?us-ascii?Q?wgcaSHt5ZTFMrsY6sh6w4on9awlvujfVaZjZN0/jH3CZrLgt7uDOpzfX/TGU?=
 =?us-ascii?Q?nZ+WamHtSmc9x0YoSRtPRBrEmW7K+J/lE0lfonKYqz/NMmx7Bn00cB5S4G06?=
 =?us-ascii?Q?IAYxpbj8eTGt9ikdseRfgSRCpKGMGvwEsHcxSw+8rlI0bFRH/HnAsP5w+H6R?=
 =?us-ascii?Q?kynLbE2ilAoXqIT4mI+2qXKd4p8WpJslnSekn+bSJBYc731ZGPPMl73URsAi?=
 =?us-ascii?Q?KMngukOiwt/mRPAw1fhz1SpkIa0be83kB9SCawwB9MmVTrFt082z/6iZFNoB?=
 =?us-ascii?Q?tIFaA2DlyzYoaTdJghqRSsr2uBycoowJBNn2ne9ZXtCqBVeB3BqXp9Ov3j+y?=
 =?us-ascii?Q?soKmrJdLHhwXdz/SxcKwcNjfzlQdhRP4ZAlxd8JOB8UBfNRu76e4dkpti4sH?=
 =?us-ascii?Q?mkm7sVCOPIohl7OeHypraZoWxlVQ054RAHm3iMhxAvwTccCArBBhh3YrkqA1?=
 =?us-ascii?Q?CmHXS6nyik6ylBv+MMUmBbvDAxvnfj+x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:35:22.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea1a31-5294-4e2e-f8e3-08dcb2b4e73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

Currently, device reserved regions are only enforced when the device is
attached to an hwpt_paging. In other words, if the device gets attached
to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
would not enforce those reserved IOVAs. This works for most of reserved
region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
defined window, required by a nesting case too to setup an MSI doorbell
on the parent stage-2 hwpt/domain.

Kevin pointed out that:
1) there is no usage using up closely the entire IOVA space yet,
2) guest may change the viommu mode to switch between nested
   and paging then VMM has to take all devices' reserved regions
   into consideration anyway, when composing the GPA space.
Link: https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com/

So it would be actually convenient for us to also enforce reserved IOVA
onto the parent hwpt_paging, when attaching a device to an hwpt_nested.

Repurpose the existing attach/replace_paging helpers to attach device's
reserved IOVAs exclusively. Allow a common hwpt input to support both a
hwpt_paging type and a hwpt_nested type.

Rework the to_hwpt_paging helper, which is only used by these reserved
IOVA helpers, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to direct to its
parent hwpt_paging. Return a NULL for any potential new HWPT type, and
make a NOP in those reserved IOVA helpers accordingly.

Suggested-by: Tian, Kevin <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

[To Kevin]
I found 4~5 places doing the same hwpt_paging routine in those IOVA
helpers as you suggested previously. So, I ended up with moving them
back to the to_hwpt_paging helper, while making a room for any other
HWPT type that concerned you.

 drivers/iommu/iommufd/device.c          | 74 +++++++++++++------------
 drivers/iommu/iommufd/iommufd_private.h | 21 ++++++-
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 76b7297d22b0f..f4c27d5359531 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -338,13 +338,18 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
-static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
-				      struct iommufd_device *idev)
+static int
+iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
+				    struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	if (!hwpt_paging)
+		return 0;
+
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
 						 &idev->igroup->sw_msi_start);
@@ -362,6 +367,18 @@ static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
 	return 0;
 }
 
+static void
+iommufd_device_remove_reserved_iova(struct iommufd_device *idev,
+				    struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
+
+	if (!hwpt_paging)
+		return;
+
+	iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -374,11 +391,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
-		if (rc)
-			goto err_unlock;
-	}
+	rc = iommufd_device_attach_reserved_iova(idev, hwpt);
+	if (rc)
+		goto err_unlock;
 
 	/*
 	 * Only attach to the group once for the first device that is in the
@@ -398,9 +413,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	iommufd_device_remove_reserved_iova(idev, hwpt);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -417,9 +430,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommufd_hwpt_detach_device(hwpt, idev);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	iommufd_device_remove_reserved_iova(idev, hwpt);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -440,28 +451,31 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 
 static void
 iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
-				   struct iommufd_hwpt_paging *hwpt_paging)
+				   struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_device *cur;
 
 	lockdep_assert_held(&igroup->lock);
 
 	list_for_each_entry(cur, &igroup->device_list, group_item)
-		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
+		iommufd_device_remove_reserved_iova(cur, hwpt);
 }
 
 static int
-iommufd_group_do_replace_paging(struct iommufd_group *igroup,
-				struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
+				       struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
 	struct iommufd_device *cur;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (!hwpt_is_paging(old_hwpt) ||
-	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
+	if (!hwpt_paging)
+		return 0;
+
+	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
@@ -476,7 +490,7 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 	return 0;
 
 err_unresv:
-	iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
+	iommufd_group_remove_reserved_iova(igroup, hwpt);
 	return rc;
 }
 
@@ -502,22 +516,16 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_group_do_replace_paging(igroup,
-						     to_hwpt_paging(hwpt));
-		if (rc)
-			goto err_unlock;
-	}
+	rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt);
+	if (rc)
+		goto err_unlock;
 
 	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
-	if (hwpt_is_paging(old_hwpt) &&
-	    (!hwpt_is_paging(hwpt) ||
-	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
-		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(old_hwpt));
+	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt))
+		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
 
 	igroup->hwpt = hwpt;
 
@@ -535,9 +543,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(hwpt));
+	iommufd_group_remove_reserved_iova(igroup, hwpt);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 04109572a53ca..414d5230a497b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -316,7 +316,26 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 static inline struct iommufd_hwpt_paging *
 to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
 {
-	return container_of(hwpt, struct iommufd_hwpt_paging, common);
+	switch (hwpt->obj.type) {
+	case IOMMUFD_OBJ_HWPT_PAGING:
+		return container_of(hwpt, struct iommufd_hwpt_paging, common);
+	case IOMMUFD_OBJ_HWPT_NESTED:
+		return container_of(hwpt, struct iommufd_hwpt_nested, common)->parent;
+	default:
+		return NULL;
+	}
+}
+
+static inline bool
+iommufd_hw_pagetable_compare_ioas(struct iommufd_hw_pagetable *old_hwpt,
+				  struct iommufd_hw_pagetable *new_hwpt)
+{
+	struct iommufd_hwpt_paging *old_hwpt_paging = to_hwpt_paging(old_hwpt);
+	struct iommufd_hwpt_paging *new_hwpt_paging = to_hwpt_paging(new_hwpt);
+
+	if (!old_hwpt_paging || !new_hwpt_paging)
+		return false;
+	return old_hwpt_paging->ioas != new_hwpt_paging->ioas;
 }
 
 static inline struct iommufd_hwpt_paging *
-- 
2.34.1

