Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99F18EFED
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364844; cv=fail; b=XNyTlf6g2jdhZE7Xq/bBBP0LtYZ9ZhjhOxor1vs+Cm2hGOf1bqSmOQFas1+s8JdYJRvNwVbzVPnQjK3MHRMsyJ3+MxoEC++Li0cTvD62rO6r+DRtAR4YbKWBYX2hHsV4iHyHxtuthxD9roJFpqfkdtGHUlEjO6lL6SFPVyW+AAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364844; c=relaxed/simple;
	bh=YQ1p2Obb3JQy7tZq7eOXod8Iq/LcZpj0IKWqEybEMvI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYcQPYKCtC7WflpzrEG8qLHfo/yHQmKln9mHe312HgUbRMJSLIRzitlz9ShnLbSd6tvFY32M5FlyIJ9LLnExikqRmVzUtAIKxpnwnH1J3cUMnCqgVBBxdrbHC6NLmK56yz8mIYXNbS2VSGJMN28Nwth2Lmk2nyqY96zNivY1blM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RPIi4oe6; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPIi4oe6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8DhwFBnv6BZryQgLEK3//SSgisRDBHknFJeagrKvluUg4WmDTBl1lfu09/n47bAIHhc0qlZEDUpLvaerA+ZKJjbR9ohXb/DZybc7aQsC+bSR7E1+p3xg2hGvQ8hslOcoDFk5KegdObResGmrkFiSkUJ/VcbjNqesvVFZccw2rXzhiUDli667Sb+M8GZJ91/Lr/yHlRi8CYhGEfCddeYWUaZn4D221MzrtU1AQ5Upsps4/MwwKE2f8dZ/eUIGJXyOr25wHkAL/tGq0fANv/05A6E5TkeABgrkyOxFskllu/unH+dJrK4imKTFd016Iw+id6o+7DhPY5qbCFEy8nX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T8aTGrkdJgBITiRyW0JLh+gNYGGfYeRUrkiMUj/UW8=;
 b=v9QbiwQIQ2hTbD1EH9W73+EDQSBfcS9W3ypkPzSeprVci0qpUOFQ+WQUxYR9UIdrbLReCk0WnDKDNmKeP1D3Xq4Pe8KpfV//V/oqPTdovaFHrBCk4WSfzArPCtGx4qUpL0YqOBTeOJnb3OSG0NwGU6hLEOVKaw7VTUbxZocWfYiYAi6TwLyw6uTgCNLnieRA3HGn1xu2kY/mBpnLswVG4zM33w3T3UmWZHGdlusGm0QU9nTax8DPiMHo+5x/DEuVxiJZHcOW1gcQrE5NYQ11Ki0jc94Z+mLvM4z+JnP2gbJsPayBnO1T39SPZxJ06MQ9UyhiJOeyk2iou94lyPK48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T8aTGrkdJgBITiRyW0JLh+gNYGGfYeRUrkiMUj/UW8=;
 b=RPIi4oe6Xbh3xBge2AYXpgoZVxwNtVAtWaAyIiO8v/5qIHojmoMlyIrLSIARAJp3Bv/rZBfKThvJPc8/Mk9TZcAq8dN7eM4aOeSWojq7nEvV3mKp1kHOqmtaZxunxjjMt1XXw5XAs/QTl+KGQTWjEFPjHEtg7maXN4QlL0WqKeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 08:53:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 08:53:56 +0000
Message-ID: <c484f2b9-4f8a-4a3c-a34d-1976b5626dbf@amd.com>
Date: Thu, 31 Oct 2024 15:53:09 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 7/9] iommu/amd: Move erratum 63 logic to
 write_dte_lower128()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-8-suravee.suthikulpanit@amd.com>
 <20241016133043.GL3559746@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241016133043.GL3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: df3b50a0-9fe9-4778-3629-08dcf9898ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STduNlQ3bUFRclZMVXJ0YXp6QTZqM2d2alFSamZlc09ZN09DOUNVMDVmNnRT?=
 =?utf-8?B?WHRkMmhib0NHVGVOUUN3eW9HYU9lT2FFRm1ENU5la00wdCthRG4xVGM1Vnlp?=
 =?utf-8?B?YW45STdmT05HOG1iZjFLaHc4Qjc5eEdKcjRSRitRNTFrUGtKK0JvZGM1ekdV?=
 =?utf-8?B?RjBWS2MyNlRLQ1JtQzRXVXd5NWZNd0xvM3NpUXlrVVRDbUEvdGJsdmZzY01U?=
 =?utf-8?B?UUlrbmVscmNpMWVhb0V5NUgrM0lxdGppaUxyZjZiK203OXFsbUUvM3ZhNmFS?=
 =?utf-8?B?SFlXOFQvZkRjRDNRd29QZWE0M1FjY1FwSExWT1FlMmF2LytocDB0QVFFMktK?=
 =?utf-8?B?WVd2Y1N3ajJidFFqdjhYa2k5V25reEZ2OTZwN1YvTmxmcTVqeEd3bGJtNWlp?=
 =?utf-8?B?Wmd4MStyeCsreVRtWnFILytUeFY3WTFkblNxbWEvZUVBMEZGQ1pudEFjM1BS?=
 =?utf-8?B?NHo5Z1RLMUs3N052RnhqR0NCUHJ3TjBzR3NoYVZsN05PdlVlYlp3WUFTeXNw?=
 =?utf-8?B?M0EwWlFnRU1JaWxNdzhvdldjTGN6VGVmS2NmbVNVOUFFR2dHWDZmRkhWNVFS?=
 =?utf-8?B?WXp1Z29RM2VkK2ZCYjQrT0dROUdXY21Jbm45c2VRU2NqVTFJbE9FNjVpWW1O?=
 =?utf-8?B?dWo2Sjd1WlUwOTZ1YzN1WWlFMk51V2ZidjhjWEpWR3p0YVkzbHM0TGhKZHZI?=
 =?utf-8?B?MGJyZUtLOFI5RVNnYUg3dHlmSTRzTU1POHZibzYxMStzY01NenVMNmJmbC8v?=
 =?utf-8?B?VGZLa3JSRFN6VzVGOTBwUDVtVDJNNGluUmRBUHhTYTI3TXZEOWZKQW51c2VZ?=
 =?utf-8?B?RHFQWm00SlBEYytTU0xxSEZsditnVWRhZXAreElCUkYyRmdkdFRVS3ZLUHBF?=
 =?utf-8?B?czB6K1NDWEszbGlGZGZWcThoUDZhSzJVZXRQNmF5dzZ3WVI2ampZcU9wTFlH?=
 =?utf-8?B?bCttVnlXbWtTUnBSV3Q3V0puaHAyNVJLeS9IbS8yQmcwY2tYK0pySHBiWkFG?=
 =?utf-8?B?TDM2SXYvNGtuKzZaalRSd0t3M0N5MWdvWVd1Y3U0aVNheEYrMFhFWjFjU1ds?=
 =?utf-8?B?ZFRONkhST2xYd1FqeXRxRngzd1Q2dml6ZHQ1THVsTmoyRUs0eGZaczdZVE1w?=
 =?utf-8?B?U1JJb2V3OE0wMExOUDZwTTFJblVJQzlpU3lmckNqcnJDYVZjWEhsaStVMnVw?=
 =?utf-8?B?a2h6dWU4RUQrY1QwQ0FneThoc2loSHdBTFR4Rm8ySGp3QVZFOFAxSUloZHNx?=
 =?utf-8?B?cWhJODQ1TSsvenVHMWRoWENKQW9JdTkvUGxveUhqS1dYUFhoTzduZ1krR00z?=
 =?utf-8?B?RllHNnlIQU1EMkVDb1BKWWJ5bnpIUG9JTndySG1GNzRxTFJDZVJUeHRtQk1j?=
 =?utf-8?B?Sm5JYVNDbndwNnhzZlpWVnU4K1F1eGJSZFBvNjlMTUN3a0ZabU9qcUZqS2hs?=
 =?utf-8?B?RUtrU1cxUHQ4VGd1QzlFNUFJaWVmaDh4ZDZiN2V3Qm44aWcvL3hBdnI0VUtW?=
 =?utf-8?B?VkoySGJXSU0weVI4S09JeGlUSUxsQ1JoZ240ZUlhYmM0ZDlHaTFvNFZrR3ov?=
 =?utf-8?B?aHh3M2RMS3U1T3VNbDg2UXoyN1lkTEt2Q01zVklKVEpCcDk4cjdJTXI5QjZt?=
 =?utf-8?B?bWR0Z0p2TVpicFNaWk5oemNnS1JaUmJ3bUFmUldqbGhtME11blRxWTB4ak00?=
 =?utf-8?B?WFNPbWMvb3VvR1J6WDVsdU5KMkk1VzFmbm9YK0dsZ2xBd1F5YjJvd2hHSmF3?=
 =?utf-8?Q?v3i0lvi3FzuoD6eMy0rTehvkJr4o7X1wcdIUiQP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUIyaUtLd3dLVGwzeHZtS1EyS255bTFmWk1XQ0hyci85TXczVUtpUVBJM1l5?=
 =?utf-8?B?WHlWSVEydS80aStJalEzMUxpOXg5dCtKajVHeWxCNFUxVk55eXJUcU16T1Iy?=
 =?utf-8?B?QVNGNkR4TkhBV1pvamtheEFENTZHc202M0dSWTJqRU5RMW5TN3ltRnFrTzVL?=
 =?utf-8?B?cUZVSmYrbjBib0NHR1RPdm9LMUJtbk5LMlo5cTNKWk1qZElZY3RKdzdMWVJi?=
 =?utf-8?B?ZjZuWE1UODVRTE9iZTlLZlkwbVQ5VVo3QW12L2NVcy9lYXR6RWYvNk5OWnlC?=
 =?utf-8?B?bkV4cWZ6Und4ZFFXYVdvQWNLd3dES0dyL3Frb1dTcmlhZVVhbnMwT3ZwSUhJ?=
 =?utf-8?B?MnM4dzB2VnJQOUxQNm9hd2NmMnR6a1BidlJ2UU9EZEJFSHJGOWkzNk9rVG5n?=
 =?utf-8?B?MXdma1MvQ290K1RRU0VVbEdrZGFWSm5VV0w3QThENjNsVjV0N05mNTVXZVBJ?=
 =?utf-8?B?YVk2MnpnZzJTc3FVcWJmdWdZeGtybFpZV084R0x2SlJqVis4NnZ1YnZVYisw?=
 =?utf-8?B?cXFxaHEzczN6ZUFLQjhGcDNxbXZzcmdOZGxsUFFvZC9jZzQ0Y3RrS0dzbkQ4?=
 =?utf-8?B?TEhMQ2hMMlpEOEtXenBpMHNzMmpoajlZMG5nRWdpUzBuTXdBY2piZG13Y3NC?=
 =?utf-8?B?L1Vxd3JPQlVaK3NIaTI4VEFia1FXWXF3UmxSOUZxdEZWTnAxaDRWYmtRRCt3?=
 =?utf-8?B?NldocXREQlUvazRyZTE5aFpXWHpmWGVHS05MNm1lMVg4WURlcnc0OGlzcFBR?=
 =?utf-8?B?NGJQMmlxblJUVTQzSERWLzhIakpGZG5zdUhTVFBNa0pGN05NQXF5U0Nrblpr?=
 =?utf-8?B?dm1qWVVXL2VUWWV5QThZWFVCOHdEdjhWNjNKQ3NyNEkxRnhEZWF2Qy9BVytp?=
 =?utf-8?B?dW1pellEaFhERC9ySDVDTlZZNzJWcUYzRlZGcXNZNEdndXRTTzJ4Wm5IY3oz?=
 =?utf-8?B?OHBybEJsanE3UGlGUWkwN3ROUHlGYmo1SUcwaTl3M09yK2JEcTh3R2lickZp?=
 =?utf-8?B?RW13WUNNMnBIQ25BTXdDVzZGTUFCUXVjblBxemlzMTFvTXJ3Z2FPcGhKM3Zy?=
 =?utf-8?B?cTFYYnA1R2Q4VjhUeTJGUE91Z2xmTUhobmJ0ZklWb3JTcWJWdmRZOXluVkJN?=
 =?utf-8?B?NFVtUldrd3BnaUZsN2FleDNZdkNpTXBMazZRVE5UZjRyRzRTSVZEc1NBZkxt?=
 =?utf-8?B?Vzl4eW5kMHM4YmlrNXp1dWtjL1VoVkR0VFovcjNpTW5CTlRxMmdXSmFLdUR2?=
 =?utf-8?B?ZlAxU0E0QlJ0RFlGZ3BsZ1I2SkNWMXdTcENONmRHMHVQT1RZYjRSMzcrRmJL?=
 =?utf-8?B?SEhVcXMxNS96K2h6L2krSVMyYUl3QXBYbThuYVdYMlVYaFMzS3FQUFNzRDlx?=
 =?utf-8?B?bllBamhJSEgyZ3U3MVA3WmxMdWZIY0xjMzBNaGlKNTFYekQwWXNqTHppbGtO?=
 =?utf-8?B?THJvM0JNQ1FJSTA5T2x3K0VaVlU1eEsxV2hlcGZoQzF2T3UwcSs4MU1MOUFF?=
 =?utf-8?B?Uzc0RHRnQzVMMHo0WjlYdHhkcjlKQ2JwM1BuZkxGY0g4aTF3cDZsdUk4TzV0?=
 =?utf-8?B?Qk83YnF6d1E2OHE0Qkg0U0J6b2Y2Ulh4VTE1dVZFTGZrTHdLTnlkbHhFdW95?=
 =?utf-8?B?NGU5WDBVQ1hybDhXTVRNek1UQUJsNG5jWFVhWm84dWtPcDF6bEFydWZIQk8x?=
 =?utf-8?B?cVVTMXJnNnpWcGJlZUZRTndTR3N6S2VhY2hVUS9ZMzlNak5icFViZnVyQWMw?=
 =?utf-8?B?N2NRcVZ3QXpUSjJNcUwvWHRLZ0dibFJ0MXBGYzNaUjdNMzA5Q2JuSTZOeVhj?=
 =?utf-8?B?WVMycU5QUGhsQ0kwR1QrcVpGb0dqQkdraE1RVHcrWkx0bnNTZUhzWnlQWk9Z?=
 =?utf-8?B?dUxKcm1TN3dDdnNVNWV6YVo5MTZtMVVuS3UzTkUvbVJMeHVLbUEzbzJNZ1Ex?=
 =?utf-8?B?aVJqUm84aklrb29PNDBwSnRsQXFZeE05RHN1aitzSVhRakt1UnI3RXV2Sm5u?=
 =?utf-8?B?N3g1TExXT1h4RFNYM2g0elpiQk1GcjhXQVA5T2VscFVFbUluK3p1SDV5dXo3?=
 =?utf-8?B?SkNidW1xWm1VMGlpQi9TUElLRU5tdjlvSThrWnhiZ2NuTkR1TjZsc2hPZFk0?=
 =?utf-8?Q?f3XuLHgSLS4zrV52syLwQqcIq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b50a0-9fe9-4778-3629-08dcf9898ce7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:53:55.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO24lIBiilaP8PQdEMODuUA/gIKcobGEH99HJnTT4Z1hx/lVt0zCs5peV/LLGXwQWiZGzmEQuDc8F9jhpwYEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024



On 10/16/2024 8:30 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:17:54AM +0000, Suravee Suthikulpanit wrote:
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c03e2d9d2990..a8c0a57003a8 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -105,6 +105,10 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
>>   
>>   	old.data128[0] = READ_ONCE(ptr->data128[0]);
>>   	do {
>> +		/* Apply erratum 63 */
>> +		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, new->data[1]) == 0x1)
>> +			new->data[0] |= DTE_FLAG_IW;
>> +
> 
> Why not put it in set_dte_entry() ?
> 
> Jason

I have reworked this part in v7 to move it to other part. I will send 
out v7 for review next.

Suravee
