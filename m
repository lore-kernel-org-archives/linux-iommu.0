Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC134D3A7
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944430; cv=fail; b=nsYUmYYznCqpQr37kf9GYJ4ZaJ5Ab8yxW+VxMYdZHTZSMvTSCcv32ZSozUxEH+ApDzK1xRzyhE8H/8R1Gpok5I8o2/NpYd5O2BFjmii3lOH9yWCgXFclmnjfJvWDktLAhogsCr1IyUmAJVc35kKw4ckm0nH13ChJempRTRs4vZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944430; c=relaxed/simple;
	bh=Tduzn1VYg6Hs2/R+01qFBYX3s9z9a0wjUp7pOXmwbXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in55C0i5Q9t7qnSvQEIWwCxyi/ZCBB4hrcsf1mFEA7ciZDSZMfMiHJ4og/yLIzlsSU3WrfOFxj8ENcm73BfisOszAEnARdywacf9ptx+H5VSLEOs26ibW1ho/QGKWpxmLFNYqyWpkKN8LUEhbeuP+1BxZ9EHx0LX/sQ4Xde+kbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDOMS/AT; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDOMS/AT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWKO0Mdw2KLIaeFwtazqt3BgGQ4tN7ou3QJmLsvwZ/4lg9GKWzQRL/Xeh+n1LKyI4rFcmt+3XPOPkEzVutf0hsQlQC5Pu3VjSjwrApizVNxTjhVNhOguneVqbXTemCHt3DGGwKOmhCv1NwN49ENekiZOYA+SGCQQ9OWUumGBWZsGfDVWWpjcCtkMXhsFkPDb9X2S63wdX8GyNCZgDJX5X57JhKz4D855fPWPXdfsGZrRe/ywhjOwLhUwHuu+lFB3lVn77EfhYv3E29DVA1suGiMuAMjtKn2ENXkEz/Zkqwf8h8t2GSFSZc9vwJppVbXR9BeNxJwaachpQkSvNom9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRcR63eSkad99HHrIf8c3stt2LgXQ3oTsHFraoTOF8o=;
 b=weQqi7xkr2bXuY5VGcRsHhCFMpOJTPhaTvOkK53UmUj+gaVhah9ofgQTG1PsQOcMqSAIy6x1G6mUdKfl4Lg+x5v7lIVB+Fdf+k/QD3zO0riij07x+k3sLzu1d1AVOlQBzy9zLXOU4CSyketTfuPPljROw2ZN7Le7DeiN+khJulr+dEkqUbjmoG/sZQx8AorEWIM1qhhKHihbdBRKHW+LMs5N/ss69qIEzwejP4ZdWNR4d8597KJVXunFW4qvSH/Q7oETjSMFvozcx929vPYVpBpUsUhL3HkXRfatZ3HPiq38vjVEXDUsjckKwIKlrtOdnzFhWRwntPp1j/LtJsBcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRcR63eSkad99HHrIf8c3stt2LgXQ3oTsHFraoTOF8o=;
 b=hDOMS/ATNpMkCpre9zjRG1WX608KezVxQtLmAwmvUwX+mYe9tnnWu7ItxedrRM0ywDcRxmC4cPTEPsUcNT6jMYoszxDaht/EIMxjYdv/66xOzINYrB1nUbS1C+g7b0uaDACKkB2ZdrNibH1ClkDUeUCANlZOkuIe2vK0J0cHxdiK8IuZ7DbScw1gg/t8F94PMA2+NXIG3PYfGam8QWyLGXPw9BiKfQBxM6LuhQCtE3yrmQsktJWixrLXmKraqQSAHvQ1gIaWUklLQyfeiQBWB3er5JSSVoipSupZbf6MKbHL6nRchMB5BrHmbjuJCXTyGddI+3qk2194WEgXdmlItw==
Received: from SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::35)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 31 Oct 2025 21:00:24 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::b1) by SN7P222CA0025.outlook.office365.com
 (2603:10b6:806:124::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 21:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 21:00:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 14:00:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 31 Oct 2025 14:00:05 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 14:00:04 -0700
Date: Fri, 31 Oct 2025 14:00:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Ashish Mhetre <amhetre@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jgg@ziepe.ca>, <linux-tegra@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Message-ID: <aQUjU/mgccX7mt8R@Asurada-Nvidia>
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
 <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: b15feded-d508-41c3-01f8-08de18c082e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/Cl4llGOpzFNh3Yoy0vS7Kx4oDSH1w8EPJ5BszjFfJFFeTs1OMDtHsMNiDD?=
 =?us-ascii?Q?Lbmctt2e3PdrcIc6Oz5Ro44hnf+58RRUNe0bQCDpQ0b3RHDW59kYb7ASYnsd?=
 =?us-ascii?Q?KecmQcTjbeeceWeShwWoNdyvmFkYn/aVWbFYSJlVwi6RrO9TcP8parNfTp2x?=
 =?us-ascii?Q?xDrgjqT3EHDjFwcdeVg1ycaoSCSn3aN+3Mx+1N49lVblz05ytgdo3wY1dQ1b?=
 =?us-ascii?Q?vaOni9bjOgx+kZoQqw8lWZ8xqWeJLlw7M8gpKKNgwIar8uridv54smRDTwM3?=
 =?us-ascii?Q?ZoviNXMVDUOC2tq59TQ1mk95Z0FM/BedH6kLyMvfvh5+AMmoopG7BPg3Yxll?=
 =?us-ascii?Q?IW5HJueIWVE+5vIYFbwhF9bAn5FocUhmccP0VC82q7BR+cFTbvkVqRyWtznp?=
 =?us-ascii?Q?MIvo6oxS9Cy8SbmQzzrmZ1x6QkO/0HYXKn45OVvfEzLo37jn6kmVLu2hNJ35?=
 =?us-ascii?Q?Uyg1ly3CjxizJmnAyigyGsu9/agOm0baThiNwooVxWg9kHMaSf6vFba1uMPp?=
 =?us-ascii?Q?2Ro5+NP7Xi5UyU8DaFEErCkY9S8sFKB+YnFwpSC5F60JNUOow8mLP9pHVjLw?=
 =?us-ascii?Q?4/jVzcpovWfbnACjHBBY/uFnz6RtjDKh0VEZvNuJdnVK6rxY8duLfre2idMP?=
 =?us-ascii?Q?6uKuzjCzi/Vm8+EuD24gonnCwVCijGHTGPk/Y/2D9T9+ICW7BHfSU9d7eLh5?=
 =?us-ascii?Q?Gy9Wvhvc4aBzi5H9GfzYJD81vjWSV7jtpCRvwMVTIxoazd23CLyxluSzxPJs?=
 =?us-ascii?Q?KbQvDRRSVqtWKKLKb08xOc1N4pa+uv4taYyrDmP5uR3alRWl/a/4yBptKN95?=
 =?us-ascii?Q?91Kqov5er8APN3efmPcR4SDQn81gsKTOjPpE2VJYCGAn6dgtMjJGeTAHshua?=
 =?us-ascii?Q?AOs6kYjXgXXiUOEzyF9AhtZ7KFd+3EKExDF09i7Jocy1CI7eREDcGQikrZkx?=
 =?us-ascii?Q?mYT/YSB7H+15nBu1V7AuMAai+nQQ7rhsVnk2XgNKkEZ5BynV1C9MlaTiQVwu?=
 =?us-ascii?Q?XmolAuXAUCYpOciUU/Gb5bjNjqHUcQt6CB/Mmi8Ghp9blMQQL6Eyw7up67bC?=
 =?us-ascii?Q?ljdfWq/VhcoaXsRvwtNJDRPPO0QnVO4NHmyLpt2+vwhmbzgmoPn8Nw7MZGLG?=
 =?us-ascii?Q?uorVaejBVWCkO5aRYCCp5ryLAopiEFRRrsTevKtqtrGDKiAamucBLTOgwKwp?=
 =?us-ascii?Q?5DtvwwwaFgYbW3Cg8VTTAoQFBSgi1icgwHXA+N3Ip7iBmi+ISNPMSF5Dcnbt?=
 =?us-ascii?Q?VrSfPAPcSRTiabaTH9WU2YKIL0aGYX+Ef4QyynZyQChmNhGhHVjUVdi3AJlj?=
 =?us-ascii?Q?/6plgKG6z8Adw1MLh3s61YGr2YGJpz3gri/yTgxg1WvGKXezrtxSlwxMFAo2?=
 =?us-ascii?Q?XJsgR90DMdCA/3BjdH5bkOsgPY9lqDtCSZMxhInByLTT8tlM3WjRf6WqrxBd?=
 =?us-ascii?Q?cMN4GuFTQox9ZhdaaUOa98k9q1bP1qXubchnkg8wwMMFeN+x+tYiVtnmXezc?=
 =?us-ascii?Q?QZf66pSLcIFLbC/d59l5qg+ZqcKmNUoUg3X/lcND1LK8CRX9WO4yQXQFyN1M?=
 =?us-ascii?Q?YuwYAHLnYAGtanAeMTk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 21:00:24.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15feded-d508-41c3-01f8-08de18c082e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293

On Fri, Oct 31, 2025 at 09:14:25AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
> > +  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
> > +  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
> > +
> > +maintainers:
> > +  - NVIDIA Corporation <linux-tegra@nvidia.com>
> 
> No. It should be a person. If entire Nvidia cannot find a person, I
> don't think we are interested in having this in the kernel.

I was the submitter of the driver. I can take it up.

Thanks
Nicolin
