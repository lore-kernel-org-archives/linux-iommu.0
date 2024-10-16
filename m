Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0B3A8F0
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085450; cv=fail; b=DnzWqmlRxx6zBvPE0SZ1ZrzE5w70dToyKidE22o4uO6uBXvlapJSbHIhuXrYweOkejynYrPNc7TJY7iUekIMX6NKIPfz9luz7vuCw4nFv8Avn8HXbQvgOusn9vcD6jeSVFUbR0Bh7/IASWhF8U32pIx2wbovsgPF44zB520Gv0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085450; c=relaxed/simple;
	bh=6q0QJIljlCvNg3jMU7xLI0JqwhA7tw1ERAlNOpcBlEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L5dFQrU+Hv5pG/QvJT7ebn6Jbq6icfE3J5XATdtNooPf6dzF1u2uGE/rAwrKf5502uq+SRYvfQXv9jLd6bPtEfVz814TYXDojbJKuR/8yuLLA1QmnqmeO4KEsnmN+Cs9MO5zlUO5TGBjd/ZB75Doc8+BIy7QWLDJEvrqkg2VLWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZ2szUHP; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZ2szUHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z79xxqs0J2x0mwZxxOFqJIt10h7czxxOzorvWGWCJx1dEJ2CmcrX23h2b/XHSHrbE20tYPJY2TvyYW5dO2YUGPLfqhN5IuHOgnm6lvitHtkyARzcyWlIy19qkfYCDKuyk/8VWj6aOQ2LuqcDIdExM/GH+xGenwp/HNtKmUdAkUSybJL/cGtASWqpaJoMKHhR9+tJEPzH7Y8tGamBQoh76j0N4+T5wSLGmT2ZEyuwV5fCvh3ldCX/cggoO7NkKO30QRvCTFdL1psMtf4pIchoTHr/8uiwpQLPaibYmZCbmSRx953bi5toGkC8pUGVxedW4d7xg/9PEH7YF66ik3oV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRr8vnaDheg0DYvflUld2EV0mzt62l24Wyr+NJhaRkg=;
 b=eGnWB9ryK77WuUzLfyiACgKrPuXCDWz/z1ElKiUCc6fRwWf6gfkgQEpMZy5BYO0rRt9sUCfZuLDpx7/7gRBTmEj7c1J32HVNcc8VG16Qto6N1traB79PggkaFMFZ4T4nn53MUm7/rvx0vMnLANwtfHBkk1HdlbCsAghD3BrG9SArBp/R/iWikdSB8+Uo6jMwT4gKfAizVFEQPnzR36KfZmSeGaP+tuwijj8srVl+sIeWiXpnxzeXZX6BZn0hztgKNRastOEvxv30TdIfIClkDfZ+Is/C74Mt74LBIzv9KVnulT//pXUS0gPB9Pldv/9jcbrJ6NTQdtM5tHq5FWzH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRr8vnaDheg0DYvflUld2EV0mzt62l24Wyr+NJhaRkg=;
 b=YZ2szUHP6vSFyoODLS8FBs78v/UVzN/twbTahIKuR7H5Dt3w9CbHe3Kv0zIrtn6XJ//4fahkiCOb5U8ymUhisVRmV/mIeJsWXUmvvOerTg1jwHK34RaWFfw/1++rWbO/buG7DWV+EGcSbqPk3kz6kfDuBbSyYDp0aWcgYfa3S3VwggCtYRMitYprRSH/sk+ckPEf6EEXpkIdKTIcbSp5WTdmo4Jd8HcKhyhKpL07ZJTFaIlHFyPWbdjcl6TeGNdycR7cuSY5IEJoV+w2G5BiNDfhCRJegPZi/ppuJCXzbb96bFU/lgf2s5dDUB4vONkKVxJFO+1a5kS7ugYoqXb6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 13:30:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:30:44 +0000
Date: Wed, 16 Oct 2024 10:30:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 7/9] iommu/amd: Move erratum 63 logic to
 write_dte_lower128()
Message-ID: <20241016133043.GL3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-8-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:530::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dc117b-e70d-438f-0f32-08dcede6bcc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oi6ZHnadZ7XH1v3WfWB7Sga2Anc8pQUBazAuw/GzFBvNH3xSUWL2fE13atYz?=
 =?us-ascii?Q?3Za47yfS1Cxk5n1UUNe4d2wuiUQq6yGvg+9VycnN/UaPkDtOI82KBwdz68pY?=
 =?us-ascii?Q?LreOapqCH8pwmld+Gcld5x+O669ITgPTuPjd/Q7+j5TUpxM1F0Tpr+WL+R5I?=
 =?us-ascii?Q?J3ypWjhjkyKnenztgsdIb5BKniVDwKFTZHmc9RG/LqAI/mog2uX31Qq7aGYB?=
 =?us-ascii?Q?/uH3urev+zkzpKGpT+xEm6pCs4gbaW+hWYrQARK3xNMTwWHAek0Q03/PUjM1?=
 =?us-ascii?Q?1/sJD9t2+rxutPFMMMFxiXcjlol3a8jJJS1s+P7dQWBgEngDjjmDypo197+X?=
 =?us-ascii?Q?AMGEFfSgBIdgp/FT1zTXgxL+R0gNMPKKyqjSuE842OgFgzOK0kOr38i3kbTd?=
 =?us-ascii?Q?4vZK0wfCn4LjTT4rgqETrdHLUYfXBh4WRFO5JSeA1AIB52/uceq8Wn1MRePy?=
 =?us-ascii?Q?7lkAnAp1H310mM8aCxduR4b5e3kLb70bDui3d/v7HxdCICYDaXddm2CQEhsr?=
 =?us-ascii?Q?IEgh2DCPpPjTbOjXmWCy2dTY32QDkpW7bfXWAWHXnH839aFfX+tFZVY+qqQr?=
 =?us-ascii?Q?FdU0tD7JcY9mz6oS/tUHTUq8Pi6koq3s0LKwx1fkerHoSNfQxcrJ+N3Aon8x?=
 =?us-ascii?Q?ZgZiWENPMV4SLXuXlo3RsW1wfYE5NqYZLEY/0Lnti+BMei+m8lUC8+ECltl3?=
 =?us-ascii?Q?lUnwOyqIiyTGzm8AUjBWQwK3XQd3Wur7yg8JcvyMxVMCz6wzQX3F6BOsPfSr?=
 =?us-ascii?Q?B2V2DPXjSZc09183lzc6ronI+foqaZ0MzpH/F6UoN0OnvNnPhw5GxFRHxe+p?=
 =?us-ascii?Q?jJpCXjgFdk0XExGHYHrenguLgadWRKZ2imZzP/SOMZrMkU/BhfyLY7YzjP6R?=
 =?us-ascii?Q?+k7BxwLVJVi8Qo2EIsgzz03dpy1TZL+Mv0JlO+r3inRt4NTQyIgBiWB9BC9U?=
 =?us-ascii?Q?AEfye3sJIWuQSxNo6PLe/eOqoUfL5wggy/s27sh/GbyAfZK4iYgPFTqw2BjD?=
 =?us-ascii?Q?2DWkkaLjUAqScGRCcmAkI6ejCzeJMDRgRH8I2TkjcaSqHelTXf0sPrV+WZyN?=
 =?us-ascii?Q?5TzL6J1zC8uSVoGQB1oP1RwG++jyH6vbJp9P3DpWdk9rrDA8a6YOZU4MhSK4?=
 =?us-ascii?Q?CK46hKhlgZ6plF9rWEnFubkVcXfLy044ycsNZ0upc5yLRqkVSnASXCJ2zG9c?=
 =?us-ascii?Q?V/nfq0MfmhxaEu6T3uU7APSoqJry+TDcNPYIEI+OuBwdS1+MTVHJtcKi7Y1j?=
 =?us-ascii?Q?PSWAZTTrww/lfITebn4DmCRHJKo67PjmbTgrkGciNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USgoDLeN2H6c3UA74LrQXAEkvbfW5Xc4X/OmSWuP8k7LQ5rs6l+n96BeeB0Q?=
 =?us-ascii?Q?kjRP/SWO7QBXgjNUNDNkyeOqNj9SWXffCwgZOl2X0tAXDcBnG2pJMICqJRfp?=
 =?us-ascii?Q?Sog6Lisq2LoQxClD+8nIkJXtucXfnlEkDua1z0aXawtVyQqk1G1GnxYGbbVN?=
 =?us-ascii?Q?fDO5TnZlpOA5M0Ak3pYUWqUMhAnRVqdy8aXKI5hsHQQ1eWygsBzMxDbDX2b5?=
 =?us-ascii?Q?RhYS4WBFfJshWEN+s9d4PVK3FGLcWn+qXzu9twXxVz+nouaZeiCpMFrNwNQT?=
 =?us-ascii?Q?z5ettXSKj5xphjE495tWuzoavuQ6idj9XCTfABY9RmcNst68JMPfnFxqkASU?=
 =?us-ascii?Q?UAxc0DTK0edjgEEC41oU0Un6rKjBkBc2s88PtWEDKIdAm73hkp2E2w4NQTFN?=
 =?us-ascii?Q?JsLa5ly6dnJV5eoeGz55CEfyehuVCJqMRM6Mhj4ADfPJng7JAdIXROUBwIQH?=
 =?us-ascii?Q?EUQbWmVdqRni1LNzitQtf7wX5faH2DRcYsw9kkoJEcxd7/s3HrBVhF34i+Yq?=
 =?us-ascii?Q?h49sc5+DuqCnXj7yLCNnBUgwWgDbVN9UpEFlov07Sx6j/uNqGhN+zfcUuQPr?=
 =?us-ascii?Q?uBH4DUlTOfAC0CFtgUFJ9nlayg2nin4yRxtsUQ4PM3xcvn07NuaXCPNlEKiH?=
 =?us-ascii?Q?DXV0oYFwwKeybdjQ1tAVxxZbWfbSlJd1ddaHuKV6ep67m8+Qc1aCV91QFCIn?=
 =?us-ascii?Q?qfZUYkx5j5QstmnZWFACg4Zg8slwORP9ugJz4cP3VzvuQI3RsDtHF/R819bG?=
 =?us-ascii?Q?+BVu93qW3lcSpSOgYcv7UIswLmM2tNBG1/PjiHoM6y18P0b3WlhBIsw3RsJD?=
 =?us-ascii?Q?JiMWdb6QfW39J76RhJF+8IRqcfo9sArutg+kw+z4nLS7hWNtHJMIukp1eDt8?=
 =?us-ascii?Q?q8l6797WzMD3f4Sn1tHtih5L9zHDhFoA5RipMNcFx0sCN7hK2ou3i1YaUe41?=
 =?us-ascii?Q?f4Jpp0lbfLF4GzP+ExvV/CFH/xJJZ/X9wq5kBABtDdvgnvr9oQOQG4nTERtf?=
 =?us-ascii?Q?02XIPWVOzpvEzJu7eIqpTbxwzB0scVq8CeNaS2X9eV7lZMGu3Ap+yHD0ZtxQ?=
 =?us-ascii?Q?ww5tFTwsRw2KBcvNWr+u9e0pD9uJjGEW58EvMf7+2OgVBZSjQ5sxvW4zCrsA?=
 =?us-ascii?Q?agMqPSWvqkgD6ekVYQB3JDI2rGZpw7pgHbaQ199Dt1E/LtIX+0zM6WiIQeR9?=
 =?us-ascii?Q?tmpPVM8hUHeuDZQ2uex5IFyNvtsa/Pa5tAhZ/QWIYL/I9Eq4K5d/uvpI/s+j?=
 =?us-ascii?Q?wRVOwx9JvQgqUdg7kdxJN8nw7DQc6bypGz1cSsaYsGWnRI+WQmzyoSUfQT0X?=
 =?us-ascii?Q?X+KmVoqAuHagTWeuuILtszeJDkUdpbWBS8WA/XUMTkv8D8M/IyUjmKCOr2eL?=
 =?us-ascii?Q?SI8QXjOQ/3N0JanokViXYE59Durt+0Fu38iG4yx2Y6vE8487loQ5P4Gmdpcl?=
 =?us-ascii?Q?dMUo5mofdU5u0DnaYVdQ/O7lPd8MKAS91atYaJK3vw5tS6InN4Zvh6HaXCJS?=
 =?us-ascii?Q?w8SLLKLHxev1O6mzVT0enwuMuohE2T8olwzF3WckS7LQrfrZO8XFmwzNBPXp?=
 =?us-ascii?Q?VxHuiavhsHEc3rnPdLA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dc117b-e70d-438f-0f32-08dcede6bcc8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:30:44.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJED1OTccBYJSDbKASdLyjh/1d7dSS6ktnqBunnvLLR8rIjNWQyidDwDO+3BAKs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Wed, Oct 16, 2024 at 05:17:54AM +0000, Suravee Suthikulpanit wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c03e2d9d2990..a8c0a57003a8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -105,6 +105,10 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
>  
>  	old.data128[0] = READ_ONCE(ptr->data128[0]);
>  	do {
> +		/* Apply erratum 63 */
> +		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, new->data[1]) == 0x1)
> +			new->data[0] |= DTE_FLAG_IW;
> +

Why not put it in set_dte_entry() ?

Jason
