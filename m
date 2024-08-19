Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C238DD2
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049264; cv=fail; b=oeL4MLeuPTI7WhWmuBI4Y0/uJ26yvLRyWmTM0I2XOHB47UHMOluJZGVhMM0Ps5Dk8zNkUzrjHGl0lsdob6cHHhd2jWK0k5E+lIAT9eODPeZ7pQAUeSLXq8ruu05ouAdTmc27mPgeS2sgBMASHWmZ691tqvLKF0lWzJfybXl2Mbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049264; c=relaxed/simple;
	bh=M+g6guI9m5vcTiBXz8NsjpgVeIaDnZDQkSWLWhRvF78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1ai0owSW80YQKKXwBJIVJA9qknG9pYJjNnpnBrGrVlAanXEL36NSTo8tYA8op+E3+pRceadLE80/tnycgwH1B2J6n1gZ230IuJye6297mMh/7K7WF6UV2MrJ4K38itVgP3EGmkj71TGDknXAnzXszr4NQlzmDUL9xBalMZRmoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CzZ/Yi9b; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CzZ/Yi9b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGhabKgQTkcdgxC+WK9961FHqZudHRQYoQiV26gdBRSpcoZAj6WNcDAf++2v7p0t9cNk9XJyiXxqu6zNBL69zCHWwM4w9WyRNqhsr4S6oTZQmBB5tGc9um4AmR8m1Idy1s1yiCTvJKgbgp7NcP4Qa0WCdG2ptStaDDyrioweCYL2BEujR/YpXtTGc+c+QKdApgoXsJI6iRqmrm4ferp0pDrR1ounp4JbmhW1VzpYRjW7A0EQo6z6/AhbtziXiTrFElES1QrTneF9RFFepI0AVw8OTRuuhVE4sYVwFJpZm9lIhlbXWLV2PC9+IoWSJXUjKsb7dZls76Yr4VCmfaIT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImD6cx9I48oJFTx+npu8QhevOS1n1rxnpNJbaE0Rnbg=;
 b=LSaIWzIWJJ/cKKuw1yTLgAqJKM07QYwbNv0veincRVuZIOR9b2ubfSA0E9z3goRHvEtavLMkIUNEfKStmL1Xrs+RQC8djhhW+UlQXsviWSaseqqbyEF1MkmAbID7nmZSQnipN3BiftmrBQFqkCyXqtzEPZmeo2P1AIZrYOKF5Uq3pNka6JFrl1QPKuHSEHZJ4/ltfftbNIug8n8WkfBUHwrCMAv6OW/HTILUkqPEJvjJ3HHhG98/yGwgXhsuWPT/oO+iu7pNiTSezuchMH72LwkrpZ9n6Hga9qJD7DT0pR/k/02oiLsogNC/Lytt7zfekEb2cSAqrJTKYxz3frnHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImD6cx9I48oJFTx+npu8QhevOS1n1rxnpNJbaE0Rnbg=;
 b=CzZ/Yi9b+lNLXRawTiDP20XzWWk7daEOYcibB48OQudOoEWTaKD5frqO9Qgj6+UuNtcweCwDGI1K3cHE7QeboWNCWn/0WnO7iXdjOM5p56YlV7M6Y+tzNW1E3PEUoE5UUdxZDRKny3ZHcb74CgVumtv3aPEsHghsQDbo3NKU9L8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 06:34:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:34:17 +0000
Message-ID: <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
Date: Mon, 19 Aug 2024 12:04:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 578aa934-ff0f-4580-36f3-08dcc018f36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzNsS0t4czlMUHM2Z0hZb1d1ZEVUa1c3OHoycEthVW9XalF4VHpmS3NkMnI5?=
 =?utf-8?B?aGJNb3VKdkc0R0NRdTZVT0s1SFhRR2RyZDhWQTZ1T0p2R0ZHdnRJRUtUWXpz?=
 =?utf-8?B?bWlhK0dNakZPaCt5aFE5WUNMbU5mUk9qQnZxeGtibWcvWWFLVmpaZGR3Z0hC?=
 =?utf-8?B?MStCRmZsM1g3Qi9QalZvRXpBaFVtYTAzelBlWElGMjhuUlYxb0IwVHZidkp0?=
 =?utf-8?B?MnlmSVNxY1RNNkllMlZLdFhHMUxUTHREblo0WFlHRHRUZ2hqaENaZ1daOW5w?=
 =?utf-8?B?SWthWXlITXY5d2tjWlF4aWNZdXhDZ2dmZDgzT0dSZjY4NjhmQkhKMitoQXY5?=
 =?utf-8?B?UEgxVHRvYjM2L3ZWdmQ0b3M2TWJNNjNZZHM5cVFMd1ljeUZGWERwTHI3S3VU?=
 =?utf-8?B?YmY5U0tGQWZlV2ozREsyOHFxbXUyZURkd0dYWG1kZFRBeTZmaU1OMkt2Z1R3?=
 =?utf-8?B?YTlvOFV1Z3BUeWJsVm96Qll2a0s1M0QvWE9pOS9YNlZ3Q1M1c2xjQVdKdlVx?=
 =?utf-8?B?aXZ1NktuRTJJVU9xRjUvZU9uTVJkRzNhTWhSOGYwODhLZ0ZQY2JqdXZGdlVI?=
 =?utf-8?B?WFRmUkp5MTNCSlVnWVVFSVZrS0o0d1RDMi9pdW5Xd2NmRWNoeVJBTnZHV2Ey?=
 =?utf-8?B?d2NNU0FtUmNPREsxYlNCS0g4d0J4ZStUcUFBenNQOEZZbXdBcHh2UjdBRVJq?=
 =?utf-8?B?ZFZJa0Joc0VDY2tLenRxTGFhVkJ5NFdKWUZUZXdhdUZKcjIwVHU2QUowSXdO?=
 =?utf-8?B?akpuUlRtbzcreFFKd25LMzlPTTF2YW11aUIxK2krcEFWQnl5UDA1aGhhbWp5?=
 =?utf-8?B?dW9UTXNWWDk5Q0F5eVZJeDVxUURzbGhoTHNjT1g3bXZmM0xTdm1LcEIybktV?=
 =?utf-8?B?UW5lcytnNXJmMUVuWE1XL243d3QwTWx6ejIwV0NLZlcybmt0SlRqSkNzaUpY?=
 =?utf-8?B?S1NVT3VaV3RlSmhVWm04dEhrbGN6V0tRbDBJS0NIeEdXaXgwM3Qvd1dXTUlN?=
 =?utf-8?B?MHNkVXdIWUwxRW4zazNLc1phTDYxclRuUDZQd0JOYitQY3JSc0JlU0JMM0Rs?=
 =?utf-8?B?andQZW5IR3BmdThFNUVjT1AvZVVVY1E1L3FEWEFRTjNNQnBnenpCUzBYT3Ey?=
 =?utf-8?B?eGdQRzViSkpHcFIyNWZabThLNmZoU1lxWDAzYzZPQ3MrK2FlU21uYTVjTlI0?=
 =?utf-8?B?RVFPSzRsbGtjaVFNeUpaTE9DcDNzL2JnWTlHYXkrbWd6L0FkblM2SU02NFQw?=
 =?utf-8?B?MnRQZ3pUQjBPTGFHVVRNZ2hGTkd2S1h1NHlkT25LQkVNTWlWejgyNFRQdjV5?=
 =?utf-8?B?VEhUNDcrTDVMWlBRWld5eTNqM2E3UnptOTFYTi9xbGxaZ0VKUWZVSCtka2wr?=
 =?utf-8?B?eGkzM2NKbHZxYlA0ejI1T0VxeHlwS3J6VUVtVWwybTdQZjdaRm0vMkZReWZv?=
 =?utf-8?B?THMxK2Jwb1lhdnA4YXVXQ1d5MWRKMEZ5SGY0M09INkVOcmZBT2dBWmw0QTVn?=
 =?utf-8?B?ck44MkRWRGg0Zjd6cW1GeUlJLzFYOVdlN2kybll3LzJHbkY2ZW95amk0ajhj?=
 =?utf-8?B?dG9Lek1lWXVaUC82TnF6Zi9NK2FnQ0hRVGlITnA1a2wxNXB1QjFSc0hEQ1RS?=
 =?utf-8?B?NkNIMlU1ZURMVXg3SWtRMHVrODhibmNhZERoUjJRMTN1T0xrRXVnN0UxcWtt?=
 =?utf-8?B?SVBYMHM3OS9mYVRqaXdBSnl6a2h1K0FDWVNod0phay9ZZWR0Q1VrWjFOeThH?=
 =?utf-8?B?eVRYU3Urek1LTG54bXpXd1o5elFsM1Y2eUg0bm0xbWp5ZnJISWxGUis4ZEVG?=
 =?utf-8?B?MzE5K0ZWQkxvNmRRZnRwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZwZFNucXdDalIrTGpnaG1qeDdXMGlna3NwSzJkTDdlM3NybVljdHdrN1Ba?=
 =?utf-8?B?b3ZwUk56V3lCZjVlUlFqUEFsS0FzQjhUcHVNaUJ0SnBpZUcxNytHMzI4Z3dm?=
 =?utf-8?B?dzdGVGpTbzIvQUNNTDNscG1ocG1UTjArb0hSczZIUndmZXpaaUhjZnowOXMy?=
 =?utf-8?B?NXBoUkV5ODF1d0o4cDdtWXd1UlQ3d3JxYUpPY210TTd1MjE2R0JnRk1oUm1B?=
 =?utf-8?B?MnZQTnVSZ2JXNkwzdWFYSGRVY3A2NHI5NlpwZGUwMUkrcXcyaGZYa0x2a00w?=
 =?utf-8?B?bGhwUjNHQkd3ZGpidzBERkYxR20rUVZya1ZIK2ZuMnR5RW5GUDNLSlBJdllp?=
 =?utf-8?B?ZzV6alFHeUJtZGs3RjV3Y3BLbitPQ0hxZnI1cllFOFM5ZDBrUGVmaHBaQUpT?=
 =?utf-8?B?NXZQTG5WTTFEWFlYR1VDUEFEekFZeFNkSnVSdDFqTTBqcnIrMHpJZ0dzWjNW?=
 =?utf-8?B?bWxnWTI4OFNHMHNOcTBNeE5jWU5TbmJJTFB5OXl0RDZEVWh3OEduUnR3OU9T?=
 =?utf-8?B?VTBMb1lMMFlicE5raDIxMC84Vll2dE5kNSs5TmFENUFqZTB0TGY3N0EzQjlW?=
 =?utf-8?B?c3kxTVFUUXE5ZjRJbW1IYlc4K3loa1ZtSjF2bVd4MHN1WDArdVpPNHc1ZG5E?=
 =?utf-8?B?a0tlbCtqVDlCck1QeE1jRE1SMkR1K29PRmozRVZPSXFyTjVFYTBib0JoZkh2?=
 =?utf-8?B?dnBxbTZaa2FwNlZnQ1ZXL0o1UlhFSXFDUFJDZkkrWkhZYk9pbmNxTVpyK1lE?=
 =?utf-8?B?WVIvTlM4RThpY2ZFM3Uxa2NoUmdRZGorR0JPdWZ2Ty9IT3VRamhQQU5zYmxF?=
 =?utf-8?B?ajFmbVZGZjd5UWZyNU5pOEZvVlVncExIdFdXL2U4N3oyYW1PS1R3MjVCSWNV?=
 =?utf-8?B?S0pGaTJHY092VjhYaWtkSE1RM2xlbFRnajJxc09kK2tKaFBXUThLYTBRM0dm?=
 =?utf-8?B?enU3RXJodE9oajZ5RE9Wd2hlWDRidXFTVTRmNmVyR2pNTXFXZEg1VmJrSlFm?=
 =?utf-8?B?ZXlsdUJ6S05QVEFFZnptQnl6YUZRM1RLbS8yeWZCSnBONFJaelIvVThHbnlt?=
 =?utf-8?B?MnA5SE9DbEFTZDdHUmM5VDdzN3ljaWEvM012eWEzZGQzWk9hNURiMzFFTDVq?=
 =?utf-8?B?VzJDbEh2Y2Vma29TVnJrakVzS2J5TXFjUGhob09PMnI3TCtkU052SWNYeWlk?=
 =?utf-8?B?ME9adC9lMXdDbUY4V09sT2V4VUdRVU9PZmFxUW85enJZZkxHdHh0TENUQ0l5?=
 =?utf-8?B?d1oyYWZtRXBmWmVxMVJRMmphRWZtUlJKMlJDVE5QNzMxSU1ScVdWaEtaSXBz?=
 =?utf-8?B?c3BXS3RsZXh1V0prQzRGcm9tT1U3cmVZU2tEYW9nVDYvd1RUOWQxWXJabFlq?=
 =?utf-8?B?NE9Ib3NtL0hSRTR3Mkx2eSs5U2ZWSEFHSHg4eno0MUxDT2RqcEIyMjlyZUFn?=
 =?utf-8?B?Y2Q1c2JtYkd6N25zS3JPMDQvb25KRzJOTi9oQ3Z1ZytOOEllT0srSzEwSXMv?=
 =?utf-8?B?UnNwUFVXS0s2cUNwZHFPQVRUeFpQYjhMS2ZkdjVnUmgwT3dVaHhnTjZTNFdH?=
 =?utf-8?B?amF2YVFqR1hRcGNteXBncnFQRi9LenJhK2ZORG5SZnZVZG1FVDVWSHdNMGNv?=
 =?utf-8?B?VVlUa0JWNUdKTFZFOFpOVnMrbGxISHFIWE9mS3FuOHRYYWJjeU1LVlM5dUY0?=
 =?utf-8?B?cVZEZFBicE5yZzVweGIxY1lKeUJKaDg0VUdPMWZSNjBoSWI5YnhXaGVKWTBv?=
 =?utf-8?B?UEppNXpjV1RYTlQ2dTlUUHJTQkUxZHdxUzU3dWpHM0wya0ZZbWNsWmRCYnNX?=
 =?utf-8?B?eHkzblR1WnY4ZjJReEc2RTFXMDhQbjRsU1BvMVd6LzFzWm9UZWMrdEJjamU2?=
 =?utf-8?B?NzQxQUhWRGxUY25QTXdFVUNDWC8xNEw5YkxmQW9SMjNXSkxJRFFsczlqZ1hz?=
 =?utf-8?B?M1Fwdy9vc3VOSDlkblpsR21tMDN6MlhhRmlyOTloNHJNQllTYVU0eWhadGJh?=
 =?utf-8?B?cGs5KzJyK3ZsazY3a1J4SmlXVjd1UXRKTC9IYmVxOUFzc0UxY0h5MWhFRFhx?=
 =?utf-8?B?aW5lQ2JxMFp5SVE1azdNMy9mNytVeDlzalBuOGNkbUphR0FGV1RkOFVUQjBI?=
 =?utf-8?Q?8q434J4XWUdk0yVAWVu19qRci?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578aa934-ff0f-4580-36f3-08dcc018f36a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:34:17.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2IGNaZukVtSOhZqXOl0Ilp7U1wTEC8LCCAXhvY0ySCGnXqsWOsg7ZZJTA8drAUR4GpNd9b7jLxDUeLuf7TL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

Hi,


On 8/16/2024 6:39 PM, Baolu Lu wrote:
> On 2024/8/16 20:16, Vasant Hegde wrote:
>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>> attached to the device and disabled when the device transitions to block
>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>> feature independent of the type of the attached domain.
>> Reading through other thread, I thought we want to enable both PASID and PRI in
>> device probe path. Did I miss something?
> 
> PRI is different. PRI should be enabled when the first iopf-capable
> domain is attached to device or its PASID, and disabled when the last
> such domain is detached.

Right. That's what AMD driver also does (We enable it when we attach IOPF
capable domain). But looking into pci_enable_pri() :


202         /*
203          * VFs must not implement the PRI Capability.  If their PF
204          * implements PRI, it is shared by the VFs, so if the PF PRI is
205          * enabled, it is also enabled for the VF.
206          */
207         if (pdev->is_virtfn) {
208                 if (pci_physfn(pdev)->pri_enabled)
209                         return 0;
210                 return -EINVAL;
211         }
212


If we try to enable PRI for VF without first enabling it in PF it will fail right?

Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
AMD v2 page table -OR- nested domain) it will fail right?



-Vasant

