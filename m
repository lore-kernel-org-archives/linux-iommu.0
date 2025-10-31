Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E52FC870
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931808; cv=fail; b=Pef/RoujyvgZqVZRKUjHNal/vpT4+0Y+PfztxjqPS8vtnDkofDl4HQLWqpO4GnQcww+soiKTOsMwAdK/lZ2+ktkwdhbUy8fi7zPZv//qHcyRZgoZAZKYPIJMQ8YEsPGFZDXItuNmakxunPxJOHKKbwjWVt4Vpzqjmf70EFJ0PvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931808; c=relaxed/simple;
	bh=SGhoOTsQ0Rupy76dlXGY1oGwlxnVtz51bx3YQYp4nww=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si5ntt/Q7/y7i8XqFTxRZAL7WNuz5hLljhhBW0mrtxZkHJDpMUuTjXuUTPmthndqQnh8W/Gy0zJU4+oQmwUIkhayBflATVzdRhv4codfG8bfF8p70+qtDvHjmJEzItIiOeECPe3EWqqe1/D1s/woBipUx3p8akmXaONBGrfdmI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmZezopM; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hmZezopM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC+3QZKoVVAC/QtQxS6P3OOPrQeQ9P3Jgf8M4ANFWAxGve1hcrqgOFrqJNhOc+R323qzrfE5VgU2xZVHpmv1RJC8Ijti07aj0wwGbwrGqRBidZD52srbyKI2Y6q/TlPfJpMEN5Ab6Rel0ewlatLQUvO4a91vyWXXqjlInxN2o5Wy8canF+4EBms98oO6FJj1TUW3z2EbP2VPb4XD2U704MJw2m5VTDPvtNkcS8ZWJ2EfzOc6yBwCz4lfbUY2Tkh/3pNotlL8jJlZENzmY20uKc5NJChMmlqi1fZTBe+G1+PxdUAP6zPJwI/zQMQa+DDoK8htx0HQfMTHIdVP77MuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtTuZEIWNEMCJbl+So7JUGDXi3NSnL+8tMRu1lQKjp4=;
 b=XXJujuczCXYzhevbSLRw40cm4FM7SOvBDheSBc0zaRbS1ksN/pxhFCXCwC/GkgInXbBpQHbkOhfAX76pQeSEv7uCD0JYLonfM7vn63l8PvAEqg/6KwkjBKiQ0DN6qsKjO8ASDoRLAvmY6GAmUfrfbI7VPMiPwv6X1lqEtxfXbXQguepdLGgJpu2Uo35a1wQh4iEUiLOjXvCqE55EPPfM76j9hX60MpuV6Y02emgOQwNhJYi42klzXBW2qW4Uchc6Uw/tw+hl+A3g7+e4h/HEYCLaD47s6z/BmcukqfnGv5kQieVIkdFkZES8wLuAQIFWfrUuExphgPA89x04PJZ/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtTuZEIWNEMCJbl+So7JUGDXi3NSnL+8tMRu1lQKjp4=;
 b=hmZezopM8opDRWi5JLxn6AN89FMOdJhiO3LORPf+RQXQ1JDduGkhWlxneb+Yqg8+DMW2XHtSR/t1Cdr7xGYTFJzyLENkmBuWartd+WAe4SZ2MSnoTBwE1oTIkCjTstbUnlOGIlF3VgYxfhEnPsO63+agVmmP4b4EVQSpEKmzb5YI8JCbJj1AlWn+DPOS+L/B183OJc/4e+wYBDL3kA7/JyIWeWDMtVu1oloBHpobYPkCGmlhQQij3XCYgjg7XoNQL9H9wsdblo/ECOLLYpxttbAfVyYfj5p1Yj+Szn1XMXXhCj0VPsDsKyAa2EDhIPOOvQVtQsSsazKytgD1mxV1Kg==
Received: from PH7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:510:339::28)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 17:29:57 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::99) by PH7PR03CA0021.outlook.office365.com
 (2603:10b6:510:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 17:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 31 Oct 2025 17:29:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 10:29:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 10:29:42 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 10:29:42 -0700
Date: Fri, 31 Oct 2025 10:29:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <jgg@ziepe.ca>,
	<linux-tegra@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV
 driver
Message-ID: <aQTyBBF0IoE+pcXW@Asurada-Nvidia>
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031062959.1521704-2-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: df121294-0b4a-498b-b83a-08de18a31c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87QUkYTSV1BlQm29iixkrQtITskdpnO17asnvSIE9uNy4I/Rk6S9NNQPDL7b?=
 =?us-ascii?Q?4hvSjYzfysddubWtIJSUXgucj2NrvBiHO1guF9e+RIju+xmyx8gC7anH5Wiq?=
 =?us-ascii?Q?ovabzwG83nd3bh2d39LRaut2yInKP8XiANigLoevpBTfM1C2EC5FbzgSoTg9?=
 =?us-ascii?Q?KuopGKoj8RH7Odx6lTERdrp0ynIQhAQ4i18D+8C90LcQM0eQ6phjM3NkHx4v?=
 =?us-ascii?Q?v0YnHWKGPxUVhjCf6rPb14zQMRjmnF1FgJK/pWrWz1ShZtN6mmQb3pHoq8Q0?=
 =?us-ascii?Q?iN4Jg39M7VEXEJNznSSaGlUq3PHbbVN8F4ZkDh257f4Sp/tdJ0zxWgPRz1IG?=
 =?us-ascii?Q?tnykYCBezDds4vvG73KtmkRfmacTFwwMPJYOABayQW6GstSx8nnPpA/3reOj?=
 =?us-ascii?Q?/3uLE9KHtYqr/TMyVq8hHvmc9DzSNJYRtGi3ZWJIh+1+tD82/8hXzL8Dh/V9?=
 =?us-ascii?Q?G/CGZESav4wb+QJxKG67H6oBcSVQCyfy/o7ltGFLC8nd4sSSu85QlhlXsI6s?=
 =?us-ascii?Q?iQ7wZvZhW6HN55ZayTluuA2MepabsTWsItloA8DQtA2rbeqdnrH3nS5BUMYb?=
 =?us-ascii?Q?WieyBzF7Nd79i/qSYsxDyCWPHlgzzwn9VmDXGeYuiQuGis0a5kV1NU73vI8V?=
 =?us-ascii?Q?yzJzVjpCDvYDjgI4Jf345CPVopga9SYGlOUgwtWQsPOdTQ+C2V7rvv928jYq?=
 =?us-ascii?Q?wUfMuNVA0c8UqTKIuM0aIwshFSgRXDi7FOgWMcuTvsy61imvQHcdrG5UjEeM?=
 =?us-ascii?Q?pN199vyArsGlknfMOfxtGz+wVHEtSg4HEl9aDeTJGPJgn9/fX2xeFg9ix3SQ?=
 =?us-ascii?Q?m9C1pM4UCL1C23W2s8QQ6JtIn5NO8XOS1KkichUPNJvucx6Nu2piMhfIBWPM?=
 =?us-ascii?Q?ipeO/DXeTdaSD2XmctrTfX2pYy6HFRwEWbMGOcDMUffb55RGnRxs+dUciwvX?=
 =?us-ascii?Q?2Q6kg4Ybclvnseyf3p1nWb+PC6FLRGTFRa6QT+NRgFeoheMLeeInIna0DaIm?=
 =?us-ascii?Q?m5FxkXER85oQ836d5oDE0Rd1mxHQkgC198fWOLin6dHF7eQZrHzzaJSKBRJ0?=
 =?us-ascii?Q?WNcTOmBhpsN2JWiB3Ht5uyjcS765JcqHoyI5QrVJ4Ru/B6nPgANLA2HqB4Ab?=
 =?us-ascii?Q?jGCEUMkSfAZBdzF5DGzfhQ9CZ6RAFO7zjnwyZq+SIOWmhCvHwOLDplgS+kaM?=
 =?us-ascii?Q?65Zj74nN4puquDsU4J8WVFGif4W6SdARjPer1MngG5w0/vME88PHP+zRWAR6?=
 =?us-ascii?Q?LwcX0MOux61DSHeObZfzdPjA5G01OnW70b+yx6BgmX5YYHqsWXqwsxEiMSSl?=
 =?us-ascii?Q?yTK/uVrWjjccLsXVA5GH4/1WRDHxNmxOqduqWrgQGntwXY5JV+0ZVMFwTEqM?=
 =?us-ascii?Q?LCAGvhprbNzqPc85TBEhecBRANos8SfW+q6mOt66663Ox7upTvR6GsYvV+X0?=
 =?us-ascii?Q?+XoQyoEoQAfHhCvoSbCNTGdOuLfZMa6ifSeFLllVYmTPjRIMRB2LdeZJ7Jz6?=
 =?us-ascii?Q?a747gIOkRsdTn/JFkApN6GVconpo7PmIcXPraSPArFEzf0jDo1BwA2ZsYjmw?=
 =?us-ascii?Q?FH55K8EevlbAMZFz0mo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 17:29:57.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df121294-0b4a-498b-b83a-08de18a31c9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

On Fri, Oct 31, 2025 at 06:29:57AM +0000, Ashish Mhetre wrote:
> Add device tree support to the CMDQV driver to enable usage on Tegra264
> SoCs. The implementation mirrors the existing ACPI probe path, parsing
> the nvidia,cmdqv phandle from the SMMU device tree node to associate
> each SMMU with its corresponding CMDQV instance.
> 
> Remove the ACPI dependency from Kconfig as the driver now supports both
> ACPI and device tree initialization through conditional compilation.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With two nits:

> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
> index ef42bbe07dbe..5fac08b89dee 100644
> --- a/drivers/iommu/arm/Kconfig
> +++ b/drivers/iommu/arm/Kconfig
> @@ -121,7 +121,6 @@ config ARM_SMMU_V3_KUNIT_TEST
>  
>  config TEGRA241_CMDQV
>  	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
> -	depends on ACPI

Perhaps:
depends on OF || ACPI

and update the commit message.

> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
> +	if (!np)
> +		return;
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return;
> +
> +	smmu->impl_dev = &pdev->dev;
> +	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> +	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> +			dev_name(smmu->impl_dev));

	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
		 dev_name(smmu->impl_dev));

Nicolin
