Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61C3090C6
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760527; cv=fail; b=U+PjvOcm5zj2o27WVjalsWguoHOXmfUiknh4LHjVlyKiTs6s3OjJSJigE3kypNtHL8vKTbgkILFTJZrCt7uvZwLEMCNQMD7nVQAWD5zTASJTgJ0qXssv4qbHNax3uHMIXTOrFsubnEMABrROjD6mV1bQvUbxyKzrcmP3F97zBJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760527; c=relaxed/simple;
	bh=9F+TRF61V0rH/YSj7iA64efnAjAC3JCEQ+ExLe4rjjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXzbhwBlEAaRrZR7xFnq50P7fYjZNlVwJAW0y/ZEoRkAFxpsXkNgAlnaJG+DhtIlu9HjDC+drTrtjnS4jbhy1go536Ax+amEGiDuJJ5tyRlWDD3pbG6lUULV461J77zVlDc79StDHzSWpOwo5buTmmg4xfRt/QlRjm687m8/iPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhVyvQFX; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhVyvQFX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDatscuG04ObZFATscPrEe3tF4Y5LdC6Xydp5jRdhBrqqEvdTQG6SQdljtvxPKDQpEtQuRldYjjuSH3j7xOY8xo7+V8yuR9NX2zaf+osBr5QFo+drIiQaAmuTBFnwOGSTy9my9MubMPGZzTurJUC9CilhsfI/JcEBIOp43f+uSQNOkvlKMSLHMw1S22d/F5daS5QPpt06H3Jz43DWxsAcQ/CI2Jys+ZjwVoUIStP7Nv/QGz6RA8wp000xC/6pTQpimkjBie9qCbwfTgg7yJwLbIKjOXDvIPeQPDfZJliowNDse3UPl23z1NreFe+9G1b/U/AH1kFTEhc+fLxHggZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k6xsO5xV4et3PNFo2vm0oPZTPOv4Kp4Lswdbqf3Cps=;
 b=Zr6gjL3ro354JBH84bC2Ttwf8ibopj/sgBOaB8ZhcVLywdgyASytiofTK3TrpoXxgPn0k+jMoKo6fZBm6fI3nhMV7DizV/1urMwpYglio+D2uBHfMIPOS/7IfJlH5j+9us+ZrPGDHHIa2+/H+5MApXd1fpA8mjbMe+XxedhY4uyb92sBO023Ep9/9ixW+WFP7M/JwmEpqcfsi5VMEO/doyacCch9LfBNlNxSNn9aHiLUjkv26gyR8NVV9BQuuCAXHt1hBlsm10kR0tkjYbUkmynP1dxSpRFKQXaXSnw7MecrpzEnzBXNhJh+XdfwDm9YFE82unlUUWir9Bm4mzr8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k6xsO5xV4et3PNFo2vm0oPZTPOv4Kp4Lswdbqf3Cps=;
 b=lhVyvQFXi/0FGh0XrBs1KEQai2rZbzGMxgb9kzmGmd0nSJ5OiNl4FT5/D3i2n2Kzo+DeruwJ2xs1OU70Mqm36iqMaWNo+gne0i85T3sip5s+O4byVEnSq9Gn2aYKM9uxxGe7pB1P56z/QfY63l+uKrd8paZLpMh/A8YmcOaGuBQKaCJR5xz+b6RZiW5Os5c+547oXBTfZm5RHFeA8SAtsX3cIBJSYB1p4k5TNawpHUeSPpoeKUZWG4QF7nyRwbS6kz6QD9h9AZpN8uKuBlcteewIMmL53ieLZCMIiZU/JH9UoVxD/5MQfiqCnAXd/+axEgbtbiyhTTD2VixCubRyMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 18:48:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 18:48:42 +0000
Date: Thu, 9 Apr 2026 15:48:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 07/10] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260409184841.GP3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
 <20260403051146.10210-8-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403051146.10210-8-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 24567ea3-8963-4509-385d-08de96689f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y2sDqKqPV3nAQ8uxG7ve1+TZee0ZavL9L2QV/P73J6Yn4WLz8Esv+/aSx0XdJdmUD1Vry4LRRdl/PLWNVWdprg7IgmpzTeHCFJocfQMylbyLSz8niz9Av596L0m2GKg5Vu20UHypCE2XNyQmeadm08FiYhmGoOhl0NlQ3XOJjMdpHK4UefFKTjgFaemzzUi6S7rNJ9I21Ly0JXb+SHSebZjFEBNKoFIGhHfHECOfnVQGbge/OV4GUesyEAGXFXtXDjlVa2pP6fiWyLJIy5W/nP4ZVtPOa/zA2Ba2f/qh6eVM7mm3M8FcpT5EjEmdtfCCW+hI4ot6w6FsNqBygNsvib2GOxXLsgeQlv2+ABTZ2wt+kPWE0RKLesKISvBDIsS3ECoXmSM0TYtsXICB192MR48qjjNbVxALPsimWGCkbHr/EnCdc9BwLDamODnXG9bTPRCZeXa/x8sfvwvdOB+YuGTQ6cvm1hccyK3rv59hXvXngvVi5a8v0CJS1GjbA8N+f0/6pLM0amKppGnKu+TFRBmRZAqg7Z5WplmmFtybQQOLo/h+qXXHnNUKFGwU/6UJN8tACVaJ2UupN+S4qRtCTnywQ90SUSveu1xGC4rIXVN03cTkFuNIuM6inGqZbN+YU6O+A640ILROsHuhPv/UxFddjcbF+7ZajlefitJS0FyUSYFn0OKg/zlf9KKwBdEu/jOxeZiq1EX1+NrH4Gm5JwFggfaeZB21GwJGANoO1Ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9ZBXutSS35I9pRQO+lBufl9oqh2+cfZ6LoC+/2X2amFLsoRWmms8CXGfQv2?=
 =?us-ascii?Q?/9afFDgjRPtn41htcq7DLyts3376RIqOuGEE/e+XCqccTvHqqnuGotia6IB3?=
 =?us-ascii?Q?mYR1hrzwDzujudepoJmnQinLsvl2KO08G7fL8MwS+PKB+0OQWmSp2y1iJMWT?=
 =?us-ascii?Q?NMZ7brtu1spdnbHINjd4O93BRw3cFWtyeYfyixcnmWsO4wuxxS5H0yTKTu2B?=
 =?us-ascii?Q?l5SpcudZ8A/B2P+vMib7fIqIQwJdFNt/c2fiFpm/YSQd7BafDkDlzaU0E0fQ?=
 =?us-ascii?Q?OyoHnU0IXBavaCPGu1hfAtbJxWvAAsmrkC+6dCN6kfj8bVgOpF0quRWwIDjI?=
 =?us-ascii?Q?dbIKjOiX9qsFFmb/65H2Us7qkQG/E9t9LMTPgPFwqQdXpf71smxyFJ9I5Up8?=
 =?us-ascii?Q?0OXEJzrRnu4EXPmjh5hnxNIo5INok7m5xDaIBEL2BlEUxd8e/rKtP/hDtOwr?=
 =?us-ascii?Q?PA+L/MWeV+lhRp16xzMgBPE2Rz7iKnCFpn/E0cnsM/wNxm9qiEz6rlTgJssR?=
 =?us-ascii?Q?aUgMxcbUpYKnyvptEheSzwKo9WrZ6gc3ta0CC+aUXU+DypfTTVrX/jjw8AqB?=
 =?us-ascii?Q?lIirLSNh4x/35bLHRqJtzC+V6Dp7hOqzpyKw8oHu4Cu53IKeNgPPZSv1hgPa?=
 =?us-ascii?Q?T6W3zKfsW7p7jy+KzX5CZxr6dHFpjIMWBTrcVCXhLxj/TYM9U+zd2Od4racR?=
 =?us-ascii?Q?8s3fRSakqiOpCkKYA9FWCgLPxEUNWhlN/G/ho5oTMGXb4Cd3d/FT1EkyATa5?=
 =?us-ascii?Q?E2NW+Gc//EAcQ62XGBfwbEW3W74ZY0pk3wkwahxuZkSND79NDmHYwpFzo0KC?=
 =?us-ascii?Q?DfQCP3vDkLy/WPtDbt3sshc++epvuNjfITh/p6pXhfPAWFD/C4CS/MWwGFYL?=
 =?us-ascii?Q?ZdJOIRRuTNPO37UtG5QLn/9yzWBJPD+BXpQVRadScBMJ+DEOs/Id0PzNaaMl?=
 =?us-ascii?Q?vkgWDa0iKG68mD98jey8rgJplBe+vdGh42dnVvr2KoKJ7kNWBGPpCEmumWXF?=
 =?us-ascii?Q?YY1ZA07ZsRFs7LafsUqTTF5aYyQ1a7dBODgJK/H6tdX3PHdpyFkE9RmnsLdO?=
 =?us-ascii?Q?Yc9drmDZvMQ2cpamP7yd/FQhRUfbBpLMNLEkLKrYzF1x9oAlNqRpfGGSOgMb?=
 =?us-ascii?Q?2TAmiN2ayNia+22YXP2u+A4fudiNBAh09pFkEPtkT6OiOxLBMK071BOBCZ6Q?=
 =?us-ascii?Q?QtBKCJ8i3hVvu4ndbfWBkscT57jAhkzDeqrhzYBzz5bBUqKPDwhk4OTm+OUD?=
 =?us-ascii?Q?71YtuyW+DiJT9BIljUibOhhkLkPyg3o2sdLzSus4QLmX3mbdsEpqmzQ21Sp3?=
 =?us-ascii?Q?uersAczG0McXJkqBXaq9cHEA1qdAMvyJB9YgLba1CEzURZlrUI/8A1f+Lsmt?=
 =?us-ascii?Q?Te4UMgR6DEfDMBaO5vVOGdMDjf8Mgc9IC5EpxQJvsxOvceHnEworX2Uz2KiK?=
 =?us-ascii?Q?OxjtVV+PwY8udBpaJSJwMkAAx9O1lfqwJ6lRJ62D55RTTVTMKo8j0NrxUjtD?=
 =?us-ascii?Q?ud2B3n0zAUCWDB1aNaZs6OqWP/Hj4/94Ps8e4deMwK+2ZW1iCNERoEZzHbGG?=
 =?us-ascii?Q?Xz1xUq9Zjb/sHWS9hLnmuQ1W8DqlcrfARyO+nRLKTtY/oSLcGyYUbD+SbdvP?=
 =?us-ascii?Q?vVl57T0+jbHYWPweDyMWfcdPBopMicbNdYD3Lxut1Vt5SGQyIcYnOTD7Tqn0?=
 =?us-ascii?Q?uyLjMHKs+RE2YfZ3XKVVClUMEMOZG2jKxbB1jtTbqd9s+L38?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24567ea3-8963-4509-385d-08de96689f05
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:48:42.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FTE2zXj4DRbJOnMcMH0BauUch5RyCLk3QS6/GDHRRg8Cf3z/40D7UpU89PvBv0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

On Thu, Apr 02, 2026 at 10:11:43PM -0700, Jacob Pan wrote:
> @@ -392,6 +398,16 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  	bool interrupted = false;
>  	long rc;
>  
> +	/*
> +	 * For noiommu devices without a container, thus no dummy group,
> +	 * simply delete and unregister to balance refcount.
> +	 */
> +	if (device->noiommu && !vfio_device_has_group(device)) {
> +		vfio_device_del(device);
> +		vfio_device_put_registration(device);
> +		return;
> +	}
> +

Sashiko points out this can't just skip the waiting even for no-iommu
mode, it isn't linked to groups and containers but the lifecylce of
the open FD.

Maybe just stick a !group inside vfio_device_group_unregister() is
sufficient?

Jason
