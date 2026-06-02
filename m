Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E353EA66
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359880; cv=fail; b=ZK10OSqLJ1lgto2izuMo8q1PQAsGdboXFMAgLDacPGWEFC0D4TJ2SlNTN8sWFGL5Nr61NNUYb4E1NUBCJ05Q9sLWuC+/aPce5epzW6PGd77eJtlPDk3FCA/WmuEvRGiuAu0drBumo2RnjHKAU4jRj4Y6gd4SBJ5p3aDJnkAxUPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359880; c=relaxed/simple;
	bh=3aDj3DLQQ/P3R2o+8SXPW9FurFd7hJdhA5yK29m391U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm/Jg2DTdqM4vw3f9v6GcnI317/ks9FZgo2WNfpKhNKgHcrtjkwjHJmv9p7hO2TGuoDiVKmcC+Wcz59dAMMSIl+6ny67T+E/8BvTOKYd9cZqE4cw7MeiyfUHZLJEIcmG/KOYWMsttpdmwdq1oXHvfuh0SJgukI3VQxqo09ZUxjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dRUrPyXB; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRUrPyXB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beqEa3dr7KMF+3a7+n9/ha418g+YjwW8vlGOt3KLNdppfA7CXuuGT91PsuUy3Oee3JwS2rlp4hTu+yrNCG6jSkq8+azz0ndVUBBHY8p1HgtEJ54Sv15LnqG6ylA50uRU0gyzcblVRz/J3ZVnZ1vHpwwyqsC4d9L1xHvwSPjea6zgjTynmyqxCgop7KXjSG7vEGBOkCxbT1veLcHce7Q8FitP9MdUf/IWTqPa3UGeIJa2dOKbx+X67bodyn5EMdhq/A8wIjwXpMhfro19Hu5wuLFgHPAeLZCOLU5hQ/VXreH6+WrD2ub6HXwHjYjFfK7KbxJcGX0X/mXhW5qL4yEQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnAVxk5zckAuEBNYTRV8dH5DS18Sz8pWfvh7aWauE9w=;
 b=T9Ev9+ncSXuZ7FzweWd66vimuvylzgtZiOlxZ+6Cbe4wsBYpyu28x+MSwMao17xCdA1UX4FKZwY1TbvYg+KCPob5xlDzdBYPdkp6KAhS6xu1bLCy2kwuRgVc+E/rQPu3UjhYmqm8E7qt6n+LeVVyS1GnUOc2XcKS5A+goME5mJM13HtlO7nRnouvwCLw85JHYu3ISyeuSS266G2P/2N/UIrqk8lOlia2v/a6DsA4+Wjm6IETRfkWb0EKWHOWFlSDeUxxTxartK6AWLRwJOs2TfCwOwSP7g2E0ThCfyBgMjujeEzhiRB7AvjtG0okJ1+OxIDygxt5KeF0+gCJ5fwvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnAVxk5zckAuEBNYTRV8dH5DS18Sz8pWfvh7aWauE9w=;
 b=dRUrPyXBnxUv6Cr/j8lSqdrNVo5qTpQlk3iCGRbUFV6LIprijJvdoCa22k7Iixu/S+4XaA04mF0UGj0QkbIFCYHWMGTRWbXRsqLie4nrk0kFDExL8NEnltBZoMEX3T65l24LrgL2Q/2NTiGLRkujwlohzwJ5fyLqiS1wEl6GWHztKyaxbwR6VIYotZkwlfU8RHpltlWQxQbUoCVQ4NXCle0VjXT41ZJkcnyU3pLxGU+45165l3t1ZUdvoWihN7beHdvMsqM5kQYtam69499+ex1wT8O6DYr7lS5UxrbhlhSGMuw72RgDwGEzsC3858Mvb8FrHt0s86HreFQkrPs+tQ==
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 00:24:32 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::1c) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 00:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 00:24:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 17:24:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 17:24:20 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 17:24:20 -0700
Date: Mon, 1 Jun 2026 17:24:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ah4isiGhSScKMotO@Asurada-Nvidia>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-12-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4952be-ec3a-4fd1-65f6-08dec03d50a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4lqnxBobuD2CN2bL2n76fB+Zsrt6c4SMBrudp+kl7VXJQ7XpDBijs+zPt6XzvXk/jGgcq2BtBPbXAT/hK1G2w6+6+TDFq6uXMjyeC4HtazWjZOA6cU1iKf3RV+qwkLYLruRGTPleRaCPp/MhGcLfooj4hBiodSifUMp67EYp0LNbk/uf340ltdOnWy90qE+32g+VAaR3IaB0qaidL2HW8ZTKXoPwPmDEZaelghVIw9t2KD1mOd8d6wLVaBaKrPo86DO8VlWbgOoKbn57CTC8kxjwH7MvqpekM8PckiJiG+kplcVx4Q/tmojXDoIWSijL6LpgvDx4utlSuNftTLT+xXCdX/4sQrroIhK4sSMLRvFb1y1b3c+s/g1SK2mo1FJXm/n7M71adXqyas3KPrhNPuM02yfgR1vGJTNTCWnawDZc4b3lm9DF7tQ9U54eSEFb/JPtgfgl1gI1z+xA1ySFewyAmXP0PLl1eEeRosWIzjRKisWo6B/5ZqHh/zJqc6l7qFX3K0GC4jdosIEV5nD60O02lPcnjSa2V0WKfrGUA3Hd2odKCjrZEkTO4FCHL9zQsZL9IHtp1gstSdcTKSZ+kU86caM95zedLcHb+5O5SgJY+kBIJJ1SoblopvHd7Qa3EnReohBAVKt21BJyiCJI1UILrcwztjpBfT5TJ7MpbsgYP+aIlmkYLLdF7+GiQOlpNXq7Rb4rGOa/YRPOxFse4ZfhnGM8baobFLDQva4sQy4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ozizsyg/J5MLY4PqTGWf6cr30DwwalCTkr159MVkV/Lg2Bnc8ticlJDOW7Peiyd0zlD379pW6+pLWhFJKTYl5eS709GRy/hvG4NKzl8jX/rSm0oZFNFi5OoZGvgs62mhMik/5WICFO4P+xqSsKJHGBwUmTIG3osv0FpMf7D2MWItoUmXQbS3f9yf8cS/Z7lE0zwhREg5KAEAblLZdHigxOHjBQ7bOoOpQBftNe0sb8Pcd7+UMFNovPVfjQdXNSdzPxHwtI7ukdk6G29lNRNTP/02AA2Nq+tTl6074//ygxPPiPxQxZL+nV/45vceJiUoW5eeELOGAu0jiGp/oUmoHPvG/z0mU4wWqEUjor8IudNQ0tpxwLkn5GOo+1FgcpFCoNGdQqAcb0NUZkHIz5CeIG6KpcPci4O76XjBQKmXDR+wz0WS3ZAJFzI3hVHYLWEt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:24:30.9932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4952be-ec3a-4fd1-65f6-08dec03d50a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549

On Mon, Jun 01, 2026 at 09:59:08PM +0000, Pranjal Shrivastava wrote:
> -static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
> +static inline bool arm_smmu_cmdq_can_elide(struct arm_smmu_device *smmu)
>  {
>  	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
>  }

Can it be named perfectly at the beginning?

And again, should it check Q_STOP in vcmdq?

Nicolin
