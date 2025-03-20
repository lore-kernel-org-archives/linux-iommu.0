Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9442AD20
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493868; cv=fail; b=k8W8ph1oYVg4iiwTPEvTaxG73U6A9xtVimxm8kg4xoWo2aP2HeuGTl+4QstdjglV00IoFGnpWXdwwPNX1Fs6GoLWfSQB6nkQb5q+QZ4FIlB1aoN65acfK6U0jhrtV79JWOdmmyKNrInFAoU5OK5xeavW36Ci9gYCoR0erN4oAb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493868; c=relaxed/simple;
	bh=drAlcl20Bbrgt56Suxx3qO3rPRJ44nnCkkYehohih3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+djdwJPbZ/IMnaxR8d9mztu7rZTesNj9Q7zojWsVWeNw67gP5zKgx/BZqW/sR8DMN6UcTJElQHv8x1ubhEhMak0S7BUQ18/qsIHJUkU5WrFNnOus8me0nP4VCHhgkznKoZI1sY73VBvXFFQd/gjWXQLX1LydpA89R/v2T7HKrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPPufTbt; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPPufTbt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8WEohLgqiaA7rQyCOkBvrv+CqJbBRtY/qd1lYHCz8DCUx7N86q1h2yD5DUsdbRU2qIIE/0tYlnBamPLJ4VE3ZJGKGiM/5zZ0Q7xOE1kE84peiHe4Kdmvdq0kDdtM8/PO9+qQyuHP5+2EzbE6tBsCGET3GeoD8MdYESdydhEbm445WbgGChDXBXVX5I1ACuSVtnOTH7rymFvbBLQoJ5TnOZiJO7zgnPvwhht5/BgXZeUz7afcbAcgtFil6Ky4fY2+YW/ntPYifKdQ71WVOlr0JkxaubL15Dd+9Uco0A9rXb6eVusc3uRmAec8q3Dm+Xr2MauKlToRKaP4dJXu7xJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vuetac81AN/Enu6xMiKGrPrO7yy8+lt9V7NKFwjP2zI=;
 b=SMOl6Y2sH4Qpbyeh94yJS10ll6X8bRKpY/saZ7Pvd99w+ZL0DGpaG+b1IwH370saO8hKw4hg1sa7pu5x0d7t7AyMVeG/2UmZdsJbcz1FAOOV9K+QvaOs3WjTRBEDDZ1aVr8UIHUrq9zfGX9vKTDQmyZYgWycxQ1MQbE1HAFqWmQCZpts/o2K/mDUvBNRA+xK9BUeFC9ZFLg1f/ZHw3kW6QW8i4SWejqGIIx7Ooxi9V0AEXNJaAFeHwcIqHMPCqvVU/p/9FP3F8QIfebPuv6WrjlxARlm8llm2pyhwHSq85F1YjYKh2EKpeb9On1DeogUQf91RzuXebf621x6G6e9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vuetac81AN/Enu6xMiKGrPrO7yy8+lt9V7NKFwjP2zI=;
 b=jPPufTbtDuOs+XodeT3qD7vZY4HMamgHVTnPhePaLBrLLMWQgJBLFEFxIqyIaz8UGZJ6oCuiDUKpZgNE0HxBP8M5Rhi+SN7dU4r+eKMOmTGcfIKXTKqYK3VWJFSyNkh9dJVWrWceGo9OlYa+VJ6Aj1kKtOr9NAqHtlhFNZ9SxGdx5Sgg1FJlZQMkWZDDObEiM5QzOSAO6q/ERLGioupPh/FjwcpnwQ+q85GCAXtxIiEEuWLQXXk96b3TpIHRx2rPKZz2c86XoeF2ncNntG2ZcgMbWqmEqJ1vBF+yjv049gBUjC1K2S3X3n15nQhEeeqVUJ4rZjfei+/qYA/yeLHuGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 18:04:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 18:04:21 +0000
Date: Thu, 20 Mar 2025 15:04:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
Message-ID: <20250320180420.GE206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
 <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e209dd-aefd-4e29-ad11-08dd67d9a3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vAWV2lX3owtZN0GXGT+TcwTLZx5RC1TQvkONktLCFovzeRSe2+HQUhYbJqF0?=
 =?us-ascii?Q?b4WaVlZjh1Vfwf99Dx7sgHhv+VDEcMmrEzcEuQ1zpGo6qKWyakmC0h15lpG0?=
 =?us-ascii?Q?XY4TBfxODg1gfxQobGnilOh+SbuRfRpZhWkaQOYrOecP+Xg0O4hA6Q8wwiSb?=
 =?us-ascii?Q?SZLff9QuTprIhx9XpohP0UddDjDZIpF82y2VCw33RWtrOkJl3PFlMPsbp7/6?=
 =?us-ascii?Q?GtVzjEwiZFetscCr3krpm8m58ao8ZDlBHXGjV9hAxU/3xRY1tSeMRL2Xz76W?=
 =?us-ascii?Q?PRDvTMJ2Aj1tesv7a6qNWEQZ/t0hY5Rh6UL3b1K5SPZ3hci+qd2gI3kioFRG?=
 =?us-ascii?Q?P2429fGsyyyD0mOa//FLwZHLk2v8ddROi3Cmtjd+gn/IMst1kcs+M3uwxDTE?=
 =?us-ascii?Q?nXtIZ9S/HAVNcLXwnfJF2Z311mM4tJx1FAFBlZp0icNeraNyLDgg5Go93OlH?=
 =?us-ascii?Q?MJz8QrUIJCwN6QjGTYKSHmgaagsAUHx2TOuogmm3DbUSfbglLDwOCK/FQPqi?=
 =?us-ascii?Q?vVZv8IBFojzNKUgsuN+J8TQxJgcAI4cnd+GMFrUdaKgtayraD5UHmcGVXfe2?=
 =?us-ascii?Q?gplnTknI6MmdGgemyM/6piCcJO68WGXRMbjhUgizoEbvUIJxZb4oQoTAYo6S?=
 =?us-ascii?Q?Q3bvIA3naEblBMYGpHyDtiU7E4LTBf9ABQwbmL4GxpUeidr4gQ7uhf3N6eBG?=
 =?us-ascii?Q?bVQmBOrBYymBuFxdwxNchA8cs7ascDqDLgTJNfBh28D3z6IOlgl/bbhx3xEO?=
 =?us-ascii?Q?y6ZBUYBrZYa8iUFlURDbn6t5ABGJcy9YmUtf1PEs/wkWI9GEEQPQfJIELVVk?=
 =?us-ascii?Q?KYtR/Ns7RxcsHXvzk3Emm7clrUUCGPeyQtFqyvjC2yBth/1DA4gbZolE8205?=
 =?us-ascii?Q?N4R9dCB7XGwKP/lV2Kd1K7IAiKbQ2UkFiLsyQqiH42DjI6iDNicE+sdGvROp?=
 =?us-ascii?Q?q38lMDtbKuKjKu3o3OS/vkXNFK+eyQ+EjckU8EnS30knh/Ko7dLVTuBKKIc6?=
 =?us-ascii?Q?oBoiBxwulVvXoD8sQrbUsEELhk3JgQkRPr3xAzjAEHBMeWzjnPJ2cavvM3U5?=
 =?us-ascii?Q?7vCchjtAHiu1sFDpzXGoCoqy/emrbQC4lXV0IsNKgppurFHXG6VF8JcZnMN7?=
 =?us-ascii?Q?01DlTiwrmL31JNWQB3lzaDeGJdBf8pybCm7MALa+ghqZ7lMpeGWAJ2SzE6+k?=
 =?us-ascii?Q?LgrN29/fBQPHheyQ8KQp3t+HHXbtv8xE0HCW2P/WCwf33SLrzEXS+Ls9bz0b?=
 =?us-ascii?Q?3gsB+gCkAauzItwwgUL/ZTYU6jwLFPxdaug/P2f2aVg5F/gLQVwAmUZfJqGU?=
 =?us-ascii?Q?Dy7b0dKLcJGZmGCfqtcH9KMZnReu5DmQXQWXP7+m5cHSlmyV+f7MspD88y5G?=
 =?us-ascii?Q?l2L4PifiQox3Op4w7l33XX5aM57t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPorgm720VTgPN/aECmW/ZkX/dxOtdl/HmN+laDseMuW3Hw0k/OIjxJcH2jR?=
 =?us-ascii?Q?V8EnkDSwyfSjPQ1AFET+Ms3wp00RmMq57+Q3hnM9Io8axlIw4vtrLNBDRJHI?=
 =?us-ascii?Q?mX/UPZkywiiUdy36uc0gTqHWsjv7SO03BcHUnBN5C5dnBHZ3tGNU+zRDCju8?=
 =?us-ascii?Q?S8zXPdzk3jDy2/WmKEmTI7iIFJVu0sNDHVkyOsHOr0deQAtg7OqlL5swgmMY?=
 =?us-ascii?Q?27X1OL55MJCNseUDh/gBzMd6yq+54fGlIH4cyuFYo5EbpKjsoxIJIcfWtaA4?=
 =?us-ascii?Q?fgzC5r/3ABU26q7JYQDn6O0Q2B0hCfVTkaiYLwR6KTWmiwvtFSco9kf2LJLk?=
 =?us-ascii?Q?2LYNAlwFo/kTlRYq6y9LcXIsmxD/G+BY2qhQ2lrtSRj614O11YR/7F4hlJDc?=
 =?us-ascii?Q?r3NP+oYfmZpB+IeFiGoXL2cHVuHs3UsAEliFJMU41tpUZ+QHPsvE0YyDbeax?=
 =?us-ascii?Q?JUI+rz1gr/P/VCIFKNVaqxNC1+00WeA+QnwZ+kpBxvbKH9X9H+VE29008p0N?=
 =?us-ascii?Q?QeDAd4DZXJCFp94K3sso+q/rRMPPMKxXe2H0zaSw0zfd1F0x00vO1Qzo2Uti?=
 =?us-ascii?Q?2Y0YUBuB1a/4Gs9NPelgMzXUbwAJ3XBvUrwU0DCPDIIWgaB/y0JIxNB424wz?=
 =?us-ascii?Q?8cbleAZffJIvXmge40DJMlaF/rQQXsQtc65dTverCCv6Iuyaxs3O5NnMGSby?=
 =?us-ascii?Q?IXJGNvatTjhH+OcDEJzOjT4nJ7z0fzBmalLZWrDWpjbaDKAF477zBuCvBt5p?=
 =?us-ascii?Q?luYPS4dHgcQVN8k5+KWOpBkmQWPvWZj/zfEcGgtC706t77DrBL7Kf4n3PqDn?=
 =?us-ascii?Q?oZOCSW3pubeU0GBfo/x2mngxv6vW9bpyuGiBF83spea31KMnBVlgzIy6hgMi?=
 =?us-ascii?Q?ul3AQ97Dl3UG+AGB3rM5lEbHf2hmVPITghZ9ZsooI8jLTjaFDDhESFppg3Sf?=
 =?us-ascii?Q?vaTKCczPB36GUzaZj7lCwTwe9Q6IEDaqw812WB58K/2W/Ahq7mNiCYXgg+qL?=
 =?us-ascii?Q?KVtBQn4w4jkavLHzLsnt0jMNLkGNEdCwzEtPFPNijYzJ2JU4woUh+l6PlhLR?=
 =?us-ascii?Q?WEexqpJcqd0b7xLan1Ubim40ghji6Zl1/N9nm0WmRgVZDiAzVWNDzTdBid2a?=
 =?us-ascii?Q?OUv7Czs65qoeyBYtQlUJEX9Uq6F65E7HzBBa40zPz/sRY5x8jdax7kIyZzRK?=
 =?us-ascii?Q?jhUrJ6dsozu9xi6TamSLzyk4PdLJ+48KTFQ3S1w8IazXukvwIvrG5pXt7piQ?=
 =?us-ascii?Q?phZPIq9XAxjNYKXAqrAbtq+eMKjUtON232eyB4W1EFKXz8KpK2H77xFmD7gj?=
 =?us-ascii?Q?jJElIzfcITAdfvqjaI8ZyCsgxyTRUqAQ057RFqneViMbKJIItf70KKZ+9N1g?=
 =?us-ascii?Q?/x8Zz4gObkkHFR7cLu5VoEFsXTzgvScyzAIMoE6lVFaUdmuLJUu7GDhLOOgH?=
 =?us-ascii?Q?t/N0Ty00tuwHEzX3jMEtP57tGBM1SxAQHKmR6dqFZOPhKIba6/ny6Y3bjtBE?=
 =?us-ascii?Q?q9h29BcMOBvxVWtqXszSbdwYTI/JDhSlsSTiy7ckzHSUWW79OEYOOJXQN0UM?=
 =?us-ascii?Q?TmJ1I+UFSueBlij9dL8b7VFFHcomwZ09Q31YHzmZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e209dd-aefd-4e29-ad11-08dd67d9a3db
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:04:21.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXTeF+Cz6CnozHYtmvjOQO1qeLRFw/+SIozZHh0guqedSALdG2EywOU89+bvNQ9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809

On Thu, Mar 20, 2025 at 10:36:59AM -0700, Nicolin Chen wrote:
> We have the same list_empty in the iommufd_hw_pagetable_detach()
> and iommufd_group_release() too?

The one in iommufd_group_release() is checking that all devices have
been cleaned up before the device and
is replaced by:

	WARN_ON(!xa_empty(&igroup->pasid_attach));

And the one in iommufd_hw_pagetable_detach().. it can't use
igroup_first_attach() because it hasn't erased the xarray yet.

Jason
