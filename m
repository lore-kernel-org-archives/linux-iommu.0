Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5448D88E;
	Mon, 28 Sep 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597519; cv=fail; b=aATzLByN1ojdFT/v7rDt1oPWnWTvctHntVXabsO1nR/BqiLP2WzVIkIPugGkvTUKy6eRKaMrlaXCBLaunWw3lx8qnepHmREorOnTLKbp3vz8PU24pmMIP3sUHSnIOQ9auE8MJNH2T9DnTMRfoHqn+orXy2i5g7x3sQdDNwVHD0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597519; c=relaxed/simple;
	bh=U49OkNc1VXCg+pN/sfz4PSBQL6o47NBc8Lowo5idBWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o2ME3kLPcQVzMM/p7Bh08SOIa+ZdunEcICJjPpcZsNS2ZXD0HN5FijX4xS4TBI+O4ZPxCVKLXZK+ORzsf8rOxdI0j4N3oyq7Pt5NB+QhrD9fGlP0WmX7xEfiLimBVzmvnlvA0o/pIq4/NqBZJQZPAqfqhbq8xSD3Sxcwl7lxpkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z++MBDIS; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z++MBDIS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNBc0hRMpqlRrAal2458cJ997uGYdsdARF+zJiJxzjF2MgBfbx6f28lSWwCmgg2uT8hrSV6dRxMNWthT3F5DpJT7mTAhTjnv6ZbPbko8kM1VCQsBL06RTB038/soO+0VYOMfzp4GIZA73cC3x/OgTf0ubibWdCnB3f7XIjwWTPqxX88uTMav1l2DJSW7uTieAXfPowyHKusHS6wmPaICJWV6Kod/0x1ojUXGrsFXD/Hac/FJsqFDdYnNbR6su2Ur3ZdnDxWfMRWQZZEP6irQwQOMLJNZrjvRzks5XtMCQVzuRXYjCUULIhEUUvDqYRACczSCKwthmm+xQgU28Wxl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnu9aS3QUgj7M0WaNyj9uJ5riwIo+gOmhgy91AxROjc=;
 b=scbNMKP7okSf3pB4DUDUnFbgOzT5utgVTgR19htXgBNFSXIStcEhP85OTaJRumP2VAdSYUm32zRyjH8T11AhY5cYJ5CBZ7Ma8KuFy1qVUEhL+AetnlDOskMK1ZKcncRFm2cpGi11XmSsQUbiDpatnTRIfov50JtX3UdK2wmQetgtuf8oJ/M970KmHEGQglxQtjgip2COBYlCUlMI0pclsTdF1x4dNPbuZdL9sndYMIBH0TITbTopgb6r4gGBmTloH7rKvpovorHSwExRMWPhnZMpbwIiJ2a7mXsknxZV7NR6+/kgf0oNKnIDilNJ+vCwVzRFHgBbIquAIb7uDwJpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnu9aS3QUgj7M0WaNyj9uJ5riwIo+gOmhgy91AxROjc=;
 b=Z++MBDISDSOSnHPYAriwFdXYx/YRXIFhyX2ffLUCnMaT36/1Ub6vQujviIWHmf/FbHnMb2ijlU3+NaVI+LE7xb4HJRTxB+jukeLjWMt4BCkgAw1ZfGsdbPkD56bHtW2vfo76V0L/oAftE263va9b7wO6gaDsO2pdP6hYBfhEITyGXj4vF88L9/uQmGSdCthnYp0U3DgC4dhRrEqiLdjru5AgvGe6Nyx9U34y0bOkwXr3gtn7fYrqgUb1keX8dJJ0Xqs30U7f2OxXHEvewLeLyG4nxJPnZc+FGmBI33b4aqQOLDEWi57Ysocxz1LGIW7Q998AFfrxWHlMjTgX2+jiRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB8875.namprd12.prod.outlook.com
 (2603:10b6:a03:543::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:11:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:11:49 +0000
Date: Mon, 28 Sep 2026 09:11:47 -0300
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
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928121147.GP9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org>
 <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5wzpr7b9.fsf@kernel.org>
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf18610-5c88-41ae-58a6-08df1d59ac47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VSRASu69XmQ885M5ue5YihUDDhJ1tE+KsN76jAv4+soa1POajO3Y09HKftcSu+CiwAYkOYM4KwzN2vD3WNlJqmiVXIsmhrLqF46R48/MO9NMAZneXcFQDTllziAxVEGxk7132zQUf3Ff6VbwAyqelA8622mHpXFT+Qa0AbOBebzUNzQy1tnxL850zcZymIL22yWXP/Guh/Ovs+V8OO2P/G7bufERDHzV4X+K1yHpNa77mJQt1QOiN1BKlLMfV4nZfLk9TPtvuEQKDxOVuJbOKRy5eh1tAeAJtLebA8m/JT3kPoizBWpW0Gt8KHu5NZjLAz0CAvTH+iSea81f/+N0I+fiLGLe+C/zkeXwCo9ZpUmr4zswBdO/tsAab0f+Ax0lgPojiqdTawJCwaIhhlmtylnFnQne2mY3pCHtTRMrgB61eQ4L8J6oNiPhPnWKqT2MgDFddjdOarPT+499qoJe1EoYPtvl+IpKED89MoQYyKEli9yB1Iy6grf3PxHyUcGCLs/jCKBcE2b3NZGET0cWLYGij6uoJCo96sOCNd8Z41viUVu+qOCn8quyThdlUOLcD8iIstw0rKf1aE2ylD0yAwElabmun+eidtZ9xyi6eKZFbOAC6EbDVHF4rP+9MZNG0mKy/UnOjCDYgTfdCIrdc+7UvMVNNpvyvfVN8pNU0nY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TVnfAWt4h46R6m8gTOsT3WjkdT6Ye+pS+qiXl8PFrdAZOgSQDGIQQUtKV7hA?=
 =?us-ascii?Q?HPevzPW1pfVGWJNiwmV5QE+JAB9E+IeTTOrpzacJgnXJrcSQfAB+sdmqeLE0?=
 =?us-ascii?Q?ttNhqoKhp7sUHxShY2w4wIGjHTbVO/GmLK5qkhdNZildMtXuf365AnvBA0eZ?=
 =?us-ascii?Q?AKauLuEtmhKaWoszT5f13PG6ciKZCPhMWs28u/BjKbnzZRMyXEhbFH2LEmPX?=
 =?us-ascii?Q?HPLNqf53ghTZSj1AYjxFbKWtwq90Rj3NM/NbVkB1+HVa83ARfhm5gS/Lf0/m?=
 =?us-ascii?Q?cCP5zmAJTdWpQECf/9MQ1JUnlBA+VpscGtEcEb4P6+FNjFZTnOLARTUb5wML?=
 =?us-ascii?Q?hhH7n83IWcp0koOOhRTRcp6742cL/bRRdQyQnqefuLQLvRK7lROVvNap5tEE?=
 =?us-ascii?Q?GyKOSIT0J8wfKTz5zzMZ4GjgFWJ1wpt93w9ufWk6kHjzjOyOwFwrFU2YAhtt?=
 =?us-ascii?Q?z/C7vOvKJNQhMpGYIKoRafkMn5OKjjOdzrwLsdBXZkRUyb2RB2vU4cSkWfj/?=
 =?us-ascii?Q?aeq0vxqOXbh3A6/x69Kn3CVxlrtG2g8MeaxxyvaDyHg/w+ksCRlwitkXFpSI?=
 =?us-ascii?Q?JbiQkGPRnXJxi9O5YoafenusDOJTz0idQ5SuafW5mGz1XurmUgPuzvsmqJW0?=
 =?us-ascii?Q?G/qWmZs7wwwwS8iF3qOgmL7pkukcWlcNESXujhLraQbrpHELa25hTwckc5hX?=
 =?us-ascii?Q?Bo4decvSwJ5JHbXp+w3QJz5a8spegeOe+fKbJyZO5MxsGH0tk49x/o0oD9vI?=
 =?us-ascii?Q?3PJBmvyuoDhTHECgE2gVF14ocwsKZ5TH6PvhtSmv8XSWpp2qDi5xDD5iNP1J?=
 =?us-ascii?Q?E6xTUNy1PBXCeHKu/8rYKxFqfC6g50z53WS0xH6yyRHkie6Ze25fVbOHWXym?=
 =?us-ascii?Q?kEEkDRR/JiL64FKT8Qvguy0PoNO9PF/UdNIhu7nKcCYp8ck7HSJI3byIy6cz?=
 =?us-ascii?Q?dK3mOmfkBducPzRDZwYkIAt1I3VTNT4bEJzNJB6Ik99alBjUWHNQd3GvEmgs?=
 =?us-ascii?Q?tbuzo3ChbKI6AJ043cbmSBE6ibcKjbc+qxZeQWRVd/3Fn+eEdIRC4MijnY5d?=
 =?us-ascii?Q?Gyf3+cXdHB020n2UGWy4g0YfLUOfksnWN7hz4FdpXFfZL2dry/gTO76DYEoZ?=
 =?us-ascii?Q?hwE8YpEvVXz/Kdn0um9e8EF0u82XL1JxhlLrp43I62u7HCn7fSQ0b75H0Ep2?=
 =?us-ascii?Q?75Hl3XSoXEnsafKGU1e1rK8hb8NIU6SKCnxknpJeVjR90fPo06TF3/NF1o2c?=
 =?us-ascii?Q?bPZO4UKTdp84dGugzWjEssia0gOwlKtDFvv14vuzE4De6Qgg2BYxhFyIXQu5?=
 =?us-ascii?Q?UgGv2sZgJpIfNhaOIHGKrj7s4c3g9B6l381YOf269mlJEBPkCF9UxLvK8ckA?=
 =?us-ascii?Q?yxFI1nHy/+wyizHPlEZS/evkAkl+Mjkzqo5WVVW+V54JAvzUSDf6t0kV6ILz?=
 =?us-ascii?Q?VYuQc59qLod0GKxHUvxW1guytFdE3qaZEsEVAm5tCg9Tl5OkSr1RZfsR6AaS?=
 =?us-ascii?Q?ooI4vZq0QGb5sNd+nTpwrur3bCOa9ZbAlyZZF3yYuikTipJ4Yp1546VlX1dP?=
 =?us-ascii?Q?kuO1YCJzA3imwS3svErul8jrwufEXSuvcnM8msQtbXDh4LUYULhuUm5cWyzl?=
 =?us-ascii?Q?7r0f4m/n7H6Onndo4/y+xFaWUO7/mg6EoMrhoHxvIaG90bY0btxTIcQ7KlvT?=
 =?us-ascii?Q?I86wu+oIOWVCE6ymY4C27CWu/K/8uc35UZHZj22nxacCKImG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf18610-5c88-41ae-58a6-08df1d59ac47
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:11:49.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn94TldF30e0Yx9Pr/yM9EdZjkaTJlOhczB8gyh75Ty0LRIYsjhRKGeAVSxiQKq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

On Mon, Sep 28, 2026 at 04:06:42PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Fri, Sep 25, 2026 at 11:18:44AM +0530, Aneesh Kumar K.V wrote:
> >> > The TSM viommu should use a NULL parent domain, it doesn't have an
> >> > iommufd managed S2.
> >> 
> >> How would we assign an untrusted device? I currently follow these steps:
> >
> >> 1. Create an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT.
> >> 2. Allocate a vIOMMU with viommu.hwpt_id set to that hwpt_id.
> >> 3. Allocate a vdevice with alloc_vdev.viommu_id set to that viommu_id.
> >> 4. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id.
> >
> > The vmiommu.hwpt_id should be 0.
> >
> > 1. Create a a HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT
> > 2. VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id to establish the T=0
> >    identity S2, no T=0 vSMMU
> > 3. Create a VIOMMU with no hwpt_id and the RMM's type. This triggers
> >    RMM to create the the T=1 vSMMU inside the realm
> > 4. Allocate a vdevice on the viommu_id. This triggers RMM to create
> >    the VDEV inside the realm
> > 5. Setup guest ACPI tables/etc to point at the RMM's T=1 vsmmu.
> >
> > Now both the T=1 VSUMM and T=0 fixed translation are setup.
> >
> 
> ok so iommufd_viommu_alloc_ioctl() will do this based on type.
> 
> +	if (iommufd_viommu_type_requires_hwpt(cmd->type)) {
> +		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +		if (IS_ERR(hwpt_paging)) {

The core code should not decode type, that's always a hack..

The ideal thing is to order things so we get a viommu_ops before
trying to get the hwpt, then use a flag in the ops

Jason
