Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FF1E5200
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907557; cv=fail; b=OR8kgd7N6mRwd8n0FtMOP5jfIdu+dJzM/qmZNBGcDd4tApTRSL+8mvynltS8ScEeEmyjiDM1C0gBjca/Ra86z+8XPsnlwfcpTxTVeEl3Mp++76NZq41vazKUrzo4KhmTr6AWu3WXQUZHFYWcX31XOI2VgI4OzIIIRPJAXLUCkzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907557; c=relaxed/simple;
	bh=zlbXVTCV7OogDYV2Tkxa6D2QDl7WYSu7Yu7HK1llCLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qps7Oox2afAQVfR354jcQvVXzxfFQ6+rYTVJUwiep0yaRC3EA2LvXXli8ZeAKIljbAiqFDeCihCx5C/vXyyonKibZRMhgfkbakY8LJfzggLk9DnHvERkvGaUbTEeI/bw145/rGG2Se7kvnJ1umEUERcfPeE9bsSXUwTGiuHL6CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QgKwS6XY; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QgKwS6XY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsdFeX1Mt1oClDTOI66yIEWE+P6jLjScsj/wu7bD04kW27SJX/BknR7V7yKPTbnGFApjFbRux1OTc8mOlZ840rJ/aZTQHhiL2EPcM+gX+CHREuk2U5bEFMmV8QEg/0FJaAvN4eG1bVcDOhwsd0O0AAePqne48SDJrf2x6qM9XEIJPGxKsZFx+N9tOBNXIj8nARgm2zoSxLIcDukkV9IMby6i4F0mrFJfZHvIQN/KwfM3nZp+eXi8p6LBFPXwL/hWCFFTvXtSbQXaLYa3/xJM+Lc/9ajeI7bs8MuF0+U2JxPPL8QCewXoFggFoiWMttbuWYiDbgZtEFfCy5bcOazCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJKVdZ+qnTF0F03U5WxG1WRsRkBO4z7BgFe9QJ2ejTY=;
 b=vkCHVmgqo6WEnOWv0CpZH9qGvIDhmSXLkgtvfzZw5ll62eNV6W6DPaxGCwGKDQtuXXpI/nnKhs7lM2KDJ4AJFFqZnFRmvJP9EiyRoAF+AtmLk/SbfN06GGFMkPgOLwNZpdUKcGTD+nTzH0tccvjoEyB1S22U3wF5sJAAJaL9lw+X5Z7As0raIiKOHkrlQ+ZcdxLnFyhjVdnLETFcT+eSOXhgWD5zxMSibBWuWUKfI+zbHVMm9YFMm1yiv41bwNUYl+9/eDqOfAFMCROrYEeK9bG39MCUoi/PWKkBgBgdzD2S/EhD4K07F6fWDh55DUzpSMZnYvsju5bgEvC3W8Dxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKVdZ+qnTF0F03U5WxG1WRsRkBO4z7BgFe9QJ2ejTY=;
 b=QgKwS6XYBG0NVxrRymngvUkLD1FHgBX/z7FedUBFGMn3zg2bXjxCbWGPBcx/8XvMHl3I6DGOY8WaKY3BqS8ZR44hllEM1weNlMSY7rSfIe0fFpgo53op+K6lY6Ozf1UzL3H+B2MLZmLQ/yfTY7D0x6nNHWrqwVg455mRxM6BR1Qg30BaRFth6z/hay554Jb+fP8vzRfXfOmTNNREUedgThH6jLIi9ieLxprWU60WpjZofeWHJhE4E8xr0Xih9QJrqU3pEtUxaw+LlYjx0iNu6TZA8R/I0wlEcS8IQIkj1BoHNDoTFOaNhRzJ0dU80Ul46efeFSWojwFRFxDVA53sRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:39:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:39:10 +0000
Date: Tue, 18 Feb 2025 15:39:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
Message-ID: <20250218193909.GF4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-6-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: c3da8fc2-f364-49c4-894e-08dd5053ea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RdGB3/d9ZWEABUz7LXEwW98NzPV2p9znyxmHMCh+lquvEaj0iWTAlJA9a5iK?=
 =?us-ascii?Q?3gbaoxp/C+vQAVU5oWGA9bstbj4Dz5kHzHiFosSzjYg5TM39LZQnDyaECaHT?=
 =?us-ascii?Q?55veWFWF3FA5vgZ0JqeYsUeRFDXe8tfBqUvMlAgagT3jag+0rmx/Ysbcjb/y?=
 =?us-ascii?Q?uv3Rxs14BkGo0/IMi4Vdj2msxmbdQkleWJvTVwu7mpFf70FyeIuaSO9Aoof1?=
 =?us-ascii?Q?Vj4Qjc9QGw3JEWNOhFub+xX2keO19Jfad+CZfnJK3MC9sxmcQqy9l3FlqDG4?=
 =?us-ascii?Q?zUGWqx81+aGePiDnBUHyYZmVhKQz0y1XCU+bU0sf9XJkfLqaVpGcrRldnp7S?=
 =?us-ascii?Q?dAShDbQUplI/F8tSb6BHcau8nMxp+W7j6Ni7vf+Dj2LNGSpGGmxIozaCWIUx?=
 =?us-ascii?Q?ZatghtxzhnH/TxnAgkcL2GfmDD+2TNXhgiP97RgyqBn3+GYBbCPEHoAUG33C?=
 =?us-ascii?Q?FZqemf1aGdQAZYiB1viofaZ1hXSboZPWYmRa1wgd5YS2jXRzkFL5gRBz+xeQ?=
 =?us-ascii?Q?ScoDmrtt2EcCXZNO+DAh88hSKC5HFxh4YVMYAtFlZj+bc48BYWq4P7PgHgtq?=
 =?us-ascii?Q?x87GKseR3izPGADT6EWPeT6RUhpYRzu2wJ6UwVskEq4y7cCc9kB7l3DckYYH?=
 =?us-ascii?Q?jPW1lC31PDVwP+WlhBXFq/CIPpzZGDUmGMx7ZSUzu3my0lIiSqjQZQUT1WAR?=
 =?us-ascii?Q?8xGcW1Bswno1G4G2tMvs1ISg6dImG8pBwpacjSKRNE7p13YavyoKxd/eDG7z?=
 =?us-ascii?Q?C2pPlXONXM2VcBZw/0m0NSUbVP3erl/z4yviPOSisRMyG18ZLBujHUX7Ut6z?=
 =?us-ascii?Q?/EuXv8rzogMzIvYKqioVzO6rB6ez92pgPa0SprjKLtaHYPzReKhWnNsRpAFt?=
 =?us-ascii?Q?XuKs6k97NXeHOfqCx3b8cPg2wVKmNv+0oYI5SLndgSvzxcZhMFIyoEdlZn4g?=
 =?us-ascii?Q?8JjM7LUDkDYzjQkFMzz1LgMqTRlfrkQi9cVk8Mkbj0ArhkUFG4FKSP7UXDhZ?=
 =?us-ascii?Q?uzgEW/tk74Swb3k8Y76KSgHTiMdzDaFOCz9rkKPsNCNtylYvaAguHfNdCq/7?=
 =?us-ascii?Q?+CRc4GB3GXQqpOu9YkgjTue/CaAf4WEl6BPJXF/VTdWqkOSr5c4/rKX+O2Y0?=
 =?us-ascii?Q?tISZNbNINHKlL/Wpo7+cbImiLObqbpD103+0mGD3fJ2trH61rqr/asOszO6X?=
 =?us-ascii?Q?zPA382WuuzlEzo1qwyB+If5mkgeI2WBCsUWnUVoRk5/r22T3fBWBDf0BA4aX?=
 =?us-ascii?Q?rrOGU01JrGQRpD7lJTKbsKvChDyFTT+aU4m34gUXsWtIaVpxuLc7WPqiOoo+?=
 =?us-ascii?Q?CeHF92k5DYDfN9weFUMuhSML+BxXz6TAt6ihZtP7ASXybpICrRCbqRBT6i5t?=
 =?us-ascii?Q?zRmjI59vXRLu3zRcvsOJmHX9D1QB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8mASmvRLPSezEYyKqA34r2J9ATuKSFGRaQEfEmMW7exheUGyFeWskffb5SN?=
 =?us-ascii?Q?g+Srr+W4OIxMRFskk8IedhjWTK56yOmDK2CKeh364VJYxv2zVEVJ3/zfighx?=
 =?us-ascii?Q?Uj+tusfpUWG4grk86A/iMC9t6pfOuvbCsulS8XyNvJmKYe6bIQSBKKHZ1M/j?=
 =?us-ascii?Q?6lmrG2WfGrmwOXwPKb7dj7y85EkM1MaIJ69DWMuOIBhsQbOa0VyOjtg8SuHI?=
 =?us-ascii?Q?4WAZUAbGd81uqSIApzs/QULckgTJ+uZVa3XDA49xaBC4dUHP5kzoUJLe9Rf+?=
 =?us-ascii?Q?dTaVpQMwyNpY08MkzHPkeYrkWWWng3rEwDhRN9rSLthFsgUMU8n440gcwrpU?=
 =?us-ascii?Q?FxKstwE4xvT+x5ZKMqF/oTY3umjuoksrCM3j3Q9fyTgorRoZxPWi+ogi6JDF?=
 =?us-ascii?Q?5QK4SQpPXKKbsPlXH5g92UBjwGrcr7LBUAK4OswrHGNIlvv2uW1O0LTwXF2L?=
 =?us-ascii?Q?OsTuF1zdy0DDKKRQ25DFdBC3PnKq3rOyy3oU6WQ9KyBWRjJKWGjbgjYdyhho?=
 =?us-ascii?Q?RNp3BeN1UYbamyjxtJSG8Q65JaeKmSr5vqVzjA74BhAJMIwXsjFizH4jrpJA?=
 =?us-ascii?Q?c+/WCsf+csNzvRGx3dNeg7FMpT3hj5FO+o7IHGuvVhewr5LjzGnHf9VRHEsm?=
 =?us-ascii?Q?z+pKDrC/tA+O5OOCMhWyJAYsqqhSEdXhxGJ9IuK2sJvLGqd1KMs+ZnE3tROx?=
 =?us-ascii?Q?mhueWD76lGv0e+jVOi7dOqrNPMCqqdWLHPE8bLsM3+JVMbQbCS7ZZj3fUOc4?=
 =?us-ascii?Q?mZbO3YFD12oQs3ClQhjxJTGsPK6QkBSxZ2mI2EV19PmCwq7hrYwyVsDcNCPc?=
 =?us-ascii?Q?vDQ6OEw8mx92hxxC6KzPVcR8n6eF/o5CQLer9OkfAtFMbdhmBI6/VkRfTmNi?=
 =?us-ascii?Q?RqHlhlFYDDrEOAsYBr4a6TPF/7rWa1v0aDeUchzI2OlzrbIL5gV3+KbaqrTZ?=
 =?us-ascii?Q?fSjSNeSbAPAzBb8behLO8o7i/cDug9t+2ls0a+4DfJEop1KuaYyX87h4MFvS?=
 =?us-ascii?Q?o6FMFZywgDFRGLMIfZ/0wSlLUHh4V1VwkQaKWw8FZ303ij6BgbRqnWvG4wyE?=
 =?us-ascii?Q?SWf41C+EGHWjOM3Ba7aKjXQj2hBJ3t2kG9ybOJoSKSSEo+LYAfK7/wzmcTzd?=
 =?us-ascii?Q?1iVQTRF6Hckz5PEc+3l1noyqTRMcsds0cZ/1wPivXDdMKBAYedgnYXoSCZWl?=
 =?us-ascii?Q?e1+l4mkhaCUdimnVG5abnzX0uK395cQI4YeVC9n8KvIC6VwRKjMXSzSR/v9h?=
 =?us-ascii?Q?vtZ3YHXdRyj91ap36KoWF1rtLAaXJtpXN0w47+ir9q8ozZdRgInLx50IVsP2?=
 =?us-ascii?Q?NI8ldOZ/QotxTbEemh3stAhxQd+iGvz1mX3y0TKCf8iiKQ2i+8yUvxPb7tFX?=
 =?us-ascii?Q?czKfRPRo7BaWcMz1ipT+a4BalqfzpUQbcdrzrxh1kx2mbHEzQtdwxJ75eZ9t?=
 =?us-ascii?Q?uWKcJ0m+OH/jyXhCecskzt1p6p16oAiYcf/gBxlz53QCBWsUQ8Dv5w7y/yyP?=
 =?us-ascii?Q?OCOx0yHHdO+QANj/Tls8AZj/Vx67ai1yAVafdLCe6KFdTXF4plBZ6Zhe6a8J?=
 =?us-ascii?Q?n26H2vZO9nfGkZlWTjcC1YMiO0hpwQc45TZ+CYRD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da8fc2-f364-49c4-894e-08dd5053ea90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:39:10.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUOr7q296iGayarYC46PVpao1UACGJ1vwR1RvBfWoM2YuMkBwDChNK20WibTdNro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On Tue, Feb 11, 2025 at 10:05:40PM -0800, Yi Liu wrote:
> @@ -2133,11 +2164,16 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>  {
>  	/* Caller must be a probed driver on dev */
>  	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_domain *gdomain;
>  
>  	if (!group)
>  		return NULL;
>  
> -	return group->domain;
> +	mutex_lock(&group->mutex);
> +	gdomain = iommu_group_domain(group);
> +	mutex_unlock(&group->mutex);

That will deadlock

Eg:

static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
				     struct device *dev)
{
	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

And attach is already called under the group mutex.

IMHO I would have two operations, iommu_group_domain() which lockdep
asserts that group->mutex is held by the caller. We should try to call
this function when possible to get clear locking rules

And then iommu_get_domain_for_dev() which explains it is an older
function that depends on the caller somehow ensuring that the attached
domain cannot change. Ideally we would someday try to remove calls to
iommu_get_domain_for_dev()..

Since the xarray cannot change for non-lockdepable reasons, it can
just call xa_load(). Probably re-organize iommu_group_domain() to have
a __iommu_group_domain() which has the body but no lockdep assertion.

Jason
