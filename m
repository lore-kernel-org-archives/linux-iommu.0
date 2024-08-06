Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179429A1
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920549; cv=fail; b=DrcoOFmorUfHrUmjhX7ll+DYcpLhaerCFiAm31oHeruX4ciO2se6+mtujR9CWQ8LTXwKm+mOk9A9OIzNO9FK47HcjgVC9Fa+ySNEOxQFHl+B8IcO43G1U62bsK8pQ0Coj4+wgbkOzXqmx899mK1QlGsdkj4OArPLRLD2ymdCHGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920549; c=relaxed/simple;
	bh=nrUT9cHmY0rQrFflIPJH7BP2fTaEQacA3BAc/c2hdbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HepHEFH0xqlpf20cxYAojZyl60/uggWa/cmPFs7ueKUrFk6YxPvG5hCmOQFVl/qIh1qmaYR6rJm+nJUvzBUZUZf5IMAMYYFPmyxUV0SWQIHDaGFCzE6UDGa/8R0lO33pLinPM6Jm8NHFa+QXpvkYeZ0ViMF4pJeZN9NM3mtnkas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAsjj6FI; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAsjj6FI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwHzlLYgSDODHyCUU1przjAeJvngSXH5eihbak/4mCyrJ7/Mv38QOn/YQXM02f03sVA3qnLj2BcHhuprDyC1qVCFvopZUQtkdpnko7QKLyFOhm1E/2HLcD+UmhPmpKcTComOEfvpO592R2554k75dBPza5YqzVK+M+4FMQehpLtsferHyBUjM2i1UGZtzkhD//RVGL7oJaAZdMZ+s+bZ0a7L0pidUfbeSCe+L+bGlQELS5i+etcR8jZzA63Nfx3w9y3XAC4FnOwAqx0Hz0Z94PMZjJGAzlfA5l/mbmgGwK0lWQs1RafyTbn7Aqj3O1Z6Aq1QcA5qvBoprN0Ip7hW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMCJstFzy5VUkvZPE20qGQDWhbqFH7ufs1piLBzpQh8=;
 b=s91odQfibGax8aS9XeoNQ5Ta17vTNi3ouS838Nk/E0r6BkJcydKpotz2dl224zgwS7EqWJ4JrUlATx/IBNriFggSdt39ROpu562cbw+IKvTIBJNvuE38PMNL0rVxUD4H3ycDYAXBZBUDCL23/kkpTGh+urMQ3dx+EPz3uNJ6kcSmw6kGHHkwZekGo/B8ttXT9udXYFPEqipfVlSgKjy85wK0cDO3a/xlRGkqJWd0dgq2UhCQD53bsltETbXzP/I5d9JvPVH9YXuEGnTu+AtQZL29YaRCZukDBcZ1o+jTYIq0uaLSE6q2oFCRui795zTZTM+spw6MbcS8YlGdLEJmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMCJstFzy5VUkvZPE20qGQDWhbqFH7ufs1piLBzpQh8=;
 b=fAsjj6FIFSqZygvCXT3idbwr1CF0p9Ld9c3BswWCBo9rutWW1pU2+Em3nKILxrrAxGVqLy79Bkh6HzR3qUiG0TSrTYXIttKaCaFWy0Hnn2vP5VChlEzYNrewgy0utbscZ03SdvUW+QXImZWjpLYY0dQstG2c5o5Hwcus/k7M/mPb9Gfyc1gK9LOFmyywoMrYIIdORGylwP3OIymm6cAYxlsX2kGyS7/74rPOeWEKILSG35WZDFVsVMhqEyeMWlK6p4nF3I5C+VXua8DvdRBUQ+clT2t8Uv4haNb9sup3wLDtATkkGCJgRqTnAHASQkqyDfLThft2XEpFvzPLA0/PDg==
Received: from DM6PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:100::47)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 6 Aug
 2024 05:02:23 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::c9) by DM6PR03CA0070.outlook.office365.com
 (2603:10b6:5:100::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 05:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 05:02:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 22:02:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 22:02:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 22:02:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iommufd/device: Enforce reserved IOVA also when attached to hwpt_nested
Date: Mon, 5 Aug 2024 22:02:01 -0700
Message-ID: <20240806050201.3717816-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a63662-aab2-4944-a910-08dcb5d4f537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y24SRwqAFzUKbretFXZ/bOHreHehWXQBWIQvP1DLgnxw42zoMaGsaUkDPTvf?=
 =?us-ascii?Q?ai7OklGz2RQa4RVQFwlCEInMK9W9M1wq/T50NGJzF6nR56y+EGIuRB32tMTR?=
 =?us-ascii?Q?c1zdbhBme4wvc2qCbAEjsYVZ5YIpfx8wMaUXGK4QQPq6kFxU8sO6npopc+qM?=
 =?us-ascii?Q?jF08QQ114LZ8vNndtwAGhxu30BOq7laEuzOKdpLJBW4SY1QkNpECX639dlpE?=
 =?us-ascii?Q?3PtiCimHiv0QbyP3rffNP6XlN1yWJoORwhM50vnJPSCOKr9udq74OnxX6pCl?=
 =?us-ascii?Q?raRr05pNAb6p/WS02PwztqgLA+2BOl33gjS4SwxKwh1/XD6xrfeWQ52mNgqK?=
 =?us-ascii?Q?G8R2GpyFziD0WiTvbzOQUzZe0Zxx6ACngqTTrExQZN6q+XKT1mv9Wuosr9J3?=
 =?us-ascii?Q?LnRnmzywroD7aUpPlT5u9MPs0O5ztew0JyEC7ffyD6QcR4O6c1V3GymeGsrj?=
 =?us-ascii?Q?sRnEjq+Ru0X8tFJslhOLa466AtupBnzP/hFFAivJSqdozQO/ualqupgjxpk4?=
 =?us-ascii?Q?fanOCJ0VnxWHO1WHCoHfhln2VACLS7DISGSUfqWhzKjNY3T7wk3oECd5edC9?=
 =?us-ascii?Q?z5Se8MNsFQIrbz2shAEy7+kT2jF2NLJGZN68lkZFj+u3GINV0YOVnbz0em78?=
 =?us-ascii?Q?FUUxi8AJe5N5+t5G9yTitgq/3DNyd8QjwWVFRzVUG0wTvsZEGc56LQ6HU0Kl?=
 =?us-ascii?Q?1TkrZsT1FqrSBCBdkRlyhVQNxvHQRtnnrrpQNFOR8ax0ei9N5f/f5emfCE+R?=
 =?us-ascii?Q?JwkuuDgp23q9IpbEl4MRNGu9g/XOcNha8cVgvbRNF7Ms60rUdLyz4MPuP8fY?=
 =?us-ascii?Q?S/ta+77JatMT3wcRgQgjD+6aYVFfOvzFWqJ4yhrWwB9mlVfqAyIHTYyz9fce?=
 =?us-ascii?Q?L0px8FeXWVAToeXXDIfRqsP18F71xBdyApeu1vK4E1K0BkfpboJD/4QiwTJh?=
 =?us-ascii?Q?H1CO9Nd9gkKXpS3FVzsWkbVzUTMbYmLeM+qiIq3N9XwKCggyAfpVP9DbmF2U?=
 =?us-ascii?Q?/n1rfNCy0u5n5ZGxhY6kdiIZWu7bjx+w44xOXdXN2RTJ6VwD8oDMn/bst+9C?=
 =?us-ascii?Q?d875igkr5GMOrkCqJA0xDt0Gq3Mdei+eNrC+dCnLiaG56qhMbWa7n2qPkoK1?=
 =?us-ascii?Q?9ubMtujerwUy23sNUlCPCa0PNleXDbJVAQK8ZZBMmef0Hp/KIMVlEiDAxdJc?=
 =?us-ascii?Q?K3Br7Q5i8UPV7fhroUIWllJpbyr83zjzG6e0rxJgRI4re6zkQnenaexRjeUb?=
 =?us-ascii?Q?fuagqVcdio6Jlj40mSdz6BYCZQ0R/FqrXc06PwnyBVeMy23Cj+pJLwfpmdB0?=
 =?us-ascii?Q?QZVT5byTmrv/7KULg9S0gx7wTSsXBMpgldoHW8qUVV0gZzvOHCVUXMYlJu+6?=
 =?us-ascii?Q?5ZGLWWcqs6qubFclVZV5qmcJXfEorAgn2TM2gS6A9LSLMVBOvk05RDWsX0ZJ?=
 =?us-ascii?Q?39iZhmumjBUb7fpEJ/aZab+jdvFZawtP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 05:02:22.9808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a63662-aab2-4944-a910-08dcb5d4f537
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

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
IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect to
its parent hwpt_paging. And add another hwpt_to_ioas helper to get the
IOAS pointer. Return a NULL in these two helpers for any potential new
HWPT type, and make a NOP in those reserved IOVA functions accordingly.

Suggested-by: Tian, Kevin <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v2:
 * Corrected the ioas comparisons for future hwpt type that returns
   NULL by the to_hwpt_paging helper.
v1:
 https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/

 drivers/iommu/iommufd/device.c          | 77 ++++++++++++++-----------
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++-
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3214a4c17c6b3..949b69c9f3b2d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -327,13 +327,18 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
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
@@ -351,6 +356,18 @@ static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
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
@@ -363,11 +380,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -387,9 +402,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -406,9 +419,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommufd_hwpt_detach_device(hwpt, idev);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	iommufd_device_remove_reserved_iova(idev, hwpt);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -429,28 +440,31 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 
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
-	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 	struct iommufd_device *cur;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (!hwpt_is_paging(old_hwpt) ||
-	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
+	if (!hwpt_paging)
+		return 0;
+
+	if (hwpt_to_ioas(hwpt) &&
+	    hwpt_to_ioas(hwpt) != hwpt_to_ioas(igroup->hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
@@ -465,7 +479,7 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 	return 0;
 
 err_unresv:
-	iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
+	iommufd_group_remove_reserved_iova(igroup, hwpt);
 	return rc;
 }
 
@@ -491,22 +505,17 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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
+	if (hwpt_to_ioas(old_hwpt) &&
+	    hwpt_to_ioas(old_hwpt) != hwpt_to_ioas(hwpt))
+		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
 
 	igroup->hwpt = hwpt;
 
@@ -524,9 +533,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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
index 92efe30a8f0d0..42f5b7f7ec250 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -321,7 +321,20 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
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
+static inline struct iommufd_ioas *
+hwpt_to_ioas(struct iommufd_hw_pagetable *hwpt)
+{
+	return to_hwpt_paging(hwpt) ? to_hwpt_paging(hwpt)->ioas : NULL;
 }
 
 static inline struct iommufd_hwpt_paging *
-- 
2.43.0

