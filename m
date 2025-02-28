Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D7270EC6
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756120; cv=fail; b=ZqOtZHHGGgB0grKCZNSeLkQqtHcX48VAiJ3x8KIAilkz5fxz9naX/a/Of/A9zatM0H+P3MENZbSfPeEd99KML3LoN5BOLny0HUL8w0sZx7EtzFQa0flNfJNPUSdvs8PxwrbUxI8gYJGhkC/2z1z+Gacb3xKkQHGAmLc1M1gDitg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756120; c=relaxed/simple;
	bh=0pvLo0axwX2U6wsA98aN3KPqgpDz1XekkLtHeEjzv5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRLWOYn995y4Y1HNx+Rx2+J1kzujhVa40+sHC+HnMhd/6UUxOcnAjdyL6Ni42vOkVigbuIcxTXlLj/51zWfqNytGkNQOK5vsOyUZDcuooRppO/h40ha+7XvhhG1ivwDh0LS3Lvv/ntQboei9jQgRgtP8N2LLoqSQ+8feR+u5TSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jtZp0Cnw; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jtZp0Cnw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYXHVCVpZ4sI17dFIA1OYdmfotNdq25+Qldv7aMOm5xt5CvX/pD8OO0BkOCfESiplkac55qR3OvO9ZkUp3MR0dO2LhJVhsyfXSMiwXLAtFOv0/mym9snIdp62VzxsDuW66DDoTFLG4Nbs5otexYHMPtfgI8cYQEophhaK78vliAhs96HuJAzG04GiE/pDSTjabJ1qxyPKIkDYBfzJK5fIArQQK29j8YM4VxvPueQT6rkjN8JMZsgc1HUCnPRHVMjj3vRYLOjErXVn3bji7UE/XtZPfjsZ+zOAjw8DkGwfX1qgYO3qHnAWBJqy21GF2RBLCmn7LVXgNeg3ozK+UsurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofWsZ2A/mkwUoUcL8gVSuKc1xNckdGLHQ4cxogyMpSs=;
 b=kqjw6X7rlJsBw1hGSv52HaAS908pG/JAMIiFWx4+n5659NIsgNffaxg5qfGLehWSYgH+zrwd1V/EsWHJs3LO0yHmLczCIa6EIYr7DPdNWQUCefgTU5VN+9ZLKYaFM3Eidwe1h22vGeAdQCujNk76UReur8QA/y/xDMcGLWlvYrHAGQ71K5CuDeJhCEicuH2DmNIdK8SuOsH/YQrhCvkCnvephXVVMyNGRzLnTEa4qKzZXDjVKF7MZEieORwwrYSH/er7DDkOtJC7+aT41U2qgQ0He/1buyumlHTnRYqcu9evf9jcmxvCTk76N64SIGFVq5zOjKA/5GN1foC1+nMQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofWsZ2A/mkwUoUcL8gVSuKc1xNckdGLHQ4cxogyMpSs=;
 b=jtZp0CnwAILUwQH9Mv+xfA6fqlcFuGRvXGHS/YikdE0N9ifSJG+iJMCtPNfsUj8vMulzFzuzNdB0b6iKhjavnwyJq7VeGVPFM9f9pjIfjz12ZD7bohKh0bjoGgbJu+znlB/vff8l2/oZMK+xPwNj49WHNEmHIwHS17hzbq29/ijN8HtbFJ1/S4pefz15Gx4CISjwi1P6IljM8qUS5IydZV5YISoauZloPHAM9y1bpnj8/ejQ19ev5GPejYM1SAE7vrXN/nYRasFD+qxoB6HV7/NDkOZyLGTIMPanQuEOluzp5i3UZFJtZ4ZNB6/XOl8B0ECj49X02uLxEVwH+FTSzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:21:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:21:54 +0000
Date: Fri, 28 Feb 2025 11:21:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Message-ID: <20250228152153.GV39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-3-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: efb8d204-471d-490b-29df-08dd580ba20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awBmlaVSImNg8KkbtcKkpb+ksLTI89ipTFlo9CK1WcRWL4WLmD95Y4FL8+VV?=
 =?us-ascii?Q?TG6NG5jIeGpQG7dq3B6JzTENjByUhn3H9cKaDRvce/QSQRXr/p1ObA54AO8I?=
 =?us-ascii?Q?sl3fCBBlpb0HkuATC8sOgtt8SubRwMubmqtVy6wmKNBrBueClBnw8LDWfe5D?=
 =?us-ascii?Q?40oPqNVq55Iiggg8IfvQ+iVieXZt5Nfo55il7pZYz5M2z8cGZuDYvslIuhty?=
 =?us-ascii?Q?YS7kuFENzzGB18IJ28FHrguvHX4ZkUFvV3DjeP4VNrNFZ5b9DLQZr5VNzLi9?=
 =?us-ascii?Q?EvZNnjs0h7S9fGtlUdZM8njVcVp/q2DZdD31N3kMw/BSvXBCjArcgLYGz7/X?=
 =?us-ascii?Q?wxy6KWqlHpmHH/zkxLMO/853Pi5na2HotbXch3w+Xq0lSpU/YuRTdEx/CpcO?=
 =?us-ascii?Q?r94zp1x3eFRA0yyeh/Nh45yBuDURRejZ8HiACbWwHja12EqvJFiZy94VYLDJ?=
 =?us-ascii?Q?X+5bwuhwT5g0CRG4J1dvQDxCknW4huW7gueNNzYbz3CS0fKXvBnk9n6GQEnN?=
 =?us-ascii?Q?1bx0XAyM1bnLO8U5ARXPQPlPgI7ESS627E2W8khpmu/jQTiJCnvO03iSanU5?=
 =?us-ascii?Q?chMkxAKx/PagjquNeWV2gLaIh5DolY67FlVpxxxYeGZRiMQAU1EQT5YhxD57?=
 =?us-ascii?Q?LjCH7n/CmFSyvAw+XiJrGbxuffNJaTs70C7MIS5feM4fTW7qAC00dD/AYPyw?=
 =?us-ascii?Q?QMTlFvsjtGqD0nCzEb9IhrrdfeEtb/tuGey5udbKrOxG9ChtPPIMkIBHknS5?=
 =?us-ascii?Q?KK/24liyKup7QSve6Tt2kwYBrYGJ8xaNqs8j1YHFpIuvn30uAANU7M/ppLbH?=
 =?us-ascii?Q?nTAuoEw+pWD4NSF4k4eaGwhD11o1E+6HiRwE+9iCN0WP0TxWe+Eevmog5UTc?=
 =?us-ascii?Q?bbRb3mTox3AOd0PXiqiP0ECFdVjaCJAnYIpVO6AlbxXZppRUe2O8f3VrxBtn?=
 =?us-ascii?Q?mkpm2OFVSHQYYNBf5yY9Ls/gYF5tcip2a+bUeBeTek+bIvUqJWsvCT+S+zmf?=
 =?us-ascii?Q?OyuRPORLhT4FFvWCevLdbOAKxjCHWkL+EqKxdDrY5MFot28TVdhL9kiI0wTS?=
 =?us-ascii?Q?SzJMTOGcgWx0AHjROf5ZJpNHO09mWu1GjkdPtJxB/AOzoHn/iJvjiSDPxTdH?=
 =?us-ascii?Q?shJTT8EFNMUDGTOIhOXeOyk1s9fVq59aGv/vAI3KQhaRgp5tGdrQsjoTrut3?=
 =?us-ascii?Q?WwsuEziROCsMlMZOFFI5ORpnsUycSI6686iyDLGgUMo0HMlT7Sdy11y4s8mD?=
 =?us-ascii?Q?5uu+8Jehm1kcROSm4bNXK96ij4uVTZq2fiXlCNU2gjTeH6WVsh5A6ifFQ/o8?=
 =?us-ascii?Q?eiaNSO4heG+eJWAJvoLhtYRgtKMKGg4hBJsnQJ53xNc09ofOBqUbXKNdcu83?=
 =?us-ascii?Q?V6f8vkNrUgmZT9V/va2gHjO08PD+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40rtGS/F+iC4+TofaheX9UCxOoZznTeeOw912fOWp0QhwUX8/qkPcBHqMfjM?=
 =?us-ascii?Q?mibPI2Ctws3PXY5G1HMNgQZHu+uAyBZGGTGJvShRzMtBukI3+LR4dinucOxx?=
 =?us-ascii?Q?bu2NU+VmbJDsWGjZQKvSioZw2ecbAd5dlmnweNWHmHoxrMwcGk5/yBgXnziP?=
 =?us-ascii?Q?sMEyVlYkQr8LaJwMT2BdefrjSU5XYyQX89SWNCaOMZOgNMAhPNe03Rehqt3o?=
 =?us-ascii?Q?WzE58ubFQyL1/Br5LQlJmyunofeHo6wlZlRVkfRQJ/WyPCLT3EZ6tQtc8C09?=
 =?us-ascii?Q?JNFt5JEOO0p5knx9n5vak34A9Kmz7imSYsBtlGb15ADcO7nlM0ssDYWOjCx6?=
 =?us-ascii?Q?3QACNjJY47mzDurX7g8/IyVI49QeJk+VhImePCtRbWp/cNojwwzc3PE5krkY?=
 =?us-ascii?Q?PywnVSNqA8kvIVyAD8j7WD0Xugt0HX0GiqEnEb3m5OB7ynkf2BJqwqhS6gFA?=
 =?us-ascii?Q?nD3Pa/rl0xWJF5LuaQveKa8WxIeYU9DV7ce7yvaptBpcCJHAV9jSrhfzqu93?=
 =?us-ascii?Q?0OVEluc8Z7BayCPcvMdQ3wh75fYDLVe/xOHMmAvMTCDcOACqZQMxX8QephcB?=
 =?us-ascii?Q?vwzc8y51ZcTSYxHDrGJdV6pBwuDj/m8peNozxeaG0igMS/o76wPs5FNmm0Uh?=
 =?us-ascii?Q?Zl9F/q+TJ5DbSmT/Ht+Faymv47lDYyWU+zD/t3dZ+62bmbIYhdOwPgE35nnv?=
 =?us-ascii?Q?fII6RLWJCZGYf9cCIRqcdPw/OkGS+7WS6Bp33mmAPNHvgm2LHVpkucKyASG7?=
 =?us-ascii?Q?G4hIsDRBEmVlWBVzD/WBAt/bU8TK4DG70l4lDA16G7gUJD61EaekSIAh4nsx?=
 =?us-ascii?Q?RdLnC35Y+UYaPlCOllIlweNVb8drvaSdAP0o+zLSqRyWHjyyHkgW/LQaDvBq?=
 =?us-ascii?Q?H9Ft6ZY+QInGInD58vePk6+l6fnM9SBMBH4eJLMQF7r2CaPKA8/Kc9k7ZuvS?=
 =?us-ascii?Q?qV7U8vR3TSl+U7dVKrJxy0M7S2LmmTHjVVD7Y3q23tkXRA84JgYNTHaBv0Jp?=
 =?us-ascii?Q?V0ONcKitlBQrwNc0GP5BwFwgP9m7jjww2CU6YFUfVPz6SJ7Oi8xKqjCT27Xe?=
 =?us-ascii?Q?Ly0YdPf9GTVpymRwqwUsF6oOKefp79a6kOhzE5p1ZozmFCST5RGF7Mm0bT15?=
 =?us-ascii?Q?c4Q0yrsaSCs8l56cBS10idafdwtSdvvZ2+qKC1xMKajSr5ZCVbpYffHc1Yrv?=
 =?us-ascii?Q?YvhFH8GHKkJBX9jifr3gMeNzyQCdeph0+KsJN86mpMZEQlqs5XFgg435F47e?=
 =?us-ascii?Q?7QsggmzWFlgZenE/nB5rxEXQqo6REryJgGjSWZzdvQJKAKcV6xBU3K7Rdzfb?=
 =?us-ascii?Q?xGqhsiEeViIDalzXLcpMYVQC8g456TQr6M4yUkxvnlKpn6KOaeEyLwCrMRI6?=
 =?us-ascii?Q?cUqameri+XQHCAF9YIuYaUUt8R6iBQDkpkJ3tb4/jZuQO9y1CeMzs4O+08aO?=
 =?us-ascii?Q?moIk+Vxe1TyviB8v+5TUYSzTVIYpbhUlReGjiW5R21Po3Vey8ZpDVGuFlOAM?=
 =?us-ascii?Q?BuULcxMHQAoeNDJOvJJXvW0/aGbsORv+a/CeN6dtDV+lmux1Ik4uK9W2KU/t?=
 =?us-ascii?Q?+GG/u5Eft1RwDrobB2DXXsYl0BmUJRIHwiS17Vel?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb8d204-471d-490b-29df-08dd580ba20c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:21:54.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZqFBhQb3ekw6OgtPxnGSJzfNAW+2icsgz9XVf/oxXrRTQZVAsUDwO6t6MWWIKhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On Wed, Feb 26, 2025 at 03:40:22AM -0800, Yi Liu wrote:
> Provide a high-level API to allow replacements of one domain with
> another for specific pasid of a device. This is similar to
> iommu_group_replace_domain_handle() and it is expected to be used
> only by IOMMUFD.
> 
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu-priv.h |   4 ++
>  drivers/iommu/iommu.c      | 113 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 113 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
