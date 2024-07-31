Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8211208D1
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460925; cv=fail; b=Ao+33Ik/moxQoYKto7xewgCc/XUR/5t/2NySV7koezue6zFnMtCCIXdZKs/we3dlRBuw8fEb/e8XNFrcsOc5KlD4HEzqxwozqNwivP1E5bwVpfcRqBbY24VYhszP7DLDKOTgDINmopF5eDmwy0XrQOTyUc/sgp6Q8T7WzGBvKhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460925; c=relaxed/simple;
	bh=rHOtn07M5uR0gyYkTFKcJ9nuP9ADMjmfJ161uvFdfhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjZgpS0CjDXGHuLKJUQ26bzRzF6Qlz5c49aIygsI8+M+c/XXwi1QiVafdH0Nesz8WuV2TEMmZTAfGMQq1UNlNXxeL89NbBXhSmhBSqg/GjDxJdG6nJa+J6dV+jeyZjeDM49DLTJxkU4zKwMy++g3KZ9nS8VK7H3JuYve2jf3cW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwXAF3K9; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwXAF3K9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BikAVEUrOTIzzas/cfz9ItjvMvGyXUBFuyNg2TVtHU+g4rQ4MS0oa1nwf0uDo9CVhLdoON6+frVry1YqBDTuQpLcQDa53Y2d3tGIeRQnPkumcnuHT7Qa8hmxJ0AChPKGeTai7NLm47f/hoDjPHQ8Dg4M4sRcKlbTTX/4jMbTd624iVR/wDX+i2l7IfBlQT8VaFB+gNIee6QxwRKVoJ0eReX452fEfpy1rRRoM6dpEz5iRxlQyygNF8pB1zmY1JeoBeE9YaOSlzS0s7ihl0KZrWW/CeyXoIwFQ+FjrK/hrToPLMQnikV5zCIeXJBFafou6azCRQuTnze39YLNFwfbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1YZbFJZhSIzpCAIjZ9kk2B9oYsL3i9IS+CjOX5qrEk=;
 b=ROTfYf2wMlT064CZp7cAzxQOzeIXq8neNuSn3FVZw9/1S9F3aEDo2EHizcikn9HKfTJVWjapF4DMSqAIvkBCZfY6+gFKUWvjmkc7l5p4Sq6ASVlodB8AMX/2VxlavRCr3nH/QIclBbMdEpkFBnjXjSv2Fe8+nIUBL7ADAU48KJLKzFJ/n9DClADeU8DK+/CIOHkVxMq0osSyBsVIKgk8r9JSzvHqUa0vS/IdSsKFR3zbstrim7GBeN+UFb1p9FI8maSJ+Z8biz5zBrFfHAw3sgil2qfCZw7HEFTfyRM4QzLRudjAZbRZQDV0dVASPj1BOmpFIv1WtgYCfzOO8iF75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1YZbFJZhSIzpCAIjZ9kk2B9oYsL3i9IS+CjOX5qrEk=;
 b=hwXAF3K9xV4T96fUN27CVJFwilyw4sETNe7S7/VHf+doJU0oXwyK2lhLQwxaYHbF52+YT2URjVk3AoJS8Rp5DSerYbg4qQNaAHyzyCgLp4ngUnPp/2/QujFH41mBMw82covYDHasi16eldJmFr1k+21WQ6J0qQ+iwAniNLwE2nijsj3GCAbGrvQfQ6eN77c5eWtEVMz1BUDktLPxhD0iBd1RICAzLWvcCKUhjEN//DcfqJQnItXjbytwAoH6FEz//6/6xJ0yvr7mBjtLvMWcBCShgGGbp2BnM0slpfnVN58UCepv8LDIeu8KEz8rxW7tmN1jbV8YDikWng2VU3+0Tg==
Received: from BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 21:21:59 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::41) by BN8PR03CA0009.outlook.office365.com
 (2603:10b6:408:94::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 21:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 21:21:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 14:21:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 14:21:42 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 31 Jul 2024 14:21:41 -0700
Date: Wed, 31 Jul 2024 14:21:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <Zqqq5JYFswS49z2L@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zqp+sssdo80B7MaB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zqp+sssdo80B7MaB@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 80559811-1510-4fb8-a375-08dcb1a6cf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muAgeNFwq/mRfKssyLATuht1H1so1dSougIShr/fhKoWpFgD5EHFlITWPkGa?=
 =?us-ascii?Q?ZOl9pBIOgqyuVq7YqJHPPKwNJW0Cj6lMpv53byF1LKiBZOop2w7v9MC8x+Vh?=
 =?us-ascii?Q?6qM8unLCc/mCTyztuz95UGXzbgUfMsUdzb2XRTteH8NeSm7XdS/bFrJxOUEP?=
 =?us-ascii?Q?LaJOkotuDtOrasrTPQZw5oKQwP1O6dOXMYiQeUuWzEZNFPtlUUWj8hzgLyYx?=
 =?us-ascii?Q?iHfQ4EufL51aeH8zBNCoAH/9k40z81no8BiTTMP80zxeF4GtL3DHLPEJLhSD?=
 =?us-ascii?Q?Ubus/4tDlkcqwDM691VOtKNvY5ySlNDdzjrwEMkH/s+3pw4HVc8TglQ0b7JX?=
 =?us-ascii?Q?+u3czVBZ9y35htF8VjSjWDzfUvGwKzrqEoLS0PBAgL5foE+XGnd4JqZM2WT5?=
 =?us-ascii?Q?vPWwJzqJVzr/ooqG0eXgbYqvQZg6sHPAAG7UaHpY5NCRGEWRY3qgOyB4CdKO?=
 =?us-ascii?Q?iO/6m5IysL7K9ViyrN81C/acwBfyREgMAR76iPEiwVqJFWG7nbkREln2H3AJ?=
 =?us-ascii?Q?u51tUIm9zC+onyA4IRl552EooygXY2tzoUhlm1C7e/M55XEDAUYbqbRYnEtX?=
 =?us-ascii?Q?nwbKqB5UJV1V4AQVm+X4c1sTKmYUI0ubWrY0VaGkM9ie1C1kUMFIzmZYGZkt?=
 =?us-ascii?Q?LX9ve69TV1AwfehGX8Ho6ydN00K2Tn0WJUWEaSkv/ssQMRxRShOCwp71N0jN?=
 =?us-ascii?Q?OSNnPYab8fC+Gw4W2gIMYmq6YgzYpAlBKDxhlZZmyrKFdG3pLugfv46v2ljA?=
 =?us-ascii?Q?0yJHtH6UZ10jjgVjEmhJKOaL8h0cmcbLyrGUhIAKGKlETaU0BQZhRgUk04JK?=
 =?us-ascii?Q?jGvHFmEkqqNI6q+rQIqKZm5R4e1OuNR7RPnQGhbHG5S5yC7bBKOouiNsbjH5?=
 =?us-ascii?Q?PUCy8RXyuwCmWTzkNcXheGSk1dwym7L5sMorNajpkOYfuflJ8S/6mjWGdDUI?=
 =?us-ascii?Q?EbxzZtdrryjAg96HJ6r3vSAhpHLixDPGIRx9GpkE8CfvGONhnilrRs6YxhDA?=
 =?us-ascii?Q?V6+LkJh6hd3/QuaF3OxOCRY1wHSwKMh2/rIth1YOcOITo+hGFlvl9c4LzV2d?=
 =?us-ascii?Q?PSiJEkLx8t25e3WQNinYJQu7MUK0cx092cbimHJsmyw5Zchu6VIk0mKOO1p1?=
 =?us-ascii?Q?1iFaR6kv0D1QHFzRQKdbPO66hlUBCe6i1wxadZplsL3qZu5Sl2765tG85rMY?=
 =?us-ascii?Q?mUCyNHcX7s+HiWulBAaIRxnoUXROtk8FBigps77huoORmo5F1db+EK2KihF+?=
 =?us-ascii?Q?yKRK5XkW5huC2snh7ImnMqdBzax/MWkcZbjxIeFNK2+0kFxt+jFFFIbynu6m?=
 =?us-ascii?Q?0DfMlivHtav6uTkTV3LJwBFXsgdu/TPgVSrDH/X+dEbit1JJADiIfmf2DZay?=
 =?us-ascii?Q?omHF1vx0P/a3FyD5BkMA/IPRo02wNXM9z/diN8kDyrtTjk2Msnp9Cz5KQMbl?=
 =?us-ascii?Q?kbwPcPsCbteCPiagPTQXLbQkQ8zc0omi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 21:21:58.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80559811-1510-4fb8-a375-08dcb1a6cf65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

On Wed, Jul 31, 2024 at 11:13:11AM -0700, Nicolin Chen wrote:
> On Wed, Jul 31, 2024 at 07:45:46AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Monday, July 29, 2024 7:51 AM
> > > @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct
> > > iommufd_hw_pagetable *hwpt,
> > >       }
> > >
> > >       if (hwpt_is_paging(hwpt)) {
> > > -             rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt),
> > > idev);
> > > +             rc = iopt_table_enforce_dev_resv_regions(
> > > +                             &to_hwpt_paging(hwpt)->ioas->iopt, idev-
> > > >dev);
> > 
> > Is it simpler to extend the original operation to the parent S2 when
> > it's hwpt_nested?
> 
> Likely. I recall that was what one of our WIP versions did.
> 
> > The name iommufd_hwpt_paging_attach() is a bit misleading. The
> > actual work there is all about reservations. It doesn't change any
> > tracking structure about attachment between device and hwpt.
> 
> How about iommufd_hwpt_enforce/remove_rr() taking hwpt v.s.
> hwpt_paging.
 
> > With that I think continuing this per-device reservation scheme is
> > easier than adding specific reservation for SW_MSI at hwpt creation
> > time and then further requiring check at attach time to verify
> > the attached device is allocated with the same address as the one
> > during allocation.
> 
> Jason, do you agree?

I came up with something plus a bit of naming alignment:
    iommufd_device_attach_reserved_iova()
    iommufd_group_remove_reserved_iova()
    iommufd_group_do_replace_reserved_iova()

If it looks good to both of you, I will send a formal patch.

Thanks
Nic

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 76b7297d22b0f..f03218dc4861e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -338,8 +338,9 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
-static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
-				      struct iommufd_device *idev)
+static int
+iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
+				    struct iommufd_hwpt_paging *hwpt_paging)
 {
 	int rc;
 
@@ -374,11 +375,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
-		if (rc)
-			goto err_unlock;
-	}
+	rc = iommufd_device_attach_reserved_iova(idev, to_hwpt_paging(hwpt));
+	if (rc)
+		goto err_unlock;
 
 	/*
 	 * Only attach to the group once for the first device that is in the
@@ -398,9 +397,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -417,9 +414,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommufd_hwpt_detach_device(hwpt, idev);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -451,8 +446,8 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 }
 
 static int
-iommufd_group_do_replace_paging(struct iommufd_group *igroup,
-				struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
+				       struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
 	struct iommufd_device *cur;
@@ -460,8 +455,7 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (!hwpt_is_paging(old_hwpt) ||
-	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
+	if (hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
@@ -502,20 +496,15 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_group_do_replace_paging(igroup,
-						     to_hwpt_paging(hwpt));
-		if (rc)
-			goto err_unlock;
-	}
+	rc = iommufd_group_do_replace_reserved_iova(igroup, to_hwpt_paging(hwpt));
+	if (rc)
+		goto err_unlock;
 
 	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
-	if (hwpt_is_paging(old_hwpt) &&
-	    (!hwpt_is_paging(hwpt) ||
-	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
+	if (to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas)
 		iommufd_group_remove_reserved_iova(igroup,
 						   to_hwpt_paging(old_hwpt));
 
@@ -535,9 +524,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(hwpt));
+	iommufd_group_remove_reserved_iova(igroup, to_hwpt_paging(hwpt));
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 04109572a53ca..618524e1ce9c5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -316,7 +316,9 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 static inline struct iommufd_hwpt_paging *
 to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
 {
-	return container_of(hwpt, struct iommufd_hwpt_paging, common);
+	if (hwpt_is_paging(hwpt))
+		return container_of(hwpt, struct iommufd_hwpt_paging, common);
+	return container_of(hwpt, struct iommufd_hwpt_nested, common)->parent;
 }
 
 static inline struct iommufd_hwpt_paging *
