Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D3054FB
	for <iommu@lists.linux.dev>; Mon, 13 Oct 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352733; cv=fail; b=qTpHEw7kbMWC1zO4Sr6ADP+KIpbP481Ta3pEm1W8fzm6vPKrlNpF5Z2iZ85vGnpa1W4I05KIm0Vq6B0qTIVPrJPVKB09bZaqDp0VNNICF7zygTbFq4JyuxokmBa3sMPan0hWzrok9R+Hwh2cqU4Jj7FOhYY6ZNLvv1hAKrBter0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352733; c=relaxed/simple;
	bh=FyJFSFg20eUEfsC8jhi0v7ap44+doLtPkgP60AaXV6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HuwVud1yGLTwWntZEzVFUkaugC6zOYywfeRMh/eYmgxEa2IfOqrpjnC9JxxaB1SGmTX+L/YT0bOIBtFfjdgMBvwf46kL2jbOIh1C1k3z/SB4hMUkg0V2iuKQGHQUVfTIeR0DlaCfAqaC/HT0uPyehXenrcuOWBSZsnBwtvaSxAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZhFCGAmH; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZhFCGAmH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDsjwQXc3FhsFuDofs7Lp+gkBUfh4JzovSj1PtkMhZSZe1epECbc/W0G6Kh1NGWhetGp+YK6sDVaoa0mAPO4yOSKX2aGcbi1h05sJ2qG904dA0rrVXyFssbCqwSaLttVhXQW7Pvh9YZGVMR4LHi9nk9q1PyesqSUYJnqZ3QiZvQkDAMXu4SWwuNHfXraK4MWxJCnhvq5vvus1+fHulhVi3a5XQKUFJoRex95lcAYMEeW1z9FTBAvi8vy1Opjh6Jl5Jq3rgcu9gs41jd3/8Fow8urtuG0DgbWYPID7i8jWpNTr95ih4m27rgGmjSGKyDC8vZJ9H3l5AD70eQ66tUZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUyQXAFO0HiaQZu7rfQP4k1MH0EgSQEfu48wpwZQNjs=;
 b=If3nV42FzS74ic5m4X01pf3w95Mn9Sz4P7IVKHyTI0Kd6LkN6KIUJKkgR6A13e+327mo7o0JAJO+Y3gIL3Yzm8mYQcme7wVdhED+8nG8hxBoN28UMb7pPY9fmzXXszOVsnxDhmzpdc0Ha1MGawG2tBeVCaGf0Ui04Sqli6v82+ZxnK1Zd5V8Lnikr/NVkmNV7svXjv/lqFFbtSvOdCh3BuM2o2gRa0ITeTTFgshJwh+onMx3QOo1bhY48FssLMTy8vYmwzSGKQt9ogWd6NvxANl7rbjyGqiV6TUErsFnV1qFjRAETyZoZRESK5Y5Mq/fe49SBRM7IMTSoqideQSeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUyQXAFO0HiaQZu7rfQP4k1MH0EgSQEfu48wpwZQNjs=;
 b=ZhFCGAmHfIOo4Xe8RpSLOttH33x3lBxinlhqrlhXsQLhyYfToSYq29sY2c9T9HtuDnxwFPN79pT/usxBHkCG0zfJcwi5DVZPhCMEi/SlLxumkbGF6AfcxcK4USTCeShKYoX2LJMacw+G5OYH1RKWc6/pRQBMKf+p35wlvV4OaQY=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 10:52:05 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::83) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 10:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 10:52:05 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 03:51:55 -0700
Message-ID: <d062e8c8-fe8d-40a8-bbdf-0a8483c23b03@amd.com>
Date: Mon, 13 Oct 2025 16:21:47 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] iommu/amd: Rename DEV_DOMID_MASK to
 DTE_DOMID_MASK
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-2-suravee.suthikulpanit@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251009235755.4497-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 729e06f4-ee66-4001-0d40-08de0a468c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajQzSkhvcDNjYzVFTTVCWWlEYkZya292Ri9lT2h5SmNyUVI5aGVQaXJRVlAz?=
 =?utf-8?B?YnhlODlxQnFiZnowNkluQ2hEZ1cvZ3Y4OFdtWmZrNXJhWmEvUXgzdkllM1Vx?=
 =?utf-8?B?aWZibzhwaUMweGtNUTFRd09vTTBxdzhZMEtTbGFKdmlBN1Uza3BQaVNlZVJI?=
 =?utf-8?B?M3BjaSsveDFuNVQwOTF5Z2FwbHgzOXpNNUkxMkdobzk1KzI4bUlpWDB3QVFY?=
 =?utf-8?B?ZktHU3ZJUE9SODZabTdHSjNGbDQzazY0US9DWERERytzZXF0b1hCYlg0NDEv?=
 =?utf-8?B?L0N6UkZSNXVIZFkwL1d2bHJNT0tVaVN4YnUvT1ZqUy9iMHZjNUI0YW85ZVp2?=
 =?utf-8?B?ekFSMVh2QW1pNm12TVg0RVVHUEwwQ2llUEI0NmhkcE9IRHdEWXp2b1R1dVZw?=
 =?utf-8?B?M0htRkNxRm02UldYRTJnNWFWZ0JKcjhUQ2dWazB1cGpaQ2JGZU5jNTZ2bzUy?=
 =?utf-8?B?MFdyeWhZai9Iem9CU1dseDIwSnVKa1pOOVh3V3FIZ1Y4TnlrR3JrMlRPbzZE?=
 =?utf-8?B?amFobDdhbk9qN0JoeENNOExpRDhvNVFqbERoNlp0alVPWGY5YVRlT1RxU0Nj?=
 =?utf-8?B?SW0reUZBbW5lMTFtcHBVMjBuYXVUZjZMZ1graFlZeStZdWpMTVoyWnNIaSs1?=
 =?utf-8?B?Mm5kQVZIYzZJeGxIV1NWZXJHSlI1MGRkSWlWTGh0b3FFMnNINXdLMVhYcmpu?=
 =?utf-8?B?eDUwd3ROanJQOElpY05CQlVra296T29CdnlLRzlBQXVUYU1wRXFBUFBNVmZL?=
 =?utf-8?B?dUt5UE51UDRhUW85WVRkZ0s0ckpHQTYzckVMc2NPdTl5L0hxemdJaW1yMlhR?=
 =?utf-8?B?bjJpcC9YYjF6N1M5dXNjb1dMQlVTWU41b0piT3BseFJuelkwYmp0ekpCMXdW?=
 =?utf-8?B?NldMcFYzaHN6QURvOW9od0VXQ3dPYVFEWFNUdm1qWldsM2JxdnlEeGg4MENK?=
 =?utf-8?B?dG0ybEdxTTEzVGlCcUlFeTJyd1JyMHRCaHd0Nmh1NXN0bEdFQUxFdmQrQWRq?=
 =?utf-8?B?aFZ4alNDT2RtNlZ5NjFTbTVqMjFRUEVhbnU3aHg2QVJaRXNwQUJYTXIvaVQ5?=
 =?utf-8?B?a0JuanVEUXBHVlZ5bEg0REJkbUVPNnE5eFZta09KbmtmMVVPbDB0eEU3bjVE?=
 =?utf-8?B?emd3QkN1OGR4VjJRUlhuZ1BPTW4raDJER21YNTNBREdWV2xNNG1tYW9jYjlM?=
 =?utf-8?B?UER4cnJvK1hsYm1adGFLUlRhNUdmaGdoVThYZnRIQ0RreHg0WkRIL0F2cWtn?=
 =?utf-8?B?OVh3SUpnN3EzMjFXWjVLbWFPNm50MTRQK0NnRUtoWm5rZGo1NUtGQnRJM0Fv?=
 =?utf-8?B?MGpxQk4wN3RpZExRNjZqNmJMcjh5UkN3eU82MU9wZDRaS2EyeWxWbXZoa25N?=
 =?utf-8?B?YytsSHhYZ3dlU3B2R0F2bmhSS3VPUWhsb2x3MVVIK0J4aVhqRGw0TU9OeHh1?=
 =?utf-8?B?QWpHdzJEZ3FKVCtWbXVpK25SS2VDTytXc05Na2tQQ1FXVFFTYXN0cXYwWDUw?=
 =?utf-8?B?QzJPL0UraGxETlh2ZU1Wd01KUU9oM1ZJR1BPbHh2SjBDTmpDTXRpV3NrZTBI?=
 =?utf-8?B?T0pSb1UrUDFQazU2b0hQbVdHV0xPcUdWRElNRE5DRWhqUFRPeDViQVNOZGdF?=
 =?utf-8?B?NVpkTzQvWkdZalhaVGd4Wi9FOXg4c0pxdExHZ3UyVmQxMndINUlIUEVkZFIr?=
 =?utf-8?B?K1kzdlZSYmNFb3BtZUM1T2lsWlZvWG1uOVpHYkNRTzZMSWhrRi9WMmpXOVhE?=
 =?utf-8?B?U1MwdWhqSlhLQ2dRWm1uQ3pJZ0xpR0paNGV5V1pIMWhqLzZ1N1NscHprOTNX?=
 =?utf-8?B?SzZybUVHTVpGUHNOSHQ3ZXRVcGRwSnFMM1FlYkJLMVJUcWJ1SWlHaHVEVUxL?=
 =?utf-8?B?bzgyWGVsTTVHbUpCbmtmNGpUZkNhZ3A1cHBlQjBnWlQ4bmVXWS93U1JaVmNE?=
 =?utf-8?B?eU1EOXJxMVNTNm5nNTBPRFZObXFMa0FqZlpEWk84eXBIWm5LVkMvTGtweW41?=
 =?utf-8?B?WElyQlpXSTFDN0NSWms5MWRHTGxyOVI5QUZHQWJtSmhJM0hGTjFoWnhpMHdm?=
 =?utf-8?B?cHRPdEFoTmpEV0ZDVXZ0UklMNWRzYzJRV1UvUk5VaytNd2c5eGx3MVdoZEVs?=
 =?utf-8?Q?1GsE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:52:05.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729e06f4-ee66-4001-0d40-08de0a468c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8



On 10/10/2025 5:27 AM, Suravee Suthikulpanit wrote:
> Also change the define to use GENMASK_ULL instead.
> There is no functional change.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h | 2 +-
>   drivers/iommu/amd/iommu.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a698a2e7ce2a..556f1df32d53 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -422,7 +422,7 @@
>   
>   #define DTE_FLAG_IOTLB	BIT_ULL(32)
>   #define DTE_FLAG_MASK	(0x3ffULL << 32)
> -#define DEV_DOMID_MASK	0xffffULL
> +#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
>   
>   #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
>   #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b57a6993179d..a9b17d31a969 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2094,7 +2094,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>   	if (dev_data->ats_enabled)
>   		new.data[1] |= DTE_FLAG_IOTLB;
>   
> -	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
>   	new.data[1] |= domid;
>   
>   	/*
Hi suravee
Please update the replace the usage of DEV_DOMID_MASK in
init.c:__copy_device_table as well

Thanks
Sairaj
