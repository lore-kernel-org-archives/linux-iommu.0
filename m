Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03049B20B
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340413; cv=fail; b=B5j3Ow+lBKukUx4SlED5cL88axYfMFGvXHfgLPBfDX0nI6ViX/DoPmoS7AEaJ5F077DFwqPEVLb1BFHWwoGL7tT7Ij1DVQ/zsH0wMPDymNx+EU4+iubI6lPav+tiz30HB7DT/hEN0J89e9eMJnQWqEPLO9EVrBoj9vDByDZ93OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340413; c=relaxed/simple;
	bh=VQ8YarD0sXZdp7LZBjPQ3MXYo4TZPkuF4tl/eQGMvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lMl8wDslSlXQeuqupcwfGXoY4mJTPlCQOR0hDW1HTgHdCopye7+qxCYb/duUe3zK1EzADKRgmZWzIs2Okt4wFb7wOEe/mc9OKX4ZGKHswTUJJzpot7r0o3V5bWEa/Mz1lWMx8I8waFTqhFHOFMGR8GEpI/9/DP/UleeeY880A4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNQgdg0e; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNQgdg0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRy46cx1TFt9P+LuFhLGwvR2jtgUIHztad3HvnR9kaqJwTeDNb5WhswuPoqP7Baj81dYC9u47fi5Ajj9N0uXiOAdM0jpTjadITFusgkVR0Ozxk2xTZdq07zs7MrHjmRzNQmZc7/xghowqQ5sKedtPN4Z1NMsdH4VrwxHWnAIbTrGP+YYv4CkQ2pTlYZKBN2Siw8797Vouz+7G8wc0w5T7FCOJkI5ULVIBi+ptDnx4jAevSQko/T+ElBDmoWJyenlZpr37zxeJLBLjZbHiZFMQt6kj4cK/WmeH51ngTOROcZVKO31bV4Bx2pKP9Yd64mYwSiYRsFiwrk06Jfa5viTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fePJ76PCz9vvyTRfWHDtj1x0n5FcxIRTgcKLG+qIbA4=;
 b=oCW4kJG5dwMBlhxsYDFzBJwCnn+6QXql0BSPtOiH/l0DOdW02pwHMPPtzKZ8/vUowLLh6JGvFDizcII5wbVGCd0SMKZrZotFBW8v6KpIulV55JHh4c3tP50/fjA+Xdvy5ltgeQEca0is3fOLodlcznbrQrT9+ybIWjMfdAhkIqvJ2JLMNgHUzVIrM06gUcp9T4MqLTMDWvP09U3fgh8xtMeomd+ijaZheks6ktumcvPEt7MgDnAZXH+vwzBr+SEUGnE2YZdg8aBfg7uJOBk1d2byWvYdefHuHK0w2paxoUter5FE2ezqZwTXG5WYGDGBL7eKxDPIwX59a0UyZlG1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePJ76PCz9vvyTRfWHDtj1x0n5FcxIRTgcKLG+qIbA4=;
 b=GNQgdg0eGNfWxz7Jy2nSkSF2jklDi33cjy/5AVpsoXbDD7XDoy9FVbAWYtueWR8K11osxC7ry5GUKe32xsl7jVjQqLeNA/3lkfHAmieeyPVJzNSulwz2/r/yvUMdZA7/06YQocpONAgNvk0CI2wKpoz7agE2qI6IO3zFJdyMxmpPheKL74hBaJkF+SpHpaD2LnQYmEGxWKAJnrZ/46jwoqcJTrxwO+J2YTJLnYEv7dPrFk2EcwFhDInXcmN+Qo69qVT1G3ukXXSjh+QHqTj9sJsD2nkhjHl7Z3mfJQ6TJ5tySe2iddu0NEDw6X5+gqYsYNPiNdO8e2BP/6Xyii5PBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by PH8PR12MB999319.namprd12.prod.outlook.com
 (2603:10b6:510:40f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:46:48 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:46:47 +0000
Date: Fri, 25 Sep 2026 09:46:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module
 parameter
Message-ID: <20260925124645.GK9354@nvidia.com>
References: <20260909095228.2174031-1-kas@kernel.org>
 <20260909095228.2174031-2-kas@kernel.org>
 <179018301689.3334538.1783583175230817305.b4-review@b4>
 <arZFDAofKaurSjCd@thinkstation>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZFDAofKaurSjCd@thinkstation>
X-ClientProxiedBy: PH2PEPF0000384F.namprd17.prod.outlook.com
 (2603:10b6:518:1::71) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|PH8PR12MB999319:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b637ac-2287-471d-144c-08df1b030fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ff12VPQblrptE3SzdbaGv/Smf+JFDQxKC5pVbEkujHwqNssBxDAxMQ7YLV0TZ7IyU1v06Nfzj88VeEw86ai7W2xRRQmDhA6IZBLfg2zJA43+T6zIk0cIxK39dqsAlkXLnhOZLAxf1Tso2sBzVy61wWkMb53F/XRrzbAiKMXBvbhp/AZAQ1FhjaSkbGZ5dnqahQUI/LCcJ+kEM7j0sz5+7RTil3fo9NJ0UL4aJ3QcCEqQYiBelwXW31mkqTxQDzPB/VgcdsegvIEgPHDZ/Q2hSCpumNXYSC28QmfHWF0LKa5faRIR8FpwfjcKrOsrU4QZOjmRQkhzL8bnNlXG6SkaFbBnKMNnsnyPvRzo2MtQgJTYh8zDl+7AKLquJ/+Jt6WrNukfcii0xE0Hcd+w8MhUT3hQTkh9nCLMNL8aiQul/qBf7JHdSblaTLdK2W+FyxQo/A5NiwefR2Y3Xxzxw7S2Fvcsb5+JVhoTp4nnBM9v4Xl0NH8FNTV3KCGAiDfurF0KObQciFI3SQrrXbbI/N/FQffO14zS1nFN1ChURt52Essv2VYMe9Rt/AXkjWPoHpWC1SMasPZTq5kBeuRcDiDo6cGkQZSKFLDATYGEyI8qL5Gq79GsTzlaCtE9V98bxCnqtmg/R+cA6S0LxQrho5hK0PGaqDwfwR5USpm2qnmzfXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybPHFJ2+U3bPMNJWZc0kttTs8puNDF8+0L7dOFTRifEZ+rt+tGhG4K3GB/ei?=
 =?us-ascii?Q?6Ky1KCbH+qdJJKD7tP6iywY1PaAx3gmIb10N8rNpDjLohJ6kPkojDxEvqUkS?=
 =?us-ascii?Q?4tLx0a6jZtu7NbcW9TfWDM3/oUa46+cHhk08pNZvEw9y1Ah+fhfEbjU3SPvs?=
 =?us-ascii?Q?W2/F2yVr54DCxSbGHGm24QdCCNL/i4oKP4Nc9N1wPiUtdtK6Q/dEVHWXXhH6?=
 =?us-ascii?Q?fumnzMsIkmAr2/o1K1vjbG8286oQulxkx57vFSDtkvT1dxz3MiEUEqoTnGt/?=
 =?us-ascii?Q?4TuanWCSz6y06NskNqBdfORvrSk1L/iwJ+2/VeQpniBCquMssFqpJTjDGlDL?=
 =?us-ascii?Q?hHs6vsUgMu8JvMMxm9Xi1qyC8uRERGoDUUGmbWlIIkUcZKgCNxfpAiSbI2Nl?=
 =?us-ascii?Q?fRU7FEbG/gKf/Y7N5oaQETgDliZWoIiyHRXU3k0j+riAG36egJhR9hG5MvK2?=
 =?us-ascii?Q?gqk1l/N3j1xcKqLfRgmlGw9cjUjFuQIv3FI4cYa+cNqXXPAjkWhI9woJAb5V?=
 =?us-ascii?Q?zQXdH5N9q0ocvg6o5t6nx6BU2U2KyJfuFWwrqLcW0ow8P+fiFzu068/Vu4ik?=
 =?us-ascii?Q?oUPbQzUjfJ8qmdbAXgUCaUnvS8P5aeBS9Ab7Z0zjFBUq32TIJevoaecxb+w5?=
 =?us-ascii?Q?E9gtuWP5hPwpN3D2et6qzhMPFqg+Vl7z8srdvou16IF7a4zM4PSQTTQepOVt?=
 =?us-ascii?Q?eQpL2i3ekzLSOR1aHA0pxAW3R980qZOXEdlwI5A1+z7sfjvmg1QDsXST7wHI?=
 =?us-ascii?Q?tulk7sMo6SrrPqYIEqos9AGBiAhcqjD3laEh+i9VjhKn1EFuKGqNG4t64/BE?=
 =?us-ascii?Q?YfPKA7Zq/TVi2jPQteFOAPKzeD4MPBC9+ebVpq0LMuPQo11gN1RW0LnNRM0O?=
 =?us-ascii?Q?mfY23b4Nzj8T4Dxo3y5K+ikuvu472PsI5P3YdVK1AecL0CGHfQofSU4xidlG?=
 =?us-ascii?Q?T2UM0rJJqS11k8l2e9wdm4f4z4NK/SkSC0iF47V4M5Nz2r2AD//kCWtD6qch?=
 =?us-ascii?Q?vHbvFFjeAdqxP8tx6sg/K9nwPAOeWs7Q2UL+CuU0wAEOIQW6aYFlejWECB/S?=
 =?us-ascii?Q?zdTHyOeJsNBTVjpOFBjZwqiiPCdhg/yRTZDK1dxXSMer/OA9P1PWxFz5mO4J?=
 =?us-ascii?Q?M2WXzqLEL/YeDNtNefcVzpM2JmetiJhJITUfeBkAXNMZGVcutOBZvpy/6NhG?=
 =?us-ascii?Q?Z6SnrdY8lXP5FV4A47dW/d59uoV39eTNSbut8CVCzzDKnFHMec3fySkrmIN3?=
 =?us-ascii?Q?lFbLVmb3FwFancLY3fWV7+jnUA4BvmCoBCD563R+aeDiNKwC49c8sGiM1Z2K?=
 =?us-ascii?Q?nUBF5zAWI/xVfMLW4jmZoqBXllfhXrCA3ru7vmzKcZEh9nMpcAE+iw8g+BZD?=
 =?us-ascii?Q?eSptZ/FdQT1MWOWJ8zwfJBkLIpcljzBt8xs9qO1jQm7l1kXunehi93C0ovfC?=
 =?us-ascii?Q?SwqRVvmumWzl37H8kQw4bftSdCmNlgQU/j2lmxss/MgBiEwXmyooG3mdxbh5?=
 =?us-ascii?Q?QuG1vjG7jeUV38ATzpnGin24dQiz5e1Vr3DpPxv5M1BDMcdvFyGByxWfIy8C?=
 =?us-ascii?Q?NP/wID6bdEg0Hf4+GpzPBYJLFbc4MIC789kJRqzCsGWprMG5T2ZHfRcWTo+n?=
 =?us-ascii?Q?XFq9Ee0nVEt6vDhokh1HNpPCmNdUXO6MHNUKtKDXKS2pQnEoK9LHFFYAWzDO?=
 =?us-ascii?Q?vGS2wMCWum5tDeo8UHKwd5gvNTRUaSBvhOdXhRrox2MqdaP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b637ac-2287-471d-144c-08df1b030fd8
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:46:47.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZKIU0B+22iUz+p2JsJj4CpdDa80wTI1ApesItPPXVRwwGrsewxbhYnvQKbE9lrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999319

On Fri, Sep 25, 2026 at 11:01:31AM +0100, Kiryl Shutsemau wrote:
> On Wed, Sep 23, 2026 at 02:03:36PM -0300, Jason Gunthorpe wrote:
> > > [ ... 34 lines skipped ... ]
> > > @@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
> > >  MODULE_PARM_DESC(disable_msipolling,
> > >  	"Disable MSI-based polling for CMD_SYNC completion.");
> > >  
> > > +static unsigned int cmdq_max_n_shift;
> > > +module_param(cmdq_max_n_shift, uint, 0444);
> > > +MODULE_PARM_DESC(cmdq_max_n_shift,
> > > +	"Cap on the command queue depth, as log2 of the number of entries. Zero means the hardware maximum; the queue never shrinks below one page.");
> > 
> > The patch looks ok
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > But I'd rather use lg2 as name, especially user visible, instead of
> > n_shift. "shift" is a word for bitwise stuff, this is a 2**N log2
> > encoded value.
> 
> This name has changed twice already. v5 took the value in entries.
> Nicolin asked for a log2 value and named it after max_n_shift, which is
> what the driver calls this quantity everywhere else.
> 
> I would rather not rename it a third time without input from the
> maintainer.
> 
> Will, this is the user-visible name. Do you have a preference here?
> Unless you want it changed I will leave v6 as it is.

Please at least fix the internal logic to work in the saner way I
showed

Jason
