Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC1423E9E;
	Fri, 25 Sep 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339411; cv=fail; b=dV04PtDuivkAz+GwWQ0GcdNnotoMXmHGC861a74uELFFKuUvox5nthdRBFEsdGn/WqalgTh+/kRNIFf94PkFuKgaKcOqeb9fgttT07mAQMRufrfApI/RY8nD718HTeXEVqQ9iU0vXUA+ryC6eq6Z2egzbarXVjNJPkbn9/VoPoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339411; c=relaxed/simple;
	bh=623MDzpiCbg2eka8SVUsm95MK/wxYpozu23nU9kI4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D0/+zDEyfLfxX6Hwju+Npf27ZeqvO4td9BmrvcqlICnRamRXjA/hqs0ijZrmwLkZ1yU0O1b/xrmzCR9R2BPP1SWBb2EwAaUUqFWbw5CW7P2HS82Fov8w2jhpyMyGhb3uvV7qC77juvVYmJRW6ItomVdxFjCymd4fKmajzIuYYn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzcu0q+e; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzcu0q+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQoh0efAJOjN7DnaXByVtfHpfl6OC/fakFt2WBX18+F+JZVyrZV67K4AKoSjx6dMN2dvczSSqSVxHRiuddMdSwkz+W/CEAU5p0IUpNDd+I/FfpfmMeMYdi8CNlQq1xzohBtBqbBgAvI0tFGMZRU2ikDHp2Kp1L69qlfaP+Otr14RK4qLjIO/DPjW9DYx39fUWQNA0+mZd0PnpRLtWkIbxEZU03fW8pzGzBhHI4E6cDE+3bnl+Ss8GFC8vumKWhaCtMc1qpGt/Z5TA7HfB7OHF61PAKPRsxb83usXRcgSHi8G2g36NDPtYLBvjYpLyQLj5e1F5gA56+8PvYAK6qjAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZgtFYsDqpxp12LBngcxzJZdeAwrqMh+Qwrk+FElGIk=;
 b=mmaQ7RDkmSE+Rl8EWJD3ueVGZxyRQYrUDwusy9NIbFWJ7ZpWDu5ZT681ybfjW5ZpcFWhqrLjCfYbM/icWBj6qFAa/WkWvvpWZ0cSvYSY6XUqfv/oUilIf3vkncJeWh2YcdyGdEgv13WNA5ShLAORlH4gj6IV9Pi4ILltMDJK/3OiDiDyVDom+iBJlcwGhhvS1JrNx8C7+BdFJ/VDOE7vmcL83deE7bDhSHW6JHCgOtGyROB9RiwRMm8ySpyQiYYHtrkTU+6uOYSg9xyf/8Lwt9U5BjaWeZKQq+m8R6i7+le54Zv+kv4Fo1LEZDEQgz2QfWc4z0qL7MHE1XzypzUcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZgtFYsDqpxp12LBngcxzJZdeAwrqMh+Qwrk+FElGIk=;
 b=fzcu0q+eH91Z/F9SUcJ+QU6oVHSwIm40HKJ3kysHGfVTD4nakgsdWrpepDvM1Q46Qmj9e4Z9kxG604VtV6VkggYZUysPZwh6bhye4dDdX5z9/NMmw2ZgC4fF+vO/eduNhdMQZAbdx1UK3Pbh/Ds0g/+iENZ+RkCu/T7rfV8+cxYRb8qYa/u6unpcttE7nH+neBiJ+XgMLOgcycamRD+26Xe06wJCE7kARzkkqX0U2yOKoZj4nb4Le5hhQZQ1QEH7VSAbYKsb+GcJzMdpW5MW/f51c+ACqw2nUTPzU+j3+HAtHepPWWYCrAJxGgsHIfFEQ8ob7RwQegEuhW74FLsa7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by SN7PR12MB6932.namprd12.prod.outlook.com
 (2603:10b6:806:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:30:04 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:30:03 +0000
Date: Fri, 25 Sep 2026 09:29:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 06/11] iommu: Add a helper to query vIOMMU
 hardware parameters
Message-ID: <20260925122958.GH9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-7-aneesh.kumar@kernel.org>
 <179027891417.104879.9762824167936334166.b4-review@b4>
 <yq5afqyxkh0h.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5afqyxkh0h.fsf@kernel.org>
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 843f6e93-33d5-4852-6063-08df1b00b92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DY1HDVVXt8gVyJ0Omc5RDday9R+kr52hmB8tOkyUcA3T4jPdtOcs/6oCDszGh5vQ4IXLlyGOaGbept/4SIeknTEI0Eeg/gmXr1ysZ/qomO3zlAnrRALhlc5tN2f4NTBmCJdUSR1kjkowm9gwSGvEPvoy4mpb9uPwXYMGeJwETVyRYgFF4NXIVslkGKmufj40bFX4wbuZ9Di0wRmpaxevwFYU8hcfcuNxibapWqhG1JSzwR4569PSs4FDyi805BlGsYSYRJWfl99Em88GPsM7a/1oHUSv8Yq0HsM/bmtrjBlsZK//+58LurVxh+96bhQUl44CfWmPn9worJHcO6OIpNMVjG0lFIuYsFhRbfjyc5Dg5PZpA6KbSbUPL9wUiu+wDEwkhY+RBvqeUBjEKZ+buRX5RG3rnEjyACb5AdU8YqMPbzH4zjPWI8VvuaM5uO35oX3fqVrxcCDlgGfC82wGwJPF87mZEl/kJflzKq9yFRJg7IR244Hr067vEuRwpKPLf6p1rSQL3Dm2YdMAZsM6Mff+UT6Rke1ZTHdPKeS6motAn0VOJoXbQsNJ7bjI6nengwp674ll/O2zd77YIK+LhKiS36kzK6h+x5FyrSPn6i5ctNjdKnIW9rBHA7WMrHWCsr4kQMt0ZDynYFXoLwnNZHRfduLn9bdb9gZFMpr4/Hs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HlWFIb7ZFfZ2zjeL83/zMWRRt9Big0WLDCCgmd9iMGOaIGA7dKV9nnEoIcm?=
 =?us-ascii?Q?biE674utyOpYaS37pIKL3pq61gkaSPdcynBHI0PSxD/OoICcACjs2w3dEgX6?=
 =?us-ascii?Q?9TyCx0o+T+f7iSZvHfU2Em1rG5U62UF50FCFixLbxq4q5GTd06RjYYitYdiE?=
 =?us-ascii?Q?l+MUKV5/lAKvN5o7m4zhqtNfVoD9WnmnCip9G6/ccjal+4u2dkq22HSswhs6?=
 =?us-ascii?Q?odmLiAgS4McN0rqgTu2ZAUSM75saK1Y/qW3qjiwzTmPkcoVY+87iU0WTbKf9?=
 =?us-ascii?Q?ZJIDsEdTfbWaDqVvczBonD/VZQqxUzP6k9LZhy9mqd53eyqe4jXiblRY3qGL?=
 =?us-ascii?Q?oPrlOFfcTGh32No7OxO3aX9UpqZ+jmf/hiqvzUI96KZSvsQ4LdJO85xQzWuy?=
 =?us-ascii?Q?asBJgEpz7xoPHZTDYqw1/ys0QOXo5nclJjh5ui1eyajtrvJBsH9dd1M4iP7E?=
 =?us-ascii?Q?yGj5uhL4nrjnUA3cauFC6aqZb/XJZ7y4AvgXB2wQBW9xBxrJCzGQXsbAKMSS?=
 =?us-ascii?Q?ouhih+w2QQ7RnPE7FeykTMLmoY1HvIRzfUI94Sou0vOCCjfWO9vTZJbvWb13?=
 =?us-ascii?Q?mmN86h1hT11lAHqTgY5syIOCmNUxV5oTJQeibGJOyGyluxinDqMn6kTSPoy0?=
 =?us-ascii?Q?tfpwsWRrYMgz8HiaOdhmpzZnsySRMkiIbiLiehcfl8ijOq3Wj9NE4BxdxDP9?=
 =?us-ascii?Q?/4xK6YdsyBpsLP5Wa5TcTht5hROD192oKtacjroa0M+OIACVtrsuuOjNY5G1?=
 =?us-ascii?Q?GYFULPKE239XD5Bt+1qKbZJXeDsrkGQg8Ikw+2niTvoEzxktiU0ofJZCnkwS?=
 =?us-ascii?Q?mXpiqbBG43FXoOKrosAV0aKS5K/NHJDih2WCtVCvd7wboPDUKvcTmViqyscA?=
 =?us-ascii?Q?AkRCJ9EuLAIjeOwEBEoaOJGN432pPReZIH0rbeLrCOuPMEiJTRHbBAHH7jfW?=
 =?us-ascii?Q?5KZRwcF/0ebgAKEiC8LysG+V5O6tWM3y96rPZg+C6w0GpLFjxmZgV2rKH2ks?=
 =?us-ascii?Q?RvTfke+HQwS7O57VOX9tWUNW4mhotN/fkVcSUIsDQb7yMnDiWAor61hMEvJW?=
 =?us-ascii?Q?jsKe0oMASta36HVjrJzmmMspu9IN/H00/gMMzzrzPc5GNeqVQb7b3dAb5eS+?=
 =?us-ascii?Q?Alq5O27npk9JloRBeJ7doZ+TyUuVyzDX/8FFoOd34rWlGmdiYRNoztbzhn+d?=
 =?us-ascii?Q?XbYpOl/TQVH0qZOJ3HWaRpOH9SBjv3aON4ABUrEqNt6PbICwb42b2LBGKhTk?=
 =?us-ascii?Q?b8OqHU4W89BHEdJ6jf25W2W1L6n1HLcX/y3O/cdTgpd7ZYC7D5Cl4ZdCYTdZ?=
 =?us-ascii?Q?urVkoXgOWkjZ2BB35AuhMUZubaiYRkHEKtOwwNaJXDUjmtZMuQwgSiqSZvZR?=
 =?us-ascii?Q?lhpJ9ntrM0gYLnNLzw0zMvF8l7PIkIVMOH7sKMCnGYgOF1WtwK/xSXvvt+7E?=
 =?us-ascii?Q?oIkuKZYTbE7laplaZxIquCfqOKF0ZUxaxwanu0YXJjdMud34XiejIBdBcxWm?=
 =?us-ascii?Q?40s893Bkg+X6dp7Is6ewGapHiC9CE0UYWWiDyTkvSy26j2PBfJP1ulmTYxlk?=
 =?us-ascii?Q?EhaflZHoRCu14RPhM0+N5k2WR7dCFb9BC1mBzLCclkpH5b62oXHdOpFdtpPm?=
 =?us-ascii?Q?kyXMPLhEFtTdNgRUpldXPnGw46METp8TTnLNHwnEs1r3ZhdCZz99lPlCJSKz?=
 =?us-ascii?Q?GiViRhqK4MeNDSojkhLBVpC+xjgl9hzsG/uhjj6QXjOPp+Qe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843f6e93-33d5-4852-6063-08df1b00b92c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:30:03.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxXUq0uwlBbp+tWIrTBvOYGmURni+aXbLWvQL6iakTEGcnd3vvL9FgGpF0QweYP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

On Fri, Sep 25, 2026 at 11:29:58AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> >> [ ... 18 lines skipped ... ]
> >> +int iommu_viommu_get_params(struct device *dev,
> >> +		enum iommu_viommu_type type, void *params, size_t params_size)
> >> +{
> >
> > I imagined this would be a direct function call from TSM to iommu
> > driver? Is there a reason to do it this way? I think a TSM -> iommu
> > module dependency is OK
> >
> 
> Do you mean that the TSM backend should call arm_smmu_get_realm_params()
> directly?

Yes

> I was trying to avoid that dependency. TSM depends only on
> iommufd, not on the SMMU driver. 

I'm not sure there is a good reason to. RMM systems will always have a
SMMU.

Also TSM should only depend on iommu_driver if at all possible.

It is another reason to not like this because it pulls in a full
iommufd.ko dependency...

> Making this part of iommu_ops also simplifies supporting different
> get_params implementations for different hardware IOMMUs on the same
> architecture, if needed.

If that happens the TSM needs unique coding for all of them, and then
the direct link might be a bit of overhead.. But given people are not
making new iommus routinely (for good reason!) I would prefer to kick
that can down the road..

Jason
