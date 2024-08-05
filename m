Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D9165EE4
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881047; cv=fail; b=foFXW2iE+xvSmBcu54/RQlput605L4/mlaPbZ/cpI9DSRmgmHD62VkwDVZz0ox3Rjao8JqyjpnNKOjOENsgzlDEf4msm2v+9SysBnJPrIZusWUkIvO2CFqKAMRzmqkuRPcxqerzqk/xRCq6K4NfzDWZ7yb91pNKjo7WwBc3OBLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881047; c=relaxed/simple;
	bh=bNeQnA2BDKEFdv5tlV/z35mCEaI2MwkVJWXrUyzG8VY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7/GH1Qw3piDcq9yB6wsJHVZDTrcVf+HZ+lGgLHz7CQw8obnl8Gqd1w/cVVWLz8Uf1CSlCSrKB5g/6KtqLLhVSSh8b40A34uC89f8MJ6xVSKsPyrEbKV+gwj/REmgLTD0ClXNjXx2mQ29a0X85OI8Mujy2ZvOFSGW7fKlHNwI+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/ek6czW; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/ek6czW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtdOTFqaDgk9PCfh19sesnoBA3xT3Fdnj957QM0dG1fnua6QjQssG2u/VJ2UdGmchQRgpGc3KGmrvt2ZR+FR0NJM+dhMxTojBo5Dn6Qy8d2hTNU9GxkRf68lnWwRQOIXv0WntKH40uVyM86sJxhTImgE8eFx+92qAvwMk73nc9NuAAa4LRpZzkteBIh1dIZqchDlHNkqBXSTBlAcGRakQt/B9qkusBlJC0lQpC6CQ0KIlTLXMhEG/IGAdEvuNa85wTnqBAkBe8nvZX5stS7i8xLoUHQNdCvZyT80PHaaa37OubQTYr0hoC/bL85pdywpysvRu2QajdB7ni/yrivHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs1scsdw0lAhhiO5/xhxymVJD5XV+wOifbLh425WpxA=;
 b=jtwgJXda+7dF8+R4h0N/UaRJMsldJDf6nwEE4OeSs2hFLglic5MY7ycw9Tb21PzAaaA+UiT2oac4Pmg1QBukmCq3jArB1EZhBX539zMxH/GrhHS77f6FEGivbv5RGc98C/jwulrG0MY0BGbUjxhZlX3aNLpIKcRaMu4gxu633DESXlTZwdHIl+N5n2a2tkYkYCwJQILJgx+EPD2iUeUvn6aQtxTp/gHw5nMZp9XuoW4I/yK6oQk0YnlhOeKQctJZxVfByfWEHg7b3v8FTxN4Wqzj5zgDwTRgwzFIye5jXDtJEinYGEmUx8xggnDwAzv5Dau3pkE7xy63pvlDHfcnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs1scsdw0lAhhiO5/xhxymVJD5XV+wOifbLh425WpxA=;
 b=U/ek6czWhqbiYKD0DnRK6hiaFXOqk1IO/rBUqwvCCKsZ6v3qJsLRn8fm2335/P4HbxhdMSyy1GwUUCagKpjAzqelCk0u+DTe+co0QReW1jQfv8FeWBQnvpH6eY40Pi/eotwXKYRzu6Rknr8tKZLG2XulDM8XwecrE61BWzvoPXs3fDzEaD0rfFN29MxJRB6GLAL1LxszdQjTGjKaGLVXUSU7sCl5+cMQOnsj7bX5uTer+VlQPC34WxWrRDM6+gqVNmakmNqfPTcxTjM6Cdm7RN4/Qfp7kPmsbUwX73cNVBIO5xzPdxolHRbTUr+AAR80MWYGs1vdXoJttbrnWvC5cw==
Received: from CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 18:04:01 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::e0) by CH0PR07CA0022.outlook.office365.com
 (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 18:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 18:04:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 11:03:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 11:03:43 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 11:03:42 -0700
Date: Mon, 5 Aug 2024 11:03:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/device: Enforce reserved IOVA also when attached
 to hwpt_nested
Message-ID: <ZrEQt5r978B+Pgex@Asurada-Nvidia>
References: <20240802053458.2754673-1-nicolinc@nvidia.com>
 <BN9PR11MB5276B6D6A75FFDF7DB14CAC18CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B6D6A75FFDF7DB14CAC18CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df43ba6-cbfd-4cb2-117c-08dcb578fc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtGOgDnCCA/YU1SAavopCMducDPrAqH5bR67etII5mIuvM7sWrQEdHJR3PaA?=
 =?us-ascii?Q?+rtzbyCbAi1aLpSLDLa1BNhsXE56ovnfRMlE38hyCvnGNEEdmh7ALytEc4yg?=
 =?us-ascii?Q?HtOwTQXSUaqCS5MgmYoZ5LjDuqbrva3ruULnolfAI1bF8F3DXVRmsV0rH/1N?=
 =?us-ascii?Q?PLimFKqS0EX65Sh1aLKpswf/+p2zEo3KFuroFmvoEZ2lPnoioRDP2t1Uj3Fm?=
 =?us-ascii?Q?buzVS1KH9bjBP9R72Enkx5lACEHsS7lvT9z3PF6iOdecVmpvsxeH0l97xn26?=
 =?us-ascii?Q?XewuvKfxlCdUyYeDM+MA5DyyIaMp2o2uKcfUEW2jnvuESGu1zhUk9aDh0uHa?=
 =?us-ascii?Q?UmHdcOFkkrQOMnBcyuFblrjh2tqaAm0quhriJKZZrpawQPUT+zdlnOoSsBCf?=
 =?us-ascii?Q?wWQNqeHhjHYm35O+P3UPs0uLRReyUxyA1ifRNAwrzncyxt6ewyZSJeviyHo1?=
 =?us-ascii?Q?1IyHetA+M3JCbAzkENTY4kU8F1lXLM+EfjkTR3RnrCCIlY9Wfq6v+0SB/9zo?=
 =?us-ascii?Q?EAjkPt0fOfKLcOWawPKMBMmoEPyvYobjA/88KhF7YLUhGkIGiWYW7fNBVpZ2?=
 =?us-ascii?Q?1rVmG1dLVP5Dbo7uAWmWS8V6p9pcwLUNn0hvHpAMw8v6KXGm6pI8P30692Lc?=
 =?us-ascii?Q?7FcjM2ldoP3leSp51ZtvgL0blOIBAlLcV1chy82XRWTCxshQcV689fTiJ+DO?=
 =?us-ascii?Q?CcrdhOmLxr8Kkjy4bRPgNm/2Y/nQUBsLa/26d1wKjIbomO5Qu253LZqE49c2?=
 =?us-ascii?Q?QaDgDr94hyo7UsgGLj4R/ELHp7oNQwkjpI9yANMAkFK2OTutvK3ESX33TIDB?=
 =?us-ascii?Q?y116AnbNy60KQ0h5/Y9vZZP9e/MshvPccC6B8RLnxxcLFObYQCbBNU5udAL/?=
 =?us-ascii?Q?JjdUHFqVPybvEHNUH8qJGQkL+SwG8cpuxUV4UpIn6D9o7yZkCilqBbzoN5Tw?=
 =?us-ascii?Q?8l4i34hOZfHAFVrK7o5AZZdLBmicTADugK5TobRafzsv9lOlDdEzepcKzjae?=
 =?us-ascii?Q?RP2LBbug7CvtYtOkPjrnh7cGTWXpAjVxnQirgY86AQbKmUuqXx6R1hIZMaKy?=
 =?us-ascii?Q?1g1dOP1Qd9Re6BREbcCWVe+63opLNtp6VqYkGBH2rCSxfKrdIkxhrfwvnCSC?=
 =?us-ascii?Q?cisbgrPgzHOLoGmV69zV8fUjG50FsQddKL6NeQSVj7nCYl2dTeKZi0GL3/qf?=
 =?us-ascii?Q?YqIFUeJPGBkiizcVnevET6sm8gyhJxoLyWiVYzLFOw+5l9RAaHLyWnVb5LRQ?=
 =?us-ascii?Q?axrpZNmvQP5OfV//zkdl70fTf6WaEEuI0XVWK+T2plAynX85f0LmLOE0hXfC?=
 =?us-ascii?Q?sQWuIf4E0gOnyU2qaVsxl3UFAEKtfaGHXrW/tcSxNkF99yHb1l4m7DkK926G?=
 =?us-ascii?Q?ZRCihd9Z0DPFlqPSIQWtm6WlT5jbshn7WoXCQ1iOWkH0D0qN3JGo72IUTK2r?=
 =?us-ascii?Q?CntoluVcO0IM5lxfdjroR0irOSExdSTO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 18:04:01.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df43ba6-cbfd-4cb2-117c-08dcb578fc7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

On Mon, Aug 05, 2024 at 07:40:45AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, August 2, 2024 1:35 PM
> >
> >  static int
> > -iommufd_group_do_replace_paging(struct iommufd_group *igroup,
> > -                             struct iommufd_hwpt_paging *hwpt_paging)
> > +iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
> > +                                    struct iommufd_hw_pagetable *hwpt)
> >  {
> > +     struct iommufd_hwpt_paging *hwpt_paging =
> > to_hwpt_paging(hwpt);
> >       struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
> >       struct iommufd_device *cur;
> >       int rc;
> >
> >       lockdep_assert_held(&igroup->lock);
> >
> > -     if (!hwpt_is_paging(old_hwpt) ||
> > -         hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
> > +     if (!hwpt_paging)
> > +             return 0;
> > +
> > +     if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
> 
> hmm this change is broken. In this helper:
> 
>         if (!old_hwpt_paging || !new_hwpt_paging)
>                 return false;
>         return old_hwpt_paging->ioas != new_hwpt_paging->ioas;
> 
> Obviously the original code wants to enforce reserved regions if
> new_hwpt is paging && old_hwpt is not paging, but this change
> skips this scenario.

Hmm..I think that is the intention of this patch?

The original code does that because it didn't enforce reserved
region (to the parent paging hwpt) when attaching the group to
a nested one. Now, it does. So, we basically check whether the
associated ioas has changed or not. Right?

Perhaps I should have added a line of comments to highlight it
getting the parent hwpt pointer now for a nested hwpt.

> >
> >       rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
> >       if (rc)
> >               goto err_unresv;
> >
> > -     if (hwpt_is_paging(old_hwpt) &&
> > -         (!hwpt_is_paging(hwpt) ||
> > -          to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
> > -             iommufd_group_remove_reserved_iova(igroup,
> > -                                                to_hwpt_paging(old_hwpt));
> > +     if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt))
> > +             iommufd_group_remove_reserved_iova(igroup, old_hwpt);
> 
> this is also broken.
> 
> Probably it's clearer to continue open-coding those conditions in
> iommufd_group_do_replace_reserved_iova() and
> iommufd_group_remove_reserved_iova().

Here it basically compares the ioas too. The original code too,
while having an additional hwpt_is_paging() check on both hwpts
because of the same reason.

Thanks
Nicolin
