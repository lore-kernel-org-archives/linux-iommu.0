Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83394CB4B
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711951; cv=fail; b=eRkOIfhFfQ2CHEJWslwE4m6n7GX6sOZ2InGV7OA6bf337TekZ8YO+x3wL7qkza6V29M/+G4NM9NLlAEkZdHOAQTzFd2GQEMcyNijiNlJd8UGA7roENwGiUc5uEAs8ZkSvHntKmYKZrlfQ/VDAYthIjx85Efi4rzUdObZ8llVOrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711951; c=relaxed/simple;
	bh=6lXsDg+Qjuhc5N5EJUDF7ZZe0BUg1wprAh9KN9j2Xdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bub1ieMC644+M044a8HlNqtPPGFixcfNwWwoVYv2725/e/OPBWytSOe8e5x+WewKDGMTsv7Dg6cPpnKFVc36/HZxEcOE/5zMLgE17LT6UKaErC7cLZPrjcUApmO7HGABv9wh6us058LnbI5vOFrBEn3EsjbEJsyfbXGJoR7TvnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIdZ5r+a; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIdZ5r+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W438tEAiwzahLR5YJ5fR7FiRs86uJ6AiLQznvRV+dBdXDVmMbq4KOmKZ3zYbMTGaBU5acYtE5XWdkG1U0pQFIAsUJn9jgpYsUm5SH867a/vv3Na0zXMuvCz5hGFjU7OudA0C4Qjsu+YlO5VgGKJiqV28HFzuQtV2T+ZY2kC6vwPb2UHDDbW7SCn39kRriBvlnKvpFHWyJDNUh7Gaz22UCK19oDlkNRYvE+rDb5w7Ndnl5qWwNeVc5vaUw1DWzzac/6UdXR5ifSrRvGqwEz6wxxuJrMaiOqkfTp9zwo64nSDhWJ8KC/8AdQ04VHa1ohndwu7MIr+BIhrKkviG0e/I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw29+aettHXzMaNprdiIZIvtLTA+EwT3VlrGCyQzqPo=;
 b=lDKQcim9K12+YNmXAxhGLBUkc416ztGNl9E8GPvHTLUK/7zfyMdK7UWhQUni5w3eYjkwM+gKKM6DjwbvrXAp6t2aFl6D0IjkWlWxLAxuZ6gcwX+VwZdtocOCK1/av+yqPe+2a4A2mVBpCFxk5IftaeoKUcNNvJsksvUyReipaxqiHH2MXt4CiUfwFKoJAsZZxejKUqzf1ea982Ael/ILkfpLubJZp7fjFgL+bQHDU3SYJMzbsjz8QmypYNFOAf6UsnwcJuP/g2JGoJ8+gy0TACkib2q4RoD644A0C9wU7uqlUsbT7Pyx7GZ4tPO8ZMyr1hBBa0QrwGltpnY4vFU6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw29+aettHXzMaNprdiIZIvtLTA+EwT3VlrGCyQzqPo=;
 b=tIdZ5r+aWuC/l83Ijnisd5WsfL9sOEWlbtzGKrlR4ynk2kKN705jSK8V9Cta3SKFBM4au9YU6fBbUSFaYrvC4wKygwoz6DAB5xsvCkbDyL3JPCvLa4RPNWX/8/RUmjdv12LUghwZMjmdKsmQik6UVNiHRjNf4QRE1IH5mbUu6wugA2rE3xYdCxkbfAa16QAfz7jDcRr/4s/JwJYX44viIW+jEqM2EdiHt9DfYSs0r6IB1bWmIEplzfGElagSvz3UA4iZxQhtdyMo2Z3z/Hq1Y1Mfyzd/SHV/MDPslz1yiGX465971v0v8DAIxevSSCHLFCGDKL+JFi5suT6/zOIEgA==
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 22:12:23 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::47) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 22:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 22:12:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 15:12:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 15:12:04 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 15:12:03 -0700
Date: Thu, 6 Jun 2024 15:12:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 1/6] iommu/arm-smmu-v3: Factor out a common domain
 alloc
Message-ID: <ZmI0MlzgRNd0T3EN@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-2-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-2-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7ef019-722f-4412-a6b4-08dc8675bd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjBBLEOyIDMahRSU2EuEGgt5kEzsTowRgd43a5sRQJQOOaR1tfMk7G/EiRSR?=
 =?us-ascii?Q?o07BvGfgU6IKkWRySKWCKR6i37CYj/rFiTxOGw+F6oyvhrNRzsVK6nGws8JH?=
 =?us-ascii?Q?xncaWD4PODIY8e5TWP/64iqxChPet8gWsdtVkR+DH6VsVhz76y42FtaQ40HA?=
 =?us-ascii?Q?uYjJqBDF8vX6htZdrxKT30CXz+ocC5Qdv5IKYar0U3CEJ7sllAh2Lcyg4SUb?=
 =?us-ascii?Q?g9rXihN5ZS3eiBP3yEiCJMKMwMUJsV5Bw7q0/eO1PPDQtUaznwcfhjlnVftk?=
 =?us-ascii?Q?hLeV58xYICUseswMKG13ytQeeTmhuOV8hqGOKY7GVx3szWiPN5QOr/wDkAm4?=
 =?us-ascii?Q?OZYdqNjxZfnnXsC363kVnpPb3MTRx/6Ft6GH3M6ltZmQuWo0rOBlz5JTMslS?=
 =?us-ascii?Q?PogRvI8JGD7AVH49hn+I720e8FLVbqgqe7+IxTP8ih6aF5ruDE6UQEkmQ3LU?=
 =?us-ascii?Q?/GDOQPY47EjarcG8rvws09a2ik5eEVcEj+4FCWOLSjQjuCGmeeOAXB1BzKlY?=
 =?us-ascii?Q?WFhzax9mrwb4KUPYXCXHJELLNg0S1PeHKgf1xwU3hRAgS3l0507RJuplmJ5x?=
 =?us-ascii?Q?1vAknwmjnJumon/MbME89E/yhiRA6AURnj07ftxb4zrQfh3sr/2U06IOQPay?=
 =?us-ascii?Q?yIsobFo8PL65SEuJqbNKaMkmzhFZZDDruYufhGF83+Q6hpJG9+5Xlj2lYi26?=
 =?us-ascii?Q?q9XF5I8vWtJGWpL4vqJTftDYL5bv/XqQv4jUv2HHwLqhoUKmZvnW1zNTTEb3?=
 =?us-ascii?Q?sA74EM8isZJumvQvkTqlLlmR1QQukLL8FOVInCwkPB8JVh4aXbxC2SLutSBx?=
 =?us-ascii?Q?avW9IrU80K0T1OvPu8gwQPHafS0SMcATZuKTt5bJ23cMy72K6xATv6VliivI?=
 =?us-ascii?Q?OUQql1asVoz9Hom3XGECS/BdgvYIdtiVRsKrh4/FJzzK6IzIObN3yGzsnD1M?=
 =?us-ascii?Q?F6kBTcTVv35oqDorg/vShjRHxK75fOk+8yJPmOixyn3/U3vwBYg8nNrXQ8QR?=
 =?us-ascii?Q?p2w524IJxSbFbFdl26X9tbZcxS5YTzw3yYWpCQwYhn/qFr7Me5UPsDerz+p+?=
 =?us-ascii?Q?Bifs2nf734XNRwAo7vvjIVjEApH7uKAgBT2rCS7pY767IXdv5iEn2B/7w+KO?=
 =?us-ascii?Q?bmTATxpvKNpCbiuKFMYMvlNDRK7a4FZ83ILwD4OyDzyBf0+19wQ4fE+/1y0S?=
 =?us-ascii?Q?r621/fBvnBsLU/8wL9novJ6UiYwU9wGRnwvO0LCVHfNa/4vXhnoVAcmzKpOJ?=
 =?us-ascii?Q?eBedr9PCf4Hv1s56hbqWtRH7JDBFI8DF/tfAv9KV9b+z4UZhnALL9VbaASdO?=
 =?us-ascii?Q?THEoZp3t36l2mxyMQemcqZfJu9guqmMePgDHxHSvrr0mtYAZZ7hlXW2tQzVe?=
 =?us-ascii?Q?0/cUvuo5aMFXMuvq8u6e+kcM6YvWe4XeEEhOZGvVdhPA2qdheg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 22:12:22.3014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7ef019-722f-4412-a6b4-08dc8675bd4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

On Thu, Jun 06, 2024 at 02:32:57PM +0100, Shameer Kolothum wrote:
> And use that for arm_smmu_domain_alloc_paging(). This will be useful
> in a subsequent patch as well where we introduce support for
> domain_alloc_user().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Though it'd be probably nicer to have a line of justification
for the renaming below:

> @@ -2276,7 +2287,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>         return &smmu_domain->domain;
>  }
> 
> -static void arm_smmu_domain_free(struct iommu_domain *domain)
> +static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  {
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
> @@ -3119,7 +3130,7 @@ static struct iommu_ops arm_smmu_ops = {
>                 .iotlb_sync             = arm_smmu_iotlb_sync,
>                 .iova_to_phys           = arm_smmu_iova_to_phys,
>                 .enable_nesting         = arm_smmu_enable_nesting,
> -               .free                   = arm_smmu_domain_free,
> +               .free                   = arm_smmu_domain_free_paging,

Thanks
Nicolin
