Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F04446E4
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626835; cv=fail; b=W2xDg2ccv9Uv7YOUJjqurjzRD1sMvH7GcpaYGEWD6EOJWjPLx6Rse2yxC5ICyl1DDzvqag7gqAaBBpu4GgdV84nLHBx7qqNuGf3Qz25XCWW1gBukNCPpXBiZbDICy5g1o6cAbpvcvZjjjbcvY6mqMP1v11eiVLn2H5WibLox0Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626835; c=relaxed/simple;
	bh=I4DPO0+d9n2DJJfArlGKcWEUUi0HbDDbkc8rPDAriyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUhX8fdM/qzezN8ujbxN8KxYcnmrkb3BDCXDeVpSCyii9g+U3UjBoE+y4cVOZLxJDEo9ZgbrMQRYMxS8lku+I6qQL9tuB8sZiOh9X8SKY0gjNFmJauiBnCy1KMPMkxYFcPzxyS4NkEi6oFA6p0hjzvTHwLmTJn6Q7O26RUPQVvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fHhGZ9mx; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fHhGZ9mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwe4zsroambnIqWGjkxxidDhA3dBIxcBJxtI1EXAEUctDQRSQYaaTL83puyRoa0zBOCD+avHf44rkgeXVB3+xWA//yH4sy20oCbp8BGtfFn0N0yTn/JhP5H34/ftIeuZTGNqkqpwO2BbbdjJFRv2UfSqtv0i+tw5TL4xGFgGlsiRjCUba/hv4QHObswGLtxHxPvxfxdoRso1onL/kWA6ddKv4DuxOFpl9EKN4GoPLwAOeHMHYnz/p2HWlTvLFXhJpYSqrudBDk50tdvUKd/VHaN4eQMkdlYc961Sp6XJbFSBpdtSDnBQ8/O9iWQrxrAXJh9Eh08WHax4chHzVOr3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk6833LJuhYU0OebpjeVUA9w+xnMulJD03Q7IODF42o=;
 b=Dc69KPbhZyouvpObhuRZtqsxNnCMJ6TYyLvfrrw8NLklHVNGwozSa41TomQvN/1OQFtyGQxLwCk3cVgRp+WXqg6OKv5nF6AbPbYLrH2aAWvnr5E21NTx6BgGn/FYsg8wBmeLFmb19OO0Cz4nUm9j00znUwBG5yvkY/dLc1mdjssAXfCb2hCt6diPWONAk9o3JlxXTqnQtFcgjGYukM7A6lJd4Z6hrz/NTtfNdWttrn5MWB/xg/RbS9aP8PxKm8yttmi+EfIXwYOvdHj0lSpuIQ1D6rhcMGH5QhJuu7rLQxS9XWEMFHME/Yb1AhjLEuZeHf2HhpnUpaM7O8LbBP2b4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk6833LJuhYU0OebpjeVUA9w+xnMulJD03Q7IODF42o=;
 b=fHhGZ9mxJ39jvHBsfE/a0chhMxULengmTT0RTGaeAVjUo7gQQD5uK9GeSj9qR/w5PKkxmGJA4VQkGmrEGEfBHzHnBPjQlLaUiw9WbwtDC0xB5Bq+LzFvzGc+fVVdvblF/XxcJiVuPQVLebQBpq0jan7CQMdkz3Xc9HNEPah3PSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:40:30 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:40:30 +0000
Message-ID: <66464613-6dbd-41d7-bd50-20d6bb02e789@amd.com>
Date: Tue, 21 Jul 2026 16:40:21 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/22] iommu/amd: Add translation DTE and VFctrl
 TransDevID helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-22-suravee.suthikulpanit@amd.com>
 <20260707144346.GI220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707144346.GI220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: f81f1dac-a067-4464-7aae-08dee70c1ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EzVYpZ53xYjDwQ9O2ZQwgXEr6uYZYE2MpS05yjOMpFF2XpTH9HTDA5DshPJxA2aqanUobPiunJ4/XMVYNxx9EZCmLhvUM+0ptPuQSWBgN1f/yzNrbJImXRIvxFgVTNvjGmXwjx0at/rvMj4yClQOHasp/qFWnieiMcVtxhbushnWa3ecsXIwNYAb0GLEjmQFie/7OygQauSgHA7MjkmYX5M9BiwWV6p1HHaUobYVf4pJc0RFxcJztbDl0SHV37W/dB4Q1955EUzeQ0GKcYrfhSvsTi5YcsZ/Ai4dkCIrcarrJHP6/UDHyivucj53FMqgTkzsWwU15qvN6GAkUTZE1bIbBiXl7bWv6IeyZAdouae6G5VUEyt3VrQZqSK70oBTGXc+ovpQkheU7zGIYqfr8CkyQj6f/UpIRKg0iCH6edOQEg8rpQ1inZhCMa+ICwh/dcULcXWo5XHHFV2Py4qgxZu2FYLfDL6u0+ElhX0Ocx4GwiyEj1npEbLwyUIJ5cEhpuxZkCExD3fS5X3U9zUk0oltOF/chNSEWG8pOmRgwi4RvrCxA0eSH5B2bcrEmyR4WRMsxiITLcN6aun7FhjyUJky6IAJzaRyg1Kw64r9Qt7saT4Ax1+P6wgs0C9Mge2fer7wk+GQHNR6dUGidSfrhyfWfJMOlqJaaEp0wGoloxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZoeEpFeU11cUtBUkN4cFZGd0x2Q3RLY0ZmT1dnSUpFWThRTGhJU3Voa3dn?=
 =?utf-8?B?Ni9GOWhINTlLY3R4SkhiNGJYZXcxVU5jbncwakdWS0RJa0FsVzVuNW8wcExC?=
 =?utf-8?B?L21VVkhHWWVlYm9zVkM3RnRsYng2NTVGUGQzbnBpRnNGdVA3VlVWQnA4dEw5?=
 =?utf-8?B?MThDMkxUT2ZYV0NTOHgzK3dmRmFjV1B4Z2VONGp3L2p6MitaNmxmSHJBVXUz?=
 =?utf-8?B?dkdnSXJzb0djUXY4NnQ5VzNqRGxKSXBjUEFkK1N0V1ZDdjV3dERzZ1JvM1d5?=
 =?utf-8?B?akRxVm0zUjlwQUtHNklRUGFkTU5zMkhDYUdURnQzRTVLbWNvWEVadkRiL2Qr?=
 =?utf-8?B?ZEtMMXZqNVUvQjBWS0xMb3VTaDJocDNmSWZEcGd6UENXMTZCOER0UmtGcjRo?=
 =?utf-8?B?cjlKT3VOaG9nU0UrNUVmM0ZQNVd3MEN0MjdBUXJoR3hLTWhBTnNRamdsNERt?=
 =?utf-8?B?aVFJOHFvVFpoMk1UNjVlWkd0NlZGbDBQbEQvY3RUNXovVnU4WEk5dzVCWEV1?=
 =?utf-8?B?N2tDSnBGeUNUeENURXhFanJJTzZkeDNHSXFhczFtSk9TZ1RkVXJ6ZGMzRit1?=
 =?utf-8?B?V3VPajZoYlRHZHljWlFna2t6dWNQUXNUeEV1V0NtdXdwYTJSZmNmN3NNSXV1?=
 =?utf-8?B?cnlRbFdnZ3BUTWhvRmJLOU0zVlZpdVZvZnBndWhIamRCb1J5NFJvSWNIa3BY?=
 =?utf-8?B?b1RRa1JTOERXT2xFOXZiS3E2VUtQTjNROTM0YnBNT3ZEZkM3ZW5YOVQzTUtn?=
 =?utf-8?B?N3RmODQ5bXBWRW1nK3EzSkJOOU9lbEpNNnpsV3U4VVVuM3Q1K1JySGRNeDZn?=
 =?utf-8?B?MmllbXRZQkFEOFlnbDd3QkQ3ajVPWWR3WUpNU3Z5cE5YT0xVVUwvVDVtMkYz?=
 =?utf-8?B?MmlFMms1RlRSa3VlWWhXM2hmMjhvTkVNaVgyM01PbDg3WHlRVFpzWDUvemg3?=
 =?utf-8?B?ZkY0Q0ZISXhTNUVxTVVmT24yYWxkSE5wZk5rRWV5Zkl6am9UVE1jNjd1MnZs?=
 =?utf-8?B?UFVzL3Rlb2pnVlBkdTV5bU1Tc2RhbkJsQnl4N2dJbzdZNy80b1B6UmJzL1NL?=
 =?utf-8?B?UFhzOWp4dWFjN2FGRzVPcW44aFVUcUhBY0wxUmtMaytBNGI4a2FQVTRQVy9m?=
 =?utf-8?B?aitrb09aUUNhazlLOE5HVDdPYmFUUXNBWDd0TVV3dHNJM2hzdUxvd0VmaFBR?=
 =?utf-8?B?bXFlcklNZXBHcGF0WFczb1h1WkdvcHRpaXlldnFRWUlISFV6bFoyK3RCWjNP?=
 =?utf-8?B?U21wMXF2OW43MXhtajZ0QStSdENYbTYxdmtFTmtHT3plVk9oaVBadm9TN3Vp?=
 =?utf-8?B?NkI2Uzd0WlNEYnlIWWJLNCtseDRiNmVpZWpWOGZiK3JxM01QM0h5VzFMRSt5?=
 =?utf-8?B?TzJtM1RYbnVVYWdsR1NXM1d0S0dSR1c4UUZrQzRZYldvVTcxQUhqNmlYSWov?=
 =?utf-8?B?NklLWXVCTlhxNWRpRWNQY0lxTWJZVzAybnNUODljY01VdUpITkZGMHp5anF3?=
 =?utf-8?B?NzdZMFRHK3NpdjJJUHJjOGdiT1gxaThYQ1NUTDdLaVpNSVhkMlM0djhka2Na?=
 =?utf-8?B?MVhCVU9ZM2N1Tkx2a1I5b3l6VzBoR2owOHJjQU92UXlhNTUwRWZXMndFbGF3?=
 =?utf-8?B?MEVoZDRuTXRBb0RXbzFqR0xJdzY3KzdqWW11QUdoUUIzK05aWXRZOG9UU2gv?=
 =?utf-8?B?QVI2VmpSeWJudzR0MmRpczN2MGJ4bHlQNHlzcFpxRnNWQWUxbC9ZUk5LUENE?=
 =?utf-8?B?RCtCdDUwSktSa2ZSWGxTaTRsUWJqQy9HSkR0QVVuNWQ3MG9sQWk1NXFER0Vu?=
 =?utf-8?B?c0ZnVmQvbEFsSGFDL0d2QkVQTmFTcW9kZEN3VjZpZzFJR2ZaaDVDWHFRS2ZM?=
 =?utf-8?B?VDRBYzRrNERnNDdsbkxXcFpzVCtlekxPOCtjc0FWeFF4SkUyQ3JLQVJhTG1R?=
 =?utf-8?B?N2x5VXZjVVN4OWwwbGx2VkFwbmtuWkphZEplYy9seWVFekZvaXV2VHBEY3d3?=
 =?utf-8?B?NUlkRG1XNFdpMnIvZnlzRWswMWsrUjM1dmp0bW4rTnlHc29Wd3hnWFZLR3Nt?=
 =?utf-8?B?dHpkSHhRYkhqa1oxb004MGliOUt4UHJ6LzNMaDV6TCtrL3ZnSVhjaXV2RGlm?=
 =?utf-8?B?NUlSbWxlN3pEMUY5eGQrZ3J4THNKSk5ZR0UwWGQwN0tBbzUzSGl4cG5NNFpo?=
 =?utf-8?B?U1MvMS9PK2hOeHpJZE40S2FOTXJRSEZNamljMllUR25UZUlMY1JuY3ZHRUdq?=
 =?utf-8?B?ZjNadG02NkQxUS9FbjJDMTZhN2t4bmQ3TTRjQ29tWDBvMUFaOFErTCtOSnQ0?=
 =?utf-8?Q?0EFWRcspFdf2fTgvzO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81f1dac-a067-4464-7aae-08dee70c1ab3
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:40:30.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLLwbb2dQdLQRDMpoCzc8x+MJRGjyipCMUlEButJnau7OMKNM4qyTIVTZSER6dhyuDknP3HdxQIV3lqNkESL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655



On 7/7/2026 9:43 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:34PM +0000, Suravee Suthikulpanit wrote:
>> The hardware vIOMMU uses a per-VM translate device ID (TransDevID)
>> to
> 
> per-viommu, the iommu drivers don't work with the concept of VM.

Updating this in v4

>> index the host device table when guest IOMMU traffic needs GPA->SPA
>> translation.  The VF Control guest miscellaneous register tells the
>> IOMMU which TransDevID to use; the corresponding device table entry
>> (DTE) points at the nested IOMMU v1 page table that performs the walk
>> from guest physical to system physical addresses.
> 
> A v1 page table is a "parent" not a nested

Updating this in v4

>> @@ -213,7 +213,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
>>   			     struct dev_table_entry *new)
>>   {
>>   	update_dte256(iommu, dev_data, new);
>> -	clone_aliases(iommu, dev_data->dev);
>> +	/*
>> +	 * The dev_data for trans_devid does not have struct dev.
>> +	 * So clone_aliases is not supported for translate-device-id.
>> +	 */
>> +	if (dev_data->dev)
>> +		clone_aliases(iommu, dev_data->dev);
> 
> More junk from the ugly alias scheme :\ Maybe you should fix it

I will have a separate series to clean up all alias stuff after this series.

>> +int amd_iommu_set_translate_dte(struct amd_iommu *iommu,
>> +				 struct protection_domain *pdom,
>> +				 u16 gid, u32 trans_devid)
>> +{
> 
> This should probably accept a viommu struct instead of all these arguments.

Note. I'll update this in v4.

Thanks,
Suravee
