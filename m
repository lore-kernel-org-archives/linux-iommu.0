Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628E1BE852
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729303736; cv=fail; b=m57XWEzZLeT0PUE4Ehk18bDCeSA6jtY14bx1GmNEzYFxIGb6nMKGUGkBus46nN/pSsriyVThoOoiP50OGT55Xj1tGEx8idqe7H+NGXHkqGTbuevsqpmY+ss+mZGnvJl4/kgc1QArRhoZslP1qBoOQS9OLdxj/1OVGlbdNZ4MmkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729303736; c=relaxed/simple;
	bh=pQWJ4RH2nVV4Ddn9CPeqSIhbywS57kQFeamzAEgAjMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq0HUbGsOSyA/radNmeInW30J+WQCy+yANb3Ywb50auvrvF3kwPFJqmxmjZgLua5AAV3PVsHGfl23red0RgXKbcFILjIC4Fi2VoLZVsmgkYzNAf60mknoguNqccA31aLR/i9ZrSN5/Rr1O/zYpxjbbnzTMiNftq0uTXZzGhdaH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CGSh1ywu; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CGSh1ywu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRag360VvpbEqP2ahhrneA+DPDR6aze35VkgcJ0zFuRhTCpuivAhlsUNDOiE8tJxN7bD6mZhNpQE7lVl9JOmtz22lYc/F8+27UjqhWXKMZRfSJ9Tj/cLGfnmI5yDMICXJS0LPlAbUs/bi6iEcP46M0dnNTPOtKj9ExpS+jd/htlPOh22N59yi2bE/Jb1EGWFYhnNE6Si12kiVQEL8ViBWzxjsV8HDOpD4dgX7AZZgLOcXcd39J+lpPMUFMIUkSZd2YqHXNC+nLYkPvOthLoQJPr6Ti70QXeKsp7u5kGlPl5STZjWuD6Ti9mOLvifrBc01LPtbHXWXdbSwk/6SKfcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/AyOB3UsaKoPgRGLx//dfCAsp8d1DEdoDuZH//HhjU=;
 b=nHxpwD4I/jL8X0OXeozpsK7FVQzNFvKTbalJ5alWeztkkAutczcG0EXABacCIQpJw0kJvwzrPKyPqLVKWhPjM9RiDa9X6pUl76HF18NZtRmaUicAL3hMO+lfbGsQDUVLtej6vgHiyElHJBF3iVFEnyBullyiLNhL1Ygjx2ZycuxXjTGD2NTUPN5OvInMpdkMgsD90HBgZ29ciBun+zKH1+06X0Yf+qu1rXGohxUlgTxLL6gZyZOom4ebBdYYCnCJiIcGX3BcDstK149EfhwV2r+nZWKo6X29WLfkOQh4WOnuk+xCtvNjLvXOe3sNu8KLDO82mDHi/jkmUvNqud+WrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/AyOB3UsaKoPgRGLx//dfCAsp8d1DEdoDuZH//HhjU=;
 b=CGSh1ywuUNERrDxGBm3sYgYfi6SNM11CEHxxhj50RrqgrnS3XAx363lKLASkNcYZBntFBw+nSy92cQvTIxvpYRRMQbtvkX4qDyUKLqf6ppDQuvT193c0LS+aLMjlt3wIPJmfVw+Xtey1RJ7K3zDW/xxmPnNu0HaRxPIAEHb3xCnGttEOAd7zD8p9TGXIPhF1lbHe7gtTvecMLvi9xSc6DV8Hj67yKj6F5ufsKUCFXFoD75jz6K27ZXLSEGXqSbsWttepN3/BFkUlopO0DwZVXhLrnsisVhCf6aTnCwmLi65unP25KhANZ2UWwQ1rbhP3sLWpNVv7Wst1bayR8h6vUw==
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 19 Oct
 2024 02:08:46 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::7e) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Sat, 19 Oct 2024 02:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 02:08:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 19:08:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 19:08:44 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 19:08:43 -0700
Date: Fri, 18 Oct 2024 19:08:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup
 in events
Message-ID: <ZxMUqsTLZAXa77Nw@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-4-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e83e24-b808-42c0-02a2-08dcefe2f66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwFdL0Fetu7FJBRPf5uXWMCyc+lNzJ3CBMVius0dAfI/j8KHYNY+oBY8D8hb?=
 =?us-ascii?Q?ILk5vsmeRKSE1tROIkkop75ZLdbCfYdbLiazz/gD0RQpCv38jUa6yidEdYja?=
 =?us-ascii?Q?bdVeI+LL6q1hCad72t5ImeSRoZFeGiBKwpzqZzF0JiSpyAWiz5bbc84slW5q?=
 =?us-ascii?Q?YFwkDhvk769x3rzTZ5oYILcRFlSqsGCyohbO0YPdhBDbpsrw127oIq6cngLh?=
 =?us-ascii?Q?WeBiytJdJj/yFaY4/OXotCN/jB2dCLD9+ywr0zTqvnCMfkadCp2fifFxOxO6?=
 =?us-ascii?Q?n6O15Yzh5LpWZLMurVi9RGvYllboKamgyc0aaB2jduFnYIjH832w7l4mZ2dN?=
 =?us-ascii?Q?mrttjsQRJUEv7W6+hFDNJza25yG1NMcPfNzImGb4Dv46Jnc/yUzA558QWLbU?=
 =?us-ascii?Q?nJg8Rk89famjqEsrr5NVFoQX3hn7W7vCmBvwEsLyHtII4uQUPjVLxeJtbvPR?=
 =?us-ascii?Q?fTt4jw6zBKjzksZFErEgvhdi3dIdCx79uNTRwJdkp7HoYv7wKxZD2EX6qrrB?=
 =?us-ascii?Q?xJZqZxIdazta+lPWd5sms/Cu4n9ItFp2CgbXC43XfRac974PGwBHXpoytNf0?=
 =?us-ascii?Q?4z5DUOAYUY7Uwdx297PkJimeGhGR4r5dG7X0ONjiQZ1tixDb4vkiUmUplUo+?=
 =?us-ascii?Q?LsC1D0hSLhy6UZ1kKf8CybevyY1Sydu9Bs8LUFKbjSFpr0vAt80KwyNWbUMV?=
 =?us-ascii?Q?wst8ukvaDkVkSuzfDONRpRBFt4atOvr4aUPHhk/1Y0M5WJTUcmuxApifRuzn?=
 =?us-ascii?Q?aF/BXVYx2KFmnQLO79cHXp6RR500bRG0uf/WIDPtGT8vCdBII0Xe7QNtE8C8?=
 =?us-ascii?Q?I7I8dh/+jq5vI6KFaIt/ZX2D6JWWel0j7VczwBik5HLrsmV0zFZzCBJ07PBc?=
 =?us-ascii?Q?Vm4MnvQGmeV1mV4IveuJu446kMYXu5PLvvdjB6Vdw4kldv5wTIoZjOoIU1TA?=
 =?us-ascii?Q?Zj+Go6NlfPctAAU84LdqmCUUfCXFp6kH7CNjt2nMlPJUqxB93iBBj5A2cta6?=
 =?us-ascii?Q?dWHG/G7hoj+BS6v47sMsFtfxcxezuMdTDnpX7UCJE3LxQDyeLh/cEc2ibtaB?=
 =?us-ascii?Q?CsxPsz0YUL99AsirWErKgXBlGK7o8VWwZ6y0fm7IepGOjWiu4MuU/+bREW5A?=
 =?us-ascii?Q?HZ0dB23DAoXFQ3b0xQn24eYeRKpEP6fOE00on7hmSHorWc7AOYxAoUAraUgw?=
 =?us-ascii?Q?OUSAy/uQoezxhybRjvFAjtYXP3YHimgpLtQvAESuIxL4bZmUsb919LFBuWmK?=
 =?us-ascii?Q?3YolcIkMAguQ2JmQ1tPdBmBjJ4dKSKpXaccHHlX1HqVUWkIcFmjajjB6ZlFE?=
 =?us-ascii?Q?VLA8QauFrUDeBFuWIZjw0lpKHTXbjGF69OoR7DsgQxSghAcDR3izKnTtXQK6?=
 =?us-ascii?Q?rdLsCOF8xJWLTuJ8IYkQ7YRGEqEuCKHZpPirXb1JbW7d2jN81Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 02:08:45.3813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e83e24-b808-42c0-02a2-08dcefe2f66c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

On Fri, Oct 18, 2024 at 06:00:22PM +0000, Pranjal Shrivastava wrote:
> 
> Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.
> 
> The call was primarily to retrieve `master->dev` ptr for reporting iommu
> device faults. Since this info is already available in the `event->dev`
> field, we no longer need to lookup the master to fetch the dev pointer.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
