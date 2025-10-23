Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DA1DF25C
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186474; cv=fail; b=XgfikbGX6GFy+PKoZBXOwTnXKmLuXtdw1HdD6pp1O2axwiD+iaGqXMd4p+nwpFQh7sl3dGsZmIaLRZyPgXhwRwv/CEtEjteCu4RePZ4p2ljIlRrtk6Ccln6xU4acEzjejFsa1W6Q2QCAXs6Y8kT8MbCq0Cp6KWv+KeQkry9D58o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186474; c=relaxed/simple;
	bh=t2rnmPq9L2payEUsCx5jv+t8FsE1jQBWtCDMGQfB1fg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRNz0c00DNBlQobp846JseOu9B/1uMmhbz/9Ty6T5z4/uPb2PSR5sLglrG2TNZ4jUSKxaDzBQExIwCPKXpdKEXWmI4wUzAkOTyRW1vMvb47V8A8PY1B+i2OhxoGBLlfBxz9E6nYiHhc8qM6lByRsnCH2qszas7e+GJMGoJjn5KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlMF02Op; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlMF02Op"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXZ5CCUVIlS1Mdo569wfOqrS413eCeWPWx0eCVQze2Wqzw91Wz9op2d0yqq8jb1GntQeOvPlqpXdEiM8TerYY3crNqZlzcrvoEqg4WaSNWwg4sYwrTj/jAu9fmBzWpzHwZgsFabl9cadkB3muYt+15OSqddRDdAZn5RRqzeMHXEX5CewcCCVxxPAMSyL4t+Ejecreo9CaZbe/xdjlE/vLkbjbIx9TnX5vBCBwsuAAz4c1SWp58cbJSfdVYRynkeh8XeAFlSooVUzSy4IkhrHVHkViOYu0lc0RILZEBeR2dqwLwL2LcAAcTNTUXYYDQqMpeL98XXNA05F0G4vX8MX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlBHEozY6dIZVd06qY3yW3R3+XE4G/jGuAu4I8f3jUw=;
 b=EfHHF2PZaAUqhpvlF77terGdkHtt001Vq/nwNZ7mwfIqBeNgCAqaE14f8hcEwgLLspgk2eDNwEs7M/xjhzKmHqWmHf0kxS1H9P1gEZ70anWrsZzsL3yr0TA10R0JwprBCdKaEN19wwlXRra6XzUzn3NJDb9s4SB2+ttMK+6Ghf130YKoSu3u1tbCIYB3PMCjjhAcfRsUZen6qI34gqouvswXRgzMljQXyIYsoRaPujj0OqAR6R0EW3Al9VPoiGHJVg0U9S+LjdhYvQXsb76V3RIvlpXADvAhMRUFFHyN4wuoWAA+sWH0HiIcjo53aufA8u1j5+e/j56KixcMeRc0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlBHEozY6dIZVd06qY3yW3R3+XE4G/jGuAu4I8f3jUw=;
 b=NlMF02OpFgucf13NUdJ0rtEL/istT0yqAe5h6zC+yoEwtWoQXtAN2oqTQN6MYwL55L2ozrKjyGv4FzkohN2f0nfhxLw/wPcjSESxEyfPlflbOXpvhIWMtFElOaQoGS0U/pFU5QHqS/dZdq0B6LD0JKqYnbzM5drKCv5fbpz5Tgx5Igkb9lLSXuBP2oEbE88Rq5kKQNHTcRwpMNXzR84X/RYPryHwULRWVFk94zmTAeP6ngkB/wgZM5nV5wo4v6OU3gaydzaNvztl89hAVrNLNS9l88GiidNkKYKadm9FZY2SZH/CEePXhLCvMoSf86FzO9Fhiya63vEy1eJ5dhP7CQ==
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 02:27:49 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::6) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 02:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 02:27:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 19:27:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 19:27:32 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 19:27:31 -0700
Date: Wed, 22 Oct 2025 19:27:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v4 10/16] iommu/amd: Add support for nest parent domain
 allocation
Message-ID: <aPmSkeRCFOw+d4Lx@Asurada-Nvidia>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-11-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-11-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5f558e-6520-45c4-4c5e-08de11dbc273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYMi6OL/Zs5ibwN6ircBGY+8VVCVu1kAfFy1GZ0f3EK+cH096EK1V/PIvGB+?=
 =?us-ascii?Q?y4PAZEbI0sfPtvKbUySXnPX0yfynjKqpOheoSi6M3sSBOUOkpuJn30m8F027?=
 =?us-ascii?Q?hHnC76+cug1ZeqoY0SYgnd2W/Q2kEkvyYG9qgytQNmeMiY30snbOTqOOI5wa?=
 =?us-ascii?Q?goheEgQ0WJUPT0JHbM6dos+GgFJ+j+M04IMsVt7hT27q9KBWW9DoZghBOLPs?=
 =?us-ascii?Q?Wk/eaEBFEgdHzyDTcfUe3uRrf+35LdychtyE/yvR7WuOKqFMjTj5Ba80rBob?=
 =?us-ascii?Q?5C6vmyZ8PdMz/w2FaNAkglltP9P87TiUoM7WZYGNGB6SDNqeV2uKl1MndP6C?=
 =?us-ascii?Q?l7AJqkKpxaEk4AR3fwW4imzUcyvcO2zCXefNkMQcvbZKRCElk40WCpyYcEUJ?=
 =?us-ascii?Q?TEbQH+RtCMNLTMg3/9DleevDGcnyV51DTGHatViIAnTCY7TRClyjPoz32l31?=
 =?us-ascii?Q?2CCoP0sgil5kqC3H2vLyz0bz2uZlx0EHY8dujw+UKFiQwByrBp0XwDYEYr6N?=
 =?us-ascii?Q?mDr6J/coVb863dLIAHu/YKcgv0x9Hu87TCKuz67XVz7usKDKTagHtgHoJCqH?=
 =?us-ascii?Q?oaeFatMZGMYnHHa2dyP/luMfYaawC8IVGEibYDmEc357DVJK02/xdbB2a/dm?=
 =?us-ascii?Q?iLSqc6wCIPnrZH40f3yvguGesLMCdl5x42AN6ihgM5LF3RPDr+9mrVX8rxVO?=
 =?us-ascii?Q?0XfxHKXYbbWMQXTh1OdTAp0AtG63Dc0VPXu/uvwhEl6Cf1bch9cg35a6kIuV?=
 =?us-ascii?Q?VIYJxcXOOR5FAb6N9LSpsdhyiqNLHp+7KID2rUqip+2wapZz/DPEFFzBZUR1?=
 =?us-ascii?Q?JBRO9gyrGTIry0rLyTi6RwBvKb21XR/2lcV2UFlom6x+DpNs4TsyM0Hz6J7Q?=
 =?us-ascii?Q?bDkidGFZ8/D3aOOBHNc+nP+MgGFlfXE/EKiTRErseWozxACkdW7c7Bq6/mFy?=
 =?us-ascii?Q?PvT8C294IDqYqd2Ok0biw73gV1BrCvSHFP7dvJCdS0Su8BPU/nY36vsr6sMV?=
 =?us-ascii?Q?pvmNGs1kI3+Wy60vl1p37NK0/0yuOyR1wx/W+U+8ahjieWN8hjKMOjFRO5We?=
 =?us-ascii?Q?4Dc8GzY0L1cgCpjSNzoDePUMwDNMH77cHMUCtp6huMUmbnuG/jZ0LrqpRDY6?=
 =?us-ascii?Q?dWX7heRfrEUskOLpUEr/mF9iPqZvkAWKuzixfeNosFVUEjNIMhPV9RXOsLGe?=
 =?us-ascii?Q?uiuWhcAKSDzEdDBSoOz7/2ztgCKcDj5nqVd3wW03AZUFxRNOvCiw04Jtel5q?=
 =?us-ascii?Q?rabq/bFlm8d+QQ3JVm0EO1Yw/IEYqV3OhsRkE6r4GIp5zsz6ezrYsbDHjSgH?=
 =?us-ascii?Q?Xk7GmzdrVQk0BFc4A7uQpPZ6Tx7Qx05s6cu8KTQJ8/DeWjmZCFNqC0c5D2WS?=
 =?us-ascii?Q?jJFfCAr9AIUe/K+eZgcTvygI2jQedsaVUkT5S6mrfaJMQxNx6DFa2TTk71NM?=
 =?us-ascii?Q?W8ql/DBydTGqeEaPxaCX0xLPI8FeKsXJGjkJBchoy8QjZnxi0Ruu7x0e9MOI?=
 =?us-ascii?Q?YpI5VrcMAl925z9dybP8wntUT1dpL9AXFhMY1YwpDwpdIHTzjDoTOzzQ34N4?=
 =?us-ascii?Q?XME38c9TvIxzYBV3X+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:27:48.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5f558e-6520-45c4-4c5e-08de11dbc273
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

On Tue, Oct 21, 2025 at 01:43:18AM +0000, Suravee Suthikulpanit wrote:
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 9226edd8af69..c34604cf1811 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -107,6 +107,7 @@
>  
>  
>  /* Extended Feature 2 Bits */
> +#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
>  #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
>  #define FEATURE_SNPAVICSUP_GAM(x) \
>  	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)

This now should be moved to the previous patch?

Nicolin
