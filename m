Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DA2F5316
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129467; cv=fail; b=nH74sSvVp9okTHquXPTe5ecS4FNgAYTUTEmRraCRr2TNzQMVOoA0Php5buSPNMiJjxZfwvhTXu2ZqtKiQaK0ZXidYthcfc+RKX3aHN0XfiOcoU9KJzsxTD7yRARs8sgWAnn2AhNsTV4aVmNp2gQmhFm7+rI0d3tD+UbJAArg7pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129467; c=relaxed/simple;
	bh=8arxFgosOPJIad92eVBLCH/VEuEn1Rr4C6MJ3sTnEC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZSWq2cL825YOtLSuwezlvebkujxXn/bvE8l5dckObN+59KgpngdYQu4n/22KeBMrOMtWcQLgkXW0FT7UrLvurW2XnXVet2rNLWHak/mGRHIY/VOU6wKsQ6Wyay1Z4NephcjFuZUDJQn2KwK0ZsQplSbMK5lKtFDhe7E+lamA0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r9/Y0nYj; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r9/Y0nYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9FIdmzH2t4tX6l1bokwQ1pRlKsu23RfTkNHa44gev9XPa4aLl4Jwbcw10M9WM+gZ41GettX3SWOn910sw4lzG2W7r2InHsakwyQ1N6qp76Qdl80+DePrnpKsfTUzqq72xs8smAsM6givJJjojXHhdbBkmYq4b+WCcieqbL+DpLvOB8n9Pz2wMp7SIWdQyVzDO9M7RuUyAASh2ZaqYr5qXme5IAbPQdiJ3ynYa4TMrKLlEUmjOERSNLl29dWzzEEwRMyZ+30AP/8tb0Y0semUmwoEi61/LHW8p8i8AP+rkpaJg9ZBEZK1aMvcYP0Vjr2EH0F14sXvP4vNUPvdQtfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xddQgQsT7mj5bjYHHpPC1Pd+/juVZP1LfGAueXTN8EI=;
 b=JHMtZPs7HY0ZmBSUb5aG8TMA99Mok2gJxlHB0+NkJ2d4SrvAE/EWGMAvaviD5P/B8DpHud27dX3ytGXPNW6LR19knb0BLSyU1850Ry5TRkQiItnuG/xsbtMQfCoZ5zsc+pwMgkkSbKjVyXMbwE0SMbVZZWRiVIfMwueUe6iznJXHI13lXSnBBhojN6/dhCLgggb7mnHUlnGT1YwOkST5xU70kZZkahHtMOF183Um6QpM7HNMTmjSXN2bSPyJYtsHC+JVOSX6DuMzuRTRcIKpdPd8cZ9Gy+WK4Hlccvyxcrhv3I9diNVuLQWiAa0+EzvopQPMSS2HGI9sO7kZ9q/iTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xddQgQsT7mj5bjYHHpPC1Pd+/juVZP1LfGAueXTN8EI=;
 b=r9/Y0nYjmi5b1HYs7QcbRRkRQcNhXPnHSv8tXodh0Tmat55Fn0E4teF/om7ZGmT5Q52kKW7ueaLr4cf7Ttor7t6thJN4kX9efxGZmcjjPYP1aWCnH4N5qwJeq2pWnLd3iB08DNzYhVFbwTwRIjTqblafaFKS9tOjy0yZPcbOn288WpiNewCrjswMtFXhVwYWecUE9ResyVCqSbz1TN8VnZfqHKbetqWuGEQnQ5ngPHykEuFoVeVjMDu5vn3Bvam0UQaKw6Aq6hhKIUJgE0V1tyBBIhmQ306hK8b1r0RXuQvVfQwaEQuBiZLX7sByMQt2pL7ofdJWRX8eJsNebXJxPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 13:44:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:44:21 +0000
Date: Mon, 25 Aug 2025 10:44:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH] iommu/amd: Add support for hw_info for iommu capability
 query
Message-ID: <20250825134420.GB1970008@nvidia.com>
References: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c339a13-3a52-481b-3d5a-08dde3dd7eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n99W6WhUnG7Pfss0eSVBtV/2RyWqBZHGvc7Kfll63ndtK2aEcSk7E6YeNoGz?=
 =?us-ascii?Q?u+kbjFLJgBQCOLHD9dBDZfmSemsk9eay9MbcWYoRs5VXQOlCAFi97rkMUgf+?=
 =?us-ascii?Q?2YaqaANCDl9j5NITvZ+RCkYHjKAf4VufHTAnDwGR0BW1EyVh/nymmf3jbAXy?=
 =?us-ascii?Q?u7Mymirzk/KPhFtm/1GFtdwKnhUqFwUT1w25VGrwwv+GylVCeIQ7mGAttXDW?=
 =?us-ascii?Q?5tg8sPKdr3HIxalT+sXFn1m52m/toNG0ba9lZm0Ut8HdwBN+xSL39Nb36RIY?=
 =?us-ascii?Q?+LBonxJlWTshlv8wNEILzF5wQSZV5g2AM7ib/fAyLD0tg3Ag9QeFqM1Kl+Yt?=
 =?us-ascii?Q?tx2HtdPUGnauYhFwTD/D0ck/6xtWC9/ODf81icUh47AXaMlLykOBGBghBeDG?=
 =?us-ascii?Q?8q34W1LQOEVorw04MpMK8wZGKap1qDggEfBKc7JxOoCsOE/y+6MgSxbO5FkU?=
 =?us-ascii?Q?oPgR4ChcxxKzEj32q59eR0rPqhXtHtUZns5u6gAargGeQMjJtDCTKOuoaRXD?=
 =?us-ascii?Q?uDd3Q5IFw4rwus+l/Q36qOLrly5RWf0ZlbJSmkm7hwldFiaG010omAC0VBXr?=
 =?us-ascii?Q?zfYBHbujaUgWrF3rOHuxSVC559c+9ONEQHKGFnN5ZAjVuxLL8qZzZI3iqXXj?=
 =?us-ascii?Q?3VKL8JVJ0UBHvExXmdPQhhFESysz9/2qGDS5ncA1z6tp00iaOUPhAO2KN1G0?=
 =?us-ascii?Q?ix0IX967H+ln+94p6afKJCro4BmeHVKI3xfrqUgolbv2Ny/JcBfwAPFvguFS?=
 =?us-ascii?Q?1vPN9Vk1KICGsdNUNlFKzxSG30VwR0Y2SZKkKl3CY88EfKmhfNuqfYQ5V0Xz?=
 =?us-ascii?Q?WKLplH8Mv+Q0q7XxOrWhd/2vlEsmPFTSsdNJT9Xd7LNUXc5QLhRrCPwBdzGQ?=
 =?us-ascii?Q?YiYfDNNwx34BAD7b8jotLNn70m0fM9U+jcm2/ODYFrfZEhA7Sb8neR0KDXS6?=
 =?us-ascii?Q?fAcp6xgwLbgQBrBeCM8s7Vs6xsdxl4UOV3HJwyrZMCyrLOiChPPStSaPkrWI?=
 =?us-ascii?Q?UQ2tkP21WX/cvjBTbtvge3RL1B978hOnt1r88bIpOsZ13Knv64FDjdwNNaz9?=
 =?us-ascii?Q?GZIC1O3E3y/moKo7j82r4SlcfBprHxtBzKOiICGdAFTznwqc3MXsZgJ1WILB?=
 =?us-ascii?Q?0ULB1imrN/68yr8/MosZlqldSumc2yIwQ0gMWaydiFEjenoii2KUPr2dAJlU?=
 =?us-ascii?Q?Db0dYkc2d9aMdZmSZ035E2fYpj2IRQycwETYIQukkaJ0SweunDhjlMTCfNMv?=
 =?us-ascii?Q?vBeQGlZ88Eo+H80lbFAty/Ewduaw1/DyC47MSLnriDGPaPYGQW0GMwR5PLUP?=
 =?us-ascii?Q?8yfxjQOCT/UpfizwNvnwKHRmCkEhu0lt2Jwe9QrJ8AtspJJfe9P1t7IUp9SY?=
 =?us-ascii?Q?hl8nH60RaY6hq6Y3ePoLuWI8H5LhWM8qwYP6mgiMXtOwZenmhqelVSZDC6x6?=
 =?us-ascii?Q?eD6+v0Uia2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xc6DsClyai6RSm4vtb9I0dUXCWSBsSNLNZeyXy+2dYuS97N5jucDR4EQQZMQ?=
 =?us-ascii?Q?9+fhU3uS0VBNfkvpFBrEDiKjqiZC91xkuMxj59lNr43puD3g9hWgVnuuj8HL?=
 =?us-ascii?Q?Qhc5PLHTFwI7/kSfTQp4J0YjXsGCf3RzkF3gi7LzE7A82B4bZQWp+UuWeeHu?=
 =?us-ascii?Q?672mdQOyxXknexENDqaRGcN/WifZf5B5DtLYS/MwzmK+NlJc8ib8lBjgPEtl?=
 =?us-ascii?Q?BaehhI3kBaL5ZQ0py95TIoMuXyF3D/pVDvxOAIWW4H/VG3bXojwDQOY2qEIB?=
 =?us-ascii?Q?3TPomYpnOWBABhWGFXdiKvoqgtcwYMCUrSsJCRqx2eNUFUGpNZnt1snxk6SL?=
 =?us-ascii?Q?/ThmPo/ET9U3b3A5fD8BfACjBYbdUsfidC+k/oMPoB5ToHKgWByyBS0KOHT/?=
 =?us-ascii?Q?G0oxO4HSLut0OCXfi7B1Dn37O5L7BpOJ2bWjOBz3SsAEY9f+5xEXbfQfwDHm?=
 =?us-ascii?Q?vzSEpOxTKbD2b+jldXrJCiS02Ipx2x+5RGZfyBHRWkfBXXcBRwBbigbjsVcs?=
 =?us-ascii?Q?/gpxGCtakST8QVcRHZmhxJfJCa2dcgAYXPRWO4B+MfsFILMi+lvj0nGl573p?=
 =?us-ascii?Q?BNIvIcRujEV3hR+W7KIkRdC02zaJIg3wVMUvNrJnvB6i56G/7lw+q2OtBjdr?=
 =?us-ascii?Q?O2zaa6/MDwmhwP6o+hgNfXg7dkWloNK1VM6/0Q4otOsXjyG5qgiRccrmE4o6?=
 =?us-ascii?Q?4U6QFH2UJk4gVQqUD5ctsw0MatYBPZRzAC7deoFb42QZAL9ef8LlmDuv4HrO?=
 =?us-ascii?Q?/XLgHjsUZRBSp/OHopIkzFX5ACrSozsiOmPzYaVIX3VU+V0/teXBMswe6Xpe?=
 =?us-ascii?Q?1/tORV1N7XFm+OgfaMKDwvGLMccdbukxVz0L2DchJokyNJEc58tN+DHBgP31?=
 =?us-ascii?Q?zAr/ucT2mOIp8VneVA4H45iuCyush/Zv04GnlBjY0E9TGiR2FXWCi0aEe7uu?=
 =?us-ascii?Q?RgDTQZfLveOpmVz4mUq9PKbb9ZOsQD1PC0tgBYDucqF0rBV3vaVVBAqAvgDh?=
 =?us-ascii?Q?kvAD5vg/nRhqXjowe1J3AC4mIhZQwqfamrRgy+nH7FbrPHs7yl7T9WM1jF2V?=
 =?us-ascii?Q?z5DxKG4FutNkRRzNL5aRunj4DIZhx9SYOCB1pHGl3/KatG96Ld/vtMsw5NR6?=
 =?us-ascii?Q?3VnXN3EG5a+bmf4UnN0ckr147/xZq0SPpiDIwIv+pJ9MUaIVk6HK/xJ2wpFg?=
 =?us-ascii?Q?EcoLxf5iXIahBBl3Fa7LWamFdHfzJq/GjucCWQi/JAXuqdjO7zfzIz6hHqqU?=
 =?us-ascii?Q?SFveit1plqB6CRe4j21AhAqXu51U9q9hocTdNuP5flAQ/CaiNlU1n5s3d1fp?=
 =?us-ascii?Q?TR+x0irIVt8fBqHrGnGFLPBBl7AlxMZg2WM6VyCMWOKeXmMROXiOUQ+/fH3+?=
 =?us-ascii?Q?E8KTYSsgBRTMRF5CPx+qG0pzJUx8uzRXpZvjzWJ0Q1sck+dRX0FxNEzps49O?=
 =?us-ascii?Q?uO23IFf5oYCpKh3Qq06QQG2mhp4lOjkSbSKHKR7Klo72Zr06mVUlF0VX91FW?=
 =?us-ascii?Q?l53AKn/TmIeqOSZRe9qtwCr3kCLtW29gWhy7JSdUb7vtPk1HxGcpFPBc05pX?=
 =?us-ascii?Q?ZV/Yhja1M6l7Ev2XWKU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c339a13-3a52-481b-3d5a-08dde3dd7eef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:44:21.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OTrqYKREAdvg8jQR/APx/i2srbvs3zVJGgTEUEBpUxJ0sQnDrvfVrusf2fc/jk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

On Wed, Aug 20, 2025 at 04:25:33AM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor determines which IOMMU features to support
> in the guest, and communicates this information to user-space (e.g. QEMU)
> via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 +++
>  drivers/iommu/amd/iommu.c           | 40 +++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h        | 19 ++++++++++++++
>  3 files changed, 62 insertions(+)

Can you follow what ARM did and put the iommufd functions in a
amd/iommufd.c file? I think that worked pretty good.

Jason

> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5219d7ddfdaa..efdd0cbda1df 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -95,9 +95,12 @@
>  #define FEATURE_HE		BIT_ULL(8)
>  #define FEATURE_PC		BIT_ULL(9)
>  #define FEATURE_HATS		GENMASK_ULL(11, 10)
> +#define FEATURE_GATS_SHIFT	12
>  #define FEATURE_GATS		GENMASK_ULL(13, 12)
> +#define FEATURE_GLX_SHIFT	14
>  #define FEATURE_GLX		GENMASK_ULL(15, 14)
>  #define FEATURE_GAM_VAPIC	BIT_ULL(21)
> +#define FEATURE_PASMAX_SHIFT	32
>  #define FEATURE_PASMAX		GENMASK_ULL(36, 32)

Please no.. FIELD_PREP is how to get the shift, don't add constants.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..ebe1cb9b0807 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3038,8 +3038,48 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };
>  
> +#define AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS \
> +	(FEATURE_GT | FEATURE_GA | FEATURE_GIOSUP | \
> +	 FEATURE_PPR | FEATURE_EPHSUP)
> +
> +static void _build_efr_guest_translation(struct amd_iommu *iommu, u64 *efr, u64 *efr2)
> +{
> +	/*
> +	 * Build the EFR against the current hardware capabilities
> +	 *
> +	 * Also, not all IOMMU features are emulated by KVM.
> +	 * Therefore, only advertise what KVM can support
> +	 * or virtualzied by the hardware.
> +	 */

What does KVM have to do with iommu features on AMD architecture??

> +	if (!efr)
> +		return;
> +
> +	*efr |= (amd_iommu_efr & AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS);
> +	*efr |= (FIELD_GET(FEATURE_GATS, amd_iommu_efr) << FEATURE_GATS_SHIFT);
> +	*efr |= (FIELD_GET(FEATURE_GLX, amd_iommu_efr) << FEATURE_GLX_SHIFT);
> +	*efr |= (FIELD_GET(FEATURE_PASMAX, amd_iommu_efr) << FEATURE_PASMAX_SHIFT);
> +	pr_debug("%s: efr=%#llx\n", __func__, *efr);
> +}

I'm not sure all this masking is a good idea, how do you intend to
handshake upgrades when more features are supported if masking is
present?

Nothing sets efr2?

> +/**
> + * struct iommu_hw_info_amd - AMD IOMMU device info
> + *
> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
> + *
> + * Please See description of these registers in the following sections of
> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
> + * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
> + *
> + * - MMIO Offset 0030h IOMMU Extended Feature Register
> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
> + */

Need to document the masking and explain what the forwards/backwards
compatible strategy is here.

I think you should probably just pass the raw HW value through and
require the VMM to figure out what bits it needs based on feature
flags elsewhere.

Jason
