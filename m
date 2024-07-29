Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED7156654;
	Mon, 29 Jul 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272155; cv=fail; b=J6XC6MTj7pY6XeJ7YRPMNiW7tXAahuGl9a0y4yiDkuLxKTc1xqFhs+V1euTyju4+PBJYtOzLqgXpcANXQQZDZKSAasmu0tZoC2COasEiVUjqWYlTUYtMPhaLceBRAGO3PKhY52Z/qdP/RabGowfnHD3f9QN/l+Qt4xOaM2DvhPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272155; c=relaxed/simple;
	bh=22ezeCHomg0cGNQlL2T2udQ7QYlk/ookSXhuozfdays=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q191E7hdpE4yuuEEU7NfguPU/YlDjHdwVWSJIifw3Xdn2cvnF7+P/1C1xkKR+B9xE1CodnWllIBn/61WKDgB/Z2X4qTv+VFuPJoKgx2xlS2a6SYJ5uzwiEiLxM+xHl6N34AoK3n6pmiuzbO+R8L8Xmp6KIZg7xJpH3DSvSajYjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uf6hQzWl; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uf6hQzWl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OArMKu7J8tp9JqaTHmkFqi7TA9Fnns2cU05piiel+kdfgemsF8qej461bkXSeoKAcu1FtCfNTvPM/f1u2L3jMTxf2TgDfNvDA3nBQcPFFBVvAVB3mTfVDvuRaQ44kjvycxGpn/UpACLlP7c3WV0mF0DPpYqIqSlW7OQ4Q9Y39ruzfA9Lkfo8i96v9z/Mzvw39c3XeLlYnqWYAuXYrgpm5AC3IPyFRQYLPRqy3XfwOcehAcP/2TLH4kHY6146NVBbOiPf7hCuFMKjR5zkRGrrvv3kRLcqUbzSx5dA/bXCMQ6rsH3g+ZqvdJPdIbwZUWwghKOgwCQZuewWSJDTyvRpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SLFtvJTjFBZdpsSgVh9kRgRsUmwkGckey0TPBLL+2c=;
 b=Dq7VFsdmxVMp7F1dlTy34MxxTrE/HloTAq73kgZoXxrOIPM4g68niqxwNohIP6axY0cjMUESJC4REztUNzxj9ivohlcvfP/rklu9BFG/8AaYUeIELkwQuBA68Vf8HHC7JIxaU5Od1lgjH+F+uClReRYSHL9AN2v3Q2m1nVSv874c03EVjucMKh56Ai/gtQsz0CWUxZvnYwpE0r0uUO7lr5MiSxfJJqRJBRgckZ6Rq/pVkmUWBAkQyoAI3OQulQUdLvc5hIjPhjSEpAV+lKee7vvOWqMWnAHgdefkTVV9UynNmoPvPtZZkAgyVVSrTm4BkYaD5VqlSel1SQtfcywyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SLFtvJTjFBZdpsSgVh9kRgRsUmwkGckey0TPBLL+2c=;
 b=Uf6hQzWluc8uge8NkejzlhM5ra2QVZgL52pAxygEBon8iGM8kvWtaiH7VwETU4iLiUtNoBhN6ejaIHlI4xA5Ri82DmJG1VABJfjJbI96UJqKeNTz2ecEcXcVSFp1kw9/8YsL7aMkATZYVGW4Yg6/LjlDhzHqYILzQR2igK2NLLG36+kYnRBPx2NdBKIWd1RIwP9mvYpAbmYFHHKWwezuUdPAOkHmHCo+9JE3Kkp40fh1J01guzOBktpV0fT7DafWH47QvrwpvLo1Fv2I1ASle4vPk2JG1I3vjImtkU7SxtGcsFkEB1QckeoD59Fmc/bBw85VZKuuw/dfOCTIFcDiEQ==
Received: from BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 16:55:49 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::15) by BL1P223CA0002.outlook.office365.com
 (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 16:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 16:55:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 09:55:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 09:55:34 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Jul 2024 09:55:33 -0700
Date: Mon, 29 Jul 2024 09:55:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: kernel test robot <lkp@intel.com>
CC: <will@kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v10 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZqfJgxMt77WqqeNH@Asurada-Nvidia>
References: <ca671f4d090546c21a0aba6fa4ddda8da26d4474.1722206275.git.nicolinc@nvidia.com>
 <202407292157.BauV7TPf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202407292157.BauV7TPf-lkp@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 856e779d-4827-4e7f-b87b-08dcafef4c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYaWIWS55FZ16FHabLToZ8oR9Kkw/JRqubnX1OTFjLKx6eOFRPJFzyG8YUU3?=
 =?us-ascii?Q?lIdEtMEetZZCC4O2B5oaBBAkAGpSvN1FZzddxiOkGppES570vZnhQK29JbkM?=
 =?us-ascii?Q?87VUTNQgUBfOHVd9qW7VR+ir8WfUnoMIroP6VGyiAIXIWWpsRqiJ7yDcjJ2o?=
 =?us-ascii?Q?WRcPe+GQGeEel7roSoW9dcgqiPSXfpmQR9Cc1fYdmKEdbMjb0Jn/4E01UQ66?=
 =?us-ascii?Q?C05KHzpl+ILPoCZcnM5p7BZ0oZGOTo43gDiI+RMVbt4OLbMbdBhI8qyZuDD+?=
 =?us-ascii?Q?PPSyqpOTJpoxQGACNg2R6M4386Ioe3joj+nTA+7RnWR22BnXSzDLvMQh1AZQ?=
 =?us-ascii?Q?GKTDTh+Y8+kcqfmlJsgCahaiF5t1JBlYmJLjzaSm0C7GULIeUQUqvxxWXHN5?=
 =?us-ascii?Q?5v5K1zgBD7hyKznO8n0CrfY5SqL5Lxy6oXGpOPwberiq1yRHi0pSnRP27bgu?=
 =?us-ascii?Q?px2IDFHEr0PrIMzkj7LJe3V61NzijGrBGKtbx7ukuB91uPzZZBRST2ImpxX8?=
 =?us-ascii?Q?MlEtXA6q6hoR4fTmeSP8ztr/6v73vL6+CxVa4AzMLZtG1g2iQWp+2YCEjYPC?=
 =?us-ascii?Q?8edz74OlmjtCusFgPxlQYoXqltxKFlv0avo0yDnD2x0tx46+vkvAFbKIeDAc?=
 =?us-ascii?Q?m4vHxHGmXKDUV5njaa7oQ73syyae7a6ubdXLsyC6Oo6jCveKuUF7QQbbFrRT?=
 =?us-ascii?Q?2LlI9xL7JWN9O4zS3ZeclIxOnKSW3c2C8OWifABX0zxPu79HRD3+DbQgwA0l?=
 =?us-ascii?Q?vVekKItAN/SYxmvUiF60cH/eX0A9HyAe6234RGrZHtecTTzA8fBek37dwepQ?=
 =?us-ascii?Q?BiYd4xnwfeSLqOFVMG1Qp4oCDUU3xA86gxec5Dua+IxhuauLYy83nB1pWSpt?=
 =?us-ascii?Q?lpSSbvj4kkCtfnPoUMBmFv3rCpnkPUhwnmEY1xAW8VGY1AXkRDZlz1fMUwOe?=
 =?us-ascii?Q?tf6u0XSVbeb1zcgvMqLVCVmcU1AKwvpFSPtnQlBfLeWIdNWGVcSjzKwBCaPN?=
 =?us-ascii?Q?atBNqC7QAacHMDfbf+8rv35RFfYmb3yJszfEGpXI4mY9ogRHb3rz7icU1GOw?=
 =?us-ascii?Q?C66jlw91RRUXpywPAH46bOpnSWrQJ5iLBBhZGzKZ+SFQ8p5xsXvUfepmJvfu?=
 =?us-ascii?Q?Boecr7L+kGrA4bYzgeQyeZJZFPy5Eq2phFp2TvVd40J95ZtG3DRQIf6b9Jl4?=
 =?us-ascii?Q?AxEXYn537CmhSTPrY6aW8lnv450V3hebN+LMFdMykc/3HiO+ZtVc5IyXlxA/?=
 =?us-ascii?Q?WhS0Xx/4Crux2zWfsQnnsOM96BGup+hIAZQoAMqSaHwp0G6yP3qXPNvtUTI6?=
 =?us-ascii?Q?wWBSQV+xsWCxhHMvIVg9lmVolUCibkEUzDG0oUy58ln5J7BHYjBKJ2Pc+d+p?=
 =?us-ascii?Q?smMOUjl4JWImOBi9qfPvZKmEdoncoktw4y19M6FXNMmh6PQ3359QzpTQvFFd?=
 =?us-ascii?Q?rrTUlIukxixZAvA1LOgp2LACZe9tKWHs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:55:49.0926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856e779d-4827-4e7f-b87b-08dcafef4c5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

On Mon, Jul 29, 2024 at 10:01:10PM +0800, kernel test robot wrote:
 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:186: warning: Function parameter or struct member 'vintfs' not described in 'tegra241_cmdqv'
> >> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:186: warning: Excess struct member 'vtinfs' description in 'tegra241_cmdqv'
> 
> 
> vim +186 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> 
>    160
>    161  /**
>    162   * struct tegra241_cmdqv - CMDQ-V for SMMUv3
>    163   * @smmu: SMMUv3 device
>    164   * @base: MMIO base address
>    165   * @irq: IRQ number
>    166   * @num_vintfs: Total number of VINTFs
>    167   * @num_vcmdqs: Total number of VCMDQs
>    168   * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
>    169   * @vintf_ids: VINTF id allocator

>    170   * @vtinfs: List of VINTFs

s/vtinfs/vintfs

Will include the typo fix in next ver.

Thanks
Nicolin

>    171   */
>    172  struct tegra241_cmdqv {
>    173          struct arm_smmu_device smmu;
>    174
>    175          void __iomem *base;
>    176          int irq;
>    177
>    178          /* CMDQV Hardware Params */
>    179          u16 num_vintfs;
>    180          u16 num_vcmdqs;
>    181          u16 num_lvcmdqs_per_vintf;
>    182
>    183          struct ida vintf_ids;
>    184
>    185          struct tegra241_vintf **vintfs;
>  > 186  };
>    187
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
