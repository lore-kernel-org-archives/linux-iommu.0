Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E832C8B
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165920; cv=fail; b=dNS8ojzvXkfhAFdwUZN4tV6koawa5ukYqYqU/q0u2RKYwR3pY5BWnVGxQ51TDBfEplFa4muScQ2Fqs+iQgnBrdLL2YrHohC7eCxIgkzlceXO1TwMG8s84rB1gc2vDQtLR22KUcr4odaS+SxQNfl/FnGZG02NxkeUfNBZbuhEG7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165920; c=relaxed/simple;
	bh=0x2w/XmZyRqjY92GHdZXYeGE4l1gglEMrBnCnxDpbc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+yDiULW+2BdrgZuP0CXPDgNZYTkJKStHdJVhn2t/VX4Vv93ikEz6XAcK0GQtwn+sj6pBPXpgwwoTyhR/oVcJdxWKIT6tMCJ/YcANjqoqH8Dzx+BWJRLMuvyRASCgsfNpVeQL4XCr63u/i0sj4Ji9Jy5XuWm8dRf1vtCoMt3MtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R4nRVRw5; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4nRVRw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWyDlyOZ8GuNSAOAlPTDxqG0/o9W3kSBmN6lKdmvM/1yyE5SNih7nGgf0QJVpiWziXtZBidcVsC3qWPaomI9pxv2atUWjN87qQEjkST9SznrNYxOquPHCYdI6tymahPXbjjBG1VIdPooNW1vPrFh709WaGBXMmu9hqMaxMzOmLdLMKUaMkO4KJEUE5Dt/ZslgW/0KwBOdjeMhuSBMdjgyREp15manpV0wpe9mNqCXgREnUVKP3uIUj9LVfpsJhWICZXx14mMo5mFohB0WnqTYC83Crh0EVFp2/HvWgE2AEipvDjOPynRT0Nl7C33cQQLBcEpd5sHC8oaa3wMhr0R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB/bFF5a75Ry5Lr4LAvTj173wUEX02qg/1ZG8PutZRg=;
 b=T6EoII/UtnPH8FofFm7u5jBs2PT7DJNHhr4FgfaGvGY/zxZQZY652c810iVWYWTWauiufBRF9Bi6/qpLAk9IobZZhXAKUazQsWTRJeSGyyrQwbp2rADKmMOJQHNjNZ5dbzpWFw9r9d1KOX6AwNpqN/Q1l3eK1+ObGwNBtmYAyd0oeEowOj7mzaoyeMizple7zk1tOUrqr0NM4zPoevdeqO0jcH8pWvlRLwOz8iZtDa1hxlxdfZnrrTBXREoSpBwwo2jpo8X6hAnkAxdiTWP2xUzNUJk+Xr8mUS140zz+sGmuxFZBYvhjTIu2Wx1tpRM1bsD3LDArOkwclrhRGSnUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB/bFF5a75Ry5Lr4LAvTj173wUEX02qg/1ZG8PutZRg=;
 b=R4nRVRw5+JWf+/AKYcJuBv4MTpeH0gQCSJ0hwyC56KLCO6mmfVALib6BzX+F+UFGmG5PsWdUoQFvam1vNJbgMoNQuN/xP28uhxHrKvCvLwvu3Ip/aF62GdJBMn+EAEa09Fycrtd4gIvYcvRlANEZARvbBSonud0ZnxC95W/S3rImciWH1OGuG90ePhwnU49Kk07kaXmvGjOIJ1/rKFfk+pKPaw9gloARWyQVeOHgH9t4Qys4SGI4sN2izt5lQiHRBU6uFM1pIV+loNbzpGmMEf2hlnNRxqgTnRyyST62YgnGdg2nWV4D7lPJw7RAIIOhJiaLxLOyJ33h+50bDwWRQg==
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 22:31:49 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::1d) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 11 Sep 2026 22:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 22:31:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 15:31:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:31:32 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 11 Sep 2026 15:31:31 -0700
Date: Fri, 11 Sep 2026 15:31:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, <catalin.marinas@arm.com>,
	<mark.rutland@arm.com>, <puranjay@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <rmikey@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH 0/2] iommu/arm-smmu-v3: SMMU hitting kdump mid-air
Message-ID: <aqSBQKDoUTy/l2d7@nvidia.com>
References: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: a869bd19-7c45-46ea-48f5-08df1054785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|13003099007|18002099003|6133799003|10067099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zoa5+cTi6l3biMFn/40PXI6Log/K3zGzjV1DfOTpNm/+/83O4EGAn0pSMvDcjth6GSGNUHJS324hmyZ8kvX4UgnwPhYKykVHXJILoEu+NoQs9+3bBk6WZcRUQUo5iSCU06LGtUCEU33fYn7fXDgpTh4QEydgMfOHx77COQr1Zi8Yb+Xl4oPK43kGbCNEJWSzZpqx1ZNk3QErRdtbg7LSEzw+C8ScF8vsbZz33Rgm2dRHGhpkg8bwIVgOdd1fJ6OVqWCJebrFMvduorTxZlEjqk5nh8nC1EzsOblR1IUlGOGp/5IjoYdi63uSLhpBMhSw0BUq3wYbACksQB/sIMx35j8QP9gX1VKt8kaoNKKHDeBqHxYfkskBVnxB1pAv8zGA1KUschzSO9am3on3pgH2S/+HiVi4QmbZrXekYIyx3ZsbafJkH0JGe8wa6bZH6O8mH2dbsHKj5n6mTb7o97qZxW3R+NYLV6dPeEOclXdMP/sDbKmfTYCt74/TwJHXkZRKxCybPJenK4nYKhmEe2gzPLfzaAppyMl7rBrHFkDVvn9WaDqcg6g9TiEdhJzzDlUZd6cE1ZYihudx1I25ZRplhKiSB6jb8q5JcNNj8FNo0tfwPqqVII5+9IjuN7fHXYzipfal7UCBJ/H8nuy0T/Q9pXEnv5UZQF1M4bgVM58v8mRqNqikFRDw+gnYpEUfb3P2pokkKOYTYgDXACNTnEX5qg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(13003099007)(18002099003)(6133799003)(10067099003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2sHbxPeUNB3++pMx/DgqAFOJU6UitU9Hks7OnUDqjC2pVn8A9Ym7jmnBhOJnDlYVjexfBq0j+bTZfg50vaDa5G277wc/A4Tsi/shBQUX78UZzenWa9rGqApfjsVq5OO/vFa9FddGyLD44YcuAgNWjK2n09Wuvvh64VgOCh8UiQoLGWCBnwmhQo83oMADVfIIsayDuT184TclptKtHy8RmrgiTSEYYYZvrxPZ5QB+2ZQWfyD3XF4KGmYnm5fQ1UnGvheuolUBrJ/Cre/+xlPA0bS+3anrqVahZ3G4ri/Zche6hJS0PgmWsOOy7tdXhBMDnpI96oOkSw7Rh6a4gVM76rCKVw6XhfGPLXd5qOewwePw4vDtDg/8Wl2UdPAvMNXeOUK+wQ5GUgYaLRTjmBmZk+jgquTpGO+vYEhG5BdrVH8t7KkIf4Qn05SiehOZWCkB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 22:31:49.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a869bd19-7c45-46ea-48f5-08df1054785e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

On Fri, Sep 11, 2026 at 07:54:43AM -0700, Breno Leitao wrote:
> My lovely robot and I came with two patches that solved the problem,
> from a practical perspective and I want to share what has been tested.
> 
> Patch 1 carries the previous kernel's L1 descriptors into the new KDUMP table, so
> those streams keep translating.
> 
> Patch 2 stops the core discarding that again: iommu_dma_init() already
> enables deferred attach for a capture kernel, but the core only honours
> it for drivers implementing .is_attach_deferred, which until now meant
> amd and intel. Without it iommu_setup_default_domain() attaches
> a default domain at probe and the fault returns as F_TRANSLATION.
> 
> The x86 IOMMU drivers solve the same/similar problem the same way; see
> commit 38e5f33ee3596 ("iommu/amd: Reuse device table for kdump").

This looks like my bigger series:
https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/

Would you please help check/test?

Thanks
Nicolin
