Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747F395AC7
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593143; cv=fail; b=OlixAYWOjiyD1h5LoB0I+JNiudLpbogx6KS5pq3s2cUSiDNpM14JMF1zKr/qhRePUuPvO2k9+lfmeG5qgisViH8h7VZygFi375wg5jbCeql3O7nZmsqEH6FlcLKaZYzGKI6ICBZ6B61ILc1/pbc5T8+fDie3ZsBTSTbViLOuAoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593143; c=relaxed/simple;
	bh=TCwCsSky0dgqdXRyZzFEtkoMtpcSft0yBGk43+wUmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBJ2uWMwyIkrskFTUPjqb+TpiOyvFvHrr7KaUUfBRsc28QQCBM2yyiH7Dk76zMGEyoSn99I8Drj4t8XfWQ4SArck/zcqTbhsKtf8w2gtJCBUEazb6tV/C2BaACn0lpZK4WSR6XlVS+wCt/xZEts7r2nmVcuwDALBhwJLX35f65g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3/uHmkL; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3/uHmkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhYUmHP5MiA2IZynqk6vkl9+I5KiGq5O4LBAkM/aHjwMGF5SYaLjib4w8YzXj6mWufZSn+bIww9PU6QoiWB69/SGJq1xQ+65pQXGAJyxVDbZ5IdMDoDzGfEdA1eV2BFfNcLTQTa5uXcCDXUe/dU43voR+kln37ypHQzvNN38/JON7u3Szez6xJaZ4vzAhktbLVrHJbxQIxDdnTm+y1BTCFxlBmRi/yOyZUXDZhMJoMgr/L4rBiH898A+rqSmWCqITRjlvz5bwv0+z0rEHnMP+n0NvVb2dNbrKTLKkU3aMw9pyuDyjoL1T1vCyYnjL17u3axyQZ8iSWElouh0YzR2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Hsy5f45z/idNgevQvqe7JIFVq5r7FxU1xMmWSIi2A=;
 b=Uavhhh3m+F2Ezg3apvq8nQpSEFThSDGhw7zxrg2VnUlm9OgwHUWMogFK4OLhjyCJ62p8JYwB3DTN4gVesJLG4aHRJM0R4LsfYqNZ7mngO9EdDaQ32P3aeu5RUtq/t5E1BvxxfNlu8xwJPWqBlRVXBQF0gJ0QowwyEO6Mb4s5NH9jSEkyrSQ7AfwqyG1xmPAI/KOt2aUkAcQFHs73kaaOjmcfTn+7ebVyWyLqV18LCWmeXaydohIFxUKHI3IdvHxha6GKMAUZTmxpT9eGhJ6NMMYrFl2bxklhfKs5qDrbpGHXf0OveTMe/p8rSq30utCmLxe3n11dlE/bSk7Ve/N8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Hsy5f45z/idNgevQvqe7JIFVq5r7FxU1xMmWSIi2A=;
 b=Q3/uHmkLWbAza1wqZsnyH+2ijNB1fiNEWDZ3R0n/sGAFlCkD5iHK/f+Msdrulu4zyWADvx+KoRdR4n9yq36S+RFM7LxxbiekPR7+8I1YGxpVkKYPHknvXX/SSGC0cD2QanmzytffPGWDIsOO/MptJ6SAqohCq55dL7NMbXNAgK05VfvNxLqjkHW75Fr/rk771vzRC/0NjrDkuf6pB7DB5gFrI3SmgZKm8MH2zNYwzcLVVwsuFmDrDaRalZLQjh2DJqdL1pm195w1mPIqtpKuAJnkwynrYy/W12zFolqHz8I5GUD7Yel1SbOjjnumKm7kXlWyentHIO/DiyRd9uiXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:38:56 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 13:38:56 +0000
Date: Tue, 12 May 2026 10:38:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	joro@8bytes.org, will@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, anup@brainfault.org
Subject: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Message-ID: <20260512133854.GA9129@nvidia.com>
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
 <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
X-ClientProxiedBy: MN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:530::23) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1acf50-a2fb-4606-f78c-08deb02bd08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	sHe9pcpdSS3kz+b2ICKI0crbu1cGI4OKlQOWbHu1L+SosKCiIz4eOqsrDbqIA2E8NPBKinOo0B0+yases3sX65Z1RNOO6vMYfLmncbtd+ZG9MoIg/GR7zygFxGy/xCJVML/TCmsbJPD1nLc+2LzMv2qOkqajjeI8qKAe4PJOAVY8HlSYRe15F0i7XnRv8diTI3Zr0rENYb0REiqaQRY/DRWE5BuDo24YuOc18t4MelnG5Diz16ZIQUSje6voMr+zbOM639fgFx49mcisLAowRGKCJcm5AcyLUG8GC6UhoM0P1uf+JW+OX0Hvfs9wE5E7Mn9gug6qqcFHojjw5VoOSiZ31HjLxDAC2b/x795JQFt0qCuHcZzBA+Yi6WcvGb2KcYrUiNIuRL3g1Y9TgeCMYT3pdJnHQ4pX5koAiiXzt7XQVHwM+XFlhSyZNEdqiAMGQ2O63BDn47V0hn6TFC+RAlwL2927DsALx1iZGFfKJE54EvsCKCMLROGHDOikV/7OSX1nvTzceNGLVifu4G7DC0or8uonHdpOjGXmUzjHokPCVstX1I4GnB85M+zOYZlqNrOf3JgRBjNS9BgseqXbyaW8qZIg4v8k5RHliQFW/hocWi4wA7Kx3Qzu4SQ/njJDjSpqPbsQw/0cYUObf0DPVizbfWbchaClju5Vj5zHFrEk5Ph2jwUj249NtJM7ig4y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+KrWZMFJpc8NFqJLiN2vk92H5ORfgCdAK5LZeulokJiGloTCNjBIYSVWz3F?=
 =?us-ascii?Q?xds3TEIuQ3SEAjPkwY1OKu0PmWOhoyRYAQaC47to+U7tLLHD89h1PToK/rCv?=
 =?us-ascii?Q?v2XEjEWeF31N+LP96diZY2UzTD4cH2opnFFB1hrnQXRtAxMNka31T8Bjxp3v?=
 =?us-ascii?Q?OHghaxnB8VisVoAkXTNblpIzkfQ7HeOX7O24iyA4wfxKsPfo1HOrS7enQhg6?=
 =?us-ascii?Q?bdaNm4Nx3f3OtZ8cIyGPRcFlFh/wZ1TN9nnUGjYmq0whOqFbOtz++ulu8upP?=
 =?us-ascii?Q?wUOS0gJfVeh9d5QNzK06HbPLy/lDXuIB1dDRSHAO3azRQ4p3hbrDKWZm8RrS?=
 =?us-ascii?Q?OC5G6bMK9xoUESHIx9EaChJRkWXxuoysfbc3iURiaXlSAgewF5KqDI1BpF/e?=
 =?us-ascii?Q?bYg0jW0EQd/c2MAatcVJ89A7b7+MILJ1jD6oyLjraKhdKV9Xl1++CHV0vhWN?=
 =?us-ascii?Q?jEivwLbXnwpzOLUQXXiymWuePv/0AVGzL/LvxznF3mJYmZqQJSHVveRUSh4c?=
 =?us-ascii?Q?TIIpcuiZzi00uPTizZMxb+PJjHi5eEis3J+tPD0a6SWZZT9qO2X2vQtrpyJc?=
 =?us-ascii?Q?dCp85EM7qSFs+sa0A8It5MIDeKj19kp+oGYKt1CX+Y7OpgSp08+Pe8n5Lylw?=
 =?us-ascii?Q?TJArTGcQU9MLCGVRBcqrbDRi2CSXcyw2m3VFQY2+Gh0ZzGoAgWTGAG+PVC46?=
 =?us-ascii?Q?4temNjyJESV/PTxOa5JK3S0ygJy0ttbETNmKq2SJx1VxBuhALpntlP6PuxfY?=
 =?us-ascii?Q?K96TMZ/B9x4vkJbUvT1jMeSAH212uwD5Iw6IgmcKOU+qXERI/81OLbnwFKYy?=
 =?us-ascii?Q?xLSjEf5KD9hl6xKSkKs/qdZ6UmeAOgIsny+2fqzLCXimLx/nCpPX7SUewuNx?=
 =?us-ascii?Q?R4jPTqWc5GYBwhXObmRJm7vpuhvwhQQGTRJ/x6M4PejaWdxFvYfwTTz2GKdZ?=
 =?us-ascii?Q?EULSzmEomSvBQFqrPJkEIAeNMVW1e7eMuSdhgOiapUVzzp//pE04SLq395mS?=
 =?us-ascii?Q?uMgpvZLI5Va+EJ0AyvR+Im24i4k/QlugdoSkZoFEF9R6KizRd8W3Aewfzin6?=
 =?us-ascii?Q?2B1H4v9Mia8fOuUX/KwVI9f6UGjbqJgiM3WvvTqGkTJjeClnWJPtXF19Jsli?=
 =?us-ascii?Q?/6lQFMMsIg2OudwMj6y7BdDqOjQU/G5NYHMh/55E8dUjr0aJBMMQ48A3XxuV?=
 =?us-ascii?Q?QDewxddkUtMFIxbYgIky45bPa0xZUVUaKNeWsFoJuiCcFT6XycYnhXOayUf5?=
 =?us-ascii?Q?W52HL9VfWGxsLosTrnZlengYYE3YGbZ3M+Bz/2z85Jh/qBHpNKIFd3oWxEUk?=
 =?us-ascii?Q?NeFtwZK1LFXtk2s3+LqA96fmoQKErlc5HnAU1UQGJu1O0wFpJ8vuzh5bmglJ?=
 =?us-ascii?Q?vNQZ3TR2OyubN0CVJv1eVg9j5hxhliT0/ue71yplsB9v/RKpYq4e9NsbQzaM?=
 =?us-ascii?Q?4VHXg2nucRoRrNPhJ8FVXqDyQJtEuK1HEXPMmbvMkGIhzrUEYOs96Z74ChhB?=
 =?us-ascii?Q?99dEKleJ0kpYHGWByMQ93tAzQhheLkjH9ZyHs5RUd23IxfisA4bp9sNlGoK/?=
 =?us-ascii?Q?2nnknTSaBna2VkkedklVT/2e9r3aIBeR+mCC5Or6Xpl74+iyhtJNC/+YT8+u?=
 =?us-ascii?Q?8P7cgqI+Cfdhg+xd7EX0akbYrvVkFGSrizRSMXJsafM30RfsA1RGF5Oa3fy5?=
 =?us-ascii?Q?WYNU3u7H7jvGLGqIAZgFel0Nz8YCfgNPGNqrr7pHZtTOdW/9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1acf50-a2fb-4606-f78c-08deb02bd08e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:38:56.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9faavJCBNAJoyIyk9l+G8vHOpzSKZUKA1YvEDNrFLyU9NmRlBdn9YG34cNe57cD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

On Fri, May 08, 2026 at 04:23:38PM -0500, Andrew Jones wrote:
> +static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	const struct imsic_global_config *imsic_global;
> +	unsigned int cpu;
> +
> +	if (!imsic_enabled())
> +		return;
> +
> +	imsic_global = imsic_get_global_config();
> +
> +	for_each_possible_cpu(cpu) {
> +		const struct imsic_local_config *local;
> +		struct iommu_resv_region *reg;
> +
> +		local = per_cpu_ptr(imsic_global->local, cpu);
> +		if (!local->msi_va)
> +			continue;
> +
> +		/*
> +		 * The device always writes to the host physical IMSIC address, so install
> +		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
> +		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
> +		 * devices.

Oh? Why not?

> +		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
> +					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
> +					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
> +		if (reg)
> +			list_add_tail(&reg->list, head);

This seems like quite a hack, the ARM was seems much better, the
interrupt controller should be using the iommu_dma_prepare_msi() path
to obtain an appropriately translated MSI address for the aperture.

Then things will work correctly with VFIO too.

Jason
