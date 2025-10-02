Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA11FDA
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428058; cv=fail; b=RjKcneg8ryRkmFM7C3XhcMwLnQ6vCXE75nik8XcboLZ+3gruWPi9q/Vn4uzm9uZjSF/wxSDDJmrmHECr9MqZQW9ftLtXyuxx4OF73qMG6z234O2rHjr7yl1zmfTmrDydaqHJV+caqgPHg1xyCPQs2cdzk4RqemJZ3/0P19fV7rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428058; c=relaxed/simple;
	bh=kNRQfJh4o+x3dSwhM4muxrBc/KqFzs8dZgAKSGbVojc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShUbEBYzBbryWZ0iFqn0KeLN29YvLCrD9968tZfMwOcjqb+p2LcM9uiYerMHAiTMqbWGsA3HCQwmauRcQyos8OkOPixcR/LL4XVgn/nmMD5SAWNVrrmUUTJg562cDGc2OobFCkFvJZe/04pTQaU07MqDHIAu1TFTiMqGEomgqyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7fPojGE; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7fPojGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMeXtOfQAl82RJxnQympvm56MYvGjI2o/OlbkBIJ4wH41HAX9o0t8r59p2Yy/OF92ptE6WS1CK74Q1IXHG71Ty/p1pu8ydi3zL4JczTNbtcPNwBXkPI7nNICQ71x5bYUZdHlmxZKy30fPNwGl6L4r4Hdn7jI97yt8dktCuPif02NBq6l9mG2IUnXWMt/GZEZfTXC8hFswhJRXUM9p9wPVgjCPsaqCanEj4yp75sHXhsdfEf/2nIfN6lQwKI33xoy3sUWm6sFfywll2nvuxV74cdvfITbCvodQw9Ie+hOpcjgaBVx4VlXZGU1EDES0psla1SA6O1Jy01fu0PDHX2D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw9gf6CvO21FHUIFWBx+li6pgjdUSPIjkyS4r//kS00=;
 b=dI3A3LdAdhw4DuGupqZdZxcL7Y8x41q129Nj90PPvxmcTieaaK9Iq9D1AsxSMXG8hVIuB0dyVP4o3lyFbMsPJosZHmTapfcvLzM31oSZimIdAfWc1MqxrgZ+Uo5B7quiAptlaNuangAOBD0zox5Rt4t0XZwpdxHnY1Sh580fS5+E/y1QpS+ghR/Z3RnHlExEDXjATFYgGfnuuCc5RsQt/c+dYE2F/X0rsokdtnSL7iz+W+pENJu7HX8eL063srXERefaFegwB2WWRNf7oyyE1tV8lMYJe2D7lkzuXsslLetLAu/BhL0AsqB5gbenAcDG4+tjXDEImN1w54eEmZ+HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw9gf6CvO21FHUIFWBx+li6pgjdUSPIjkyS4r//kS00=;
 b=B7fPojGElZiAxA+tElaz7cbHBE9likyjwuk9skhJ1tg7uP4UrYJwi0UPFnpa7k2o/cjjoy8Rm7P52QyK5t68SgTlcxqgbE81b2eRdiDQGwohap7HgI7Gz+bSExE7DNmgGAvsKtOdE/9NbGLHN3N+JJ8KFguPurDUYeifrcWTOxN26DKF+If42+QGxotVk4r6CumXwgNKMoDvO96313ceKy0gumC9DY9HrmsD/nou0niEDEs+p4LXn9vKTb/Z5rspGWu4+qd1nfNgTMdBmiI7Fg4vsSz3/PCVTD8yVVf5Q6WB1lA6eY7sbzhsEhnIQDDV8sTQJMcb3KEzfTxC+VhbHQ==
Received: from SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 18:00:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::17) by SN7PR04CA0091.outlook.office365.com
 (2603:10b6:806:122::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 18:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 18:00:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 11:00:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 11:00:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 11:00:15 -0700
Date: Thu, 2 Oct 2025 11:00:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 09/12] iommu/amd: Add support for nest parent domain
 allocation
Message-ID: <aN69rkBJS2hIcZjk@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-10-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-10-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: f059aa28-7bd6-49cc-c7a3-08de01dd9d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIobF4Ch4CNi99yCOy0yuCBABd0T8+Dor+UUlEAOm+k4Wnvu+sSvNlyiTn9n?=
 =?us-ascii?Q?z/Rv94kfgQORG7D3cEAagIMr0Z3uZDzPaZ5rjmdbIYqJZAqP+MRg+XY19VTa?=
 =?us-ascii?Q?sEGulGPVvQTrHwFfTSP4Nv/kY/qT0jXKwwzsN7hMAhPfy6LzHq0+YOfajfl1?=
 =?us-ascii?Q?ifkXJVK0JjDAH3Qye+vz9CsNy///qOF5J+xBNkN5S4PDl1DnR9dVLW5KSm74?=
 =?us-ascii?Q?W3xxDSGVjxH/pbVZS/BCWF0gVmyzbMIqcPI+LEGZnv9IdjyCgBPQJ1wgkIwx?=
 =?us-ascii?Q?dpnqOcC2UVKevcrSBsRxorNp7jkp2b/njhpCQ6dAOqD6BPO8UjR7OkMx1C3C?=
 =?us-ascii?Q?bvHcnMimuvaAveVdz+rRC1EWJYm+nxiP3AtJ1hilBmn/i+kyr1NGpvKElNYt?=
 =?us-ascii?Q?BLY+kkbfK9CTT3Y5KXTs/ctqBnjKfPFQozOBgPjnRqYidqJLk6H47jdMdP1D?=
 =?us-ascii?Q?1MLu1O6dW73T1B5EeuBNOBpYOGsyE0l5PAJLcJjqILWCDfCoq9G2Rf0SmVjP?=
 =?us-ascii?Q?XLM1RzxB/YAgWw6tp4fN2QUfAKy81aEMMlJbUgh62uKtD77uJHM0fbru9ZQz?=
 =?us-ascii?Q?Q8teVIgYH1IWssfqSpuaMplL5CrLN299kmUzE/Cn9YK5ca4tqrqqRGyu6h7A?=
 =?us-ascii?Q?WrGSRNYmsDO/NrjfE+Voo9S7K+NZb8hXvXJVQNfMf4UBxppX+bIpFOscTA5F?=
 =?us-ascii?Q?eNXb0sCFbPCJ/jhSrjzVSwnVeyi+GbAhOT1IOWm8mufoo9DVzKRywl+kjLFP?=
 =?us-ascii?Q?Pfr8sNuXAjUUL5Pro4u3BQec4wITDVp3lDCC5CBJ60ze4Qj3+5+y9oL7vL37?=
 =?us-ascii?Q?fUDCOeUnyE0Voo6LcQioefOlURexuMtsvdDxBfLn1YYia9MCNLUZi72ivCFO?=
 =?us-ascii?Q?/nKiR7d49otymyqMDNpLquSsc2w1dYqEh6KThEcaXN2K+y67AY5giGus2/yP?=
 =?us-ascii?Q?owt2q4rfRItmsvrq6Ytoz2CvO/KHwCIuj4z3gEgGdLGb34gBy9rAH6BJEXpL?=
 =?us-ascii?Q?Dz9s1r2wU84+uo+hWEmWBbj7klhBduixBb1P0UHEBB42ZiGCIpdvDt2vtg7h?=
 =?us-ascii?Q?xrqxc7jcv29qXjSFgkM2nq4pD/sAOlQAduxretyJzYkqTEe81mnNUxdLecdW?=
 =?us-ascii?Q?3Jk+HG8jgVYqBXL+GbKt7u6jNDVioyHXxoJvuOObh3Xvv7EW+OPvILDJtnlL?=
 =?us-ascii?Q?i9WBUADu5Usg2+f4uiKUBhkCnEyhqqH1q1KZyEZKbkBmVPjESR562Ivzm3fV?=
 =?us-ascii?Q?f/tk7bZVECbD07S6+I3QzdZqWyGeFDnVCTqe1WIooWRyt5OJVShOqDluLoNQ?=
 =?us-ascii?Q?U68ED+tR4snakYSqrSn3qT0l4mGd0s179NFs01I1krTme1YWXaeOCgZ0TsEI?=
 =?us-ascii?Q?jJ95bhhKDi9j5/Qe/aJj9lFPH78rvRwTkeijNMlLW0QJb7BULMZ6V9FO5+tA?=
 =?us-ascii?Q?ZIWavXM+6rr5H/xnPCaG66WURQES1E5BxF/dtF9IBEYWr68vyulP+VcpPcbB?=
 =?us-ascii?Q?0vOtgEtywV8QoBHvxlVM0PoUqTWj2A0JQ9kuK71l9N+m/jB+7VEm0G9XN1uP?=
 =?us-ascii?Q?eusIDNnYEuNB2q71Ghc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:00:46.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f059aa28-7bd6-49cc-c7a3-08de01dd9d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

On Wed, Oct 01, 2025 at 06:09:51AM +0000, Suravee Suthikulpanit wrote:
> To support nested translation, the nest parent domain is allocated with
> IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
> table for stage 2 (i.e. GPA->SPA).
> 
> Also, only support nest parent domain on AMD system, which can support
> the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
> order to program DTE[GCR3 Table Root Pointer] with the GPA.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

> +static inline bool is_nest_parent_supported(u32 flags)
> +{
> +	/* Only allow nest parent when these features are supported */
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
> +	    (!check_feature(FEATURE_GT) ||
> +	     !check_feature(FEATURE_GIOSUP) ||
> +	     !check_feature2(FEATURE_GCR3TRPMODE)))
> +		return false;
> +
> +	return true;

If the "flags" doesn't have IOMMU_HWPT_ALLOC_NEST_PARENT while one
of the features is missing, this would return true, indicating the
HW supports nesting parent, which will be logically wrong although
it does validate the nest parent flag.

Following the existing coding style, I think this could be just:

static inline bool is_nest_parent_supported(void)
{
	/* Only allow nest parent when these features are supported */
	return check_feature(FEATURE_GT) && check_feature(FEATURE_GIOSUP) &&
	       check_feature2(FEATURE_GCR3TRPMODE);
}

> @@ -2591,15 +2603,22 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  {
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>  	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> -						IOMMU_HWPT_ALLOC_PASID;
> +						IOMMU_HWPT_ALLOC_PASID |
> +						IOMMU_HWPT_ALLOC_NEST_PARENT;
>  
> -	if ((flags & ~supported_flags) || user_data)
> +	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
>  		return ERR_PTR(-EOPNOTSUPP);

Un-change this, given the code below is already validating flags.

>  	switch (flags & supported_flags) {
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
> -		/* Allocate domain with v1 page table for dirty tracking */
> -		if (!amd_iommu_hd_support(iommu))
> +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
> +		/*
> +		 * Allocate domain with v1 page table for dirty tracking
> +		 * and/or Nest parent.
> +		 */
> +		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
> +		    !amd_iommu_hd_support(iommu))
>  			break;

And add here:
		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT)) &&
		    !is_nest_parent_supported())
			    break;

Otherwise, this looks good to me:

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
