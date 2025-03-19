Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2123A0
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359838; cv=fail; b=LbUgSIM54ZpSPYtMpZd37U8g+6He6vdPDmaHxPfOdrnV+KdPIc8AZ1spZCF2PGuNSZF1tpAELQLvEMLtg8E01GrnXizl6M6/GtZbQi24U7OLQ36dIB2ikmNRuJK5bQiwbhZ3CAQW6Iq19lvsUnXJ26mfDcE1LTLbc2PKJ7KVGNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359838; c=relaxed/simple;
	bh=wprDvkQKcLof2nr7kFgMko441VsU1CrEGOrQ5mWfmAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZOaQX+ci3DkvHFvpdrUOe0yJ5LlAT1mL1BkVMNVbwVj8WrlFqkKyWd5AVvlAqK5yFLAsTxQFdKA5kCi/4ZqOcM9+h54oZNnq0OBatHTq16p7iUcEIPzRID10xTmgXZqyqEzzLf3RZXhN53H55LwJ7nmgE56e6jLmRoTm2bl0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5iUmYQs; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5iUmYQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXxkNZfDSFe58WKKAUy7kJ5hS7ulTWzjDd4mUPdMm55EzfQR5PxohSpkOh/sJC9V8NE4ZiYhpKDaX9J5TY1+FW7cud0/yjLq4cCRXPcw2hp7M2yNHi9JbOnAS5f9Xh2Mfu0l97Q0UCMCnIv9MPfq5E1THnY1zRBHv4ZWjFoyQ6jBSAmujXZs42eTk+p/s+3rOyf6j0Ojl1Ztwp07uwwyWuHSmGyBGJfxHgMkdQAAx/HOt9reaMFHybFI9P36pwX5Fkq4Bhh0PxEwyP9WimIrbAE3LpAGQL9Gqp2BPXtkBU4KlqxMcOXVPt4f+WGTgaiG2lviz0SGql+qMfomiXtNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPOzpanjFT/Hq6LfP2fYYzaS6Wt79ZWdBGJ2psMOhk0=;
 b=n4HvfD96DFRbusCVDV8x5Kj89Rl63Jdb8Yqjo0hK8EBX9Db19NuphmTvqRHfALNq/Cdm1NSO+Xn6VXe4xd3tuoAUpfp6lxiMngj1Yb9hs7oPCt+RABqdadI98JdQEvX18K4iytTjqPkfyz5BA+BUPJE6l4i/8lRb1HQargOblQLkswUKVYtEWQ8l0hhq9j7aBgV2zWn0ovUifggGhmWLZ2zqp8eNiza7Q21JXAj8+3CJSCzI5P/Rs0NEP282Cd6sNse72yCKyMmS9CHw60/MWxCWYqLR32nXZ/BQxgqqmxkgKKCrqfYXr8ZnjWFf4/3/sPnUKfOkJX9aMOMxYhE7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPOzpanjFT/Hq6LfP2fYYzaS6Wt79ZWdBGJ2psMOhk0=;
 b=O5iUmYQs0v+NFHgxsA9oFUwdKmc7U0h51KpAuYOBkUxOoFQDAd9B0CBEPTyKnVgZaPX2FNcd2pF5IsdcX22ZmwQQd0uI7cSfk0spANWLN1lC5kkduWKJIDiVUhneOWoAfI0fVOK6wrttr9acxL0Ij/GFCIH5+Blav2ESTqqh7/X4d6QJHZQA4ic5xoeARZZilwrN28o8ONNG5CmYnmrzmhXWLKTHL85hG6rYUI4pW2g0zthnIju6tBqCF4kgaYUUYHMuwB9SMrfKiTu+N4IU0NP89pGpiE1Xpq8jZk3qTvRDXwxlaMIUF/7S1Bp7bRK0kEGQeoZZoGMdt4CxFzzpKg==
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Wed, 19 Mar
 2025 04:50:31 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::52) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 04:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 04:50:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 21:50:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 21:50:18 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 21:50:17 -0700
Date: Tue, 18 Mar 2025 21:50:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <Z9pNCKjUMbg09Wrn@Asurada-Nvidia>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-2-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd1d2ac-b1c4-4bf8-e034-08dd66a193f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BlLx4XUo5xD+uI2oUtOaOBiryJjcvD+ypgnlNTGDwIwFmZ28pgeithQMybQa?=
 =?us-ascii?Q?IwffXP7xsD0rrC6AWWJoeH8fUxvttmejbSzlffD4iA62QjSzcz8KHdSpfmCk?=
 =?us-ascii?Q?lk+twSSbXyd6zodVMwOM+FcgYaUFnNm95jIj7SwvW+XGQbsgGXruvuNcwcj8?=
 =?us-ascii?Q?Gy1JeguI2tM02OrI9h2nXU5WPMRbTicALr+s73OdM5WDOMaDJe01TWmPIc/V?=
 =?us-ascii?Q?dAcjTn7T0JPNGLtwT5pinLrEDXD0ce8J9F3y0lnQsBqec5z6MnIFPozyCJlx?=
 =?us-ascii?Q?iGK7UxVlTl4s/WKsg5KeXlsf5Vq3w1jVA+FIKBAJQwHSx+AMamIhtnt5gFLS?=
 =?us-ascii?Q?Ni/X39uYXkoiHrLMduJUKM7mt+28MqdwMR5b/1CWo6N/skqZuwkfQMAUvMGp?=
 =?us-ascii?Q?XINChv7+kPqRq7jb00ATOObhDAnMIHI3H2mDVz9uE1chYkCu19Uxa7+sgWhy?=
 =?us-ascii?Q?FnhGIuJHdsRbYdDF4ZyD4DJtVSY6uCkVpuOrmLZn7/amBN9tcww3L2JZ0Xol?=
 =?us-ascii?Q?BYN+NtuxOAwquvSrAe2SjiGfPuo0H0MMB85ryUEwPzYIByRoE2SeRq2h/th9?=
 =?us-ascii?Q?75mnpdPsA/dCjwrIvxk+SnxwYbsnCeUhzb+doR3+wrHst1CYqO3Ad53KrrUf?=
 =?us-ascii?Q?Nofat1ZDKGxR1paNaIZew1N3r1Y5IzoTsxbtVsVmKjmcun6q+Loqslud/Bv3?=
 =?us-ascii?Q?kqP9ixeulmb8MwCTnDYhZ7mpRD3ewzVEp+aTKTXphmRXYXy47ktCvNwVVJbu?=
 =?us-ascii?Q?iiI1+NJON9RzrAnDerpMvvFyLNCTqoy+GvBHXhBgEKjU27nXOXz7RjiMsRu/?=
 =?us-ascii?Q?tkw+xn0YJ3SS+cz36ETMpo6DTiqCDV1402E007dd2882KwUbTvXOeUwZ35VC?=
 =?us-ascii?Q?BCEDqsfyP3RKC7xn6UJUBADUgz6n4eBG94nzzd5Vo9NBgnLZEQEHSX8Ak1cX?=
 =?us-ascii?Q?SNTysvt18f0QmDQknecQUXLFtlzJm1X8tr+v/qgLr65HCkK874ZxQ57EYoTz?=
 =?us-ascii?Q?vHPxZZBGjOCArcxdwRbDgg1+KyjUNu9WjKGdPhPkVJvBhQszAxctRdQnKOZY?=
 =?us-ascii?Q?3BK5lljh4DBUanaIE3QR382x9TKhiLs5j5AfwuOfIiefKfmdos+OX5173W5Z?=
 =?us-ascii?Q?Kz/dpbjTKYtcc3EksLhmlqCA08xc7oY4rxGXNbozfHtU7m0iU29Ov2YZrjHP?=
 =?us-ascii?Q?Gnf7ZyLgpDD3zZ67ycWjP+L41GsnUVmcXMMsXmUEUvckg6nZWeCCNFsz4C2L?=
 =?us-ascii?Q?jwiazFT3IKIRordyCLdyuq9O8i50p0wYY80JzbiSoirp68/eXlwOkKc5FMI8?=
 =?us-ascii?Q?Dwc/jmbuH5cE+7LM0IdAGmvd6z6ChBOXsSSAg3eMoU24Q7kxJ0blBgTF6Ml7?=
 =?us-ascii?Q?ZwRiptntVpipOFrsdJH7ccg2s+TI4YO2lDBXODMv2i1MeXTcol5ViYE6Ay7B?=
 =?us-ascii?Q?A8FMZ2f0M4WbIwJcbYFf+2eboEdupgcm/mxMCiZJ+61g1PrhFFOYUwBmY4Pr?=
 =?us-ascii?Q?ce+ygBj1gj2N/rc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 04:50:31.3360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd1d2ac-b1c4-4bf8-e034-08dd66a193f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551

On Wed, Mar 19, 2025 at 12:42:50AM +0000, Pranjal Shrivastava wrote:
> Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> registering interrupt handlers and the other one for enabling interrupt
> generation in the hardware. This refactor helps in re-initialization of
> hardware interrupts as part of a subsequent patch that enables runtime
> power management for the arm-smmu-v3 driver.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++++-----
>  1 file changed, 38 insertions(+), 12 deletions(-)

> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_disable_irqs(smmu);

Why do we need to touch HW in this SW handler setting-up function?

> @@ -4171,6 +4187,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> +	/* Enable interrupt generation on the SMMU */
> +	arm_smmu_enable_irqs(smmu);
> +

Should this replace arm_smmu_setup_irqs() in this function? I see
arm_smmu_setup_irqs() still remain in arm_smmu_device_reset(), so
a normal probe routine would call it twice?

In my view, arm_smmu_setup_irqs() can be done just once, moving
out of arm_smmu_device_reset() and up to arm_smmu_device_probe()?

Thanks
Nicolin
