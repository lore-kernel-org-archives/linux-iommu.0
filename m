Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F31C8632;
	Wed,  9 Jul 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081743; cv=fail; b=A1fRBzfqb+WXg7UGkTNJPMSywgO5gBHyC63qS+Z0bTiarEmOjD2eMnlBk6B3I8xp5UQYCTtmBscYbSy77cHjqWDkU6HaYq6qzh7sojzTnJPe7E5DByBixfP/wEYXDh6WmP/iIMSh0bNwnQZBsl/OUC1pZwCxTUsYQnhfkuBUdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081743; c=relaxed/simple;
	bh=1BaQ3fIYtzzCXMxcLNCI8F/CKVOBlViXLG80SpYbXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRLfGAA1JS0q6ND66tlIVjNwcAb63c19CF/Z9OB+lvh9P6Fb/U06n3NieazbdhKIr5h0ZI6iwuUxu23Xj3EYJBzYLeowAzc8wOdxxtFDyNNsIZt4X4xMX6J00I3dF3LP0+UB9Dm06RJFu87nanUdh7nAeol8ExADO5TuF0fkBuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A2Xuy2ra; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2Xuy2ra"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1mn5xnCpWHwpBMR4gzhvu1G3R3QQptiBGEAAkcHVm5Y61yXYVQleFSLzTzmIg0PsJ/qIQZ3G4hKH7u8iunaCYa5rXZ65ntEjhjcnZrzhCeizz2oQZ5xnzdAnDDYGs8jl79OJw06NUNT3ukZ/zRLnHgwItfxqeJ9GcQ7nm9jlSmnnel5oKb8+sPExmpYCuC4XqCaCE0SX2TipkAvNUaUzN0zqWoSEpvRfJmHZl8vEEzNqO0o92baomfxIDVP7U3kMG9VXO0fX4LdFZfq9A0SOy0h0onmVxTdBidKdKTyakK4Qckedrm6YXZTAJjpnIjT0qGsIzFzNHLSOBpUQ1uEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlTcOlVRnntJaeBeM4LbcRdaMKciRKHbtZPU1DnfgMI=;
 b=SGklsBZ38He9pNYWo5UFjMbMGHtCv67R+LVEV/zmIdmby3NJIvUjS3pdM2jeK+Hfxx2qK1YpxBCz9D6V5g0wlrGLBksPsAuxqEGhcIFs2QevYTuBVg2Fw6k3urkX4noXKadtTNWSmZySMakyB2rZxHvDNJ+wA5WVr3sJET2cvTqe2HDROpEG0YB/SGyK6uTaAcMROdQpdcAYBOKaSsYojALX6bTXV5U+78wGAMr5lSFgWwUkPSNBgpnr1cggAS70br32CFFLh0qSAz0x8JgzuK9H2/qdvZ/f/vuBM3qkeDr6mupLDzRZ669jDJCNN5u9esDyrWmsWDRUjUGyIWSX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlTcOlVRnntJaeBeM4LbcRdaMKciRKHbtZPU1DnfgMI=;
 b=A2Xuy2raNbcyi4pxe0zZEOJe8nbgs4eH/RVxNoFuk0uVkwTD24lZj2cU7lzoeS+8LRRkaQfp7+bzxCjAweoeKCutbVvJPWBpTDmRnyejYKuYpbXeEydINuyh5Ql0WKL3Zh21Clth0iHslItCBIo2NKgMU9nlhZ4XI/claUBgPSHbR7IUjBIfoE8EKAxK3MUcVWuF/7/ImXHZSfw6SDYiYoXb1f2J3+ILt4YNbkz9lQgojzKypJRUw/fJk9GYysJtWRKeNrOK4qeP7GV2qHrFq0onZjIMLVtlkNFcQi6sam1gmhJAB6khSZ4l07IiVC/MnA+bz24ISOUKtkQqAZp/3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 17:22:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 17:22:19 +0000
Date: Wed, 9 Jul 2025 14:22:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at
 arm_lpae_map_pages qcom_iommu_map
Message-ID: <20250709172216.GH1599700@nvidia.com>
References: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
 <20250709002521.GB1599700@nvidia.com>
 <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
 <20250709162609.GD1599700@nvidia.com>
 <ee234cd8-63dd-41fc-9a5f-94ffca21e2a1@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee234cd8-63dd-41fc-9a5f-94ffca21e2a1@app.fastmail.com>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb470ce-6151-4186-cdb0-08ddbf0d287b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKgGOx7qV4plx/yhVS6eMpzNCRoR+fBRZYtSLmjwumKIbS0NyEg7rXAUZoFz?=
 =?us-ascii?Q?5I+HgZbd5/Ng92KRbatYHfbcfp72PkcpmFzGrjnQX8+XgLlxOZJZGsClulY1?=
 =?us-ascii?Q?ZzcUb24sNbrdFAjgalj6iWN9I2REV0jYOEa36ayMASJ1ONsgXhlq39A8Ci7O?=
 =?us-ascii?Q?jeGVLE4estLJ3fm+1EubXycHQeob3pgWsbyRbBWOGKe/OCMxDwBeA8fZWgd2?=
 =?us-ascii?Q?aPdBznnbZunpFYyMNWCY8CXR3HujaylVorWKIF5elP7qWS0RpWz+shz/nC4Z?=
 =?us-ascii?Q?uf+7bh9aSTSFh5oJClH+bxuf7hOXxSjkrG4IxxLHDLYfWjHMpj8nsmeBcku6?=
 =?us-ascii?Q?za2OJahtwNrhdlrhGpt5rQixen3LKYJ6ZZJHFnzg6fPPHPPi7xbDQlApNo92?=
 =?us-ascii?Q?uWtc9LJtcNoXjIR1/pYIzato3nwTOo6D+GL4gupACmJD/WlhnrWvQS3Ct3Jn?=
 =?us-ascii?Q?PiPzj0JSSJ40+SAzATnOIN2D8nnpovTvqjYieyUG57VELOvjH/dR3ex7Wu3/?=
 =?us-ascii?Q?9dPeeEJEN+0RLopkPytTtIywOw05h7fs6ljFCAiiawAEaGFtp0jEzV65oMKB?=
 =?us-ascii?Q?EHTqxJM/QiC5Fi9DfEgj+KmZKT/6QSbuuS2XbIDn2exa+z9W6j8mkyAqWVLU?=
 =?us-ascii?Q?tOSSA677LYMqXxpjWqTzgRyfFmE848ktvgFGCO4RtqaXuzIgs5kKAwFnIz4c?=
 =?us-ascii?Q?7+87PgqQn+sC40Er5MYfsafut4Gl1fU8F9VfnYI67x05hoOWWMAGGdBH63QH?=
 =?us-ascii?Q?kaePi4tuRXzi1EjwJlfCxV1l+8G2ghFXydgwZuQ41+xzAcZZznqO+eFRmC/P?=
 =?us-ascii?Q?r6HfUqp2BQ99O84ZdAtJDpQI0Q4FOGLvJIpFNW4wHwuFBAf/Ug4SZKyR7b6h?=
 =?us-ascii?Q?LlmlkrPceuMeO30wfIVs0WroRnpZSohOloFevS72NedmYgxr8HXhje7WOjs6?=
 =?us-ascii?Q?00as3bBMMXlNPu9bdpyTevzVLqREVCpCcH45cPHbdGgQHq7swgEav1FRWhws?=
 =?us-ascii?Q?DmXcBeBJwjcGyfuvGRa8My7wRrZUSXYudmGBWa7lTqkiSFVrtHrBFG3tOvTD?=
 =?us-ascii?Q?ZbOTVuYIkRg96lStjgtmQWQ0+bZWjdRsvQU5tTDWB+9aYFmn+NJRgaRVNbEY?=
 =?us-ascii?Q?7ZDHxRflyfyw9GogAA5Mx/XUfKdlTzlioQlAp0Neo5uXb6v3w4IB6YhssdZQ?=
 =?us-ascii?Q?aY2V4iqU/TvihBaZNEebr1szfWKnSpNy3+Hc32oEI5i0ZJn0XI0nVXBuO8Tu?=
 =?us-ascii?Q?IH6hZHhXLRwfrt/pdbleybvZoOHZDMAogq6DlGItZe9fJuH+YdP7PVcK5PKj?=
 =?us-ascii?Q?7IfODd2jl0Xo/Q07bG0bPxDx38u8psPgPp3sofH8kRNafo/GNQr7qNmKQphw?=
 =?us-ascii?Q?4iz3U0lQPl02hkyoCTv0ZXE/NcvvxqISpzr3L0m1RabTPiyVuyudNFLM7DJS?=
 =?us-ascii?Q?92y798babeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XYK+4zVTerK93hGVpTEndqi1rfdn39CAvivmBxiN+aMX0oXda90XZnCfqzf?=
 =?us-ascii?Q?XvGjz1ixNoj0L0A6dfEvAd7tTGnmgxV3/S+vW+FoW0QIwxwUqKqshHuKGBZE?=
 =?us-ascii?Q?+RCrefLGMdYr0P3IwrsIA7IUiKOnSVvHeoXnXAfF/5OAqIAFbVTI53POhdyQ?=
 =?us-ascii?Q?4XHI7S67mxTNU7y97ggp3uWoBYqucZM+N/02A+Fr7DwSBDwQextfxEMorwLG?=
 =?us-ascii?Q?bwr8S3dj1dYt6alMTuuDJlilQc6E4eS5G4dOAwip+6uCRVcdGeQdpzZlzMYb?=
 =?us-ascii?Q?mLF9xVjj46TSl8+/8QgGKsBUPcIF+XemjPClyhCrX4zcvaipWRYpa1O2bYfJ?=
 =?us-ascii?Q?GteQyHPezuMESU21+VyugSXCr+Kh+pySNozr++MFhujSAHaA7YIopyG3x/MF?=
 =?us-ascii?Q?PhOQUVk8T4V6h5hj80VELj+zjlbSnZnTeURBNPo7ypEhf71QuwOMupV2VFgd?=
 =?us-ascii?Q?rbWDlJUHyL+K8NLv7x1Xlp6Eczcrt1adzh/HxSWEP6kOOudNKyZofMdIf7No?=
 =?us-ascii?Q?DRYRyF++FCjUWCrpBfwZhi7mXpliB6fKbnE5VRRzmBFoEEJZLqwIgYsqP5b2?=
 =?us-ascii?Q?g4+NNY7OxEZJ1/to0vaVTU74ifXC8qRrTzsFfht5U8qqifOfzyY6rSb+EtoT?=
 =?us-ascii?Q?hNuWfke0awQyeNFL8LUuXA9z5H4TslwVb1/3R18i/b2TRyVjX6kWcwWHsmRI?=
 =?us-ascii?Q?6SIEp02wrvUwNbcqQ1pnSI4pFyFi8MahlRGr6mGaORwtyYCgJzJsSBPD2Q20?=
 =?us-ascii?Q?DQY9sECIVfYzhBBVWPloFh+XW4xnWhYiE2MOM4OZCl00ZSGXNCAZevH79GNx?=
 =?us-ascii?Q?Ji0iUyInj0O6u88hyb4BbMBuby/yhIIaN5zCuNM1kzKbp9COYg3/oSf0stR5?=
 =?us-ascii?Q?iyyIJcrHlwHf29Q9DU7/PbCXJ4sIkdgEkKABNZFLTmfQe8yrL7aA9qsgcm49?=
 =?us-ascii?Q?rE6+eJoDm3EJwcVnpxqHMH5Knl0KtTe0cyEyIieD2XLq5G3huhBERcpimSxs?=
 =?us-ascii?Q?T4Skg08MixcMAAjyjbnaT+pDGoqiYK//CA+a6KPLboLHJFnY0dZPuQo4TF+P?=
 =?us-ascii?Q?asVISJPxX4blwRy0RkPy7SNdUPbm5jHa3bVOu6Tjh9w/9xsGKUGP4l/5DfDE?=
 =?us-ascii?Q?V8UQ7MtDRz88bfQrRjP8rsFDV++Ow4uOpr4hez4Kvqy75C/NN9RsbzfLRmtO?=
 =?us-ascii?Q?iKGS0qlERGAs4mLd7csxBEuoiRj5SeOJyip21ypEa5b8SJkdClGr1Gqh/Be1?=
 =?us-ascii?Q?g1FBWNw0jXtZGxpNp539gCZsRIQibXhJ9X2ulp1WggUS4IglxleLj9qHDo0F?=
 =?us-ascii?Q?a33KA2QEJVrcNd0E9imHAdG+fryVaoDelEoQA8urBfXVDBh/c5+sUI/BCi9a?=
 =?us-ascii?Q?dq/8gOiTk/BXrTRKbOfGBvuJ3cSqgNP1CcJK/mwnVyuEMhaxHEOq/HmD/ZsC?=
 =?us-ascii?Q?RgxIDOdt+tSukvtNQnKx2l05KPqueFyY5Md6aVa07/VRm3BhRd5KPwhZmmjA?=
 =?us-ascii?Q?U1N0wLlNpDQsxhuj1/6L4bB/RYjm44AIMPBP16GY3e6OV3BS3rqlFP7jsDAf?=
 =?us-ascii?Q?N5rbmr8UeJhYrUvccvNNZPwcnMfTxUBfe8qle0N8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb470ce-6151-4186-cdb0-08ddbf0d287b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 17:22:19.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKYk/Znai4o67Kg9iIBTDfAKVF34waM0Vnv2s2v5Y88SlCWqRU6S3sNBx7urQLf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557

On Wed, Jul 09, 2025 at 06:50:02PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 9, 2025, at 18:26, Jason Gunthorpe wrote:
> > On Wed, Jul 09, 2025 at 04:14:26PM +0530, Naresh Kamboju wrote:
> >
> > I believe the original text was a copy and pasto from an ARMv7s driver
> > (ie the 32 bit ARM page table) which uses that unique combination of
> > sizes. It is not a sane bitmap for HW with 64 bit page table support,
> > there is never a 1M option for instance.
> >
> > So this removes 64k page support, which maybe didn't even work?
> 
> My guess would be that this bug is specific to this SoC running
> in 32-bit mode.

Sorry, it was unclear.

This driver always uses the ARM page table format with 64 bit
entries. It uses the ARM_32_LPAE_S1 sub-flavour of it.

This is different from the ARM page table format with 32 bit entries
called ARM_V7S. Only this format uses the 'SZ_4K | SZ_64K | SZ_1M |
SZ_16M' bitmap.

Looking more closely when a driver selects ARM_32_LPAE_S1 it
calls arm_32_lpae_alloc_pgtable_s1() which does:

	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);

So the 1 line patch looks OKish (maybe drop the SZ_2M to be
conservative), despite putting it in the bitmap 64K would have never
be used in the iommu no matter what the CPU is doing.

Jason
