Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011032877CF
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195954; cv=fail; b=nvvnPHCs0E2SPDj858Xnh7q2sKNi0z6RpZGZix0cVGg8GMVd8+elfMvzIUrf4zp3CtCMxXJRu/QQ1YVVjIQ5ffYmcabwAlWy/lY+0NcwvZVN77pL8YPe/W7PQ0aUBblQrm8uVN4O/rqUZgGB/QQTMdfB52Nmtf9IiZXQBVHbIos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195954; c=relaxed/simple;
	bh=oQANigfO1NVt6F/LeknnanjFzwrtepAMGQEY3abM310=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVhYmR2xeJFkkG1eFYT2Ptsq4LB/hRkH07EY1mShb/GFQgkCcPE6t8elyOLzyeeY9qNCZOpoa3OT6kW9sKXVgoLTBLdikHocC6n3yaGsJHLdmeyMS1/tnAHjYMiqvDoxIYTjEQbJ4IwAUvPJwDkTpZIAJcBMC2S4NTPaAVSa1Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjPjOywa; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjPjOywa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gseV1FY4eh+hFz3+Ksxoy1Hfs06OkQU3/Vy8254xRtxPmUrR6ZpLyKTHh1KovSUuul7tUJgk6339cChMsCnvBCBsaxThRDrSo+E2nX9TcEAwmFU/KCtjyb5gvkpxZu5/QyrRuMkBcMhg9eUcuDes4PmPtv1rhr6rc3JQvbKJZFBYOLXw5+Xwl5Fu3iGGgBHUZ8g3WeVHffOvtKFfyeDdOlnEfqUnVyP26T2YrRjp/RX4i9GDKNL2BDQrm/DrTnLUByQUsjZm7oKi6Y193XgQXMIL1gon0rvZeaX1xODjPFSQdGBUmGoQ3XDSDsDOuvlEusu2/eeSPK6Vc2RGXVDdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi887puXDDU6RxiQfvVUPvOOsc3Q3XQMzckili7hAso=;
 b=a91fb5dg69bxJgd/pyfWTPS2XDGHmLEh1XwXc5+GPkNJLzbYVuwEoz9GFVO8Ku91bATay6oiBiwVAPe5WfYjW1Xiq4CL54JL1yQHLZJWOVT901nXN4aMrJmru6+i39qJs0ToRUNm21I8uhbBegghxY5qHPSgQZmYv+cjW894IPxguqyKiRBSPEuux58brZsWlmL9nmUins5IXEA61EbSjCm4FgDM8KuApAzOlru/jpFAmRMSG1iHWgfWNUXm7OyPOepzjxa2hYPXq1c417u01uDanYb6vmYkvHsjjjdv3cSpZoDAqoyrtdgVjuXSFA0v3nHFv6xbahRJgNo5BDUOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi887puXDDU6RxiQfvVUPvOOsc3Q3XQMzckili7hAso=;
 b=tjPjOywa4wPqyjg9lOysGrx/1uNAZdaZQwozr7gClY0TqC/WA0O3i3G9mNmMXXKbyXSSyKyBeWxG/JcIkvkBl2CYqtdHJqjXs0fDFSxUM3cOwjUEnXVPJ1zIcLnWpZPTOB68+jhGjrOHYt2Kd9pesoIwuqYlxTXVuvPs8D/IHCL3cw87EW+IbVAWBRIJ09coKe6cgFD1Qi6vnHOT3ppoAbTRiq3gWzBTE2HDfZO8AssS9dNFZlKlJsPU0ZPMBPvBRc65XDb08v7imfbHBy4i3yg9zEtt+dSdww7Bi44I8On64ulHqyt2bHzwpW+2l+5vUU/bPMPd3pGZz+fjL0UqFQ==
Received: from DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 19:19:00 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::df) by DM6PR12CA0016.outlook.office365.com
 (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 19:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 19:18:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 11:18:40 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 11:18:39 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 11:18:39 -0800
Date: Fri, 23 Jan 2026 11:18:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXPJjcVKq8QOiu4d@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
 <aXO1OLrOsCkep3V8@willie-the-truck>
 <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
 <20260123191654.GD1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260123191654.GD1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe2bc16-be7e-41ae-c1e8-08de5ab44318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCVHAa0AGFNQHbFH1Nd+aKQtrsgPEixsb6jdxO/wUjJpgpDeJAhjwwdg+t51?=
 =?us-ascii?Q?wD/E6q+V5RLmCPInA2pTYrLtHIuniYU9MeUb0eB1+ja+8QlWgo2OcjwzX4+x?=
 =?us-ascii?Q?dbIf8gd+Ji5ijMfUo2IruONg+Es6h5Bspg52F7T2f29b1naE7lH4/cq6LJ5T?=
 =?us-ascii?Q?Z0sMQdjygp0+ABS952nZlXboMGy14y0AUJfXR5uM6jR4RJWmx7BQbVyKMS1o?=
 =?us-ascii?Q?9uLKtqSn8g9cESvedgG7esJGISaBx9hXaBG8QaKl21Hr43SdgzTujNe+brf4?=
 =?us-ascii?Q?J5LgK6/v8n4+9hF7kdsUxYKPwwjXEsStPxezBENjzMi0IJOzmyS6Kb3yRx6/?=
 =?us-ascii?Q?7KGtfNPLccw8t2n44U8WpbXAK1hMRtvHpnjH0FpO1SPPspq+eDWDkUkMG1bC?=
 =?us-ascii?Q?wv98qJICLP3PuRgPH0FVNjIC8IRRLhU3HPIIcsY7JxoDLHmY57GxPpuuZtnA?=
 =?us-ascii?Q?bfKbt/K9Wb0q+D2rr1uh4tmnUhVgO7mpXlxJ4TejZfUeIqqOLglv2Iy79ZJN?=
 =?us-ascii?Q?I5xZSSJJfP9br32Qtz0WHblunaGViTR22FVhD6OZ/fLLcMO86soP7dXiIJ1X?=
 =?us-ascii?Q?JKiWlKHVyYkm6XzpWcMCs9terAeTOOQ4NFUqVQYRHMOtwVrkDANBK7K0Z6uE?=
 =?us-ascii?Q?5CoQEL1GTbz7g6cPS+6gd/esrc+LXzpEWOYPPAB/3HrSXxDF00x4Lq55Hmgm?=
 =?us-ascii?Q?7Bx6LiHlcoCgqjRJmJlexuygMtGEiS4ngpy+NV/TjxPXIS6Kf3qHYzTqhibP?=
 =?us-ascii?Q?4j24TiKAP0+yM/zOs9bEBFWeLapYF+cCGxep1PJyxaKDJeTl5sAb61s3lydD?=
 =?us-ascii?Q?FP22iNR7uirLsrHYo49Bx1bf5kTZeoXoEcPpX9DW6QHLF74wPv2MHmFCaOXb?=
 =?us-ascii?Q?hlNJXphm8nITqw2xm/7KJPMLQScwPjM+Sra/WiUg+5Ztq7d3oAqu/QjgB+ZB?=
 =?us-ascii?Q?QD5QD+YQl3Lo04dxMiZRQf0xAl1+dIR6DkaBx8zvJIJoH5fGaBwuOiJj3nqq?=
 =?us-ascii?Q?5lrJPPmKQ/GB5pyk/OZORB8nccGpmwefcHsuCE+zwrWroz43EtzUa73QxGVv?=
 =?us-ascii?Q?7jzP1+8r1OTaVWvb/DAH9kUOfnwiwXZYHLgyzRFwyXD+1oOzClwIE3YOjzsE?=
 =?us-ascii?Q?AaQI5ApHotlLPMh60+kVQKSMm/OSIvZm5X56QDSqjUVbwbXCOzleU5nx8d4j?=
 =?us-ascii?Q?OylChJB9AgbT90yQGzDViJFmfGs6qahP8XmIVICG00FzprC1QTfFaT8/vfAU?=
 =?us-ascii?Q?5vQaWoDgn1FZnMl9vCA+BKKVPEtaQkh3/0gi9E2E7NBSz56fTW206xS9LtSY?=
 =?us-ascii?Q?qnrGtrwAKcOo5oL/fwWtn//XPr4lB7izKKw6xMt6NVwSGqTSwr4w0NVyH0Kr?=
 =?us-ascii?Q?t4Xl7M9yZbsHzeqBB6IYcn9oGWatkG43zAtla0d3Ww04aC/9Ox3hTqMtkLPN?=
 =?us-ascii?Q?o8rkfU6YHDNDYXFB62590h1BJsfIrrgX2JwqCHOrk4S3YzffLB2iZUuMa+WE?=
 =?us-ascii?Q?M6SYHpPqL+Hi0yAq9PHQU9rEu0z2vFMZkEFt3W8Ddlkrktm4sgeFqGY4KXrk?=
 =?us-ascii?Q?dbzl9/Tyee77FPIywu1f/Dndw3cugLuiMhrLBOH3SeFOqkfN8Kz/1qbmUnBp?=
 =?us-ascii?Q?TOj0FU1Ha5VuRxHb6wsbSQJyRLYLZwIfCzIJDIq7Wp11UUKSxgGMtoxb3eJ4?=
 =?us-ascii?Q?+OYUMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:18:59.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe2bc16-be7e-41ae-c1e8-08de5ab44318
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

On Fri, Jan 23, 2026 at 03:16:54PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 23, 2026 at 09:56:01AM -0800, Nicolin Chen wrote:
> > On Fri, Jan 23, 2026 at 05:51:52PM +0000, Will Deacon wrote:
> > > On Fri, Jan 23, 2026 at 09:35:58AM -0800, Nicolin Chen wrote:
> > > > On Fri, Jan 23, 2026 at 05:03:10PM +0000, Will Deacon wrote:
> > > > > On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> > > > > > +struct arm_smmu_inv {
> > > > > > +	struct arm_smmu_device *smmu;
> > > > > > +	u8 type;
> > > > > > +	u8 size_opcode;
> > > > > > +	u8 nsize_opcode;
> > > > > > +	u32 id; /* ASID or VMID or SID */
> > > > > > +	union {
> > > > > > +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> > > > > > +		u32 ssid; /* INV_TYPE_ATS */
> > > > > > +	};
> > > > > > +
> > > > > > +	refcount_t users; /* users=0 to mark as a trash to be purged */
> > > > > 
> > > > > The refcount_t API uses atomics with barrier semantics. Do we actually
> > > > > need those properties when updating the refcounts here? The ASID lock
> > > > > gives us pretty strong serialisation even after this patch series and
> > > > > we rely heavily on that.
> > > > 
> > > > But we can't use that mutex in the invalidation function that
> > > > might be an IRQ context?
> > > 
> > > My question, really, is why do you need the atomic properties in this patch
> > > series? It just looks like overhead at the moment.
> > 
> > Hmm, shouldn't it be atomic, since..
> > 
> > (might be IRQ, no mutex) __arm_smmu_domain_inv_range() reads it.
> > (mutex protected) arm_smmu_attach_dev() writes it.
> > 
> > ..?
> 
> It doesn't need to be a full atomic, you can use WRITE_ONCE/READ_ONCE
> instead for this case.
> 
> The general argument of this scheme is it doesn't matter if the
> invalidation side is doing extra invalidation, that is supposed to
> always be safe except for ATS. For ATS we hold locks and then it
> doesn't to be atomic because of the lock.
> 
> So I think Will has it right, just use READ_ONCE/WRITE_ONCE on a naked
> unsigned int.

OK. I'll change that.

Thanks
Nicolin
