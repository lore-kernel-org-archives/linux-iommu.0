Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABCC86346
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199517; cv=fail; b=qIiO3JI/Oc9IA5puiG9A1tA2f2NxUCnInP5Fz2cJ7NBGQ11O6xoqLHMfMK00nryjVf5S89mhHItVvOGRCj1J9F3RtXSIx28swJjZ1rwD33SWf0IjWd0flcBXY5+0t/NjhAxyUFQ2P0ieeaXXyGYcrbk+Mp0/EtEgImi26Z5pTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199517; c=relaxed/simple;
	bh=up+svE1KsgjSMnHf/TQVm8JDHPHGDlchUNBKFRHR7qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tSQSRQGAIRkhNCjAINks34Ke6YrfqTX1TJxwYaCRHsUqjiCTFHDT1QwqH4mt9Sk9Xc3HI+xIXJXxF+MITzabUw0KHLHW1mphhAkSFwle0S0I5jR8ifMP6V+dNa0qzn0R9d2Wp3me3QHY3sxnOUvqZoUIjZmjxFfBJP8uAJatmWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+MnPSQY; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+MnPSQY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr1t7bBR6V+h3wqCamEJh3OJ6E7jNoM73wSs4n0+UaPlIxDxz56pn+5u219marHrO7c8AWebzYPZmy2ww5GdDC8a5brIkb7RUASPshpZCJzAetYyIIiK7OJtuh69MjXYGR+zUQLz6NOagMIpMxZQlJc6PTzUPqb7v5nXMuxWsXpGXWdcZCiBnmPDT9vJc8VVmHJmgmPN3vrsJNUrabeYghOksvum+b7oGCkQFAzw63lO4Qw0uaVlHgbSubxULVa+Bek/x8rwgAxKk/+kTP7CQtBfywFxwqprkIXS56TksKr9SzXfq4DYrd742re3maS8IFtlvnp4CW/5vZBmDnIMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HrGASkOED3iBpi73uX46+eF1FL4CzvwBcXr4IhrTiU=;
 b=C7LXW1aIe+ayqvF2Hl+OhsVJIrEBDR9DA/i/1SO1G9n+yOpHD9hR260Z7bNIMVDaA/dS/PsGU48rruhd6i9QM4ZdnmrUM4EE1BfMuiBs434ABXmC5Tv376g3OeKcx5NMgPxx6n+5hw96JIt1JxEylV09/4eI9vrdoFwxu8Ej5NPIQFVy64FAJ5M/fiARwYdyVQqo0KUfWYIdHANSKNwoQpbBhGzz/ZhgzIpbRhJxsqAH4LKNqFD9BDRbk5tSdxjTC5SfhvRlig2ylPhUbuTA83BJIRQKl+y8jCMYWtnpWevNrlvnp2FgfyCexjKWc/b6T5GG3rBzaq1TGSiFczAPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HrGASkOED3iBpi73uX46+eF1FL4CzvwBcXr4IhrTiU=;
 b=N+MnPSQY1+oySkDFnpsZRyHXY4Uxh4shXeMpsWMVNjCNJ0gJUO/EWyBFtbcD/RGMDzFQwQHTCCmtxDUaPAKLXmRvxD5PMxNIu20+CvlVP9xiZJ5VkPXlcGYJWX7P6GnDhs/v+WE7VPAzNNAI+xfvI34/RVwhH7P5+ld3kMT6LNh1IcQ476kZgQFRuetDIktGtudJKGYvYoZNyz6KnCTg+Dhq4WKhf1OS9+ScUVLFMNHptxb5Pzmy9XHQ29/y8hdr4CgqLW2VitB2Yu/wuNOhVuehs+J0rvPSX46Fn9+aNREXqYzEHwPDXn93DrmpM9WS5jjmZDGAa7Bw2+K0j3uI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 18:31:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 18:31:52 +0000
Date: Wed, 5 Mar 2025 14:31:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu
 instead of s2_parent
Message-ID: <20250305183151.GE133783@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <20250305165452.GY133783@nvidia.com>
 <Z8iWqOBga8Xdunac@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iWqOBga8Xdunac@Asurada-Nvidia>
X-ClientProxiedBy: YQXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::41) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 43de5ba3-3301-4dae-c785-08dd5c14000a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdPwoFeMW6/CRjTjn79ojjTyGZ2S6OSbOgvw6utaHbEbycFmBqT4TKST/TWJ?=
 =?us-ascii?Q?u8K4RH1CuZQ4pyIkyFAT0S9rxSTnkjRpjpimr0eAtsvWw5PXln1IhIp7ueay?=
 =?us-ascii?Q?o9gr27mz0OUfXOYJb7NqXJ4gbPgZV1jo81kqGhrdW9J9bwu7xQs8QeoYXiXk?=
 =?us-ascii?Q?CYiej2E3nhEPfg5mATQEu9cQaBHpOHCReP1KLOgEy+XnffUAR1gVtplBHFoz?=
 =?us-ascii?Q?1o5bPGaYdrdngx13mHmK1bNP9x0v2krXWIwwelWR7u7vE+6bYSmVbqmVE65S?=
 =?us-ascii?Q?Oi7cE+XNcGm3oR1JQg2R7ShUL7FB6goLB5XanWiUtxk3JvxS75MrbvusGbYo?=
 =?us-ascii?Q?9NpzMPtKQ/6JjuhgUZUo1Me2vTRFliehL4cQ4eQQj8DDNVidRbI/pOWZOQqR?=
 =?us-ascii?Q?EmJV8dR5vrW3n19BtnmmkOyhKYXeLSZWWCJuih5pl78KqDiAbICUwjZvLywR?=
 =?us-ascii?Q?oSNGbq5RFzv0Fz22xSD8OKrgn2KEE9Mg6oTmy4qNhAAtBZWd1+T3Mh6vyfRZ?=
 =?us-ascii?Q?tgWug8mG3mWMTa/OPtvvvuq6VcnDJx930j3/IZUmaPuHRcm2AOoMT6X2sVHz?=
 =?us-ascii?Q?5Cmc4yjsL5WuPX0/Gqq8RVihDbIAh+vXgcXp/2o07BYP/DWtehhpIR5OY3fU?=
 =?us-ascii?Q?Oj4Xq4ZwPebZr45V2dhYXKGts5co1p4xqpV1RWjLJsZET5BqwASlXs0lThmN?=
 =?us-ascii?Q?aSfNgkGoa1QCfnSBcvg5j1AF0z/3Bkzd4CUhY52z7dEkg5kg9j52vI1XE6Mt?=
 =?us-ascii?Q?SwxGAFkFPmP8mavOnBus3bfY4Qq1sl2zjlxOJsL3tFKadF2dNXrHh3lpJ9Iv?=
 =?us-ascii?Q?4WtktVU8XE8UcxtlV4zMf0O2yCGEwrahStrIAgB9vLBdn9IfJcd700UxVJps?=
 =?us-ascii?Q?+9NZjRBISAmFJSWPMvNGm/lK7ay4mtS346eP2PYsJB7ZUBGYlUqgKMqoEe3J?=
 =?us-ascii?Q?rb+53QjOsE8XF8fBQKOu7u9seX1lrmgjt6nzgq8PNUubf6H+vKMTTFogdI/U?=
 =?us-ascii?Q?TsV90UXHiZgWwBUwbRkL0pdk9mEbtwoe/y+ibbAKf1+ZzQX3bk5e0IAmTqOn?=
 =?us-ascii?Q?hnNKZqqSasWp4ww1FmuHA8HBQKHGfQpVWqnBDAzKxz25Lqxb3/w80si4UY1i?=
 =?us-ascii?Q?mK4kTY1+oxtlxL24LvXe8T4mpYyAYkERAzkiABwtVhyaKIdk+8yfVpLIDGrE?=
 =?us-ascii?Q?hl3tKuMrguyx6qCMy3rUbFVKwxE5tN05SYle+9AjLeAQLYWr9h4xpQvyX+c8?=
 =?us-ascii?Q?e+JaRTj7UV7q54cJSsS2yrctqePiH9LecPzDn7inhtTOx228jzyV7InUpq8T?=
 =?us-ascii?Q?jBeWWR+hIUPaTPmIEKBNN1VIS1B8u7a6sI9gdTdBuOqHigv9QuozuXAVTop0?=
 =?us-ascii?Q?baNDf1Q6C6nwgYmRlmzSxH6U+2eT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+/P5RL3pjeUQFOJiWOX9O5TxkbkD96fAtoCaiATLmqMqxVeN0a07hn+Okhk?=
 =?us-ascii?Q?ihmp/nZIMXehRf35bSgcExSDk98LNXgOB29KJlmd0GyoZpyhikUyky3NjCQP?=
 =?us-ascii?Q?O62VsBA3/+LEfmQppAcgjvMpkRCAx8TxVvb+9YMLtlCxEW3BNwr9p0kDWSXC?=
 =?us-ascii?Q?KgyR0/LDF7/iCAj2aoIBhcHxVmL6deaBj6zecL4CPXQF5iD2QdkaWNeiSuTP?=
 =?us-ascii?Q?OP9plHKZN38Vms3YhGDl9TPcnQrn8O9F2EtUTaX1XH9e0Ro5f6Qr1ANJvBdh?=
 =?us-ascii?Q?vDmAIQVolUmSDQRXD89Mpd638VX3jtYAdLkGjbkQ5BjZG6Unpm6IpTRc2Mjd?=
 =?us-ascii?Q?wTeKnc3Cb34dEpzP9ysO6ugktOpnIZ/h/ddjvDE599vGQGH2ITROY2i8+QMi?=
 =?us-ascii?Q?6NInAzJX/kLfZqZeqd6Yz9Me3+db2PWnR/0Ac51GC1cXMAgFbFq36QL8Iv7y?=
 =?us-ascii?Q?scIzVIhpW1Rh3d9pDAYfU2PAZf04s0FrARH98C/uGGxXLY2c3wfaywwEkeMf?=
 =?us-ascii?Q?5n9L9ToRERjYQSGgEwBoOxMXt8lCCD1jnRDMS7m/AvyZ/MPwAN1B5VpDNBL7?=
 =?us-ascii?Q?Z3sFBl9izMy+YVxBc6vl62/ztokQZXKhF504O6rJCMBEs7irG/G0KjneLoQ8?=
 =?us-ascii?Q?XKx9F943h/mjC4iXkJWqLKCU4CDodakdwj0XWCYTz0soFIoaaz27PcqARtvJ?=
 =?us-ascii?Q?v26/V72d5FMrmYlEEauP6hDgf4si9ipZ0Wr2v3Bya5OAVCR6lqXD4eT9D6bB?=
 =?us-ascii?Q?eCB0e8l3bC2fpEDwsLqlh99fU1T1f0nJJW3SyDfEb/ebThktBKvJEMpLMd0r?=
 =?us-ascii?Q?iRYdRSiXjc5RB+mFYvjvIETfUNwHecZOW92J3xrtd68x6lxOsZG8u5nyTPOk?=
 =?us-ascii?Q?gZzLyE8jHyLYRc1WL58V2Wc/PNkImYRZQP4up3lgvoB54YJZN9V5iLz7o34A?=
 =?us-ascii?Q?Nb/sANNgtPBr4l9SxBSROGKGlyPyG2vX6M+V0GIpYKmpDWAHBSVJiFpEFhVT?=
 =?us-ascii?Q?tkhhIMfgxDXt9JFvFGxS3nk1pQ43Y1MxtiQIUtc8lM5bwuKSSnBq/x9g8UH/?=
 =?us-ascii?Q?cZTcK46iboiRXKxKtPk1VE/F89C60MMY12MzzB4Sg62pYRyfd+fcpgNfDMU+?=
 =?us-ascii?Q?OT4e6r6FDUMjoV8ovQsJEADy2nU5fiTGuWY/3CBfETjPAMY5ckFfUGe4Dk6q?=
 =?us-ascii?Q?afn0tPh6IH/U1xNS+0DD4BluTncArrOCBt6AZ8IAqGO/HV20ho9MYM0ntqpc?=
 =?us-ascii?Q?r9jFrdhYh2RK+PrEPmCizQ4tZiiM1SvPKKiG6Gj7YL2Qe4ljq7mXfbfovNan?=
 =?us-ascii?Q?+20ouJOk+N+X7fUFKJZIqjWvUMDP/LLC9XKcC0M5gHqKM0mwT0F0kTa4wWOs?=
 =?us-ascii?Q?RVjr8nU8KisToeAcvPnwfj28wPNPE2UrxQ33HtxARaxZhc4VcAA4MonIxBoj?=
 =?us-ascii?Q?B0ussfDAlb/2tuuva4Zof/VH0+kYvCKepOt+tcjkEwze4I/DeHq45MBQ5FoS?=
 =?us-ascii?Q?HNK2+94tbYcsJpiBrOYBdiWWXw78KDSHS9RXVnMh1Eh4eul+2oACNjQhz9na?=
 =?us-ascii?Q?YeLloJYtgyQRG61gADZDqH1h5I3WvmR4kW8x955f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43de5ba3-3301-4dae-c785-08dd5c14000a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:31:52.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9yfuqRM+6D8q/9XWmjWYY6U20AwLLgcG7BHCImzvEETe/RGV/GA/MbF6r8/ZuEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

On Wed, Mar 05, 2025 at 10:23:36AM -0800, Nicolin Chen wrote:
> On Wed, Mar 05, 2025 at 12:54:52PM -0400, Jason Gunthorpe wrote:
> > On Tue, Mar 04, 2025 at 09:03:59PM -0800, Nicolin Chen wrote:
> > 
> > > Have a pair of patches getting the functions ready for the vmid migration.
> > > Decouple the vmid from S2 parent domains and move its allocation to vSMMU
> > > instances. Note that a regular S2 domain (!nest_parent) has to retain the
> > > s2_cfg and vmid for non-nesting use cases, if the SMMU HW doesn't support
> > > stage 1. Then, an S2 invalidation has to be iterated for all the vmids in
> > > the vSMMU list introduced in the S2 parent domain.
> > 
> > I was planning to also fix the S2 to be able to attach to multiple
> > IOMMU instances at the same time as getting VMID to the viommu.. It
> > doesn't quite make sense to me that viommu would allow multi-attach
> > but the normal cases wouldn't. Did you find a shortcut?
> 
> Hmm, not quite following the question. You mean vIOMMU attaching to
> multiple S2 domains?

I mean a normal S2 domain attaching to multiple devices on multiple
instances.

Jason
