Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BE226863
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608037; cv=fail; b=pvqttNL6kZ+Zi6EumJBO0NdcDhHaaWeGIkIkwrdZnNUiqOyTRwXFEeerM/hnq4g2604yoSwrnhohn9vQm26D6J5n5Q7a8HQpfldiTajVVYIzY9ea2zE2yL1DTHl7+bd7uLcI9h7p5m0JgERnmxidQaaGo9lZhCyqLTXsvQvWs1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608037; c=relaxed/simple;
	bh=azSo5I9Zgf+QDri2ncnpPBEttMmAvzfahVzOS4oN1kU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwnM/u1QnLNIb+l5//zkesDW/seqgRvnY9LL3jaM0npA3l4eCXCnk5vp0XssAlp/8EzM5S5jmcSJVg62fPqFU7oF8psmgQUS4gCTPpmSXuTcShbIDWIQzzCbwcMBQrbwNmpkTNhqgxvsxlGPw0LPKvXp/YzPMcj4ZOPaoHi5RsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qfr4mDK6; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfr4mDK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUUei3yobjc/xpAAqlkO9a39gqk4fqVvVrfyzizeiwaA/BvMpevgbrVr0iD93qH77AO4qvBFo7ID3G6+VLpwABZVmneZZwRaZ9AwldNAX1dmBZMDXrQ6F+/LujH4/cIQEGogPGEx36Gg37Ru2NlTwL0VTrX/4rfRe6BIL5O5Uv25xdahD3lbwAHSYPkQg77+NhaitYFyBoeI9sb1jw3pQQc+haMmlq0uQM+nczanJn6x2BGe+bgjAfQEXwGjs45hw+FxpGAIbxE16bNavuHc+JRFFgv+/aruHmNeCMkkX3z9bLNnYJ9yZjyDVSBsvfEyrDW1rM/Hz37Kos6XI5D2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htdzSunTZHsz+6cUaZeibcQ0KfTB2m9rPr2kfxyMn9M=;
 b=S43gEt6Z1piHfOrpUJBFvfDJ5dbybymkO/qsyqg4n+RW8/RVPbvTF4wJgm8fkxhUvLgiWdQO8JZesPaXpzNgin8QfvhfkAjI88wQzekNpRBscNsF0n7sNGp8n13caFX5E5N6R/6ilZ+VM9gyeJUrEuWB7CYcU/57vIAsyF4VT+9c4yrSzb/4YdapMa1FzhQNo7MZwNRMDxvIaOi0M2ki49JzpeEvfX6y0UY9v6SoMAVQNcsmboxVSBUJ/rcIUPU/3ogcqGsK6R6DNvh5DBtcVUTLjdzYisUvmb93aT2HvWgq0bS7XAkAxA7QwOdMot1gP13lvwb+TRaaXxAxVbeDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htdzSunTZHsz+6cUaZeibcQ0KfTB2m9rPr2kfxyMn9M=;
 b=qfr4mDK6xdOZoQvMIZxJ9CBIoNvJKcXEO2yh61e5FjaA/2xvLVi9bpG0OHVAZRUYnv21Td6AkTfAqCVXcw2QAhJ4nzsicPYPaNQkc70dGNYmd6Y9EI/wpn4wzA8luljmmH7/04/B4hdbXatqEuRKOUGLFA0em4WXU3XDwVvpzVD6o6aC8Ur83E0tpS6fCjpu9j4OtaH8VeXGiuLWM9IyTGO/2yIArx9CdxSMCDbl3+iifr6B1TiFmeJJtHWN8r5DfQ57BBnGX7dCFnxAy8+t13Rk4eI+AW/Nc3c3My0frVJIf59IrWcpaLrMJROecg/HtFJC05fJVJ4YXUjyj/E0Qw==
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 19:33:50 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::6) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 19:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:33:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 12:33:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 12:33:28 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 12:33:27 -0700
Date: Tue, 15 Jul 2025 12:33:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v5 0/8] iommufd: Destroy vdevice on device unbind
Message-ID: <aHatBn28RmpGzGOB@Asurada-Nvidia>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 91271209-6906-4719-6c27-08ddc3d68612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJb5hMSJ1yFKwvyYg/lbEuw2WUWRMwOUAMZKIeHJxuS1nrHq8Lvwg8q5lyTj?=
 =?us-ascii?Q?FQK8WERwr1GhGW6MsPSA8uBQG6GTlIdcvVgPHoI/SWEnVs0AVZUqoECpcFFG?=
 =?us-ascii?Q?c2LAUItrdYq6kBTH+lRQls3g37m40yg0ThgvyV3gdo7DYoqrED8kWVY36iQH?=
 =?us-ascii?Q?GarK6Z1L+ono/iWQsy8SG508C9w9QkS4he1FyBxeqWmOHdcdmiOuV/L6hF3R?=
 =?us-ascii?Q?NV8MrzqVhbpkBLKH9fZlZCKNxs49ClKqLyKrWppXV+Ay8JR8FKV4gt8/QYr2?=
 =?us-ascii?Q?J0Mh9uQkB2S5jN6fe2gQbmbl8eBtGgKi1sd4TxggpCoJvkKESiUIaeMYKQce?=
 =?us-ascii?Q?5t52kCdth5oQHLtkPC6Xqh5Qa8xWuI5SlUaRHbLlV8mf2o9zVmYh800tQGa3?=
 =?us-ascii?Q?uaJAa8y0gWhFpYRQgANC+M/Gq7w+K85iO+SNW5kU99/qBeTl5ZnxhnZAqHE1?=
 =?us-ascii?Q?SsAoxKuNYoIAVlwBNg4WgO+srQv2gf5yXlAHA6cYYqtkirpbXIPixYjXIIYe?=
 =?us-ascii?Q?rWEC51ZRvN3C0w/Bml9sGzL+cjsQFPzsjlnU125FXs9QCynNz0i5/5aZplp3?=
 =?us-ascii?Q?BexwMLmZbLTCsvMAxKc0o7cesgke1CvpnZnq233m2mOI9QQQh0P/vLaLzgtN?=
 =?us-ascii?Q?WDxAN6iL2QkmNn8I1s3sqcl2eYiZwbaeHzskO5WSXFG4FCf7575DFVtApDyB?=
 =?us-ascii?Q?RVcJuD72CXxgBZ/tqoP7MIQPjB289EP4n0xjS7whc/Mc+iaa1myrAjmfi49R?=
 =?us-ascii?Q?ecThK7hzDwzi8V/iKEyBxNxtuCngdfRZkETLQDsTMnt2YqC0415rl5KjOksY?=
 =?us-ascii?Q?MaKQUuGpqTBLB0wElwhnHv3HQMzwS4e8Ix3Kiz1XMgD1qK9kw9O76I1bvSgM?=
 =?us-ascii?Q?UsB/P5BbsZZuZ/XuZjJ61bAjlaMRG/hu6FUBtSUvDny9wvBZIyhx0TgL7bw/?=
 =?us-ascii?Q?jywzSmP6RJrZm4bIGF7Yn21uMEoD1TtwXDzUvs5u0Gt/b8kDKBpGbrLhjYqd?=
 =?us-ascii?Q?oBKrChDzjZw0Y1xvly3H4lyUgjuuQav2h91gXuHsBG5HVy1uvepyety5J5mS?=
 =?us-ascii?Q?KJRRyaW8NBRDdNg0r/OLIIwcXxmSd9MmMIBYAwpfDnyuld8oCM1bUOAHmVLR?=
 =?us-ascii?Q?6PqSvlIAQwS2NOG3UT86tovCV5kJH2RoZVdLX50OLDomTeKlc1We1GEHOSnc?=
 =?us-ascii?Q?8veXpxPAIgZ7RTiOqfRAhOuaqlPSlma1W+rxV2aZ0k+dSbevn2Mfl7oBDaxX?=
 =?us-ascii?Q?zA7UqC17xwp9Y05jJuOM+OlSA5lG7egTlvy28DHXw79qk+9zeWOVySssdxmC?=
 =?us-ascii?Q?MZJcLUgRiHvzc1fZysN6nJae930niHABSn66os76AKWMKu9ZFjXimGBKG4Sq?=
 =?us-ascii?Q?/kCYgIRV9UKH3y6IT/Q3WnCQhEpTFaRqdPKOabhh1m1Or/WNshw5DlWqID80?=
 =?us-ascii?Q?rQtlpaielRU/S85WfuRzTdNOfTaIWMJXaVHLIHKhpYcP0dbLJn0Uk18cWVHo?=
 =?us-ascii?Q?3HKMIHyXXVClniPp7zVDXarEF5+nFrNzkn5B?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:33:49.4405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91271209-6906-4719-6c27-08ddc3d68612
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

On Tue, Jul 15, 2025 at 02:32:37PM +0800, Xu Yilun wrote:
> It is to solve the lifecycle issue that vdevice may outlive idevice. It
> is a prerequisite for TIO, to ensure extra secure configurations (e.g.
> TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
> so that VFIO could still work on the physical device without surprise.
> 
> Changelog:
> v5:
>  - Further rebase to iommufd for-next 601b1d0d9395
>  - Keep the xa_empty() check in iommufd_fops_release(), update comments
>  - Move the *idev next to *viommu for struct iommufd_vdevice
>  - Update the description about IOMMUFD_CMD_VDEVICE_ALLOC for lifecycle
>  - Remove Baolu's tag for patch 4 because of big changes since v3
>  - Add changelog about idev->destroying
>  - Adjust line wrappings for tools/testing/selftests/iommu/iommufd.c
>  - Clarify that no testing for tombstoned ID repurposing.
>  - Add review tags.

With the patch that I attached in my reply to PATCH-5, sanity works
fine per iommufd's selftest and by testing tegra241-cmdqv in a VM.

So, upon fixing the build break in PATCH-5 (maybe for a v6),

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
