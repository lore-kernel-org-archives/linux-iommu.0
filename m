Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22421B9D0
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905769; cv=fail; b=UDc4ESTUdZ6otiHuU6Wd/PlvdjQdxTNs9e+siK0VwbJ4EMDnFIBwyrfuvHeXzXie3wvJGJbEvy605/4BxoNiunqEtLFwEhonbJ0nb6NtlllNjeSj7Hczy27T6B8Tc05OqNzjsn8DKU4puyQFF1A1Cj7GKzhgvUjHrNHqJvdRYV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905769; c=relaxed/simple;
	bh=km/sVhXNrpMlF0MZfF+pA32HIk3Ya7HlRCO9wAUuDWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TeDnOedB/Le+aDV9KHAsIhBFDrx18qYPQIQJmaStsBTE6ZLoP4VNzSnDmw3MTZzlxSSPMkyXuH95m4dwWRv3WWlyOxPmA8Ay95Wm56rA8Xm3o7LfrNXzkuR5NG1WjN7B5kyPZV9YZgxQSU2S657eLarIjdH8Y3ZJmvYR5YpduvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H61VUOTq; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H61VUOTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVhcFxLoPlJqL8WwHygHKNhbTA7x3SWy7NQtJ7EnmgVD+jNd1Vq97NCdGDmhq8mfsqU6SkNwr0Dw8SEQv/u6VAsNWBJELYYaC39yIERFiRfkw5+mUhBh3ZJX9zczVYJ7FBys8gZTq7WDbh49GqcBoTqjBxkHg/VPQ6UPJxLl77zOx0behu0RC8C2G9daLfpIqAUI4q1Cw0LNnoIe27KuAgqjUwQ44q894qx/eBUw57zZnwCIOF3PmwsDSpV+SynXxZOSfnALBi4N7V3hWd9aUiSrOM4diD9rceBTjL6m4XlE5Dee56+eLy2vW3KWmUwrf67i8su3yqxGTPwVGnqHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaV+787zqj9bbOLlpoFADELo9vn8nTJMDGYqmiEHNMg=;
 b=Oh0dxKFrjOrndNMNRK4JdvusPUEuWcdhP55BJiH72H4Q9ewPXjOwEeakW8R6bvOaF0tWkZv9wYnEYY5CI0k/CkjBUiVK0uCFal0XeNA7rNwkIfxFr39d/jopnxbQkGd6OQhU/jmRCR8TNtzOomcx1U9Zk+iYYIBvgK7naC8t0BHrItS2ThEgEMdygd31FM6CWPUbvgG0zryQCMd0Q9+0d4fnW455j0kmVBIsu2EbmIj0YbpwpdNwIMSh8YWZUX4fagwEfJBaqkSfzkiT+y6VQZAnX2x8iXBgZ5PjzIoLBv667UMnKNbzb3rSX6jzyQWGHsRvo9rE6Mf5bBMrvXApwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaV+787zqj9bbOLlpoFADELo9vn8nTJMDGYqmiEHNMg=;
 b=H61VUOTqa1HLB1izlt4cFqZztbMMYuJt7HBg4DhflOG11vYPlOl3jNoY2frGaUWCGG3yr3jPQis8fUzz378YBrNCyZ/nGaVsQsaMnf4sZuv6a8PrNV7WBdTWj/ExJEh7jh/FNGgNuQ64m8LClASGsOcRAd+ZZIWgZ1TKfC4KDzjL12TRplb9z0J7INHWCDO1TPUP/rtCSF+cZ84/74h+1nqjDO3q6fE1RRlRCsUQJI7lW1O3yiHpwl7CIYdIkYVXjOQ8uYs2bKA9SdaU+R2jbyEB70pKdhC5GAd2kUzalDIkKiFim8FXMmVaNA5kitLmDfDEM+OYLtrcku8czvrg/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:09:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:09:25 +0000
Date: Tue, 18 Feb 2025 15:09:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 1/5] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
Message-ID: <20250218190924.GB4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BN9PR03CA0516.namprd03.prod.outlook.com
 (2603:10b6:408:131::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e137b-b004-4b3c-d7eb-08dd504fc285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IsInj26WU+v76bbZH+sdIhSn/NmLu2UnLsd73eZTmeUL3w36I4pj2vH/B26?=
 =?us-ascii?Q?idhBQYR1S8oKDx3AKQUHL1r5e5qJs9gLBxEjbOZremP9r9Kd2EMpVXcINKpl?=
 =?us-ascii?Q?K4HrtntvOnxfm77PcizAQ35z3dtw1EhOQKP71rqMmcsu+w7RgyocHgOBmb7F?=
 =?us-ascii?Q?miRfgT3UkSvBojx0UjVp0wKIRhq+LEkRjCAT3+Lzks1lVLT5VNOCPU/WqJnv?=
 =?us-ascii?Q?Q4xlQ6f1UmS6S0DKPR6rTN7eNa6mjO6lblbNjS3n2zEIx5dcLeAn2KTx7kp3?=
 =?us-ascii?Q?i0DsWmdQrCBx8+eWv4NbFWbEOYyzLgNQTlJl2N25p74IC3h+SE+jtVo1TMGN?=
 =?us-ascii?Q?ZmwLtn1t3gjqt9N4tYUymRDLJyAt84IbMJITBWum45P6FI10yYQmA0cwWJat?=
 =?us-ascii?Q?eyYJko/Mx5EIPZqphk/RVbc01yk55xsXkCx/uf7+RxcKiTS5P0NzHJF5cYYe?=
 =?us-ascii?Q?a6vwVp2Mul8h6mdLUJVSlXzhLqJeRiLrMafQagRv6nqsPRWEsNzefH5dsJSr?=
 =?us-ascii?Q?gvVKoyBDe9gGVnj3EFTPEhcUolYKHu7kK7k4S/HK0xTk+EfmCd4sHcVsQsQf?=
 =?us-ascii?Q?ePpU2gb+6eaMI3/XWgG5/PWlLwZdDxzq7TG+06er0oKWi6arh9dxlKG4vC2x?=
 =?us-ascii?Q?mwaeUyde9fz7vXSGS64mAgcGUW74EW+8gbyrHc3NMySzL4pIVlSXThwU9vbx?=
 =?us-ascii?Q?xrgpqBVPx24q7WlVCWeGrv+I626CX3gBI/3dZrTZhRax2MdFYRJYtf5zv4VZ?=
 =?us-ascii?Q?pQU7i4PCZEH3mf5uRbyaHaWpizfnGRaqot3dfcPzmanTw7yPFCAoeo059yGO?=
 =?us-ascii?Q?esOdlki5qr91X1op3mvQDIO3aLSEfXool/oO3/UssWkQy2wkWJ1/Mrjemkth?=
 =?us-ascii?Q?t0yTArouQZnrvv++b95cxVw8iayHhHRj3GoYl8X0MrOUfAHueuTD2cHl4cqs?=
 =?us-ascii?Q?FP4ZXEzAvBP9Tj8pytA1YjJWgdKWvdptTkSr29EWNXTmwI6bN6mjSNjVhbf0?=
 =?us-ascii?Q?ZQmN8zepJws7ctvKUhwSurtUVEWjaeak1vxJEXpz4gOjQNK+Fup3J/izPwMc?=
 =?us-ascii?Q?xB/Bp/Qfv+WAyRHcAGFXs++x1r33fI6JiH3bP/+NjLXapMcH2CGiwpaapvaW?=
 =?us-ascii?Q?H2F7x/JhiLKatzao7MRmYlFSquKj9niFZ+qod8dqBL0DKcWb1ck+ew7Ksma9?=
 =?us-ascii?Q?SUfmxZ4PegnDg5VXZ/AxX9wz8XbCF8Pq2ppqM9zV2LBRKwkAcSOiBprWg6eF?=
 =?us-ascii?Q?ijVb0nmMZ0kpAvOP55OTFLJhQFEwTFI4S7RmalZ6g1m815UFQyJF7sAlO1j1?=
 =?us-ascii?Q?Ko6bsEAtI6zP9qUoLG6Z766WL9iJulCoeZuy56AsM8OSqWSWtQmrNGnbGquk?=
 =?us-ascii?Q?82JiNZJgE53WnERJx/o/xZjKgLsm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RL1TQm6LeMfYK2OCI3kjURUcXeDNfIPBp8VAYOgTPKg165gypHMZOHWhJ6p0?=
 =?us-ascii?Q?xovDHm+tIKHn3iwegyLIeO+I9zCyFn2ERuAEoOqvNcKBUsyxBO9wHWkXJD8d?=
 =?us-ascii?Q?j2Z3pU013tnWFYBO8Aipc4FMTd4hfVZwdIPpXXbXblODEQ4oO78yHOmWzst1?=
 =?us-ascii?Q?Rxs6XFbybjowejKDuRmESz5PQsaGAwsIsPuRkaOvIj548lTcIEeGgfVPeaC2?=
 =?us-ascii?Q?HBhLPTfnAKm2dsJa5DmrU/jmJjGSwQPXVsx1j6Y4jRIHGXnxcxJZ95OzXcIz?=
 =?us-ascii?Q?61XuJyGw3lnKL2YSIij98nrOnQh3sW1n0P9ZsvOGmp1ZYNqFM8QyWs4skPh6?=
 =?us-ascii?Q?YNosgEKQjN64KW7IIy1zXE3SIRWqOt4CcIcL6X7VAcv85gvT0j5xBdeTsmgm?=
 =?us-ascii?Q?+CchOPi7DrcTzi9sXq1QCt/MY5X10p3FGr4zsIky9lPzdRZIpSiIm+xwFPP5?=
 =?us-ascii?Q?FUldjolggK99TUdVFL5PfUE99D+TGXFu+kPGVxfDw6IkXhh6outke8r0z+FR?=
 =?us-ascii?Q?CIbkBS2u7bAWhleWLwGN27qzXNGymFQz8+flW/a4Bl5tRuBt//aqj4kQqoJ4?=
 =?us-ascii?Q?3N8zcWZmm03Kt4NDp3KlEODD3xeTqnvqjpcuDXqsepVP42rPyD49WUW3G2g8?=
 =?us-ascii?Q?4OysCbFCpHptJs9pahHaXSnLw8t8edm+xTM3hT3ndJLJTp9f3ZRCY71ZAKAD?=
 =?us-ascii?Q?gCqp/RmL43I9BgqU0G3/gns0PFPaWedu8cQSrNa3maOFe3zfoTc6F4P1sJ7q?=
 =?us-ascii?Q?NiYoqXwlXN9VHxtlzMbhp+21qznB7xlh7OGWaQVfmPEls/3jhhudlztWae78?=
 =?us-ascii?Q?krMpF/eNRnx2RvP4PS68n0gMbNKEF802Xc7ZCw17f1RCp4KaNtgdn4o8l9jY?=
 =?us-ascii?Q?+CbsZ6U8RU3MTuF6u+b80h9sBZVww8Vcys8df4b4B0QQlbVILxAP6Bm9EXTG?=
 =?us-ascii?Q?NQBzEULlMz3rDjbt+UwjVxcsU3fb3j6VD72MXC2Z/9vX1x2vJ38kQdoeTyry?=
 =?us-ascii?Q?le20kPh4t72ixiE6lssatOwi+0xkdYElgLm4SUSDczM92+fCdUIWsUv/+GZz?=
 =?us-ascii?Q?ySV83Za/2PRNXDyB1bTuBEQ8eIZ8ZjdxtPFB4grCHLp0KExwJy8tKacmkynK?=
 =?us-ascii?Q?Qt2Vez2AmFhlLRBjcN7+TezlXc9rH9QJ5p4yvdGMI8+Tl17a84Yya702o0I3?=
 =?us-ascii?Q?o0r8CfZyzcYE2VWlyBoUSG2vScwJ9KoGUK4vhDzgo30y20LP10ZfvbOLsRw9?=
 =?us-ascii?Q?Ka/k4RwPVGp0v0mHi7ON8metR5/1t418T/wsgwJJSdkGlZH15cptEhUaL+Si?=
 =?us-ascii?Q?lbkWm3eJ145PzwnfU3kjcHYwdR7KNKWXgrvfot1odCc5UvFJU+qfly7BHERb?=
 =?us-ascii?Q?xMbhC+YV2Mp31dXm/GcmffqBGLlgiRhz2lpe+67eIoqgF60QkxI8t7MOo7pM?=
 =?us-ascii?Q?SuwjTTyaLHgRC/V5cSUgWrFyOe/d9p4/q8M212UHwAWxjIpZRGO6QB9GydZs?=
 =?us-ascii?Q?fcUTBFj+DCfTxgdv9NpTi024bp8Igix7EXiGpt45WY1WsLRInLhMAcmK/Erc?=
 =?us-ascii?Q?CxwtEdfhNAPROCRQvCPPSQw8mR4UEWXy+b4O1e2a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e137b-b004-4b3c-d7eb-08dd504fc285
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:09:25.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdpSnUX/WnkEq2qDmbvJZ5/LcvrSRg/s5T+DNinYHnkBjgJzOXgK5V4x2brbQHdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Tue, Feb 11, 2025 at 10:05:36PM -0800, Yi Liu wrote:
> Caller of the two APIs always provide a valid handle, make @handle as
> mandatory parameter.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
