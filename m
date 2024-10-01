Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363F1C4622
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789716; cv=fail; b=VP/9H3YEC4Vbi9pOyLJB0y/EnaTh9Jjb5CN6wsRgeUoxuR4+61NH0D77XLFuAUmJaDx+rU+4H2ZjUfuLHS9QgQHb9zQ9Qo7nEMuGxjKov0QBBr4cTAe2nNj2qF1XLTiR5xRwVZRGfe/sATTBYCl3MAbR/FUh4OMKBenL/2OqNbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789716; c=relaxed/simple;
	bh=X3v92UFgtfarbAN8o6mDgNNZoP0Jb+4sD/G8hwkgT1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UiPQ0eErARKihiE3d+M5YWmKpWzV9qE+59Zh7oFF2nCy6+YwYIpM/e/wc6fKdqiPexERXKXMIU70kcjQiDmAGAbt1y4xSxoeaJ1lxqwzQLuUHUqJPjD1horRPX9LzjUKGxJa3FQzxFKjKt+ych2YdPKrEwZtLU8rfCtFTA3yUzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qw0ju771; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qw0ju771"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzYfkeeJd68DBYW+Njxzv48UQKn9YXE8wcqDIOS4XnfGhE/i4Jukjcp4xFCHOZn8nMMdj+Uk2fNM7W/UpedzJWiJeAVxP5rm+ftDdPkVEMPf98+sQS2f96qVUw7w/K/fA/o+TxaR+ecgBiwFIPHcYRfaUR+3qlDNe9zXI954Wu2r3qDQ1tAhm8k8QgEAcc6d6mSKRr5gWjZSHJ4zXDRIOjBkIJhaL8v97rPfIelK4si56UC+SnX6hnPgEbMoCZ3IoVbiqapdC0SyQtLlctMw3b+bq/EWiOmO9BuRUyIDLEbBY8a34F3GSX8JaBPEaosoWstk2LUyoJG64BZMvICqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxl0VaalGsB5Q2G6rVyv+PUjc6cXkHeIxD1QWdxMLgw=;
 b=MVZJw4I0plIKneIeq6j4Y3zFpJ8aBIFkeITjKRj0dk90EcugtOUapBn+8hUJxECdLYJFcqLsHHQO8QU8odTaNDlE2D7MBe9CH4wGSKVuDWF5skHCGkUcH+RJfJ96p+4twJraBxY5gY/uGb8Kkf+Uty4qIe80XaU3ZkeSBHDkovRYWdGWgIbd7T8DbIXlz7nK/FKa9YerZDdXWOWPN1wWyPhsYdOwmUAABmFVNMQXP8WPrJi8Cm9ZHj8Ywj5wkEczXhdmBfvPpsoLjUu3vSsz0jJUyqxYxZ4ogbD/IEJpGZKv8H2IfL66B1SD+5q16t/Kz8GCWX1shLS6S++vg6bYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxl0VaalGsB5Q2G6rVyv+PUjc6cXkHeIxD1QWdxMLgw=;
 b=qw0ju771DgzfkKkF+Oiz+W9y/G/2j9z/KUSlB56ggNVlmYt0k9UF+OkTjgXQRX0kN+r7BNG5d/NtGSXQskksHAchp0sp47R0PsoK3hDKHYz4BXeY0pEMFBMlPL8TT5S/pm2Y4+sj8H12e0/V1F2u0eIe6fPiNoYllGLBlvhtVbemDuYKUEgsisUY8PC6kOXb+e6+B5OFH02fg5GIiV+5bBUpkj+IAtTTM1aZKxYaOhlECTLTx0aKFauuwOP7nXsZrK9YWtLC9/l0HvjrkCeiPAjENPbz2OCThBX88Ru+STN2ceDAVMLvIcagJPptiboo3RxHkc81Qg1Ec4u8ahlOlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 13:35:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:35:12 +0000
Date: Tue, 1 Oct 2024 10:35:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20241001133510.GD1365916@nvidia.com>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZvrUfoTM6s/jv9Nv@p14s>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvrUfoTM6s/jv9Nv@p14s>
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b64de8-75a5-4d8a-2023-08dce21ddfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p56zfOEIk3HHaNgZdJgX1q0DCN0OQh6ySTXpRRnWsdZciK2kvK7zanUcimHH?=
 =?us-ascii?Q?18UO3t1ndexoaCasn4Qhu+M/eOfhe+AIsBkccRsBZ8xnzCUwHbeqE+dFMcEy?=
 =?us-ascii?Q?wSxVqNjTX4YeKnSUqwL0szuq6KeHUSfHuhiP3vFswQr9jSDMuZYnGmFMWA8p?=
 =?us-ascii?Q?nePKo2auJkQaHtnLvUqCWK24j+AU9WScww1K4w9VBY31gSaAEniEC4Dp76VL?=
 =?us-ascii?Q?24MrSSn2KlZ7/O/fUSpkbcbBgoXIDcRVAcc4YYlmUrvMrs3K4Z6Zc2l7WiAf?=
 =?us-ascii?Q?ctcPh3Usg1A6AtXOYoXStKrXfKG6gVnib32YdRRQOFov8oJaH/SjP85Cttha?=
 =?us-ascii?Q?vD5xr8Hs23/cZDzptHrXR4iIUCfAHEav1fl06w1MoQiQjy88b8nvtog3OVrI?=
 =?us-ascii?Q?WuN7avI6feQT+F5tSvtfduaBtqZcoGg6XzAF94hOz2X8sODTH3ogQW0zSg4m?=
 =?us-ascii?Q?+McEPRMwgc6bGDCPtVHRehxUwvVnkFbe32YHGTR3x6JJ/PK1oBoxcVL9k/rd?=
 =?us-ascii?Q?oxHranslouT515CO4n6cLMme2V9ts/w96qlbKTq+R2af0/ZqLruNGRceCiVl?=
 =?us-ascii?Q?tjzakyQcGz831kwi+5hcA2POIZpcu0LGRuRsVrq9mXZ5A7z3lx6ZA54Vx14V?=
 =?us-ascii?Q?M2TlwcDalmyHzOISBC1TZSx+lpAT+9nWM9AUAnx65oeKrlvc90OtZoUIis10?=
 =?us-ascii?Q?A1C2UGTu7sJKBthFe+DajdyRHN98hH4oeUP70B/As6VehJMBXgG9Vqs71gZ4?=
 =?us-ascii?Q?YuWqCfcL3ykNVwSdd+gRlWshGHVsntU7pb3r02IFeOWfp9NHzXgnTx74MYS1?=
 =?us-ascii?Q?K+4CaNdjD05A+aUUtUrT+jQO7ndGkBBgTTa2XGlc0URZOaYREcJeBDTxt/6v?=
 =?us-ascii?Q?MK+aaU/SN8cQwvSzZObRu2+3rACZkre6balMiAWYVroGqzpGqbJmRQoi3rZh?=
 =?us-ascii?Q?60euv95wx+ppU4jBXZK6mIkZB6DX08xbbODU+5KC6la7p0Sas5wx9P1qpoNK?=
 =?us-ascii?Q?R20cdpSRsxVWIC9DHkH6ZNt8olc9/53Bj0/LTClPyU6c9n33SDBn5ZB8q/Zo?=
 =?us-ascii?Q?TO9v/i1QPPdXCAiLhSUnTGV0Z3rfk+KxoOJS7q5wfluFajANVi+buPjlZ9gj?=
 =?us-ascii?Q?AoY2xQkSnNbZfhDB9f2brMUyf/w8mhMRffMIu1nFZshY0r4a/Cz6Fne8gzV1?=
 =?us-ascii?Q?c1oX3oL7ww6euW7BACs/StrX2uDtKMcX1Nii7ErYbPRgD5O3E/VAzan0vKMY?=
 =?us-ascii?Q?e4Wi+Fn+6J7Es1whzBiNVlE2edhLspv9tgvSTwtJXkrcpMkBRhOAevrab7eY?=
 =?us-ascii?Q?LpmYc7Uj5reW9XDgbCD0rG29wXerkzwfvtcgZ7fm838TW0dz6+IBA5uxu1DW?=
 =?us-ascii?Q?2foPGJk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaCNJFXAvhRQazO9qeYXkw6bNDNFF9OJn+x0UW5qHCHjvD2Qz3lYWvVovG3s?=
 =?us-ascii?Q?9IXvLDKODvGQrK1Ainio/jHSfwut5qsEKfJu2uLP0VK+daztT8zKsKQCeMf/?=
 =?us-ascii?Q?LUoa0Ck4TXCITW0tDskUOSAVwnUgMH+uTxGeb59TerHsPXcRrNd23o81KkEA?=
 =?us-ascii?Q?Cqxeh4KTeibcvNJfcO2jBSG7IF+dZaK/aYvXJ/RPCKxhGUm/UWjRxGsJIW0r?=
 =?us-ascii?Q?+0QVWuV16nW6+rIiOjM0sZJng5tdlzgz0t91r3o773kaH9DGJ3AfXdLmVmjP?=
 =?us-ascii?Q?sVJgCMFDypVxY/rdH/sxXl6/U96mDIZUX3jUqkwq6oQNYejyhJf/SbYX/lci?=
 =?us-ascii?Q?njeI0Zn1RIAIUPyMyEhlcAivRMDu9BCESzbhz4qTd0ToXKrZ4casrIR9nJgp?=
 =?us-ascii?Q?SNHi90XPHQJnhrSdsNIYEetHsICwnldDwls8Y1yQwz6Y6gXCeK8xBOewtoZ+?=
 =?us-ascii?Q?N5EGLjhClu54MmdPuPJpgmyxMahlyC+YyfsA0lwQfJx0/XkkUSFmhX7KEHgp?=
 =?us-ascii?Q?+H6zkTKv3b5TEbhPLDjzYKITrhZKUCrSazy2/i5xiKOBNR8pWf1kTfbv6OKO?=
 =?us-ascii?Q?gI9k1ZMFvZ+qzToKI5bPfhdZPGoRt6qCbtp+vYBGpRqDbrY6HELJVIOiOaUn?=
 =?us-ascii?Q?1KWDPgTZLC5a7sik/vaW63Ak8EwmVZRwFWRRgiLh3YSPgU+VEI++nP0zX1pY?=
 =?us-ascii?Q?Yf+kuKn/z7MtRim1LGx/XYsqUitbSgSMmpoo+E8aIDOsbNyaRqMqlK628s+g?=
 =?us-ascii?Q?PrJvE22nNywzGf7cJW+OC9ZJBFwKHT+bnFofPh4L5/nDSF7pjcHoCzCUQ5UB?=
 =?us-ascii?Q?iQyOKPgrZhDDHHrIpF1S5IrNPukQRNWXLh76lUhiFT1idRQyFJXQqeiiazYN?=
 =?us-ascii?Q?h0efu0QNIhsM/wVZYeaT8M8T04aPqRidUHJbCztc3Q9Yb/nIQE43JSdt3d4D?=
 =?us-ascii?Q?deBf9dHnr9lL4lZ8wTE3YKcJOB29W2ZMhBFHw5Bwxw39AoLLDXMe6k6SDq9w?=
 =?us-ascii?Q?t7+kjbiwUxT0xaQebijwRtlDVQxZogr7PCmdVqcXHBVq4vroyZVPgNlqHTb5?=
 =?us-ascii?Q?dEv+MHLRfClIn8LNTEU2w9soAw2BEnyFTiriyGzAPxYN55mr99IHEMPQQ2sw?=
 =?us-ascii?Q?zBzVbmCKSSPVMIv/3Eksr90F+R7/88OxzHgPwNAn1o8ofNkOPqjYb9+TCvYk?=
 =?us-ascii?Q?fmIrMVB1yx4TYliM/3lzBxm5vqVZ7JInl9qraXta4EkOlsV9fqk1hA8or/27?=
 =?us-ascii?Q?HAflFn5fdopjz+rKQ/KSwlS9upemOdUIKEf5tdsOOxcWW5evCQnH+Ot1/tOz?=
 =?us-ascii?Q?91F4eS0hw7mqgpRkm+/5ztGvdE3Npu4mXotbGy4bZguIT+YRf8bwKh01eDxp?=
 =?us-ascii?Q?Lxdm5rGYuQ8EiqO9HbIcm6VQ0eEn9KYeRlfROrhrESPSx8UtAeelSEEaTtxR?=
 =?us-ascii?Q?VKgkyYJw/bEnPKiB7pkBra5/GbX9C7H/6yOmW3Jl0B9MXI1iimz7D+hTC8qh?=
 =?us-ascii?Q?hWtCIAMnW8Ve0AyQpJvWXvpt/WsSdEBsk61x8sSwjrL5PcssyKMPU1CIq8ne?=
 =?us-ascii?Q?hsc15z2Ic87SKIc1Nns=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b64de8-75a5-4d8a-2023-08dce21ddfed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:35:11.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY3Dn3gWQWMp6qkjH77lUA0QZeWpTlOu3gG3M103zp5/8L++GjGt75kKWn7L7vcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

On Mon, Sep 30, 2024 at 10:40:30AM -0600, Mathieu Poirier wrote:
> On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> > An iommu domain is allocated in rproc_enable_iommu() and is attached to
> > rproc->dev.parent in the same function.
> > 
> > Use iommu_paging_domain_alloc() to make it explicit.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> 
> I have applied this patch.

It is a bit late now. Can we run the stragglers through the iommu
tree? We want to put dependent patches on top of this.

Jason
