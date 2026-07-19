Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979F306778
	for <iommu@lists.linux.dev>; Sun, 19 Jul 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784494796; cv=fail; b=Wg1UZqDOBjkzsSmEcH8rTsEhr5YKXd6ShWea5xRyLRKS5JH1FAcOULY4Z2We2XNxKcFWDq3aGXtUFX9KFpePS58OeX7tH0iuQGUm8MkOkbjq4TQqYRQYxYseW+Dy08FrsgEEyvE/8UGCw+SyhosrKZt1UN2Msli06RSAyv1x+DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784494796; c=relaxed/simple;
	bh=cWqlhhkqiHQBddnMlVVruKxdZm5qbkFnsIP+O8345Kw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWDRghgjACeLvsrIrmDgFndLNIzEFsScnhJRxLbPFlo2R/prAxc8lUspxFgNAIV5gHXBgfB+W6PuVsCkY5oIl2igjc7aF54dJonYKFbMKubkYcc+NEal/+FAloX6g0FcdwV3zlrskWqed3niDJibsbUD3g6rk2LF88djZ9ASWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ps4+VjEZ; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ps4+VjEZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBXZWYz74cz7BM6Ktxa3xb6Pq1NCxBPrR6Dqme6AlASwK12OLYal1Yy3exgOFsdXsDyee3uweS2D1utKUj1UMzM3TnWqMmkXN95+Vlv1uMBFYvV42BEe13ZkndxfOWcyiRp0Nddi67DtHx59r4qYomRzmtLLtLM+1BbgfnuqqZOphBdsmtvIevK30s7uM2AD2Z/Et/tPKYCZKVngo8q9WVxHDap5LvVsxdc5T07HSJb1C5U/+xIhGrY3iD4QbWzk6UUlu19zGh8o77V0qdzcErvirng5EppFXmmnhwYlMR/dbzUgqxOQvM8ukQ5TX+UdYwK+FTn/LRHEAXKpSf3fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru7BqNSmE7XvtjkBC4D6GiqOGs60UXtdlncVkre3gCM=;
 b=OMsKjsxyvIThkKlLaonFFWMRkhIjOFYFt5ruH1j5qPAXdR4n0qXY7aFJ/Nqb81KCngGJ3JG/YABpazWI4VWnXd/8Fg41gSUrI6BefFcCaMzDQDhxZCfEhIqqmR7VfkV1xfWG6fksPcGneo+Hk/08AFcvCICE/vAmWuB4dd9WuEMLpdg2wTUlUZotFDnQ0DUjUp+WO4vBXI4Fot7Vby/fWc4mh0O7yrnlqSGmLWBCrWPCeixtyyUvqfACzVa5VkGSaXSWu+QqK61KLMOVsp9ZWkUJhtjJ7CosMWghcv7cR9l6Xo29gtfFWulew3K07nhnvqC0ftVHg/sDSh3jdrnJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru7BqNSmE7XvtjkBC4D6GiqOGs60UXtdlncVkre3gCM=;
 b=ps4+VjEZ6/x0xwWc/bWu20xxg8l62dKs7opJF8l0yYLlIQS7NQ1g5kpNzWvhdd4tVHIVaCMILWitTRh8kcDu5BIhcSsy+CtH01ebWD1cTHrwUUZEe2D5mIZUObrbX7lV29EDfyg0Bs4yhko7eZol9xmZQkxw29kJDapqpF1ImA/e+XH4JI0QlnFk6HkMcD63E456V2ExPu9cGxMa/iXruRco+bbwedq/SVX+wM5RDEe7liiFDohdegFin9eycSEqIJOuvSrdFfOxO7CyzNLZxdi9NFv5PEva8w2z1Ppd0WD6c6bI5DeLhGEqfGYQ43k46u9/19gpsUpEI8Wy8+eDow==
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 20:59:50 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::92) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 20:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 20:59:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 19 Jul
 2026 13:59:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 13:59:46 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 19 Jul 2026 13:59:45 -0700
Date: Sun, 19 Jul 2026 13:59:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v8 0/9] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <al06wA8v4p51+Uo/@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
 <alqh_NVatGn84o0i@google.com>
 <20260718162052.GF699082@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260718162052.GF699082@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 085eb585-6392-4083-a0c3-08dee5d8aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|4143699003|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z0E8WHUkYslzC+3J++uJSgK4A2S/pYGn+1wVJSoZAHH5IRaMvMJUHwfDNrL/xdk6V4WCPwp1hi8+gRhCvwwJq1zotN04nOOiH6nu82gj+PU8Zt0W/Z8sAnWOM0mxrb0JQqQOpQJcQNt3av/Il62sujf/iFX2Qblm/rmZ4o5KxqohFXIVQY/rl5vtxbEkRFEC1omFwYcPEhxuWWW1+RyYG1dDp6HFsdGSko0Jfk5C+3T2qbZ25BLNUIcfGok9Fvu/BaGBTu/sZtMpC7wQlLWba2Wc62jFh6w+4jfGmIkTgokaVXEYfCh2S7rtuNlMGS1cN1n1X5iPjUI+gsyA/+6a/CUoGHUgZXhZtRFjeQvF9T50fmxlvhFgyxFjlFwfaV4bIVi94yZJpcLP2eJH2mJr5kf2o4jqnVkJ9tRsehN1B34pQ1sFsAlUSAMrpKO+JHn3GdLeZGgxQkOURimMWucvWDsKrtkG2U8zxpZwpU2uFMG9johuWOIt1+scYw6TozElaJZVTqlC9koeiYYjgZNg33lN3pO97xf3XTwM9yqmD6zU5mST1gp0rCZQmtkrzSqvCdVz7YHLYid/UPGxDDj5GVExBMZpLyPlZKREHfXhKwVPw2TvtVix3aG+6dcX7u9goocrUldFezIL9n3IWSA7G1lic4jEVoV1SIWLbbTOEgSGbIhINxAz+HwKai7h+75Iu+erwXuMAWC924QmwRio1Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vOTSolr0wXbOsPMoRZRjAz9VJteWB4JB8/0dg4B+5H7wBMDVOYlRfb6wj6SPCsn2DHGIERkCxbysttz5u0n07vVAeLOXZ82S1g/Le6gH71vQq2uhuJZAuR3/1Ubu11g7GxzgQ++tQsWwKEev8Y4SiLmj9Gp+mpRVr+/NWfr1a2HQCs+pIMSQdhJIeunNAzPRouJQj0xAn4ZK2Cqselpp/Sbk/a5LnB61wJDxO8P2cgLXQ2dBTT3mGEMSsd+Q6KQX8dFb2Vf9/VuhMKfekC3NdECRzclrYbDj7pcy9xaNtPgAIDyhiP7N52wk31TV7V0kW7zGkPa2Xo6PLb9+uoRHZ/IHqaZIZ2vyMD/AqePS2tMFZ78GIbsSvdQw3nUGQ1I2IwMPE8OXIjdWopMyWEnBJKj4wkgHYACWR8vPKr2wXO0Xj7OdiayT8HPNMge6SawV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 20:59:47.1244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085eb585-6392-4083-a0c3-08dee5d8aa9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

On Sat, Jul 18, 2026 at 01:20:52PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 17, 2026 at 09:43:24PM +0000, Pranjal Shrivastava wrote:
> 
> > However, looking at your approach, I think I can slightly rework my 
> > preservation logic and instead of bloating the KHO ABI with physical
> > addresses, I could re-use your exact table-walking logic during probe
> > to parse the live L1/L2 structures directly from registers, identify 
> > the valid tables, and kho/dma_restore them. There could me small 
> > differences though, for example instead of memremap stuff, we'd have to
> > use the kho/dma_restore API (which can be done by passing some op like 
> > the data structure writers we have?) Similarly, maybe reserving ASID/VMID 
> > can be potentially re-used as well..
> 
> I think this will be true for all the iommu drivers as they pretty
> much all have this same kind of kdumpish adoption logic in one way or
> another.
> 
> > for KHO), I wanted to start a discussion to see if it makes sense to 
> > factor this common code out into an arm-smmu-v3-kexec.c (or similar)?
> 
> Yeah maybe so
> 
> It sounds great this helps the live update project as well!

I agree. I think the final layout can be:

# Kconfig
 config ARM_SMMU_V3_KEXEC
- 	def_bool CRASH_DUMP
+ 	def_bool CRASH_DUMP || IOMMU_LIVEUPDATE

# Makefile
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
+arm_smmu_v3-$(CONFIG_IOMMU_LIVEUPDATE) += arm-smmu-v3-liveupdate.o

Nicolin
