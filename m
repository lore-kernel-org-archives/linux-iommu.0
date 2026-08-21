Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887C423E87
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328785; cv=fail; b=i1uH6YymDZS4fuaIDHXV0XZtP88DB8Em63YaJ99xJz/BbSa7AJFs+u1KyoiijTNSy7Z8pyQrCmGcTiNMe2d880vcjccn0rjmvDUz3zqYuDNAlX8Dqa1JwbCzRR5QIVQ8jqiajovCuiYjly3YlKx+NbHUJXByL7PYdJQ8/aK2mg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328785; c=relaxed/simple;
	bh=897M0j0VB9GL+Fajsa4AKRdIlwQDvK2ko9Pn2Ktp+Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmkSGwTJrlKI7xX88lgZZrLFm42JDXoHslz04UgvTvkbcpbgbbFcQ0UYMpmqTu6CP7X3oHbx13TrSMuOPS6nwshHxXis0S0gJ2PDrYDyA/JbXa7wSyIq5m6PjB+4ED/I3N2lds2En4BBGiExhEfD/t3POh8xjKnM/NzAB78tQ5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DotMfDcR; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DotMfDcR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLXP5dLmzUbfFkJ6mr1yWXGzSa52cTsUwpugJt+9ypjekvcjWl/HBDz+c/42F6EzrTs3MoBz2QQv5m8rZvcXInCyEnfCgGx7reI/f6zsWZ/jS+YBMdNcVMl7TaJDP9+bMKBsT74R/bgE4ybjWmhH4OjuTISkrkRfU8lgyzD5VhycyhsF5qErgdVh4yl7AN7nDIPsZK/2HdYkbrqYdye2d2IFNvXyUpQLS97XDoaxZKYmac8nDVpXvLp2bLWSU8E42ZgfhUIl3gGPZ5wkR1OC48VUGaG1W24fngiRYRRUw1HAECEy7/qpWLaaAdggUfS5AwYS0SOzLRXWOKuPCylmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw3dxnKtsVm+rf9hv3NqOKZpVZcCJVPkwgY0PHNZcTw=;
 b=nJS/yf5+nhuyua7dKa5Ipat4Fe1hdePdZp3kzRQ6bpKEHJZm32u2GXRTL7HxvlC3FfY+OCOBhVK+RYOw3U/tImW8Fw/XsqyGGQ/Y3SKhkh33t4adHZenW4paI8G3LpMd3TOXAJ4Jw5mQSXRyrZYD+60NqpLzGkhzqpwhphsE2OKPX9YZBONjB0pEXReA5VW0L87WfZEqIic9Fmqkr3w0dmfftp8ozlg288kxtj77w81e5uKFrmulOIbdFrVxXXqXrxxED1WZZJKyoaegDdezXoynU5MnZgC4p9y3fxV2+ZRYpssLWB7/yY6YFbEwz0v9+TSGnu/1o47GEVwL8320Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw3dxnKtsVm+rf9hv3NqOKZpVZcCJVPkwgY0PHNZcTw=;
 b=DotMfDcROgSQo9EoiwYvKDb1Rz/ysm6PjdddOFwLZ/7atfLIVpI6N/tCy/Tj5yZWK3Y6iesjxJeov5lPrSKKp5g26BsF0H6PXskhPr+Z77XI4o6dbHngQOdmPpcnNAQ0Kws35R1To2Tbtm0WVVM4H+gBj/WQyg7G6BQv+dFGw/3p7udhTbjNi2MN/b4C3/dkCorz61Zn2naW6mixWhztzDwRDhsZfceNYPhxZ1iJZtrxU6v454NkZCJdyy8867lTNGQafVYrfVZb9SXrPTQRQGJ6Vp86MSOnRoXvmQGTcdNxZanVppSvcEEg/AGD0H3GwmhJYClQCH2Nnl0Xykh3JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:12:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 16:12:57 +0000
Date: Fri, 21 Aug 2026 13:12:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260821161256.GK244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
X-ClientProxiedBy: MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dd64c9-d40d-4120-bb74-08deff9f1044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jd+OxVSRDWsrsdYB0jstO0SGlDa+JNIhInh4hBlVm+6YD5VvRi9uYCBpFxRdFbQiMY9pyOglZG3gw3dN351ArGigWOotGUXLp8M5paFxIyZ1jpURLCev13tB+saCYIrOg/sDDeStNlIKnCFGuTZrjUVkc35PjBWhoKryailNK1AXSIeH7eOprh+fWj8kvw87+MuE9tdTOrZmqB17mNStoI9r+8Xq5Po6R9oReFoHnTkk2dU7ygKhIeFqY1ek3RuBFvSKktv9XN0cPtNghbELqXVBZtoxoHe+N1h3b6i6RSQiY6Y1jYilTYa65k0NYDk+nHX1S78X8G97pYluz/KM1QRQBkf4DeqdSQGB3WuzvgUpP8Tvu+8I5VR2rnyljXxGE4yZfxTd4oXjOVAZlg5DcGVvh5kQqNKFYwzoNvhz96Up6u6BaJTeM2EFwdOMRDTQGQ1zqDbUeqdv2EdGcYrjuLYEzX/zJN1Si26Q3dVx4fNQvmx92phXN8bZfGK602q7PMx8Rna5ICFhF/dLQhQZewv74cEE3De8c08gSia+CQ5Hu4IBo1E+q6Gk+S6wH7d7aAbI1nSkpd9JX9J6RDctKaZLm8YtnJnH6gmFd336IJJmBz0bejtYtQhLJmbDY85fhXQjhS8qgncrvger+1Tkk0mskjkFuXivLiMDqUWPXCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5fuKq5IzcyDSqgPMwJBMjjgeecpHvPqaldEKF42czzp2BqluCSntZi/TbBg?=
 =?us-ascii?Q?p74LGxR9IGyGdb7ZXcN+r3vhZC4D6ero6YsToxFRh0kagkdLyKSsahjL0bEl?=
 =?us-ascii?Q?IidMYlu9x8/RoKwgBrAQApe9RagIU1HUtcTykC8IvQSiq9ku/DSZsNIUOMay?=
 =?us-ascii?Q?DcxIkFk0p72048r/poYbcb83Mv91Noehi8gFfERgby64f2VWiggKyM3DD3ln?=
 =?us-ascii?Q?IfWo+NMuHzdPKZVubqurcfhi7HoasoNZrJTnmoltrqy5fL5W47BM09z5aQSQ?=
 =?us-ascii?Q?kstZgiNRNObR8Kjf+JISK008RRbIJ/7ARLbAjnNOrQ6XHLLVCjm6NjoXDspt?=
 =?us-ascii?Q?wp8pMKZFt7kf1bFLF1tsI3Xf3XK+ky1Lcz589ihKXM9TPC8p+qRsdyUZXW4I?=
 =?us-ascii?Q?l8S11N63LtWF8GPLVctPOWpI9Kk9bXROd5w92eF3O9yUKzxZIg/C1xtVyQXs?=
 =?us-ascii?Q?gCOF1TLskVyU2vguM7plI32Kq//gy08+mopWSvRQxALxFxY64eYKN5f3HxSB?=
 =?us-ascii?Q?N90sirjCB+rVF+evL38gOb6O14BIUo0/PTOWX8J0nxXiaAUeX3lWwDse3hzb?=
 =?us-ascii?Q?BJJpU1tvddF8IEB29fYoZ+1kNQABx2jNK13/asFB0Td3jytbZpESWUeDipaD?=
 =?us-ascii?Q?Ju68Nxy+/hgqoB+cgaE5hNTyMbkPH+Buc+0ctG5yGosPmbkeRi6TatKu/ciP?=
 =?us-ascii?Q?tMCp64lJMBhxOUVAVU7e8aI4HHAQFOSU80vTBjvaSf9GA9jmJ/vQuqukuDoT?=
 =?us-ascii?Q?KciC33rsUSVO54a6zYbsoFf+vWoazpBEd1WQuwzE2BcbQ+8oeZwThFd67HxQ?=
 =?us-ascii?Q?q5icvi7vN0IMSLWxNkf9sn45zxS0nsd9rvLA4Bp5t017cgf8bE3b0DAbHK24?=
 =?us-ascii?Q?uTCNHZRN99aoGqRn11cxgtHlcBLzr0Ya3VP+bLoz6jugIpfbIxZJbtUpGM7T?=
 =?us-ascii?Q?872chVQRQvHoKb7RcF0ZC/P8/99BI/Vy/Hfs2+RRHFd3rSLyvHPWjhZzX0i4?=
 =?us-ascii?Q?PsmhD7FVVywqxRIkx4yT5ODRySL23ZQ1n2AQHzMktEGj+IgPuFKjA40l6t+q?=
 =?us-ascii?Q?EQHi06AnftL9yhja2q93rJFdysutCwlaGWpN5uo8/2MogUJWTnXqG5cZluZT?=
 =?us-ascii?Q?xSFk/gA8D/pHK6vz9e8KltiuDBFehp/jMzeYzHqLvwjfgmz5eQCWOrP/2LWp?=
 =?us-ascii?Q?sCboyT0wIRGLbX5HL10IgXblUL8l7+CNdXhsgp17IeggaQzizmfz6Q4CeELW?=
 =?us-ascii?Q?JoKtza4cqfGfTgID+gXMeIHKW/URBgfosS2HkDs45/GV9ek4JB5veIWkg5Mc?=
 =?us-ascii?Q?F9Oe8DsJHjCwA6yJbezMbGryzz8p38waTlbFTizdEywtwxgc0qsY7LOuxyMs?=
 =?us-ascii?Q?jPuGkQBlv4fchoOVrG9gngDqeAcYB+ne34U6j/7Dk5kgt+msv+BZ3g/3nm8D?=
 =?us-ascii?Q?2+bEpg6SbQ4AFzK/szPd5/TrH3ati1kJEKm/Wm9/UFb+LtaVW4f2DVW/A0PT?=
 =?us-ascii?Q?n6AVsC1p+7o0BXhK3xSpcknmujmp2pJT4+sIb3NFtuhSnAT/Q2aOtUkh1p2B?=
 =?us-ascii?Q?+owZODtXphhXawcSeTlMu6C9aSgjBr9NA1cDdM+dPfEk2G9aw79XhjFxbckF?=
 =?us-ascii?Q?xtTnNpvFWz1xcLqcxUzwrM7xLzjU3zKxdB9kNEy1PhOnN1L54tbY9yykdgvX?=
 =?us-ascii?Q?O0KJ+BTB+y/lUx7K9klV50mH8tk6DoBmVSH5EOWTaN9thz9o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd64c9-d40d-4120-bb74-08deff9f1044
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:57.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u144w3WIN1inFQ+qc1ZN4RlmJ0S1KMklQS+F8TljPRXtXpyw0hfti76K2uhiWamv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789

On Fri, Aug 21, 2026 at 05:18:49PM +0200, Andrew Jones wrote:
> On Fri, Aug 21, 2026 at 11:31:55AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 21, 2026 at 04:23:22PM +0200, Andrew Jones wrote:
> > > > But RISC-V IOMMU is also not involved in interrupt translation. Beyond
> > > > it could remap the PAs which represent the CPUs, but you are not using
> > > > it that way since it is statically setup.
> > > > 
> > > > So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
> > > > where the IMSIC itself just has a wack of PAs it needs to access so it
> > > > calls iommu_dma_prepare_msi() to do it?
> > > 
> > > Right, this series is only remapping IMSIC PAs, not using the IOMMU MSI
> > > table. The MSI table must be disabled when second-stage translation is
> > > Bare, so it cannot be used for the host mappings here. It will be needed
> > > for guest interrupt files (the irqbypass series I'm also working on),
> > > where this IR irqdomain can then intercept irq_set_vcpu_affinity().
> > > Also, keeping the MSI setup in this IR irqdomain avoids putting IOMMU
> > > mapping knowledge in the IMSIC driver.
> > 
> > It's ok for the IMSIC driver to call iommu_dma_prepare_msi(), that's
> > the architecutre of this at least.
> > 
> > Until you get to adding something more complicated, eg irqbypass, I'd
> > suggest keeping this series simple.
> > 
> > I guess I would wonder why the IOMMU needs to be involved in changing
> > the mapping down the road, why not just reprogram the MSI-X address?
> >
> 
> For guest interrupts the MSI-X address is a guest IMSIC address.
> Reprogramming it handles a guest reroute, but not vcpu migration (the
> guest address stays the same while its host backing moves between
> guest interrupt files and MRIFs). 

Linux isn't prepared to have a guest controlled MSI-X addr,
AFAIK. I've wanted this for a long time but we are not there..

Does riscv absolutely require this? I suppose you have a new problem
where you don't know what affinity the guest is selecting when it
provides a MSI-X addr as you don't know what physical IMSIC page is
under its S1 IOVA?

> The IOMMU driver updates that mapping through "the hypervisor to
> IOMMU driver interface", a.k.a. the IRQ domain's
> irq_set_vcpu_affinity() callback. That mapping cannot be prepared
> ahead of time because only the hypervisor knows the target, and it
> may change later.

Nicolin has a series that worked toward making ARM work properly, it
is not at all like this and it isn't done with remapping domains.

You want to preserve the guests physical MSI-X info directly and plub
through the proper mapping so that the S1 -> S2 translation setup by
the guest actually works right.

If you don't do that then you can just have Linux adjust the MSI-X
addr like intel does and use the RMR trick from ARM to get the IMSIC
pages into the S1 IOVA. Still no need for a remapping domain.

It's so complex, so I think you will have an easier time doing tiny
small steps at a time..

Jason
