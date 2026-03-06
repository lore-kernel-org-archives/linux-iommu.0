Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F3337BB3
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838739; cv=fail; b=kGqB3BEtbfCS+JHttvtKNQg/VM6OxaC9jOmgKSWc2nV8DUoZgTX5HfM6u9faLH/4sFdRRCrfL7qQ6ed7YdFMdi9Srk0Ag9TrKsJU5aVh9JZ57TL7btIQiQDX1Icaqw7jdKXWNa7is+Fvd2v7kLY1UK0pCgxgKrqsDcRjjxc4/lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838739; c=relaxed/simple;
	bh=GRO+sSYqoLdsgJqO8GMwkCKeMrwxDTK65HzqF19XaIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1ekxVqsrLHUne7cZ9DwAp3ZzTsUtaRA9O1xejp/BIo76alO4Tj+aqpW4deBp+lwBrVVnq18IuwOJp8FCSevcKuzNZaiX4PcKqj/V5cwQxmopN3ObR75k8uctcj8SIVcoZrPg1oGgj1QW5SPskmSSS/4IXdABHWS/2c/77tQ6xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7mNk+rz; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7mNk+rz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZNksr8LyIKbYljHm8kaVThSrpHYYPQlB+bClQwMDAbxZGNuv1EfanVHBApxoUkZxupNLmuUImOS3uyXAWMJ3JKXoKN3UNOmtnhrpKHNR5Wtkqh6KsjTsuo6hxHS6rQ5dBdyFpu3A4LYuw/9SlQ3dicQBZHB4tm/EyxilpcVVt7nWa90ekjl7pVHJAQoZZkr2b1GL/blD6U7gY7so1I+nBtjJ9wwhSakaTbfQ0Q4PH97Bv+gd8++FPLBwOj/m9GCJ2WRjp/bmIXirHI82X3BD3mpapq6Iku2yrSfdCsreJ3vaVFdt0KYXWSQZwKRacvhxPxUw/QP/L/T44EJzFNL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh+JT00dwMS5/jGHZ28BTAB6Xy+Gq74TY636kXb0VqU=;
 b=xwEt0jFHCu8O5RUMM1Lao9S6M0kyJscD13TRck9NwMOZT3xJ4mHEMIUY9SUO8tFmI3+1DYViEIPJTRKr3Ex//Stx8V6yarlzEp1HF4MHRx9QSh4zJfYKspKnLFYz38KBwiWsOgoNoeTN5UCK7iE7+H2e62GIVKDm12Cgh5dSZVkz+1updVybXNJ0Z4DEookdxpWNGcGqumvts8/tZpWaZwx+zmZm4EuQYupt+R8uJeza+yE+1GUL42/IasfwRivbn5CXH28AlnWHyw3wDesjuhOeNrdftbaPHp3ChEzHsp1eD3xEgwQZwkk0oJxix+Z5rF8LqHAN8YzUVEn4TzTh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh+JT00dwMS5/jGHZ28BTAB6Xy+Gq74TY636kXb0VqU=;
 b=h7mNk+rzlEzseh5O2IAFMiA6Ks9t/PBXIdMWlHXpJzGOmOmuIohap/zBoJpKGS0IpfsIAJCCsFmhVU+JRpJqRRJ9Tg2hkvaL/dRcnJPELBJiy3WepXea0xQJNnjdWDJOKtSda2iIYhV4CcbPUrJqh/TnRYmrRBe7GT52Jk9YlcqWXM2oU4WhRZXjEfle9I84uiWRaWhF/iRwegUbFUjRVwWdcTr02joHmywJwQT05ukqSKDSxSQZ8FyaMwydas6HtvvHeNd/FgWrOl7VehhHy5i1JoCGyl+hhuHYgKXu7VDQ8ecUa2QFSZnT+BQMFbLFSjtVqR9V2Qf9z8WAFr7wjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 23:12:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 23:12:14 +0000
Date: Fri, 6 Mar 2026 19:12:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	praan@google.com, mmarrid@nvidia.com, kees@kernel.org,
	Alexander.Grest@microsoft.com, baolu.lu@linux.intel.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFTv1 1/3] iommu/arm-smmu-v3: Drain in-flight fault
 handlers
Message-ID: <20260306231213.GA3717316@nvidia.com>
References: <cover.1772568590.git.nicolinc@nvidia.com>
 <c8075912c23542c9e9872408658dc496063ee3a3.1772568590.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8075912c23542c9e9872408658dc496063ee3a3.1772568590.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dbed6c-471f-44bc-3d1d-08de7bd5cdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	ZzZeVx9WQXZfo+LvsyykThwluz4SzoFN82LxC+kZzbWt+wwQY7vgqtjV7iZKPnUkvIchPeQJYG4UPEFTozDGket15UUmL03hhEjsnQul8zj/zIH7nHyGNGcWGGQJp94GDkFc01UCpITncRHwbwCnn24zmkguOSpg6hbmIonsXuDmEIYeTmeP8hHY2L0uCUsMqPwAVrY8OvuV/iR64KUUoD1aZR7vG7pBAHI+pWDyJcAowakf9cAgBxWgwTg3ozFB7bkUXomjpPrkJLcLwhc+b2P1NX6pQoSUcTKRL/7Qy1weLd+3cxIzHlWUDF5KfQWAGBcVnWJfRZTfejW8MPKXserfkjRmoBx1hOYV/vklxNf/yH5sBDvi/NH+ypyqi8onYPRrKCFTNUXD/zM3nSwbht4Dp8PgxQGHxOeMO82st3n+N63OymWtywA0AkgSYajQ34DkJiBawDDSKzLdEmCSpXbFv7RG/dT2PrOHCgkC3w9t1TBA+VkM8EuQOuPvopofuJYXEN0t1zDGekQVWRJj5xF0n1osRl4BAQRpP9SP3MMQKtG6FtK2pYmPGeHDfqT6zovHRROPJd3qeVuBT7LAYNlhJ7WWIXWTIXGdBRyCP7Gd2DyKxrYs8+bufISNoz8k2dfwUCEzxNccSDoeATUIqh/Er7/C0AMCu7IPhGmnCXwYFEBwo2Tkp7VeRrHjDW7GrEAc4JlzaX48e3wC6wzUD1VMCD0u+zyafUxWJ/YwuWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAdalwJ1dEEPkG2aAtIzgKoqdyN7T6rol1EU4w6vIuweZCUsUpTJrWloGX25?=
 =?us-ascii?Q?AE1srm2RSUX7aeoC3tJwkc6qQaNyb3lWa6zejVVA3nGcQjdDwbBjpslYVKYE?=
 =?us-ascii?Q?Ji8jHFXlKfkZHH+jqgRAqdel7Y7QWXjRtXYYgISgtOJmnG/J5F0QLxJzV2sT?=
 =?us-ascii?Q?DSPHnZEdVIS/JB9eSV9MPZFfTJcrHFfiqXR9UWIuIo6zxlcXDN3OBbEvYMDR?=
 =?us-ascii?Q?OXBpvRHBRTR5imhYpZgtxDKdI1+xWLtwx1LhaKhbXU2nJ5TPpN0UmfSk6/Xp?=
 =?us-ascii?Q?2y173MYPJGNlWRdPrZlp8Vn3zn7FDtgRwL9CO3l9fil8YSRgnpecMAvTmxpk?=
 =?us-ascii?Q?2q/6ddnt/q/YIpnOO7hIPKIbzXRFUgp26b1FzH4YtuJtpGjbbEPIEdhn/jt4?=
 =?us-ascii?Q?0f62bYFHnLlSnGGiKNuhHqv1RyfMeIxp0XJGw+vYIojiGzub11KN9oD5OcFN?=
 =?us-ascii?Q?cqkggLHkIaWt9HRmtO9G3KlIv+TEixMQHN3AdqK7LslnpP1jyGT51qMCbQu6?=
 =?us-ascii?Q?2v6Uk0IWZBrQNZXwm3jscWXW4GVtj24kTN+6bBCIRFPgDDCyjtXRxesIJMLY?=
 =?us-ascii?Q?AzON3dYvDvkKT+zHPM1l8TJOhiv7Y6ExvS87EZ4jWrev9qSPRqOQQLscf2ja?=
 =?us-ascii?Q?nM0IonpC5AIRWSh3og1kcOnWA+UwW/vxd4eF3XfUEr+gaQcTrWAPoMXpVuC2?=
 =?us-ascii?Q?aE1UU1hIN1aG1seD7+zztEJaH9feZPnCVW4KRgzvgho0c9agR4aJI3EKrRMV?=
 =?us-ascii?Q?Iiq9D7CQiwTY70wksmOnk2HDCrxGszSgaca94qXIOkRhMHJ+ZM3T6xHY/+uc?=
 =?us-ascii?Q?5UL+TKA1reyv1js8pcyfNBg4HXKc1GMogP1Pp1ovcKrB7nGYC5Dqekf5e5Sh?=
 =?us-ascii?Q?HifA8Iuj2FYV9QmtA9cdYrtartmEIrUpWsz8Xogxg8zE/kcfW+1xnQ8PVMEX?=
 =?us-ascii?Q?wKR7x9wBwbW1B9T0X7l1K7+HjZNPhTcjjRd5oUXYwIjRyirtp5QXNWlff0Y+?=
 =?us-ascii?Q?NqDKOGyhXE4IlPCoKz+y0IZOOAEGCMNusRHtS8oUPke4jEWwn9mOC+w4K/U/?=
 =?us-ascii?Q?u5QhNiOLmQKv7UFTyolZZ9GDddn7aJbuTnZKOkvQStTC2Qrea+nRQI2/Ao6g?=
 =?us-ascii?Q?UT9TTanuZMqIcw4F+RE2XCIuQliGAMvvgKxyVVy1xRwAFGCY7b4OJUJuHA+i?=
 =?us-ascii?Q?m9kWFOr8zKF06F10txcLb59apUPNDBv7cVxrMXrV1C61QElFMwogBxouGIFC?=
 =?us-ascii?Q?14KldALznPPz5yxcg9BSXUJVW5KHgFWkDsnxbFStb08/85126APFmFIWoo/X?=
 =?us-ascii?Q?NN5vSOqPxCHA2/D6x79s1+NQohi0hl7Z80afd/CV34Exu08Lfe4Kt51hkMj+?=
 =?us-ascii?Q?FhUOpDDWr3yCNl1NnJHy4FTzZ271Gwx2hiELgjqyTNJtJf/WrxziutRXFUMc?=
 =?us-ascii?Q?pvXgBO1TrtBb4Zr1WfevrY/8D6bAAnJBX2hnDVgpTUsOktwsx6IYd73VbLgB?=
 =?us-ascii?Q?M0t8LXHPEjW/CfFmqqzyhs9mbKCxW+p3rLTUvS22ug/Yp8UbQc0UqH/E3Eyk?=
 =?us-ascii?Q?yTbK/g+4FW/R8lyzuSNlcs0sciuyIkBjn8SNPppqXSATMRzN26fabvmv0Zph?=
 =?us-ascii?Q?hr7k1yPEeMNPaZeVq2mN/EuP7iTT2wDLD1hAK29rNeyoK+0ZlFfRj2xN+NaA?=
 =?us-ascii?Q?6S3lzvIkPcWwXr35uB+5+1fb4aJMguZBClNxRDqJNU7b8caAsm/2pSaLRQUR?=
 =?us-ascii?Q?fWn5aVn/IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dbed6c-471f-44bc-3d1d-08de7bd5cdcd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:12:14.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJkvv1WICvTDzwhUlF/nATX3v8EysVp7+Fr2m7bWi5XVq/knDyQXRqZqnE+dpZYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

On Tue, Mar 03, 2026 at 12:13:05PM -0800, Nicolin Chen wrote:
> From: Malak Marrid <mmarrid@nvidia.com>
> 
> When a device is switching away from a domain, either through a detach or a
> replace operation, it must drain its IOPF queue that only contains the page
> requests for the old domain.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Isn't this an existing bug in the stall handling?

Jason
