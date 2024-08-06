Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A80129A7E
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973011; cv=fail; b=CUYcPucJDiVUjbVg+FqqyO68wbYHEKJMbip8c7ui/gNtXkY+hBO8mkp3J1AOZfLL4OocKIRoL+poUTGirZFqEAJyTD57u/iPLbWipgBC5q3VUNcOgC9pXxtCgsUhOn73UqJHzbAKUDODM3v1xOoexs3bVMrCexgbANpbmwmGi+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973011; c=relaxed/simple;
	bh=FFi14VVTtioEDNdITEShckD+mpQNZ6VEk4ffSpbpkEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYvXtCOppZeE/83CDAjdNzewatPoDf+1UZo/W3ZuR0TqC6eX4n13hIz3ahWg4A61QdTkk4lcVSg9gKNGRuNg+RJ7QoUNJwzAKvwsyPRJM4qsGAuhC+O0NriD4o5BjXfvMMedsmS28s/XPdWuLvmAtsOZPJcOXnQ+UwfDTPcU8RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pW3rlf/d; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pW3rlf/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6tq8G8RyddbEwvIMuKDQoxT8PoB7qzkvnyEpB87CuCIGiAsI+Pq+TmcyarLEXqBHrsGA9JWSo9584Vi3Qzu0xcJL84A6qixDy1yyb3P4dSmaTK9u9qgmNVRUmlykm39SRPBHmpsHmvjGK8kWYkbytadAkBml+f0lFoSM1ChdUHRlCIlqZVWg9L4gEFstumHbkA8zOIR6yfSqIm420+C1qjt8DBLf9AD/TflJXEIgI3ra3H4GOwPEIBiopOVj0Rn7JXfA62lTFwsgpOWcF1Gdk9VIFY4vDd3wegMmIa/vSz3ID+MRwSJjFW+ROJsXTn3OXQVuUUkY/sOamxI6pWxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qex6aG/3RRLnKuITW1iGRsfgUSRLGencRU2BKIUeSuI=;
 b=P1gfDEA5wJSW+9QAVfSyksBF4ZnXlfIiQo/Qg+fhp6RAivKg2ln7vm+OUqwrqvFZmxLOv/t6Jc7Q4xBED7M0gX+rIMRkpvikR0PVqh+YCXJ/ozWpbbXozz1+UZpBplvtG71KOFGYqGDQGEpAOO/WBYfEiPn+xvnEXDdDf9l8psYiGjN1YzZml4onsOZj4nHpzgPMg/fsuSWQc/tf+DmLVILHLlAs/PobEjc3//4I63VrG0vMlarfUN0rpus+LY6ScT5cjQ69zDmAZFcWly7Rk+6LnWAuX+Sl3F1TcqWyQASdlAINuvTwJrqrgFB2JG6GR16sY3c+SiUZkMuBVSYY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qex6aG/3RRLnKuITW1iGRsfgUSRLGencRU2BKIUeSuI=;
 b=pW3rlf/dlLHhiW+d/lO7CE/9brGHQ9a+XgWs+pFj/nTNOHIribf7VgFjUdWtZhu9o0DAXmi/WPEf/VeG9KZbcdovwgdTodfsvtFxAMQ8ZGrZFdyw5VmZX404nCDGRtAwTN9bTVwz8UkvLlinTYPl5U3OqMRuMB3h9viYVLQogz9zPbH0ttCXDNGIRJHq16kUk2aUfFHlXJYWyStKrMlyr/e2FyEw4Fy26GI+95MxgzC/0DwV4Ow9WW5FVqugTirFuAR8X9KxA/Xfqrb1sd/FOv1978Q8TpCZla62xV1+3nWR7W/AAwh54B4XjH3cADyUmkLkZtdcqPfHrnUekNd4/A==
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 19:36:47 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::79) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 19:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 19:36:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 12:36:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 12:36:37 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 12:36:36 -0700
Date: Tue, 6 Aug 2024 12:36:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <ZrJ7QwO+HJ6rxL6Y@Asurada-Nvidia>
References: <20240806050201.3717816-1-nicolinc@nvidia.com>
 <20240806174242.GP478300@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806174242.GP478300@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b95ee7-9375-4cc1-255c-08dcb64f1bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zqNArTNhubdT0L2RyAAh9LhA6rP55BZf9AWtcjnJcbNwlK3R2sXiHfznTzu?=
 =?us-ascii?Q?8cJv/ryXF9Lnt4bWInFTgsMfbt3S2EwUz/gf7doDPmARao+VcmoYm9HDxmya?=
 =?us-ascii?Q?qS+WKO81WVC+PmE8AE9gWJtqP+E45QxgcadDboQ0MHTJQwJ+aXBpSELClHmg?=
 =?us-ascii?Q?cPAqK/jVnF4Ztf4tiPyZuHelWuM5ttmgyfCN9+7pe0kj9pfTZaK0G2YJbOE1?=
 =?us-ascii?Q?Gkoju48zLpYHjChew0M4BGfHg3mB5rxNwwZ+76Yof9+wORopCbKp92rF9nk0?=
 =?us-ascii?Q?4fNozob28YYIz9IJvPwTdOkLylqsrMve2bxD0ylkdybE1WhvTor0qd7M7Yjr?=
 =?us-ascii?Q?xQQVMow/jFOQRs3G3goY/+LHbM8xq7xS7g+jkkPStwe/YUWJIQOmUUJoMQOV?=
 =?us-ascii?Q?osX76fRhiPQESeOEzj7N+BE6vQFCh6TDG+gqu7EzrM5c+N2OJGEnjfdYPnTo?=
 =?us-ascii?Q?usXRE8KbFVp+2Yc68cgVafSczLX+a8h/pwJ78hywgwv2J/ihR2WrF/nVx+WT?=
 =?us-ascii?Q?yniV9J0fGG7AvXLBMKbRAhLI+gaf/vShdewgNIMH2o1UHPVa6jqN7Wif6zvu?=
 =?us-ascii?Q?BXRFOxWFu8bP6FxIxpuMHZPRDLJZIYG53NknrAPx81R179SYVNgZWF0G6voF?=
 =?us-ascii?Q?jQVtlLHHtmWnBEmAuXNfe7bP6JMA//NvM2Q5dMU5fxSJf9c3jRL/v6IV56S/?=
 =?us-ascii?Q?5nmijVe7pLoUugKElD2ciDCDst1zgz47ZsoBysPYFuG+FBTJUas5nwcAlzRs?=
 =?us-ascii?Q?ZenyYT7CuBYulXwFqvSCov9aKknhmzBSVNklZptFHefP0I/RtY3OzL4mtMAt?=
 =?us-ascii?Q?tPYdjJuFwitSUguf9wt3KRhhZACg8awsOEIROzDGDtVHk9Rs5LpxLxdxO/MQ?=
 =?us-ascii?Q?em4dFShBw/H3LmYdjqwF6dZe7wkiBU1gSTUOEVSlSlYohU4eZSG/+bGBfuQG?=
 =?us-ascii?Q?fEYKkXPjNdjC8p0i1zjSLMMMdqhgm906OtyfNFEHo/PoziObIhKfmhlrco5i?=
 =?us-ascii?Q?LcGRvmQFcNw41LLF9WeNoNvsu9+241PuXiC+xTAYdj/iJ75hv/6/OcYhzyyc?=
 =?us-ascii?Q?C5keDxl8xG3U6MYlUnt+c/W74CD7A1mtpEF8yU/HbhT9lIiLKTgk1tGcCj9+?=
 =?us-ascii?Q?Sa0mZt4zbPmyw/8YWl+CyKKl80GjKtpDxYtqoAaA0dKMVLiDBwJ4aE2cfrJ/?=
 =?us-ascii?Q?+FkV1Z5yREHGSCdBGGm5Oez/l9v8Yp9trcCal61g2LceAaW4F4cdp6OCBrUa?=
 =?us-ascii?Q?HrqO4yes9SzAl0WVALUkZhUlpPdmUIhj4ugTtRpLN5A8/dVPXLZnfxbKwFI8?=
 =?us-ascii?Q?Pj6hiHvKspBGGXP8jifTqC3bskNziA1MZP0vMMgGtQRmUAbhh2WOKNUWymdu?=
 =?us-ascii?Q?5+aRBY/8OPbv0bDSKBcflHQUSMWPNI9sfjRS/LDFmO+S/IhtzBCTfiABuFfH?=
 =?us-ascii?Q?JOxRmdm3W5R0v329xU8TTPW0b+GhhKa3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 19:36:46.4430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b95ee7-9375-4cc1-255c-08dcb64f1bd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

On Tue, Aug 06, 2024 at 02:42:42PM -0300, Jason Gunthorpe wrote:
> > -static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
> > -				      struct iommufd_device *idev)
> > +static int
> > +iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> > +				    struct iommufd_hw_pagetable *hwpt)
> >  {
> > +	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
> >  	int rc;
> 
> This seems like the wrong place to put these types, a big point point of the
> struct iommufd_hwpt_paging was to mark functions that should only be
> operating on a paging hwpt.
> 
> The caller is expected to figure out what it is doing.
> 
> >  int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  				struct iommufd_device *idev)
> >  {
> > @@ -363,11 +380,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  		goto err_unlock;
> >  	}
> >  
> > -	if (hwpt_is_paging(hwpt)) {
> > -		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
> > -		if (rc)
> > -			goto err_unlock;
> > -	}
> 
> Like we had here, so it would be a bit nicer to write it as more like:
> 
> hwpt_paging = to_hwpt_paging(hwpt);
> if (hwpt_paging) {
> 	rc = iommufd_hwpt_paging_attach(hwpt_paging, idev);
> }
> 
> Then we can keep the clearer labeling of the function signatures.

Okay. Will keep the hwpt_paging type in the function signatures.

> > @@ -321,7 +321,20 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
> >  static inline struct iommufd_hwpt_paging *
> >  to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
> >  {
> > -	return container_of(hwpt, struct iommufd_hwpt_paging, common);
> > +	switch (hwpt->obj.type) {
> > +	case IOMMUFD_OBJ_HWPT_PAGING:
> > +		return container_of(hwpt, struct iommufd_hwpt_paging, common);
> > +	case IOMMUFD_OBJ_HWPT_NESTED:
> > +		return container_of(hwpt, struct iommufd_hwpt_nested, common)->parent;
> > +	default:
> > +		return NULL;
> > +	}
> > +}
> 
> There are alot of existing callers of this, I think it should get a
> new function to do this behavior and it would only be used in a few
> places.
> 
> It is not OK for a NESTING to get into most of the places that are
> already calling this.

OK. Let's add a find_hwpt_paging(struct iommufd_hw_pagetable *);

Thanks
Nicolin
