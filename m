Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B439769A
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714786; cv=fail; b=KKLFNcRhc7WdFOVc1ezOm1JMclZAnTZGwRCY9vQsPtQscJc106KfQiL7VHTRAGC9vux9w1HODujAJFnDOxO3bcNrt4EpxcH7xuheVP9xTpNzWg2ZXOP31ff5NFKB0Eo3Kbp3FPWoWzv9duTUYWOtyKza1BMEldvDgXyxluCJxoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714786; c=relaxed/simple;
	bh=z99pCzQ9EJuFrGKFQrQLIiDGblKgxT6JFqKl27erLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CuQuaa7R3yPlXdwVYMh3VTQ1sxZ2gIA9okvNX67GVdpiXKDLoxwmQ54mN9CvkV3BKPm6GgIHvsgUK5XSOSgWdLkzgy3Cy/zkDfxHFNMBM4R8i8KLQZ++jUS5ZGvQE8kS9kgomNQZ2cuUdqSrNsWKqXjR3rkBbFA02xAUFJy22GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjiEpSzg; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjiEpSzg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0yvoLzgQP9M4sTD47SxhwyXnX6DkoOT3y2jyLDQRoXQtUB0YDKbgnZic1U9qkd2p1fP63VvfPDnKb9nB07ksRiXIfpj69iRLQ2HZ92+108adRpU5ma32Wm43q0dzsNxsJ+D+tEicl01mnZkOP3JoIn4YgiqTH4PGZ1YfPOhoDQ2DCvQoxw0jZAIHGl4EVcTWky2WtFhCdc7M4sN4gOQGDZ6a91VqFKGF0KzgPFnS2vJsQK0zJWAJ/4TR817jkVmCcnU1utRxRPa1Ze7fs3NH4OfHYDquLBbhF3xW1nrNiBrGhZ3+zgDJTk4zCRbB+QA92B4wNkHyZrS9bGIPFTbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edv3o36cr/KBLvCH5LggcKgi5MLxSpQi6O9gxoqtY+w=;
 b=EDiuMWZkMaj33GAWdivqnGLo83m3K+QhzYMLDRUxHD7Jx8yPqQvFrarPc++Ffc2vsHD5JY+Tc8pokcezA+eccSG08aSpEJhIlMKUgHK5vH9vJzCRV1iOwU66SgShbLXsrzBaJeRNUBw74ayfXZ/nUJOo67P/AvnLv9yTZjHpQIlL/odX9/shhwQNkTTm04rwW2XRnVqdHYRMiPkekpZnCsDrcKQJ8scTmIPA744uoUnp6XMkT3f1J/bZkHCHkSAjqOldDV6xBKpOa7GksbNRuWbeFzP1fvC7jhOaK7lHxKBulTWEFntsumtm2SGXPvEag6FT6u5GvQrGTOSspPKkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edv3o36cr/KBLvCH5LggcKgi5MLxSpQi6O9gxoqtY+w=;
 b=RjiEpSzgumRO4edWbXoe+A17+9MnuUKM/W/tno5dxGi/deDAyU37+Ts4+cMpspO3Qa/33GjfjiDfbFmwGI8EOwffqOnzC1stmLEdkGx1IL/wNP3bjuGJH4kxeHhJ3KTkFFCJSbZCvortNdVKMHPy2A8pFYTBqCI7giwAnGr31UaDuQO/7Q8morHsNhIbNlmh+9C7M4shBNQzxKJV020tfuArdYSYprw9jSGYJtGLHUWKNP2CEB2ipRfzn76m0hGKERD12SJwR/oPxe+ub43u1Ey/Rc4eqi29d7a0cJ6Svkk4MVZM/XDiOFlo+DDpFxSEvUIJyKBYHPUygP+IfkpIUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 23:26:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 23:26:20 +0000
Date: Wed, 13 May 2026 20:26:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260513232619.GF787748@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
 <a8db8d35-e7de-4e74-886b-d978e1ecff06@linux.intel.com>
 <20260513122221.GG7655@nvidia.com>
 <20260513152014.00006a3f@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513152014.00006a3f@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0442.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5681c92f-ed7f-4c1c-c43f-08deb1470a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799003|4143699003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	mBJrrMd3iKCqOeFJSZ8eUelQvKbokRt70arDKilRdoYkVYbGelxKnFGvnX2J9UBM9r7+VrPHkc8hddNIeKMDtOmh4u9csY/sHLRvzrnMqL7mX7IQDgWJLjOcbecU4Thv8yxWjZf36WqEftyPJM/eawrLxcJ4EfPDSJ9fG2d1yxu4G/FCb8TMgPXSLyjig/U2XgA0J3lDBXxSVsF4IONTcVYxyQdLPZPj1e+GcbKEo7yczie1SwhB96D/OxtUtXTvEMLdL1Jj1yJC/C2X047tg/nAQr/82XQN9qu8zKfaAPSpz7NrMBANxnMFCq+m1er/qVao4L2OA94a+eOOdOkuxVZ5V+4MsylFHLMFIGx4qXAISyBt4+Lh2+ct/acq/Ao1zRtNuI6AEjjThUerwD656E6xqICRk6T4xJSwIKQHAZQdKGy0rIEZ4dLRVCT7Uy9DYm/viK3HP1iYDds2XwOuqX/PbAsI7LWTTIGQNz0GJyI4ycFm9cbi1ojpwIZ+5RcXW3nh9GwsbYFVzBlZFC81msCIlCaZl90LZDt/X2jzCvAj1VSzyfnRI4sNFkn/uyoTpGGOueg21fbGE49s1/oxBu1/wxRoIxiFj9/Nm/NqowPm/j0efcaDpXufTCcSU5+HVbmnkGdFalTxKHrPL7QC7gRvyFbMrL/SVx43dbWCujI+jJ8kF5StEwwvH5JnqnSy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rioTP9mQF4w9CeZL/XVb2vDBaGqJrRalGM0jVrAvRgYjvElTAcyV21UO4ds+?=
 =?us-ascii?Q?i4V32xOVUhJFkmHgMOQbXzrsicB6E9Hnv/03HpbWqTIYjxfQCxpAJceed8VS?=
 =?us-ascii?Q?brPOUNfZYt93crL5E368+CIlEH8qzR7vx3htb9rCr8uWbyzU2Xf/IuRFHbya?=
 =?us-ascii?Q?sno8rvG1H5cLzp7cXvbosSWIL862+Nig10manp4QE1usR9jGlRx5arTVkBUv?=
 =?us-ascii?Q?r3q/x/4z7W9QZY/kGSPUQRdopDBcwEg3aK0UWjQtNRAgLmQVIijmzZEvB7Kl?=
 =?us-ascii?Q?iYIcmRyftJnul2Iky9+WQicrtfhSEW6ri+vir+UcM4qsJPDID8ewoCl1Ie3W?=
 =?us-ascii?Q?aWthiyGRDoKrBmWDJ84e04YM31zqaJ/uZf5XeSLAeAiuTAYlInQ0/uiNU45u?=
 =?us-ascii?Q?eqomhH6an9v+UfhY30Vdb3cHUeqCvjE+Z8KjXwRg9mmPOcQbauevNJ4Pxa3B?=
 =?us-ascii?Q?mX9Xm0EIkU/1u401ihsgESQa4UYEB+r+8dX1FqHy27gKsDWanUgaYXdjck7y?=
 =?us-ascii?Q?lv0Nr+RBlhE1U1FNo6AIne4Mz6vgAksDUsZlFzB6k66blVLgVkG1qE9bh6so?=
 =?us-ascii?Q?3ci5TStAIPWwCrxxhmEvPLgK/vZYksvo02E6uxsaSjmW5fmXUxyv1Gba6SFY?=
 =?us-ascii?Q?paxyvZ558/5HUIH91WI2ekSLYVpJrjDrbZAw33atAYxELanJHfTIcTjJAhbi?=
 =?us-ascii?Q?3ymUNgz69vq721Ym02tkCfZvu3DO/EIOgAyzt0UV1MYEi30TwvD4123iBUFw?=
 =?us-ascii?Q?PT/rQd475vi8GOOtJVx+Exy0J6KSKadj/RcTx/wK2FkJgv24YDnD7yoC4iLd?=
 =?us-ascii?Q?9ku2bcy6O2H00smGe3JvYZmDccN7YrFeBNzjFdDXZ5Y/ABGVbuJ3q1M5OC1H?=
 =?us-ascii?Q?bI/VWkFIKyERHWcwcHKg21HSTox7+y94mIKsX8rDB3vx9iwyDdzjai8QR4uf?=
 =?us-ascii?Q?r8AdkDI89nT25PorhNbaFveafSVSgwEPZI02ZAOPc3hHdg5KpNPUoiClcbTs?=
 =?us-ascii?Q?cgGbH8DkBiPrmXe1o3LycOFEDm/OeMb3KbYI05TdK9szaVeVQKBO/E0uYFtk?=
 =?us-ascii?Q?Pusj5VhQAyL7p/hEfD+o8NNfjO5pPWjcXILxo5Fw4ShQReNzsbfOFURe0Bz+?=
 =?us-ascii?Q?eGWwe7V1NUuRGcOTvNjoZV2NqTrL2geexPjiXWShKHk42PC0Q2U4IAfBEER3?=
 =?us-ascii?Q?i9g4qfpwfv4quBM21Kvb2YSJXdxWUHoK7K0Bt8lJc9oTKC0teuehG6J9t56t?=
 =?us-ascii?Q?5ygaWvN+OCHMw0FWOyajIwL5kBEoJby+qSLnziTVTcMHAAJ08S9hYpCKQG0F?=
 =?us-ascii?Q?+Gm8Awy73ZH7JG/I9gNWDo+lWd5K44HeZfnNbZMRUACbdMXZQ9AAC/Zapg81?=
 =?us-ascii?Q?jK9FeLpUlpec4CrJIYGUYfeyO1HdtyHJkPLh6IXk6OM/fYzgyaqOO6PlDJVo?=
 =?us-ascii?Q?6CtT80m28wd8UeP7imFRtvqyYNzmwyyVLAGmuZ2AWvOq26OHiNu9MJcpaukI?=
 =?us-ascii?Q?sa5DkRmds3tGgokJ97gCDxUAWk4BwQFckOArBwSOXY8500ZgZrhutFfZ8cAZ?=
 =?us-ascii?Q?S8D/TL/hDc/TnKOS4SYq8mJndTx9v4hH/kiec5sVefVIxqFribUFoXzVyOhE?=
 =?us-ascii?Q?RZ5FWQlo5DI2tfLBgW5T/IRrspKC+vu3EG6magQjZrJiqSvdl3wyRxamYUiA?=
 =?us-ascii?Q?GunV48/CDszFD9ZEtdbgm2aSoXcmb8TMNctqc8M1YbM/OZg2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5681c92f-ed7f-4c1c-c43f-08deb1470a17
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:26:20.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFVjfXgvJHGRZt7ANlWLdFBXhG9TAoEHLwIA2SbKTvoc6i65Gd0ZJxHXetqJdkki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

On Wed, May 13, 2026 at 03:20:14PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 13 May 2026 09:22:21 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 13, 2026 at 03:53:43PM +0800, Baolu Lu wrote:
> > > >   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
> > > > +/**
> > > > + * struct iommu_ioas_noiommu_get_pa -
> > > > ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> > > > + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> > > > + * @flags: Reserved, must be 0 for now
> > > > + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> > > > + * @__reserved: Must be 0
> > > > + * @iova: IOVA to query
> > > > + * @out_length: Number of bytes contiguous physical address
> > > > starting from phys  
> > > 
> > > Nit: Instead of making this behavior mandatory, would it be
> > > valuable to allocate a bit in @flags to toggle this behavior? For
> > > extremely large mappings (e.g., several GBs of contiguous
> > > hugepages), the loop to determine the contiguous physical addresses
> > > might take a long time. A very long scan could theoretically delay
> > > userspace DMA setup.  
> > 
> > If we are worrying about that then a iova/length pair would be
> > appropriate such that out_len doesn't exceed the length. Right now it
> > stops at the area boundary IIRC.
> > 
> 
>  Yes, it stops at area boundary. How about renaming out_length to
>  length, then use it as both input (cap on the scan range) and output
>  (actual contiguous bytes found)? When length == 0 on input, it could
>  mean "no limit" to keep the current behavior as default.

That sounds Ok, document it carefully it is tricky!

Jason
