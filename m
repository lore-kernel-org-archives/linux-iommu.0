Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7413C3F6
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717169; cv=fail; b=q57H2DWQByrLcYDd6YjQ26HLeDBcZOgU1HSOdl1lh2Kd5fXvhu3sBhAdi8wBvOUq2QDD3yyDqLkKrlJMOm3Jaex8rEpwrkn/BG9xqnhpZOoSKtDGxed/T4JMwu4WTZ0y6okUCglGQWuVba6uYs06pVuKbJu4EccQ0mqODV+JflE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717169; c=relaxed/simple;
	bh=P7ViN2EQE9LqdIeCW2WJ3McAPb82BqJqBPK+N4bCJk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KriflKfOw7msxGXNBv2GheHSWc0JxZ6SCzyKPpbpI+emGqPiCcwqGQ5o0rL150Im+qr0cVFVC1c4Vuf8bW+ZQ82JCZ1ysvem+GPRYEqCZ01GlgxRvf21oEPb5oHo3OCM3H0/aJx/bSy4wwRWA+HL37LkUjBXRLMnEVn0ifbvFDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bsg+yWUz; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bsg+yWUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blp64ggqMBSDniMaGS3kWRcjG9f/HF0E3oZTbBIwRlKZEl40FpUOnPVlm3RBjXRx0xCXkrNIsXM3ZIERorFFxxbQz9Xgth2jocguP8Mf7tDAeNMXGIslliHTv4ByxYqxJqGL3NfO0Nwrqzj8u8gWI1+SJz/XzxSvdpaUnYnalLWSuheeJLp+D+GaYWF7RGlCPZ2XCWuE2ysCQ+eciODro84I2XNLeoV0QXzKqSl6QzjOC2tBsZSBYhxaM/elzcsPDKjgDn82Km2rZktdkx1SH2jDXiyAyQnh8tEP125Ly16Y1cZOj+mzDPs3NUEGNnMFcnPmuojbPOFDWzGfW3kjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysF7oq58/XiAk2S8GpiOMu+bUR/wDAf+JODJyxDMPn4=;
 b=egwh5ySBS5767neLxoAIcotm2TozHRzj+j9KQYzzUqSkeEVjcDuzrEslsW44pMg8lWqTO5Zlh8Tuc8YvIMlTcYVWeHgQiTeSgafiWTMEd9myKSuSrvg7ku0/61g9/QH5PdFDaMQkYreAQJJHb2h6bkm8ELm0Oi/L5DaE0G2eG1yNkEiShU/tKNcOY41E6QTicK2ge7jyHWNLaqk6FETtP3135/EjKUYlPkv2XEmpfqPPWc7fiXhGxK2fklfv93ewBOMz6hHWl9uLCMELmgH2bNfvQSxkQge0I/j7othAsiw2WjK2ntpObLtkEAwGbbpXvuNwC3GWfV4ih/OH/b0HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysF7oq58/XiAk2S8GpiOMu+bUR/wDAf+JODJyxDMPn4=;
 b=Bsg+yWUz5qJjUVZZSU86bHiOIZCuZjuO1s/l6f1Ixc8/3eZIDYqxEvtB+Cf0DoQxmspJvH0jcFrun9vzB1AYYpk+RslBtNpnR5aM7YVrwoMk5DOilhNRpOzAS4whqwGmwRqsrqyREwSue3HPE1lIFo858ciiFe5vOywG6/AoqCe1sUGwEcbFDT+svu1KkREiAu/MUUI/68gAmOEIH5yAt1UNb5OHxd53NxMGDh1LMySWu03Q6GfK+7+pWDIX6WCYSXzD/2RwU5NdIx2FUqxIxfbxwbDybZUQUdfAMmnfRbTUcv9H0QrXIlsvhnEaWhKHPlHpjvH5Y6XNwbs8CddI3g==
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 23:39:25 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::e3) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 23:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 23:39:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 16:39:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 16:39:21 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 16:39:20 -0700
Date: Thu, 6 Jun 2024 16:39:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 5/6] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <ZmJIpuSMnUpOiJ5Y@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-6-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-6-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 79585e6c-c9b7-4ddc-65c3-08dc8681e61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5ue4lxKCzNJfQrMhesATEL/q4rkOjqkSVvLV6DN97QuSjpvcP5lOB3kbSVi?=
 =?us-ascii?Q?ksRt4EtUCjPWPN0DPlryTxzbbBQDdLiy0JL72NrkPuIojB6xLcGWSKp2nD0B?=
 =?us-ascii?Q?nbXkMHpN4Ykz8g4MEarBk+2VkChPwvqZ2+52mIHRivrHArkv5CPdG4fuK8wX?=
 =?us-ascii?Q?LovyyAUdMFpoOGeI6l4i6zTym9FW9u78lT5rOeSKjyuIFGwTq0NU7Gm2G0Ma?=
 =?us-ascii?Q?lqnDQ7/Z/Y2YpUfgY3uG/WL/4wVIRJnqxxyBO4ICMRTsEVag3NKC9fewIBCn?=
 =?us-ascii?Q?XGlW9nGWfV0FpiaySfJNYJ3dXXjTPss1PHBea28vitEFrjO7GEs5uRSxdi6C?=
 =?us-ascii?Q?qdJvZ9rXMOY6sr/AlOYGeT1Jea/zaFXs2m1M+BRBw1ayGJQ7qRHzy6rLoL1a?=
 =?us-ascii?Q?FeWn4D+43+pUvbEO6SxS0+w8nYETkSQkLxpwJ9ZNdPwJ2+9NpuMYcksh5cB/?=
 =?us-ascii?Q?T/mQlmo7pnmwykaFm9IcI2do+YGtPFUYnctr1Vof51sb6eYwpEgE5c2uoHwq?=
 =?us-ascii?Q?iSTJHb7wBWtZ9lKojMNXkqGFGHvNaVK9ZBWzH5fjHV+umdjKg1qckrwsDevd?=
 =?us-ascii?Q?RKNEemMbiLRPDtpn7ctyhK/qPzbFQovt6BdVMJZr/3weWb0e5L0jZ3gOrcgA?=
 =?us-ascii?Q?mRv8lRugZNXSH9Cx4RmPSGsYvx7N+zWy1rs9MkYB7II57pH1j8YC7BaQQomI?=
 =?us-ascii?Q?To3cgTf50KJ4dombQ5gzWhy50qD3Z9q+3/w7V9ZF93ZcZnUvBXNplWNYVUbU?=
 =?us-ascii?Q?U5MTkUTNccUhiOQHT/6vDxgLJXlLucPgLgogMgGxFaClbCV4ETOIAt4r+ukh?=
 =?us-ascii?Q?jYXW82Zh3h0BuAdc+/Ly4Xt4kqpq8eYC56Kt5p7zbuKqBzBdEGxqoHgllIjf?=
 =?us-ascii?Q?ZTuu/bpL7/D0uYJHhl6a6JPgIrS77kPN3WX3fH+hq963D6OqTyj0/52iqHhC?=
 =?us-ascii?Q?7DS1GAHTikeyuPG/nuHNXfNwU5jUTGXBAwSI8eueP9J73qEhuDTFofNsTBL1?=
 =?us-ascii?Q?9E11nqK0vfTAQsLl2TMmd9e/alc8CztHTAqGKGpoV2Ve+SQTtayyER8Oxe5S?=
 =?us-ascii?Q?kbbRocl13cBCBJq/24beNOKicgR/PBAZm9/XIL99K0YdknGYMHs3yKr2gD9M?=
 =?us-ascii?Q?jgcZC1tswfPR+Cd0fUGQyPqQpN+tPQsGwl7D8D7rNRk7Wz28mUsI6NfK1Gf1?=
 =?us-ascii?Q?ezKskXoZ6ROTTTzOxKdoUFxP0l3z9DdDn6R+7ByvyLLzjFDJeAJFaZKx01CD?=
 =?us-ascii?Q?nfptxuUpiamiMuIoExJ+Ps8O3d3/xAPvlgOCftqt4bBx16IT4GKB1xPhd33p?=
 =?us-ascii?Q?f0cI4Jp6yjR8KUWFlMJ+Kpawepo6P5/qZHq40UqLkYxCYY8Xgv823cswTH5K?=
 =?us-ascii?Q?HWUfQ6L9zsOE4QQ0RaCIFJCkT09Aaf9X4B0O57okPuYREHX/QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:39:24.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79585e6c-c9b7-4ddc-65c3-08dc8681e61c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

On Thu, Jun 06, 2024 at 02:33:01PM +0100, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This provides all the infrastructure to enable dirty tracking if the
> hardware has the capability and domain alloc request for it.
> 
> Also, add a device_iommu_capable() check in iommufd core for
> IOMMU_CAP_DIRTY_TRACKING before we request a user domain with dirty
> tracking support.
> 
> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
> as it will finally be enabled in a subsequent patch.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -92,6 +94,8 @@ struct io_pgtable_cfg {
>         #define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT       BIT(4)
>         #define IO_PGTABLE_QUIRK_ARM_TTBR1              BIT(5)
>         #define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA         BIT(6)
> +       #define IO_PGTABLE_QUIRK_ARM_HD                 BIT(7)
> +
>         unsigned long                   quirks;

Doesn't seem to be necessary to add a blank line though

Nicolin
