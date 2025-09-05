Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D01274B3A
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097857; cv=fail; b=hHXWzYiSZAzBfGtzRtMJZMp2ILuEPhbspIAupBKSeIZomm1Tm+x3KOgzL+rdaQZrc/rezhodoNJcGLmN3iUeTooeocSsCw2Tm+ljYeWMAjYnNGv26KyFCWnZHtOoN7iaA97BLS0r80jPYkrtlIMLBzw9/bJ2zIVShae8GN8JQfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097857; c=relaxed/simple;
	bh=H9nw5+T3K9W5aC71FjONIC0ubJgpxrDL0s9P1DTuG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVAhdPZFScro0SyuRkt6blVcQWi5PS7lcziRSetlNXaoVq3sbuBjAri9jNDfuQPBuvUAXMUVxa/fKemSLeHhwiZpToBuGPys+Zwc9XbpqYjeKnCF6tggiunT+0VWB4a2tyR1NJOw1rRT1NKTAklIjgumpRsxeLJS2Vf2uwFDDRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R4JecepD; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4JecepD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVjMVtuOSzczEnBz3PWw8qoIGGupWc4CsNjLbz6XcPfWRuvs7uaiL7m9/Cj+Smvtbg8kZZKS5IbwugHnk/ZjhJi7DDH8AOZzJSCrlAZ/F6jDSL9oZxeVWsJD2Eq9/0bli3I0KX5/pLdttnzOg38FwNxSVD672vfs/tWPDRNZjnGRzUnQ2D+7OAXLBNaKT2EBpdDMPAiWONyp3Y/BeBwXw78xE5SWLtSeeBl5SKIJ+ENEp0fjnAJAi+9Y8+2K5Le0P2AinWo/0CSCR3OoHE/yxXjl2/nXad0BFTij8cYujiRiaZMZpyOEirZQuEOlItW15MLgcqoYVAipl9sVNBwjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4llOfeMloJLZvAtdaLCf3floVPmVhmv21Jrv7w503oc=;
 b=vzddCxYtglzpjfsgQrJ+baj3duVWaKEjNP1oAyfi/NUfnoHy02+gyTRlb46bnwAIad3pB0xBncIEEIARszoIYv0txjow/RWBj2VudND29Vkh0JJF7RD05f0pFzRSfBI7p/DEV8zB6uNv2eq4bEvu2v5aOFRkMHx31YWH8ckEy50cgjBUJekNvl7YI74VQToQBxUx/Xkk62OtoHI3AjhQQ2bq3MVEwSH9rGVbRjfqmfRMGWF11SymRWCuHND5S51NyQY0x5wdE/jABf2NJ9g9mRoIL1/1dacEb0Yoyfrm8jH7mpAo9H5+8obDT9hRZTLFA9dSqA/q7CjBL2f7EmlsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4llOfeMloJLZvAtdaLCf3floVPmVhmv21Jrv7w503oc=;
 b=R4JecepD8A0IbNJqzX3XihscRfOwG7nP4Q+IGM7VOkvfhbOu/v877Gho+TfpMq9Kd4/DSRWBFRUdI6ZfGD2Jpj16HScTyvtB7jxfsa5P2CPmSLRKtAnNDykFbB+zzEoGwao5MMG15A/92iW2AajVe8u6aApmbJOrvqPI0cqTkGIqlzeyU+4u3ZP/gh69n/4uDT2iKL8guqjDcsh5wf0r+rP95MwToEP7atnt0UlWPW++Yh2PK1K14sSs7hF2I6hYpi88lekS5Olk9Sh8gN1ZeW/XqIYYPuec/vS02y/dGzfcOp4IpKutJEsJDROB8gzjm0pLGajJM0acb8mZKK4VaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 18:44:11 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:44:10 +0000
Date: Fri, 5 Sep 2025 15:44:09 -0300
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
Subject: Re: [PATCH v4 7/8] mm: Hook up Kconfig options for async page table
 freeing
Message-ID: <20250905184409.GS616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0475.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::12) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc9899a-ea01-40c5-72b2-08ddecac33f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nrBlORyPbLPzQPsRsxC7B21Kq4/RapMU8pRw7+QasIoB/tvjvx+hPL7YNMyW?=
 =?us-ascii?Q?6H5Z6XoLxLWDN+kvQRa/aNj/M9sVifQhc+ptYdYT402ZhkvKk0+BBP4Ruaa5?=
 =?us-ascii?Q?t/BaHeUWPKNRs3G8WDnFA2lUZKzzH5oTPflGCaj9mfxGfeDWcHY4dhQ2rkev?=
 =?us-ascii?Q?l/XTiUY9fboEaVNyxdRZgZBIjcbJkQ/ibgKr5R5dS/ibUmrxzmWysr6lUYSS?=
 =?us-ascii?Q?RxJ8zkM4wDXqbBJPQJFlE1DzIrX8RcUqqMi1rHdegwIduzirNMk7hWWGqjiW?=
 =?us-ascii?Q?YWPzUyVv1rYVwUubc5zddjCCsYRY3mw9WG4d17XHAoopLcBSp1UU3AnIfdIS?=
 =?us-ascii?Q?mlRHcnibnqM3cz461FnV/AOOu8Kqft/JNY18q6eqhkPV8CmuMXZSsp6ooRkZ?=
 =?us-ascii?Q?xY1wloJDxAKrZ3KF9X7nRRRKTdZaGEoGqGOU0t3VEXNFHRjSLoUKfD76ee0M?=
 =?us-ascii?Q?m6tYlUPYW7UlJSD12molfdATgGqC2nJIoMWEZUJ2Oqce+W8bEH/XJ459cHKJ?=
 =?us-ascii?Q?AurCMQbFGgzIXBcljo97kayON0rj6QLIJR272Bd5eO/0415zSAKqsgLTZpVO?=
 =?us-ascii?Q?kNukG6zudreTuad8gtFXgsyw19eRFkxtAnMhBpk+A4httLAxYxxzRQY05kpm?=
 =?us-ascii?Q?+WeW89+blQ2Z20GtD7b18WZ7uaP5H4HD0ke3pQSi9Ewvw508uBCHoDIMvVHv?=
 =?us-ascii?Q?slTlpvbz2LsYXbQ7w0i0NS/oh0k3pJn65y3z5cPRevs/zKHYiQiBSfPl/hGo?=
 =?us-ascii?Q?6VFH1rEVddP9yISknalpPBY9iELAOfQEzV7zb+JwCgDlmdjWwnJpKm1lYcLq?=
 =?us-ascii?Q?Qy8hxaYm0l2JiONUSAN339DWh9hsT42lif4SO3kUBExWUr4CxrlupaA3z4s0?=
 =?us-ascii?Q?AoMWRofIS8Ph/eaq/TfgAyEe41P+2QCT7x2bmpyU4PIdafkEBW/mBY77Y9aw?=
 =?us-ascii?Q?ZGLEXxc/7vnPn6y2XFnTcBFSiXwlbj248JXg4uGe4oVWaPIncrakvgjFCSvR?=
 =?us-ascii?Q?+RDk+jnxwzWO+5YI2w2vNjippgBwxc6OZv5tqN8JHaFPk2dMivHWBKhkSPSr?=
 =?us-ascii?Q?by7tRVAJDYl5k50bqxl9l+DgvauuDOocD6E+J5GhlC9dugZm/i5jkpyVuKF0?=
 =?us-ascii?Q?F1iNh6+G062YtXZyq+HhfuHCRwoh2ntZ4BAUKuJv7VRrhdim1M1Kht/3Kepy?=
 =?us-ascii?Q?cBCgYcKvZ2l6ckZbBCFh5t3bXsKTyDNaYPESRKJIN8WHfQXXL+4JVXYZj0kC?=
 =?us-ascii?Q?3DXPI8G74H6BZQCn0kpGRLI4gZOqVNTygVDonKkKa65b+E1km8AppY7dJCTe?=
 =?us-ascii?Q?A2vOm8IQ2BGp0I6xzHjtZi5cF/TJVPssfJxb+SMjXVavD4tKhRIRbJxYWKlF?=
 =?us-ascii?Q?TrqiOVEjsMDlWXeZKmzPAoN95bNKoe7yScSy2QJkickD2cZGaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k68bctgVcstYXos5RQTqV7Yc+UL54u0OvZTbCahvdvzE08NbAbIkTqtaSSxK?=
 =?us-ascii?Q?1qL/bt9sPAcZFUNsIygae+/VKcHZyihF4e9uzOEllCSi9U1uQ7/QUhZIs1pf?=
 =?us-ascii?Q?fIW+Cru7mge/0oZT61n8KkPNdWtcFBoPumGV5haThenJdbwjhrMkmNAc+C9Z?=
 =?us-ascii?Q?MMqi7lkjwNQDpt4Ti97eh980VvLF9tN1k+lT7Fos+q38TVqloXRB+FIYO+AW?=
 =?us-ascii?Q?+Q9P0jKKnpyRsdEkXMrm24wue1OFDs31IpeOaT589hsjw+/cBtCZO1bdQNVx?=
 =?us-ascii?Q?dcZdH7+B5aF4Z0FdGKLXnPC9fGRYmTOk8RHydf6EfkvqGdi+/FRxIZSFxyCg?=
 =?us-ascii?Q?Q4JiDoUM51+K6K44Z7TKAb4nS8xmtMw/N0ev5QLKFzdexaTOB7oVwov4e656?=
 =?us-ascii?Q?XdX8XuGzL2FH6gfsh2RNfM96T0hCLMy2JzNmrdOCJPewXM1wy6by5Bdk1UZg?=
 =?us-ascii?Q?XAz6pPDun4gv7IfXOGCLokT+cu1vPOQVz3f57D/y9XkQ966r90EtS4KPjEs4?=
 =?us-ascii?Q?kfj89SxCJDeRM5P9Vacr1YkdHsPVv+3949K5H3AuzVBAu8TVyJcpa50015SQ?=
 =?us-ascii?Q?qiR9h89lNJ9p40oiwFb+0ir6OtDatT3EjWPetXObEC9d+pvVNi4LQblNNxwZ?=
 =?us-ascii?Q?v4Kt/Ip4j9mzFfBEXBSLn/FLKzKitLZ+DuvBA9iFTzt7fORUDBMbKp1MDJ/1?=
 =?us-ascii?Q?odvAu4PAlZcys1o5d7S76SQi0wbyy5CtAQ0fTFjP+6kjyJxFkw/BEbHGRsjP?=
 =?us-ascii?Q?79NDMuzJN/sF85YwSTaJyvQoIpQlGoMowx1Ff7M3XCsKrSaSZFV79dN/2jJ0?=
 =?us-ascii?Q?xuRKXTludSKJRrxb9+PF/8JenZ1jXCk1Lggcwyz5zK5RuDzD2g3bz30sb/vW?=
 =?us-ascii?Q?9n44xGLHbR4JjOqrrBxmxB5fUZLJqxEL7d5iJBi2REgg0pIYa8uguDA4paAl?=
 =?us-ascii?Q?Bx+Vy3LcTZP754/4AdoXuiFez9sGrTOmbuJRdfYufWs0Pl7hHsdDX9//WQzL?=
 =?us-ascii?Q?I6uigvP+3H4K/3pBUhu2eR6k36O/SsWHj/wPqQzLTnogj7QPV0+iT1J3OnJz?=
 =?us-ascii?Q?I9mrDxAQcT5799U47PDxhelsGP9aKOhtKb65rnzKA2XIaVBtCCbIap34hi2R?=
 =?us-ascii?Q?wDlgrzjALodhAK6rl/jquXRLP2zfRzjl5Odx8va/mjtDD6k26ZdvxV5PHIfw?=
 =?us-ascii?Q?Flrcaqf9O9erTz6nXkO/xwoFAJxJz4zmqfLURaaa/xQu3aSRNaG0o+AiXpto?=
 =?us-ascii?Q?kEeHv+DUP19rw2jnztWQ4QtLnNpenAKLxX/7hCbKLYAYjQ5sU/RkMgZQZwl4?=
 =?us-ascii?Q?Ny0U+K5wDliggcWkJXJs07kFxOji9mQkgxz8pZvepNsWDThFNX8eblcTo56v?=
 =?us-ascii?Q?orTmnG639UfEvqNCHhqAzleCk7AjWbsNBDWJ73EJh/0KtCKau5ngNNiEoVbM?=
 =?us-ascii?Q?Zzrf5OVM4qBk/b5kGCTzxsI9XC/Hu+tRA28HIEr+S2igdx34nSA3FYaKahQr?=
 =?us-ascii?Q?iL9sxz9fIfZSgZD/RGi14Qew/bjwwbrgfKST2jECY42TKjLdIVsJRT6zzcyz?=
 =?us-ascii?Q?TPQLFWqUUGlU55shD84=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc9899a-ea01-40c5-72b2-08ddecac33f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:44:10.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NroE8KQlSmGeo9m2lEumfnfUkqHlGlKHaQzQnzD6TXLRwtkw64WqAIi51+jL7SyK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

On Fri, Sep 05, 2025 at 01:51:02PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The CONFIG_ASYNC_PGTABLE_FREE option controls whether an architecture
> requires asynchronous page table freeing. On x86, this is selected if
> IOMMU_SVA is enabled, because both Intel and AMD IOMMU architectures
> could potentially cache kernel page table entries in their paging
> structure cache, regardless of the permission.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/Kconfig | 1 +
>  mm/Kconfig       | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
