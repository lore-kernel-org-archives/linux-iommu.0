Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5F3998A5
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589931; cv=fail; b=a40fYOcxCdX4p5L5beA7+5rGylexz+BtGx1Y/KYjMiLVP1newmPULjm/+fuqyvYggNsU2xNLgxpVq7HSyUlj8JFGR2SMuQWkYSku3pkqy5Iz+Mx+xLh86YLWYDZtFfnk6mmY7jwy/BTSHMhGpDGDcJc8Bqmx7SXe33VKdje71EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589931; c=relaxed/simple;
	bh=3R6gO8AwVgiafcobrewQ+AMJ7Nh+UZG3Oo840bg0AhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QCn15JHHbwQqdRkjq1VrlehwYqrfGp+TIknKY+gjv3XUonaYDHYOF6pHDB72AVkiBj4p5+ek4OwralYRluUQ8XXx030UvIw2pW4M8MQDgGSE5PmjPGHdY8CgM+8jRcgw/XC6m/JJvDJXxO6V0djqSHdzR3at81yLLk4NatvOtUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iyWIS4BI; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iyWIS4BI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0aTcVtXJ8fu81dEvAOHKqJrvXPnauZkynkhTFv1B52HqQwxl0ipQ2zxHzrdDKX5LPbRS9T9GZIHGKsHv5M8niy7/Sz/nRx/k3OkMwLXtZebWQmCiHwHnG0dVyL33ierRjoxT6MgEJjau7wsehw6e6hYNsvnFlouDKMbmmdfUoRoubIqqRd+qyHmtdAnn6lR9YYZM51VtW+V0fc1fUla2+fgkg5GbsJ5AZ8wyOxWzGzokeeacGiJKAYN4ZivRZPT1XWxudy4UzPpd6bLpl6Xv3lCo7TTJEHtFWDG7jnmwYiYf0+GNbDrErlO6upPuuoN0mulQ11NtVhWQOkQuMTJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS90+hDWkoQMXjPoyhb+n53wP1Mdv1F1aMvPO5wD5Ho=;
 b=JL8ucRKSYAZfwwbpxZJDD7hRNoRC/KMe6IF85abQA2nHXvNRJDkOEnIZyJPM5uuA6Y2HVfLszohCzqmin8lce6yApykOye6LXF9PxXdoUV1fQUt5Jd8da+jfN03Sblz1yRINhdYfRoGPh2HCFeRtUahyz6p8GRT8TMYcsdvfXoSTREJPugocQyb5HzG28bxtC7NphjMprIqwC4kXHjmypuPoBLB8mMZtvFEHyhRryYV7jCv5JuVJweLCAkPTTtnCWpgt6DHem+X+LDgTZ2u054KqtfCXonZIqIx41Khh8Qgh6fdYrvrKZayRh7hhF41n7MzRneDMeR0tnsV9P8FQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS90+hDWkoQMXjPoyhb+n53wP1Mdv1F1aMvPO5wD5Ho=;
 b=iyWIS4BItjEe5YO5pnJ29E0waSsLARzUrf5pOOeydaUNYUS+iMH+OcBf+I7Ib05XtCFWPHR0KAImNVNs4J1MPoLRe0dDR3EbOlLMMSyLGvAa5vTBHUsGdo2fJ8SoQwbDdHxLUBnhZtJOelmeKSijLHui2DTzklbAnaaxTmd79L39OZvsyOGiQfaTJzccS2G2RveB6eIXy45S0mEERtFjJ9rNuZD0rnCk0wJEPp9qTzuf14WQni7fNKXSWX7KVFM1WOuanTaW2CBCoaEQbfhLgczJz61+xJQAl776g80eplrv2kxJIPw4VoCgmDWBMIFyIJe0t1z3FKe+7vhhoqLAiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 12:45:23 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 12:45:23 +0000
Date: Tue, 12 May 2026 09:45:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, alex@ghiti.fr, anup@brainfault.org,
	aou@eecs.berkeley.edu, baolu.lu@linux.intel.com, guoren@kernel.org,
	iommu@lists.linux.dev, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, nutty.liu@hotmail.com,
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, vasant.hegde@amd.com, will@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: Re: [PATCH v3 0/2] iommu/riscv: Support Svpbmt memory types in
 generic_pt
Message-ID: <20260512124520.GH1116784@nvidia.com>
References: <k6k2ufkol6trxucf32qxj5i2v7safcyososquomqr7vavqwvr7@s4b6h26htu4x>
 <20260512075339.18339-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512075339.18339-1-fangyu.yu@linux.alibaba.com>
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac02bd0-9de5-461e-eae0-08deb024556a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hbwu5uaqN+4JY08dG7GmV+t+UixAGxDAYPWJVwUPlG3Ohok3APFLa+u4HLOYRYid8qjkmXlSWM/QW1XeGnpIJl48Zgu7xEAerleircvBOdJdRRl141ufgy38qnx9QFnZiV07r8ZlKlN9zXP8ltBeEoq0xGppv6lvhh5czQv4kOBcNC3ywKjLTaSNiQp/u7F4dPaMWHiU7mWBQfwAOXEL3Bgh9ljJR2PMB+vbHTZ4tS0hzESdMGRJ+C4SbQM9wURO3OoUDVMP804WkWgw0fbYb9eh6ft+XxLjhk4BlggKWE6o7Ib0lEBkWMaQ26OAFMj72DeERBD4SEmSEET4f701ssItt3StcUz7b95RWVi24m26WzqcJEV+y1j4myBVe+wAoZmD+z7/SK+VyqMgA+hJBh47ScmqOBcvL3tFH3QqVkpcd/a/beE14Wuy64XqFihiICT28R2zZHx54aF9zSWKPFQvs5E4ndssNCoHF5sosBuslAtrPDcDl4nMnxJoUb4/X2EJ3hsDdES08McMqDHPYRcMSxSi4CoBPLN7HCtk9f3OoBszCwfG5PowDru155QMts2ijbsBd4JGLOcxcOc17dYAf8oEyxACxOEkZkQEmiGyi7kU7UaBdgAQ7XuNRv3whPVUtHFLwbZpCICD6uH00/eJMUz0br6Aw/Z3rL4LzbX9QU6tCZQ5EAsbQ162hVrl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1pNTRpeFI2RjdxTUF1aG84b0NsVzI3QmZFcEwxVGw1WG56c3ZSV0Raa0do?=
 =?utf-8?B?Z2NxcHg4QVVRRXFKeUVZb2NQTTAwYWt0d0ZIZnBYdFhFNEFyT3VUOEhMTUNY?=
 =?utf-8?B?dHppRFJqQ0JsRzBBdGQ5U0ZRWnpOaFBWZklyS3dMSG9iM3NhYVMvS29JOHpi?=
 =?utf-8?B?ZStyQjBBQ05DVXdBRmlaRGNycEdtWkQ3amZVOHdtaFVwakFFbnZDWm4vbXBu?=
 =?utf-8?B?VXRwMzNVeFZHeUpvTWNCam5OMXVNZE1oMjlIZUsybEFxanFtb0xEbUdybXdY?=
 =?utf-8?B?anppQ2hNOXkxd0lrTnBXK3N3RlFqNnRYQXRBQUpUaE1obHpPTVFHUUpkenBV?=
 =?utf-8?B?Ky81anQ2SWswSXdBazA2bGRLS0lvdVJld082djNqeGtiRjdpNndOWnFvU3Jp?=
 =?utf-8?B?bVdXRWxDSG41UXcyaC81N3RLemZtUzJ6a1NVVEo3Sks4aFEzWDNSTlZRMDRh?=
 =?utf-8?B?ektoY2ZsVEs1Q0hVNmpNMHJNS0NFRnBQaW9Fem9wSFZlMXprN0dhZ1hUWEtB?=
 =?utf-8?B?MUYxRXNWcVlTNVVySGFoWTdteEpBWTRNTko1NFFvZXN0V2FaTnFmNkVScnZE?=
 =?utf-8?B?dUVJV2VDVG5zakg3OUZ6clhhSU9ySkJzclZkQUZWZlNqcGpwMVkrWko1dHBl?=
 =?utf-8?B?YmpRUzg3bExDckVsb2ErOE04UlM4amU5eFZmTmVmT3duVDJjaHNkWWVnVTVv?=
 =?utf-8?B?bHkvM05kdVEvSGNsbjN3VlhaaTZscDZKcEY3Q242cGJtQVYzQWt4NzBMRnEz?=
 =?utf-8?B?QWkvSi9SaGkrWFBZQy9RN3JpRHk2UFgyRUpmdVNQWjdkYjA4QXRHYzkvaXFO?=
 =?utf-8?B?ckJ5SDIvNi9qeTBveGlVcDRSSmVmTWRud01JODVVRjdYcFRJeDVnbythODlI?=
 =?utf-8?B?VlZ1TE96Wnk3R2F1bXpGTnZNSTVYU3I1V0lBTzY5MEdNdE9UZ1pXVjdCQ0xs?=
 =?utf-8?B?QXI1ZlV4Y0VBakZNTmxJNWxEdWV3VGtwdk1zTGN1Q3J5bkp4RzBZd0xRSGp6?=
 =?utf-8?B?T0dmb241bzdRTUlhazNpY293L3UvcnJML09sYStuRmw3RFNJeitkemtYanVJ?=
 =?utf-8?B?ZjRzR1poeHR5QTh0QUw5QWUwWXhDT2kyMEN4Z2Zzd1g2dDM1YnVhcVFYNysy?=
 =?utf-8?B?dkJVajN3STdYRUJBRzJEaGlCQ0FxdnoyWUxTZ0NVblZXVkltcXFETGlEMHRD?=
 =?utf-8?B?eWZWMy9CUmtheUt3aUdEM04wVXN4YzAyUThJUlRJSUpnV1hHcG1jVklOMVEv?=
 =?utf-8?B?UkJTRXMzczBpeXRITkdLWkFNeDhucVJlcmpJc2pLOFpvYURyeGlvQ3RKWmVs?=
 =?utf-8?B?K0MvNUpSTDB0Y1d5VlBiNU05akI5QWJSL3QwMmVsS1ErWW91Z09BUndqaEFR?=
 =?utf-8?B?K0h4T1MrRFd1TlFvL1JUUXBVWk52TmV2WkdXL2F0bFJXYnFObnh6eDdYRDdt?=
 =?utf-8?B?SjhzSWZJZFdpb2NxVzNPejRZTkgxWjR0U2pUeWk4RjlYRjRSNzZhbE85Sy90?=
 =?utf-8?B?LytrdnFrWWY0RVhmMXhtWmFYREpJV2QwVDk3U0wyd21NdVY0SldKVkNQR3pV?=
 =?utf-8?B?SkJManpKazh0NXUrOFVaSURadys1bkhONmhaQ1RQcGFieGtCWHo5STY1Vzdu?=
 =?utf-8?B?bzFvT1ZCYTZVZzVQVVlqQUwzME5MS2FFODNXYUphLzVha0dVWVpEZG1KYWZx?=
 =?utf-8?B?WGMrTnQyUWhialdjeUtoZ0MxMGRCaTZ1MENhY1F5emlVNFI2NXUrQm9Tc1Jz?=
 =?utf-8?B?UmV0am9LNEo5ell1Mkt1ZXVJRUxQZi81Q2djOWJOMWxwMFRUUnNFemx3M0Z6?=
 =?utf-8?B?YXJOTTcvRjh0QmJsVitiWEZtOXU5VFR4eUZVeVdzYXVkWjhvWkhTUzVYVnFz?=
 =?utf-8?B?T1haMFZ4Z3pTSENhTDBqSTEwbEFFdnp0dzlOcVVMOENXbGZOK2ZxVHBqV1dJ?=
 =?utf-8?B?UjV3bG1laWFtRDNGSFRHMC95ZEEwbUlYbEJuMUg2ZlVpZWVxQ2loSk9KNmdL?=
 =?utf-8?B?R2FabXJ4MU56THE5QXNRSkdUWEpVVU05SWRUaWtKT25HZjdVekJkQkFDZkFF?=
 =?utf-8?B?Nkx0TVdyVHYvNzI3d3dTSHhHdkhlVUFVS1pkQUJMbzJXQW5naFFKbWRtRGt2?=
 =?utf-8?B?aEN5Yy8zYStIb0lIVEF1bUs2MFlxMEx1bm96R2RQUmNwcFVVaDBOYllvTzlE?=
 =?utf-8?B?ZkFlSDU4N0w5Y00yNU54OE9BYXowTkZJUFhsYW4wMTA5czA3eFRITFY0RVRH?=
 =?utf-8?B?Qk5hL01MMnlxNzlLYXBSeXc4elJydDl4Ky84NkNVNjBmcms4cmJ0RHlNR3Fx?=
 =?utf-8?Q?/TgF7WTV4VKkLPqsAj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac02bd0-9de5-461e-eae0-08deb024556a
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 12:45:23.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS2DbdSqWhSf13tTdwYyPVKZ4ruW4peE+8UDMllWJ8fAIjp9oGWYcfATUIbS+wfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On Tue, May 12, 2026 at 03:53:39PM +0800, fangyu.yu@linux.alibaba.com wrote:
> >> Fangyu Yu (2):
> >>   iommu/riscv: Advertise Svpbmt support to generic page table
> >>   iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
> >>
> >>  drivers/iommu/generic_pt/fmt/riscv.h | 11 ++++++++++-
> >>  drivers/iommu/riscv/iommu.c          |  2 ++
> >>  include/linux/generic_pt/common.h    |  4 ++++
> >>  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> >Applied this one instead of v2.
> 
> Thanks for the review and for applying this version. I’ve sent a v4
> update to fix the 32-bit build warning, so please use the v4 series
> going forward.

Since Joerg already applied it the normal thing is to send a fixup
patch to correct the bot warning

Jason
