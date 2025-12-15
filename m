Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536ED2EA159
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833591; cv=fail; b=TGcoAT90vGuhuYp8ScIZ2t9IndrRmsSonoHrWgttjL2pEX6K8zL+Gr9FHmO8OJYNsBk629Oew+bKBqD+6ARAyI4J/as6B9mN+GhMtYCYY+zoBkoeewn3A4jFUFjhOejS3hTdmTHHYbBJJ5K7gBVdW6U/zFimdceZInYFg66IJgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833591; c=relaxed/simple;
	bh=IJlveeGN0EOndl34aED5oBML70N4GSsXmY/Ef50RHE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAhsZQGZyTDpN4kvgzZNelhnpZpAvJcuyddILk+DmfYCyttXyBe6ssXnEdb8bKvlPu/L0X6jwWZdoMKD3TKxdy7bAjbKvRy9YUiPsfTKjoMSaOXSyV78pPVnHiTpLvpxyYr2HAkN1vaUpLB1s3qDBYuSl8tx4eVXNC6eKZ9gzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GhI1TGkk; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GhI1TGkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDbdZ2sIK1erwTnbjrqkOdQfSBTX/XHiP+BE9JJfTny/azX1joe4oi78kv+Rz9NPCpWn4fP0hIWvUsiNwBdcQ1L7fY/nShch4SLQj/hS+bnbdUy60BU4qjZ4tF41bSXh6c4zFMMU8oBSL8eXSTs8HcZryKV8Yy89VkLXfHQ6UiiAj+U2DXV1YXUp2zV6zlm1OeTFklWTuRNH1iS7QeRk4K+9hcAQ6A9f/S3oRR7AKzh5UCRjXgl5eM/Jcc+jgOSdrmPdTaay2ZtNIE2tdE94cQjtwCHxeKcg/gWX99AwWq2oLG/P1vdKF7slrGHrKVtVlPMQM1gUaa30k3ouH86m4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy2Yi5gsKQEM/K9n6LEoZR6y9ntNefdeLc3esZmezF4=;
 b=UKOZSl0nswV/bCUlPaV5hStlsqePy3tAxZTF9ZjcUfxomWuEA7V2YI6J8WSbudxMX8HO5U/ehscnKeHZaRXjtiPaUlFEi9y0aOPZDQmw98d6uw5nCFPO/OC5WB2PrZ0ST9Y61OVrZdmxs87S+9NPibFRx+gpM5pOvSALytaUaVpwruWQlvAqymq012eVwhciHW4UOB3xvOM7NXv1apklzwhyoNSWzuP8rEx4/CvYaNuF1AD9H7FfYR60CAYglNCy9lun7wYtnT2Zy/FqgwHVF905KwRi9Y7g3hXvMR6jed1E5kQm9URDJC/TrAXKwlMQ3fHFVJAEZr9/iypZvnaMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy2Yi5gsKQEM/K9n6LEoZR6y9ntNefdeLc3esZmezF4=;
 b=GhI1TGkkBxQUlgdWfj42F/Yis203Dq0ygNdFkAPbxabHacM6smywtY7hXI0jC1qjA3i+loFrPDFflCoab5duoOEMXiHt6BOfRUZo90nZRZ7//olwgSFtMAjInwErw0BNO5rm4kVbijISR8Qm7GxzocEIwbP39JztFCZg7qQ105L+AtoDxOc4inXwrOrHI/UFmZk49Y9TKz9fhmWSpArQLIr8i97CD6bzUHhEf++CiTri2ymwEVOkFhW+gVUfGieS0XBPhB+8ox6jmzNXKeqexvXIuiu1b+zP1P2hOtYog/foOa2sqpK84E2DaPr2xXSiDWLkx+/taGUsmUELWCatoQ==
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Mon, 15 Dec 2025 21:19:46 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::66) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 21:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 21:19:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 13:19:31 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 13:19:31 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 13:19:30 -0800
Date: Mon, 15 Dec 2025 13:19:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Message-ID: <aUB7YNiCarEY7Ig7@Asurada-Nvidia>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215064819.3345361-4-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c10b0e-1b8c-42d1-9d2b-08de3c1fac0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ClPmm+HEyKioTa1umTUSzxdKMQY9JBHzlLrZ1HybnV6q8NVidGeyiKNaX9HU?=
 =?us-ascii?Q?hicPT7Y+uqLhW4lmeURVm+MMycEVBd80TRD95vpzH7tFAyF+R5/rWsgexhv0?=
 =?us-ascii?Q?O2YGe3hCBeBdy6irUm5I5p1JfJZPRLbb3ZBYs+nZge17nKVPmNv+56nu7yZ6?=
 =?us-ascii?Q?hchbMPCj5/pXawMSl+FqlT32uV9dmVNB+CiD8zxuacTVa7F3N28wtCVwEoJ6?=
 =?us-ascii?Q?QdpASf7y4rxPb2jd9Axnz8ooR1rSLxrjHsUQyhTvH8zYIWzVJAcBS1kV4i3L?=
 =?us-ascii?Q?5Dx/rXl9bi0UWiCVgtskGcL7yq8ATd3YyFQjayEN0PFN9fFU12FxrGfqlLhC?=
 =?us-ascii?Q?JukjfVnu/fsBTZ8+ejuTCPcTfKVpr1VunX++dpCorzXNiAy/HsZGokPZuPsh?=
 =?us-ascii?Q?I+Dj02FZ3YZn6E3BiifBw1ysdoQjIqrScbobY2ZhXDwWP52Inm9189JK0LWc?=
 =?us-ascii?Q?VsM1JoUeXJsXz954ORh4iDcx5Xgg/R29TU4Ff/rEUYunlVNT4liZuz8tkAJA?=
 =?us-ascii?Q?qGxyB993kyxX8nfS+bwWttDKAQkZ4tP0fElQFo8y/NXXDLSuztXao/Rjx1CA?=
 =?us-ascii?Q?nns2sB1rT/Vz0e5BLnnGpx313iPHjbwhiXC7VrVVaIIIrRKWVIgBObJsk6MB?=
 =?us-ascii?Q?UyKvetqeYHOULzbw7di/etMYhmDBpDfVu+MlsUxwvpj2ANmGDdKdPaxOqGPI?=
 =?us-ascii?Q?tk47ex8lY/5okvAvPIud4xoOnY31qnqCF89P75S32tdOzZpFRDVesf9gBbVp?=
 =?us-ascii?Q?h/pyEEXnR4A3NwIWo+c+AGuPWWfO2d43gpfGEiCM8EUwsMiNB+16r+nbrP2q?=
 =?us-ascii?Q?0hDw4jZCdX0jZ1XX2mcHKzzC/Sw9n9qCZUHLAtAPOl2HDCQeyXycUKTQru7v?=
 =?us-ascii?Q?sOUYVc9y7OoYyEgSxAO+XWsOkXgF0zoUttQZrFv/hnKpzB7pWdYO6oZxP6pv?=
 =?us-ascii?Q?cBy2fA+3KZxdisDH8nJk5WS8qTgSILjuTgC2dY3LtnS660+z2iG7mmmvmuSq?=
 =?us-ascii?Q?UljalDZI2qeZWCQ3w9gtP6uMTA/cEY5UDOAE7BvEyUPFehg9MxzrzRSeVp2i?=
 =?us-ascii?Q?/LOAdpaksYGrtj6A2WFtQ+hA95GpN+tOMnKtohJS2vJNuJITD+1QWC2lXnrU?=
 =?us-ascii?Q?dIfjYO+7Tx5iDalruXxWD6dy1ZGbKgl022MJxDIFE8AqS0KvkIHYBmD8XB7g?=
 =?us-ascii?Q?TmIajQCagChtBXwk5RbIWGIm9lwe0F3jT08nLd4vlsvncp0DPTiOMIXcpjE/?=
 =?us-ascii?Q?OT1CAvfaqovufnfao9EFMzD1r/Gx/pgBMNeWratWZu0y95SRiObkJktnMrDj?=
 =?us-ascii?Q?TIyZhMOKT2JDCt38VjOPf5TGUtD5m9h+PJeCUbQZOj9HSXhS7CJxig7/7blA?=
 =?us-ascii?Q?C43oSdsGM/R6iDJXhQBMeiglmlRTcCi5lDlKYC796kiuMV5CsF+dMDMG7uu6?=
 =?us-ascii?Q?zIzNjhaf7e7WaI95VU9B1v0oGuCs9Ji6d0IeCjaVSz1xOBMIfyUXUGF5cBW3?=
 =?us-ascii?Q?FVpAdpXJ9xJOQl3vXTIzIg6kc+Y4/Mpzt6Vx3qcTbGAOY0Ku19f8Z0iTrSip?=
 =?us-ascii?Q?VOky4bqIeZ8RWcVVuUw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:19:46.0942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c10b0e-1b8c-42d1-9d2b-08de3c1fac0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962

On Mon, Dec 15, 2025 at 06:48:18AM +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Add a new device tree binding document for nvidia,tegra264-cmdqv.
> 
> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
> property. This property is a phandle to the CMDQV device node, allowing
> the SMMU driver to associate with its corresponding CMDQV instance.
> Restrict this property usage to Nvidia Tegra264 only.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
