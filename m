Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBD1B3F32
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656699; cv=fail; b=U844qI0nM8kibOJ1qVTP9MY3wzcJJZ6QEgoqpPpfW+UAzY3ftmE227+ElpAYmVrlj32pKP0RTRhMbuwe6ZilHX1VaFk0/IVlJBvKxn13KknvOrQi1SW60/+k2tTfm1gstX/M+fpozrY92KaC30MhS2lMMjBXB96NAJsyag/VqO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656699; c=relaxed/simple;
	bh=8CsoP++6/Sg/sEM0Yl4afpIb0M/c7MPOhutjVmK7d5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MILoCz90U7oHGg1UdpMHDYRHMVBImyKHe/RCTi0BRcr/kudsfjTfUEp7nfO8UhsfGpwydRsakyMbYu7ygoicBjj32OF95nhnXYgzzjjTnB7p/3pPYx77cJOkXQqYPrZvD2vDRE3cdzD820Yc37qihYxm3XcQgITp8t1LZrmJf8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zrpshojy; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zrpshojy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps299lV0Xyn0selN7MAogO8DfyVjJnSundeJ3BzY6Kl4MCdXZRhUv/qQV2taLowOxDN45iu7m6wgRoDwdaSnfQ/M7xzNBIwF2l8M3pIjNllTfIjT/lxNLtlaNsSm/Ixf3t0Jpfo3x79ZvxipWm+wgmd/896kk2aeZuYP4Lyse31zPzKb71Nir43HsK2G+fzo1MD+wspgkkEtUxfhcjiebtyow5E4NUY4Ws63zf6dggIV61bWo/jD4nfx67IoZXD+Fs+Z+8/hd1P7xfXiCkKZJjL5dH9Xz6hGPfysvBnDItuGNmZlZaJYtDrH1Phy5a7tWAo5QR8sgNAOoxRjZQq/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmwdAe+7AW85mD/DhbZVXSeQP00LKPSzaiT8zK1G0Q8=;
 b=nXN7ohUhyZhGndQ7rg+x9dG//cMWDGd6JXE7bBKBbrJKLH8hlJ7WIIpywp3ThSNhDyyCeN4C+UCrTssdNaWntBJryx0s2IjMI6XAIvxUXLBQ8+A7lfb4bkoF4WZjsdge2ZzRG3asezzSKBiW+tVTgqibHRABVsgjZ+IIq4ED+RUXmx65Jt1dC8ZFiTk8k2uOrhUqmsfrrPlvo08F65mYcs9AIBBh67RXBwwm9JShaycy8UIPCSEe18nlXVcII+bMzlWF4WLUApGLCLXok4Ny+RAKxC62b9GGg5KcX6D4YuaROeZvA7ea0Wg3H7p2ZXje56sWtvlSkY35t6SVdM0trA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmwdAe+7AW85mD/DhbZVXSeQP00LKPSzaiT8zK1G0Q8=;
 b=ZrpshojyADwddOv9kptd/sf0bv4Kr7ExtsO3eYUK1AKqn+SI25908I2iOw1yZSpDbtAhj/TirZoiUrEJPWj1vQs6vRoF8G6ipduyqxTKZHmXUhGxBrxT5Ys/trLvlBtJIBwAHm/Qn8kyf83qXZpr9RHFOpAhBy4dxrjWDRAuj/6/7Et1yy4Vh/CJxHlDVi1Qni2qDu+IFDpg/FdCPAG7Fv+asu+MbT2/LcR2zVGShg9eaoHnvdmVJ17ZNVv7Y4pxvGTJ5bF+OdGoOYDlVCRU3juwgkKDI+bG5arLUdrQCI40nPqXUtxn7mlN0tvlwkN84BORfcX+ZzLQ2cSrG2dCHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24; Wed, 14 Aug
 2024 17:31:30 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 17:31:30 +0000
Date: Wed, 14 Aug 2024 14:31:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 6/9] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
Message-ID: <20240814173129.GW2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <716ac3e9d2564bbc47390160286a9ce1a1d85704.1722993435.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716ac3e9d2564bbc47390160286a9ce1a1d85704.1722993435.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:208:a8::16) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b37edd-5dca-4841-1bf2-08dcbc86ef58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhIpoBH6x0pd5ULt8bgIKwxzNZPDt89C6bAFM+fp3o5yyyCyLY70tNxDjR25?=
 =?us-ascii?Q?kQxNEeI9LeU3iNHuvO23Q9/5bYGTRLuccDornlIrN62/B9EsN7cgYsfFQKA1?=
 =?us-ascii?Q?CkQO6Qidweshxre4ZqTBeuV23XFnUNDQyR/STXpYzdpnj5H8naeIHEkWDuew?=
 =?us-ascii?Q?Z/mI9rtDG1qwUpX4rRw2Fm/fUWfpm0B2YoQeDDH38HF4TIRthkuIlwh7PM0v?=
 =?us-ascii?Q?qYV1kD07mZnwPPXrAko0A2CqE0uWSUxlWtj/TFb0ebcHlrhjknQDy62WZhzx?=
 =?us-ascii?Q?hWWYDXmH3V+zsjIx2k6k0MlvSG/hhlh5PpczXF+UkA9EimFluCuSePPxBZPY?=
 =?us-ascii?Q?Mio9Q91Nxew6wjNjxbiNAUuYgcrAzg2nEprsOIqPE1dE+WVeavYM/93Qo+Je?=
 =?us-ascii?Q?NIhT/GffKL4nr2BEPhn2tXgXOtcZU9BI5GTaX2LYH7jAAfuwBkFgPsdASFn2?=
 =?us-ascii?Q?BEDKsKi6cwAfvJUHsICJGr/0Frj//iao6+nJtbuklhP8uJTQSB1EBRx/tV30?=
 =?us-ascii?Q?Wwfs6cR+unKAGUdJ3o3EqeucrzmreTZbpBm2NOyXeXix+Kqiv5sBIcSsFkvt?=
 =?us-ascii?Q?dEYGabeq8afHLTxU8Kpmb6jk32Dx7AqMQuPjAWjxs472YnK41TuZabjjycR4?=
 =?us-ascii?Q?zDxnLwEeRTffA16WwFPzcOHndwOZS4O5HBCftgBCXYOFi5W/PXX+bXSjfBPh?=
 =?us-ascii?Q?4KvJY5tZwhSoD3JvU8AKj0nneVDG20xZun1jWw7glxlHIsc5cpVocnfNRjtS?=
 =?us-ascii?Q?wSWfFKMP2zoZUA55totb4lYOkq6XHuqpPLaK1ziBtm5UXWKO1ZzbuMwTpzYj?=
 =?us-ascii?Q?BBH35IpQon3R++8ExYlamteIPuKIOy4qMmrY5O5RaeeCKSBzz+7872Lk/wtI?=
 =?us-ascii?Q?6lgWxs2DUoNthnxURLKBKoSrFl2kHGyXPMa5See0h82pMbJ0VKQTFdiFRmgc?=
 =?us-ascii?Q?2HLqJ2f2fUKwAY6v9Qi70TjOydXmeZ5tGjN2IKq4BNOA8vSYl+FHMUBUSc1u?=
 =?us-ascii?Q?v1NhJe6usXGY6ya58ZE4AC6bpE3J2iXb9y5+ZNLMR2k+oXGyxanzHYJb3r4f?=
 =?us-ascii?Q?RMk+R2x3vFS9hWOWkKBd4Kj06k463MXiPvBXOGcAg+iIGf/cR1LJoDQcNu7D?=
 =?us-ascii?Q?U+C/SJ6AB1coooW/Az4D4qvhwy7Lca7pdDzMqzp2eWKM+DqL3twVRaDijLUt?=
 =?us-ascii?Q?peZwJk21j5vfRpnqvPcZ/PIXzpsXGDh3EtRRIZgcBqBgbL/vLXXM4A3lsDyB?=
 =?us-ascii?Q?7vBI8qr5BpW8K/lt4eeS5o+GTAoGH7jsVcYPm56uoaVCMV9OUWTF7Tavgub9?=
 =?us-ascii?Q?wIEaAHHvcS9NhdsJVJMLYRD35YOkkBOh4XLUPkIe8bRLaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTM+zef72LGolgW62YFt35NppU0PRDyDX1K1UbtkQA8PNH8ZoBVb+AgIJIvx?=
 =?us-ascii?Q?F5HqNfQUAr4XoRYJxr59xyBCYNceQI8kD1CVJLa14jOYWOPA9gaHzciGtl99?=
 =?us-ascii?Q?6H3fpy+npmeaO8b4PaxS0ef9pbocqnmLHnDDCAwSSm0bZCV6F1S2ya+NGkcv?=
 =?us-ascii?Q?w8zcy/J1laOGiAPJ6PdiknmDIWk8aGdb3tqBaj411aAkyn4AjvzTqOX3LIK2?=
 =?us-ascii?Q?ScrrJYvJvczRK5gDeFSjZf9Q+HwtN+/B4HzZWPScrT5C/teHJMCrGScKvDkp?=
 =?us-ascii?Q?PQN//ssMyWOmF9Ek/m+fuyV0q7Dw+ppSfmWu/w2sfUac/YGDwafkA27tLoU/?=
 =?us-ascii?Q?STd3Kj3xyp7RiArBZts87mEv62fUu7KEI7ZLJaIuo0qF7gPcURwPNzjW4sQ9?=
 =?us-ascii?Q?+27MXdouMQnRJXofpQ1BdJK9Ja9ayKn8Jk7Ccn5c2clgTt6uU5wyLQ/e0/By?=
 =?us-ascii?Q?4icIfk7MA9HfWeqjVfOF4H0iOBVnZpBCXgirJU5+QijI2WvuC2v+Q8lE8fjS?=
 =?us-ascii?Q?vMsjQPm0wxucghY/SIQ0njnS5Ab1R28P8aE4SRyBiMQvv203V0jkkR3wPiOg?=
 =?us-ascii?Q?k9eNgYHhTeQ32QrDSD8mekGRHPecrSkCPRi0RqPEqsTsplcniMv0STWjrP3s?=
 =?us-ascii?Q?boI93A3Kgyb9kNQ9GNP1ypVj8ZLTM8dIPfJuaa3WSNC7pSh+xhy5MUhyuoe1?=
 =?us-ascii?Q?nhEk3DZq2MGt8E3ry9+eqTSPSm8nZA50BMRKY5EFaGNCog5z4RhnuXCzBz/+?=
 =?us-ascii?Q?0iYDShIOrHbCDy2kOegh6wYa5rldSGJZHnp/GzAqo82GD/Mx5szTDV09/AuZ?=
 =?us-ascii?Q?eAy+peXvdO3imZOmaUe7S0rRzuVF7+bsj9x3h3a3chTXYX63FgNXHgZnu4gd?=
 =?us-ascii?Q?B9ABU4pZdLKikG3de9D56GRVgIvvyAkarqeM3MCB4O7N+7oQsNpJBi+Kw2+d?=
 =?us-ascii?Q?WPRb2HEB5wDECSivu+LY5RLs1KqMcJ4btxl5BmVmHmtud+X/DlbRgTvA4lev?=
 =?us-ascii?Q?wXK3Q+hZ+ApVepKNE+mn7r7rS0NH1AzufMq6h36eR8micpdci6mduhf65f6x?=
 =?us-ascii?Q?IjCqVZjLTfxCxqrTClAmzz+wkZ76Eeat8tiYGLHy71VU+n0btjRviQb3LA8t?=
 =?us-ascii?Q?2+IPdyhenue82nQM3xfQxAHrmtqmT6uo8kxyQ/AM1n63AMiFHLpAL7dItzlP?=
 =?us-ascii?Q?HI3iwJOgGNQl+p4t6Wa8ZZWKU8+aivJ+NCFZc+P3I0EyqZiSkb2aYYBEf+3h?=
 =?us-ascii?Q?DASDhfwqaeGReO+A0VKWpooTc3FMy1FyzRSVErycAysAPUjDS9tjAzZnGKdR?=
 =?us-ascii?Q?wVMYsF7PIZejvjPrltb1Sr+wSw0Xo8F5Fydv1B+hBNY/xBR+hUymwYaXBajG?=
 =?us-ascii?Q?33xqdZmI1YkZ4GQdJ/h15xgOENFFXvQztEdTFigOGxORNeeGmYb4FNWwGMMf?=
 =?us-ascii?Q?kMjLjuZlN6EA0pZG/PboutM4UfqM5/1oy49Wajz7M8zfxzue4SC5tH8DpJiY?=
 =?us-ascii?Q?K0UE2CuL3n6QtKukpkrFo3p3Ze5OeJdvNcTpgTSHmeIGBjQWZpdVemfNrsJu?=
 =?us-ascii?Q?+00W0NavZcpnFtd7XuM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b37edd-5dca-4841-1bf2-08dcbc86ef58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:31:30.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSepRbstKGHnpWQVllUfnnUEdQNbqoTWg+Hng+1MwG0nr1Urh0IBrI6WfiDBFjZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

On Tue, Aug 06, 2024 at 07:11:51PM -0700, Nicolin Chen wrote:
> The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> CS field of CMD_SYNC. Add a new SMMU option to accommodate that.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
