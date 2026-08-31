Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AA3AA1A8
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212968; cv=fail; b=jhxH8SnCqOV1cnDWagFXsqnlMdBh14LIgjCOsdqfgvI/gJD2mdhOHX69VF4qojyMdKsAcByCv3YGhOlsM4eTdALIA54Y/wnj+fh4UOsXzxn8ffhMgJo7zXbIVNaMZChmKAoJhdNCxE1aG0GLJel9jXSRBF95o6reLxY64JckPOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212968; c=relaxed/simple;
	bh=d8RFVPjMcowDUZ8egI2gOhHfwzI6OkTlfd9PZw5HAlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFFmDWFPCpqSFGOiQq0XAEql8KQGmRj1mXQpwL3YtnVFK4OQadvRBKjN+Yx0Xeq2Q0rAL4dee2rghFB7gXKTiAm2NAXYS/SIhgcj8KxKdIs09wRa2vDTT73rysimRj+2mXs2Ys0nLOmQgSh1AhW8We4NDb5HMtFB5b0AQsj1AQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ji0tkAxp; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ji0tkAxp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DURAZInfqLW8DKfle1a+J+ovT5Oo6iNbYqlMKHskwCZhSVTGK1wDczTOuMxqao6VFis/Mmu9fU77YTDOiuOuhZVR9EivBBbRUD8r1igqImhhJTCXDotxu7OAbCI5fmyBG67OuZJ+HJMsjHoxyJn9edcbONLyNhFC6qeRHX02B/5dwMlzvzcOe6/A+IOudzys1DyZm2ybHWZxvClOXtWMU7P5Oa6IsuzMY9HRPfw3kCGlD02xVVugjdAKdDzT0cmI9N/5agM/pm/xkvQNHQN5hoUPa/5UAHwpqud5GanaRuVoGhv4QzE8ry5+s3c8IK53O1XKvO6Wx5KFFwL0uouJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXfcQRqWeY8nyg4g+YwBQpARP4a5TtVs4UAmw3sVy04=;
 b=NF/4kA9sXyVkdWNcR/JQUw13azDg0QLv5un+YDjq7et/4zxtCVtQqeSw38VwJg4QxhDavY5v0YnsmvLmNkojMI9fD+29F9lxJnzS7NiZgncpvKoDFiGwulilDGxTnR8YoEcEI6ePLjkUBwEk3BfyxnsWFtBf5mVQyIJlo4916Ndyf0ueVXkIRIK0eOhub768i3bGGkziwrqzNu+NAOQLROq800fLk+TUTWdvA2mP2xAnqIVA6LEvMSJi0qEGN3ILkQ6c+/8bMVEtjAfs/SOy6Rdk2ob3Q9pd0r2mZBJ8JPSicnM9UEzOefLU6gwqZ3FudnrzYMuADXoQx+49ju7ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXfcQRqWeY8nyg4g+YwBQpARP4a5TtVs4UAmw3sVy04=;
 b=Ji0tkAxpaBev1dv53dfW7fsdCjM2kSRa0mP83EmaCTyZI0UOyGvWUpP32lmSjYVveVmz6NbTGCLEUFw9UNZWjYtmR0mZoDzhZLZFeig6aIOIcq6qX/MjWBXH+eF5+zfamysMwZJqPfYrs3urqjeMp81dlmxq08zrs3yNilA11YM=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:49:19 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:49:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Joerg Roedel
	<joro@8bytes.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)"
	<iommu@lists.linux.dev>, Jatin Kataria <jkataria@netflix.com>, Boqun Feng
	<boqunf@netflix.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable PerfOpt IOMMU perf optimization
 when GPU in identity domain
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable PerfOpt IOMMU perf optimization
 when GPU in identity domain
Thread-Index: AQHdOQzG5ayngCAlkEeBN38K5oHz8ba4sZZw
Date: Mon, 31 Aug 2026 21:49:18 +0000
Message-ID:
 <BN9PR12MB5146AEF96DBF667749B61205F7A92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260831055108.1893285-1-mario.limonciello@amd.com>
 <20260831055108.1893285-3-mario.limonciello@amd.com>
In-Reply-To: <20260831055108.1893285-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-31T21:44:10.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN2PR12MB4288:EE_
x-ms-office365-filtering-correlation-id: 0702c630-d3f5-4b31-3d89-08df07a9b58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006|3023799007;
x-microsoft-antispam-message-info:
 UTnudyyiX/By2TDKGHqHme6qCuRs9G0vsNADsNU8jLJG69blhN22V2R1JDuWo5ssTp50J5NTN1dLoB+Cr+D1TEEso9gXyMcOIrQ08PBthyFYG2eRYLsJA0LaHn3gdXcmCJfwiuWcITBslVT5CPaB3SiPch7I3lVnGqUtxLImfFREGe/2p7NtYxOwwPoK4gnaBMDQVmBSgGTh4Xf2ut6BJ24+k+E4BoZ1wSCbgYkAHA7C34A37xHYtWzy2KBfCqSorQmdKeGfNQXQkLyFi8BFEE4pzkJo8HrHn04ivDTVPxfOBZwBAaTnFxtG/veHQhBZ2VAWyGL22DoK6P9BKLgqH+IKH8t2416VB9xqxf5bcdHUqZZmcaZsL6p45HjZhKuoiQpbkW8/6VdUIejDfHuTTW2bTDbyPM4ZJAj/oumx4Zg7JwVyAtp5oFZbEhnolJhk92AXybHx/5lGD6lvh8xqzmgKzClFjYDkqu66uuf6zXZWXcIMhVImjXaVdShrLXnWIV984KfGS7X7Xyl3VqLpdVJXJIDBPKbLzV0sjqHYvDMBvtBkYv1J6uuN9MfGu77duSMc8FDii+YS4yRFkbIRh1dC999NJ91HwFhUsc8u7nGI5iU6LrRSCL7zaQFTMEG8EDVWXw2nCgXHWlxq9OIEK1IM6pouLfdosO0cMpl8NuJt/Ar5fzemuHFmyzbsY6SnbgZlWTc5uUJCvQBSf5x8LPvVaCqPpK22eHq3pdZNPY0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ERHo6AM4hEkjTxdzBjvsswSIOd9qxxrs2pPwmv8jHkEQ9p5PnqcItk06ISr?=
 =?us-ascii?Q?gLDRO3Hw6sXIPXLrQ8VFgTNv8l7evtmALUeW7aM8RClZuVnsQ7caUf+1Ffdg?=
 =?us-ascii?Q?2suA7Fva/EKiem/UXw9HgMTZTCxqojK6rkGvvkYRVhJGXpoLnWhlvG33Fzy2?=
 =?us-ascii?Q?8Cy7yhCDvww/2x66sIIKXfoaFGZD1WCnet9+x+p2LuUud8j6iSkRXI4PBCa0?=
 =?us-ascii?Q?MtTwKc3dP67Wq6amyirfP7UG9UnNaYUCFITselEffSc5Ydm3NsW7eyPqsxWu?=
 =?us-ascii?Q?07VLT9tGOin1btBQgZVrnohOQgGeYuWoov0cfvbICm6Red2kOf6LIEVg4Rns?=
 =?us-ascii?Q?Hk+RYDAdQLTQp/RX+FVXY1lfzdyfcBwJnzpF+q48EjZ/dyn9bulfTLy071OY?=
 =?us-ascii?Q?ClUIfVoUhCOPf+xDXqAoe+MT806DVT1KSVNo7Dwfm/kqd/P2q1pEYTN+DK/h?=
 =?us-ascii?Q?tN6Hh/CwKdX6G7PGYU9/4OXkhTExNq6GszVOJJoF786p7XL8E8lUvY85QwjI?=
 =?us-ascii?Q?Mm78Q6emscNsOjSQrdoSMMrg3HzUaexVugJ8j0vXJpQh0Ptyi+/9cb2ARJLK?=
 =?us-ascii?Q?qYJsduT+8X4gAnW0RJ52FM+fcOjigKx9+YDBu1xljCGLFBOketW+odWvzbQu?=
 =?us-ascii?Q?eMNe/HO6h8cfynNhVkW2eJzc57ZTKHvqa+xm8cd+kSOCzMYRj+uUNfprwLTd?=
 =?us-ascii?Q?P0+1BvTue2mosM9GWakbt25fYN1PLS2hpycNE3IRhthIQJDk2rHnbFbszsxj?=
 =?us-ascii?Q?H02xi+6zySMe+8i3DMe8jCnpkfD3QFsR2YuawKAyoo2A6jJQNOhu5SWa9OQ+?=
 =?us-ascii?Q?SXpailDGhLoIOWz+VQFaD+sm5MJiPH2qZmjzX7lUkBz8S4ONJooRaqZufj4t?=
 =?us-ascii?Q?blyt/bGQ0y208b1P7VEZidbJ8iMuu/KTr/HICVeOrXlk+Pym/PNbQOlhQM7J?=
 =?us-ascii?Q?Y882omkXe1fmohGoXV246p+/7aV9+cOwjUVR1Y6+PbHiKvT7zFsS4oBcLMGA?=
 =?us-ascii?Q?XlSyygGwwyvM4jUnhYb9n8tQC6ZWSOYbM6n2Lkx0T0taWQ8Kpyw5szt1vox7?=
 =?us-ascii?Q?xaF6M39dUNhZ3Uc+p+e+6KvDNhHD9fuPx0AfBMOPTZLmy5HzeYEIvofHOUwf?=
 =?us-ascii?Q?k6u7xYub2U2Qfqs0S42BeaZsbjVBYJ/u0x1L6oHBBrGqXzvhCbe5VBmVmBsR?=
 =?us-ascii?Q?zLSA2tM+fcf1AIUW8iVBletAMTUQ0NsTc2X/9RHP2fMlbovyVc1FWCZHr8Hj?=
 =?us-ascii?Q?DMnqJS4cvr96OqpnMNJO8KVjfRVFidZte96tYPlYXTysSpbkWz/4smXNcNXQ?=
 =?us-ascii?Q?GBUV46foH4gU3UCOgG2wnnY1bThLuIAyIpWFWEXEUGOHf6hm3RyX5WmxklG7?=
 =?us-ascii?Q?RWDCLCcIL+73CfCODP3UcfRtBnlsR7QmiciyKVM5RyMPllDYlffP+gUjqofn?=
 =?us-ascii?Q?KP61wJUdJLYpXfJz1wKixGM0ePCNrDQ+z0yCwhGxOlc9I8rvgoLJWlksV8Da?=
 =?us-ascii?Q?QBdwXwijjE+WohPucHBmpzR6Fcx8OeBBc7KUZYnKf6Bt+NepYGZ7tkwra78N?=
 =?us-ascii?Q?qhsahqm3VVZEqv4V5BhysI+hh/qSVvo/9eWrWO1XYYNMhOzzZpJ6dwJGUn9v?=
 =?us-ascii?Q?oup5a46x5BYIBJJn71pvhgv8VeKsY4/uwUAbWduMQXr4E2a4PUKgRqFfppET?=
 =?us-ascii?Q?a8rxDnxagAEVUd8hR/jdeoQquGJC1gOnqZ6IjbPgKx81xMk6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0702c630-d3f5-4b31-3d89-08df07a9b58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 21:49:18.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8Ax7es0oEOY1s53K8xLJqU58ymDcM0TV6alLszATa0WqlSUgWQI3aBDanQ2+Qa7kASu3bUU9JmfVdwWuoKgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

Public

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, August 31, 2026 1:51 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Joerg Roedel
> <joro@8bytes.org>
> Cc: amd-gfx@lists.freedesktop.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Hegde, Vasant
> <Vasant.Hegde@amd.com>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; open list:AMD IOMMU (AMD-VI)
> <iommu@lists.linux.dev>; Jatin Kataria <jkataria@netflix.com>; Boqun Feng
> <boqunf@netflix.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable PerfOpt IOMMU perf optimization
> when GPU in identity domain
>
> Enable PerfOpt via amd_iommu_enable_perfopt() when the GPU's
> iommu_perfopt module parameter is enabled (default 1) and the GPU resides
> in the identity domain. The identity domain means the GPU is already
> performing direct DMA with the IOMMU only enforcing IR/IW permission bits
> -- no GPA->SPA translations.
>
> amd_iommu_enable_perfopt() clears ATS, PRI, PASID and SVA for the device.
> This is safe in identity domain because DTE[I]=3D0 means the IOMMU alread=
y
> returns target abort for ATS requests from this peripheral and the GPU
> manages its own TLB.
>
> PerfOpt is a soft, optional latency optimization: failing to arm it (for =
example on
> an IOMMU that does not implement the feature, which returns
> -ENODEV) must not be fatal, so probe and resume warn and continue rather
> than aborting.
>
> PERF_OPT_EN is a per-IOMMU control shared by all devices behind that
> IOMMU; the IOMMU driver reference counts it so that on systems where
> multiple devices share one IOMMU, one GPU's teardown does not clear the b=
it
> while a peer still requires it.
>
> Arming PerfOpt trades IOMMU DMA containment for lower DMA latency. This
> is enabled by default for GPUs in the identity domain as a deliberate,
> documented policy and can be disabled with iommu_perfopt=3D0.
>
> The AMD IOMMU spec indicates this is only supported on integrated GPUs so
> check explicitly for AMD_IS_APU (which is set by
> amdgpu_device_ip_early_init()).
>
> PerfOpt is disabled during GPU init teardown and restored on resume.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 +++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7974f9b7944f3..930a78db7132e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -156,6 +156,7 @@ struct amdgpu_watchdog_timer {
>   * Modules parameters.
>   */
>  extern int amdgpu_modeset;
> +extern int amdgpu_iommu_perfopt;
>  extern unsigned int amdgpu_vram_limit;
>  extern int amdgpu_vis_vram_limit;
>  extern int amdgpu_gart_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 44bed0ba64a37..75c74c72a52ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -33,6 +33,7 @@
>  #include <linux/console.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include <linux/amd-iommu.h>
>  #include <linux/pci.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/apple-gmux.h>
> @@ -3752,6 +3753,17 @@
> amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev,
> bool px)
>                      apple_gmux_detect(NULL, NULL)));  }
>
> +static inline bool amdgpu_device_identity(struct amdgpu_device *adev) {
> +     struct pci_dev *pdev =3D adev->pdev;
> +     struct iommu_domain *domain =3D
> iommu_get_domain_for_dev(&pdev->dev);
> +
> +     if (!domain)
> +             return false;
> +
> +     return domain->type =3D=3D IOMMU_DOMAIN_IDENTITY; }
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3958,6 +3970,18 @@ int amdgpu_device_init(struct amdgpu_device
> *adev,
>       if (r)
>               return r;
>
> +     if (amdgpu_iommu_perfopt !=3D 0 &&
> +         amdgpu_device_identity(adev) &&
> +         adev->flags & AMD_IS_APU) {
> +             int perfopt_ret =3D amd_iommu_enable_perfopt(pdev);
> +
> +             /* Optional optimization; a failure to arm it must not abor=
t
> probe. */
> +             if (perfopt_ret)
> +                     dev_warn(adev->dev,
> +                              "Failed to enable IOMMU PerfOpt (%d);
> continuing without it\n",
> +                              perfopt_ret);
> +     }
> +
>       /*
>        * No need to remove conflicting FBs for non-display class devices.
>        * This prevents the sysfb from being freed accidently.
> @@ -4327,6 +4351,9 @@ void amdgpu_device_fini_hw(struct
> amdgpu_device *adev)
>
>       amdgpu_gart_dummy_page_fini(adev);
>
> +     if (amdgpu_iommu_perfopt !=3D 0)
> +             amd_iommu_disable_perfopt(adev->pdev);
> +
>       if (pci_dev_is_disconnected(adev->pdev))
>               amdgpu_device_unmap_mmio(adev);
>
> @@ -4692,6 +4719,20 @@ int amdgpu_device_resume(struct drm_device
> *dev, bool notify_clients)
>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>               return 0;
>
> +     if (amdgpu_iommu_perfopt !=3D 0 && amdgpu_device_identity(adev)) {
> +             int perfopt_ret =3D amd_iommu_enable_perfopt(adev->pdev);
> +
> +             /*
> +              * Must not return on failure: a bare return would leak the
> +              * SR-IOV VF exclusive-mode acquisition taken above (releas=
ed
> +              * via the exit: path).
> +              */
> +             if (perfopt_ret)
> +                     dev_warn(adev->dev,
> +                              "Failed to enable IOMMU PerfOpt (%d);
> continuing without it\n",
> +                              perfopt_ret);
> +     }
> +
>       if (adev->in_s0ix)
>               amdgpu_dpm_gfx_state_change(adev,
> sGpuChangeState_D0Entry);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5b08afde37baf..26ba7852e1ceb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -185,6 +185,7 @@ char *amdgpu_disable_cu;  char
> *amdgpu_virtual_display;  int amdgpu_enforce_isolation =3D -1;  int
> amdgpu_modeset =3D -1;
> +int amdgpu_iommu_perfopt =3D 1;
>
>  /* Specifies the default granularity for SVM, used in buffer
>   * migration and restoration of backing memory when handling @@ -392,6
> +393,17 @@ module_param_named(fw_load_type, amdgpu_fw_load_type,
> int, 0444);  MODULE_PARM_DESC(aspm, "ASPM support (1 =3D enable, 0 =3D
> disable, -1 =3D auto)");  module_param_named(aspm, amdgpu_aspm, int,
> 0444);
>
> +/**
> + * DOC: iommu_perfopt (int)
> + * Control the AMD IOMMU PerfOpt DMA-latency optimization
> + * (0 =3D disable; 1 =3D enable on APU devices in identity domain).
> + * This arms the IOMMU PerfOpt control (IOMMU spec, MMIO Offset
> 016Ch,
> +EFR PerfOptSup / PerfOptEn)
> + * Arming it disables ATS, PRI, PASID and SVA for the GPU and removes
> +IOMMU DMA containment for it,
> + * trading isolation for lower DMA latency.
> + */
> +MODULE_PARM_DESC(iommu_perfopt, "Control IOMMU PerfOpt DMA-
> latency
> +optimization (1 =3D enable on APU devices in identity domain, 0 =3D
> +disable)"); module_param_named(iommu_perfopt,
> amdgpu_iommu_perfopt,
> +int, 0444);

For consistency with the other driver parameters, I would make the default =
-1 (auto) and have auto enable for APU devices.  That way we can add 1 as a=
n option later if we want to add a way to force it on in certain scenarios.

Akex

> +
>  /**
>   * DOC: runpm (int)
>   * Override for runtime power management control for dGPUs. The amdgpu
> driver can dynamically power down
> --
> 2.43.0

