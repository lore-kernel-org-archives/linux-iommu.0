Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09901D9A49
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512629; cv=fail; b=ksdyyt8umVZhdLgph9Udk8ckRd3RsX/Io8BZIiDuZoKYUSy3NRZvklvF3+c6dyCGl+P6RUn5z+6XWh8fHdlAoceQiLHwqSWb/HoZUApBI2Oi4ZBLWHBVNYeyNPQIDWpJdeQWAFqrYkso3fOUtY0NvJWyumyyyJc40tzdQ1FSKb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512629; c=relaxed/simple;
	bh=kbz1RhNcnt2K6Jyes4+r37baDd9RS7oeof/7cVLAyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sASD0iGvqI1V/MuLLqCIWyxwJFYY/Flf51zpUBqdMrRQjF1aExmB8ef3qgQxh8vquucHwkibEj2dmxhYGc9/xpdIGzo9pPGfXSM3HwE/Nf87dH38j30i9JcDHRybhDzIm201W0B0NybDfdacB8tVxhh/uDezIG8BEc1QN9zR5/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWPOnz3k; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWPOnz3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxTJZJcEdkQnHp73Zj94ZjtUzRdV/OStRMc5A4q/fpzuvRWAzultYgZ124y1l3zN2rXe55iiapW1zNreSW6YV85qYT1Fj+TG9K0hBWUnJUWFS5TbDHH3GCVgrPvs6FRho2NXM5FVgzzr+L/KkAu78GoDb/L0C4w6HRh+1TztAPn1ZzHxQpNcqgo1o8wvwEMaCdtYjbXhiQgtxO5rtXrPk5HxcxGhmr49lP07j3Ug4agYNZ3AVOra/TrNN/P46tgffr7SrGcLv5uSj84B4Tb57vUDD2NQlvKe0MxjJVbsQGP2Lq0OhLCNaL637cxAvUntEmucrZwlYCZcr7oljjOimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgDAsc5okhbMdFpNp+E5PgL6CVkRRpFPlKm4iavJiKE=;
 b=C/P7FM/FkMcBTKQBMgBnWZYSsXnE7MKPYW4oinmQqk0J/mK52My+cAk8R94bXYmjsS7ySVcwxgAA4+q3sdAtA1OjqNfMgYbxVMFwnLYVkSp2dFQqj1KLDokPdcoUeB1IitoXNUNznXbAFFPCs4EyLtDFo7o+GkhVSpMLDlm1JTns8n9DacY/aKaHtz9YUGZjrnb0ZZ1tUOa9/cIdf+Favx3FhNNuRZCWqp7RO5vHhz6wBHf7kjm98YB+ID6NEJiYEUWL5UdqbJd2NsAT4qGRWBUEwmy4CyqbnAOqPdwNFA4CW9cnK7e5DZ1azcL05ag+2y4HKvqLkjovYNWTUewqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgDAsc5okhbMdFpNp+E5PgL6CVkRRpFPlKm4iavJiKE=;
 b=sWPOnz3ksNe30GQ9bIcaFIZieljYuF9aY1ifvQH8yRa/E7zyUXHaOR3eKLciztBwMFWTGQKn0wuUU2M1UYKXoZ9CdSW5D8Cyx4s/onTTEcZvmqSSgIobWw3/4bESdctr9BT3tKg9h5ronBUQvzabC/Q/fKWgdo3faSYUflt0//dHgAGy5VWCAmscUB3AWuqxNV0OoSmLqmEYXisJWOfk+aKLlZyDzVCayEICforg3pTOONkWA71zhiXSjYurcc3sgcLva6kuP5Q/+t7r6IOaPEQNTOCF80/fjJclB2bs7nrbgr96TIt5xj9fsLgfdyuOGvOPOixVfORyy+uyLAq/zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:17:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:17:01 +0000
Date: Thu, 20 Mar 2025 20:16:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iommu: Clean up cookie and sw_msi in struct
 iommu_domain
Message-ID: <20250320231659.GM206770@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741294235.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:408:e6::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: a8aca956-f855-4b3b-525b-08dd6805518d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gu3vwRl6BdjTsMRDtfn0zqWNQ5uauOud+r24SxdnDunwFnvnOJsHfl2v0fsf?=
 =?us-ascii?Q?ri3ABZ0Gt+MPTeazs0rbMlgGRdpBLRBqsG+fk0FMu5zTaCHkmSLTDTLsafYR?=
 =?us-ascii?Q?ByzhWAZjnWlZCplNJyEVCNDeGi/pd8yw51TzRk7g3+1MucsjMM7XJ6p4AzcY?=
 =?us-ascii?Q?6EqWFEs/uwFWIrHHilcIJO8eABLLNLhQzO0ffGkl3ELoMGslY8rH4uZT2FnW?=
 =?us-ascii?Q?1rnQYPgvTYEAMj2mttQ0g+rLlmAAniYaHEXqf5VD2EJioz90UNaC6XewiJ6p?=
 =?us-ascii?Q?hfgMJuELNFBZLG3XjvGaDWeHT+KzSjXzcwQbtmb1CeoEBtZCGCw/nqaFU3Vn?=
 =?us-ascii?Q?m7faDOXFYrv9Afb27aCEmKla0Uqytq1T6A/41MlGbbPonHOMcJTw1iaVCp8p?=
 =?us-ascii?Q?mDpi70rmiRzJ6B6/+V8r7SdOemROIi/0iGYRgX/Ws3SGeiPpvM8iD+zYNYz3?=
 =?us-ascii?Q?uC+msaA2c+Um6dj/gOMl4ljUaMVktYSzGQRZAP7DppGNQIwfS8zf7nXupCI/?=
 =?us-ascii?Q?3Vwyq7PKbh3sA3B248S2Og76eW5Lw0/Y7VKoNUblCzGgdndIHUHsKJR7U6pY?=
 =?us-ascii?Q?LlRhnPOy83zzCbjaoGLLQv4v+PuuGpTKA3ToLET/fYqhhsR1cUYiyFOadzr7?=
 =?us-ascii?Q?7KwR44QqIgXMxeMPPbUVBwUPm7P0mkQsMmu5SIWKMDw+LKIZoMxi8XxItbQQ?=
 =?us-ascii?Q?l6pNH/xX9BbMKFXyVL1zSOGDEOsVuDbcM+FpdeRCwgd4GLV0BwkiZmnrnKbP?=
 =?us-ascii?Q?VeDuIrdTUhAKEXaI8liq3vM4AAIAYoqt9Fy/KPaXV/Jd3NXnP3FSVhM1FzTd?=
 =?us-ascii?Q?E0QUf/tJKVDBITt6Lauvk48bXUYBBZ+NMcgs9a4xsY5BYlusv14H+GP5kvWB?=
 =?us-ascii?Q?uXc6H6p1/3F4t/FBTqekgTEwmFSjK1uVMIO+iyE+QISm3v1ggRNzYjc7H17z?=
 =?us-ascii?Q?h+1AJtSaDfBtDhp6TCg7POWSp7UxU/NJgNVSZUyPuBXRY+g5ZsLCS+k4Z/3Q?=
 =?us-ascii?Q?62YpoAxvgR84t5+ilbROUKc3Kyk3bs9K4q8grF1ipYmcaA55H77VIxIiT1dJ?=
 =?us-ascii?Q?q2FVgOd5ggBj9w+6uvrCP/EOQ7g6MsFO9mJ+9l38j5CTiMgvVHSfebHXdxBK?=
 =?us-ascii?Q?Td0KykbeZ6s42KKud4DPc3S5QEdFLoAFKGtf4YLg+A+zMdOzZuvlF9gZs7wM?=
 =?us-ascii?Q?N7POr6zOwtgDBys0C5fMSJNfFctqol4i41+yWvNz8Wtr3PY1JKWndlhq6LTt?=
 =?us-ascii?Q?BORgo12ZwcaC1uoB+yDq2LUPVEsxXTGIQHFetXUUlD/jSQ+paVziJXI9G1SF?=
 =?us-ascii?Q?sQajE7FNCeV2OwsSIEPYxKiHEjRNYa5OLL10tKJ+4022Vy9V03dEn4X1JHHS?=
 =?us-ascii?Q?LWjto+wpBCjLf0UESwEJ8PBDZSrO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Faoioflcf0JDJ97caUVvW10Q8LiR+hi9o69vH2CKgGx2K9MIo3/bCSJdKFQy?=
 =?us-ascii?Q?khqe6fIpmE9eMSCvELhr2cBdZF1gP5/F3TpRzks/LYkoXP/JOEL9v3rABw/V?=
 =?us-ascii?Q?dkYLGdh8B/n51DKF5dQYkOg8gSGjr95SnkkvK4Qg+9UVjUaf0P07Y0G8ZgAV?=
 =?us-ascii?Q?oSc+N0PHGG0V+9xh+NkkOHIPqxUWoYPq3NgfwdsGbRigG5v6gCKBGsspsFA9?=
 =?us-ascii?Q?ax825Fpp/DIT9vWC8pSVyUvBM9LCSGSd+YJlHpmccDiDXdZAf1PoYWdJ/2gf?=
 =?us-ascii?Q?hOx5YYafU55Y72eoi88BnMmZIedkONNfzXumBTE4F4FPQo70RN2Nmci4ZIv7?=
 =?us-ascii?Q?4KgDIvfiySfUyaTWS8IUnnsqg9hncjf7eDUcE1RlQV43VSKqtqlICG1Y9wOV?=
 =?us-ascii?Q?a7GfiREjU1AyqzR5q9Jf7JRkCaAdM7QHjCYSeNp9vfItaqgQ2e6smqDXwfSr?=
 =?us-ascii?Q?iezZZWMnU8F1eos8mG0Orz6sQV1w0VSXf2Wez8vhPnazBCz2fvfBRtezdxhn?=
 =?us-ascii?Q?WRQ1WdOe3sHIPn6WnsNeZziUoj5ctVYjm+DMN7DI83pgFJkp/Sd20Tsznuh2?=
 =?us-ascii?Q?yKGgZEPqypXivOY4eLhO4LhWB9fsly3CGEQKQthgBdjtnRh+I4u807G19HJx?=
 =?us-ascii?Q?5jXZeSnMIu3DLemPKZmHUYTwVD74LInuH5QjXnlMLjVV1kjnEEJCZIOHHxk/?=
 =?us-ascii?Q?yW0E5/uIEtRpDT0MEO+u3eWneN8rZYp9M3cfik1GP6R8eG7O2pKO4lwv/Kx2?=
 =?us-ascii?Q?EC6uNwNrA+RrZPtZU2CQwXnNM16v1I9QMD+9ge8AsX6QcV+B+LLLvzeEbXxr?=
 =?us-ascii?Q?fta/Cw+pu6H5LRtG9cu/mt61ywBfImMwcAQUUmkrasd+3wKZ5+gDTq6HuW/K?=
 =?us-ascii?Q?Mkmg0JDCNVnNOr7Df0DKOYDRJPDmlJ5l8hrbX57u2z+A3eF9Ew6Ft8/GqUfP?=
 =?us-ascii?Q?Q9yrI++7wqdalNkgCE/5HgmIMbhKidzmTNWY55BnN4cK2ozSvtcOWwE0x24F?=
 =?us-ascii?Q?xXvo55mYLrKd6874oX5EHb+sCaQjy7QGQ9rZ/U2+G96NZdyccdg1Y7951sRH?=
 =?us-ascii?Q?z/atL673A44r05WG92gLaSaamBp5gPD9IS2VzbF25DZwMbRtvaSL1NGTrHIr?=
 =?us-ascii?Q?Ml7/nPS00/HtsMjAS0cGUMLYif5NgGy8BOTTQZOCA5sZJ6iRryAgHVMRiChB?=
 =?us-ascii?Q?bM8wMaOb8VX9ohDsJwQORf1KB2f1zkyHCQ69uZRKjrPGRAnc6ozQfDjZK58H?=
 =?us-ascii?Q?yWEOT7LEMKi00rv3CJVoUCEFt21V3QGjIMh+yYtPUOfpRutQS1kTkGPIO72b?=
 =?us-ascii?Q?RP/1bjFwLhDME9//RpctY0wEbKj/xbxz8m/LNjYBhYI6CaM4nAr6kYWaJoQs?=
 =?us-ascii?Q?A5zJRHpx6GB/Ca21aT6fCsfkBOSwEWHHkjgWg0athdr4RuLLIMPgTqgUPXyJ?=
 =?us-ascii?Q?/WuQtCjoMMFZRV93M1odIlpk/Tf6p069CPbX15Xpqov8WogGOe5V6xsef3+1?=
 =?us-ascii?Q?tS+WCJ026JLE3MFvh29XdawrpuIQSxpEzWjZ3bo6Muw1zGRROcIUzAifIU88?=
 =?us-ascii?Q?vgdZwBPqjd3E0sMdTyfx6+HuIRdTtUOQ556eemWC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aca956-f855-4b3b-525b-08dd6805518d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:17:01.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGv9QEMjbdg/534PAAfSl/PTlHImsqiys5TxdbBJg3OhJP6XgL2tIg22oVAzmw3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

On Thu, Mar 06, 2025 at 01:00:46PM -0800, Nicolin Chen wrote:

> Nicolin Chen (2):
>   iommufd: Move iommufd_sw_msi and related functions to driver.c
>   iommu: Drop sw_msi from iommu_domain
> 
> Robin Murphy (1):
>   iommu: Sort out domain user data
> 
>  drivers/iommu/dma-iommu.h               |  14 ++
>  drivers/iommu/iommu-priv.h              |  13 ++
>  drivers/iommu/iommufd/iommufd_private.h |   7 +-
>  include/linux/iommu.h                   |  35 ++--
>  drivers/iommu/dma-iommu.c               | 208 ++++++++++++------------
>  drivers/iommu/iommu-sva.c               |   1 +
>  drivers/iommu/iommu.c                   |  35 +++-
>  drivers/iommu/iommufd/device.c          | 131 +--------------
>  drivers/iommu/iommufd/driver.c          | 125 ++++++++++++++
>  drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
>  10 files changed, 320 insertions(+), 255 deletions(-)

Applied 

Thanks,
Jason
