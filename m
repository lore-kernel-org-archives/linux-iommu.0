Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09E12D758
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478774; cv=fail; b=ImDgPR1ZlPhwmhxpadzSrl5RHszsxmmCbJI0cKK1NAakJrblkDg1wCBmCU4aEKN08+0FXCyHzZ1fKEHEml074+dcK/U+iQyuK700bXqOYuTibuajBy00GKT0YWhEGrE1yW79EuVgjUtYrQuW5DAXAHD0s/EjRns80Elg5KKNGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478774; c=relaxed/simple;
	bh=90UJRbIb67bldhSUS+AB89WLQixdrXiI3G38V+70Oiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUffm1z/HlvAbcuNv2OaNllNy7wUFF6syUNsxr+hn+D9S7OjVYXZoPP5zRdDZ3Hxs4BhwFU5KKVqe4pq6R8Wu1mu5/7DT3TKtpOjhfKSloTGVss+Xp3ZV7kEKnpPwERIsGO2HRqlzfVN9yDQiFcMYyqa2VsGCBTuw1bQyXIF9RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHxt0qAs; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHxt0qAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8jaLq08tCwDSb57v6tCHYsMvoIT0FLAhvyeDnRrQdKcGyqyVqelrDDd3P/goorJI6sPm90ZPdUEXJGCOxSKJoHO0NU7+71KN4UJ25lRb5NO7nUxYTNHP8B1awIgpdv7m4wBJczwVsro6a6y5OIy5Q4yU5MbgWHEmXNqOnXKvL+zab9rrLVLhbMPgL3NLz41N68eiX0bimgGet2ifjZ5XSHS6YDw+BgNozwJ/IZ/g/sx/2Im+F/qxMz8/et0iym8w9uVe8nkKAsGUIZ79pKVpOGaEKZTXDQ7dRLqE+8uOLJi2xfZtgcWMNc6bZjSjmgJLcJ06V9zdue9F84vSPiYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb33lr9WosHWE3vFx0ynsxeFsf9cWnN8BFIcsSvIrgY=;
 b=VD55gCdUG3vlLYVxXfUS6+FV/FpOSrZ+GnyH+kgcPPgz6hENRopb1x0WKMeteAYTGbUI0qicnLykesL0AIRCU1RvIC0idLReMk6WT4ZqG63kTBslXP0j0nL8rdm70rCQkGqQT0Fj4CDs45sMvQTcOYwd4pe1gFvgjS70piMBP3bQp8TfrX4j3/yXtIya2pi+U/5Qb6DGgn6ToKfioA4KwO1jcELpdFOiHuI284OweW+h+OebSzRx7NDzerP/FfmRbwTzo/SoL+GF614mGaaaR5GtmhYdkBDOXudMzA/1tUXAyfNW3pS/kPJDsPQdzIfrN3c0MW85HGIF2tJRz2NMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb33lr9WosHWE3vFx0ynsxeFsf9cWnN8BFIcsSvIrgY=;
 b=pHxt0qAsCvNeH1++2tojuRMJNP7cYlwa6PvwSx8kAlruJs7U1Ff+BxEJUSpEQ7KBO6+AsvbHr5t7CMTjd1NZ8EkKSun+pSFG9qyz6uGR5UHfFPLXj9juI50drLVRsShMRwj10W/mPD6NitPijcoHJiY2Z2SbfANz/CfP2EEhL9JgtxjqYfJ4VFa2OC5trhFrXmpF3r9w0SBMIT1Fm9RoLlg1MkYhA2BJveTI7ywGofFXGw+ciTILpWNJ9Z3Pt6FCeW04sQ8i3U+kwxYEAx8pt4daMapRvQs27SIL4FycRGkAXZiMVV0abDJf0uC+4e1OSaR1un1y/+zmCF8OjYtFrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 16:32:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 1 Nov 2024
 16:32:49 +0000
Date: Fri, 1 Nov 2024 13:32:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v9 06/10] iommu/amd: Modify set_dte_entry() to use
 256-bit DTE helpers
Message-ID: <20241101163248.GW10193@nvidia.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101162304.4688-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:408:e5::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 003864da-0ecc-47e6-bee4-08dcfa92d2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CLIQmxjW+i2lxAeY1/U+QXyTwnHqAMO9rY1fdBWiesMKNhdvvJ903P0OGv8R?=
 =?us-ascii?Q?G9t166fdc9fCn028iKxKWIQDAhp3UT7mimsgcUAh2AW/Bei/ApJ4CGx37iFp?=
 =?us-ascii?Q?2qxttbUmROeZPdENsNsTI4QmNdMfX6zbIFVAfGCFWXumxyHIQfn9bEHam6Cu?=
 =?us-ascii?Q?SYp/YLxkxVFMcfpRjKJYvs5p2sc91xy8RCulTNtWJJ2UMgJYVgS11Tinbkv7?=
 =?us-ascii?Q?cf+BMF1n23WNP469Gv6+HBNv3eCS0YF/dqhJkGqiW19FM/jbkKCXGech4gP4?=
 =?us-ascii?Q?1G0Fwu7ROeBd/s8eOztpXKbafPIxXdEHl+SxhORpfddNyHEwyzoU1RROuwQ0?=
 =?us-ascii?Q?hY2ER5ZxWLfwsSWp/IK1YbY/Bw+d39r3GLNv0Z0GvoqEKyp13+JsW9S1sluS?=
 =?us-ascii?Q?ddjdJJ8DCxMkn5N3ybUQibXSPnFt4yF8cYZkQZJFdAZmrod7LgYp9ZRS5mx3?=
 =?us-ascii?Q?H2JKMlplN48G8AWEMAOHt2mZHkr36ydNloJ0EJOzNYod1w/MlIQPyjlSL3Qr?=
 =?us-ascii?Q?PowWpS/4zvUXRN7/uCcH3B8ttzGN9qiYGKcFbDlaAlKVt08w4Xm+3I/Vw81j?=
 =?us-ascii?Q?bQES1b/Ei0P5wnhGfOVhW0llGyTI5pnklNSzDpMZbL/QKQpltSG4nMMxtJl9?=
 =?us-ascii?Q?nKw//HFrFJexEDHZdra0mG1vNo/6hAEETrhBTE8DiTJ/9DwNZrcSYQ3BwYOr?=
 =?us-ascii?Q?kIyVjfgZa634lYHebktf6137KjbSYPuFP1NoAUXYHcduQ9x285XkYA7N9fYz?=
 =?us-ascii?Q?pvD9KQNoChTpvx2UHQvtdEGxDStRNbNWfCW0GU6NSSe6PrPEVjjALp5yeWHb?=
 =?us-ascii?Q?yEEY4sZclRAs2cf6GIdYMFUpX0MsnQzqrofXVoWTqWGGErrAGslKJfcxzW6C?=
 =?us-ascii?Q?R+fiZfwTM4plk5HPbn/dy1LFZO8AEpqr1gyQgbJcO3EhvnY8qD7tPmP8S1j1?=
 =?us-ascii?Q?Q9I1t/nwYcwVAx/fk7lsT/y1EQz4FaXtfawvQGqqeW5mhjxroEzOhRiptp7t?=
 =?us-ascii?Q?K+o+iTHyiRO0S5rTNwuA9kHigqyiKpmlTmA1UzP5vrWn0+DOrpZU4qVyeoFw?=
 =?us-ascii?Q?ZeBAxgnBu7YX27JUg8kNdqAEQEyHfXwIqyg7sMI1RpuGEN/L1hZvWvgdR1jH?=
 =?us-ascii?Q?S7kAAgIPNGMoJPfTJfgza2Rt/oSPcmuKWhk4x1yYDsDBJgj1zNwLfpBzEdoW?=
 =?us-ascii?Q?RoLXWDeb8bOfBgrAPBw7T3EMkLLz0xkxED326Ywp8BoQ+VdHBH6DXZC43wK6?=
 =?us-ascii?Q?IE1izQHUQdwT9wX/T/EWU1h83GFBrcwNzaeLf2ZiXoc19/TCZsX4UciZgz4z?=
 =?us-ascii?Q?VaPGxFGYUi3SmZ/nCUJwoLzc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5t73Qjt0lQ2oM56ZBwHDFxZ4k4w9uoH7C2+n1e29pLMnK4BpMOXp2PrepgYU?=
 =?us-ascii?Q?K2LiZneKKRQQuAsd3SdnX4WflUQ7ah/h6pUZ5+MjzH2uSzKImjn8TSjEB8af?=
 =?us-ascii?Q?FTbV55FZ+LomYfcc6cpupy8gHvlMJdmrZa4OTl67Y8wEZ2/8KNRbqDBm99g/?=
 =?us-ascii?Q?vlxWiF0MN7DOlGEfJcpd6ApAl1mGLWZ/fXWzxJd/voertzsVLm53W8KK08nV?=
 =?us-ascii?Q?js4EUUBeDovMiIjlUY7XVVlVx896Y9V/wLWFJf7OGIbuS2Oe+qrAZ+tvkxFg?=
 =?us-ascii?Q?0f9CXpWxZ2qM/77bSnnnpXAtd3WZhqqNwT6hTMgmc7ETA4GZDTPWfVOAjASi?=
 =?us-ascii?Q?m8o3dooyO7mL1nD4aZF22wLFnItWGCu0hnDoCokAQVhIgibrwd8bKfmih+Vt?=
 =?us-ascii?Q?TOf4/A7Ncc0M716b7EqHTEhPD1yrV4z45HTjYQF2Qt0hKXyBsUlhk3eA+gVb?=
 =?us-ascii?Q?z19lYykTekf4M5d4P94MlA07BR1b+ND8pugy+5RulST/2pRS84bQvWXVhseK?=
 =?us-ascii?Q?bx6UmTWbw15gF0g/l+TV8tUIBkCt8mdihxlKxAD/QY1BNWaS/jK+wRv95iLt?=
 =?us-ascii?Q?93/ieRcllynNpeMXpNE7sx1SJSBAr8G1YWqA4qHbiMCepPANil7xFWTJo2Up?=
 =?us-ascii?Q?81BZWp5L5HEUjCPTfgPvmxxfWWE23ymazS3JKzU+b7jufqIxVCQRopnFunb0?=
 =?us-ascii?Q?IyHhzVIXdQ7YPKsxfneHrQexMpRU20PNPVcxCW+OpgLsGunrJ8DOfY7inM34?=
 =?us-ascii?Q?lBCmSx4jn1MP6VG6FdovUl0XscB9Nf8o1mOvdYtjqEqUi5WK84b/YLQcZ3Yn?=
 =?us-ascii?Q?VXViBTL9DdWIG8dL/GxcyjEW9KyJjsLicNfCiNPXRe1oRHfY3inVXdELd7uS?=
 =?us-ascii?Q?l/HoAd9R8gMqviLjzbogN+yro2gkgAtC4jMwHPHk1chm7kS8px8it1JIhSYx?=
 =?us-ascii?Q?f/HWWJfX5AS/mmeg7uUeW7GftPhcHtBzfVmQxlbY6y6QUunvfbdDVhTT9/zK?=
 =?us-ascii?Q?m2ZiZ3Wg+PCq5EE3+UKG7Hh6t0vjcbJftWOglsvdYUqpCBfNmkSvRbR8TGxm?=
 =?us-ascii?Q?r5xe2R/MRHnTl0JOt5TOHrTdy2TTMrzOwI+FbZAnd9oDnLH/RDplE7Ur7+IA?=
 =?us-ascii?Q?c+ZPeF6WUi4EX3sYBen7zBeB1ucn2Z0bR1KVHLf6Fqv6uqh0acvbCd2NJSqe?=
 =?us-ascii?Q?TxujlIDCyWyD2jGUtLsiSTkmQiQa0gBSrJ8izQkdSVF69w2PexZ2+rfExDsz?=
 =?us-ascii?Q?YfmRQA225QW6gFwmJ+iat3MdC780z2llL8yYOqsLr2xfYF0KJCvrzeq7RXrc?=
 =?us-ascii?Q?ohiFpbLKHtD7OlcZsPR36ChhbYaXwRE1RMTgGLetKs8euWeM7/2QSty/8Eku?=
 =?us-ascii?Q?wCUeNG7O6GumUhuw6D3Qn8eHxzfm8pR5DSNhyyfTOsdHekrXNWz5Vbgj5Klx?=
 =?us-ascii?Q?VKP8uFIzo1noVciS/1DshUgjzBA2j4WXqezM99DhHB9ndMddSFYKP4Q87sl5?=
 =?us-ascii?Q?0qpjBdXcSCgijmLsCiol2l2uke6RsRcd2Hm1ZIH7Dk2fL/F5S3oFlA8iqGA3?=
 =?us-ascii?Q?Llr9NYQ8KZLW60lvBR4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003864da-0ecc-47e6-bee4-08dcfa92d2e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:32:49.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcmC+dhovqR9eElXXZkyeqGEI1Dr4gEJOMZPd3PuztKwKXshLgE/7bbv8PjbvbUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

On Fri, Nov 01, 2024 at 04:23:00PM +0000, Suravee Suthikulpanit wrote:
> Also, the set_dte_entry() is used to program several DTE fields (e.g.
> stage1 table, stage2 table, domain id, and etc.), which is difficult
> to keep track with current implementation.
> 
> Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
> another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
> GLX, and GuestPagingMode into another function set_dte_gcr3_table().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   2 +
>  drivers/iommu/amd/amd_iommu_types.h |  13 +--
>  drivers/iommu/amd/init.c            |  30 ++++++-
>  drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
>  4 files changed, 106 insertions(+), 68 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
