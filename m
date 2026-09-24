Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEF4B488E
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276341; cv=fail; b=iW+BnuOWmSvrZ9b53b/Yj4VbEuALXAPJABTQw+U6DyddTtQ8Z8tcPmZwW/h1XUg10izrLomvMUmdTqmNY762qhNT2OCH1VpmUtdIaRK2zhXDHzlUlJRewbJmv4jTbbO+x5Y9Ux6lLGNQpbs3mEO+FaeZl5jOI2tV7PEdFIVAHuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276341; c=relaxed/simple;
	bh=FhvZ6JbCCB9rFLbK62RQDcuc1D+N2LTdJHc/F0srJOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CADgky8e5ORlwbJH3nQiEjTCtfS9ioWXxMEiB8gOteISi18Jiit1MQFNthATS+CPsls3YxxDohKjgM+y9TNXrp6RdUuwJovuBoS5umGa60593ECqamSIIF1pkCNjyb/dnRKoLlymGKi0gSqDPves1nIAG1pavwCGn99M8d3aF68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXzCn3qn; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXzCn3qn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xotUTWHOOIkU31PJgfsnZbiO5AZT4qKeSfUN3SJGHiQC5uQhUk5q1LG9fIa0z5xHnzeW0spkylr+qO1eJxY9wrhkO4rsfCvh+NdWmKNroEvcET+AoVdycGw0y7ZC/SnJc6ALwQXZMvZ/lz18oFASPfM4nOP84o+FRQ2hP5pZks53O9HyeZ7+RLcg4imZQ+5+uMRIxK0uImPlvr+T8kDhvopxmQP1ivKCBVLoUJxddk6TT9CUPdcN+zSZ9JlehXqzuJirR9EJDv31+aq/b4wu0+gioTpBwCwgL/YpmtMcqaxB4uxmUvjg4/eA8NqR+00MoCgNTF1RSvda/gmhqkGutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIWn0+pbEPFwTFx5ejhJN9PtryYKj/aKFQh/Po849Bk=;
 b=eDqTJz5G3BEUy0u52k4t5Sdkh/r1AJzeDaXgG6LTJHM0oQoBaB0rmA5Qng4yP782E6GwzYg6FeFohnYkDSxEXs7RUHjggbxW9Rp/ttAdwhE/FdMCp7y4GjC2mIgLWyk6KORfZb/blO4yEQRYvA6mtf6yo6p7Hg8RDjgfQWFrauKzhEtd/GKyFcUlEmrWiErhthM5TySRHNMifYzt1c011+rSv0PJXSs/teWkXyRq7LQXbLT8rDRxlq9oJJEKATz3zkMQqvfdS9pr0V2kqSkmBVFWzbTyJhEMYdwEiFgeXN/7C/4mui2MYPMBwNEK4ajBWcsSaMkyYjE9AUCeJ0zt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIWn0+pbEPFwTFx5ejhJN9PtryYKj/aKFQh/Po849Bk=;
 b=GXzCn3qneMjISroheEqDDdBhQgw01JhIa3muAyoKIf+n4lcYSBaF4tZXspKbexpgPwFX4A6bZ5kZB2/4TIbCikq5XOQTb73qTOqYf9wbn0WtU1QsI5dTIcfKcuYGoBtoT57bpESblwrj8Ws9XkdXn79PN5QsLhL/T51OpreLCseY8UtYBXAMcgEvn6tUdZMi6Kim5RmQIs+7GWx9sZ64Csyh264mk75NWc6GwBigxr3LXelVBLFJfQKOInXDqtsU/j2QhqqBp+8BKA/h8MHz3/MUmpvTe4TYM4NDDxY8aE1sCSNRRiS9q2ypWra8r16F13f0zntSc8GLc8lPG5Fw3Q==
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:58:40 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4b) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Thu,
 24 Sep 2026 18:58:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:58:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:58:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:58:18 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 11:58:18 -0700
Date: Thu, 24 Sep 2026 11:58:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH v2 0/5] iommu/arm-smmu-v3: Fixes reported by Sashiko
Message-ID: <arVyyFLTvhLrBu43@nvidia.com>
References: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 622aa12a-2e61-4e07-0d3f-08df1a6dd8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|13003099007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JANtDvNyoM8t8dXIB1n7uWB1axzyZjZrRMYDMZVp8iodInEBh8BgIci+4/goJxSB/bmHpDo8qffTgp9N0gpegooEOrUsCcqicJ4p9HMJL5IedVhCAfLgSq/X8wLVya0tuK5CdJt8YkuWhdGE1bYAXXVo/V7W3bhhUd4+JwUa6KkKu+44Mni59nAJr5YnvArl0TM75z6GXT5aKL7VfIGg7Mx3chmZImZ+YFIluJEqh/FqLy7/J+TyjkXNAAcABogPp+6NYkf0Y1VT8pQYlf5txUp8afFrfWsgiSt8QTZjtv6IyCCHaSJwKdF5g4bNvzzW8fe+qRr4RILpD+GfF3+rg6/DmZVGwNqG0zGDwPtzqd0P3tWlW/sdCvhhjI4pMSYwTxuvkCKLovgyIxM27pIWSarjlXwpXEHNeph5/kZBBXlXcnYyRxg6RAhAJa34WDWWcjkeZKoWFhw7/scSku30+MaSE+RYjG9+g8RA58mB/EfuE5ioVUWRlDAsYYQlX8TMF1HZVA6GUKZ2jxt8moR10aO0I/C6QWie/KHzIbfn7wBrJIno2RUFaDT5xCFO+TWbyer18jsDh2mmS6benUGXlP2T4fiFxSIlEMmVvDN2FgwB8dH2zD/LZZCM39UzHczOPF3c4r3gjev6gi/FVogq+PijoVSthmYRF02oxK8APiZt2UlT0C1ZUOpvC3q6/SASqmlvwzIoD2ViMrR21uBNzA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZVEuvDZJSrcO/q1N/hCBjLUzktZfPNRRdUwKJOLq2fuMx7tbbuYNFPOD1LextoD6//ducn/AJgZOQRholabVn0/meLR57fa5dKV8mBrNjP8oZqSyCAWJHJyJqkjzPuUfEi7MS2znUJBUces/J8IOo4/o2eZyD8DcBo5kCwIbhJFZUl/pbSaR5Ql4VTcfKVitDt/2aAxv4Ge+gZ62ft6Xgu2w71MEpNEUQYCetEyFz0i+IOQOgJjPWPECe0zfwmWGHHcHPYO3JD3XeDd21/cyxeImunu2ukK3rIkF/qZCcaQEZjoKzp+ItuE5DAucEC7XHHXesdJhQ+41hIlrXNWE54QhXEKx0KDtFv6ZQu33kzN8yCQBImsZt93QTYc8Eo8jQmyCBeOtkk3NNJ+QbXMOOjrm0JB3ZK5Ip1XXQI9H3bt8F1Iorc1XShAabEQZtJK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:58:39.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622aa12a-2e61-4e07-0d3f-08df1a6dd8a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

On Thu, Sep 24, 2026 at 08:56:11AM +0000, Mostafa Saleh wrote:
> While running sashiko locally on the pKVM SMMUv3 driver patches, it
> reported some pre-existing issues in the SMMUv3 driver (the RB tree
> corruption and a missing NULL check) and given that this is not the
> first time a pre-existing issue appears in the driver from sashiko,
> I went ahead and passed the whole driver to Sashiko which reported a
> dozen of other issues(except the last one in this series), I included
> fixes for bugs I believe are true or worth fixing (others were mostly
> missing NULL checks or bizarre HW/FW configs I don't think are needed).
> 
> I also sorted the patches based on severity from the most critical to
> the least, so it is easier to apply a prefix if some bugs are too
> theoretical
> 
> Changes in v2:
> v1: https://lore.kernel.org/all/20260828125409.1921538-1-smostafa@google.com/
> - Drop patches 2 and 3 as they are fixed by other patches on the list
> - Collect Rbs
> 
> Mostafa Saleh (5):
>   iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
>   iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
>   iommu/arm-smmu-v3-test: Add missing error checks for inv array
>   iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
>   iommu/arm-smmu-v3-test: Fix UBSAN error

Sanity and selftest run okay:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
