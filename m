Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27F216A10
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796476; cv=fail; b=HmoWdBMPEIZeDdUxf0Qb+tmCC32104uwlJWqhtL1sCnDXwHoWMoIfrlvDuIsdybE86M/HyGjKFGQrAhiDz8UzlhutFyJ6nb584eZ0Sl0GlsVdZsGpPYCJSsD4zwwwamb1dsTLU0tkTbL/CCOtv6m9f8zn3HT5AQWeJ1WN4CJrDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796476; c=relaxed/simple;
	bh=ZVFJubHih5Z+w9DQ/j4r/XHl1MAi8visyTMRKpW+rMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KolM/afu2Xj/o6jJAvDjLtHLaIYoS7VkFxT/wzIBecF68dZHcPHWdy25YUDDCS65+k0xV9lSbhoGlcfmpopWltiPaWIFRK+0rwldhxoIcnaGiKH0JjJk5qcyfygDRrcY1+4hX5rWUIlTf4nytWS++EiefGf0WfmO5jEcNirSheY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epH8ihK5; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epH8ihK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyZn28Gj1k7ctBKyzRiBP9QWMvvsAe7k4cW99qldDUGzIZb48Two2ETJWVujqDTOHj+z3wZja/uAF/Nxk/Gb86tZ1LoDfbbLgrbMG/kIZqS15NwE1S2Vf3+R0fYHEahMYheccm/IFm68IVUCQULUvpY1vDIJh/r7JrtTajuWoZmn1cEerZNvbYCUbYpR0qOkor0LdgHBkOfwhhDE/EMFgsbEeyjy5+SO0nRHg41mYmKaJQlLrk30/RzBnCNRHS13xjJZwXJuhNH6TBoYab3eikf3APNg4ydVu2ahTWZlXI+/gO3gSybbOUzgvs2qiofPDf5W+wrinQeILZIfNyPbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHVuWvDh1Essp4Wf0spQ7W2hXuhy1uCwUXwxlh3FkmQ=;
 b=saScikZIl7ZB/ijuEPJJGNVXdorn6ihZh/31JkaR+pjUT3BE+ICYpMkruwitonPDLMC/2rgn/p5UrOKsWXFnYQACL0moHX9K2vDVZb82WNW7/TtHGQKO1mC9OOc643MeSlBHjAWfkJOyQbvByFBpsZMb1Io5ibbVGu45bWSwqaIOsGhyw4qYhp0pqNcBrZVgLxYz58aamm/nDbRpXNg+EWSPx1r1/zxOezx9Jg2KHmfnDVCOywCxLbaUuziYZrzUl1aHZqFfT2jfneDszY5k9N+m+luivnGyPwIaf2AR8WF5h5PHZ/3MidQl9zQlcfIfwEshHk0+ab1VbT6RdmX89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHVuWvDh1Essp4Wf0spQ7W2hXuhy1uCwUXwxlh3FkmQ=;
 b=epH8ihK5nJO4KhkErGuITUVeV52Pyj1CuWy6Nyvlrf/qQ9ILM79vGPesdtcJMCcHErlvAJ4PN0QH8QivwU8umrEMLCrfDvq10Tm7dwYQzmYd0fCngYFNuwc34fmz0buqjTmhZSXlWU8v6GJhObPkLzMHaV42hn+xEgKgvhvDJWoo2Wv2Azclrh1pq20fiCLeoFAa8ZmHKjiJpaJxH9MCfmXVFrtHsJMz+hWU9Cvyjz+IUcJ6MaNMlgJVRiJRG7K5sJABnKL1c4w4WAnr+zK2CtrvDs5XN3cafSLTDvdKjBSrfXovQxUbYMOs5q2NWjcp0z6jKg0plB4AEtZAhrar4w==
Received: from BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 19:01:10 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::60) by BLAPR03CA0094.outlook.office365.com
 (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 19:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 19:01:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 12:00:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 12:00:48 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 12:00:48 -0700
Date: Thu, 24 Oct 2024 12:00:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxqZX3BxaM3Uhll3@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <20241024131511.GH30704@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024131511.GH30704@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 2434fc07-00de-4064-4cbc-08dcf45e38e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0I1QWpDR284TVVVdGpLeDVtUGhrcHZsUTdKZWFkYVpBQ3dHY3o2SktudFZZ?=
 =?utf-8?B?elNVZ0JETm5MZ2NTazhLcGk1V29Sa0p2ZTR1eXBoT2lITVFpdUR5VmNhYXFQ?=
 =?utf-8?B?MVN5bUxFdjRaZTlkeW05WVByMVRFWnQ0b2gvTWxZYmdoVUk4OFNzNVlhQlEx?=
 =?utf-8?B?THdDMExJTHlWbjlFYUIwTlNoaC84S2RRd1I5bkhRSC93aEdtYU5Td0VJLzBL?=
 =?utf-8?B?djdsYW01Um1IWFY3eSsxdjg1Z2J6ejlyOUM5ZThqVkxNczhSR2llTW9nN1JX?=
 =?utf-8?B?b3Z4Z3JkWDM3V09yNG42d1BwNG1CRzhNMXlmWjkyc0lQZDM4YUNHeUtLUHlS?=
 =?utf-8?B?WkRvMjg5R3RIZXhLcjdnaGxaUm5JcU5HRmtHR1hXaU1oYzk5alVYSXoxL3VQ?=
 =?utf-8?B?amlIOFlhUGhWWXNQNTlTOTZUQUNxVVJhdGZOVjZRQjczaHJ3aFJUbTVQVlIr?=
 =?utf-8?B?YmFCVzhrcU1LVzFxT25lc0RacFo4cUNuZnpzOXhKQU51Umo2RFdzcFdQQmtN?=
 =?utf-8?B?dFQrRERJMVJxcVNIc3IwWmtJNlJVaTdZSzd4T2ZQbGZuK3dBQmJKd0xXMDQ5?=
 =?utf-8?B?Y1I5WXhBcUsrV3pHMjJNT3M4RzRSdDhxUlZlK1JHYlNmaEkvR0gxWUZRWGQ0?=
 =?utf-8?B?U1YxVGk4UnBVQjZ4S2VIWDZWRTJZQXk5WjJLZ2t1ZGUwbXZVMnM2SnpxS1Fz?=
 =?utf-8?B?ZHZIa3pCY29hYUl5am5RdFRBRjRtRy9uVkppZG9wTzFCWTZmbk5kY0tRanUy?=
 =?utf-8?B?bStGelBLR0lYY05SQjlPQmRDb3ZRWEh2WFVLVERpSVV1Z1BibWM2Mkg0Y29i?=
 =?utf-8?B?c2xMQTFtaHBabS9aNjVCVVJDUkhtZVZrOWQxcmtBbVJVVnZQK2VDdld1dHJz?=
 =?utf-8?B?S3FTY1lkTldUUGJ5aCtGUjJJR3ZMUWhJdTd3dnpqSzFxSDM2cnllanZndEFO?=
 =?utf-8?B?emhwMVp3UnphMzBCUmVWQ2d6OGdKVjlUSmloTUhUR2Q4ZEtrUFBTckZnUDdQ?=
 =?utf-8?B?ekJKb0k4R1ZRblM2enhmUFJnbC83clR6d0NJVEFXYW5EQklmc29GRmE4Wk9Y?=
 =?utf-8?B?Z2NkcEJrWFlBVzJxcjNCbDhBSU44RHU2TjNrTlNtbmRMSSt4T1BJQXpjT0cx?=
 =?utf-8?B?dndFc25KNkU0ck1kSTZJbXRmUE9YOVRZeHlwUUpmVG5sZ2RyN1ZKNVlaVUZh?=
 =?utf-8?B?a2tnSm52RWtzWGpRNTE4RDBMaUMxWlVMMG9sUzFzMnNQVy9oUklYdUlTelhK?=
 =?utf-8?B?b2NEOU9vMUtOLzVPMmZvMTVSSXUwVXdtcCsxNjQ4TlpmYVUxeXBpRVYvL0lv?=
 =?utf-8?B?TGV3dVAwMm51Q2FqU3NHUll1STdsOTlnQjFYNXlkZlEzSGlOUjJKZTJFTnFG?=
 =?utf-8?B?SmM3cUZ1Q21wTENwWWFBV1lGZyt1L1dlVzQ4NkF1Mm84cHF5amltRWRPZmZp?=
 =?utf-8?B?dFJ3bG5kSHR5MmtXSCtCQ0R0d1NrMTJwQWIyZi9PcDRqM05zS01GZmg3Z29E?=
 =?utf-8?B?TVFXSTdqRHZoUWJSVUdZeUJQbm1WcllhRTVGMytKcGhySmRpdEQvT3o1SUc5?=
 =?utf-8?B?VmQrQnQ2UkEwS3lUTnlZaTFQYTI1bUN0V3EwbDFNRVdDYlJsNVpralc4QThI?=
 =?utf-8?B?Y3RMUmhIcDV5eVVoVlIrcnNBVUFPY0tyUXhyeCs5S0VYaXFGMkNKZmorQU9n?=
 =?utf-8?B?TWFSNWNIbnNUUTQyMXZPSC9CZGVtWXVDTzR0bWppSStULzZCQjA5RVJxOGN6?=
 =?utf-8?B?UDd1bjJKOFhsN0V2WFpCQXd4ak9SS1gwSGRBRlVJNnU2Q1IrVGE4UWJxK2Yw?=
 =?utf-8?B?cU1kVEp6ckp4U3JVZzRwOGVkUVJmeHNxTFJ0Sy82bWR0bE9HcEdYYURSb1lo?=
 =?utf-8?B?eFN0RTJZQjlSRXkzWjltbWhTZWtnbHd1Y1h3TUpqNDhTNWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:01:09.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2434fc07-00de-4064-4cbc-08dcf45e38e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294

On Thu, Oct 24, 2024 at 02:15:12PM +0100, Will Deacon wrote:
> > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > +{
> > +     struct arm_smmu_device *smmu = evt->smmu;
> > +     char title[100] = {0};
> > +     char mastr[100] = {0};
> > +     char addrs[100] = {0};
> > +     char flags[100] = {0};
> > +     char other[50] = {0};
> 
> I haven't followed previous versions of this series in detail, but
> allocating 450 bytes on the stack for this seems excessive to me.

If "450B" raises a red flag, should we do something about these?

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_atc_inv_master.isra’:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2065:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_sync_cd’:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1218:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘__arm_smmu_tlb_inv_range’:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2213:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_atc_inv_domain’:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2118:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Seems that struct arm_smmu_cmdq_batch is too big. Any suggestion?

Thanks
Nicolin
