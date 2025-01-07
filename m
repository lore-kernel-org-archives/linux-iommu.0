Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6918CBFC
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257019; cv=fail; b=q5ETL7/+m6+Barssr0SlOgn7umH7y5D9tnSvhoSENkxq+aZaxIqcEPF3ei361V0Mo2yKTVpdNOdIDHNhP6YbPS2s+d3C3KGH7hmOkH7eExfVb0y+aCLNnd/wSth5CDkKnCcBIiCAHES9+heIR7olf892I1R1OTQTEG77LNywa0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257019; c=relaxed/simple;
	bh=sRJoMPXknSEnR8zQYaXrnrJDrpnaMEEdAXdAGkiz+NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lgpt/rKFkPqfiJNFhTZM2s1MX3CaLqVGtqSvXucmKDkeHXxWgVdImWUSeAN7Gd8Ch3aSgWtAmTh6iHN4WJtUlKb7KTW4n5N9DsL1Lb2JINHb0GJwwg4Kh7DisyEQya8IV182is6XKTrcXO8mWscgdKoRY5ONG4TfZ17QTiM1zFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRQVFCfg; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRQVFCfg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAZviv6JOO6ZG7zZf1FtYp6S5QFEa4o6QbTkfW3PNWpXkjF8MbHDgbQUd2w639Dn8jMJhBVlaIzJLzwbyz4vT4dWpm/AtMX1+xYnSaMPnpvZoC+zRLBVoAr2vbg1tKr69zn8qCr1e79Tv+PX4bJxxje7lIuj6p7OTCJi+3Icy8LX0tpSZdhbUAoOvT0GW0/0RGy2okpRTW6wGvhfHfwlJgBxmr1Drko7Da9BJ7z+l6YLFz6GI69i52ToPdD8YrXtiuo1tNjYTS9Wvpkgyr0aflmujgmN4AAfAegJf6UvgGeEQud2IX0fV4LSosc03/BihRoK2O5raGVNolf+SfjiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qwIfJOeiUQOinO1e6cMwtUJWjJlfwEG+dPgv2W+X2A=;
 b=aTAkHvXNKWvm7tiAj1HjadjG2xGr+9YkA+UlABFUzeITYajBKYvTTXSZxgj8CKNXjl2eqCF/lZD8BqSN97tIYQFKeEEPS6f+ZiDlA2QgJawPxt5RqQJFtvibQfePO71XJKzRCZg2gvoPNU8Kw8GIzbNjMnMhgJn16tfhvSjEHiWYWxEgBHPeDMGLj319YXm+Z0Dp/B74N5DpuYaFScsvTo2G09vUTY1B9UmUDOiOisCGHqTvh/00jjtPH+YQylBIGmgvLGg54s8pELYFxf5Ii9CAR+3nl3aZKhi4qUHa7YdJgTTM9rJ5/3vDD/rc9nAEmWD3T+FKDPZ3LOti6N6IoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qwIfJOeiUQOinO1e6cMwtUJWjJlfwEG+dPgv2W+X2A=;
 b=aRQVFCfgV+EfZ68HDGyUcyFgkzNk6NBYDoG7DBx0Zrd6l1Vskf85w4CCZ3DIJDXj/UsLRB/QQFFbBZ7TUGbhE7ieaoYyjkV6MWaQPUsIcp2nXkcdWMHgOXXt4/feJdVcyap/IdHgZd00yoBqVrRD+zqc10PYK6ALuBui5v7vMuE=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 13:36:48 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::b4) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Tue,
 7 Jan 2025 13:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 13:36:48 +0000
Received: from [10.252.205.46] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 07:36:44 -0600
Message-ID: <04eb9e26-27c9-4443-b87b-9b44e8447c52@amd.com>
Date: Tue, 7 Jan 2025 19:06:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
To: Vasant Hegde <vasant.hegde@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<jgg@nvidia.com>, <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
 <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: c64f3cce-e0cc-40b9-9e75-08dd2f205605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWp1NTkvVW5WNlc3MG5GWjBha1ZwcjhzUldtRW1RRDJkNk5zc3JERk9ubi8w?=
 =?utf-8?B?UzdYYjVJV2l4WElQQ3hLTWtwN1RvcCtvcDEvWTgycnVqeVRyQXJ2UGlYMXJF?=
 =?utf-8?B?L0JzbHJBM3Btb1l4azU1UFFSVytCejZIRkJEM0xTeDc4MkNQUmVsMzhTS3BQ?=
 =?utf-8?B?UzRaYnJVS1ZFYW81TzNmbHBmMHZMeTJvTDNxMUl3dnExenRNN0tvdVhHamsy?=
 =?utf-8?B?MFcrdUtiVktWT3pBQ2dEN2tBQzA1YjZpY3JXQTIvUUsyNUlwOEl4cVVoY0J0?=
 =?utf-8?B?UE02RmcxZkRxNnJBNGR4N2trS0VTaDNZTjRLQnpzeUdUZzU2dHdlYXBKT0R0?=
 =?utf-8?B?bm1JRmI4MVB2NW5COGVTUXN5N21obTZDNVo1SWcwNzJuaUJGNjdpS2F0SDlt?=
 =?utf-8?B?dnNsb1Y2QmhuRFkyQ3NPRDhYV3dla2hsQ3FqZDJzQlIyc3EvZWM0cDNVUkxL?=
 =?utf-8?B?dndmVC9sK1EwVjVRU3VIbDBKdkZxNkNERzltS0gxMGhuZU5ha1g1VzllYmVx?=
 =?utf-8?B?dDgrYTduZG43YXpQNVg4eFN6ODF6M1o0R1NZa2lFbmRYN0J6MWpVQWZMajRW?=
 =?utf-8?B?SDRsZ0JKWXd2REJ6dVFaZXV0RE1rYlVqYTUvMU1aTjRUZlVmL2R2V0pqY2pV?=
 =?utf-8?B?ZVo3SjFVazh5TmxnM29MemZFd3FMcHFrYkpFUXBCN25HYlZac243L3BHdHBp?=
 =?utf-8?B?TnZINUhVbTMrMGdOb1RPVVJqOXl6YlYzSi9zaGtIa0pjdENQRXhHMUo5RHJ6?=
 =?utf-8?B?b2tDNTBEdE4zcmphbTlZYlhaWlRSK3lKRURxSzB1c0F5aVNmVk5UaHdJSGpr?=
 =?utf-8?B?N2Yxb3FYT1l1QWpoZ1VvcWZkSHRreFRKdVg4UzhjWTRyVG9ubnJkQnlmeG9J?=
 =?utf-8?B?NHZsSUF3OU1QRzkxYnBqTVRPcTVIUlFnUEtoNGF3MDAxNE9SbWxFd0VXbTBa?=
 =?utf-8?B?bnJaWWVFdk1OUXZ5cWdVd2phV2VKNTVxenpKYjBDbElXTXdRSzJWQ1c2dmJB?=
 =?utf-8?B?ZTJVcVJmRVVkWS8wQVF6aVo5MkIwVnhHS1pUemErWk1VZHk3Z1o3ZlNXd0kx?=
 =?utf-8?B?NFBLaytlOUplUytEbXJvcVFTN25CUWNFZ2taOUxqdDNTSThaNGhLSnpHeG0v?=
 =?utf-8?B?YnZKeHcwNWhhV1RXQjRxaHhiaUdPMlpUVHVKQnJDSFpDTUV0M3VOczdYMjA4?=
 =?utf-8?B?Y2lwM2FZRFpjUkcxeWc3VW1EeXJlM1hKTFZDajV2czVUWjBhc0dsWFFXWDhv?=
 =?utf-8?B?RkdaSTVOTWFJSnQ4L1p6cnVjZXkyNTBZUk5rRmJHclU2NHgyeFBjNUhOWUVX?=
 =?utf-8?B?a0ZLTDZHUGhFdnlsV3pZVGppV1h1NFlUMmRnYTFaTTVMWDV1Vzh0TWlnWVRG?=
 =?utf-8?B?SVozajE5OGEzWm9wNUpoY3hRbXdISzlmU2U2Y0ZMNDFNWXNWNkF4alpCSjND?=
 =?utf-8?B?c09Bby8xbldWajNySldxMyt0RzF6bXZOb01qeWJzOCtNTWdGYTZFWjFzbXQ2?=
 =?utf-8?B?VTBQOFlEb1NaMHFyYXQ3V3pVNXdKTU84Q3RFajR6ZDMzSW1nMXdaYi9KMjVo?=
 =?utf-8?B?YU9TYmQrZDRleEgyTVhRRGhUOWMvL1NmNTloeGpYMldJeFNXbE5wMi9tQXBx?=
 =?utf-8?B?SUE0UTBRMEVHcVI5TnN3S0x3SkZrTWN0blk1N1F6b1hvQUpWN1VVNDcwUFNN?=
 =?utf-8?B?RkhaTTJlaHBrS1VrRXMwWmRvYisvdkt3RlRQMFVkVmpIUzBITEI2MFE2Sm4x?=
 =?utf-8?B?TFNJR2ZML1o1UUFUeFNSV05JaUd1OGhVMDJtYUl0WHd1Z3JTVWRVWVVmUnRT?=
 =?utf-8?B?bVAzUSs2eVZteGZLeWhDWjVHUk8yUmJJbnRwNitTc0w0enR0eFcxbWswUXhl?=
 =?utf-8?B?dGtBNnd0bFNmVVlXNzZhVjRWU21jUGJZUUIxVU5mbVVPWEszcGRpTHl1ck1i?=
 =?utf-8?B?TWxSZi9RenZ6QWJlVTRKVWZoUGxhT1N2TSt0b2ZMdFlTMVFXbDB2OEt2RnNX?=
 =?utf-8?Q?q8MvDIwTNzODW94cDBa//SBNtZiSW0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 13:36:48.4052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64f3cce-e0cc-40b9-9e75-08dd2f205605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808

On 1/7/2025 5:45 PM, Vasant Hegde wrote:
Hi vasant,
> 
> On 1/7/2025 12:44 AM, Alejandro Jimenez wrote:
>> When updating the page table root field on the DTE, avoid overwriting any
>> bits that are already set. The earlier call to make_clear_dte() writes
>> default values that all DTEs must have set (currently DTE[V]), and those
>> must be preserved.
>>
>> Currently this doesn't cause problems since the page table root update is
>> the first field that is set after make_clear_dte() is called, and
>> DTE_FLAG_V is set again later along with the permission bits (IR/IW).
>> Remove this redundant assignment too.
> 
> Good catch!
> 
>>> Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE
> helpers")
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 20177e18eb0d..a8c17b602c95 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>   	make_clear_dte(dev_data, dte, &new);
> 
> This fix is fine. But with all changes we have done in this code does, do we
> really need make_clear_dte()?
> 
> How about removing `make_clear_dte()` and moving DTE_FLAG_V to
> write_dte_lower128() ?
> 

I dont think moving DTE_FLAG_V to write_dte_lower128() is a good
idea, because the order in which the function update_dte256()
assigns upper and lower 128 bits depends on this flag.

Regards
Sairaj Kodilkar

> -Vasant
> 
> 
> 

