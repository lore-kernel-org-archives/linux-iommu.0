Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32E38C43B
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288626; cv=fail; b=mC2ciuXf2oPdmi/XmVsjO4lprZ95EjWul45/kYrgG+ZMjtuiE3pxA9W2mk2aUeYR6zfJts+IwuETlMrXOI0I5bwQiWx/Yy4M/B+XX6vPg7LprIJb+gkdx6YWKx276o+dPDUSrgFGckHJDFmLVwy/uCShhdwN5ZfFhmB423esfo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288626; c=relaxed/simple;
	bh=u02Y1kAtyLxWjnhbZOuOGC1Uj9KuV7phfKRtdhvP+RE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2s/W/IIFN+gw6b+kIIVstBuZs7HKJyMK/4itRJPNvT34C4N/gw7LRVluvlUlLVdhHAvdjYTin+b1NTPFAOSIfQfGCJhDKwAtmSLmT6f26ov8RedIfhJEqzSZVbcInv+RZgD3xG2Zw8qvfxcxO9Pgf213CBtPlVoxEZ9mfYynQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KRE0AOiI; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KRE0AOiI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSQ2e2s3cPC6tx/nKy/vYTWjg613+9YHgAvvQqgO4tFhFOTV3kt+ZZwpxCwBY4xGvfsSGwnMON068xcUKkfVpH5OoVMrl0qzWBL22Mn+vBFWQaX7zu8vcizS5+dtAbs6ZUr8Jc5CtYucx5Ix3PU1QPNFTCHmJ+bg1pI5jFilASWen6NRXHQGneyVyoMVMZgBhIZxvEVq8dwDCReBNM+tX3VoHUgO/SoD8JiZ3ewb24NiDOuevJ0obiQ/NNjbHr1B3aEfq2loSoM4mjqXJxjnFTaAf8J9h60O3jDBJkdQ07g8Wc33GGPN1/QveqytxmC8h0Wk1q60LLjjo3zunorKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXO2EVSBOOB30MZx96sZpyIUl/ISbDyTQpKDnFOHUdU=;
 b=w17TxThfmBUsWaNCs3raW2W5ofTzqYmkuEwWIwspb//AbtqsnP1NOAsEcOKSexYi5v+2WOYG/NV3IlG0sC8r0g1oYw5kdJkvgQ+ZHmQjbVujuZ0ha5TMi2jDldk3iqJWQgJCXvcOZmBbDJFdDv9c08zwr1FTPKcObqqkkz+T+y9K3dRrkUfo36Q0wjcpRq+ctrvNEao1FXXxZlcPkPrwgpiGtoqdlg701Ql33NUyuL4nl7EjzBVAJnlHfhIXYhZKmf5mRlfaK2Qcp06dB01WIbB11xU5aJk0ZSikRQhUlgy4UyoU2KTyotRTrq4S2c10UpK9vPYtOPfNnARec2bpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXO2EVSBOOB30MZx96sZpyIUl/ISbDyTQpKDnFOHUdU=;
 b=KRE0AOiI2HBjz7IwLrW/b4OLwR10ux+7AbZcjc02eel6A7dQ+Zf9AUO26miSZX5N/e7mbWUHFf8FiNW0xc9k32G18thhqGQZ0DMsjLrNFiMjqUUUjjr2hUZU3ceh7c9PSiU0PM/ktIfFCd/3mJ05OovYdSzfnF5ylWDr+J/9KuA=
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 04:10:22 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::84) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 04:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 04:10:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 23:10:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 21:10:21 -0700
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Mar 2026 23:10:18 -0500
Date: Thu, 12 Mar 2026 04:10:13 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from
 PT_FORCE_ENABLED_FEATURES
Message-ID: <rkohijfap7j4kqbspdp67ygdjy2witildk54ar7ty6hogpqzxk@n6dzmnipzbxf>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
 <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
 <20260311164403.GC1448102@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260311164403.GC1448102@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4534c5e5-78bb-410b-7dc5-08de7fed47b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PSPBM1TAM2ULbTvs3jZXz6DUdaX/jsVTb3zm9cXXh1U8Ul2YDcSwpPZ2bGFnxjQ8joixXLviXLNvP7WfJX+0qIjGJPbpGICVTyID8R5fZPGqRSVAuvfaH9+golmqL+4jTtW2UGVU2OIqOu3LXxXGRGc1hO6mT1ZqfIdEgnPRipho602Bc1IHAGNd9x4FC3ypgjLLDRReDU8GfVKxthgZMH3sG+RvMwZ9WLZP/FSa9CQ4s4zElYNGWUp2Ul2Stk+/hz/hGC+0nVtImrmcS+i08fpJO4gXS3GGP2F5h30TZZiXsRCcJhXYndQS2odrZZKlGECY13kGjgWwyTfRNYlNbNGMoFculvx7M+rcKXcBAXa9T8c0JgpgNW/n0QO0LD6wf4TO/pIOOsACteZVY2A0KBIzZ+IpaGglm8jkL8XARR2/RcrnXLHN+MysG/1N5MZUoDEUyjmMD8xUi5o/1BOtYXsVXTkjQlomNY8KU7DDv6jVxfOSXhqT7pS3Sl/eT3VTI4Vfy/38YIfw68QFs3ehnbHJq8gqTgjlV56CQ1oSPFm5GNF2sbCEJac49d/1aynHBzSeLjgJoNMKrxqZPR6exyhc/EObbKZ7wOoClOM/WOuvAXmoUl2hZ8FK6mFd0eWqoLBRr5M0TtnbIcWe1E8MylyZA08/8gr5YFd6Y5AqpKUJvMV+A7BRZy5PjjWwx2cUXOvM1RSIrwqxEuf3381u9lAppqdpsJeSGp+SifqkeOVIuiC5/vp480FPBWkPEB/0aEstVwW0rBzvcyHMgolCgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	waGQB8hJ1VIuEcBvl1sq+r1hBszu593q6IUHLeJu+r9K4wEAnyGgKmU6osI56QT2d5u7szSbZ9l0L/EqXJcBJTP34NLT4GtUyBpLZEjzEXmbhLGf94vvCqMPt/DxWYcyNIY+CEGTJxw3rVCKsQOM/10EczBCe2qdgT/z5ZI945yNo5mzQ9SZSG8p+1zkK0V6+tl6ttkvh9Fj/CvAWumyBecfy86GeHrRO2p/wW2XYRs2l8iRNearfVFXnTPSWZVrWm5Eku2WF8S95OjjCwxlK9y+auDAufxV9lt18aVxygMdRrOKXd37WM0hu0yT8MaHOs4l1AeyeO7qjzB7oYTBnNTOqm5q8GaBlrrnWdMJhFbDbxxZ4hp6oQKDFzdspIVoA4sTbGF49VJH2mCHiQ9tsnDyERyUD+Qu+kLTZ83Tis3Ua+Vfed2m7dBsoZvJSuq0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 04:10:21.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534c5e5-78bb-410b-7dc5-08de7fed47b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

On Wed, Mar 11, 2026 at 01:44:03PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:54:55PM +0530, Vasant Hegde wrote:
> > 
> > + Jason
> > 
> > On 3/9/2026 7:35 PM, Ankit Soni wrote:
> > > Dynamic top is used to grow the page table levels. However, if the VA
> > > size is small and the initial page table level already covers the entire
> > > address space, table growth is not required. In that case, the generic
> > > page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
> > > error -EOPNOTSUPP and leads to domain initialization failure.
> > > 
> > > Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
> > > domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
> > > via cfg.common.features, this keeps normal runtime behavior unchanged.
> > > 
> > 
> > Fixes: 879ced2bab1 ("iommupt: Add the AMD IOMMU v1 page table format")
> 
> No.. There is no bug here.
> 
> I don't really understand why you'd want to do this, the driver still
> sets PT_FEAT_DYNAMIC_TOP, so what is the issue?
> 
> It shouldn't be removed from PT_FORCE_ENABLED_FEATURES, something else
> is wrong.
> 
> Jason

When hw_max_vasz_lg2 = 32 and starting_level = 2, top_range.max_vasz_lg2
comes back as 32 (clamped by min(32, 39)), so it matches
common->max_vasz_lg2. The 'pt_init_common()' clears dynamic top because 
"the table can't grow beyond its current level." with next condition in
this function, domain init will fail with "-EOPNOTSUPP".

Ankit
