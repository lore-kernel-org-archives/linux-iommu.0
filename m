Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF5392C56
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558376; cv=fail; b=VHoDdOEU+tOerkUTB7Ind+YcqPlARv2anNQeU2zbyUYvPrF4bH3IKFF9p7oAUZ2vYcsWYVRHuChtn0uQJ7vaUgXQCmMfefWcDxPWORM1pEbk9ISJWZAG9j2gdGykceeXbkMO6JryPAKvUrSdI4dAcCRQf35UFhOEI5dwzis9jJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558376; c=relaxed/simple;
	bh=EjOQiwnNGeooxKItfmetG6//C+tIJuO/VVBJMRZJuaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQe6+bts5Vg/pJycyT1VsWbVVk+otI9U5ypgq4Y8rc7V7wKD6/lM7dRbkgVjuLoQsqxrrykq2Aui8kMu+ggvoKRM/eQX9F42lIyxJ4RL5Hb0GUGY4dszzAaZauICk9iV9HqyEOwoiyhLG1cVOL2ZC3ALe9vYYXjWq6IZ3Ep+riM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlgZcXGH; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlgZcXGH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVY8aLMB16/JUcBSQTceHj7xlgrdME7CqOYPZX03YiuC7Ty5skXLfaXCqNWz/QqQvI4Q9IlAStZJXHDv0lDhqSIwWdVcdRpyzmgXhqH+/RVdG3wI0EHU2vzz7T/j1D8KrVWbKUp4vyw/DyKCktYMhrhZDSBy2rmn3wPdMiCDPazALe88Y/FTgl4PRBFNMt7V6bRNC71i87ddsbGFOuW8KbiDF3nhVpzS7Ksu9IkWJTHk/PClrUF2QE/5l2qIFR/FgYr6PUxuPqCChw7tqbMdjXkJxYs/i0BKiplX81d+ZuGG2M4AYwDeT6+k9vsa9VhRRAXRigQsSEtvfnMbgLseXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCX2KR6LwUkbMsdcKKT59YYecvKI/mYnFmFGLjtOYVI=;
 b=SvsZi1L8u5VJL3dDOyoi89Mfm6QyevzWZ4W+1YRngHIgQGBSyK96n2P5WQlRCkWURZxv6Wd48SY9Ngf1zsM8T4FWVZbAORqwS6UjWA1NPnoGhbQFg5jWoN+6erDetJkOwxY4/BiXPwsiD1bkTNVNcRJCUHrV4idMbnFaxMZWITwN3D3RDHyVRxmcjBBORg3FlmC6hsFZKpMvAaplQUlep3lJz11DU4qLxJ3EUtg+XUwtEXgLQNWDFGOUe1u74kcASKQtv4+naYAWTILL8MEmoj9ssmnzOJhd5kgDQGrWjXsGZdBDhva0dS2PFl2mKY5uaQpJ6VIsE1J5WZnfTrUFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCX2KR6LwUkbMsdcKKT59YYecvKI/mYnFmFGLjtOYVI=;
 b=RlgZcXGHwjm/nC5//GF0WzGR2eGXPO801PCfFRLLqgSDRlWipZcST6ItOXCfv3MjeAARWjrCbgflqg2FYtJt8GBe+lg+etDM6J3vWWsDldHo7ez6M48PbYknc7IqB7dzOdUM5Q+duR8R2XDkaJOkq4XDgniCr0Nqye4f92XAlYk2POUxianoFx9tZLnFfBuZ/Y4gRiFhGe4qpHyDYYvRQ3D082uVvNnAfVBDJr60pMdnYlD97+DtlZl1fE18jTrWt/TAh3oRlXWXQADgsFGHo3M+zrRFBBiAlcfSYwLeRtZofvO1kCjn/FqdEGv4RcnPPp1XrR6drFGiOkCU24rNsw==
Received: from SN7PR04CA0167.namprd04.prod.outlook.com (2603:10b6:806:125::22)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 00:52:47 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::43) by SN7PR04CA0167.outlook.office365.com
 (2603:10b6:806:125::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 00:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 00:52:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 17:52:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 17:52:31 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 17:52:30 -0700
Date: Wed, 8 Jul 2026 17:52:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	<robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ak7wz6Tz0scMmyyM@nvidia.com>
References: <20260609073204.1760077-1-amhetre@nvidia.com>
 <20260609073204.1760077-3-amhetre@nvidia.com>
 <ak2K2vhIQSTNAPto@Asurada-Nvidia>
 <d4307831-7634-4b43-a909-1f7e8664e852@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4307831-7634-4b43-a909-1f7e8664e852@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1740cdf6-5cc4-472b-fc08-08dedd546501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	yn3w7wJBxuBmMeqNTFdSyeEADWIq/0CaI8AKgqDjAkjq+6BB3BYCtioL08KaLszWuIQzM2WGekZc8U1pbjkvF8lBJNXa2cmAUE7jPRzAMbVhUa1OLbcPF/Cyewa4/1nkwiEzK8Zzekj1wkcVH842UixyV1jJ9w8W/0XudWLqfgGz0SIwHB6fkCgArJgi63aV6qmLJclwi/V7HDwLaoN70Hy+SI+7Pjc8oVE89r/dQUk4DF+4EWfnyfD0V9/HT3quWx128IGYToVKqyHGa4gjnzosfo475abc8F9okAXAJCRavm3b5evq4sObmivMSHv/8UgTkgoMwBIpCB1dRTihLuj76qkeGYqgmML0Cr+aEBoeq5DlKqOWRRnQ5UHancxfHQVEZpd7a3OuVox/P+ZagwgktZmq/FSbPyW7zPx8NY9Ffl1QpxZ8iUDhJ8hSANDk0Z3p4fk7Uz+lUS+JRWaZm5gqtIgGCGSM3JmIHENC5Bb6bZc4Dgjrid4NUD7NftJkYJ/y9tBjS75kLg/Ajf7LJRcoOu+m3JOrisGmVTR9B5MZuj46dO3wRDtWG8SLBLd9rGIjnv8S5/fcPlgv33rpq/zZUMfSOUca3NpFXqWny8oOgjk/fvp3dd9/I2ilnibqM4Jh1w0Xn8PLLH9AhRlC2kQ0MCP0ZK7/IjvPecg7laxbsSYa8OcohwShYGeCUf5W
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g/IBHxFFiSqW6enAFJrOKFeXZyOSjGYpxXtg7vdaPZX/4h5U7ZhcmGEGrU3i/4ZosIaSyhrJKmV06YpvJPtY4OwddDZgml0mmJKhN2MebgL/bnobreq+TmAZEdREFX8gflSL5JDu8AAHHlZbHRlQXRZh7ISDCZu0+bsWeqojRFwdxi48m80zn08ku0WMbcXSDcSvJDSh+nffxcykfWTFqdZjnrxzgC5BBcFPHzynng+rC0kY7W1SFT/fZggjPnzN9mdQ8WQsWtItsDOGY7JPc0LVBwfDgP9MX242AOvbxXwqJx8r/cjaCewIhYXWyoHoqCG+ATiFMFBVTzSZxHF4qQ8Y1uNQHpJAu10g6AGDkdzqVCPpN4ekabU4JTeyNvQ6PbYKBhmpwguFRjYVzfnNHH8hrmqBOxLtcyHgxyguSrxP/bj4I0xjcwG5r4OKO4Ar
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 00:52:47.3436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1740cdf6-5cc4-472b-fc08-08dedd546501
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On Wed, Jul 08, 2026 at 07:42:21PM +0530, Ashish Mhetre wrote:
> On 7/8/2026 4:55 AM, Nicolin Chen wrote:
> > On Tue, Jun 09, 2026 at 07:32:03AM +0000, Ashish Mhetre wrote:
> > > +arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_device *smmu,
> > > +				     struct arm_smmu_cmd *cmd)
> > > +{
> > [...]
> > > +	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
> > > +		return false;
> > > +	if (!(smmu->options & ARM_SMMU_OPT_REPEAT_TLBI_CFGI))
> > > +		return false;
> > Are they redundant?
> 
> Yes, both are set together in exactly one place, arm_smmu_device_dt_probe(),
> guarded by the same "nvidia,tegra264-smmu" compatible check.
> If we want to go with static key, then that makes option bit completely
> useless.

Drop the deadcode then.

Nicolin
