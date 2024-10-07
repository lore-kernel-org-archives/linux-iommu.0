Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408901D4159
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310013; cv=fail; b=E0L9F1Oj6qGKGND105kP7gNIudHMrABI11WJcYlt6KA99WJvkBUjPV6q4g4vrR4dsbBhHpQlmeY7QV0Tqu4vf/H6sEPh4Vr6Uiw3wk2/PcIj3oUd2izaOJ2Bl8gJTwlWSw8GsLqkJ0Uc97VaQt112S/KWvlS28ASuttSlWvyeZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310013; c=relaxed/simple;
	bh=BFgywF5ioSawPGR0MBiawJsPVzJ5c824zg5H/fs7mMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C9rkBspTd1YF0M60HANfAvtCKHl1tq4I3ua9QhTLTAVE3Z2r6QPUFD6CYD7DZdJMUDj+3AtU16o0sHd3CohbdTQcbFSDeK2U9LoQx6wvcwFCElDfFJ1pz+CC8QclnFgSQ2tyaeSSCZVevSmGDxaDVgVa6ge/EIpihhn8j2gkmdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARgvV7Rs; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARgvV7Rs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5azJbztk3EIAvJdHTEiSprJr0k1165nkHNZhm55PtUij687FyDIxh/mJwGNMfofEqHC/Qfx2psEHbwHYXkb5+mBjqVTMgfHtrHs6L+FwAKVquS+wQ9D96TqEjqVUZdPgE7uGP/thv45hjayMI7Me+3fX5jYCmXFsrcGkaWlfjw5cVcywsCz5bDj66msKohJXsNbyiIcYUwwoIrSqqruz5HfRBX7EicmmAzIXgF1V5CNKX8PiRo89z3IhNBfHBsy3al6qdmd18Ni4aAoXPEul/oMmKmrwEokIYht0Y2EHRuZ5vRuz+fNcYaZCPOkTCydFe3JHJrV0UZuHDeI7jz73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGpGDVeANLjo2n4ypCptKhewR7bet7JJfAXrB/bC+6M=;
 b=FLqpqbfUeONJvZuN7KrvzhhOwwFUeHEdHB4HV8GNLsJ/bqgDuXMIuEifhJOBJRVETMs+ej4s3VWkuheD1BfKKNNP5Umn2Mu+POCSx6EV8Hf/H+BWilLYwfZkSEZZQrxd1km6haSKjeDg3gAr2sWltZ2szFk2m4/STD0eBtRsNJpRSTXFGOFD++gAGCDGlYf8lf8iScItxIXbWADQXNwmxm2HT6CZmfVM9PljJ2iYd8gjS1tN0fBXaDOBcfyI/aHff9ATE4VX5YrG/o4NeD22qr7CiZlPJNfO3VsD4sT6IE594XUmfnzv+52Z3M6rUVJhPU6JJPZq06zOfeRElJ9CXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGpGDVeANLjo2n4ypCptKhewR7bet7JJfAXrB/bC+6M=;
 b=ARgvV7RsZMddK+DScQlHSts6KetZd655QA9V+LuA77DuuxgwLGapnPT0Ry6ap64Ot6TvRFnnqN0/2gGxHxil3yHE568E58vZgUFOaU4nsQfcO56OKZF9gka9g6cohHIbxAeSRUAao0NjMnfG2pXvsQ3LWSsgnRY9o8QQXe1xJwZLVRn7fUdYJe4uSxF4rSLiKBfX4Jf/Y5V8bZ8WjpCa6JXGjJYe9Q5+3x+T3ItLApcquXI0Qa9ftb9bbAUwYEA2sNL61/AN+QVA9g2NzZlbUNru0KrUGNPGtkr2Q2JufIdU3faoeuS39SYzmcNKVvP5a786Mzk9p17BUIJD4lAx+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 14:06:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:06:43 +0000
Date: Mon, 7 Oct 2024 11:06:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20241007140642.GP1365916@nvidia.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: f1777e40-daf0-4d27-99b3-08dce6d9459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7UAIoR99p9hnXIi5/BA5RhO0qG6/6xj6NphjEyPCmYAgUR9+2bYhqX9pKzm?=
 =?us-ascii?Q?qMjUM1q8Pu/uxKV1sS1qUcmsVTY3KKK9FJQgiBNxK64q0L28HgcLtq5/AmcY?=
 =?us-ascii?Q?CzV7w7q7acrVagPvKOlikKhZwm4ljVqXp0QcheJgyElVMMsX2MJ00PiaVMRc?=
 =?us-ascii?Q?Jtr8ScNAoVTUttbz3dOhZIH2QaB7hudoD17FfxSEpkRfoflDdxjAM9K2Qn0A?=
 =?us-ascii?Q?0r/d/oWDRPJsYEZgSbtVacBV2MAiDB/lAg4rY1wJiWgN1Gcjj4yiN/Rm+qRo?=
 =?us-ascii?Q?mcKJJikEd293tMXQE8BvBFqI8uuQit5smaFTmZZWKUwLkinPqF8DKiptPk1e?=
 =?us-ascii?Q?6Dh7fFjsvNOWmiAwwp8jYpSn0UCazlifXaFxcwK43Bwz0pEIBxw2WWVStNeb?=
 =?us-ascii?Q?j/yFFefenXuxW4iBe70GOb4uGdo0LkfkjsZhhEVFIxpM90eAHVynWpOrxmqb?=
 =?us-ascii?Q?JTA6qdVcdym0jqYqUHq6sSsR+Gd6ICF6NRz3BPuoAO0gyxoMHTCtviy1f8pc?=
 =?us-ascii?Q?VOUo5/TH2IMMV74+y69zmdSAn3gNIptdMo/z3gy1bnzhCOGSX6YjPa0Lu+sN?=
 =?us-ascii?Q?IHEF0jIm0hymCJXfz8wXKKetvcqbgwTAf/ARb+zf8azugx+it7YiuW6251fz?=
 =?us-ascii?Q?Mkte+8cB/Nv5n2WIuo7KhoB3/vhKjUJO30/AWtFg2LdtUGYafouMBq6jFFVN?=
 =?us-ascii?Q?TqnZ9VFWMlevRsFbZ1+XPjhoJyUrRxZg/tWFvlfzZY4uDk3pW6rs+9v06UBm?=
 =?us-ascii?Q?/9DfwLj7YAwgA9ObXcdQyuuQI5ndZJOgVbu7nTPTaJerQjg3lt/AVzFnj42q?=
 =?us-ascii?Q?jXDAGUGBSBigw2ThBe8zNwb3lTf3JYSgrN8HLbLhwmYmcuESgMjdVdUucSUL?=
 =?us-ascii?Q?WJxgEkFOIDsAbjY3Cze3MmjlhVLxJFrC5M+RwCcUOZaDVyt4ao8/dpAPl/Hm?=
 =?us-ascii?Q?eQaAI3wzpCAF/1HKaAQd2ZFiIJkMc83irfhd0/YcxlY7ruGTDkWCuc+xNP1D?=
 =?us-ascii?Q?ocL1cs0Nm5pNeJuSJTS94Rt6G9SSYVuAiZkft98KsM/+GiRAURj31WDUd3c3?=
 =?us-ascii?Q?NZw3kD17H/D6H2dQVAzdLHLvIkjB65BEgsaaImXEQH/fHiX3jnIUPSRrgrjK?=
 =?us-ascii?Q?ujchWSICM3nYAViqhVyNL5R2FW1nUeljtDBmD9yiUFgGAPWgIfhHjZQ+2zbb?=
 =?us-ascii?Q?Wox0Ra6oi6mpxhjyfwyRWaoUvKIoQYEqWEqjPwMhFUyDlfU78CD0ZOaFPKL8?=
 =?us-ascii?Q?7oU/+HCC0201MHtqjatj0yNQUl5Rti7igfWKzRljEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0vabw2mMzT6o0zBCh/ahnhGwaJDxIRIueD8WnhkBk5BzGexLNr4xSKflkHY2?=
 =?us-ascii?Q?L0AvcsQFpk5dAECdIeuONu0Lg2xARtGU0TJrGQfNwlr/ehr8ILa60WPr47jm?=
 =?us-ascii?Q?A+QVlpfMNSF7ou5myNQbvl1dqlIvpthAukJzuFUbdI8jT2gcCxyvgIv3IkSm?=
 =?us-ascii?Q?o4z8O3G/R8wBx4Wl/xpK57GmkUZcTcmstUy+89MOzyXzDX7QDz9JBWO3/+tO?=
 =?us-ascii?Q?Yyu17eKZI7SdShFlS40CRx/nYKMXrnHsNJ31TJbm8wUu0+zCJDNdVTW0KhVy?=
 =?us-ascii?Q?Uy5bWKNvc9yfVz+MvAKDaTZyCzA/ZrmUkwv9ymbs30m4qnSswxk+Pu41UqB8?=
 =?us-ascii?Q?vZG7DwGYfF/8d9poAwMNeS4TcaIpEIS99GnHHbUkQeVhT+2GZUBXt+azJs9I?=
 =?us-ascii?Q?0LaWKsH7b1MVCKl9umwsQZi452BR+gUs0z4VIDD81E+/mhQfZQ007w9LjUfX?=
 =?us-ascii?Q?CKo4q+xkMAV3QFjVCuJvN7obpjqBZ9abkyZjwDj8PIK33r6IAXprwgmA/UtA?=
 =?us-ascii?Q?bCXROMl2Z/H/oVDapNbfCRrCouJzkODTawn/9kJDDzV0BHAdb5j6jeGlcGYV?=
 =?us-ascii?Q?vZjhKtQKhE+AmFznUksFnHDX8iei/Em7LMpJ9Fn9hcrvhdlijKFUb0XR92tm?=
 =?us-ascii?Q?gyL6K9TF6RsfsZGeTbPy00K760TIm4fnHqS39HSS30ReLhYBEgDz7pPYWITa?=
 =?us-ascii?Q?t+fBN8fPHUZiZFn2qr6u8ahVej5fqdMd9fMh2mmdm9nybjFag+st5z0Z4rN5?=
 =?us-ascii?Q?teYMoDe3vYblm06vj/eJRmxBoDSSlaScb4Dd2HjX41Fs8wQ8cWx3I/3HkvZW?=
 =?us-ascii?Q?bpQdVmIUA8HfCtDFO0aHOOtjy6CBqEXHH1DWOHczOQPzoGoXCJImUd5/WRVL?=
 =?us-ascii?Q?gtedykmwTdb3HXVG1liPBmFk4/EwvYprK/eQRkZ1xX+Ie0zQU1Y+4FIdCsr5?=
 =?us-ascii?Q?cMFznMAa38et/vHnHQ8Ih899HDh7xfKMeMwwAHCdkEHWtZkEOAhZVGJkFZ7u?=
 =?us-ascii?Q?JdDU83EG9Dtm39pQ2Jd7otyVGigjIW5RdMVU3DgSW0vCj9Zb042y6TpTD8nj?=
 =?us-ascii?Q?+NrCvQBRHep8jh4nWoHRkKXmrMUKNsnE/BwUBn+Ex726cF5/BLkGhPquyrJ+?=
 =?us-ascii?Q?cHkT/rYN38D3c9EPZi5v3OobvvExOl1hOp/F86gDVUD61zTfRHOo3G4vf5n/?=
 =?us-ascii?Q?pLtXwjs6k2WfTnumrDWAU8KTovA+BzDE96BUY3dhLgH/9lwsU/pP30cELUS7?=
 =?us-ascii?Q?3Sj2JeB+4cqa+w1Pawmp9ww5QXSdzkkACos7vwdadfiHEFiNpXDTwMfSvT74?=
 =?us-ascii?Q?KU3rSa1hxA7S4Hre4R1Ge9e5P4bGQ4NPSXs6QgwlqBZMHpV2hd+YdzGUbqxY?=
 =?us-ascii?Q?1kgqNRlfxL6N2d5VR9Y4C9feeBQztwNTCkSruM7TDPv6zg2uc2sW+1Oi58IK?=
 =?us-ascii?Q?q6uFOBS2uzZTA0yNQG/WPEpYMTjYF1HDWS25t/eZqn8kLWlFORH7JmUMKrbT?=
 =?us-ascii?Q?ZlW2UrMDJi0X2rrIid4d5079ed+lsY/TH5rNqJwijhvgf/F6shhWisizlqoT?=
 =?us-ascii?Q?TWDomM+2iIxFxariUBg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1777e40-daf0-4d27-99b3-08dce6d9459d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:06:43.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rkw9vCpvBB115oEStBIR9DDUqZLzXbNwFewcA0awzvMKNI+gKtneFke7+uj9r+Lb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

On Mon, Oct 07, 2024 at 04:13:49AM +0000, Suravee Suthikulpanit wrote:
> +static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	do {
> +		old.data128[1] = ptr->data128[1];
> +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
> +		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);

Why preserve the reserved bits? Shouldn't they be reserved by forced
to 0? Should have a comment explaining this

> +static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
> +{

You might consider re-ordering to avoid the function forward
declaration.

Looks fine otherwise

Jason
