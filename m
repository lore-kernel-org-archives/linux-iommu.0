Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF1EBFF7
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096703; cv=fail; b=kipFBekbiBS9OCrF90zZtT7cCOB/25wePuVBpiRoZ1K3yCNolC7lIp4Bhb3P/thbVlT7TTPw/l8QW4zFlV04vRMeNo7dL7vViaEX4EjMPYVuCHKbOQqkNOJENZq2YGjd4bYZ5+kxekZvfSwpey0nrGcX2n4d6tT1GGNIzA3EJ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096703; c=relaxed/simple;
	bh=bM27zpzbD+XS1Ugd5vbD3dNIb5M4f5lRzm282nBI0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ft0wgaPM/Yp//hSnHhQuwuqTadT9DKjyNRVi53W2doRpyMjQV/VRjrct4E0CfEPIi6RtZiZYcJgQ9dmyNNDRZmIxkc7HQfMFP5gzbwJaYlsPXBt7OCGapbOzaLe3Te8rpv/wDv9vtWW0rYF3jEeC7Ilasf3SAlPEiqBsMz22NWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUt1eYHU; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUt1eYHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjKGNxO5b0BjA10yrhRozEOchiKn1mABFRHGTBfwMe7UAfe1k9Dbz46Rq9TVvzB1xwiUk2bjfHpEjgC67/ul534mp4Ijvl8CAMepPuC6I/bl8dnEuaNgfhf76AaNixhICVRBEQXB9/IqMqLcAMx3LlLXe6axoY2o85F3eElbwkO/0aM8gNPT1GFiKHf0Mis7+Qiy+gO5hwTGZtkg4LSURaUutNxh8qUapLYaxc5WJv7tycmEwneEbv4UkjZnl+wBq+z6xE3Z8rGHLraQMFntsfyGPZiSvtuy12tZvXTWhpHhzN8DpA2LCmb3cfcSrvE+MB9Rvl2e6AUKOC2xL/0qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWLbGIOaoGJb6mhdY6iJq6jZscl1yrv0BfsUVEvkPxg=;
 b=iwDYOAzYCyVqr5CAe7efLGFgnS7ybQIDkYW6NzI83iqM7lA46i6GFTiDzAOPS+6pIs5G8QQSpNJfE8diUK+S1QoW41X/xlYitcmcVBKyNF0sMOIIWsRvkttFLDr6nncxzDFIFVDcqF8qtMqewQ2njm7tp5P1DSznsGX2km6qb4+yHnAVKu5yiNZ7eAAL2kXYY1/rbWIwOSXBrmXY+O5GDgK9Je+Cljdeh+OHJsUv4IsDTiT50QUXqEeSuIlCUFNC3FvpgcAZZrGNnWPvO4qAC5FhghsuATdBuLjDl7WYoTu5d8K1YlJLAZ88nx6UnOSqE66FFoUeY6gLewMTHrc83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWLbGIOaoGJb6mhdY6iJq6jZscl1yrv0BfsUVEvkPxg=;
 b=oUt1eYHUTYtDjMsXz1/Qht/9UKVBO03DPnFfKZ5gEAqVe5AYRFYQlnHU/aorNu+AcpK83NY221L4OhII/Of0nE6kRh1XnTp2t2LQG+WQrbK2c9d4nihJQANVa0AiF4lo1LoaXMfmWsPocvryYiG81YPB5Aj/A1PJLM50y94CWqoIXH67eSjXw9gdqlaDBrf/etXLbjN+wG+6NKlKPLecXpmKy7PHRTsNOEf3mbVID0Jgd9IXpN912c1gNBxiBeH4feaoOo733ixhyLrU6rNHChpYzFe72OQfYnVuBNT8NKMdwX+J9yt9AiakxoMJA0EhnpqYHc9giqyCfgoG8yNWVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 18:24:57 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:24:56 +0000
Date: Fri, 5 Sep 2025 15:24:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 2/8] mm: Actually mark kernel page table pages
Message-ID: <20250905182454.GN616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::13) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dbe5e7-539e-41ca-9ca1-08ddeca983be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RUjzYkN/wVbYp1t6LQFz5KYoWhvkvFlFndXYcQkMQMWtm4ZBmI28dkVT94Ud?=
 =?us-ascii?Q?4Mv4ucCtYCSCBIggj4l+1csJPA5XtdHRQnpsLgSBas4+8ugvqVfcKwV//aCH?=
 =?us-ascii?Q?vhjSbcNwdMm+0fY1R1RGueS4Tdn/zmL7qiel7vm+nvz3q4zkTI3DCZAHB5IA?=
 =?us-ascii?Q?FfFYOyJ9zOfju3KW0ZqAILSGuNbbllTAMv2IIAnZmSgWHZhE+vqG+suVb6YO?=
 =?us-ascii?Q?c6fUJ62XWs0jPQ6T1YhOoeo6koNwA+i9eTEui+u51pLpigrUHTJ/rcVBFKqD?=
 =?us-ascii?Q?Q8CxaW8awGzb4jCjBCrHlzCLde4gyctCImEYQ9zR4wIuWpuE655jio+6/RKm?=
 =?us-ascii?Q?iAADp8gl7tFrjB+prcxmYpPk3WGOGUfrCoDNqZF6zyb8J5zKmASnwT1TJBoz?=
 =?us-ascii?Q?v4RQ4CAVwn+0Z0XgQL7V7ZMnhgZ95wkUeyj4ZKHufhtx4xFwooRLT8udpNRf?=
 =?us-ascii?Q?ylNqwbFJ9zpl6xaGdGzzNjB+RTB2+0bPHZ0xQwMQ1Xh5eerz1hKvheMbvlwB?=
 =?us-ascii?Q?iIGWWZf4lVHsZThoSX9+TmXbBcLYBnw10SZ5wGrx15H5SIlusMGrlpkbbiC8?=
 =?us-ascii?Q?eLJQhPWILzpS+BrXb8hbBtuhaRAPYLDGWVLKbjM14SaH2x0Gzt69RUbphF9f?=
 =?us-ascii?Q?AR9GtuIsIGEHzjNS8qpqPcJQJE8mslECJUcofYKFhMGH51tD0eg3QgWdzRCN?=
 =?us-ascii?Q?fWIdI+d2RdZA6J8z6/pMtGT+X32Shfnjhf1cb+2tx370WJZ63OXHPNg84xBc?=
 =?us-ascii?Q?W5ABL8R9LiMaLHObcywq+PkHo3jZ1CYYensFYI0cAwoNm3NgnXcj93CxoY0K?=
 =?us-ascii?Q?jwVZMqpFIUjyvVdHzzKP/JRNOsbOSsoyiHSxN9Jy4+fH25kmqJ5x1enlVqyw?=
 =?us-ascii?Q?cZH1z2CIKLheuYPS6mDHsDMH17nP0Y5yTteFrU02oguRilwVJODhhdUTH0fR?=
 =?us-ascii?Q?kupCj9rLBmiFzZeOsOFSunGvTVQEePJGM96nDeZPSToBIVeBoTxbkxy3WNpK?=
 =?us-ascii?Q?YX8typanHthgfj5DaaZNcK77B0H9RtJ/CPfVSCdpcYSUXzcRque6oDKTOOZ6?=
 =?us-ascii?Q?Ign8x5Ezl4UhD6OaXroAdbpr6L44R4o1KsPjqQ657xmYkQoIuv5R25JYabEc?=
 =?us-ascii?Q?qEvIRh60uOGX0K5N+kD1O59yOVsDpEtSA3uG9b2ZUb9h2a8g3dBHs0PqwXD/?=
 =?us-ascii?Q?UXCvMofaIPef9PAZs+6uSt7MwhY3VaxqFIBCyv6iZWb5Y/v01VDb8/H3ba5c?=
 =?us-ascii?Q?WOr3oIjBFbhXgTJV2pKQc+hF9WPvFyTcbSRv+Plr8HfQqnTPAuawz16DvXLa?=
 =?us-ascii?Q?/F2GrGM740Wde+0hLyO2qiK2xJHrXYThyDqmH31pbj8aLgdFdSNKxpjb+RdM?=
 =?us-ascii?Q?ZoHnBf3+A2tsx9S12+SperGe7P1odkRBGcg3F+h1HZzwuLrw94XKiNblFLtl?=
 =?us-ascii?Q?wrRjxvr5EDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Xc+q1fH2ZWr6WekdUcosz3pI4oAaFWDCGg2CsG46Cb8rDPe/6bZEeV4y8H8?=
 =?us-ascii?Q?DmIrSxPgho5D0KVH+YcQdriir9+C66MoXi1A3F6kKuIpyJNNRbikLniphtPV?=
 =?us-ascii?Q?HgAD2wYaKfXx216WrXgRRlANRmT9PeBjLKwXnQXU1Fr7CbAeBVXlajYDyBfg?=
 =?us-ascii?Q?RZqJfHYZXwo540a6hIjmHQ93p698D1+gvrOHiZtVP+Rqg2raAkD+QptrmbCU?=
 =?us-ascii?Q?r7rQW3S8SfgvT/i62KX/U25gJST4g1ZTk9R7+tcTwSv/HUfdGsBUFYINOqfL?=
 =?us-ascii?Q?77TCIkcQDjhzTULKIr731dlDyR6MP27nSGNjsqjiaVSWSeASCeej3/Sfc60x?=
 =?us-ascii?Q?hZ0oEY2BZRYrieo6DmYVqTGlm7F3mPkynEp7PWBsl+WilTvJNfD8g6WpnrPf?=
 =?us-ascii?Q?ZnVhtywKRNKcYrzDjBlQZxEw/G8lWXkQCdkf+yiiBOqt+ULycoCsCSGue7KA?=
 =?us-ascii?Q?cgKTCNFUU/ZF6SCkdxA1SlvmAzvglIWsYJymP2KOfnMw5ZXIezwK/VF0dRhR?=
 =?us-ascii?Q?cdY4u5FivC92bVRAOT8IsSVQEQokjraoBijkPICIm2KL4XoW5jDpSSC8OjKs?=
 =?us-ascii?Q?GabXVT7ABKj/o5xtKKe+h8DQPuISMltZiCtvtqHT3DmOb3lXNxqRUgmh34fR?=
 =?us-ascii?Q?b1nf8Tk9JOn/i/jruVhq8qLPhG+R+8gZOTqcs2vaq0iOEd9WIfLkaq6kP7wo?=
 =?us-ascii?Q?GX6YZJ81Of9cetjljQVcPGERy9wYO/B9D0wJTIvv4oHOwAYaOR5CMOV+H4m2?=
 =?us-ascii?Q?8qna34VkaJCB0fyjoJr8gJp2LsC0C+w7Higjp5Keff3f8d7syOx+/6csqO/X?=
 =?us-ascii?Q?DH0KAZNJ9utWkE5kikfoxZY3d0R7dIt7piMLmpyBcYrXghPqYALGWyXYFXGQ?=
 =?us-ascii?Q?EaLtoJd9ZcETURDlW57b5FVoNWMiNu7wxQTosw7l/zzhtC4ulCpKEWGRYD4i?=
 =?us-ascii?Q?STKHK+2qDR9IY6UqnoK5lGEJnnCKNcFU3Ghk3uzDhU+havKSo9PbGXrZNg2P?=
 =?us-ascii?Q?OtTyZBr1YxksDtZqAGZ7XqbYt432bIV3Mhv4KPDWIS5evBWX1bwMxI1J3MjW?=
 =?us-ascii?Q?KYgZuF1XIDg3w2baU3NpeL0G9q5HqUW+yhdwniVA4lPSJyrMx+P/5ugIsm0A?=
 =?us-ascii?Q?yYVhlTygfunyNpQojZ0IsAt9sEuAL/TyHjg8R9cLMvboDH3kPunBgE9qN7ax?=
 =?us-ascii?Q?IHKqnx8qsxIBuYyuxv7x5s+1jr3NQ7TPHiidPTqJtnYpAF6YMerpy/GSHnWz?=
 =?us-ascii?Q?UTAWLmm9RO71iVQYu94yT5BuUYnSJreQeTrmKUbSTtA/ntk42PrGjc6ZxTDE?=
 =?us-ascii?Q?h1KL9NsvYsGBUYEH/37q8oq8imT7mu5krdPudzYTHPOBqmh7l9/LGdujqCRn?=
 =?us-ascii?Q?Y1416YjFnlerX929ziUldKEFsxE7R0DkivD2K45vlvrznMwB5RmRn3Ote0NM?=
 =?us-ascii?Q?PrzWD1gNQwV2ompFMcubx8Ma37Gky5DIzsmxOfKK5zSoOemaUV/O0Hf2WRV9?=
 =?us-ascii?Q?sosxlhzdXivC+w2fDZBKsGBxPURI/n0sIpaBd5u538/mgNT7D5AFA/pmzsD9?=
 =?us-ascii?Q?4WYfH05vpp1uEsYe36s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dbe5e7-539e-41ca-9ca1-08ddeca983be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:24:56.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0NbQVuwM83fdCEOLHD+5koFQXXsE+iwGQdix8zY4VbH+PR6Vb0AiKBY1uPCA0oY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

On Fri, Sep 05, 2025 at 01:50:57PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Now that the API is in place, mark kernel page table pages just
> after they are allocated. Unmark them just before they are freed.
> 
> Note: Unconditionally clearing the 'kernel' marking (via
> ptdesc_clear_kernel()) would be functionally identical to what
> is here. But having the if() makes it logically clear that this
> function can be used for kernel and non-kernel page tables.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/asm-generic/pgalloc.h | 18 ++++++++++++++++++
>  include/linux/mm.h            |  3 +++
>  2 files changed, 21 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
