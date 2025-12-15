Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDA2C0287
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833705; cv=fail; b=gtqzfR/e3s6CiWtei7rlyshcyJUub+izhGX2Cfzv8JEpSstE8bq2QSVzwpFtuA0Tg9suujoW5GNZqJzuULims0ZY+8HDGnTANwvINprMyxD7jvjRZ0I5uayEOx2WutgtdG9AvBI1tZtFZr4zPgDShtQvni6HBr0rVjHiPkqpwfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833705; c=relaxed/simple;
	bh=fBRQGh6VTaw3XJbmXHxw8paWWyRUPLfMhHojFc2BVuU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWdL+gqtC4A0ygSlfoQTA5b52vW3N0Og3lb+fMkpsKjzZfSvZgHgr1BoZa1zdAv+QzqoosQQ1qM7hyjkfVe/NDiseAS9/H7oMHL4lcAk+NIC/GAFke1RboZpovNsZG7MR0bFF2dD3CYGubmHC1HHE0j4IjD4x1NxcoVNN2DVzrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRvGG3TX; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRvGG3TX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKUy5K+VZEdjtYdKJseuBmobCuJCEEzyStzEwqzV7wglqgl0oLbDI7tvLKdh4SDXvCZrxj79rSeRrBLXdHr/4SRax3R+kc4gU3x4NO3wyV+KRzXuwSbXiYgVW5fM6KuPFJAL6Mwncm9u9A7tJzAzvV1110S0jPEh5quNLMwQpCaZI+6XYQoInp7xg4h3a/X/JXU6UHcNOAfEnz+88I1ChuOY7kwqgRFJgpbGFz2wflusdnFV16hONUVrJY8AQhN3I2BF2REf71Jm01P2y/cjN547XkCj9R2bUz8JP80siywxwIoB5n1LEzZHMnycYYEGjK+QTJjgqUKEVyvxmqaI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoPOuub9aZJieZNO0Hz5CyoYydAfClrwTgE4K1LVfo4=;
 b=puSLacFgv9V9OYEt08Kp2c9wzwKnvJzII95k8yJelNuaX1nJ2gcrlIR+RUiBmH62G1W98ZvzOvhvDfkmGDfADs7pTXELjWKd64HflYxNZVVtmY6xkX4rbP9azgVev8lctxiyJVVO5aPQhxT0HHFBc+nkqtUMVwSJRJsGTtpJvx1S1B91rTJ8BQLn1QRVYZ1ZvRZx7Hfn0MNzjLEDmZ1x59BHV+9VWmI3L5WkmQtQCVsNDgp5ZU6CnzG661FoxKtrVAd3mS9xQp+V2jhwXxlkw7LQkzgCA800txSgmL7Vd+rW/qtmwN0QufhMNdLj6Rbi5KMCRgis/1UmcmFCYoaUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoPOuub9aZJieZNO0Hz5CyoYydAfClrwTgE4K1LVfo4=;
 b=RRvGG3TXOzKIwTgeSLmR0o/dMNU7sOvlgfmHDRbYq3EHj+B1Q5Ww6+2iGu+ikx+nzksNYaZDMOCj+ehrJi2gJr81YQtv5aTaQX/VCwOsw2m0qaNl0oOawXolfmPZBHoN2k+gxuClG/rjgRZykzzb8z/ciZWhJrHgyEANeB5d78LEYKSCE0B3G0FNH6mYTfP4VokaFwIrZrq8QF/un2C8i26cdCdGELevlWt1RweytmJeyxX74ISED0FL6FI+sj1cFiWSjoBzUfmmBY8IX+OclSY9sp8b4fO88xjr7y+B3s8rajf/SAOp+i6eeXuT4BF8T5G5WyVhWFsGi3K2RHFbCQ==
Received: from SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:21:38 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::e9) by SJ0PR05CA0115.outlook.office365.com
 (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 21:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 21:21:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 13:21:22 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 13:21:21 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 13:21:20 -0800
Date: Mon, 15 Dec 2025 13:21:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V7 4/4] arm64: dts: nvidia: Add nodes for CMDQV
Message-ID: <aUB7zz8wMJoPSVf7@Asurada-Nvidia>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-5-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215064819.3345361-5-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9419cf90-fa46-4267-e2fa-08de3c1fee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqjuavN4p+gVb8JxCL6+JbRF2plF9XWnM0XqAD3MS5kYVl5sH2s0sfAqG7+7?=
 =?us-ascii?Q?gL14SR9QCERh4WrkSlv0MGzthe3CWacgNnqX4GmR0+y1t1LfEx4oNCw4D/Q1?=
 =?us-ascii?Q?ttBKpix8+jdcmK4Adp3Xu2d+VMN0KkC3rzSZaP/4L9Iq/84/BVpmLUv2lAJ4?=
 =?us-ascii?Q?subRnTR+RPsPlHN/nm1RFWaNkPOjL+PcneeWJax3gZhUsHorHYxRGqGtWioL?=
 =?us-ascii?Q?8FNVMcffn1JsEBtv30tZ9BoBT11FDza5F13CPqlxbCXUdrRCNFhB8erZv7yd?=
 =?us-ascii?Q?sGV+UlL6zW73BNToKHHMOhaw5GwJYeGW6UEImv4U/f7LTM7zbYRWp4r9KEMV?=
 =?us-ascii?Q?cwJsTljW/GbIW8dLFUc4k8m4RIi6L4+1K/zNFND8E8t7b5VhP0gePxirveym?=
 =?us-ascii?Q?5l01n4TACilARkXy9Vkn+c+jzVr817EDtJt6PEq3P/htP/PbPd9siDhBgCY3?=
 =?us-ascii?Q?QlW8be42cusw0WMfeObwjFpvhJ+ydTnInNKlTtSxK6P7FR0lCpCwzPg+8udv?=
 =?us-ascii?Q?9kF6bJYeTBGx8zM687eQ04gSdHzoL2fr/2NuYbeX3I+cQC+sosZJ4+5PHVbI?=
 =?us-ascii?Q?ye73wKnNS+bdjI0vgS2Jl5qUxE97wp+9UICmQebdsGRui/mjcEmA69PbZdKo?=
 =?us-ascii?Q?5z7t3hdjZEm88h7sm8vyz0wTe4Jax7kDhn8Ayh+Of7llmrL7+4Fpyr6k+BSO?=
 =?us-ascii?Q?tVhXPKiP+iyM6UyqmUorXLOzsDC67ISKPy8MMZwYJsT3tAygsxd0+tBjOiRp?=
 =?us-ascii?Q?6Bkf6cyTbgPykxZURm8qfMpg+Bn9Cf9gYlReyu6oND3XpndXcx2nS/QmZnRK?=
 =?us-ascii?Q?3ePpsY4lYJJ3vh4BUCzBD7Q0yrDorSfkTHWjm8AdfzeiJaOZahA5BYfg89q7?=
 =?us-ascii?Q?Z9DvJKZYPOUmfNhHNHyYSpQblCc/0q/ixmU4LY6vLhUu3tMmhfkMXpfycBPW?=
 =?us-ascii?Q?ecugOmugnKVXA4JdW8w/XNoar+uUJhXFsnCSOj28BM85bCUHygSl1/SEBv/G?=
 =?us-ascii?Q?Kw/Ld+LMEDHxAJfAodHi3/+zWwIDnLhvEYDlsFQf8c/3yslPORZj6Gn2IHVG?=
 =?us-ascii?Q?4S7w1sqxzZGCLkRWcHAXNQqgupfX9loIB3MxbMkkcGYFZYbPb1JIdBr58gk3?=
 =?us-ascii?Q?xn/+f7G3B/oUHnPCK4CZTcQ0UTlOB5lvyScdekIEtnBgn+l8iIs69EEYQAnI?=
 =?us-ascii?Q?OueFQ4OqI1MxeylDTJzirs+FWtk62iMsXxQ5V3TwTqq6SMR2uDqANyhhAUIY?=
 =?us-ascii?Q?AcsYhTcYK2+kE1UmRLkbA3fWlmGuUpTldT6q+oRnq3DE/Q/D/UDW+wK8AzCs?=
 =?us-ascii?Q?LjL6EgJG7vOKE68MTgcYY5wWUGcAEurcM+XLE6PvmkAs1NRN+93rM9Odb+eA?=
 =?us-ascii?Q?XkdrkTgoTluRlkKzHvzbbvJQVo+MQ4FJR0ZE0icPn4pXjb4mI+c2u8pZ3zi6?=
 =?us-ascii?Q?nUyh5JeoVYdN+ZGARgdjnqxgVFEdTya7wiT5ACsCHA7kpDnupolIN6ITqwc6?=
 =?us-ascii?Q?5bEk41IWgU43OFroNgcrQYWRDRQNTe3lMptC778mZBm+XS4i/TappZuti4X0?=
 =?us-ascii?Q?3eZIm0Vf+xdhUjBRoDw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:21:37.6233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9419cf90-fa46-4267-e2fa-08de3c1fee84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

On Mon, Dec 15, 2025 at 06:48:19AM +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
