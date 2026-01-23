Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F926A0B9
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190993; cv=fail; b=k0rd5EfAMaw3/BnuGen8yOYQP8BhZg6G7eu5uU4djypDM5Y0KSO2PV8ipc2wjexe6CilndUL7athUabQU+oF4x7LlL8BytvJmWippvnd1JCkUm0lfOVcSn21O3N39eDiw9hMC1IfXdV9/UgCOlxLmZMJqQFOkTQ2QUr+sAYdRPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190993; c=relaxed/simple;
	bh=6zGuM0J6xAnGm4c4Z0XwbvZOiWZj6W2LMzfNrRl9WWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahzckO3Zd/bsJiXTkNpSPQDYhj7Yc1Excilo3GgrPlCLY+/fJ5vGalSoGuD9E+l9D58wHvChJcXILOLhDkCAXD7hbPYYNlVFbJ5xknURQq50ryl2yyP04irh60742Z1/uF9kUtVLjcjhe0cv9TzIGu4z+pD5hQ7o9GqNTKMSS30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t164rN2D; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t164rN2D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgctXeWELSMgttmPsDTDHyEL5DDTDepVhS3TGGqUzOhwjxSTOCGMvgDiawdLiqFrJXEPdCgCsp9Uyka14xVvjy23RBNcTXYOo1VXR9Mv6fmO/J/8/EmepU1g1EKU2A4MbOfiOQT6tW56fKSgkUdf4cVKFoZb5a4uqFLqv9lg5dc8EgdfuHz4SmgrTaB9ejVb1VZliecXgIPW19KqV0ve/Kf2MVlTzH/7lDqBebvtNycm89nLud0fxrY43i29HmbMTusxhrmtYUG9kDLgdY5tWW1Z3qEaPc4Q8b/JjjB5nWgJBtfxBGGEg7sr9K2fI+UjX/E0kn051G9YSfDTYfre4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zglHPqXVnOrGX30LYgJQLR/hAFgJ3JKoDGdPggkm+l8=;
 b=qWFMymPObmtnv8h/cviiPe2iZu4yL6v7S5LvahJeUOs0b7jiPmnTyMVAbQ+CuHPLlUXTmXajQGu5TY7cVAg2o19y32PyEi2wiPotBIs6kbmPRo28SaT+98NwyZcz7ONhLCiiRuuI9McVtHCWVI40aBtI8f71V87QaXv0BfneWMveg4kV1Y7VInJBGuSGxlOVqku6HKU5PUkygxrS4D+wRHqPWYZhEclv/E4bD/fTy7viGdvYhuiy264nauj8Jjo5GcnmkVg9xBnyr+MWjo+DePA3z1gInWdaNb811H8q4szQL2K+R5lOKpac/qgNHo0pVD98hpxPAk9dBq7HNer3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zglHPqXVnOrGX30LYgJQLR/hAFgJ3JKoDGdPggkm+l8=;
 b=t164rN2Dyz38y4SE0koaw0F4wJVDG6V8bRjbBNs3iBQhBbD0RvK7hQmVwkvulDjFfGLd573mhcCeY413Yof7Rvdi+g/27CiXKC4YiS10EnJaOOIg7pRhpkjsWGBloA3eRG/4m0nMl3Fa99YuFpVDaVfpfRK+A33EOe7yoGsbTFv6QtjS4o65O4SPxWYqmY/xWtfC2uFu8+RQI4FfmiZIIazugzpxqm8/yoloUvJjHXBUlilfixvaonHO+xqzCBBHLFTMzSOp7m73fBSa5kdK8Zcx7Cc5UtzSt8TKCg9MShWhu4tTgxJshBmOursCKt419Hn6IlpHbVZpwxHk0dGPSg==
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:56:26 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::a4) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Fri,
 23 Jan 2026 17:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:56:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:56:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 23 Jan 2026 09:56:03 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 09:56:02 -0800
Date: Fri, 23 Jan 2026 09:56:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
 <aXO1OLrOsCkep3V8@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXO1OLrOsCkep3V8@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c1dc7b-49c3-4efc-ff89-08de5aa8ba3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+H3UiHnQyvyAuSkwJkcVSsbSbpNCA55hIwqqmxv2iZWldsPVEXDPGulK8byj?=
 =?us-ascii?Q?r2DZrxr2OM2SJXnnAi5ZVktUb51913v9XQhr88t2NVXoEJWMJdvVS9bWgs1W?=
 =?us-ascii?Q?CLNG5uXCPjkP+ij+yrfR6ZjIAFDRSdKXjQA4Dj6xx/dVZeGK++0L1XmkVnWn?=
 =?us-ascii?Q?XL76LPtDQuNiVpHa6ZUxbRq75QjXeyOSba4zOkBkXDUcqLatgdvJ3ooEk/OG?=
 =?us-ascii?Q?qYmvo7dnPyFBH7aQe6injMzFvW4yB2KtQWXwcZJvEQlNQh8KTnao3T3EbQbB?=
 =?us-ascii?Q?JxgfhhjN3uHovoTBvUikHLPGog4D32VMHnaTSQYHogUCnC/yQltt52vQcNoU?=
 =?us-ascii?Q?LRCiBlmi+0OacKT5L7pjBQRn3udkrZyUJl1TUEOQ157E0wK2gyj4cb6+aF1O?=
 =?us-ascii?Q?xxmmjqmtwAd3B4J51KJyp1/ETJJBlazj6XQeeu4JigHMvqEWfWZciXGquBh0?=
 =?us-ascii?Q?atikdAjVlQNjTMWGtnJMhVg4P6gkJDjHT81ZkpzFNghyKSJXpwYpPnXBYAhk?=
 =?us-ascii?Q?TRnHd8KgyEaL+VOCWSh7YotyY1ftNAMy2dIcy3VFb2MbC+w73iL320zNC1Oh?=
 =?us-ascii?Q?yyjFTmPtoLTF/lBG+1mKoVdnEBJHoFzvcRwLQW50iPrKUgNDoMneM/btVyXU?=
 =?us-ascii?Q?WKdYTEYYMYsDijV34FveV93eGRYBAPhSMS1Rp3Nbi7XblVp97Rgp2+VABUjv?=
 =?us-ascii?Q?lq2CQG15VDP/p1T/I+hM/zhGGdDStLueadwkBdUhps1MHa4tfEo8BY8/3H/T?=
 =?us-ascii?Q?hFpIBagBazVmP94DGYT3doIrEN01uFgIyP5J55V0rDWetc599hmvncD9FEfU?=
 =?us-ascii?Q?lbiadKdUf3UywQ4CaMtoKShc5TlUaQJ5RvTmllLOIW0fxFRZAvAyK3hQXMXb?=
 =?us-ascii?Q?Vm3cVHYtb7uARj0OW1pr12J8fYsrPppTtOT5a8f8VrrWtQQCWYRUIFCbbRSV?=
 =?us-ascii?Q?NCb/aWh5csj6HvnT5uwBa6FPi+jXRtmfIUQlFKt+OmHSPIeTW9Q7Qv7TdbTJ?=
 =?us-ascii?Q?XJXRRG/PNAfu2DbjbYqW1TScny0RpAL8/zFb8BFJa9h9bsafaeX7lsaaij9u?=
 =?us-ascii?Q?7ioateqNqubzyj+zzJrbiAR8tPGV1jYyl/0pYl6gEAg3BclDCuDFuMhhg+vu?=
 =?us-ascii?Q?hwOkjHfzctTmAq8GFEQ6U/ElHzWPkIeu+91oEeyhNPn8CCuk+a4DuuNoXIDY?=
 =?us-ascii?Q?6YovNviomdiu6uREn5yg1MGp+8B8/m+i4n8Bcb+uGq5Pa9v5ti7/cZxaD0Fy?=
 =?us-ascii?Q?c3/aZy99sQu+PN5qBmXdE2S3rFEQxWdj9IfiMSLeUimFC+tQHi900Urngk+X?=
 =?us-ascii?Q?0sSjvxQev7a6Vl6IoGUYQSSu6LQ30e2yT7hs3+WE0CjZE6bK1SDTi5eee9NY?=
 =?us-ascii?Q?hrIo3xx2PaIzunDw8XK79+/92+JD8cza3pUf3nvWpH+24bf7h/mk0yP3VDVS?=
 =?us-ascii?Q?ci7unVzGtlSHB3iMlYdeeHaWxj/jLkGiNjZ59mPG34duMSrazQPiwmr0HJjm?=
 =?us-ascii?Q?j/VD3LMlXA5ruMUA3/7c0NDXRD5x3zRCgPigeDFQWpXHWl89uOJ7bj3FG7Dg?=
 =?us-ascii?Q?4FnyPjzYdoMtOUMagwj6lP7FU5fm8FD+nY63QLNp2sA21iahggVFdWnfZukA?=
 =?us-ascii?Q?GeJl/17HkPbYYsgfOgf3GjrLBMsMI89Je6FN+fDMr/tN46w8aHapk730m0N1?=
 =?us-ascii?Q?0V7atg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:56:25.6911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c1dc7b-49c3-4efc-ff89-08de5aa8ba3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303

On Fri, Jan 23, 2026 at 05:51:52PM +0000, Will Deacon wrote:
> On Fri, Jan 23, 2026 at 09:35:58AM -0800, Nicolin Chen wrote:
> > On Fri, Jan 23, 2026 at 05:03:10PM +0000, Will Deacon wrote:
> > > On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> > > > +struct arm_smmu_inv {
> > > > +	struct arm_smmu_device *smmu;
> > > > +	u8 type;
> > > > +	u8 size_opcode;
> > > > +	u8 nsize_opcode;
> > > > +	u32 id; /* ASID or VMID or SID */
> > > > +	union {
> > > > +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> > > > +		u32 ssid; /* INV_TYPE_ATS */
> > > > +	};
> > > > +
> > > > +	refcount_t users; /* users=0 to mark as a trash to be purged */
> > > 
> > > The refcount_t API uses atomics with barrier semantics. Do we actually
> > > need those properties when updating the refcounts here? The ASID lock
> > > gives us pretty strong serialisation even after this patch series and
> > > we rely heavily on that.
> > 
> > But we can't use that mutex in the invalidation function that
> > might be an IRQ context?
> 
> My question, really, is why do you need the atomic properties in this patch
> series? It just looks like overhead at the moment.

Hmm, shouldn't it be atomic, since..

(might be IRQ, no mutex) __arm_smmu_domain_inv_range() reads it.
(mutex protected) arm_smmu_attach_dev() writes it.

..?

Nicolin
