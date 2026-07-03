Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAB35AC33
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062716; cv=fail; b=JV5ajd7E/1wOHX1yqYmUZMqHmdl8Y9EDeH6puRK+ynDybXSbkhQOhEo6aOsMG/SZk5GHkV1Zx6kWtFLpX5IqiWnUHqr3Z0K5TlYHijAABod2UdUco07+gP8PAz3ZuVM84CkHVb4W8bvcUHhF05Da8xjDkZSJ7kXv1DAJbU3Xsm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062716; c=relaxed/simple;
	bh=gLrSWBOotrrFxL1UdxJJ4BN0PpPesdUDIiB8L8rzCpI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV3lE+AgGf8MDJ6Zka9g+jheQBfurNmMhW5CO8W9hRNPKe7peYjHPu69xXoZqibnovZrPIfOPn4Sno6JalnSBWS782I9pAsjvAOQ1Jw1u1ihn3agpJHD6KgxpjmGrLJ9wc6CVObbGV5aVUGBHSeBgtioMDVNELmgNQWPVG1x+NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mPu4msqI; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mPu4msqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imoo0DWEVJaMgnQiKhCeIfvc7s0B54jaKJoXAHChnBFaWNyK9DTwDzgiRN2DpdTy08oGdBRsYUJGuXYCnaRwEKix9Ud5tptxWOJB+eBlTiOHYvut8P6eId9uui5fZ5qdw8weWHYF9OhNXuZKk4b0/MsYYTdadtHVoLbssrot5gzJkqgct/eiSFGwo+T3q7w9387psh5qx/xotwyIInILLtXEFkoaJkjOdMLeW6M/OFjftXMQNJAF3oQcFl+n+aKDkx6ceAI1bO1tkKLYaqKqt4weB4RgC2DBkvc/8voUeJ97PMNji1e4mpNmvKDmsalUqfp9ie+sgMGDyW0zzqxHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWg/04MqwjzCxR/RY+YjgQikjy3lkqbePMHA2J3Jc+M=;
 b=sBaNBCoipOJTxxWQ3qryKIOE33DQR4i5QdaPPoDMgTUpK33Cd0JegfTGhwby50Stb4ByE5l8Tj5sZvRTB7l1YodmIJgm2YMMtjbGN6X/ZlnAdcKhEVmHJbwW3R5zA3xWRrZO8XOZV6t7rd5zZCalaygShxoWE2I6fnSrIOKjdYnQsLIxYg6CVNTTwFPpZs/7X6KQel5SSspPoSdDSsis3AorYj5d9PmlxMHOmwburwnAvEPvvbugJRE84tWf31X9d1dR7N67PS+yJahy8WAAbGnaSEVbOVBqVQHHMpn8jqE4Ej3BMQrfQb6WQfnCKSp6h/gwXKpH5aSVDX/6gvZiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWg/04MqwjzCxR/RY+YjgQikjy3lkqbePMHA2J3Jc+M=;
 b=mPu4msqITOqexgFLLv7CGudmSKG3D3uUi5U9BFUuNr9REHPoyFyrdPkNdWKX/frModlDBPS5Qkeq2BmtZcAgbC1E1AHwBi763wdaFRbEz888+qQTLGGABxysg2LSnbEiptPf0MGOtUi5cXphj9mayKCye+aIXFLuxdLyADJGNQ+mOvm3KZyXvXrMn1UuUdfw3eEUA4N0zhcTItd7MCRo/4I/9fvQ2uRYJqCUYbJm9GrhAfii7ZDcgRT9mafPdvIxrXy494fBg6ws9o/obW7fqlCRzsFO5yvRsT3tfUlcYfl5rwvsrUQnZzutr+pRcCWMTy8QQ+T4iZ0jmzKXK95GpQ==
Received: from SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::19)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:11:50 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::4) by SA1P222CA0089.outlook.office365.com
 (2603:10b6:806:35e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 07:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 07:11:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 00:11:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 3 Jul 2026 00:11:40 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Jul 2026 00:11:39 -0700
Date: Fri, 3 Jul 2026 00:11:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 08/11] iommu/tegra241-cmdqv: Require exactly one
 Stream ID for a vSID
Message-ID: <akdgqcheFwS8DnfN@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
 <3177c49c4d9f24b1dc001d54b5ac30e5061feb7c.1783054570.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3177c49c4d9f24b1dc001d54b5ac30e5061feb7c.1783054570.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: d81c282c-5706-495a-b8e4-08ded8d25a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nZE+V/HHACHT59sGzIY+pwVNVwPqEFjT8xUrFDqiHGkD4+ZV/jFKmrr2ZuIYFSLcyxSAkwX9eIBcmJBiXKdi0gJab+FT3onOFfLSNVeOpMe/sy0VIGxXuA4gk4HE5fquQ1UbbtUGMTnWMPaFh7jj38ICmcvxf6wZ1jO/fpMIEZ0wBEFomoIPX+UBFFdmyz1OLkJjOKry5/t19n3V8DjCyPs1yhaGK6bkapJRFALV7CYaggi15aoNb6M3Kju9PiiEDK5ysskEao9T1g+DlAX9/YBBzb9dCS1Jsli1Qk4CRssGAEc2eqdXwg2ijKEgszE4Jd6/usQaOJ7nubUI9q+eqZqXkseESXKesdr4Q7GHA1xlqBoMWb5t8ud9zu93wDpNNQDUGf4ELgiIIIRlYwH6jDHcIKvlzyzNd6chEOl48+QHN/XhBRLe3Kvb2a1Lywbm6l93ABIBOSoe/nz7L/nLnUJYhcN0ZWxD7MlT1NDlv589NKRLe1m7x+Ae1uTIg5cb5sR5CIKbyx2c9nnZXi+q+TSwCJONbeNmcvkqlZor5zuTV6A+zYqh2gBXALKwYOnIroUAn4TalKczLm56UnZICaHvvqSfsZbbp9++zzdKUy1X7nVm7WiXI5yMErFUGjU9cB+lAbJtDJktnSaLnK0tUtSqoxlowztt2a/4tPxpVnieO6up/C9SAdG1gkijgkRwxl/9gJOGApbGUzNV6EN5pg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cOD6yAod88JZnYXftyjR+xDl8ymuVgmBXQJflq4mSP0BS+J509szqiPwIE71IHnTtEKhr+z9Lb3AiuKH6l0ZT27bUaoRVAr+Gy3BzKmmOXLh2QBFjz1pmVSCJygXWxfTAcW0Yqx2jHaow6A1lLS1ktltYknBOLFsM+s5vTLX/bIpwrWPPdUO7LYXzrL4oQ1p1Q10eJUEWCYN28c2ebR7SL3wyyuTjjmUtePoBef5jiVxzg3PHEivu09PGUAydErXXwd7mEGQM6wM0ptdM6REZJr1O+PFE66SDJwWqUlzXPR0nNzqesqND7y9JDo8MK8BjxKpBmjKmTqsXSSMdMUJmj5eYf531em1W+ca8Kax2TbeMWmouAjQBdUomU8BBWsPCWLXWAtpfHM5DfNZArWt+YIvpwAf4VxgzhJIdZVFyQZkgUNqMyTKvjETPwUQGLxb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:11:50.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81c282c-5706-495a-b8e4-08ded8d25a38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235

On Thu, Jul 02, 2026 at 10:31:34PM -0700, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 812cc500b4a1e..aa0568e328356 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -1249,7 +1249,8 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
>  	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
>  		return -EINVAL;
>  
> -	WARN_ON_ONCE(master->num_streams != 1);
> +	if (master->num_streams != 1)
> +		return -EINVAL;

Kevin pointed out in the other smmu patch that this should return
-EOPNOTSUPP instead.
https://lore.kernel.org/linux-iommu/SA2PR11MB4844DD8A0367D8E909123F868CF42@SA2PR11MB4844.namprd11.prod.outlook.com/

So, it'd be better to return -EOPNOTSUPP in both places. I'll fix
this when doing a v2.

Nicolin
