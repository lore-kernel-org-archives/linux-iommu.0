Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF2186E26
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277494; cv=fail; b=Zb77L0eVisUkk2USjujdTCmRw9epTIhDVOWLDM55yibtTS5fZ7Gfi30Ke5OlOX3CQa7e0AvgRZ0XvNZDiIzWqKTmIveuJVRskJPdzjPWOqBB6/+PMfexzM68IFrxZj/dOTvc7NwYMpdaBD648aYBBo1oBk5CeLeHqchKuNBsxiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277494; c=relaxed/simple;
	bh=HCziss3mFZEO1Plo3B4eYNX23Ny8HJ1Uf8aOI/Nyciw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xlt2awiMGWpny3iqUpi6deizAyGQkS6vcxvm2PVFq75qXGH3Y7HpBwP91+b9O0x+0cq4ZSUkdiK/k7a3YV/CxRpJcZYYXh4LlWrx4xqW0udY3iy8Z+si6m4lYEzYzmBFwmJ0zzFaFvYvT98Trc4UXEJPw61NGUXWBNCtBRt0MUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zlw5Hgiz; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zlw5Hgiz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjn1gNqu2+NLODkm5x/3CJfygjxmevDDhWsJsRhXW8olMyXinI5jDRk4+AQtDOr2Sf5lZMFiwRLmCX8DOWjNBLIRmps42EHA8O7uEIF1weuqErN3bewVT+RkLpsvU1nHYphUS+nRSen35FIF/esuCsrIQMF7oNlAUXN9JrcSZD2uXSD3I4HVbWc47SBBYlIlnrXMuhRKgCYFjJzlXRGit3mUh4Pra2Cwt1GXB0A0gREfv2fmsP/msVB/mkIHQkV7wKDYVMzvFI8+8q0KjYstQbBg0EMKRz3/6HWucVc8r5hxQBmxZzKpCC15FvjkjXAcYugG8XUJJMMtOLEYGm4yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/37TINbP9IEllLchNaEk2jdM6PRJEoJuhqFkSEn8mw=;
 b=rnBZQyAX7MnYoKlr6s3vjgDdHw6KvNqmiFjKG1woqpYuhxBjS76/0h+8Jotk00aJr0I53s9kDzqI/GsTJOdQRMEgO4iMnslzZYhbNwg53QNRDzR5WXoeLQb6xiGdcRdJSVaflI1tDkB6O4wH2xx5+BASFCYhyNUF6+Jd1peZDl+yCmh/AqRUx0+ycjv+Gt4/NXR7TKiVb2IiPVWzutnTxPz3zwSLNzucvIaOPmS2p9Ggqku5JBM3B0dnWxrCPARc0qp9aPOTyuAaqddiU1qmc/fY5EYnlzl4ukmK+q511QLaSgTxcDtjaYvL+sGLRn3P6COLoXBbZRTlXrTYsW5IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/37TINbP9IEllLchNaEk2jdM6PRJEoJuhqFkSEn8mw=;
 b=Zlw5HgizOuAM9A/zfyRIIDknMHf0urIO1E5uJ3i9hUhtYLsyg77LgM8jJGbVuMn4SWoBS1m/ny2BMQm8Y6h+GEL6dlw/wpQAe/5Sqtg8uTbFrHrBA6h3d6yDzDRIH2G8o5V3mdCUI8Ki9RQld8zT6djuXhd4ZwbR8g+iCfHxtMufaPU0j7deKcMgx7YoSTmQ7clhBvoHgaDma6Po9g7e0UovmK9JRRrZQ43et005pBnURzgk7vMe0/yh7yuCSDy+kHIqMlVxpqrzJWbsk7UJ4NlHCOeOsFEXsxtyBjI7YZP4Jo5kINvN0y8jueiKnszHe4JH1Kzpx7gqor8pMmNxqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 18:24:47 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:24:47 +0000
Date: Mon, 29 Jul 2024 15:24:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <20240729182446.GH3371438@nvidia.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728235106.2435208-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c61741-ccc3-4808-45b7-08dcaffbba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UG07BmgNPd0TKD8iRdoPt85MCEOOi8DBRmj8MWTXtAoJSOJQNmzEedpi1XhI?=
 =?us-ascii?Q?cnuh/XBXe36qjNGs+xl5jBC1yLI9GvrMsLodreY0iJYBPSSl7A1Tm2Evfd7+?=
 =?us-ascii?Q?nLVrfTkFW0uoImM/8DTZqdQuoTOd47YPEGySc9hDfqNJT04Myac5IliP0qcP?=
 =?us-ascii?Q?4XDxR/3Boln5LP2LRh1QmmR1hdxSV5KYtXi+3Bf8KO6GV9paR9HWtebRXJRY?=
 =?us-ascii?Q?7484Iuppql64cf1ifVo+TlLHAxI5bnI0XFNk0m4MMZfbBqlLBEbx717Fzsd1?=
 =?us-ascii?Q?bjgZGRPlGtLWPKJ6puEH6iKA2dhMa6zeua3c+7c8rf+lQXFHf/u/5jGVBXUS?=
 =?us-ascii?Q?IEJjhPzS5dCxwlu9XW5JCPqj1AhPY3NZKjw9/sQHNSb2pnUGfZJWUmee55mE?=
 =?us-ascii?Q?I5zKMYF5o4snBZVNGzCpfWG817Pwv09f2HPy8UP/2sZXZD+n7HAvIOChmhcJ?=
 =?us-ascii?Q?WSecxQV/LUpGIoLSGN1glJ7g6lxriLJ6b1hKIOQ8EuvYSUSXvUPbE4O4KGCC?=
 =?us-ascii?Q?ny7tLE545uhcW4ua/nnrOQ3kI8ALO2b+xD+SW4fkFrS0mkhs7rbYWwz2Zvm/?=
 =?us-ascii?Q?i7bdXAnTT6bjoKaK1pOO8h01HdcM8OsbjdAcpa4oZ5NRAa0MATIZ9pA0ha01?=
 =?us-ascii?Q?W0rP6Mdo4oU2zccz/tjV+8jG03U2oRQm1yQBvZCekYdFAYtbw6kcF/+8jtVK?=
 =?us-ascii?Q?XT11lq0OY+4TkNwV6KBOHAkxY0UAo+FhEGuljOcUz1CpItOxLl9pw3MZWaev?=
 =?us-ascii?Q?5mEKI9B0gbTsUlEqvL7PyV6XJJAM5NogipDhiGOgi9cWFa5M1zZdR3vHw7gF?=
 =?us-ascii?Q?aUeu4Dq8G1EPgGmYQsVnKjMdLh17wvetkzqEBeRS3zdsL2KgJWu/+05XGaDI?=
 =?us-ascii?Q?NWpMcvOtKGDlcQrXV94hWQ2OL+dlb3TE1H9ZMtnbmQxKgLIeMuy/7+uZZImS?=
 =?us-ascii?Q?C2/aDVQlMQGtvP/591hcpJf2V6YntEmQ7rMqmY45K8MWh+PxgdjyOMrrHgDl?=
 =?us-ascii?Q?eYe+K4gE7gTfH9G8ms1Wc3IhnRebFhTX3VMl9HK8ozvWOklREwVbrOMmS4bt?=
 =?us-ascii?Q?/fif7T1FTaqp2sjkJHmF+OqdTmeuiWr7xV5AQLUAtH3/v1FsO3s8yV0vvIL9?=
 =?us-ascii?Q?jD2vblWGxbaMyCFPf3EoB13iEU9aKG/e/3XjRrU8uOpqjp0iXaJPwKUasSGv?=
 =?us-ascii?Q?p+Un9MpxP1XedDzqZL+Lzhi06cAx8T+STaNCsPhHsCxpJz478w5L0NcB/5WT?=
 =?us-ascii?Q?nIkyRnjc8R6JGaCRvG/4h+ocY/QCem46ym60ExpW4GV+PkICHDIdfUgB09QU?=
 =?us-ascii?Q?NJsGMkUfWfFS8AJ5jEj7H2GGlurKcL6XntaKM/cXxPGjoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mN9j18s1heBRiCVS8dWbVr0zWimo2j90seP7oN7yZLOgfOuldbRYHPUV+Th6?=
 =?us-ascii?Q?qInKx3bviGU3t0vbI42DrusT5214d/jsBTAwbxwiumC4sdYxyTmkS03jVh9H?=
 =?us-ascii?Q?16jIMxbOWrfwp4R7rBhpiImfhryzWtTyqgF0Ivia7oX3JYyBO8Kt0YKUeCkR?=
 =?us-ascii?Q?8m43+Ngzr45LlLK2WJ3HZbLICYMfU2T9ODOnTP7brzlZp6rHGVzKJRcFYZjZ?=
 =?us-ascii?Q?q5RG1sgsiwtWZu+AN5voh5m6KFS6wSi8fn9tHxv9E7S4nGjtd/v8I+sAtjrI?=
 =?us-ascii?Q?dJ7TAaL8rJx7IZXPX4/IrhwtliVQ7HTyMdJw+etb6cQe5ngdzfWFJLSGWEZn?=
 =?us-ascii?Q?cBXq1cCv2uqZhN4SQJqjyRU+nMBLlSplz3uPRswHraGwCJOL+U48nKlGF5eG?=
 =?us-ascii?Q?64mZLhTzWZASaWbUPd99Wk1jnYFe69o0qsVQXxR4V9dXVchRasfGG0xSImzB?=
 =?us-ascii?Q?aivAxXr7zG38t6bYHPC5UC4YVIczTWgPHMUxFtnlbNpXc/uNUtwUJGCwrnIi?=
 =?us-ascii?Q?zTF8Ygl40modH3wjCIXihoFqIgO1LMccaC0OF14fiXl3ppbbRUM48KRvumc2?=
 =?us-ascii?Q?0sw9wGVUshM64/37ai1auH9fax99tKMTAwZhSvQqJyObvCImnnIn1qz5/jqh?=
 =?us-ascii?Q?+4M0+HBB4jwyxJYylG+lUwG+6TGgd7uo93249hw2MgdLEbG2hXQGHAKXsuUk?=
 =?us-ascii?Q?+xfEqzhApZfTz8NaiOn/PYp0Eitz7YlxxqF3kNA1VQShBhq6w6IQwm7JTEfB?=
 =?us-ascii?Q?ndpeMQnzSlXJ7IO0iJe2a3IXTJhRvttcvDkC6OAUMZLeEjS0/rBZRcRbj8mB?=
 =?us-ascii?Q?GHu9XdavHTh8ogtzAJkukQq1tOCjZuW5mj1xJzjJZ3i7cDJoMzp19rBrjyBc?=
 =?us-ascii?Q?HazSjxG1cf4YKaFjRHP2We8DZoncVHH/qu1Qn8C+QlsInQiiXvrU8yT2jpVn?=
 =?us-ascii?Q?MCrYYvRVbo0O9c96+Jmm6Oy2YuL1usV/gMFxa+HtbpfmZqHxiEMnelbHPRaT?=
 =?us-ascii?Q?MpIDAXx12YCC5VFzHB9QRMeryPiWCgYXSUmX8zkrY9QRapOS/WDNrFUU0ppB?=
 =?us-ascii?Q?wBqqHflU+TkYz7INLwplKzGZVF4X+7GvR+rVEdS68JV7s+BQNdmrkRFcAQ38?=
 =?us-ascii?Q?KR61VLquftBZpRtZVWPRkbDsKf7QxCIaQ+Jbkjpf0Tszjs3t1jHfOhOyFO9T?=
 =?us-ascii?Q?hFM6aF+o/uW/dSf16sSThdzXmzGHeAJNi33kJoVbkbmkgmK7uxBEn4XQRGlq?=
 =?us-ascii?Q?OIilNaDbPgSylG4l+kIB39+2aGKn0gecjxhQJuOUUg4CYUZgxsovVcVetVEn?=
 =?us-ascii?Q?Iqq72YdZbNdEXk9jsVy+M15Ndl0tlsmh6k0IU1D/piFDxRueVbUIjZKlTneW?=
 =?us-ascii?Q?atRtqMsBmfUYauSuLL/7sbzOJHUy2MC2gHlvcQNHNy74ANMyt/e6iTiPRye/?=
 =?us-ascii?Q?HD+7UpAfocrGI5jbGECgAMpSBAyrkEi5Z3lJKiBDQtXoTGmI/tsVDI2uXJoo?=
 =?us-ascii?Q?aOw9AiUurzITH/HCruasLiyXSkR5Ytuisz640g2jnOC2K8k+2LjSKA8VTlsv?=
 =?us-ascii?Q?EomgtuQHMaOgkaUeW1J80UkCUNut3HID0Qpo1vBK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c61741-ccc3-4808-45b7-08dcaffbba2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:24:47.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J2wStPEYeTncaXx3InVMdI88Y0Lr7t84Igg935TL2nVFEkI9jNXcZcZT7gj5EAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On Sun, Jul 28, 2024 at 04:51:06PM -0700, Nicolin Chen wrote:
> IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver. Though it
> is eventually used by a device for address translation to an MSI location
> (including nested cases), practically it is a universal region across all
> domains allocated for the IOMMU that defines it.
> 
> Currently IOMMUFD core fetches and reserves the region during an attach to
> an hwpt_paging. It works with a hwpt_paging-only case, but might not work
> with a nested case where a device could directly attach to a hwpt_nested,
> bypassing the hwpt_paging attachment.

Well, it does this because the attach is the only place where we have
*all* the devices available.

Doing it doing allocation means you get only one device.

So, I'd imagine more like we allocate the MSI region during allocation
for the device specific during allocation

But continue to enforce that every attached device also has its MSI
region allocated.. Which probably just means checking that the
driver's reported MSI address is the same as the address during
allocation?

> @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  	}
>  
>  	if (hwpt_is_paging(hwpt)) {
> -		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
> +		rc = iopt_table_enforce_dev_resv_regions(
> +				&to_hwpt_paging(hwpt)->ioas->iopt, idev->dev);
>  		if (rc)
>  			goto err_unlock;

And this seems kind of weird, shouldn't any change the ioas regions
happen when the domain is joined to the ioas with the MSI mapping, not
during attach?? Like we don't want any change of the IOAS to blow away
the MSI region.

This should probably get selftest coverage as well, it seems easy
enough to add to the mock iommu driver?

Jason
