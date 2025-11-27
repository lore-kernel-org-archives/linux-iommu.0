Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76347DF49
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764220538; cv=fail; b=OkJUnNN5y2iVYYp+qpbBI/wwlrwcW5UU8y6/aDrnpepsj5r7vfL/w5HdJgx2eq4Aay1iQJ4xfzWbwgkMbeFwuKl7N23Z0fGlbjAgVnGMrokKGaH6w6HD2Lq+1wiuifG7srALFMwCKX+0qH/lOv3zNAs0CoQYJFljICDencMhpPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764220538; c=relaxed/simple;
	bh=x6PUBtpgqXKSURYGQPDWTgdGkk83GNUMo8Z0t+tTbP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQr+0FtJjdvS8vjuTbv9rNBUndixXXuD/dK8lSfJ2f+9VyBg71sUQg/ZGTKDOVC7p700YJGoBEC7hpv9qRJAhhB1en5Nd7M5NeRsg/xbFynyncPnl1F3LlYPWLz3ABbCA4+NbuvGhtUlxIC3CKHveI4416KSj32CrYlM5lm96aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IbYYw4ra; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IbYYw4ra"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoHHsvi7/7FIzHeIoO9gAPoZ6QC/p6+ibnVtIiIiKditgSkTARX89JtEs3Xc+3RtDzCIpLtknVowlxSa6zK9xHRQUbQcMResxinh/+kOYAClWEJAEhxB0dbb2ZTs8en3ViYUS3rIOv2Zy3Y9nGiwbag0fdGuKfVlW3vovJDQ46VaeI8zssU4RjQkDmatxVYvVdEQq/N28IunN7aQQtcCzEz/INQtXJRGU3QlZmW2TuT9MkwKik0u1gF9ap4LjiDXZVZs3DchtN2vob82r5qjhEuzClXD9lVfMMgSEChb+vUIb7BejKxgUj8BWI/RMP/DNe4eKn3kgbxKY0w6vefISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzMpnQxYWDzLVQQoapAdayEnJzs/frcnch18ufFqdTU=;
 b=NepUXPXUA/mKsmFwqaThys6+0feunQpwp3p1Yp6xYUYGCaxLxsbcQmsvVeVLEU8Geam5W7yQZqnTIFgrhJuVf6w3KuqpqmxzUM7Haa6J2jHILLmu/FjwDGNuwYSXt1bDuc8mm3sxaOSbRDwMoMmiSGCWlZpGaAxwtMn2F8lcBgXnzvTQKwpQG0zQ6+Ya4EffnjdnlhCFeYY0mBriKL8mwmmVlUNfJ9STNzvGDCRoMpSZ3xz5Vw5Q1HzmH4Tjg5LvMXRcqzChEGaJZkCBCUGJSgUlGGovC9JE4IAEV9mXFGSoN5A45ljXVtz8VffTTVkYJh+kOH+VdTakfUmZpQhzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzMpnQxYWDzLVQQoapAdayEnJzs/frcnch18ufFqdTU=;
 b=IbYYw4racZ+8EtWpi2+6llBnm86lFh6YmUqE6pl/5Dq1pQrRHJHSiBbHlYmaIS6UzD5xtxMz3bJQaLbVeILRWaDhhn21ZGLkluQPgIvTyXSbboExoA4S9/5PGhtUWtF4eOj9/Zm3WTou+OSmaenpNWve7+cohHG/Nm24NCmAnc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 05:15:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 05:15:34 +0000
Message-ID: <499db877-2587-46cf-96cc-486ec66db3df@amd.com>
Date: Thu, 27 Nov 2025 10:45:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
To: Borislav Petkov <bp@alien8.de>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126160031.GGaSckH3SHrC8ckPa7@fat_crate.local>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251126160031.GGaSckH3SHrC8ckPa7@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 7387718b-b1ae-4c1c-d197-08de2d73fe55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXY2Q3Y0dXB5a0FvQkdRVng0K2VLZFloaWlnaW9tTDUyVmsvVU12Vlk3aFJM?=
 =?utf-8?B?ZEtCVmZxcVNTM1g2cG4zTlJoRGdzM0RZam91bkJXdTY3TnI2UlhGbUVjb1d2?=
 =?utf-8?B?Wjd1MTNDbnZ5ak9zY2ZCTVBaeVNaYkFNeDBmQnJhd0ZuenVxeHZzM1lEaU55?=
 =?utf-8?B?Q2FPMWxCRitoMVJ4UTFVZHRhbEs5YzBEcGt5SnF5ZnhtcmlhOHFndUJSLzk4?=
 =?utf-8?B?NW8rd3VmMFJuaXNjbndnMGlKTEtkWkNrQUU5dmQveTRBQzAzejdLeFJ2YmR2?=
 =?utf-8?B?N1FDUlVBaGJBQldjUjY5Y1kvbUVLM09KUVhQcHVJOWhEL1QyOXdNR2IxNlZR?=
 =?utf-8?B?a0M3czY0TzZFVFBXRlhYYURwbDNHdHdDS2JOczd5TCtvbTNwVlRDZGhtWW5G?=
 =?utf-8?B?eExDNlBlQ0ZOYXZCZU9PWmxyUEVZMkNUTzl5QzBYVGNEZ1NQMUJPSVFUYWlr?=
 =?utf-8?B?MVJjR1FWTXR3VFBHd0FCaFo4Z1JLWUovNGNCd1BkMGlYT2Z5MFBBejNFRFk5?=
 =?utf-8?B?NFByMUVhVktRaXNvUVlYa2VQZ25xd2pqT2VjUlRtVlg1alk2MkQxKzl3MDNh?=
 =?utf-8?B?NEVWdFB0L25zd2JPNkZMRWdpK1VtNWU2dFVwMTdCamFVRzNjdUtzY0lnZGlZ?=
 =?utf-8?B?QU9zdzRpSCtIUGFwbVlJNzVRVzVSYXpoekMrL3MxSDcya1dTQnBOSTRKTU41?=
 =?utf-8?B?Tmp6akY4VVRNdE03aWRSOERPa2QzS1F4RGZONkVIVHlUNVFsVnRFR013RUM1?=
 =?utf-8?B?NVRVdWtBVGlsdGlIakFxNVFDMUxHdnJWZDNoS3F6UFFQNVhDQ09XM3Y4VS9i?=
 =?utf-8?B?WFhNWW44cFQydWJqYkRoL2VXODBpWWRCQmZaenRZazVFaENUZTBjYjBYV3Jq?=
 =?utf-8?B?ZXBDMWlmc3hEZjJQWUhQQXZQbWU3cCtOemU4TXE4TUYvK0tHQW9HYURWTU04?=
 =?utf-8?B?T1JPNXE1aDNrbEF1alA5MkZNZUd3WHVsY3p0aVVYVmE4SjFtSjNNQXpnekg5?=
 =?utf-8?B?UEhnMXlHcUdncXd4c1NCOWdzL1kwS0NseUM2d1FxcnY4TGFMTWZuNzZXMElu?=
 =?utf-8?B?akVEWSt1d0xTdnM5dEZGcXNYVmJxTDRhbEIrUnkzU3ZVTVZrbTdXelRtNmhI?=
 =?utf-8?B?WGg3ZFFmNFRrUkNRZ2JGWjZieFFBVWVpb0d4M0RDMFNUY1FyeGRtRW5IT3Bq?=
 =?utf-8?B?WDRGNXlSQy93bE96anUzQXlhT0RVS2JZRi93UXpteVdRdmp1TnpwcEtpWEVq?=
 =?utf-8?B?bGIrZWZvR2dzemdLUkZyYUxLdjVZNGtmc04ydzBlOU1GdllLZ1grVkFCQ1BQ?=
 =?utf-8?B?N2Y0RVJHWWJvM1FuSi82TnFqd1VqK3MvTGRoVGs3WUlJeHFkR1pBUU15Z1Zy?=
 =?utf-8?B?QUxNYmdoQ29WWHdQQ3B6WmlhR2tUYTVJY0dRckFRam1vbk55REx6MW9RelZN?=
 =?utf-8?B?U3pubGkrVklFcmh4RzFVemRMNGFYZkhQc1ZQSy9TMXNwbW5EMEVrOFFzeVlF?=
 =?utf-8?B?QlA1OEYxZzhMaFcyUHQxNGZGeDQzL2Zsd1VJSzFjdys0SGpxMnRqVlFEVTZ5?=
 =?utf-8?B?ekFDZjJFZnFLNDBwSlBzaFl0TjlDYmUwcTZUN2dUK2cyTUYvb2hYSkQ5dnVZ?=
 =?utf-8?B?WTdESUwxclYwQXhsWVh6MXAyeG9JTHZOOE9SNHpHZjlRV3lKNitJRTFCTWpW?=
 =?utf-8?B?T3ZvVkNrT1A3NDgvUVJIUWZNVGhqTHl6STUrZThMR2p1ZjJVZjVKUHYxZ05W?=
 =?utf-8?B?SkZEcTJlSkxVaUlCU3Rxa3NzcEIyOVdFSHBYbEhRR3dwWFJZUUdKa1VFRnpt?=
 =?utf-8?B?YnV0UnpORnBjUk9KZ0J0SEZMWVo4c0ttTEV0cGordnllTDNkNFF3blkyR1dV?=
 =?utf-8?B?ZDY4TkFPV0dEMjZWb3pRS3hkdVErRUl3NWNzcm5QT2t4cElBVExwRnRNdGNP?=
 =?utf-8?Q?Eqb3OISvjlp5IKeqGsTOvS0XA1Lzj2k3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWVJRUJGRHZpRUZBem1CZTN2MSt6THJyWmZLd2hIQnY0d25YZWJOazFBTGNN?=
 =?utf-8?B?cHZyd3YvZ2ZKTWhPRE9sSXF4SlppSGFzcXVhWHFQRzZteXc1bWtqbWtsMjZD?=
 =?utf-8?B?YXduYVFrY3VVeUZYaFhodnU1b3VETWJ2ZnBuejRFSHJqMnF2R1grSWI2MTYr?=
 =?utf-8?B?alFZallRalhST1Yvc2Y4SC8vbUYza25JOTNRZU4zRy9pUU5aeVBxanpnREp1?=
 =?utf-8?B?NWpEekJsM0ZkSVczZFQrMlF3TThpb3laWjFXVHBVTzhqVEZHNjR4YVd2NVBF?=
 =?utf-8?B?MVVRMmR3SGUzQmVrcEFMaVN4MytNaWx0R0ovYTV4R3h5SmYwdkUyYkpHUlNx?=
 =?utf-8?B?QTN2bjVyOFRsd2N4TFB2MWhOMkVvVGYrMC80a2NSeW93dWhoM1k4VnhROS9i?=
 =?utf-8?B?dFpUZ0hLcVRPaUJXbTJRNGpjL094SzVmeFFMb3htc2lLampySjNJWEdsQTBM?=
 =?utf-8?B?KzcwZmlqU0F6OGk1VDV1bHZnWkhnZ3A2a0dkRitURGpVcGVCdDYxUVVndWlM?=
 =?utf-8?B?S2pSOXo5SlRTZVJPT045QnQzdzdUN1dzSnkvWlNRY3o1b2NvTzFOTmxwZ2g1?=
 =?utf-8?B?bG1Zb1V5QXpnUkFmWHdMR1NOa1h0eGlLMFcxandIWXhsb2c0bVRrd2hvTERK?=
 =?utf-8?B?aDA3am5naGVKUVZibjB6R0o4Q2VnYUNqclRwUy85cHAyYnJGVVB2ZUpRaG1J?=
 =?utf-8?B?R1NPdzFYNUowb3lRL2pCd205UHJHUlpoT2cvVDNZaG9HZlBNazl3N0kzUjc5?=
 =?utf-8?B?WkRFc0dOeXNFTEhEa1Vsb2hPNkVucEdkeW1zNGZiR3VCZE5IWmNkM1hoSy9t?=
 =?utf-8?B?VXlxSWNGRUo0Y1ZrSlV3ZEVXVHFGb3F4akdGMEdCS0dxaUo3RytBRmd1ZlRk?=
 =?utf-8?B?VzVsVTY3ZWllTUJBKzI1UzV6b1QvWmUwazZBcHRKdmhoeHF3UmYvYWVkNjZO?=
 =?utf-8?B?Y2ZWeE5LdTZiZFNNUDc4Z3NkZksxSXZSQVBYRGsrUUc4bHNNakd4ZzVUOXBW?=
 =?utf-8?B?REc0TlBpU0xLdXpNb2FDdnhDcEg1K0REUldMajBWTnY1TkQweDNhY0wwYkJS?=
 =?utf-8?B?bysyelQ1WDh5UWk2cXY4VkpUdGVlZjZOaUxnMkR0dEo5TnRpVlI2bFRDb1Vp?=
 =?utf-8?B?eU9rS3kzWk45djViU0tlblpCTEM2TUk3d3AwTDVrbm8wRFVhaWw2bFF2bmNP?=
 =?utf-8?B?d2l6RFFIbjRJdmI4WHhXYTlJazU4MWc4NVpvNDlxaGJNR2R2UkZ1MXF2c2VW?=
 =?utf-8?B?UzRzekNlQUwvUnlCWTYxRk56RVFqRTNFYnJYYXlDVzdoRGx3S0swUDlkaE9m?=
 =?utf-8?B?VU5hUHJqdnV4T0NCWjBka1BlWkdnVEs3dFFXZ2NCYzJqdEpPNmxua2Z2SHhR?=
 =?utf-8?B?RDdrRWxJTS9obGh2Q2VXZHh3N0Y5emJQcHZnSUdYOUU3OXRyQWJjdUROYis3?=
 =?utf-8?B?TmFSWjRIZDJiTlh5MWlXR05URzk2amlQMHhROXUvT1hFYUhvZmM1WEJHazhI?=
 =?utf-8?B?cExYY3RsZ3pjelNVM1YzdGxsdkdzVHFkb3N3ajJtWWIrVnB2LzBvb0NkZnFY?=
 =?utf-8?B?YW1FLzhLcU5MM2swb3FNa1lRMkRxRXA0cmNMTTJFN2krVjlJVWl3NXRlM3F6?=
 =?utf-8?B?Y3M3bXFBK2taMzloQmRsakJpRWxMclZmeEtjYTR5N2p1VEw2ZHZIUW1xL3kx?=
 =?utf-8?B?RWlHbnVMSUE1eVpObkRtTENvMWkwdklBa2FNUGtBR2hvZk1kYjlyeERzRzJa?=
 =?utf-8?B?aFdoOW9hZmNvanVKc1Q4RmVCWkpWUlQ2SFdKMkxRN3FNcy9QdkpITDFOK29x?=
 =?utf-8?B?M3djbzBFeEE1YnZNMUNPbGltSUxZV0I3ZHhXOTFnT1kzbzQyMUJuTHVHaGdu?=
 =?utf-8?B?MmQ0b0luTWh0dVhhQ01CUFlXREJKclJvQXd4KzNjc3J6RjdvQkF2dEVjcXJy?=
 =?utf-8?B?Sm9EM0ZvTDB1TEJnbTFOL2dFUlFIWXJnbkFVbDlGSWlQckc4SWVIMkNzQkln?=
 =?utf-8?B?WldDNU5SWU01L1BPWkVPY0k1UmllaWdsb1ZER3daYk1wc1ZLWDR2V1VuakUr?=
 =?utf-8?B?Vm10ZUJXY0FiMWIwSVBqSTRod3NtZVZ2VzFLMWZiT0U5M1k5cFZBeVc4SStX?=
 =?utf-8?Q?sHSZJ9JeUBw+wcBuMwbWvUzd1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7387718b-b1ae-4c1c-d197-08de2d73fe55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 05:15:34.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4GfIqQtPo3TJwWvVCLAYsnrTEMVDTViH5jA5VWUbIy7dKECHdS7UwduPP7uPZCryyhDBGIvMEefCHXUdNknxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

Hi Boris,

On 11/26/2025 9:30 PM, Borislav Petkov wrote:
> + Vasant.
> 
> On Wed, Nov 26, 2025 at 03:32:19PM +0100, Borislav Petkov wrote:
>> Hi,
>>
>> this is latest Linus + latest tip/master. Box is Zen3. CCing AMD IOMMU folks
>> because the backtrace points to it.

I have tried tip/master on my Zen3 and I didn't hit this issue. Can you pass
your config file?

We haven't touched that code path recently and generally it should work fine. At
least we shouldn't hit issues under normal condition.

Having said that recently we observed that under really stressed environment we
hit softlock in the culprit code path. We are working on moving wait_on_sem()
out of spinlock.


-Vasant


