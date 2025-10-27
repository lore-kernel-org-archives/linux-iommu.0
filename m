Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF22FABE5
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564093; cv=fail; b=RbTfb6tGE3e8n8072PnRviHTD2jLTxOkfO9BKfQFjVnza2a0A2nzyEDRhQzc+YTWHKHhexs93IF6UqBeBrqYokEKe8TL3EQOjXE5FErIETf96nviiMN7vJ03L5m3iPdiEx0QOKnn0Ow1ux5QYLtoLRsYOfm6gbS1laF4igpHcSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564093; c=relaxed/simple;
	bh=tICJ0laPuZlWTPPjMCMJZK3cEqoVZ3Gx/Z5F8rZs0xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OYJxRVCfNas98PG7UM46y3vkIMpOUATmBRyYyIB2KGES5/uy9FSJdyLb+rq2AzB4PUysgntXVjnjLf2sLhOSvs/Wj2rsGXpEOqexEqiTMrjadnlBawn4oIh4DNogiPmAkTcLEDep+1fgMrrFS/w6n27hPldU0Mfe3gnP1JdPEVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lnUfIaIT; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lnUfIaIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo5KaRNW9otqwuZMiULGyzzPXHrLQA6RfEM/I4D0nLrJ8702IN9WckVCsfPpgSNC0D9hvsyy3Gm25uXt8bPCTN2rUcnfUcjLg3lD4L9JMpMmlMtIJ5umwsxynbZ0L4OnCAM2FJ2llddFf4/YyQKyqVPy9HDeoVd+dyau1e18Skkicvcy6DiA5V1xl7r65EtJQHEYA1WvKZHon/aJaRhWvMJduWmc1FevtXEH91PQVqoSffA4MDtrOMeBkG+EMHNWvjij0jMptTY4qUPJdxMczEOniIAIDOkGoRlQUMxYafQKMp1tmuGO0UfaAr6FUyYeJxt0jaCUpLGimNhpAvmZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFvMc1/6N8FSDHN5pYiCwLaNbx1OiYm2VRqg0jHMbVs=;
 b=ZPX779MxB4qWTi4hj8KQ6+6OZgR1fRo415alzV8epq57YdztAipa90LqTs5xcxHxxLAMF5paPlbDDuO4b86d3V0VXvo1W66J/DLuRcKmwXjHk+nvllQmya0oQmvyABF7OIIab7PqBjk5JjumSh8wu2qkA0yObh4+quxSZ/ogjlDdeLWno/vVjPjUtqgmdGw3MzcX4MOhS89+ViZ9sdujlvV+/n5BEh+3LfrNUGoBlJicFFmHJwQQ+Trm3+IGEd1zHnp+82xPFhmsipcoHP1tuUlKRzI9hw//9i3zDA0fdAtrF3Ur0y15aV1L/ENwyhkD0qRY2LdvkSxpanFW3zanNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvMc1/6N8FSDHN5pYiCwLaNbx1OiYm2VRqg0jHMbVs=;
 b=lnUfIaITX3D+mke95hIogWylFEpHslBhnzaOSmyAyJV1YpUFjqgCr4vWw7XDZ92BuJ7+qcU9m3AdIFhMWBs+kJzn25ttrzxRmrB3THHlHt0o5urpSwac6tTtA91Fl31z9nCLNz3XigrMNb1mCZehfRj6qyID+KNfDdm6hokryBQ=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 11:21:25 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::eb) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Mon,
 27 Oct 2025 11:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 27 Oct 2025 11:21:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Oct
 2025 04:21:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Oct
 2025 06:21:22 -0500
Received: from [10.252.200.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 04:21:20 -0700
Message-ID: <7d28fa51-0c1d-46da-9372-031ddc20874a@amd.com>
Date: Mon, 27 Oct 2025 16:51:19 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix potential out-of-bounds read in
 iommu_mmio_show
To: Songtang Liu <liusongtang@bytedance.com>, <joro@8bytes.org>,
	<will@kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <CAA=HWd3_nKzKguK4JAs3aX7MhyX3mxFPLNLzEqwRPiSPTwvm6Q@mail.gmail.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <CAA=HWd3_nKzKguK4JAs3aX7MhyX3mxFPLNLzEqwRPiSPTwvm6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 50793a00-079c-4392-7721-08de154af6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnk4bXR6NzVBeHRibHlMUG9NT01hcnRydC9LeFpLalk5enZUMWJPYWJvOHpU?=
 =?utf-8?B?MWpIc054VVpiQ2hjYjg0cDhyNHRNRWlhMzZFKzdUN3dIRDlEY05mSDYxQ0pW?=
 =?utf-8?B?TUpveDc4SjNwRG10ZG1xcVBXZnZpakhUWHRTSWdDTU4vWU0waGJzcitFQU5p?=
 =?utf-8?B?eDRjM0I5KytKeTVwakRMUjhTVkJSMTR5SVNiV3c4MzBCME5kZnFWdk00bkdS?=
 =?utf-8?B?QXJXNGpUTFpBU3BOTVNjdnZ2c0h2WklNN0M2MkZqUVpPY0VZTnFybm40QXc2?=
 =?utf-8?B?TE4reWlWMkdNRTQ4S3Q4WGNpcU04THc1Q0ZCTEV4bGg3WXBXcHQyQTNoVlZv?=
 =?utf-8?B?L01qbFRTM1p6S3JXTlZoVWhzVFRZenlhMmN4M3VNWi9FZk16Z2pPN0NxVnVU?=
 =?utf-8?B?d2piS3lFNXpSM0kwOG9hTjBScVZxMmZ5ZGJETFF1Z3hKcGZ2eUlHRGZiVlpy?=
 =?utf-8?B?Qmc5TEZDbVNhYWt5RnBpOXFtT3VzQVF6VFpiTk51Yis2MFlVczJ4MTIvQlIw?=
 =?utf-8?B?Y1BocGs0S01VcGdHRm5tWEZZVnBOM1AyV3U4VWQ5Zy9xamRMSFovei9zZG1P?=
 =?utf-8?B?QUc5M1lvemlVQUZCenpRa0tlVTZGRWQvWWU2MTlDZmljMlRRQ2lxcWUvWTcz?=
 =?utf-8?B?NEJRMjJ6WlI5QjUxQ1NGSnh3R3BjWnlxSHFndzhhLzNHbHhaTm1GZm5HanBh?=
 =?utf-8?B?ZzUvRkF0WExNeFVJT21nendvVW1QZTdMU1IvZTA4OFV2bkJ6UFI4Qm5kcVQw?=
 =?utf-8?B?dDNnWTZtYlNKb1BJaUpYNVBTQ1J0MSt6b3p2MUNIZWNtV01ibTNPemE3VDd6?=
 =?utf-8?B?Vy9ONlpVMnZQajE0WHdzRklIYzdRdkV3dTNza2VBMis3eFNXWjhUeHRsZHVt?=
 =?utf-8?B?cWJ4NGJtOFo3UEoyeEYvSkh4ZHRhclVVRVpPVU05TFZtanA1TGhmWGlkOC85?=
 =?utf-8?B?R3VEOUl1WncvRjJDNDBObngxRTZVTi8xVkh2WERKVHBPOERPWGM3VkRMVUFn?=
 =?utf-8?B?YTVUSFFIY0dGYW5OK0dXYXhoR2xnRGI4YWUvd0wrdXVnaC9HcmVnUG5mbmc4?=
 =?utf-8?B?ZFBWYXNaZ2V2aE1lcWZ2MjNPdE1qTjNvKzVieE9rSXRmb1k1WjF6dzN2SnI5?=
 =?utf-8?B?a2ZQOUEwd0V6WUFNQzlQWVE1SjRucTE2NitEUEF6TFlEWmo0b0tGazc2WkVv?=
 =?utf-8?B?cEZCc2txOXBldlJSblpjZFB4N1hNa3hFVzc0TERtTnkydm0yek9XcTNJeUJQ?=
 =?utf-8?B?WEwxdFVLTWsxNXNKYWNYb0hpQmk5bS9rZnRyNTRaTzFqRTIwK3JQRWlXS1Ri?=
 =?utf-8?B?SkxxemVNM0FLVGtVVWdFUzdLM21LSE81bjJWNVU3ZDNHaEozY3dQZ00wcGxE?=
 =?utf-8?B?N08xellFcWVOYlN4NGQ1L1o0ekI5dnA0YlE4c3M1TGtySGU0YnFTOHBuSnRu?=
 =?utf-8?B?SGhXWEh5QWJUeWNJc1FCalVTYU5TelJ6eU5zdmtVczJwcVhNVlVzU3IyUzVQ?=
 =?utf-8?B?RzZTendZY0xVTkpzTU5kaHlhajU5cERlOFFsNklOcHV2aGU0dThTSVZSeERM?=
 =?utf-8?B?SGlCU1B3KzRTK2V2V3FXaGVnRExCb3E1K2kxR2FBN3RsSEYrMGFTVkFIVU9D?=
 =?utf-8?B?b00zNmN6OVVnSC9ET1FGWEgzWDcwSEJ6b0dRRk54UmdWTW5mSHZqM1hIV3N1?=
 =?utf-8?B?MHBXdXNoeWFBc25sK0lrcTA4OFV6d2c2N0YxUXloTWlmbk53ZmRJc1NCT2Jy?=
 =?utf-8?B?SWJzVFlvcjg5MzFmbUhTQjBwSDRqamthbzRSckhBUWRLTDRkK3ovOWxucTlP?=
 =?utf-8?B?SkM5OC9DYnhnNG9BSWoxY2p0eW16SWNCTllQdy80TU13L0w4YkhwZHdBcEpz?=
 =?utf-8?B?aFZoajNnQXFkdWtCNUxVMWxNaDVDeFRuN3F3czY0MDJ3RjRGUXgwcEN6UUVZ?=
 =?utf-8?B?U25tRkxWK0FUckNocEVJbEZMOWI5T29YM2dEWnI2cGxFcDNYa2J1NysrUzdC?=
 =?utf-8?B?MW5GNE1UV3NzcFE3RFA3azBvYnVqQTJuRWEwR0VCeko2a1NlZzJMZ1h2OFpL?=
 =?utf-8?B?WG9CR0FjTHFQSUhubkN3UTlsaFp6ZElRZXRZY1pCTi8rbGtqZS9lS3VyUk50?=
 =?utf-8?Q?yWjY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:21:24.4211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50793a00-079c-4392-7721-08de154af6cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

Hi,

On 10/24/2025 1:32 PM, Songtang Liu wrote:
> In iommu_mmio_write(), it validates the user-provided offset with the
> check: `iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4`.
> This assumes a 4-byte access. However, the corresponding
> show handler, iommu_mmio_show(), uses readq() to perform an 8-byte
> (64-bit) read.
> 
> If a user provides an offset equal to `mmio_phys_end - 4`, the check
> passes, and will lead to a 4-byte out-of-bounds read.
> 
> Fix this by adjusting the boundary check to use sizeof(u64), which
> corresponds to the size of the readq() operation.
> 
> Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU
> MMIO registers")
> Signed-off-by: Songtang Liu <liusongtang@bytedance.com>
> ---
>   drivers/iommu/amd/debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 8b4d7db7869a4..5d85c47478a57 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp,
> const char __user *ubuf,
>   	if (ret)
>   		return ret;
> 
> -	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
> +	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {

LGTM.

Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Thanks
Dheeraj

>   		iommu->dbg_mmio_offset = -1;
>   		return  -EINVAL;
>   	}


