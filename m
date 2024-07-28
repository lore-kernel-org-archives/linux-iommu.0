Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797179F9
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722210688; cv=fail; b=BoYcHTUxkOqT+pkGrmPO+e0F3OJ0+BnNJQWAbeItzlBNdPS0wCJl3q+5iER6p+my0HGa75dbb6RJrR/T+j6Jcwy+juMj2jfYq7q0f3SzhbBT2IsAOoFD2gvRH0XsArF41KocGFfhs8n+kAJ4fkyY8+IXgClZJlIr01IQVzM6xSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722210688; c=relaxed/simple;
	bh=GsMOUoF1zvhKm2WieKkYVtFhKieT/ZH7QavkvbTsvsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhcIdyfqTS4d9+NY7/n8PvBeZl33hYLpBJK3j8fgJkuGHdT4/4o5ESl9qk3Lm5El0pUV5/VVplKRUoHEI+Yh3ufB0qIM7yXiu6G5+CgyM82jzikQ80QM4C4rrTPHMKQU0hV1rMrOxja7VncHSCphlP3nkDVEG5RSIASlCp5vBe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUwTD+8B; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUwTD+8B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRutpGEvgfOjY6CW3mzqBPdTOYzjkZQ+g7Q3hfKlnreYo5GJ6jg95hEjGDrg2soGnbE65IMGw+h9QG1Uon6PlYr+VzL1otL+Tw51fw7cCjeNMoPx2EReORk/Fai3nslGKYxHEFiaRAtKrgzGEw1zmnfcKY3bw7yzatXmz0zKFsz+mwRJcOUe9Pqen1NcIgaI1O6LqT5Ib9AFEa7PldmdR9vnsK6YuufnJVTtQIHmjlaiCdLacTR+Ny3F6akLHTS1xLHrL4ADYpaDY8/xL/imG6RsE8wcZ3JFKQvGZRV4n9vhGRbAWnbUB1+l/0yhy315VPGMzGU9RqRR2k06hlhJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rbxOOxB6lsA7deOwfHUNS5El6Tpls5zF+rj27yJwJo=;
 b=fUeK1elpQ8WDbYmfNkl2O46jlg1tEk3/GErSt4FNt1u8AQvq0/sNHWdQ5Wm5eYZuaomLMyoRI3u+FcasjwsD3LEltqI9K1qEakNalXHrs10lGUOn4R3h9AvsBCGncGFWcvIplwCF2XHhGOqffuu/GbVQJguJ1n0D2056AcXBQYe4o8DwAf69sgnpEtvOgPzCyiBj2cs5rMD943wVyYQakHClEgRd9aUNzWY+4pV1aDhkohxQQ0IMqx7q7Kq4SJ6RrH5IxsaoHjE6zkDRGpL6oTjgMmlLPZqkaZZCS97BwPB62wPmZtq+ZmbOdDpkLajKlQcBOSZ7TWQh9UC4SDcQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rbxOOxB6lsA7deOwfHUNS5El6Tpls5zF+rj27yJwJo=;
 b=UUwTD+8BoLiPFMQWwBJAio54voyZ9cL372UlW82+UBM5eUKvGwcZDbIIZsjn6p9zPPMv/GQXiz5fRUY7okCqk+KoknI6nmRLGL/qPZP7D1YxS7vboSYZIQ8SBG/+VD4pdKG/GzW7fLf5rfF/mkmivEymQBa3EqrTyRWiIETct6MZzgDX7vzby0qUmwMwY+rDpsZvsGmg7hr52RA8svsknnZsEicJTMAzJPyZpqmMYPlJX6LSgLXNYbnpaN6sRKP7+X+1pqW03E58On2SWgvdkLJyoP3FBV2a1HUWBLr/tS3d3tcJbBNNixZDarPlLbSfuguP+uQDe444tJPQOboNYA==
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sun, 28 Jul
 2024 23:51:21 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::3a) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 23:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 23:51:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 16:51:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 28 Jul 2024 16:51:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 16:51:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging allocation
Date: Sun, 28 Jul 2024 16:51:06 -0700
Message-ID: <20240728235106.2435208-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f06a277-e13c-4d7a-92fd-08dcaf602e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOy035xhgR+qeJSfgjXdrFsIs8OLcrpv/j1r1qe5FsfDUaUFSNNzCF3+kHWQ?=
 =?us-ascii?Q?5blvEeD1FyvNCh/MiomE+cs+zLP4PSeran3Bky5OCdBixK4NuXFbs2Xm498t?=
 =?us-ascii?Q?6JHGC9sSrCiyLh1oKxm7GihGab3w3IqUuW34FUIfN7IR1AX26Jqtf19F/mAR?=
 =?us-ascii?Q?86JotntVFqpWol4IbYrkyp4/5L4j4UQmo3sFFL+s4g2U1+raW6fBo4bAOcCs?=
 =?us-ascii?Q?Nt1A5SusfaP2rRsqX/bvWkl/6mAPmxEC2bh2qOEvUMGryt0hiW1hcNMCBI8Y?=
 =?us-ascii?Q?7drwdJWoBg/HX0QN1dxUJP1N+vMoPYmRA/R0koyjXR6XdPIswK1W1IgQ6zm8?=
 =?us-ascii?Q?odIJysD9KOj1X9+tVM0TtfCdIPM5Vt5gOQd99VJTX48PbcdK9lkDvdh7dcAG?=
 =?us-ascii?Q?dp0NedIsw32KNMGdLwS6zoNxbauEQUEom31Kbqsj9aopCvdUFrH6n6fp0U7M?=
 =?us-ascii?Q?j7T3WEjv9kCMU9gEn5NmFzY5tH98q80su41V29MGou6kue9oPrso32nom5pl?=
 =?us-ascii?Q?lrLXk97IvMHSrosp+JQ0xrRsAwr+mZIUHvQeczQ0HVG/zVsbsvh7iTRG9TF5?=
 =?us-ascii?Q?a8PVvcxOyfSEkRJFAb7fzOLKEG0Rn+8WlpPXvuneX45GvbSTnEDIrH1fzR+M?=
 =?us-ascii?Q?Wc5kHpnRX6WbacBFRK5TZjHyJT1CgCQylD+QQfSLj4/N84aMDRyYoNZXrvjz?=
 =?us-ascii?Q?l43eV8dSkkvI9cweerpkzXS1wXXA/1RFpVShKjQ70L+Pi8q10dJ74p+4/xsy?=
 =?us-ascii?Q?j24syO+KJwl4jLzTa1NW9xKf0kFQWUjVgtCS4/YB9eVglU082D9AJgm4U3o4?=
 =?us-ascii?Q?FxdFk6QSkgECvwgysGp+2Zvik3mOQhXUcJ+ZDlMj8AeTeD0XsfRlZBSHemKx?=
 =?us-ascii?Q?Iag2voDPe5E0J+5oDzGxqvO+rM9hTtsqWP7ATOkXOhpLXk9gVP7/Ei6n6BIZ?=
 =?us-ascii?Q?IIPYUL5eNSHDwAsAwxUBV/WC+SNr4YLuOgye2/4GrfvydHAKubgIQ72Dwnlg?=
 =?us-ascii?Q?GJBACFft9Jjyrm1gcB9mLe/jVcS8KNk7Phmt1czg/SGRZ7Kpd9kVexi0c5Ak?=
 =?us-ascii?Q?En3HvLGA/WQNsUQESa08erO23dIW/mG8TbNoKuD4+wwrAqIJPpkJ40x2nnUb?=
 =?us-ascii?Q?YTuQcur84RXYJIAIudpMt6lQJN4vjbhs20CUA74TPZNzGVHohzCcF3pTaTap?=
 =?us-ascii?Q?okwy2bxADnq/jhqu0jKZeicMvls3Fl6fgGbas9Ftu19gbhbzVw0NFwvJolSh?=
 =?us-ascii?Q?QesRxe0qET9+3pYwwzOJKPrE0rXm6LIQCtzyHH2JCuJ4ggh/1mFWQZ5Bjrv+?=
 =?us-ascii?Q?VS7Pj9H1HsoIk/tYIEIy/LmUnkJvNZdE8eTVHfZ9pSx56dlDsVi5/qI8ldtQ?=
 =?us-ascii?Q?ozKZayDPcTHbVd+QENYrnwhS2dj9xI7E27XCW8E8CYLhvnUfeP7RQ9T/5Eqo?=
 =?us-ascii?Q?CP0mBwJTW1r2sfh7JgDcxtZmeddAGRcN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 23:51:21.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f06a277-e13c-4d7a-92fd-08dcaf602e6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver. Though it
is eventually used by a device for address translation to an MSI location
(including nested cases), practically it is a universal region across all
domains allocated for the IOMMU that defines it.

Currently IOMMUFD core fetches and reserves the region during an attach to
an hwpt_paging. It works with a hwpt_paging-only case, but might not work
with a nested case where a device could directly attach to a hwpt_nested,
bypassing the hwpt_paging attachment.

Move the enforcement forward, to the hwpt_paging allocation function. Then
clean up all the SW_MSI related things in the attach/replace routine.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 67 ++-----------------------
 drivers/iommu/iommufd/hw_pagetable.c    | 45 +++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    | 13 +++--
 drivers/iommu/iommufd/iommufd_private.h |  5 +-
 4 files changed, 55 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9a7ec5997c61c..bc8baee32a9da 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -90,7 +90,6 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -293,64 +292,6 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
 
-static int iommufd_group_setup_msi(struct iommufd_group *igroup,
-				   struct iommufd_hwpt_paging *hwpt_paging)
-{
-	phys_addr_t sw_msi_start = igroup->sw_msi_start;
-	int rc;
-
-	/*
-	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
-	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
-	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
-	 * domain after request_irq(). If it is not done interrupts will not
-	 * work on this domain.
-	 *
-	 * FIXME: This is conceptually broken for iommufd since we want to allow
-	 * userspace to change the domains, eg switch from an identity IOAS to a
-	 * DMA IOAS. There is currently no way to create a MSI window that
-	 * matches what the IRQ layer actually expects in a newly created
-	 * domain.
-	 */
-	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
-		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
-					  sw_msi_start);
-		if (rc)
-			return rc;
-
-		/*
-		 * iommu_get_msi_cookie() can only be called once per domain,
-		 * it returns -EBUSY on later calls.
-		 */
-		hwpt_paging->msi_cookie = true;
-	}
-	return 0;
-}
-
-static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
-				      struct iommufd_device *idev)
-{
-	int rc;
-
-	lockdep_assert_held(&idev->igroup->lock);
-
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
-						 idev->dev,
-						 &idev->igroup->sw_msi_start);
-	if (rc)
-		return rc;
-
-	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
-		if (rc) {
-			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
-						  idev->dev);
-			return rc;
-		}
-	}
-	return 0;
-}
-
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
+		rc = iopt_table_enforce_dev_resv_regions(
+				&to_hwpt_paging(hwpt)->ioas->iopt, idev->dev);
 		if (rc)
 			goto err_unlock;
 	}
@@ -453,15 +395,12 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt_paging->ioas->iopt, cur->dev, NULL);
+				&hwpt_paging->ioas->iopt, cur->dev);
 			if (rc)
 				goto err_unresv;
 		}
 	}
 
-	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
-	if (rc)
-		goto err_unresv;
 	return 0;
 
 err_unresv:
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671e..dfb132e4dfbd2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -82,6 +82,42 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 	return 0;
 }
 
+static int
+iommufd_hwpt_paging_enforce_sw_msi(struct iommufd_hwpt_paging *hwpt_paging,
+				   struct iommufd_device *idev)
+{
+	struct iommu_domain *domain = hwpt_paging->common.domain;
+	struct io_pagetable *iopt = &hwpt_paging->ioas->iopt;
+	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
+	struct iommu_resv_region *resv;
+	LIST_HEAD(resv_regions);
+	int rc = 0;
+
+	if (iommufd_should_fail())
+		return -EINVAL;
+
+	/* FIXME: drivers allocate memory but there is no failure propogated */
+	iommu_get_resv_regions(idev->dev, &resv_regions);
+	list_for_each_entry(resv, &resv_regions, list) {
+		if (resv->type != IOMMU_RESV_SW_MSI)
+			continue;
+		down_write(&iopt->iova_rwsem);
+		/* owner=domain so that abort/destroy() can clean it up */
+		rc = iopt_reserve_iova(iopt, resv->start,
+				       resv->length - 1 + resv->start, domain);
+		up_write(&iopt->iova_rwsem);
+		if (!rc)
+			sw_msi_start = resv->start;
+		break;
+	}
+	iommu_put_resv_regions(idev->dev, &resv_regions);
+
+	if (sw_msi_start == PHYS_ADDR_MAX)
+		return rc;
+
+	return iommu_get_msi_cookie(domain, sw_msi_start);
+}
+
 /**
  * iommufd_hwpt_paging_alloc() - Get a PAGING iommu_domain for a device
  * @ictx: iommufd context
@@ -173,6 +209,15 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 	}
 
+	/*
+	 * IOMMU_RESV_SW_MSI is a universal per-IOMMU IOVA region arbitrarily
+	 * defined by a driver. Any hw_pagetable that is allocated for such an
+	 * IOMMU must enforce the region in its reserved space.
+	 */
+	rc = iommufd_hwpt_paging_enforce_sw_msi(hwpt_paging, idev);
+	if (rc)
+		goto out_abort;
+
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3abf1b8..c9b7c7f6e046b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1368,8 +1368,7 @@ void iopt_remove_access(struct io_pagetable *iopt,
 
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
-					phys_addr_t *sw_msi_start)
+					struct device *dev)
 {
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
@@ -1387,14 +1386,14 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	list_for_each_entry(resv, &resv_regions, list) {
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
-
-		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
-			num_hw_msi++;
-		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
-			*sw_msi_start = resv->start;
+		if (resv->type == IOMMU_RESV_SW_MSI) {
 			num_sw_msi++;
+			continue;
 		}
 
+		if (resv->type == IOMMU_RESV_MSI)
+			num_hw_msi++;
+
 		rc = iopt_reserve_iova(iopt, resv->start,
 				       resv->length - 1 + resv->start, dev);
 		if (rc)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 92efe30a8f0d0..d61ea73776261 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -89,8 +89,7 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
-					struct device *dev,
-					phys_addr_t *sw_msi_start);
+					struct device *dev);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
@@ -302,7 +301,6 @@ struct iommufd_hwpt_paging {
 	struct iommufd_ioas *ioas;
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
 	bool nest_parent : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
@@ -382,7 +380,6 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
-	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.43.0

