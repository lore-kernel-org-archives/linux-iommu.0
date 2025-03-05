Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35824A076
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196700; cv=fail; b=L1Ra+HJSdwDPadbmV8Kt/joavjIrC9tYP9MhIwCg4O8VjaYFaZ7IxYXy4vyL9ntKaR8k4NFVNvY5FLGyY479/P7fKU71IfjoDgNE4JpdfQgiNvBfAJOB90Re0sz+89+TOGXd/Se3vVA0govBLzOZRIqv+LAo2kXo3ogvqeVIzrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196700; c=relaxed/simple;
	bh=Rnq18rLPB0a4aAC2ElQAsF8g8B1edR0uWwzL2BcxtRo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcWMYCAp+3kNqgFVosSr1VYxfbRvf5r0k7XBricQAr/zErJnstIt/Jml0yO4XFxNYAa96fBbrxoOdDs2YNZsLobsghZhr7vlF5+r3BN+0wSBAVn7SXykfq0fKNownpjMzb+++V2i6qOGQTLv7QRm9r2hdLVQA5MKyQXwJeVpsrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hj6Oz7Hr; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hj6Oz7Hr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwWYxWqERKvVsOkqkZzK0aIzUBXvc7ekAA5InKkQAxT1Wi7WTY9/z4OkAiQO0PCbFIraU84zZs2JIXTFXPKGzYg8yybQzRR6dY6aYEVRT4+/T8EDghQUrx2AyqsADQggnF8mDw83ftiYdZ/XekgfJtW037+JGT6IgwW//ea5PvCHlO5YRYTaaPs7qNt8uyFGtIBqvVeegYyj1LxIep1YGSLJdlp3aAw67UQuNZmOWRsMiyNQIVy+P9Tml2LW0cvFYFwccgR393L+pBQVRfF6YiVVTiNQqAgMBO517g6wNLATgRfZ3TfS2cR4tLnjxWWPC+tIhoS5ytjDJaA/7wSn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjXAoNMzuAcfI1hZx3jUBgtCyTm0EsfKMlVxDBxLMUw=;
 b=P0/8c8kRtU8pOmvi3soK5Vj16V91JdCoQrIWPbOng4gsHD5z0cYf/MARVxMBXZnlnn8sg9nJHZCD4ySvwbopYBEb0SlCHhugLbKhtqhtAtT6dItRjvIQ7m21rLscg0R5tnYOamfN7xS+JHJQsZQmlm57/Q5grzmWbchiFLyU6XrtA8ZWrU37WDZICB43gp653DnsY/XYqmrsSCwBoc3lZF04fPtuAbXfwi+ZTuBdG1j1Kgmlpzw2xFgfW2VuxGued/RBC+vvBY8C+7+++E2sB9mj6wKDvaukkFhJKAy/kcQJ5AUOI69RihmvsxRKS5zUEk+UAB0wC1knN31g5HkXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjXAoNMzuAcfI1hZx3jUBgtCyTm0EsfKMlVxDBxLMUw=;
 b=Hj6Oz7HrLWViixNc15YgZAeMWKlz09MITi4TncyGne/jKeerAPLFn3tB41hiUkb/WaUwjQqQfAUoDzMQcj+8+Ng06phuJsUWyU6btmGo6yt7TNFpv/qzCsxtSopYReEW2OI4vhpeluPZ2mEZuLN5coQOdjqZT8C5D3zEExE4QXs941z1XJ/GrY2rrB+xOTnA+Ejhy59eDGHoNk/8EPv5DUztQ2lmk3PaTEBcS0aRsBKWgfhQaQ1nS90EwsgjjrfZNv6cyXuyHLL9V8Gaj5cr6BSvOjNZfvNeOwZ7cB/SY/eHsAFF2KAQNuaEBzZp6TQEbOFKIIP33FRZ/p3+zXtwoA==
Received: from PH7P220CA0098.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::9)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 17:44:54 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::e6) by PH7P220CA0098.outlook.office365.com
 (2603:10b6:510:32d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 17:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 17:44:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 09:44:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 09:44:32 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 09:44:31 -0800
Date: Wed, 5 Mar 2025 09:44:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Message-ID: <Z8iNfnZ9N5Lczxmq@Asurada-Nvidia>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
 <a95b39a55c324907a7001d3a2cdf076b@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a95b39a55c324907a7001d3a2cdf076b@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 709fd8f4-1fdd-4b83-da82-08dd5c0d6eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V4MaDxWokNhFgnn4mxEleYCfUJ2/LxUM/pruLIui3IXjyT223JdiP8BLARfy?=
 =?us-ascii?Q?xZ0ogKqleNzS79+yihFijhwYtMSZQPQP/Tiaetb0gQPSbBYUmZ/mqnqQG17b?=
 =?us-ascii?Q?WkkNHxFuwyuZI5P/ORJzcoGmkEbB23JMBozZr936jKgwWVvmOQizyXMeDvpl?=
 =?us-ascii?Q?bovaHObkmfjFLX4F8p2FLvAOCbM/ou+OpWY8awUg1U/8jrzKCfp+vjIxX1hv?=
 =?us-ascii?Q?UepvR+tGR4N3wtPTL8TuF9Kth+KXTORICZ2G0XCPJiDeHqaHSnS8IBtk9UKp?=
 =?us-ascii?Q?jRXJbXNl1tVqfspLwbJY5Zik6m8PtiKsE9q0wLGXfl+pRwNmHGpZreRu/f0I?=
 =?us-ascii?Q?3lLQTcdtALYCeJYRkDNvMdpmCFO2ehi+CkXXVZqFuwUO/phFup8ncm5P3VDN?=
 =?us-ascii?Q?pDr9A3xEptX7p6qtTeAPviMgISqUArLULBB/ZIBTtQKHBhq+AFcUavXE/2d0?=
 =?us-ascii?Q?uUBFDrNJQpCscRGSBk012tmp4AqK75G+k2jxXLb/FBgH1QPXnEOEzwuk6Qe8?=
 =?us-ascii?Q?lWfjro0nuHdeNOArAVdyPN2bB0oQ4fTSAbzMIvbyojvYxf418ri4LdxbnsPb?=
 =?us-ascii?Q?N3RSA93jPUdhuOwkQz/ccu+UgMNnJTs8YUsVRsSjtth8Nllag0z5Y58KE8hU?=
 =?us-ascii?Q?8wbZHVsSCau0alhUNrm04zJzrMRb/lH99p4lsM5992Lh5fabqNdCjjgssw7y?=
 =?us-ascii?Q?w/5JtWO9DO09yFChyWMtAyj3jyLbac4TOLHrm7+v+J7rp4EEihufZVbK/0c6?=
 =?us-ascii?Q?RjXEO/D++kJ9cRmmhrTPBD5P0SaAox0r97S9AT6GEd2chPCVrOdC0YRzFKPL?=
 =?us-ascii?Q?FWqvukZwxq0xPBtD53shf0QHLKd+P3g22AiL9mX1aUFERqYnhL9xFVdTj8A+?=
 =?us-ascii?Q?BVlI86qsLku+gkGT/Hwfd49xTwLbjW4ZgrbgongdUiZT0Imtbcq3jCmj/xEM?=
 =?us-ascii?Q?QYFrqtIIaFhtIvI1xu+bfqaimqzL6ff+/HORmtaHFGkKZdWtFdzQsoJ2irW4?=
 =?us-ascii?Q?lm3yG7zUICLysnWDnLMILknVIXYcDPDQX5YA60gy/vPm31l/B1etIoQbVlJw?=
 =?us-ascii?Q?grr4Yvh2S2fZYcyAFJyP5MTJFNBKcviQZrggXZ0N9Antl4MU7QRuxyFxy6sE?=
 =?us-ascii?Q?pHUrTV42KbfTHVQ0QeXybLq7FRHV4s+4REKtZozt51uSbRbJP09HY5ezA8lJ?=
 =?us-ascii?Q?HvU6rOr93Oh+CPFkHb9IW2cQEELlBpPCSNtT6P1VqzZX7tYw2Sv3JRsowXzo?=
 =?us-ascii?Q?71Ln1c7U9N8a2PxtqdATTFuQ2W1k9zcWDRuNXMdplY8+jQklaYgb549wMQdp?=
 =?us-ascii?Q?9zKU9GSY0BoLtvmpJWP6NCghtayzAbYMGuxEwTrDStFPy5Gjw/FV2F1TALAa?=
 =?us-ascii?Q?YvkjGzwmbWD3myT42soF2nS0U0SnCv/m+AK3F/0quDI/dA5UAqwM8Y3bs6oK?=
 =?us-ascii?Q?YZCTHlCQvF8tRfE1aNCucw+3zYUmBXFm4H9PdWBXgXJeC5VG9qrYRKYvCxA/?=
 =?us-ascii?Q?H7g6Uesrpb2t7g4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:44:51.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709fd8f4-1fdd-4b83-da82-08dd5c0d6eb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

On Wed, Mar 05, 2025 at 08:50:17AM +0000, Shameerali Kolothum Thodi wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index bd9d7c85576a..e08c4ede4b2d 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -887,7 +887,7 @@ struct arm_smmu_entry_writer_ops {
> >  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
> >  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> >  				 struct arm_smmu_master *master,
> > -				 struct arm_smmu_domain *smmu_domain,
> > +				 struct arm_smmu_domain *smmu_domain,
> > u16 vmid,
> >  				 bool ats_enabled);
> 
> Now that vmid is an input, do we need some kind of validation here as
> at least vmid = 0 is reserved I guess for bypass STEs.

Perhaps it should do a WARN_ON_ONCE(!vmid), as it doesn't make
sense for a caller to make an S2-bypass STE with this function.

Thanks
Nicolin
