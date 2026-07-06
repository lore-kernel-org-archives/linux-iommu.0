Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377B2D0C79
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358200; cv=fail; b=iSk+roNed3w/SGW80yIt2C7te2Z5nBwpGdSTzy4OV3UYKNYaG2w3rHXZLwHE7uGPixAJA7jU6zkBgZ2+L7MtI6Hu7k0VGPpksOPvrmpqoKb9zF6hznQA/4vW7fY6NPOEq3fe66p8Bu89wY+kD/RCiSxRka1E9AF01duBqbi3G64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358200; c=relaxed/simple;
	bh=3SZijPjNoi1JiK3Fc2iGrLs/TNkoa5BFLwz6IB5ow+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TDXP9539BuVWridBZv3OKIBLaBfjRA8skz9S6MWPuMe2MLv0Na6UJVO5WCiGCLRIKpXLjq+gTQgWVDov93x6+JhXnD5YW4ED/y35JifIx9NY4YjGyLyNa8En8raNxagfGr+MobNOKqWrE8owmLQaCqIkz20rt7MDkQhOmfxHxp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luqh+5sv; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="luqh+5sv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0Ov4y/y6XqsdQJCE7wwNP6Zy2iM4dX94YAJCsRoLcYzI/K3RAepKbqtarVHDz+3uLqLtqldGYhOfx2vOokl6E3gJRfuePykpoBmfy4cfjDjtlQ0GHB4ank9PUZhGiJLLT1I2YxXVatKO2+nq5TIRXWU/w4FMr2zVq+1ngOGqRiAcBkKcsrxKE7OA4Km4RJXJzxl91lInu7P0deVrBdoCkfjEKjt6Sx+yQFgH5UyFRhYD/r5Sc+lIT4Cq0bI7i99ueJjJ2HhTo4cw1lbvjYOY5DJ6hCk86P76P1OnYTYhqfsBIHR6SUiqyHSyVQpa4ABojrT1HLpalpKGqlu7VAq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApBqB9eOIBxqzICKN8NH35CpkTwbN1ux6GElbblCuhA=;
 b=DnzKYU/ioVDgyCrhzaxizKEkpjanMW8URT7fZEjXx7RJ6SODR5nRCDVhMOxRc6gajjVjyrBB4lafqFcrBOrc5OYJaHsCkkTMTW01je25wc7P17OW7N6hP8yIFqjXd5EIEOLpUmlM/b05yc/zCaKBrCEUhqAE0g2MWALHlFnfwTLGtk/6hmGchF7duXu+4LDNUyx8vD421DGBU6sSJ3w4g47Ze7tXVI9Cm3zozrCG7GNQiUs+UZ+K/tisNYEmfD0YJgiJiQ2CpMYqiTdyFTrICoIPzQ/nDOPl6t/8+APhhO3hDixTbQ7i0M/WQ4Fe05KbuRut35HHtQgq2ChO27nFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApBqB9eOIBxqzICKN8NH35CpkTwbN1ux6GElbblCuhA=;
 b=luqh+5sviJpIujRnrdAjLusy0jlHob7nT/iFxrBwz7pjH6OgA995d0Wb8qlcu+GVpWiSoqOzUnQyaqZaxb4Gc5RjIeKy/X8yAjJ6x/JhovuCoA+ntYaTRIoCV70e3Re4tYezkaznrfI7qhB4jwYGZb+MCf4BgOvQ5zthR7ViksRcLcuyQxExYNKMbrv0IyhmZGhxNkOt0GstMa/UXPXnkT4k7WQWrweSzT6wCzD6lDUHPlNQKP5cSnuAAh0Y632rSMwUVbfNdTLDiRntX1gDukvqF8FgK3zG9+z9CSHguOyysvNpeZwU/jCD81u/O2tbEFJy4W7g1p4IQzY38vcypw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 17:16:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 17:16:33 +0000
Date: Mon, 6 Jul 2026 14:16:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <20260706171632.GA118313@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0739.namprd03.prod.outlook.com
 (2603:10b6:408:110::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbfe645-da47-408c-8e56-08dedb8253bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lpyY2Raps9TsIdksOHQPbyS3e2XZMUshZuVjWPW4//WTEkMKGdhCc2/CIuiyYPYkSK6Xn4oCaKrzm8CuQ1GWYnU/owyO4gu+TvHGMO3bs2rafk5TZt4p7lBw+fudnpsGvEcXzO6SGcQoXbCNvLZQHZcMkUkU7Fcnw++YIo/1CaqaTEkFO1y+MV5yuZi+9YMG6q66r5ML2wJJ6HokwuxQq6gp6XFVUQiOnKR3sb6GltKuHPVce5TnTxvgc2c58nW/ZqH3wBfycvn0luFlCw1c3C8wp8wm3CaFVf+EaK5fS/jPUo1JuDlbm4pXv1TbpXx7JIPB80TyeNOTWZJa/qkXhblDUHya2UuZsbGvL+JmyaRfGaVprk8qkbMiuJNszyBhdJP4Q/pYSfbaKsxBb4Z2WQbjs5pKZumN3L8h3yTRgaZrBaSVFfXB4768pJUuZcW65jWQ/yY9xBrL6Px9pdfSxC0ZnEiiWwsdZJCKaRjdupLoJGTDtuTh/9XMj4u5xzMB+ir2UeRm+c1ZxpOSKm3pA0vzzq5YttyDYMvlivsTfNCyXrqm3R+NwPA6EYpE7PUInVSgD+h1c5748QEhHtF1WnuuNvRBc6HZgCUBa6/TiaNidyvVbsqHjxh4myUk7vH8rgdX4fPWhmxnjNl8sSd/FlS4gTiQPnsFbQLIGw46RH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGnL06j/A99FkG7/udghnO7UbUgeDAl1aYuKe1J/37ZmNrDNmLDxZBKkcv7W?=
 =?us-ascii?Q?/52pg0SKzP10Z/vg4VvnDh5US5LXqSrWZvFSuGpr2Tt4/gmERYmxb7+Pi9wQ?=
 =?us-ascii?Q?eqNdGFqOW3gsTI1Zxo3EGC7iMwfSVOVMHsgF+RFWGXjBEWUGjFXQNItt3gD/?=
 =?us-ascii?Q?jGV2w7hrJSlBpYCBW7ZtErT0KzbYs7roE/yr/fh7kwwItB+SxV/m3dGJoH4p?=
 =?us-ascii?Q?e1aEi9h5iHNWdkk7zB5P7/V19/4yHm2g9FYiUMCq7Yymft6zZ2wyNIn8Mzy7?=
 =?us-ascii?Q?EeZI/lWhYV4cKD7+tFfuZthvxU1l/Gkkqah7jfwLKeAFqG5xBqOh0cbObsIR?=
 =?us-ascii?Q?7xAXSvGcfAE4PzEapKqwuiQ2i81KBQuOvvA7oGJkW3fVB9Zy7AjPAGUz4MmG?=
 =?us-ascii?Q?zffGCKR+KkwkB4w/4qklqPkOjj1ftl3/WCqVzThIO/aETpBt1sgCjzlr7Efu?=
 =?us-ascii?Q?paKuhFtDxb48yx6+QhF2i47cj/p4+m7RWdl+9zn7SK1kdTv1gjMTnc161us5?=
 =?us-ascii?Q?CaUGRq6NJPhTJNoHAzf5ES2viAOFs5r7gvNjGHr6n7T9U9coOFjGo1BiJ9Zm?=
 =?us-ascii?Q?j+anjqMT31Se+kz2xcYyeK5y8sWw4frdVvcwmJft6pkjw4mnb4OzULWnC4rT?=
 =?us-ascii?Q?AT2V+NgRbPqB180h2ZzI8IpRLOi20I4G49OhxrEdfPo/l+ZN4S7XXqoJ2YCj?=
 =?us-ascii?Q?MDzI6SkogYgv7bW1j1OnDGJ/XhfKWnTRWbRJM7iM111FIE3YNtZnQKpub03h?=
 =?us-ascii?Q?8Z9Sy9+yN5zYbPAyT3LRyZPprMBs6hUBlsaqpIf07bbe/wqiw2qaIN27e+pd?=
 =?us-ascii?Q?7Y2/kPBt0bu//NKTAH+bUwH9bIPomxlW2YEX4nKNxC4XTNAM4a7dot+u9lkI?=
 =?us-ascii?Q?HdqmxBxADBsRtcmZabVeDfYiFvp/XemAzmIrlHip3jhUGP6yFsTdndZy4589?=
 =?us-ascii?Q?xOMf6e2OHGF8770atLEMv159iTCTkAvUw0GMBV5qRI1lc71n+08gLUGRJDmi?=
 =?us-ascii?Q?H6s56xKW9YAPFR0koKWyjvJhdFgW5nrNfRKs6+xFUtDx98GqRf21/nQl/P04?=
 =?us-ascii?Q?fyodAaeVjn/+VRD+39UdRtKKWC80unmIRPCynrilBMqCz6om1EcUxwcdQtET?=
 =?us-ascii?Q?F60mBCns5HVKn7UwvBqTZ8rGZ2FcMpAtj5ZzuQNU7+R9yrcaJVlFsfXsUEUU?=
 =?us-ascii?Q?ewRdptg80TZAo01TdvghyuCyC+A/yMugXYO0+9fommxyFSjKrjPNaFVdgC/C?=
 =?us-ascii?Q?KBZVZoRmEmBe6CO9tHRoTs8elWnmadgUHTX26LfHKxPso/DkXdFQxUAUEEYW?=
 =?us-ascii?Q?rvfSkcZy25Fz4kEcKiTCbOelscs7rldfPVbSPkuvwKq/eU4UFeLP+4TT+Cis?=
 =?us-ascii?Q?tlWb6Ru7Zq2Z37+J3gnH0WeNXgTf2UQ5ERcWuBUN+tZ0Blj+Yg5DQt3T+/zJ?=
 =?us-ascii?Q?W7HjyBfUAB6aGeH2C/AgR+99mRXDUKuj0lZ9h6P62ke01qWHesqWP+qUq0LW?=
 =?us-ascii?Q?UtiqLl7I72pwryEC9/6/YQzHjQiKbaHbj8Znt8wlwslu5FSd0Zwj7S5MTjp9?=
 =?us-ascii?Q?oRliy38gNURNDKAWiweOduzqvzCS/U5Zx+l+HugqVQ6vIHSkFPx6MxErRRt/?=
 =?us-ascii?Q?gqYOF9Tbq8G0SQRyfKbR18QtJSV3pIRGqim7Ui1zo8cwZvRkZ5Kl7ypO0UZJ?=
 =?us-ascii?Q?GphKA3DUVAGTAP0iPKqnSkNPbYMxgZEgLPmlgOptLMjJ/Fpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbfe645-da47-408c-8e56-08dedb8253bc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:16:33.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5C28aUnyA71gYzPyaYbrvFBZqkF8Id5FG0W13rUlZYvqw42qAANSrInUxulRBkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

On Mon, Jun 29, 2026 at 02:15:36PM -0700, Nicolin Chen wrote:
> +	case CMDQ_OP_TLBI_NH_VAA:
> +		allowed[0] |= CMDQ_TLBI_0_VMID;
> +		allowed[1] |= CMDQ_TLBI_1_LEAF | CMDQ_TLBI_1_TTL |
> +			      CMDQ_TLBI_1_VA_MASK;
> +		/* NUM/SCALE/TG are range fields gated on FEAT_RANGE_INV */
> +		if (vsmmu->smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> +			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
> +			allowed[1] |= CMDQ_TLBI_1_TG;
> +		}

There are a couple of additional conditions on tg and num in the spec
under RIL which are reserved and illegal, I guess those should be
checked too if we want to block any illegal command

Jason
