Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F22A1A4
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491269; cv=fail; b=I3YMA3LSd++2SBelrjqX7wnlBeFhMJm6f1joQsN3PLdrBYujkVhvt5UnneFD/mItdPVz32SZd5FgZqrv+MvZD5ppsZ+TM0N/hDdcZ4cvxmZurM01WK+L/pKioTZ1QbBP9D0bQYWSmRDocGssCqb/A6pR8u/BblTJIJ2iuE1PxBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491269; c=relaxed/simple;
	bh=WBPXyZ6xP9aGnzxNje16s/HlMsf4QkSe8evA1aZ3k3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkOyscwFImpQJZXl7T+bcrGD9yGpKb+Kqt5jsYeV8CHPJlZw0CWkmazXI8Gn15+9aG7xYFwnDJWj5exlBHKrN6WbuyzyffsMJDncqsy/lMyEmCLHP46be86UWead5Gp354D13jPSFZ+pQIxxQT8VJV4JrJUQl3jWqh6i4t9huKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGp7YEr7; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGp7YEr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTViWdfMA6d7nvj7s079qOE44mFHi9AYRDeJ0UBE9rVRqm2rHfeqqk551ybuMYcCW7y679UzbQpe8w8+bdjcu+II5JzN+Ysf6h5l/yf4/3SplfU7/ZPqsw0Gqm+Pmcdp3npZop9w+Wi2tRGoTb+HwbyxrXQRVS5fl4khMNnXPfkR9T0EU1bZH9B6nELURte2KtgExH781/FweF2HqEyYSTond24pnJYPlYGwyFU6yh7AqmeMr7OBrJmLq2bCDTYVif0tAUqX6EiaTNeyWhrGVmNVRy2Hg3nBYPwLIjYSO+EjP/9JDDDivi2raxBZ2FlaillO6AzcYULVaXp+/5olXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXUqgX5fZUaV58weroTUduPYWupBexnIAJqYtIU9oV8=;
 b=RonUSiifUqGozbxDFKPaz4DweAegPfKOm/lj4g2aMSioRPNC5fF0VjJKLxewOKZ4srb2cFnIQj9wNdp1glgUTknGYckyt/cTSUUJg2DwtMrhc/vbrV0qnh037qgqC9SEaQ/1/wTUWR84qxrKybZ7IwzwrxWwt2lgqGx0GVAsWz0F4jY46pZtxNi9DolmpkWSesyYdA/ZI2fnZsxWlrTup8UOJHPSg9nXkUBtYGfxnQC6vY/dyU6AVoGKlE2bDYdFGGQmGoUc+LCDFTLtE4MeHFc8h3DGKnFJXOL++OmAZeVpI6Vklmi1Sr8K9SDOZT5PY98ebe2MTq5suq5BZMVinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXUqgX5fZUaV58weroTUduPYWupBexnIAJqYtIU9oV8=;
 b=qGp7YEr7nzhV0n51gYM6yC+1r/KMDik2q/tJOThBGjiEM6SS+PN1YdxEMGtXxlYAzEHpbRFvABmPVVTbJvm++Ef0oQt2IrH0S5bmi+G00+3yE/JPbbwkMZ12B+kIiKddTypIrdPfzcpqyKZMYdrFvzG58GJkQGVCpzO4YmMSApgtnH3+A0Yg0H12fvSwGL+nXEUJTnfyxlOgeanLpyIqZp4V1V5tyNgCOv0K3CzszP40x/ZUXG5pTiwFBrVH1dZSmkyUGUE8inxbOlJjaJ/3ikeoBUVcSLDTuKIquvMXRVpFrMK6/1j/tanZY76dQRh2soSLq5dfOXB21Q1FmCjKpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 17:20:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:20:58 +0000
Date: Thu, 20 Mar 2025 14:20:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 08/18] iommufd/device: Replace device_list with
 device_array
Message-ID: <20250320172057.GA206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-9-yi.l.liu@intel.com>
X-ClientProxiedBy: BN7PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:408:34::47) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ad7feb-a193-46ad-abe3-08dd67d3948c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUCaof6H1+nypQmsDZZcgvgh3ttDo2JPz0UdTI2q7G5YtbRMHDhO2nZ2fAUc?=
 =?us-ascii?Q?0fQTGVx+BPyElPOSevT7gohuRc73Sx9j1Zt1YEqwrjjezVV8Attn6ZJfjShq?=
 =?us-ascii?Q?SjUyVXmNs+Kv7szWy1nY2m0gd4DQTvxowdAXeaTy3D3jApx6OnMpbTmKfUqu?=
 =?us-ascii?Q?PkxqPMFzYWDw0yycJejnegIKvlnxoEWxGlIrUZV6qwj7HAt8U/U5Vn4YAL1A?=
 =?us-ascii?Q?+Vwg+TJ2jNULt0AJgOYmsMJK8WV2SGuFZbSEJlijHW2X0GnnqwLHlxBsUeUJ?=
 =?us-ascii?Q?J+ZrpH5oV2F3Pu/lfE9dVOmL1TEMMyMMgL5tqXt0JJgRFXIpPB4pzYkfXziS?=
 =?us-ascii?Q?vz171h+nPmclfXIV6OmZLbZNhTkjHe/ZXD8yXnFhGYy2v08aoZdm8B6VLc6u?=
 =?us-ascii?Q?Lm1PbhOHeV79CVtHcw+RksRG2QozlGTdnmgffqkm8p9GZvRrHoLgfNHTwLtD?=
 =?us-ascii?Q?THmNyDY01lm6DM0XLQImPuhPd6Yb6V62521t48WIwIvzxtfMWliwF1gyx2ZW?=
 =?us-ascii?Q?ae4z5OPONzWOiBwDnIsGIrYVoj7pVFYc54nO8EdTSRVnufj6y4cUwNeoGP5I?=
 =?us-ascii?Q?Px9qkyrSObCWRAlJpzBfhA1AD6fTduIQrTMkByDh3GOpmr8GGWMBou/w7PlC?=
 =?us-ascii?Q?vi19JgBJ4PQV0qlxpdlwSDqbZYI3zpXB+jT08IXmV7a2Je/7qRo76vF+6s36?=
 =?us-ascii?Q?e+vI4Jp8yHkty7D7b80qrQotqWmybjOI6rKXZgDftVnLKWAx1R/E0CRfWh8h?=
 =?us-ascii?Q?m5CEmp5IH+TKOd3vZo/67bnIcNAIYOf+sCl6+xKDdpo3BC7H0FP3V3vP6RR+?=
 =?us-ascii?Q?h40Yf6oQB1mmVJwOur5S3c/AA+m62JxfOfHQD+70MFOtEX6acFD5uMko3lJD?=
 =?us-ascii?Q?QC8xsKk8xmCWh2738o+OzWRRMkBy/J/9CE0OoKBiM2HLeoNYlT2raJIqxccp?=
 =?us-ascii?Q?2dTVmeJ7B9In+vgRpfU1/i98AWmrrEWjxexzhthJ18EBgxZscPCXAaZYNnU4?=
 =?us-ascii?Q?JKtp6LYNGcy4fv/yK9C3Mg4yGXVsPUuDRgn0yPbF5U0Df/1ycrQ8ZSP5GYzA?=
 =?us-ascii?Q?3mdjMAyUFWgkPrKtpsli6WeQPZ7+yZsXG4bW3XcnibBMZhIu4w/dNhylBsPm?=
 =?us-ascii?Q?kYTeAvTwJfDtMJe9HIlP4i79k1JQrRHz2KmmToSc2by/2ij99mdl4InEOZNt?=
 =?us-ascii?Q?zQPcTnf/hJPc9hHouL9MgCpO0576mxRHAi7xIZ9inZSqhUfFgDuXmAUtsLIl?=
 =?us-ascii?Q?uD+KbBq/i+A8DTzDkTWvHmv0cTfYfHvEKLotOxAfb5p+be1WJbNq0FJPRU2B?=
 =?us-ascii?Q?PG2uxlZ3yDsN+QBu52LD256pvLTegIMn0QrtjGLslih3crEtAKJXrhUW+jq5?=
 =?us-ascii?Q?4AWuzNvRSJUm7zbgrjmzQ1cxmv3j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QF0wNq5v/8WQGOXyGy2jBanW9oJNYm4oFL6vxC01QWbg5ST3TU/ahk+JEaIk?=
 =?us-ascii?Q?NADKXd3gbQkOaDqy0dKfNPqwehcLy6jbDRERJ30qRowbyzvGQvyQGUNZNJsi?=
 =?us-ascii?Q?+H/x+ZosxMs58CMxrOxFZJr8+RozKSFpuz1Umt69h6AGZskwdmBaVnU6x/N6?=
 =?us-ascii?Q?cq2OuIPHx9a6xLu8Y2xeygKtzxfAJ5KjAfvKzqvO45K/eiGILg1P6t9yeVqX?=
 =?us-ascii?Q?9g8xv6GWe0OaBRpwskW7Dvtj45T+VZTakyuFPnEz2OkyS82WdfDzIqber6Aw?=
 =?us-ascii?Q?QGuggSksXJxyDGIPBlyjcDRQZEgGyzfYqNRdoAphGkQqhmrqLwlBSyvK5j/T?=
 =?us-ascii?Q?PihNonCtdVMCZpJtowW7WrVOzpFYYKm3byYkfVANez1N2W6PMztEYlcrlCMV?=
 =?us-ascii?Q?vaWaP5PEsXOrcrY9Udz0eZq5a3TzyhLlQhiRqUBadDXWsMb0v7Z4vbiUb+Re?=
 =?us-ascii?Q?rGeOcgDQG69Yo/FATn2C+TcM9OaWZfAK3TQ3ZzszdkoojxbK8wT9Vrx49DO8?=
 =?us-ascii?Q?XM3BHvAGSYjTWBP6rv96JpgoIxWyf2WWVle7Ar4Yvi+bQ+llqHsWOfHLmfPr?=
 =?us-ascii?Q?zw43fOwnoGrjCOGlgz/vm8TDaR2lXrOrsD6k+4VBq8LpetKHtHOhshG/Draq?=
 =?us-ascii?Q?uUw1UMoXjga7Uc8bxW6Uc92jRtnp8fHa/vt3JFsiPamHL96Z/9IUnRiRxe6d?=
 =?us-ascii?Q?soUivJGwCRmsOzIhm7vVlz8zobxxJOOw7uSZuXJkdKK/2Sm2BwHPKRRDV03t?=
 =?us-ascii?Q?qp3FY/HCIvdpxuek1e8VE9MnTIejQBp2GS5lh4D8KAIWT3fDHxr7MtQc7pkV?=
 =?us-ascii?Q?XK3Wvozyrab0SNijkoKcZRCCyKVH+ZJRUJC4khp5TP/Vi/PzR67zsWaynCck?=
 =?us-ascii?Q?UPJofnvJYK9j+BctovhJ+59noFPG7AeCRghkWH9rEl+TV9MHkR6vY2rSEgK/?=
 =?us-ascii?Q?gQokdoB+MQFHHPQcFi782Rfy3oroqDYAEnlkjg57jTyfv8EFuV7R9AmjrHqi?=
 =?us-ascii?Q?+UN85z/5SYYAY2nTt+VYgOXMlf2PbmOKNCOo7uS/2dclPYL7mtvGuFGOg/2D?=
 =?us-ascii?Q?N0HUCkA/WG6c2IJumX1JkkbKCHnHMiDjqKmubhhgAYwo+/4zmxzNCmNf2vwp?=
 =?us-ascii?Q?LMkr6uwfBPj2SmrfK6qW4TTXXYRReYeTLvBZ5ijifKpvKv1hlY4xch6EeMcW?=
 =?us-ascii?Q?dG/aetTXym0ln3fkcXGeynR23bZFINHQ9QR/2OWcf2rDX7FbmYBd0x6vna/7?=
 =?us-ascii?Q?zuFuXXPnR2IT+giJGeicWto7uD9yhKlgQpGcsKlmlFU2R+d7+lX9d3slBlgG?=
 =?us-ascii?Q?32dEc6/PJR4Rc106BpmJiRvDbJNU/48mIR9DTiqLPp1TMK1QRqZmWOUPkWFJ?=
 =?us-ascii?Q?njOwm0GMkoeuD5W+YrMbSZRPtgaGK42NCmmI0cFZKImdSgjz71pM3KyFaz1+?=
 =?us-ascii?Q?x7I8ovxEoFA4WHNCwFYapZh9FvedLheu6pNLSvvqYMKbLU+BMvELG4j1ZaMU?=
 =?us-ascii?Q?bubdz1qbuPG48oTld+mdEm7ithgVkJcEFRAXP/PduQm8akvmao3nLJHb4zQU?=
 =?us-ascii?Q?/GLIszxg3bseBgLh3Qk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad7feb-a193-46ad-abe3-08dd67d3948c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:20:58.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXlESzTHDIyqxBSaHSnCCFZ6wnYQuFQCq4MV8ca63RHrrXw41T/oPRepU1n74shz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

On Thu, Mar 20, 2025 at 06:47:34AM -0700, Yi Liu wrote:
> @@ -298,6 +298,20 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>  
> +static int iommufd_group_device_num(struct iommufd_group *igroup)
> +{
> +	struct iommufd_device *idev;
> +	unsigned long index;
> +	int count = 0;

unsigned int and unsigned int return code too

> +	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
> +		       GFP_KERNEL);

Probably don't really care, but note the choice of obj.id here is
going to waste some memory in the xarray. 0 based would be more
memory efficient, but some of the other operations would be slower.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
