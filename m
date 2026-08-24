Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431C41930D
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575933; cv=fail; b=cYnCxzDrtmi2LZ6oBzC/YjbvPsJxvq13BcDL1/vwuWmIuvYm0IsMa/AvzvrEe/80XstDBgwWNHo7sNnv3yE626Fnc7VTwLQo6DckLMIAmlB2/vIimRfSxJN/2/0t+QN10Vlh+phyCizosQmOOIKxEbXX2T/PxDYEQsk43V3BLx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575933; c=relaxed/simple;
	bh=3qBDjiwNx644Lt2C5pjTaHovDnIytnpyQpRUAmQXrXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSwYS3VBFcCXv+bpmkQZiA7KtugNmQLFXG+WbUeotovw9j6XDEUbZG6Jhg/tf5g0zlHs6S20/tcLGK0paKFfyDzfSc2q86aknGyIZRW2EqcEIXtRVluYLN0BsROyRnqMjMHNSaB6Z4GzJw4+441HhnEwBNU8EX24SJMhxwUK24I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUDN9BoD; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUDN9BoD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBKicUYYfH3QrM3cx1DIWl0xw33P/mAvnB10JBDWWZBZshTG0ePRDVWQKZ4ecr53Y6iXOYvoT7+ALE02UhBaAN0eDp/O/kQQcY3EXQbQUccvZJVJsFbB/JroSE4RyVplqabpaRTtnpXmH8fcwBstOJLJLUnLJ0yv2o8Jr5tf5FpnTFlAZ+MP/dY+pv1eCQkOaus0eNHPCtxeJvqBVBvdw1SUi//jYdO5VMasBkZVjMhcgjbZqZ6og53RqRsev+ke/FfUKbnRlCMxMmTo40QBsn/HyKxv+ez02y6+6KA59YwhXV/S//TfbujEcPLlbM4t0Rx4fZwRX/hJii79GoN6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o/n8fnpKpzY8b63/83dKH8Rw5doDN5ddstQUn4U8rE=;
 b=TpDVE1VcGM5gNMRI17jtyvsT+oib2zs9DXECGvcXQ+Qmg8zLp6T9K3zlxJP0DTzBlhVSoZvY7h3wtah1ZnW1SZW/yIwAae7cmd5bnSaM66lU23ILJsir/oAq2jcmIygotWxMQUcbgivWHbSVdP/sv8kRVLRoxVdNOfW9J61CpceYuHdbzBZGVP3C0rhh/Ged9jOEAKT7XKFDFvo6hGMWIG16cJeIfXhv+FRpAbyuOREaiddoqYz2xwIKOyBguWrlc+ykaS1uatTA9Ml1DZB2tXxjTK+icp0QLsyy6snB6lusldyDsrkqUjSAsyjAWLeY36CVm5woMI8nJW7nkjmvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o/n8fnpKpzY8b63/83dKH8Rw5doDN5ddstQUn4U8rE=;
 b=tUDN9BoD1NPZZZVFYEcNazRv0eoCHnt2sgYR/ku6XYXHusUlVTaarWHk+n+8z39x24GtZNjbqNo2DqYZu9Xs55Z25z4cu7qylqmhFzBxNQSuX3aJ3A4EPHDzYsNgy2HhghkKMWPaYoytVeo3/C+nCZzgWg3yA9kfB8wXYiGwx9uePIfduLteHhqoUB+vZUk77Pl7UMPT1P4hrNvNiMnaj5mPct3QIMNp8Yaj+fb2oySJWkIZaeBeIPQsmyDwoolAmS20aMhKeE9hY/gIDL0xub5V2FzDNQ8QYOQ7puLiGk35jOPF5FU5HVUkzHa8N4t31dJlDPvcPFiqhzUKmwxX1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:52:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:52:05 +0000
Date: Mon, 24 Aug 2026 09:52:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260824125204.GP244917@nvidia.com>
References: <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
X-ClientProxiedBy: BN1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:408:e2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e86c35-52de-4160-6c0f-08df01de800a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cPWu+eATR3wRnlmiXs561NBw3s6VxGRyTyzbHKGAz1hO0vP3UKlSm91aOSm4Rb9by6n7OuCCg6Ki2L0mfLBtH4BG5n6QnPrP6RMR7EGn5JzCupDgCraqBBRDTcRbsEGjutpb3FXUs5tXctYqECbrNtceCPKAZDdfaHg4al+0FTpmDAFBjNYDR6jJGKchrYVO+ZLhFYBFRtg92/OXlNlPbnhC3qLW1PuFeLdScYqxwiQfqZ408VPT8+e2TIBURYPGuqjtAzM/ljohOekY4+NZEP2pFatlpKvcr9K5M7NGHxdQd3WgSIlZxMaiDl8f4OkNyxYHJIi3ULAjNAGmzixDmRoJ+OO3dACkkpjAC2omsAeGLn+0HxBlJyi6D6RkVWll81UR24zTMIjTvH/CkDp6Z3cWdsOlWDWwC7zYND8frdNGc9dzyMWNV9kFEwoc109QHONjKPX+3dpxLxT1hS1U0IoSDm5Vmgrzyy5uQBFmgY9ezcmLCJb0OHmnOZ9rONZlpq1bv8g38DmgzO4IcDUBK1M58gd2Tbmyx6JVi9jnqCE3qxmEJTd3jaXQeLaXnf2K5SZHinkOAg4IO3As6N59np8RDUvZWUcEuEPk248Skh3kaBbk3mju2zjaxi26wfem0pPI6kMCLjBxym9XRUlD6Il3UR67j2mAeRPCX/ZraVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdRLW1Ed0swm+/S4LVbbEQ7D7m7t1tM4ocEzzpsl4NYhCxWtOBGKTlWYSBSK?=
 =?us-ascii?Q?8omAWGpoetmzPekiu05ZotyTZB2ZnozFYScJg6Yapfo3rc5CfM7EamhIFnCR?=
 =?us-ascii?Q?1cWKoJBrJpK8GioXxtSGc84fz6kbqB7Wsx4VeUQSQndd84kg35dWvy/fS05V?=
 =?us-ascii?Q?slQ7LUCqNLri1V3qOOk6dFru8ProOUNmqpjKsj8kGlzaS2Mqii4ekv4ioOD8?=
 =?us-ascii?Q?R/JvWy1iclgBJ4XSmShB9LFJKgYu905ZwtEiUSp59Z4cJWWD4dvd6R1nbG5D?=
 =?us-ascii?Q?+k684IgT+SakG20sBkVuUsqq+kaBhblRi5vDYzq2kGir7qsRNm+iDlWlBNz0?=
 =?us-ascii?Q?xNA+HFy1CpkQslUAHDBBjpqJHKhgJlE64XVy7KuzPYUuTAOq81CRDZZSspo6?=
 =?us-ascii?Q?plaI1YmWywh4U3gw8XG3h7srVYZf7zlRKfbmFLnx83jgl/G1zRJgpId8br6x?=
 =?us-ascii?Q?tz2jWOmRg2HUnQT7qhTmnQM5zW9W/go5hUi/PecbtPnvAAU2/Vo8BtOuQR6v?=
 =?us-ascii?Q?NECdp05b0qJaSj1wnXD7I+GAMNXJoIdtEfRgCY8bC8zNIeMBPDtvlv1Wj4Wh?=
 =?us-ascii?Q?IX5W8AMmaoAl+NXicQ+4MFF9v6bTIGAA95UddsuwWZzMRRTDb5GIwpg0sq7g?=
 =?us-ascii?Q?KtLBH1mfd3HeaGbEJVhXxvQbltYBIfkPjj/psttwj7tXuaLMj6/zQzIZJPZ7?=
 =?us-ascii?Q?0mF4g3fxWCAcDpAVlMmKe2HUfj5FoAa0PkPPlpRghWZfpmFAu0vWvn0JcIgg?=
 =?us-ascii?Q?ZTU4TZjNWT4uBYpihsQe6QIg5/Q5zihhFC8Na7TJ6hn4iBFWCx0YDfak7gS4?=
 =?us-ascii?Q?nOFwngCJ6zA/OyJGSj5x5/2GRazChUdQLAGAEhGqGzU4dPUpkZKqWNSV9Xui?=
 =?us-ascii?Q?VRljwrfGBqiNIdsdhl8smS63MvcqG0iHTEbQrtI3gpwG8yh0DqOBFmYJI1cK?=
 =?us-ascii?Q?I7nyBk50all4pdLt7CYBE7qmo6eUm1jpFdhhP9IWzh9zCaaRAmOsEpRQTpJO?=
 =?us-ascii?Q?Z/ukO//eV60H9Oy12UKQw2YGUDmmR/b1UyHKqeTeaijGpJoUw5Vcibnt6kAc?=
 =?us-ascii?Q?smduFNZbWCFdl9jELQ3j1K8Jm1j2CkHAb9CUafdRsIxVo7oi7eHOVt2w0Ga4?=
 =?us-ascii?Q?z6Lz4NDEyUSzjDOOskjC4Y5Ene+aqL6FI08ku6dChi3BaV2irmDmWAzKFPx8?=
 =?us-ascii?Q?l+buQCaeDpa1uCzTJyxwDNFcBgy0yxRhp9tx4WLgzazY462mS6Rt7QnDelGB?=
 =?us-ascii?Q?CKmVvrrNAb4ode8mCQjt/M4XE2JB4TUr1dLTb/NUe2DhTk6kJposJ1i2rdO5?=
 =?us-ascii?Q?Z3GsPhalMlIaVa1j4uddhfU7g39J4CfwRBUzPP166wuIsHc1l99CZP26M5LI?=
 =?us-ascii?Q?1Y33FsH+tYIsGNI3MrwyPANP7HJfaFDlScjbLMTToZX3eMIqWI5MOWwpeUSJ?=
 =?us-ascii?Q?KdI2MebbfxnShH1yONBAJKbO+UGmZqqAUSrJYtrQKzmsawC7HlS/Th7duLuu?=
 =?us-ascii?Q?Y4OeJiB5gybgzknc6Q10foj3KTHFiUw28W1UN3DNjwt8vrnZ72WbO7rVxsXV?=
 =?us-ascii?Q?6UA5IPFsbZ9pUgwrM8vYfAsHecwSPggdFTLGgwMm31k0z8ijw2hYMFdYSoxP?=
 =?us-ascii?Q?1QGTBoPVERrCm/aRfBgPR7NQhaClsMBv6cB9WSF7O4VCQV1LVmRTuThrB1Gm?=
 =?us-ascii?Q?3YN+LkDB2r4+ajaOqtqIe+uM1DDSTe1XJReyayHdpIWP5NSF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e86c35-52de-4160-6c0f-08df01de800a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:52:05.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgf+HVe8x3LX26MFnJNX0A4L6q2WWVUA25H5RpSxKU3JeiK3tXvKHJ10ryMU6CZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

On Mon, Aug 24, 2026 at 10:50:07AM +0200, Andrew Jones wrote:
> On Sat, Aug 22, 2026 at 11:06:25AM -0300, Jason Gunthorpe wrote:
> > On Sat, Aug 22, 2026 at 03:50:05PM +0200, Andrew Jones wrote:
> > > With the RISC-V IOMMU MSI table and irqbypass support in KVM, we can
> > > write the guest's MSI messages directly to the device without
> > > interpreting the IOVAs. 
> > 
> > Every architecture can work this way. Nobody has impleented Linux
> > support for it, and if we do, it must be arch generic.
> > 
> > Not being able to discover the vCPU from the MSI descriptor means you
> > can't use any of the existing less-optimal Linux flows and are forced
> > to implement this hard thing..
> 
> The RISC-V irqbypass work does not require a new framework, or even
> callback. It uses the existing irqbypass framework and implements
> irq_set_vcpu_affinity(). Since that callback programs the IOMMU MSI table,
> it belongs in the IOMMU irqdomain.

My point is you can't use the normal flow which relies on Linux fully
programming the MSI-X on the host side and only uses the guest
descriptor as input to that flow.

The iommu msi table doesn't actually help unless you can also directly
use the guest's descriptor. Right?

> > ARM is basically the same, the ITS page goes through the S1 and S2, so
> > the goal is to get a valid ITS page into the S2, tell the guest to use
> > it and create a S1 pointing at it then feed the MSI descriptor from
> > the guest unmodified to the HW.
> 
> On ARM, the SMMU translates the MSI address, but the ITS performs the
> interrupt remapping. KVM must therefore know which vITS the guest IOVA
> selects so it can resolve that vITS's DeviceID/EventID mapping and program
> the physical ITS with the corresponding vCPU-specific state.

Not quite..

IIRC the MSI entry itself tells which pITS page has to be used since
they are 1:1. That tells KVM which vGIC has the vITS table so it can
read that and get the vCPU. Now the IRQ layer has the pGIC, IRQ #, MSI
# and vCPU. It then creates an entirely new MSI descriptor and
programs the pITS and pMSI entry. The guest MSI descriptor is thrown
away.

It is like this because this is how x86 does things so it is easy to
implement.

However in idyllic ARM land it could work like RISC-V. The GIC could
mirror the vITS table into th pITS table and apply the vCPU to pCPU
mapping through an irq domain. Then the guest MSI descriptor would be
used unmodified. These days x86 can be similar, if the guest has the
iommu remapping HW it could be similarly mirrored into the physical
remapping HW instead of reconstructing the MSI descriptors.

This has never been implemented because there are alot of missing
generic pieces to use an unmodified guest MSI descriptor.

Now, risc-v doesn't need to mirrow TIS/remapping tables from guest to
host, because it doesn't have such tables, but it still will need the
rest of the generic machinery to use unmodified guest MSI descriptors.

> This ownership of remapping (for ARM in the ITS and for RISC-V in the
> IOMMU) also justifies why ARM does not need an irqdomain in the IOMMU and
> RISC-V does.

Yes, that's right, as I said earlier the irqdomain for the msi
remapping table seems appropriate.

> The irqbypass support is already separate from this series. This series
> only introduces the IOMMU irqdomain, which owns the IOMMU-specific MSI
> composition now and will provide the irq_set_vcpu_affinity() hook needed
> later. Putting the compose code in the IMSIC irqdomain now, only to move
> it into the IOMMU irqdomain with irqbypass later, would add unnecessary
> churn.

I'm sure you need more than irq_set_vcpu_affinity() - it still has to
use the guest descriptor unchanged, and it still has to get the
correct pages into the S2 at match them to the ACPI/DT description. We
don't have any common APIs to do that, and every arch can use this
stuff.

Without seeing the whole thing it is hard to be sure exactly what
arrangement people are going to want to see. I'm also not sure how to
combine the iommu MSI handling, unmodified guest MSI descriptor and
this msiremapping all together. A guest centric flow and an normal
host flow are very differnt in this model. This is all new.

This is why I'd rather have this patch be something entirely normal
following existing patterns then you can come and propose the changes
to bring in all this new stuff that must be made more general and it
is a self contained picture. The churn is sort of the point to help
people understand exactly what is being proposed.

Jason
