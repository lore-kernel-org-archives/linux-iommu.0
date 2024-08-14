Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5613C684
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672680; cv=fail; b=C6lp8BvBNiStG9DQAlF7jEn5gEpcAcL/r1epNS4bTApfYCOSWoIIVp51BGAlINLiJjiPs/UA0FvDJ/wpn469B4ti+w9ptUGhLxXhxrRNMAE1G+9x6HJQuwPslv+Hamxe/qywktFlJTAQ7uEnm9V7zOcdo0zwdMvBUpF6EYvDNIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672680; c=relaxed/simple;
	bh=xWD4Et2DtwvNA921et7/F9Q7aA6bQtCLu+jzZTl8hNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djT1rb329mQqwbkNUVcSBuA6u3tsIHZIqytDw+60LsLx7Gk86s/HKYZLYj97luP/QGumhrERp4jPzJJE1nFx67Ce9fiy90C6Wyg5hxyca3vsSrE+Mh3RTzPPTueVlbqBJodasnk+OZ4Os3dsEzV5dYNyxYd8zsU3SyWf9Wh7NMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVsX5gNk; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVsX5gNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA+g2xOqworpG1lko4N4Y1SdudDKX4VgyyhG0S2awx3Ruc83HgMpCCupMtpuIoNKz6zYJ/zDw0iapGDdJjO1n6yVRRlMwYVBZjBHtPMYLHovl+QliGz5zCdwRnsC6cj5d2vczqO72F8yRT8u45l5M0cO0DbPd7rya+DbLjfL0h7iP4ZKAQsApRVyCDyZ7yMfT3x3A96BA8z/ZJnQt7Wy6R1z0i7WFNN7lNWxd5ARUQcNyPKMTMXpHVa0Svp8mW3J2JmZYcZ8odpH3OKLig195jySVfAlM7IzSAnB56sngTq0nQTT5zG/MTXaFQ/7vlnjkSyLURYEKArW9mbKYTDiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBpORGO059sJYQ/p+IcpgP66b1WHpZaEs3+aaLksUp0=;
 b=Gsob+XW/cZlSBlYFWh+go11cZ5PbFM+nFn16lk2kQzFxN8nTVhj/43DMsURI9hsm5oA+g4hd82/F7DkGQRFaF/mcQDcIqinDz2opQnKy+bFwdtFuSn/Mw7/Rl6Ye+YZ7ipamf7qNhqIsdC9zFMMhtJ+yYQqRWWJUo3UngKEC4Zq0urBVnhw7mgqqNXB6TfxxglVx82fvjUwdWEJkTTzT0l/LACGz7T1uMZBmDC7MS9lvkWB+psl4uVA2rd8GzpXcA+I/TXUNqxBgWQn3ha/vKvkRoybZKQXPsYTuZi7lkwvSfo0o1taZxSam9TKxXJYyt1HVqaJoWSCqyhMDQpzqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBpORGO059sJYQ/p+IcpgP66b1WHpZaEs3+aaLksUp0=;
 b=aVsX5gNk9R+Jmn+wm7J42RexdJMlAB13MOVctuEIU5exW0Qi/iPZKkpcUxPNwymzzU0se3LbWmKKspBszWf/j6Fr6UNi/vQqoPpvRT98CFwc2MGGMOVL7FQ9pKZOzJlTVXzP+Wfep2tOtsMpNKKFrWB+Q0tnSpaQaSWHF1T8PCDoX4V5Jq03LNcLwSkH0N7hwtQSAJXDCl8r2yY7EGWsTBym7jeWmCNOznb5d3rwIR5Lz2HSHRHDtDDt3CrxswCkROZVHYACJ18+3QCKIZ2VHQOQVJhU4KwfRmn/F+deKFTbkqFukfX3zJTfrAOF9j/JmNRmtzUMp/pjZcY/aiTCKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 21:57:55 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 21:57:55 +0000
Date: Wed, 14 Aug 2024 18:57:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240814215753.GY2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 4187fcc8-1b44-4759-8f47-08dcbcac2709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	i9Exc+SQ6tyEfYT2a3icCKAjQePUKej4PoY0Ioih++4kwBGzsgTNIlZqmJT/5feFQ6IYUJ3fk4JsWSis5Xa5RXMvBrAyAfkwStsmAcT1jwPUcRYkbT7Z24acThP1fMl6VuokrZtSYcTpxYChvoq8CuTH2QkyrhZjz74FQYTI/R93v+tFtq4io7f7mhli/BbAHyu6spkwnyZdcmAnQ/ZI1WVnaRVIAg9abrTqHDpDUwnQaM7TMogYAcpCSGTG+jtRdIk7NG4ZsV3WBBUizFLDa6gX9nIYyN3E4k15F1sh3r8EP0i8T62opFAb0bfR8pZ3R3L1L5VlfoTXeBcicHJDgEmxIUGEz+GLAjwX6vhUupyqVoHHyesPrBVlZjpe4I2r4ixOqsWe3JnkSAbvUGVpIuMY79YQveGu3U5Lb7r3hBrk75JY06AnP+yLgVL7dwZYhZwuLUQdFN9Vm46E4jZE7bm3dP1eF3wCaGOfL4B0SJKxpcpX8eGjFKgUMs7HSg2OZMSHPamsJL8dExpaWIM1oaKsoB9MdrAm2x/GY7DdvNvmPHMv0xYJAIaASbntDbbr2rNmNr/dzl6YhDa1Rco9rHToYqrck5omXLF4DpwJzIo1AQUv/s6ONQ3F7c5eHVbLUyU6Fnyd0BzRaA+i0H4K6/2BxlueMzBViZ4+XqNpTKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtsShvxoiPlOFFjOvt59O+3RMsSgAwPHZg4hloxghep/y/nRKaEa5N6fonek?=
 =?us-ascii?Q?W6QfAjy6wZiOuViYw9/NCezSnrj3sJbivA+zv9igBWdfDHka2UzZhkprwGmX?=
 =?us-ascii?Q?Ugz+GeBsr1aQPvVYLHW6krradO/ZDiL+XinJDULSU2W8tAkqvdCIwibcUnr3?=
 =?us-ascii?Q?TsHoZ/iEJ0ITn7XQBKy9CX+D0aH3r/Y7RR5YN0lzJ977XoHzAQ07JasPQl/1?=
 =?us-ascii?Q?kA1GJDeulhY/U94+tUFK3Unt5UQ2C/Dv42ShQxDiVDyEtikHnDRKSxbwean9?=
 =?us-ascii?Q?gp3BijQfQ22tm2DMOjJ8MC2dJwAh4guYCaTYJ2DkRSFfAKm7wJDK1wYjb62+?=
 =?us-ascii?Q?P5UdWWUYH6xWYmPomKaYhd6gi2SmET0C+1p9+CwggfDlNu5TLLD1cb6XKojc?=
 =?us-ascii?Q?qlmtWV4UOYoS6dST5nTXGIEkFXrQxWjaYHjOCEu8ZD8KNV6ZHholYeNEd330?=
 =?us-ascii?Q?upiPzIYfrCGAn5TJYZ/oiZPgyXCvqWpgDVqFaPdIisoVHpruhxD7hzOC7UPc?=
 =?us-ascii?Q?9p2HSAtqui3a7fVVpbtHiDeR18RXFcojl1SDVSA3xHtJldF4UVvSuSo/BuS6?=
 =?us-ascii?Q?jUvFkAptQV5hWDzVPbO93Eea0RhVtVbtRLlhdv8vzT6vhrMYfaEjqYWfEcbu?=
 =?us-ascii?Q?6RieRsuKg3neQpP5y3nTvQMZUrPxRkhxPp6IhVCArNr+2Dj9lFLF/YJNX9WE?=
 =?us-ascii?Q?0fLszhyC3GgV6Dba3sUbdoNQh0y7n7jMcnIzXgHTQMDTKtOt8XnDhzYe3MPC?=
 =?us-ascii?Q?5oYCWelDPWGKRvSLtzw3juTCgNnh6390ZbmoNNS9B24p5pmjx9xXlryxVcO4?=
 =?us-ascii?Q?SphM6qBKfBK2Ib84s4wSYE6HQHLfZ2r1mNJK88Lzu7q4ElEf3ji2X85sQ6x7?=
 =?us-ascii?Q?sfQRgNpsmjdnTrC0ycJElvyA8Ojh3VvPnuey6c+qtkm6NunMZ7SZVWw3afSK?=
 =?us-ascii?Q?GRvHAxoB6llCCJN/SViYOd7Mkq4j8tECB2xy2SdhisXR7OzWloSknQ+Ygbr7?=
 =?us-ascii?Q?J2ar6vDS1XzYlfV58kR4SdaWyYfyFyB2qYwWWaRlPvI+FrdU59p07dZexsrX?=
 =?us-ascii?Q?HYyJj7YXqRQlANE3XUTDYG3HWoKANUSZiCGsKPmKXAPb3dT53k+ZrTsd6ryJ?=
 =?us-ascii?Q?/Otb0ZVjR7xGCqqM3FL5HbmeJI8nZqDcjbkDRoF1SnwQSPAWSe0g+xQD83/q?=
 =?us-ascii?Q?3iSDFBCavtidc2vXKZePY8PK3NGg2hBFJ/5/EmalJx53VVS2wsvzSPkI+gpK?=
 =?us-ascii?Q?EvCWJVCd/89w1AC5U/JxWkPXwH3eavnCTezgZvnsl/udV1klRAmKr2wjBX9I?=
 =?us-ascii?Q?71TqgdfX5SDYtN+7CU1bvCTk0l4Rly/XsfTB+jaCXwho0vJOMVtcaLFgoZbr?=
 =?us-ascii?Q?5/5qfbOR8eAz359oK0sZw27huKeAqG2OIS3CSFP7aV9gs5dv64OSAPg1Uanm?=
 =?us-ascii?Q?0Tfd0WBlSMMTcVIkS8UI6yOqIry4yt9g5DGy+eofS6PePBET7GCepc5JQy+w?=
 =?us-ascii?Q?eRZMD/bcTlFY/jof+iJ47sXTV421EZbssGn24/bW0Umz1M81Nd5hN2Q30TkF?=
 =?us-ascii?Q?BagpsIK6S7m4aYpZ5gM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4187fcc8-1b44-4759-8f47-08dcbcac2709
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:57:55.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5uuFmJmC4bxj4+Ps40a5gOwuYFtIm7SKQONq/Y+14LbChfzN96nVcb66SZoq+yJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

On Tue, Aug 06, 2024 at 07:11:53PM -0700, Nicolin Chen wrote:

> +static struct arm_smmu_device *
> +tegra241_cmdqv_probe(struct arm_smmu_device *smmu,
> +		     struct resource *res, int irq)
> +{
> +	struct tegra241_cmdqv *cmdqv = NULL;
> +	struct tegra241_vintf *vintf;
> +	void __iomem *base;
> +	u32 regval;
> +	int lidx;
> +	int ret;
> +
> +	base = ioremap(res->start, resource_size(res));
> +	if (IS_ERR(base)) {
> +		dev_err(smmu->dev, "failed to ioremap: %ld\n", PTR_ERR(base));
> +		goto iounmap;
> +	}
> +
> +	regval = readl(base + TEGRA241_CMDQV_CONFIG);
> +	if (disable_cmdqv) {
> +		dev_info(smmu->dev, "Detected disable_cmdqv=true\n");
> +		writel(regval & ~CMDQV_EN, base + TEGRA241_CMDQV_CONFIG);
> +		goto iounmap;
> +	}
> +
> +	cmdqv = devm_krealloc(smmu->dev, smmu, sizeof(*cmdqv), GFP_KERNEL);
> +	if (!cmdqv)
> +		goto iounmap;
> +	smmu = &cmdqv->smmu;

Should stick a:

static_assert(offsetof(struct tegra241_cmdqv,smmu) == 0);

In here. The copy inside the krealloc won't work otherwise.

But this still seems Ok to me with the new ops

Jason
