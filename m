Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253349;
	b=Mtrij8KkEnKgXUdAhXHwKGrTftuyKn6BOoRiTCOB5aRxH67f7galQYypGPP66BJcB+sW
	 Yud/ODkVugpZvn5DgJp8IDebEor5HbmfsOntLaxLAMGMeXtn39B1om2x/VrbjthhBT6Xk
	 yQW+HC5Az0kwqbQku8tYTbw5eVyW6aPDfdNaSHQIW/I5HmUPoYzMVj6VZls0XEmweAskN
	 fyNIgDJV/2m/oir9iPr+52M8+sjomm6r5rEzHnaOqlDIc2AeuPQXl9z+8zgwx4PIz3OsA
	 g5BZkItBSZALzM/p6yI9NG0tyJ1ety2aBhKyvDRvaevi2F4kCpv+e1kqjis7RisLutQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LCr3WCOsL13MOjtm+aHMaQmG1DxZ+QVChZmLyUFkF5M=;
	b=gsYpl5X/d22+axNHkOOBanLXhlfkGRkLRRQJggChjgaNU7PS+75oU/NWGDrs5CmwI6LC
	 r9ojXX5KTNotQtPS6SachrYVeCH8+g5HsMnS2qH8OX7HU2rX2/EuCOhO8oX5gkHjV+D77
	 /XuPdPpF2AgiExX+fq/9lrklfBkCvMRMom61KaBmTbSXfo+kbFGIO7sNA9TabnmWhIuyf
	 Dyun0jHAUWgp3uX/TyGFbg+2dxIHk8CRQmMlwhcRrIRIGVVplABzKtY6aCiLU18kHho7z
	 gYjbPsFYgwETiFUOLGXEIhpNx2teUgXjcj0r+B8DnXH+nQgbN7YTIbFKHW8PXE7MsEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOZU0itS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2E606A326
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 19:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A2E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOZU0itS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHDCr2I9Uxb9/7kuKc1cynYzgF9gdvKRMkr1lz2yKWrjT42VaHG81uqwrfdCi+D7dmux2MiinzXlGLNZ9PxqmWDwYV4h2YUDqGrRvTfqyQixCbq94iKd/8AlMi7GyO7cl32yTxMVq2FWUV47yPEJA+HPR/KCrr5huzDr5xRao7CMNKDID/t176RoI0zqSEwGDHXj2r1Zo8UadcuGxJv6lEKruORVcvuxPz84v24TvppY6REJA3OJ7omvSeGE/jkBDw7gDm3lxr/5odohSfzMRJhsj8sUM7Il5OrvLW75hVxm3h15zlLP1TVWXO79XxtcOFshtbuH5hQfGRbULh6Lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCr3WCOsL13MOjtm+aHMaQmG1DxZ+QVChZmLyUFkF5M=;
 b=rrs8JALdBZiph65o0DdLHT4fqbD9jzz5/Lh++jRQGafPChCwjjPqoVXQyGYJ8QS/XjQnkGY6SILAJ2r27ay9A25SPth8A+mrMak4s+qaWjdskUwA5AsMax/3JDI1iKdmwXKGKp0q4b86R+rzdglrZNd/PKCF5VjlIPWcDuyVqJdSJQEEhnIDbGojTZeYqqGu6DmZNPirJvCnG7WZduMPayRBBfZ0hW3v/MKs89HBbgS+lkXc6nzP3OyqW2DkaoY+VyLH9/BVqk/Q5cUnb+AqN0tQJu42DOqJdnRE9evZO0KAGbg2YzADEs8Ytmonc3r8vNB7/Dj5ZrS+Uw5R1eFucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCr3WCOsL13MOjtm+aHMaQmG1DxZ+QVChZmLyUFkF5M=;
 b=EOZU0itSOG2yauOU76+az6NckkgXfRMoqyfK9nMVkI9lcHvHRDYUm7lXzfHUuY7kBdahH5MIX1VE9EZWrmqqOdzjLWWtjTZ4tz7xxdVcic4zVb2pqno8pB4ljRDo+zSyrKeqCvAVvJq28hWXasTaY9PbqgXP7RJeIic1+geiRdALLC63V/IQP5WOlYyRNa3qRxEK1ZNxk1EP6d/DYamQsYsjvBReFaZE6n6Mtsc7lNUVIqQSjJOdGvlsjzwNaLVyFi9aFEKQi6uoK739UdUk5LlwUNo2nyWxYI/DPO0f3yW/mrY1XytfEq83Zo0tHM5qwQ4lNVwYsdEUuKAwWxA5AA==
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 9 Nov
 2026 19:42:20 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::8a) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 19:42:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 19:42:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:41:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:41:56 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 11:41:53 -0800
Date: Mon, 9 Nov 2026 11:41:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peng Fan <peng.fan@linux.dev>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v7 4/7] iommu/arm-smmu-v3: Use a per-domain CD table
 for non-PASID streams
Message-ID: <avIh/TUA3rPsytWw@nvidia.com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
 <20261030-smmu-shared-sid-ver7-2026-10-26-v7-4-961726ebd6ab@Example.Com>
 <auU/RARTx8dv5mAE@nvidia.com>
 <au8iwj68zXO1us_8@fedora>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <au8iwj68zXO1us_8@fedora>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa45807-98d4-4692-e74a-08df3e9990a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|7416014|22082099003|18002099003|261026140227099003|261028144727099003|261026121527099003|56012099006|261022105027099003|261009223027099003|261021135927099003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	vz5q7miqPN+v4rnCLBvlXqshdJfU5B8Hj4JffgD/JNJMASvsYX+kIleQntUwD/Bime2m0WDASYtkmyrY7eNKWjvso7urvhesYEL6ZLz/W5enJ7ux3cCXGoqnIqi73I6hdKM6cnqoAuXTl3AQry9tI6UMsQdFOG4HXoekkX9M+8cVFpSCoNWa298LWWXjAVGyFSPXgm8+ghGKpUuyCvgChQjspnpfoXYO86Szf7Nr3Kt6ewXzg29PgWQAt1muaOVyyiQnErPp6bOEnccx0TfaWHnEtq3fbFF+KXhAzzJgPaOBEThk2ZxSYsZLiugh0rrMXr9cx8+qrbxP68fqRVWCg9HzLCow4AFLBEh2KHV9fEVmJK6CP7JUIIFUxKM4cO3Q90BGz7i+p6ZxIekLygfWt33x4yb2zuevpDtuS1BG1wtuJji01rFUDnB2ipyWuQhFgroFMTHdmPtxcOhtXLLP6TeXXHHRo6zyCvz2zyJTrB5SA4OI/rChdwZbBiC83/eBRPF5P+GfT0UUSSBm5UTIkp28t01XWOiEIbt8YKY0wgp+W44rkNuF6ld9PoxbzmZ17oIurHVv/Z9J8E8aIvCLrQA9qord64kWkss6JoCJPaQF9ow1u1B/05rfRqtn7CfC1HQy33mQ19iDuLLr9xN+lmByRVepTiyObKvEG5JKDBQrFYcMlbco7KAqmOEtwrne0yvCDFPUDBx9BRtZItKlnA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(261026140227099003)(261028144727099003)(261026121527099003)(56012099006)(261022105027099003)(261009223027099003)(261021135927099003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1PRS4eQjulnp5TRMyLmi9vzb4aqZdcsYRt7O3wCvu8bEGWthVPKoNrAbhqdPlZ3Piw3L+HgcY9uokmagn490aCFIvfh/t4asn+/VTwKcow14jKEsmMwFj72UBslXLn0R5mVkrvcQdyc0wY7f8zkJGcXRviWw3ppgw4p8PrN7Me0jMQXfyUyITaqjzj/PodG0fE/I1OkPhOlCZnsI3ZBS6JvUsq2Jsc9pu/aXufLaeRXoB2oWUXu2HYgxaYuujt6aR8ZefNLGCs980xj9A7JZbFbb3IhXLcQ31oiomeiD7D5SK6JiV0OZUqDqVucd+c+2bVqHLx+MHFnhY0GG1dTbmbp/hLO/aF5TnVkHTbYzpj69EoZwklNmeJOk+/cpuNcAqG6NRMrCmcrjd/cta1wks1rnEaEsat7QkSEAbSWMiKVWTWsW3ncVysbyY0ZRikRc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:42:18.5906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa45807-98d4-4692-e74a-08df3e9990a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

On Sat, Nov 07, 2026 at 09:08:18PM +0800, Peng Fan wrote:
> On Fri, Oct 30, 2026 at 06:07:16PM -0700, Nicolin Chen wrote:
> >On Fri, Oct 30, 2026 at 08:09:36PM +0800, Peng Fan (OSS) wrote:
> >>  	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> >>  		struct iommu_domain *sid_domain =
> >>  			iommu_driver_get_domain_for_dev(master->dev);
> >>  		bool ats_always_on = master->ats_always_on &&
> >>  				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
> >> -		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> >> -				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
> >> +		bool s1 = (sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
> >> +			  to_smmu_domain(sid_domain)->stage ==
> >> +				  ARM_SMMU_DOMAIN_S1;
> >>  
> >> -		if (!ats_always_on && downgrade)
> >> -			sid_domain->ops->attach_dev(sid_domain, dev,
> >> -						    sid_domain);
> >> +		if (!ats_always_on &&
> >> +		    (s1 || sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> >> +		     sid_domain->type == IOMMU_DOMAIN_BLOCKED))
> >> +			ret = sid_domain->ops->attach_dev(sid_domain, dev,
> >> +							  sid_domain);
> >
> >This covers almost all the possible domain types here. So, just
> >drop that downgrade, and it should cover the other cases:
> >
> >		if (!ats_always_on)
> 
> Thanks, I agree the reachable set here is only S1/identity/blocked, and the
> outer condition is effectively !ats_always_on. The separate downgrade
> check is gone in v8.
> 
> However, I don't think we can fold the inner check into a single
> attach_dev() call for all cases. For an S1 RID domain this is a PASID
> teardown path, and arm_smmu_attach_dev() -> arm_smmu_attach_prepare() can
> allocate with GFP_KERNEL and return -ENOMEM. The IOMMU core requires
> set_dev_pasid() not to fail here,

You got the point that S1 shouldn't propagate the return code.

The non-S1 case is the previous "downgrade" path, which didn't
propagate the return code either.

So what I was saying is simply:
-		if (!ats_always_on && downgrade)
+		if (!ats_always_on)
 			sid_domain->ops->attach_dev(sid_domain, dev,
 						    sid_domain);

Nicolin
