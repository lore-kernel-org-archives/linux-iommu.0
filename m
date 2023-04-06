Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D7E4DB
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 23:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLSaZYDEWnkf8jKsPk30/UOXAKKEKd8S0a+uSM+HHGFXx8PmgSg7EtV05qdLmqPJ2axdnJj1Ucs1gjJBM/QjaYEHaUsuBeaRhVMJ3pABYNdGyFVJDSlqLgQoCscMxMSHKkqLKed9CK4NjWzVfhrsOmuGM5YCAZjOlLq+FohOn/kCanwKbhSJV9DDXAzANW0caBwmBdHre4DlcbIqGlLVKCqV60VzubMx2RXVPrkzYtEnPxmiK0yexgOL/WccvsKxILSA+XH2bs7iK/PzQZHbyd8Hwhc1TdpuWs/oHMaYMt4MvohG+OHXv7wFpGZNMH0s603XefA1j9B/mdoI2nF22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJjvMpPYO/8yOkQR19IiMxBDYcTJjbLbZGw/tI5RKG4=;
 b=X70Z+r5fnaDZKRsVjOb4kvLYU9uWgjdlHQYZI351e4Reg8QWFnc+aMcCc/JeHNVv6AmU5/5GIdkmTO2W/N7Gup9nKM4JqXdRH1ZswdupB5zwBjl3YAT8vrXlkwRqE7Rs3LYllfS7lU9x+luUaSao2okEO1qddTWTlSgf6pHvm6i0PvlvE33vbomCgDoiFas+U9WxLBaB4mas1wMFtH+gvnLCLPeNwFQnbeJxW8bS2GohalV2mOEyXdW/fdwX4Y/jWRiv22fvy0UCoTUs8Dzlf7fgjdtwxIJ2IGIOZ+tTVW8WtXphiWRWn/snhqt85M46lmhsNTxHQ4TMZsS2DFdqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJjvMpPYO/8yOkQR19IiMxBDYcTJjbLbZGw/tI5RKG4=;
 b=cwS9IoORhWEAr0xfFAifb52GE9lklbyK2bya33kZ7pae50f+nUZMOwnjnfRM5/FB1PaMawXrfE4OEHKvjlwdUWi9Um9F7JNrIC4UjWFphVyfE2BlzFTsJV0bCohQdMm/CZlbBTtHxrgzcSO7XEPIql4mlUxA1i5huYgMDmDaHtJ7FiifQrpDoJHv69Iht/5qUza4apSlOUO7gm+FJ3p1g86KfTbiWR4l1Y9BubU661MAYQFti4/+/rkjO8Xy313noUzc+WsjibIw12/DUX7pMBBZEx0tqmLQv+jc4BLTuhUMkqJ09/ZExLzWD7WCowcW+4eGjCb6JQAd1syQ48LC8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 23:37:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 23:37:52 +0000
Date: Thu, 6 Apr 2023 20:37:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	lim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/exynos: add missing set_platform_dma_ops callback
Message-ID: <ZC9Xzvakhepn0liX@nvidia.com>
References: <CGME20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9@eucas1p1.samsung.com>
 <20230123093102.12392-1-m.szyprowski@samsung.com>
 <Y871a3elCP1gmPQi@ziepe.ca>
 <e7aa3a5d-c8f9-ad7d-4c5c-08756c1ab2d3@samsung.com>
 <Y+90rkPHe/+eSLs6@ziepe.ca>
 <9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com>
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 12598444-6963-40b5-4689-08db36f7f072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WqlYVpYrtUaXwRqkKC4igxlWNmeFKeqa2q5VWEmW3/sxyWLzcPi0Oz/KpHymudbH3CmnbRrNEKbEHpviHCpKbNzF9q7ueuU7Kis2m2CIfPhzTIiW1f7KiG4Sz8+u9aHUkIGYUl/XNEjwoFXC9mrMVNNVSgXXPiNa3ioydyKhs97K9BYx9P+QkUe2atw1pHzgDlccFLOCOxpDZ1bL1iHno9FEi9fdCBEdtgAAiawLdQQcTFAJNmkrXgl5YVelN+PK00NBf/UqXI+Io2zTlUIskgon+YMm3AlOVFfWynii9sl/yvYKPqnN1FAkiQ/tyUk2WprObnwHEEkVebpvXpOeNggNP1rbtgcVcPhBbiRL0b5cXYFzv+G95KxzvsL+aN/h1i3J+nG6UevAlWoFvpzR63Qp1QpF4y+8VUqsXrPwdz5uA+qcs/ZXEODVNHKu2mE1PaXp0BlFwaqzBRtBE60w56Pmif2qbFFW4gYmT/AMU4n0zqKQ84mKZJMWsLyO5GqtMLZDiuoVAX4FCYnV+B7apsLlCZxV09OpF/wZb/6iVjjYiz3OwszbP9U3Ixm+3xL7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(2906002)(186003)(26005)(8936002)(6512007)(5660300002)(53546011)(6506007)(2616005)(8676002)(54906003)(83380400001)(66946007)(66476007)(66556008)(41300700001)(478600001)(6486002)(110136005)(7416002)(4326008)(36756003)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fc4ALQtdlHNvWXrK8pyNBaawAHrl0wTaZRTARmzvqtnVDmEe3G4tpr7h6c8F?=
 =?us-ascii?Q?Ixu7rrgHm8lAsVpDKR2BYPQ03Bc+PV9nNQBHrl5OKGylfBGtIPgEBNgZ3Xxy?=
 =?us-ascii?Q?J3I2gvvRBYWzpEmbmwV/lJPqTETVMlEpIavKHo6n7BJZ2pvDl6YVG5hD0dK2?=
 =?us-ascii?Q?63I/75lazipmTq97pIpi7029emno8ZJ6PYVa/3Aioqquw3mPzaqOb3N8x+LD?=
 =?us-ascii?Q?52x5UcDlVe8XkpcGhdqWSmS4O2fU2SUOgFHW1mApajpuVbSFmET81WDgCnU9?=
 =?us-ascii?Q?Bm9xclukkXrNBBaCQSYeMuXm6bbduIOSXGEEtsOSd1XsjtMPFzOwKIzI3IWy?=
 =?us-ascii?Q?2P9mBMslvn1Ss4Epx9YzeQRZ+G6GZejIneei4kL/Gyue4ZbFPwKst/oADNNt?=
 =?us-ascii?Q?Lq/lr/Cnprsw1voY06cdLix6Pl8owOk452N7rQTghKcUMlOSBREzSUGl+hC/?=
 =?us-ascii?Q?H+Zcv0lypDvaYxbcrQNiuOyCq0Jsqvz2zFhLFk0CeDD3f+FKsiIKCYvdueKr?=
 =?us-ascii?Q?4D7TRGa96usLhZ3uBDbkmcnZUwszZZEfBm4GdR8Hn3UdLO/+biROsWy/dvVN?=
 =?us-ascii?Q?Q0QOh5xvOflRUn6zfMs/t8kN8si+gEZZGtCQ79dT6DQQg791uFd/DJzFOcrf?=
 =?us-ascii?Q?uLm9LbtPrVqwQHN8tWua2uQX4Qv3aOHYfGJw1PNrTQKn3bCaca1rvTk1hBBS?=
 =?us-ascii?Q?f/vaoV0yhP60FtFJNclraCBPUJfycPIoxcp2pfdDRo9HtJPj2RNDizcFqIIT?=
 =?us-ascii?Q?BJupgSvt3KQTx+cGKO8fik6fFqBb79uK6CBXUT99BDa6yhdTxQl7TMCyhUuH?=
 =?us-ascii?Q?73CpOUW5qWc9uHfS58ZSlBeeUJ0+e42vE7qSx5UDq5YvpiCrkhOlkGLcSlmR?=
 =?us-ascii?Q?DOgn4JXjYUTmzP0R9NLegd5pvXyTHP8idxZNATD2fB8Dwk7w+ANEqbPU37tt?=
 =?us-ascii?Q?8mKJNpjlV8zuDDaciZBkuU6NAdb7c9gR7ujbYtwicx/Zhr5aTsvvflltGAvE?=
 =?us-ascii?Q?PlS2AsMSxQKLSHlz6GlXCxzt/0dYiskfqP7g/3cVsjv/bPOrHU25NVVjYIDb?=
 =?us-ascii?Q?sMQVamAlcg4NcgxGeUMog8/6qqyy6Q7vFR7h9reX2t6450YFF0sqMxtb/FKJ?=
 =?us-ascii?Q?tDzy9iqlHfsPRUJog5YHwiigW5aXG6fjShQRNRQYTHvgkkP0EyfPiDvBTWEY?=
 =?us-ascii?Q?cNDKRT5LUTU5jOgezqw/Gl82ZF8bvAQpxM5zUSdQ06z7iDn7iyUAxjqAkDv0?=
 =?us-ascii?Q?pmfuO3DbNgpZCbY57C8OksOn4OVWEqNZbtLvQi2wmORdnrbsdz+z9lUaf2xL?=
 =?us-ascii?Q?GL3OwalojhLr1va6mf3nhhKgQ3G5uAV2Ri8Uo5KUfGNTiufG5qDhyMVVTF3G?=
 =?us-ascii?Q?CNmhhu+lzB8KofuHyazuOoxwEcZmOEC7QN5MpORz6lYVPRwLJnj8S0KIwrLG?=
 =?us-ascii?Q?bjtbSz2PnqCH1sJ4GzwWMmYzFYD48qvGFCeS/fiTAkiWwlJSwFz/HI3Ux+Gq?=
 =?us-ascii?Q?6SUqjP9jBR5Seh0OFcye0Qo1Z/wv2GCQNvF6119R72EVZr5O1BWiOif4Cz0b?=
 =?us-ascii?Q?Vb7zECfHLOcjWXl3Js1Yp3P0qCBzhd5XRm1Od/f2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12598444-6963-40b5-4689-08db36f7f072
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 23:37:52.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+XAuGYverp5u1ES2qdqKwIO936FuNwJk75R6hHJzMo98Vbu86dpjW7A8mbWTcnC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On Mon, Feb 20, 2023 at 01:58:40PM +0000, Robin Murphy wrote:
> On 2023-02-17 12:35, Jason Gunthorpe wrote:
> > On Fri, Feb 17, 2023 at 12:08:42PM +0100, Marek Szyprowski wrote:
> > > Hi,
> > > 
> > > I'm sorry for a delay in replying, but I was busy with other stuff.
> > > 
> > > On 23.01.2023 22:00, Jason Gunthorpe wrote:
> > > > On Mon, Jan 23, 2023 at 10:31:01AM +0100, Marek Szyprowski wrote:
> > > > > Add set_platform_dma_ops() required for proper driver operation on ARM
> > > > > 32bit arch after recent changes in the IOMMU framework (detach ops
> > > > > removal).
> > > > Thanks for looking into this!
> > > > 
> > > > Can you explain more about how this actually solves the problem in the
> > > > commit message? I don't get it.
> > > 
> > > Exynos DRM driver calls arm_iommu_detach_device(), then
> > > arm_iommu_attach_device() with a difrent 'mapping', see
> > > drivers/gpu/drm/exynos/exynos_drm_dma.c Lack of set_platform_dma_ops
> > > leads to a warning in iommu_group_do_set_platform_dma(). The other case
> > > of calling arm_iommu_detach_device() is after unsuccessful probe of the
> > > platform device.
> > 
> > Why can't this just use the normal iommu path in all cases?
> > 
> > It looks like it is trying to copy the DMA API domain from a parent
> > device to a sub device.
> > 
> > Even when using arm_iommu an iommu_domain is still present, so the
> > copy code should work?
> 
> The ARM DMA domain is a regular unmanaged domain owned by the ARM DMA code -
> in order to use any *other* domain, a user has to detach from that first
> (wrapped up in arm_iommu_detach_device() which also swizzles the DMA ops at
> the same time). Without set_platform_dma, that detach is now impossible
> (because no IOMMU API default domain exists either).

I was looking at this again, and for completeness, the reason it
doesn't have a default_domain is a bit subtle.

The driver does support IOMMU_DOMAIN_DMA, and it will go through all
the iommu_group_alloc_default_domain() stuff with that..

But... __iommu_domain_alloc() calls iommu_get_dma_cookie() which will
be wired to fail on ARM32, so the core code nixes the IOMMU_DOMAIN_DMA
after the driver successfully created it.

I wonder if that is actually what we want? As it seems like it would
be OK for ARM32 to have, effectively, a permanently empty unmanaged
domain as the default_domain?

If instead of failing due to iommu_get_dma_cookie() we set the type to
UNMANAGED and make that the default domain it could fix all of this,
even for all the other ARM32 drivers that haven't reported this yet?

Alternatively since we taught these drivers to support IDENTITY, we
should be able to remove the set_platform_dma_ops and instead
implement for ARM32 def_domain_type fixed to return IDENTITY?

Jason
