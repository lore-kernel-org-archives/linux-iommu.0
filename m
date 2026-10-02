Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4554AA414
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960333; cv=fail; b=piIncEfixmlw1ECkI1jhd6Ka4qpvtl/nMn14z6r1SNFYcyZyA2mHrXT5rKOJa/6lv8lP4GdDdutnrLTUtwcLjLNj90wVC77Wjv6ZpJjAipHdiJqHNvbIYds0m+zgO3w5OCewM/1wVq8fij522an/AoUg4rdVXs+xIccgGu+Z/Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960333; c=relaxed/simple;
	bh=RGxHVMjtAfDn1yV/Fu1G74scftwF69+rxvBT+N+qscs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBS/MQ4izVCfj5W7HwgADUrhhPWmRxruzk/bbuMOD/qyFdzOxQLXlV7VQpUCp+qO4NXROwsHbXva07MgIvT75D3HiS1+yTzSOchpxmw2sOQN9dEr02BHuAK+PVDkTx/HiflZIBPpbZbXa3L3FjP1IU4URLg+Y/gDiHSM2x26vys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umodMw3P; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umodMw3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWr3QUCQ0JOh+nl8DqrxXThWsebgg134IPAC1NmFhPS4W6j9jeoFTCT/VEa1xDmr2hJJk5ua88WbGGAnEy9TKTDo13LlVBIQKdA4pE4rxuDJZEXiQ53ij2Ugzz8IB0pTtkPaCtX5JBayYBCTZMZuVn85H6frnluFzHky8vFbsBJ1VddEYff9modD7H303tThFh/rbRhAAVkyDreV7T44gCjXTl3w3tNQvSqVrD+eEdtujdBrF4ET9vZMDyUaTOU4h/fIjSTRbJbZDso+FYvBL1A3Of8FbpIo7vLdpt6fJVDRuHLnxWRWwTzC1liQ+PCkEtg8hmaahaDnGomBuLxgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpE8Vw8UCJS+AESt1/Nz0tcemSMs1zaqbJC0UvflrYw=;
 b=yp+5cPMhnbt1Z7ySOp7IfzQwwiQ9+RBE0piQhu66wxs3JxYPuB2+QhqQ5WllVbnefm4Ixe9xa64VBiUsQqbc7Si9F7RzCcGRgmyTPDfRh4fyFxWsNdxImKQ0TAg0ZtU6B7TYQbTmqn52GJlLtXWXoFKPh2RqALsXofBerIe+M3mr1g41lRQhEHgrK5Cuu79X3n30ar5N3Qfe5wYb33hUTDxtYBPPCcMDeJr72TPzvWmTosjuJrhXtYoQfNMmu+QN3Pguhip+MpkC7t2TUY3Rak/7MnGLAjDoDI9fjewcCjm9epZa/uHsPJA4KELs5cS+06a3NBApOpwspiLpQ2Neow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpE8Vw8UCJS+AESt1/Nz0tcemSMs1zaqbJC0UvflrYw=;
 b=umodMw3PhAGdKVG4QNB/1pSlZj7J80SF7hNUrjjk1iIwwsHzd/Si+wxOEA1Qa7b9u//4RXUC/nBH3CXCKT7MRpUvZotzJYe2G9yX/trs9S5beoRAnVfCepR3IdRY8qSLfqzLs3AAw2jqJkowLHqRuykD3pvF2r8QHgOoj5lDfzV+B5oD3vuZF5jajbbj2lmvtDOVrmo49MZpI3OaZrdReRH7LRwv3NYBJ5aOG7FGeySphobOrdLcRamZ4g4sUYENRXk9L4RHzM/KskW/OSJQxGB+Jy9itfEIZ6tIwyNzyKiPSgBEfAP0CnaKxHyFhdiQ53a/L5TrG/mlLpWgvc+Xbw==
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 16:58:40 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::91) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 16:58:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 16:58:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:58:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 09:58:13 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 09:58:12 -0700
Date: Fri, 2 Oct 2026 09:58:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Clean up redundant MSI cookie check
Message-ID: <ar/ipObv6hdgq4vH@nvidia.com>
References: <214eb3e383431f48b517c4bd2ba4f329579a442e.1790958898.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <214eb3e383431f48b517c4bd2ba4f329579a442e.1790958898.git.robin.murphy@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 87edfd57-a122-4862-8bdb-08df20a668c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	F3iDTDlxXurZc9DXCkXk/MRuHUSY7ihgAtQ5S0U9p/pHbptnSemUjZLSdSudTmjPVldnyIj6m2o3mtaWAcTJAVOprmY/5uJigAM3YZuzRP1/IntFnRrH9Groyq3ow3jirl35TqgXYN8DJIIeAfU4k5LDeyWUSV8ZUbPhs3N69pk9YJqN4jbxnniGn1DtLZz9dSzlkiAU9wqmMSzxUzZvIs+QZ4bb8ggXQH4drpSLqaoS+v5UlySeBs0vE2Mn//wPU0pKLIKXd0oZ/tRXezAPOtvlbTDM14YSdfgB5PChqxm7XOuolbbtCqqA2sazUs+9XvuuikUgOMtpBpIJAW+lGdkiPNUteFwFTgtVCWNAldD9Z8sVqKSMbMn4heIaxHfy/JhNqYUJyO3TnKBfnhxLd4QM6CSNOWmShpHFud0+uyMQGi0ME6cGqP3Ri93vsDvhzXobpLbLf5InMTrzOp4WoLg8F4giPXIlJ7llhW/1iUozDhLaJ83P9DW+mEluFC8hL05cw68K5iFs9t82GKQTH/6wRRO2KNSkcJWs/Xae95VGxMeVpM5qdPYWjH5yx3/Ou2YphOAscjXGpSNLiAx3h/RnMg7UZvaI9lWbKjGps+C68ljRnrncybbFlyt+mjEO+bU7WAEjrtCHLWutzeP0U5F0y/X6S8z7b9Jd9vOWvfym3Lf7r5iDzP+N1tpKmcOZh0zZzVByisuAShvEwzc+fg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nSzT7bUMPHvkIlsvdGdI5MpEXAAV+j8fSFYjaeE8yWdN/mO14T3Ya1ZSzeMKsKoaRfpadCyoP1lB5XzR6gwFIzz52uQ2Ap/QLpGdcBJxrJ6J7EX+dxamtJf8EH0QH9KPx25lQRaKekg34MMc4FwYvyfS0yymhPoROZg+HOkEpbe0AN1EcwE+Mi10p92XrCSZd+dOxfGKwSqmrkEJ12024R0qqWcpejqyJiz5QPJ4OrPX5ila9zu+UXwXMFyb1CkkE50Cexx7ZV73xYIwd6o8gExP5F8V8Ff/8wTy6onO3eZjnO18yfFg7OEHbm9lWnQu9M8397Jnts39uP21EjfEvnsfrQ+aYbyhaUeNnCYmgTme+lDNusAyJyQkXo0V/O1XJFE7wTHk9IkNBLKr0YJspWD3PKmb2DVLJ3un8CULrOrhxgZExjLAOm3DoEuspNh2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:58:40.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87edfd57-a122-4862-8bdb-08df20a668c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

On Fri, Oct 02, 2026 at 05:34:58PM +0100, Robin Murphy wrote:
> The has_msi_cookie() condition only mattered transiently as an artefact
> of the cookie rework being done in parallel with the sw_msi rework. Once
> combined, calls to iommu_dma_sw_msi() are themselves dispatched based on
> domain->cookie_type, so checking again is clearly redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
