Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792818A924
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706474; cv=fail; b=PadCR5Z5l5rFwXXCCy06BvVWnNDcj/jkU7gIJV8Rj/tXEAVA2fzXfEWu3km21YSTqQwzcMWQeXKXR3pi72sSZh/8S9VK94jA1GKIiGPMXTCW9yhYNDQP/pXdxaw/knkg8Vn0kH9MHRryHL1GDSGZc1J2Wxb4hsSxlKWkDULsfjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706474; c=relaxed/simple;
	bh=mR1Wdkbf+6G1JYvd3K0uXK4OsV1wEec3q5MeZHbG/Bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0ttBjvi95g1mL26Lj0TT2IGE6n7HSSiNZvgnYZhFd1x4NCBJp5cIrIzo5dz+21cMdgPU64nOiSPBklHLD/Wh9/eVjxfIlmvWJJgmUgOB48WWEC1xYMLaE/DZsC2rHKjdN1wJSUHjcwNKFCYL2MOP6pSio/+RS3gv1UPAAPSo2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7HZX9bS; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7HZX9bS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnrivj2LVx5gDeGiwVXicjzB26tQXCRHj1HokTlm5XztaIX+6cyac/GpeawEKx993uVo/IaGi3OvPI9HU9BAzuj/bNXnAIF2PcFjRpHrgW00zyRC6tI3IOvuCwT9BMrAPa2iGIhi8S3LCV3RWhaElHsU+4UKgHIevN60UiJvfxX1j37k3TppRcjI1LrzwhV2JGKrpj35s3b1xdYf3j8Yd6h2rLnya0czqYXwFsBHlL8RcMPLK4u7Ag/wDA105H1B8tliTx+VIxfdZxgurC2Q0AaEKPL8yGpBfUgq7lgAWhHX1QwuYnrnmXZAhQE/d4HIjT3U0RwmkUSmGM4sRuPePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVy29aglOUt3R4mi+ShfFyvlk+YNUebz3fy1kcLoQJ4=;
 b=b4w8p10gEX2qrnJ+w34RV2Y+zqXcymh55r5PVMKQjdZ9U9MVnXCbvvtB7kIm+8MSsjVgJaNhMbzNyna9oG/dv1gOAbrcfoyMmclRDSYUGe4HP+5C/QTWpmhAnSqxvENhoEL7yKQQ1G4U1M2m4WgPLLgkR3zDI85n8hug/gN3PW5BO43zy0laQfMEOkvkX4lzbWcNpUefyCufOZp6vO5AjQ/SoPb9cNcpcAYckq02mM9TFiKNMpUGOD9kR/O5BdjSNDQRU6OdCdbwrWj4+Tj6RwYzxcy2e2NMgmkG6YbL0EgTbu6YJpKY4Fa9ZPqNLTMPj2PpTFnCoCPDPwOtKHxaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVy29aglOUt3R4mi+ShfFyvlk+YNUebz3fy1kcLoQJ4=;
 b=e7HZX9bSx7BvlE1Lp4bIZZwqd9NIo+5Fu85tMdQdpSQ3iMYg/r0VZMmIxu+KaMdT0B1L64vH21H8yLRKoySUeGUU1xkOPcFtbwNJ+b/4FMGP63O8TnWvKrDZr52l5K6IDDtmQ1kyMNm/aJISW2pDE2nlTHmJYLlAayTaPq4PMTTnEOxM/KLk5iiBpLUDljBOYYy4Ork+mT1sL46XxZTIYEbtw2p+rCzJu3QVRizC1ecIRFoNPuCgp2eQbA8Jhagtoe+hJ4x1tv+THsFxMjwkh9WYVOPwEQwh4rEwwDST8y9GulQybH6RUIbJijISW+hfmqcHSZSpWUyvbvLKxnrzLQ==
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 21:34:22 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::3d) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 21:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 21:34:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Nov
 2024 13:34:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 15 Nov 2024 13:34:14 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 13:34:13 -0800
Date: Fri, 15 Nov 2024 13:34:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Zze+VFpGNaXepFWC@Asurada-Nvidia>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZzdJAFc_8h6LfVL7@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: a6922fbd-3e22-4d01-5e90-08dd05bd4500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hFiR0nIMigkLLQ3DGriJvM+0HwhhY5TB422sgidoDjIqoe8M8KAzI+/2Y20t?=
 =?us-ascii?Q?VM0V/B9u2STmaX3qYcqyz0U46ftiKGSdN7SIf22Mat9S4UYfNK6g14zcFHrC?=
 =?us-ascii?Q?SAZR2+Ph4y/pF6etaOppP8DEmKTiqihZHdAlAknNMvG+IEQBo32/wHMuOceh?=
 =?us-ascii?Q?1m68YMkt2NNrwJnY3Ncor2EMMNfreFZ9qZPbtjSgUGxK3OsdjkxHb3vIEqAJ?=
 =?us-ascii?Q?8wTART/UjRbhqDJk0t+ZEH0HBYFxdNXBJKjUssWwzV8vVmPPRoiz9FbxRHI5?=
 =?us-ascii?Q?C/tmslKEAXapwCyK/yBduOCxZ2L33MuskEmIN/c96XJFCbznzSbg5XXd8YJU?=
 =?us-ascii?Q?675q4XlNtN5uKykAByyrlfyha3Ns/hjWdzUaEKaTbgfTkWbhH5CYIKCyvYu0?=
 =?us-ascii?Q?s1uuAAOXAAv3Afe7eydpCOg+Si7lMJo7u8YL1kPoxXjFpohenUxoTk6CSiZY?=
 =?us-ascii?Q?mSqUtlmLUZFogCqADDzwRbmYiVFWiM8Wv7c93ARp4uwYNcT0vpD028chGAZv?=
 =?us-ascii?Q?kAN53Az8x4XOMSc9amqTkOdWzXl/qynE8od7ANpFY0LEybYnyQLE8qOoaCgT?=
 =?us-ascii?Q?cpaCqnoZp1v3NmOFlat2RQUdy4FRDujQkQdR9/rLytBe6wRSsL+/kVHoYK/o?=
 =?us-ascii?Q?TTMImR/qM+DtX1qgqZMwD1OtrD4V8IbdkOw62PIEZb4d6gwvYB1a9K3Ii//y?=
 =?us-ascii?Q?NoXiyZODD4Y4kvyKZC4J07CLxIUzM2IV5+MriFbVtD6ZMju4KdtZNvTl2u0L?=
 =?us-ascii?Q?qBywoVZYf3n/LdF5vvfRSUw4Xw4buIG8acOD8YCWzZcYnrAqDuyCPfDPvTOS?=
 =?us-ascii?Q?2PHPu0/L14EZnY+OmLydSPgPjGJNxsdbC2xrdFPnzCKwM3XZsUJwKtFWraZ7?=
 =?us-ascii?Q?WV9EFyWKaVkEOPNZDIPDSSLlJ+b022CII/UAQ0nuejpKOW2qLiSbhUKVetP3?=
 =?us-ascii?Q?Jlh2s+6lqM2v5t8tUQKKfdaOVYmY0wIv7DUXah04LCq3M4wTBRwignaspL1t?=
 =?us-ascii?Q?3ggvizF+Hq6EZEScpXwBr4bXU496XkjxNDUmeCPMaaaUNpErRIOCZXIW3Ih0?=
 =?us-ascii?Q?sXR6BARxXKfKCqxx6qki2qM1FIFVi9gNz7c0Dw+dC/CUl74gAQ/kbiGdz/QP?=
 =?us-ascii?Q?uFrkUvFOHCGGGE8ISuk9pZe4alEApXzxqqATNsUKbLiUdLn/qkUk1lURXAkl?=
 =?us-ascii?Q?8CrbH7kI/1m2sCsch8/RCWCOy7IHAoPHWJFqKGg6jZqncdMD2UwLhgMBNWDC?=
 =?us-ascii?Q?MEDLepS8fntT3vLH/sRTrq2cZO5g4Xj0wVDf3PyWCcTXqYyKIQKTmZsJmhBw?=
 =?us-ascii?Q?RKzWWC8KhEEc4kUW9xR43EJgBkAYqrZFwi9wnr4tfGULzavHdE9sQGVRzLae?=
 =?us-ascii?Q?FqF7kmCOjmxxlLEle7na6slxFgsrSKie+VT3/EK5QsiqdpZNGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 21:34:22.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6922fbd-3e22-4d01-5e90-08dd05bd4500
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > +struct arm_smmu_event {
> > > +       u8                              stall           : 1,
> > > +                                       ssv             : 1,
> > > +                                       privileged      : 1,
> > > +                                       instruction     : 1,
> > > +                                       s2              : 1,
> > > +                                       read            : 1;
> > 
> > Feels odd to do so...should all of them be:
> > 	u8			name : 1;
> > ?
> 
> Hmmm, do you mean something like the following?

Never mind. I see amd_iommu_types.h does something just like that.

Nicolin
