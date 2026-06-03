Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C847884B
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488826; cv=fail; b=nNUa3RQAtWT2sxbkj7O+vKf+LIu1Z6OfO7a9jHRrO5BlCOV8NvlfPZQX25aDcLTk7RbtwQ/4lu1knPyOrSlSMgdnNDaY7xLnf+ypZYedCWyVqD7u4W0kyDhU/25GvWgDuPrbgO2ndQUJpo8D9+jFpcZhDJJcZBO44RqoJIz8LA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488826; c=relaxed/simple;
	bh=4GIEjmWO2S2gmglOsehnkC7Uwz4xxPiBGMnJ/51bBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hSW+xWuCFwAYvLESJHMEDeIcyhtiyOybEhjwtcwTUTcQCRZJOpXjKJs1m2rJc0UvHWU9qxH2nodTVtEB7VfxQGqZUA7ZT2W9ViUz0Pc+oEQ4LOCgAbgZVWP+sgg1DcR7MTunyniEGvlPccTx5mGT3zLt3o2140Hjh8Jf7Znl03w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ldku4sDg; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ldku4sDg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMBhMwZeW0ADF51uX8DtkjHBC2h8wYSatFtIP98xYaIFcKtX/JhF3zjS3cFUT9zUtoqolOxe9qoIrKhmq45kAg05h4xPr+0H5AXXsSOFgOydAbdhjTgfn/AynwVUivpglGe7Z9m5Fxc+GsIzaw+3gacCt5ABi9SATIjAR28nfLgTNfgL+C0tEm7UUP5Znu1YYius8PuBeltl8qReaMwj7hqNurLvaGgYmdO0209jY/Eokro2o1BXW7NtMnA7KT3Uh7tO4YKPCGoi1Y0RQfiXx5q7AMH9Kw/WP6Sh57bQgxGfpjqz7SCIbc5iD/CdNIqSyIcQMG6eV4SQpy4OEcO0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1npkqb3ClUaAmUFncFtyHf0XAXGuMTy/9/qiNkrRBg=;
 b=nAt5Mpwu5ap+x0oNjODgDHdRfPUNNuVP6fhOk5b1WvjDBKmtfB2qwQ77M33GzlAgkJ9t9p7JVnifa03w/EKdLlN1Xk0/BwF+vWm3TNB3W737vpNTrjOiQeann+nevpGQhY20o+YMf2+O5GRCnV8r/EpwXSQPWnLSDqpRK+IZdovKUNQCeZP0EFnhrTRzJvYulM4SR+lWr88M6jl67ArJ2K7xUe79cwrFNKo+1I2MADyOFGSJ2pdxz8tT+NgkUeuS1WkFF27cnvKJvUpNSvs4YxhZmqb7OFK71ZRp9h0KlzTDiwORo8yTiXmjScNefsb+Q3Qrg4HAiuDnJGUDI9trOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1npkqb3ClUaAmUFncFtyHf0XAXGuMTy/9/qiNkrRBg=;
 b=Ldku4sDgfMYvvKuPcrEQviEhoiBAsq/0hTdL/xTbQ/0tkjPg/0ntXLhsXUQLFuVzOj0+PFBvqlr5vqKonV7cNvGwBKdt0yRh6hwsVA0scoBWlYsm33TcaLuIJDxr3woBZOJPbqcem4ib0GqeJENQY2GwXPC1VZiA4Bwws03SzeSNRaL/+rn4kFVbXAxiBIUbKbS6qmVrScyIs1lRi3+s18FGG69eHwn/V3Ms0F7uxops+wQwInSkE3oZVLuVDAfGyNzXRwUyiYma/xfGx6icbpuXhv17HjNdjBSjgju+9X0tIsNb8wqKkGOnDZ+DzKnHQJ1hpILMd0O+nSmpPY+W2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 12:13:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:13:38 +0000
Date: Wed, 3 Jun 2026 09:13:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
Message-ID: <20260603121337.GA1170766@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260601133031.GA403363@nvidia.com>
 <592389f0-3068-4b7d-9999-5fd188dfb293@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592389f0-3068-4b7d-9999-5fd188dfb293@amd.com>
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5b2bf7-f274-4f4d-fe42-08dec1698b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3TweTvVboitwZQ22TufxGm6PdqyY7V9d6nR8kzMvHBJGmKEQoxmp79h8Ea5eM3XNtnHJwVu6cKwAQMrBLrVdklD92cdvppnahLxI7xHn/lVAEYFpHMMnL3LzCHBrD+/KxtDpe633Eohx1mGu8o/ARTmFLXgzx9TSm7BzdcMOmmS+LYGJfs8gPgmrkeMxef7C+3dPjoghcJfxXv6jqVOc8FJwFCo9akRrVy7vmbyA/Tdg66UFZCVajDDXaz9HVFHOKJz6pJebcmtwgW70q0Rbn2W4IZ2SQIMHHf7M5+uxm+JlbFwW9RrZw7xD00BnjBmOSz5CNhNMYiHbx+NdfM9Mm7QmczTwDp4XUxrHESCfovitu5DG3QGrZG8bRtlCuWFlXNCZ+C8fI+B7w+wig+LmK3I+v0AgVZ7gbB+ZL6gliEppVojgNJDSK1G27c+FW9pTgoXyif18LUfZpSvk0UtgjD/c00NaMmQIkR58oFRGjR/m0QEqqyfdZ/BNukq0SmVK/r8UitS2lujGojI9D5vJS6GfPw6Z2VYOEymqcLuvaFEYq9PzpBsUYWuEumpVwCibT3gcMIADYCGOUMNeWgsBPwrT8rZ9lYAtF7LkRbpp8zD2eX1uUt/413hVunefI4QH1uOwqLG/xd638yWs+ztDcIyPA198UboJLIKi8U+A4XwVsZxLfgn8Te86D/wLJHXe1Y7X0SVKjX7GzragUMlLUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdr8MhDvREBpPZhG6FNusOPPtTVByk1rKk7LHdzy5Ir5FPgNP4K7Peeyr9JU?=
 =?us-ascii?Q?0sAwvpxUmoLss77wc/PfhLm0AVthgpT09IcIKCr5xEBM+5T7gcetOzAMWD9t?=
 =?us-ascii?Q?OFFnibuzPHHsSs5WpiEFjBYz5BJpx7JQjxEJBfic3zg9FnbL97TI2WvmtPBe?=
 =?us-ascii?Q?KFfkwZpevS9ZeIsm7rpkKDLZ6qk+sArlYoYJ/AMaAXSmMP3z/jde44KlnXjY?=
 =?us-ascii?Q?FVaBfvyA2SrvxhGJUtlNShOCoy2MNQ0wsQfgBYX3sj7Zqznkkt99xSzeyDqf?=
 =?us-ascii?Q?rICEN34DNU7AbKjk9If4jHdMNq+stHGqMtOxc2TV3YguGgn+2ALfTtYxpi0F?=
 =?us-ascii?Q?ZDo3jZmmjhxMlPz0azsZdx8RqvDgu4JVZTV/+oegYtvqakA45281bWQQBFJ5?=
 =?us-ascii?Q?Q9rT1ETdDirphSygWi/oDXcqM0AaQgicXgJToIdfr6QoTgEjiF4Ww6nzLEPM?=
 =?us-ascii?Q?cjWos4a4hvpmrEs2a2aX53eUiTNNEydJqcnQ8t5MhoW01SbuxMYIA5lyAvMn?=
 =?us-ascii?Q?Tr9REKgmpJqCiIfG2z/XbWfr48tpg5UTFS423kGVDsaJas0KA1xgtQh2e849?=
 =?us-ascii?Q?Mw09rLhj7GXQStvnVJ027JBHZdwXqYYWTbFGxiHJZ3NkJAK3m5+Unq09C6gH?=
 =?us-ascii?Q?F+GeSn1HiWO/TTfGCkJ8bsW0B8C9yy5Ysndzjuq9yuqrwgbKiWkJ6QAxZg+Z?=
 =?us-ascii?Q?gnuy5YYwuPbhrSCRZGMIPtFYX8XaD4l6n7r2w3D02nlg+kSqmC++cXw0O99F?=
 =?us-ascii?Q?eipFSHogNUCGf5orIU5gV/GNLk50vl2d+nh/WpVdP4UuUfY7Ec57s6a8kf5L?=
 =?us-ascii?Q?KNyd23c/Kz2COzvVduVyAvYzFur68bgPMBExyYeb2TDpwjzGQjKkfxbkARlq?=
 =?us-ascii?Q?VIMW4a7AFDnjZj7oEnwarKQH6vALVci6u9kJ1fYQFzjBmK+0KVgZe2wzJH3h?=
 =?us-ascii?Q?PdgGBfwZyiU3qr6XIdSQ8bUBaVrigivg/ADS0UfErpx78HzOt40VmSs78Pv9?=
 =?us-ascii?Q?AfLkgFWJ0GFNZ+lzs1777SRuHX0E82BY7yAfDdQijxi+spTwXlj0CmVlF5Vc?=
 =?us-ascii?Q?xorbyQKtQp6q6Pja/MxJA0R0D/NWnAbzg1wiOi7g2hk5W5iSfwb3O8qh0Aq+?=
 =?us-ascii?Q?Ioh5hVBHrk67vgZEAtvC4yTo0CJ8OUMXfqJ/SSujc3XwWwzC6xPvsN86pq2L?=
 =?us-ascii?Q?4PqKrJ7+SgAzot83eixyvhgpKY4D4JHEoSW8nhAY+CNRTDIqyBv70rlCr/Hd?=
 =?us-ascii?Q?LwycFNcB9Vuq+frSLg5Euk9NH00JWK/wNBHUK3CNgnvNDv2b0MfmrVBD9ELU?=
 =?us-ascii?Q?PRCGrBHBrECIFKQqiU3kLmPwg9Gy87Yhs0FlyHv4HhHDm+GLYERgUJUI+In2?=
 =?us-ascii?Q?laGGSEPRxa+Sk4Newn4RkM940QC984s1xxeC9KCyq60Cq58My4l04zDITsGA?=
 =?us-ascii?Q?Ro5MVdQWB1UluK1l5yEc+uk3BFWXWhJoyrt9+8fS8zorNzNnTxMTJMwa7lLx?=
 =?us-ascii?Q?wD3LqvYYEIrS/5Pfh7hADlrcqAq6kOcTj2Gq0Cl4O3ZnISwFDnNXDA5wBUJu?=
 =?us-ascii?Q?SYKd6Xxgn6WJjpeLq4IrSXiYwdUFSxjISJI2werpCUHRvbPaj1cHYrPHHpfx?=
 =?us-ascii?Q?f8W0rmC59Qnsbg/3x0bu/tEoyATML7tSfKMrWTuLhqlUWqce3VGz7ipnseWY?=
 =?us-ascii?Q?E4ghqvoBAR2jB1DI+H6o8hxVXIk23DSRYxFFstJHBmb71zJO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5b2bf7-f274-4f4d-fe42-08dec1698b34
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:13:38.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTCaNCGlTeJiz+400bEprVxw4OYgD7fnsgLGx+RycgNXVnwgoJS4hqJ4Hh6u5Lsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

On Wed, Jun 03, 2026 at 01:41:34PM +0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 6/1/2026 8:30 PM, Jason Gunthorpe wrote:
> > > [2] Linux git
> > > tree:https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-
> > > viommu_upstream_v2
> > Build test all the kconfig combinations, I noticed problems.
> > 
> > Jason
> 
> I have build tested w/:
> - CONFIG_IOMMUFD (m/n)
> - CONFIG_IOMMUFD (m) + CONFIG_AMD_IOMMU_IOMMUFD (y/n)
> 
> And they all have passed. Could you elaborate on "all the kconfig
> combinations"?

I don't remember, just my default built kconfig didn't work, there was
a stray ; in one of the #ifdef'd off blocks

Jason
