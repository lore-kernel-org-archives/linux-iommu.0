Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D24463B9F
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582200; cv=fail; b=j4I/yAZx16lBH0gROKgcrCMyF+e+PwlItmG/6KusDW/ubouiCCNXXVPje8gfmrlVJ1+IKoA8efWQQccGtD82mS3Zxf2jcSeEp4MBmnKyFgxR6q7Ds1kSpQyP+DjUQ9UgsdGmcudRyV4mI2Aodss8stQxeaZRdYXqZG1Gifh2498=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582200; c=relaxed/simple;
	bh=E8ck387kbZTway1jxA9qRny2ud5F5V6dcvz3pdo+dzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdysAIuJOoBAAVQKyUPhzWlaoF9F5DDKLWn4ILhAAQ98PCld4Rj+Hj6SnT9zfOvrZ+59OhKTPHuI17B5jiJk6L/h4r4RYvAuMnCiPIfbggJHJRsrcrzYbcsrp0KS7wN4sqGutneWqofjbzpyJMaJ0qMEsTbCgP7ZbFiFL8pxcF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f6kevX4A; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f6kevX4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ5mu3htuIt0VuxHqRu4oMPQKwV8qccES1xocYylryC8doVwm67s8d42rCOl7XJ0DWV7Ykvoy7J4GBGC/pcKDprJIP4WaWHnDWfe4DORDAaMJS1UnL7ocSpQl4YYRO1dXewXgX+gVIpRCVN2qVZovPFY+KA6h9w9Tkd3QDa8VKrYKoV2EcrGZcLVAcwaRzCJU14HfRCwkwa6+hkYOUi+FxbkJtXUBYf86T91k5ZlO52pJuWJA/Bwa8dZAoIawXJYX/zM8ZCGE11vycF26BjoHWVIgffq+VJHT70ZfIe67rPCpcmFLyqYg+QGRCOhWobXWBm1pG7hUO9EzZVLpRqpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRvWLpYwqTx+EhU470nBy2+NewH7sKH1xB1mM1udShY=;
 b=NfmjURIJoz0QpIn4I3tJnZVQ2TRUSX93McewfqHFSXQ5Zjnv8f5+ZiqoSZKSVIOhC5t0R2NQfBmQQnn7Qp5x/PBxMGq9vX8Ro6j7VvIoXUM5RZ67+C9hOD9Q88QXL2m95xhYbkFQPbboQClmNTUFUs0FQlp5AFqLn19QuHRxVBApvJqDYfpKAxnEJgtqgyJsDDxMhEtgjxeer5H0jSJM9AESbDH8/6itaUithNAqIDeXkcRkEVH55Kt2q4BsNejYb/UG8bqP1C5qUWbAYcaoeBpV1/wPN9S6mh8G7oHWB+abT6L0kqvhC9c5CW+p8cojSCM0FCaFUUzSNhOCZqFZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRvWLpYwqTx+EhU470nBy2+NewH7sKH1xB1mM1udShY=;
 b=f6kevX4A0OrR1El0lL61PpTbMlYaGWmW54N4iUEZBnMkwvCAjQ1XhFWeUbGR/ljHRFBXcwbIL3aA0B555dfadx7OY9egL2IURHMFHMYLmlmjgfBy+90r3rJh59M9lvoEqDlRlA26oP9CxpVM8krjjRRoD8m3CNH9/42vHAVQKzs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by IA1PR12MB363945.namprd12.prod.outlook.com (2603:10b6:208:5b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 07:56:34 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 07:56:34 +0000
Message-ID: <72fdc94c-d35e-4667-bd68-3dd8bba852a2@amd.com>
Date: Mon, 28 Sep 2026 14:56:24 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/24] iommu/amd: Program nested DTE and DomID map on
 attach
To: Guixin Liu <kanie@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-18-suravee.suthikulpanit@amd.com>
 <a9465515-de05-4b85-891d-6cdbbd793195@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <a9465515-de05-4b85-891d-6cdbbd793195@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|IA1PR12MB363945:EE_
X-MS-Office365-Filtering-Correlation-Id: fc460ea4-e22b-4643-0c0b-08df1d3603ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	60glZN9g+XtTs6S/llokvJdWqYFBdg0X27IZoiKo5mvR1RrzLoJzLnMc4B3hLjTN5qA1bei0XsuRrU4UcrN9Uu1RFKq0gzbQPRjLIFYsLiadZVJXFIuzHUZGd1FVMatHx45rgeL6b3QmW2XigKCi2k75D8acWoMA3AfyW8H6opAWaUFOwkuAAtjw+R5ohLftYvMkyI92hOsNqtJUdTL9HDuZgJyfsP8jI0r5v+e4IfAJml9E+Il1rBTfeDhGARjCsu+TUEl7J7jzLAi/l0MjOkKH2HahwJLav7SBIMqli+bm/a2/uj2CUg828JQxFoPLDsQq4RLM/fK+jJQbfEo2g5BboCasHgTE7M8QxqWl6jHjRndml8XCLffjHTq1a0HLqB83MFJOBZQgQGRXJ2gsMpDpsgAVWZuADkMzNXhTeis9q8So/FfUdxOXkWmdPpqa0cxI0rvpNoTTv9loISKSwuPBA41aXnQGp55d7IGiadmGnSlxlER3gqSr5+MMTM8wPIRkThopQGqo0Vh+Dobofvq7M4QxRzcrMTp+fqm5EzZvRzyUHLu5tL3e0oKSG3r+NAFyomwpEUVFqI9TkpflKrvzqS1jNj+e/mDhclkDJOddpAFq5QK/nMLZ41xcl2aWWfQCHNTTf0pImGW4zzfh2/FrMQZqpsnafOnrKQ6zsGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NxTEFOdXNBZVdoMUF2Y1FUVHRuUlp0bzdtS01yQTVYZzZsUGJORlltcW55?=
 =?utf-8?B?WHl5bllQaG0xYmY1dmF1bTRmd2xhQWl0NHBTWExjaEJnUEtLSlJsWVJ5eWpH?=
 =?utf-8?B?NUhvZEYrWmNpVDIwTkhRYkdiNzRXWURPTytLek9zUkhrN1huQkE1U1RKRHhk?=
 =?utf-8?B?SmZGdTg5TXh0N1pQZG1QZkdwWExzZFdsNHZnMzVMTkE1d3g0VnZjdG9BY2JN?=
 =?utf-8?B?d1kreFMyalRyWTVYVHpZblFxTUMvTGM2ZlhTVnA0TEhhOEZVbEJuRW9wMWlY?=
 =?utf-8?B?TDN6ZkRVWndTMVRnd3FzbU1rc0kra2tWU3E3ck1nZWYzQS8wd0NqM0lyN1Z1?=
 =?utf-8?B?d3l0RHFtblJ1MkY3SDhXWStBRHZJODVmWVNVUjVCTEdjb3k4SGljWVU1bit0?=
 =?utf-8?B?VWliOUtyNnRFZlpVRWt2SVIyS0tHemluLzFXcmhVU0VmNi9tVmUvTlV6ckly?=
 =?utf-8?B?S2J5ZWl4dlIvNzd0SjJtdlNJVGVRYkhuSlVraWJRbCtKSStvY3IwRk5FUnV3?=
 =?utf-8?B?aDVBTDhZNUh5eFZNWHppVG1PSW11a0Z2S090WmpQQ3VZQmlJbUVHZzBFYzc5?=
 =?utf-8?B?WTlsbVJ1ZnM3SFR6aWo0WElHK3NqN1FUNGV3SFFJbzM1MDlaVFE3TkpJaFRm?=
 =?utf-8?B?elA3d1NIanRlbFdrZlhPU2pFK0JwSndYcGd0WFJyNDh0b2UvaTlKaURoRjZJ?=
 =?utf-8?B?N0toNUllNGwvYXNiREFpZjY3Rll1eVhsYktJVGhzU0ppNER5MUlkeC9YSFhr?=
 =?utf-8?B?ZnVqT0ZBdSs5YW8zTWZzRDQrWGVOZm0yeVJzdmxXL1hhL0ZSYS83cVp6N1JW?=
 =?utf-8?B?cWQ1TkxMN05jR0JyYi9RNW9OVnlKWW5XTUpQV3JSbzR4MHRmNzlrYitiWUJE?=
 =?utf-8?B?ZEpzRmhJVmJZVXV0ZXMydHA5WXhwMjZ3U2gwak5YMklSc0liaWNqTmk2d3o0?=
 =?utf-8?B?aFlvVWpKWGhPdGQ4MVZ6RUZPeFNWUGtRUVlJT1FqREJIb1NYVFZoSEZtTVVW?=
 =?utf-8?B?WTFzeXVGeWs3WENFc1BVL2dVN3NBcmpyaEdJckgzSGF5TUZZbHhubEZmLzJn?=
 =?utf-8?B?ZEZGMUFDWXMyRTg2eFQrODh0bHllMkx5dklmSG9KbzltM2U4bVFHVVkzN09E?=
 =?utf-8?B?VjFxWlNHdnZoYUtveEhsYStTMkpvcjZEZFVINmYzYnBUZTJhVVdxNXZOVm5D?=
 =?utf-8?B?WFlUOTJXUFJZeDhCdXlYYzRPTlp4aFJRSFZTSk05bFZvZE5FbzZ3Vit1MVVo?=
 =?utf-8?B?L3hFMDB1T2hjTUJROTkrL0lDa3pNZ1FpUGtQYStGaHk1SXgxamNLZExWYTl2?=
 =?utf-8?B?WWF2QkNXM3N6RXF2NlZvQ3prN3c1Z0RsUGQvcjNSUDhudlNNUmhNeTc2Ti9M?=
 =?utf-8?B?SGtLZjlWWTdVRWkvRTJMTHZuSlJjRHRVbWtHb1I0UU14WHJ2dGx0YlJCMk95?=
 =?utf-8?B?dDJVMVA5OEN6Yi8zMkdIWVNkdUVYMjdSdU9ob1JIVkhIenhHRmFWVEZVYkZt?=
 =?utf-8?B?MVpuK2sva3NrTHRaTmowRDN0aEtRWmZLR095WnBHRGN1K3VFUTRrUUloYTUv?=
 =?utf-8?B?dFVQMWoyNjJ2NGtjakVwakl5VWV6S085UVIwY3l5REdPbXFaZi9HM0dWWTlC?=
 =?utf-8?B?Uk5wVk5RZldYMndDVkE1TWNpSktQSWJZb3ord2NiY2xjRDBPSmNTRG1IV0RB?=
 =?utf-8?B?V3NUV0ZoWktWbTlUcWRIRlZJT0I2NW9BOHMzSWxQdEZySlNjQ3JHaThMQnF1?=
 =?utf-8?B?eDVnRDlSYjNJeTlNanhVSy9uS3JNMWdtbzlwbkRyWEdycE9STjdQSFNlbG5j?=
 =?utf-8?B?a2RMTFhlU3lkL2xGR2tpbG05RzJWWXJjYnI2SFF4QjBkdlJiNE5CMjh1TVRI?=
 =?utf-8?B?NWhCTTVjZVBPWit2ZysvTDhMRDV0WUx0YzVxOXhETVdUMkwvVUhRdlpnQXVk?=
 =?utf-8?B?eUgveHBQMWhCMUhtUU14VVpINzlycUk5eGx1VTQwbTJhV0g1QXRqK3JFM1BX?=
 =?utf-8?B?UjRQNkNqK3h1aGVWMlg0NXdVVWhSL2wxZFB0N3VrK0tRVzBHTUZpMlV5RW8y?=
 =?utf-8?B?dDBPdHpmU1N1cTlkWVRyeEtCd2tPVUFrL3kySi9taUNyb1lzTEFKRm0rSEZ6?=
 =?utf-8?B?MTdSZi9aczFhdmF3QXJlTXVmaXdkb3lKKzRPM2N1ZWtkQVM5SFk0Z1N6YVBV?=
 =?utf-8?B?cWRkUFRuOUk0VCtQa2VPUFpkTlBGZndVdys1b2ZidmFxQ3RUMEx1Sis1UTlu?=
 =?utf-8?B?WXNXMk1MKzFlNWRlWldxYzlobFhtckJ0RnNNa293RDVKMXBLQVJQOG1yTWNZ?=
 =?utf-8?B?SVRWTnBudWhkY3A0U25aNkRFOXhycDVsTEp5OHB6OGVsNzVJNHRpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc460ea4-e22b-4643-0c0b-08df1d3603ea
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 07:56:34.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhz95LwjOclQibOfMK10v2uv2UnzmYbLOBMlbg10F+eGEBqeMci+EsSmIdIEzuZKlEmYqP/nJzV+zV9frfJMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB363945



On 9/22/2026 2:11 PM, Guixin Liu wrote:
>> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
>> index 1022ae20c170..f17ac13da213 100644
>> --- a/drivers/iommu/amd/amd_viommu.h
>> +++ b/drivers/iommu/amd/amd_viommu.h
>> @@ -23,6 +23,11 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
>>   
>>   void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
>>   
>> +void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
>> +				 u16 hdom_id, u16 gdom_id);
> No one call amd_viommu_domain_id_update, should removed?

I'll remove this in v6.

Thanks,
Suravee
