Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59D33987E
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422480; cv=fail; b=qAfP8NxAITj/dQAq6rmaD/l6uZzVOeLDfga2kBIH1G/j/DqKfhAWaT1RKXmTZ83LXxEL50TZ7KXwfW+MJULJnoMFSU0z52ncbxN12SfNqBXnYQrif7qD19REUQWONbVAIa71HbRu4ES2DvFjV9Yl48K3s3R3xuJVH/ARKGsXaq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422480; c=relaxed/simple;
	bh=BAQPiKrExDFuG+GrnOXZvXL4Fo4xOIsahte4g2lWwjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4N09bZLgfP+Eo8iztO7wPyGLuSzbNjH5KxxpGS+S0/LYQEdI6erpgKXHqbqQxDhYa46BYTPQ7xeswUTDIZyHzirI+V5+TN2f6jYUSOijxvJqVfBo+dPYgOTHsErBzI1ffnxQ3UYy0z5uHuPd6fE+OkNRAeU/1UOU4AGzzLvNng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BUy4bLQ9; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BUy4bLQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuPLgQFk+PYRQgQ2emGlcLyylS++hO9HwCJWBOm35V6qOgIeXfTLPru+MdLVuKNfdIzWcK0ETWLfs/hxLZfaNfuV5LD9aJJCAqkmVjCIPhC0Q7uOHMQTRLlxtdtqjhhD+NXhzMqWkFgMUmKYNUWSSWJFakL/8bX2+zFJoMQgvHoEN7vaURWvyrJNdBYf3D6+mjyzOW7qqe/PtaqGMIrStdLDKd+go1NaJMoHqIxrvgBpz46PecN54JW5brpegefx5Zxdw5HRxIvKtEJx7LQouG2w+R9W2SoousxZAIrOMdoxz9ogXEd1621/uIskEmU8CU8KDa5WPPW76N7bZmoRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/3RELfDmAguHL37CO8uVco76kPdPU9cvNQnI0EglSc=;
 b=D0vtiH34uRNhpEN2htcYQhmNH1xwJEk9NSrhkxrZQAWA+v1m8OYHn4HBmyjzYrwsoHuj1K8zLyde0NFOacpPUJFV2aNV2Ae0KREjdFCmbSXm8MQZC64FfgWg29dQ6nipvfY/KR2QCU7rJH7bUqFEHuJMl5d3nMBfkuwoo0oFZZngBAXpttvSImroXqiTkfaBK5951+FRejU91yLVtbO9fdI/kycm0mxFvfGyFYepmBXjGkfEhitXh1Kz80t0T5/Xl+gNmKqiu+L8rw8WL4Y8TLyw9i0QZHwMSoUc6Dug3I/ZgT13rjNDZ2jhQnPLMVmKOAQyrRAVZvZhfkjlUuJU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/3RELfDmAguHL37CO8uVco76kPdPU9cvNQnI0EglSc=;
 b=BUy4bLQ9WTBx7h3EN7+uxOa8vd3gtmPHBtKM8TL5h6mWaUEclAWdeeMGEcffhKlmy2203538jWQXMQVO5C3YhtFSzg6H3neucRt7Ya9X4CR20Nw2HhBE7pTLH2MCD2KLc0TPk3AQE6r/awPib2NOYxTEiF7nyRi9npSw9ofEOQ2wmRlPnziyRE6DAn4CWFxgPpyXIDRj4pNvKUDEOoVh9d2PVYzN7V3r61KWuq0nlChzHcSH0gUVJAxmboVFyabC8veHi4ivEObCuYt5yS17aBza0ZpWGtuAJDHJdrgvAJG5yTZ2gVKw5UioyhEzaQgEbo2GtZTIWhZNrrMK0P19lg==
Received: from SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::12)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 18:14:34 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::5d) by SJ2P221CA0002.outlook.office365.com
 (2603:10b6:a03:5db::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 18:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 18:14:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:14:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:14:18 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sat, 22 Aug 2026 11:14:16 -0700
Date: Sat, 22 Aug 2026 11:14:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 08/12] iommu/arm-smmu-v3-kdump: Reserve crashed
 kernel's ASIDs and VMIDs
Message-ID: <aonm9nwqlf7uvJ0+@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <28a26f13a91bf26a7b8215a0bea493627cd9c832.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.13784336777302966750.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178735412602.18212.13784336777302966750.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: d97fc714-4673-492c-31a0-08df007937c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bYiCZ8wD3qXBmXVJHaDKcYRBlQUyzPxmRIuUPTXDj2lMX/9jLBBGl3qP2rIU2TfWokumlMwPT4ueWW6diSrVV7NhTfZi5hnhhsSyPyh3rQOjJ/qi4/3aDfcB8ambUlJlhwxUEMTdGaW9aLnjg3QS5xc4xuTwet4JV/3F3/42MqXxSY2t3bYE+/O9RTQ33Mw3orjxeUiP31uSAG7hROR7otIXV1JuzwlSzUWAZ90bhGO93k1bhNuNv+/iqTy9+Qf9CzoP1A+90VQppc2le0ikteJFeTK0QhKTKTjB7138IQsIYvi8Kmm8ueTIdeUO07eFe0yrwqbyrXcB1aB/BdfNdeidkMHu3ycr6Vz7l4M769yH7dsaAE+TtUSy2j794ynIoyRl7N35fbHpI0TV7hraHtcASI2E+zNMIUOjlH+e/aIyWs65SwFwZWnM4RP20c2x/nn+O/4R/4aUzLFC8qUS/aaEMHIJUbHEnMkV9jTeBPSKEf/YZEPwF8Fg4y1QRqmm+P3hbh5x7ZFlXd/ewkTzTEl7pZsOqFq2HWkdZRwHhXXQcfiuBoTOI/f7BaM+P6YRNTVNkP3vTbs3mFbYr2CG+6eUWP4zzGTynBNM9I33Dofgu2v3gPxjWB4wVYwVb5l7S8qwooS5oCZedsTYJSMQBKWqFx/GXwU+kxImsvD0ajtYedn8LG1xYzSwoJlXF9Xg+bNkZ2pwRcbAsAwyhPQ0gw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BrUjADoGLzBXI1JCCt5Q1H06MfjPFenY07ViwZJjbWlo1Wys0SuTrxs3168pIFfL4qWx5bzUql86jrxAsUNwtGe3w22UMgA7I2L8fBvXSMx6kfsAjECdBLYiL3gNi/sBL5w/Ti0ObyMNMmqVUVvSe+I8w9yZeFPxon9Z8U6t1xjt0G4C0hgQjTywKVgRyuLNGbY/BBQ6+FAMIX09d6IzqjdJKrnajXmxsilvYiJt2Wzi4G8M7NTIDmMoQrCs8ieYj1EKvwTweJGdid0ebcCJuK/wNZCi2eP27TbFbVZ15ye1yX64reMYRKkxY0Q65AuhVNmvrUynSvNJZGFgjj6dm5dsiqDgCy6FC4JVn3a/P3v+bDn/G0XVURkXUcCxzt0FxZqsat4yqHTI2ofgLSme7nqx4skVGQgE+55W2GdQBEDeSngcBSxtPd16mirZC5bD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 18:14:33.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97fc714-4673-492c-31a0-08df007937c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > Nested STE's guest-owned CD table is in IPA space and left alone: its ASIDs
> > only pair with the nonzero S2VMID being reserved, so they cannot alias this
> > kernel's VMID-0 or EL2 stage-1 domains.
> 
> This explanation is a bit off.. Nested ASIDs have a unique ASID space under
> their VMID. SO long as the VMID is reserved there is no reason to inspect the
> (VMID,ASID) list.

Updated:

A nested STE's guest-owned CD table is left alone, since its ASIDs live in
a space of their own under that STE's VMID. Reserving that VMID covers all
of them, so there is no reason for the scan to walk the (VMID, ASID) pairs
behind it. The only ASIDs needing a reservation are those in the space that
this kernel uses for its own domains.

Thanks
Nicolin
