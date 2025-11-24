Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD5231836
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012880; cv=fail; b=CIfIlHCM29gauV1Cy/JxyC7HL3GQp900C6YGsiHFweJKqWvNS/OuY9R2bT5TGmi/K/WvgjBv4nlDzCwhKUrZAzPbmxAhLOKVx+ltp44BtYb17Z5tVF2U+Ex/6ncZZZQCWkqtdPuCKhQIwe8aIWtEvVeJuCuB2Cxz74i3mVqLLFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012880; c=relaxed/simple;
	bh=tlh23hVc7VHp6nIVFOziVDdLdr2NtXEcH9On+TvF4k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKmjXTu98EQ8iY5ppCP87mZKsct2T4ezzoDpVDJ7SJ5LlUHJGgMRLIfOMzVm+Ws9vIU48FR0ivWC1yI+WyyH7O//2y1fcVu9S0wpL4vMbr7WFpCXp2lXxKK3F0qA7lhmy96+/gtKYfGiJVHbPUWZ5hiJVHaRJsnWmsAt5uG7+oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSkf0fuz; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSkf0fuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1gHI/5cjf+lDLvIpe81b3O2QLM7FX8jygBTJoBhSMTcFP0b6YFVDeuT6+0JDpHLFnlTbQSQYpX0e33QR6zEifGar0Lde5inPRDCfAda4cgHDbIzerwygq9mrMHoKQJXzZNKLktxdUf3MNX810iiHSx5CD4ki97AoZV4I9ad5vfKRKnsHXMM/FVwe6hfwTi8a6U0hlyzEI8SNhTRH70wZbaBRcH1feEiEAEqKb+5rTyxQgI71IFkwC2GS+5Hw+Qx60zTt1Rw0MwFyV+QTJYwX62kkbbm66xrn5+66j5dmzwtDX7dcOnZNVFf5+IwuMQMVv9ZYeujEcieelSUM7yugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hm4l5Z9meQRq7P/KjDKSQUcMLe/6x0BcfPNJMVSDdI=;
 b=qx7IWoprrZe/EDLnV9wywJq87GAz20xxu1vUoODarXhxdSdgk+yMfOoqG8sOsZP37EBDTqIHGmIf7EcleZYesLqybdqgN0ChKs7tpnsKSFvuVwKgE4z3YImtE0ZAtlRp2zqJmrUGLNGMxUQpIUBCpGd4RP3HU/FAFjpl1G9/ZxrMdroTAGoum98xEAZxwxaLU9PZfvx03dha5FTye1fXqFy0Y3YJ4vVmLyMWe+mNmRuq9/FvkTnkzmNyFd8/osKt79UUs7uXbuSLd12k8TZcbtP+CUCa6DN9iGEEjFd7WTPaRQjjRntgVUZ6gHBwaFyefOL6RHYaMGjpIMeuMIVFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hm4l5Z9meQRq7P/KjDKSQUcMLe/6x0BcfPNJMVSDdI=;
 b=uSkf0fuz64v/qJvMv/A9Xjrsv8i/wrwKtVoNgQoAwv6kBv+xwj6VMDlbKe/1+UMoaL24wqLMVAvm5TP66xWBFD+QVPTig9oncNw4tui2+Uz5NEMJ47c36g1kaGzc9FE4943QC5dTV72BVKXt8f3AAbFiOdxlVZv14MqCcoEgFaPhIw5qYi5fdHe69NznURk+72IlMNIhb+lrIgNvda9vb8Dqt4XcHk/QKkay+sPpkeu4slyN3ngQZUOLlp3zZMVl5PBtka814/gIJ0Qk2zGfu8TPMOqAGoEbsr+xToeREUmAPiebXR/u5+NZ00/13exz4d8WjEGNQEgTlyu2FFyYdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 19:34:36 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 19:34:36 +0000
Date: Mon, 24 Nov 2025 15:34:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
Message-ID: <20251124193435.GL153257@nvidia.com>
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:408:e2::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: e0148989-9d95-4e41-6220-08de2b908036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7EVBmgbHYE5NN5TTPEL2N5KwBdlo04VCm8dA4Y9SS+1hcACZgUAeqnURa7g?=
 =?us-ascii?Q?ub+fH4yr1lOHrOQi3o/1d2CY/s9PLWsTlL6VwvFM8iaUGxCUmxNrkKktSPuS?=
 =?us-ascii?Q?ROUDDnbXf23cZoO21cN6ow0T+0nmJ37oEdKZ7h4yeQRhiNZIfCl+kryg/K7X?=
 =?us-ascii?Q?y+bgsaN0CiSFkL0BRkqECXicfcD0304YmfAvsGCKXiJDu7pLXjcAHARPSHxh?=
 =?us-ascii?Q?IjE0Peyhm7eKfO+Ah9KfS/hQEuEVoUIclJyGNH/J5Eik7QhIm+x9MvrR+N2t?=
 =?us-ascii?Q?hk+m0eAY/J7U0WP0a98AoQrM/ob0DclyXkiC2sWaLG8Pe0Yt/wuC8bge66pa?=
 =?us-ascii?Q?kJ+WDiUPmgLjIW6nk5X2PsLgIEN4voYlnR7FWO/dEBoglH4R5ifGuJt47ucG?=
 =?us-ascii?Q?7a54fnMXHjwQx5avKkf16kBGedWRQJXAs3HG4oib0rZJTKCwZTMAGjCEzvJ0?=
 =?us-ascii?Q?pl5FzEaPpykF2ElInAnKGgC1A+REMX0p+Pggl9nymWfFa8y1r+PyFNBif1HN?=
 =?us-ascii?Q?a2Z9KXhCxFZOGHZj8Gob/PvYZCUuOteYz7njtCwLYu4g3BJXYv6hn603u9cx?=
 =?us-ascii?Q?TnnadwuELwuUGYObAK/QoiCJSzi5GSZYJ97PBsPogqmnU41zEB8hE1/+mdSH?=
 =?us-ascii?Q?XhIqrHgrE4rbB1S2NhitV7t1/tJY7vZxKPtQa5AxPLVaeOgZK4EMa6/656Dl?=
 =?us-ascii?Q?62qRqGHs8QI3sYTC+QtGMEmyFV4QXGzSIVCCjmhfo2sZABOCnnA2UzQ74dpX?=
 =?us-ascii?Q?st6O1sx6Y+5i9W7LrDrdGPmBFdPEH796YCQBhbwOIGvuYqDld1mnFKyYYaZr?=
 =?us-ascii?Q?yfqT8IcY3QTqb+K9r1L6vb9pc62k7WW4rXMW4Owd5lF9BhGc7AYLgUP3uRnP?=
 =?us-ascii?Q?iYoIDxXHU7rkoZlZvm3oihmA4eozLCX7rrL8iD7KG/vhIdkSByTb2f7JDlz4?=
 =?us-ascii?Q?RsU//AEStlX4hNPsTyu0YT/ILwUyrt/caWo70LYSHoJU8Z9fB1RcUMKb69wR?=
 =?us-ascii?Q?t030rMhMurSDput/93Y6hxMbWAUsNm/cyYRjAh9JHORUCwsKDHdIhFcVSFgd?=
 =?us-ascii?Q?BBklzo/KY7zPdYT91Gb0f7d+o8Mgo5gGhivKnRMqzXS/tHsxKfPcQwLDmu/R?=
 =?us-ascii?Q?djgEP4GzcmJVq16osYvVTi9Xl/x41bWM5VCnU6QtlTrHkmtHryabsLZfBKKn?=
 =?us-ascii?Q?7IK80lDJRcrkInejIqlLlvooPom4oJIKk0BwWY2g/nAwBfOregPnpCzKlvYs?=
 =?us-ascii?Q?9ZDA1k2dL6qhYmyFSMj7cIPs0CEKH10Sf9Wfpg/B3m1D0LUyir3ePtAT2GOI?=
 =?us-ascii?Q?cVpIH17Zc2bRzWCiUMtYSKHxSltKCEuT72OR88+q4inwe7UGu6Ge/S4cViVM?=
 =?us-ascii?Q?kh93mqV21tI53laIkjrweAgbnmQwBA3e8DKOBs8Z+Uw/wL1dOh3fF5D05KtD?=
 =?us-ascii?Q?Op8Zh2I/GsN0/EnPBJDFMjlvo9xJvuQ0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkyRroD9xgebbwA1JzQJRr52wdUK6GS7fsLjXyKA1A92P7y2L4bJzN0O2pNK?=
 =?us-ascii?Q?UG8PoxXS9UZ4m/mNwiWIxCZk4jJI3JRLTykKLqKVRMXQ9bVgyBqmMq0nF/DF?=
 =?us-ascii?Q?chxB1dZ0F6SX+Zeqp1tXSi0mH354+B0DsLRuVxJZxtqTzM1TlpM2rm6w4XCW?=
 =?us-ascii?Q?3Y9uzIGXVezGJSEzELSRypX6MI+ckua0P3baaJf0jT+NqOr0s4XQwhPn9wNm?=
 =?us-ascii?Q?UiWPKm2VJucYoOpDroMFnTAbTmO6Ud+INKSMlJpWSaO3VY0iVB3RHp+J3uwt?=
 =?us-ascii?Q?1P9sXaYt4UDaNbb01MbNYBRrbjRWxYXRAflFz/I4pTguWwFOsiBwTeCXx1Hb?=
 =?us-ascii?Q?LDED7PKE2Lt+UHa6mtDilTY7eejZ+MJM+WqmaiRgmmK9eMyT/LhbtBRN6AXJ?=
 =?us-ascii?Q?78EsJi2xq1R6wALBaYbb3PZGFsNtyPUo5eUnNOqW+8LZhi/DoBv45qRAOtqF?=
 =?us-ascii?Q?Y+TbUJh0jbDtQkDfa5W1YsRSNIywe7j4BlY5UQIoFmRY45F7PUlzHlmwgkEq?=
 =?us-ascii?Q?owGHsraHbkGhkRF8m51UEzteuKNAruERwF8yefsKZn4I6h4w45llE2bjqcIW?=
 =?us-ascii?Q?kJrzZJaYp6dMpjao+W9WwQL7vNc42A3JcbrPfEHSlpDO1KHnT0MHL9P+TFOw?=
 =?us-ascii?Q?JDkTH9/cz4vZR+e7hOBB5r6Rx1SNmg1uuPXTreEU7nSnMP3XKvjnuzGOWKB/?=
 =?us-ascii?Q?+E+nqpFp9boG0jBFLkc4O2s6zop1TSJZz2tAla3Ar/uVRijO4TBhFGxtNvyY?=
 =?us-ascii?Q?QRmPvnpSDTrhke0vN5lTmHGDSzPS7rZqFy2iG17KSYz9C6/eU41WAgTbsR/L?=
 =?us-ascii?Q?mQwo0TwPLjD6Tzk5SYK5hwOb5OSs+Oar5sLGVRyJWES9Fx4ruEjRfUlTx0Mv?=
 =?us-ascii?Q?5YJye7aQEgfiB/VBeqbmS888ZpSnJEfkj8MXJ+yZxauD0OI3HtWpaCn9yM27?=
 =?us-ascii?Q?O59KUTWSspkyQUPUhXSq16LezoIcFP3mmiNxHEKH1StLx9yUOxw4I5D9BPrH?=
 =?us-ascii?Q?QxiEVCsBg7LdNiJgjTVrdzES9V3dE1WrUehYWyeXFx45Za2l2V+l2SdVxmhO?=
 =?us-ascii?Q?83yWzMRjywsvmrcIHadmzhlvJuJC8guFp3DUbhp/4IJK2Pb7CsQYqHpuljqx?=
 =?us-ascii?Q?8xyc9lwfVCnsRIynN7kKK8dtexibZtAcDZldHkvxUH0Bjzs+IDkBSjfBmInc?=
 =?us-ascii?Q?agqOfKKUHEZB4EQv7XBr932R5AZ/+ao8Zcg9kepmTcuk6WGuBApK6KciNwNo?=
 =?us-ascii?Q?wPdTdKEDRZdQm+emAwTLpmM3mOzd2c8SVHlVX+sFYeex1IVdoVqMamQS6mjb?=
 =?us-ascii?Q?G8f/FgTW+HuPUgsBe2sJqzNHuMr7jNwJT0Ob63prsJZJc3+qIjULYEBUD+Yl?=
 =?us-ascii?Q?u0JNvQZqFKNWmVvhoLrmjMB38P/x0onM+Jm2iO3YCDP/0UfHbYkCIDfqALZK?=
 =?us-ascii?Q?yeKb3cJQX144YZzFjZlB2xogvI2lcxWUIszsqeaiezkuLwbwdmhAtrebZxRa?=
 =?us-ascii?Q?Ghqws1j4fUPh6mfp6UauNqug+iWE5Mtpat+Tr35BuXfcyYwSCWf8thsIqEFm?=
 =?us-ascii?Q?pswkL5eLyT73ty3udWA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0148989-9d95-4e41-6220-08de2b908036
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 19:34:36.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sFfmOR4uB8jt+Nek49VK30UiBTiN32O9C2CtsSEcbHq3obV9so3akcZA+EcU7Hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153

On Mon, Nov 03, 2025 at 09:27:55AM -0800, Nicolin Chen wrote:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
> or bypass vSTE. Note that device on this attachment won't report vevents.
> 
> Update the uAPI doc accordingly.
> 
> Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> 
> Changelog
> v2
>  * Add Tested-by from Shameer
>  * Skip vmaster allocation instead of bypassing vsid=0
>  * Revise the uAPI doc to note a corner case when CR0.SMMUEN=1
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 ++++++++++++-
>  include/uapi/linux/iommufd.h                        |  9 +++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Will, I will grab this in a few days unless you want it in your tree

Thanks,
Jason
