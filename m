Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4031D432D
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599060; cv=fail; b=FyJa0oUYuSkFRz1/NXF5ckmKsQESG51deM0BDmk0wIFecMlehYPBGYkC+yNk8SUC06AUo2+/xvfbH7d4o6rD43Gdtycu6joLXHqoJLqsUBQmy9LUAdyRDTI6Pz0TrZIEHnvfexsJjBOlGG39knLW7gfLcjUZ2gWkO2Ump6KS5kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599060; c=relaxed/simple;
	bh=cw0M+pkM3Bwr9S+Ifi4q3PiHxYKPpCLqT5YdCD4xMHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TEZFEECwzXNvClbRGe8dQPxtsiFT2PGudHKlRfreUZHhbSfPdGnTTedu58WPqzGSrVvXwV6igG5tRmmF/ApKDxHLateVuc5Z4SdODv5VvJlponS41qAKnQW3dHs5EbZL+mttdHs97wF3B5Kb2pp3TsUnJIYxR3zc4tr96ahwcpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJWQ+N21; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJWQ+N21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+hqDMhfGVmqA0IpXnu6eKlNkhQ9LKjAnWEiM5Btw+a8HZ9aeUFZcb0UbHVe6yGvV8UaVtMsLFTMWbgjQQD+h3oiKoCky0IYGtahHboceYVZAteEw1cdODr4A5k9Knn2xxOzVenMoIL5nyhCuwz1HFvxxA+0cSXwRRomGqhsKrygyYxr5bNxZRS1LQJOjY1ATlGg81DnEryIes20mxLtVNrfWewt46rWRBd9lgKvgwbMXn6xhlbogxiir93xkOic8fnBLYj2SdsVdQwzQUPoyqmKuizOfkZ/8VMklT13fSRMeXOoaNK6bPiW0VO0VOztPOrN4zYbrPHAlWOh4vRfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/7IldB1PEEx94i0ELJ8IjiJ1AtA0b4oyu84aQggWH4=;
 b=tdYBl7VvWjUgELQhK9tS6q2Ka9LVsyitBSp1g4EVN2QxwlhAQv4m8saGJBPi4tgwhNhSxpahjIFGDmC/zICoKFDg78SeMFKtiOZmXz1DUd9GS5bqgB15arPrJJsjcb5FlQ+HIB5Ou/tNERaeq/gfRiFYXU/Ethp1tJWUYXiIPUMIaGWtogyxAYuRerIVgYTbguQmSCM1VUuM6v+mu9ZyuQeoeF0FJbB+xCwydhYRA73P0vofeID39BNXsvp9cAyTzzZJEaimzJdtLHlFbiK1L4WYBf9oFGUaP4NrBZXMeWG8XB8+dwbi4iu+yidGPaQ+r3tLu6y+IVodv57fDhFhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/7IldB1PEEx94i0ELJ8IjiJ1AtA0b4oyu84aQggWH4=;
 b=MJWQ+N21o4r8C6BWTlIKEBGzcylwUWajmEptLKPjF3Ci5ZP8s1OwlGk5KW8wN4K9zafIxoGKQH+RDa0VB84cD06zHNLN4eGO0hDDObLS/1Pzww/qtfK2pG1aie5DbdxwrMb6nekAIJRWy/o4g1mcEzeP/vjMm+OVexgXujkrJ1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 06:24:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 06:24:13 +0000
Message-ID: <ddb0fd72-41a6-47b1-80f2-b336365a75d4@amd.com>
Date: Wed, 7 May 2025 11:54:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Add efr[HATS] max v1 page table level
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
 suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <e11bcff900090636a547f03c77baeb35b43234f7.1745389415.git.Ankit.Soni@amd.com>
 <252eb71c-9913-4199-8645-59d8a7513b10@amd.com>
 <20250506152755.GK2260621@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250506152755.GK2260621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 7467f599-9bbf-44fd-ccf3-08dd8d2fc8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFBcy9XTHBqRVJuT05vTURGaUdMZnRFNGhnOC9KcUJ5cTVodDVaMlovWEFl?=
 =?utf-8?B?N2xmNXFvcDdOZHN1dWVnOVozT1JSWFlsdHA0SkxBZC9JWmcxUWlkZVZEajI1?=
 =?utf-8?B?LzdaMlplYk94bm9Pdnk1S2N2WVZRNEZiQ1g1QjVpTVFpUVhERXl0SlNoS0xt?=
 =?utf-8?B?VTI5M0o1VERMdVNnM1pjNWhUUHorUG90elZtbnR3c3BTUHhlbENxUHZTQkho?=
 =?utf-8?B?UElKUVE2SUVQNUhXeWZLZUUyUzhsOXo1aTJ2QVliaXZOWmlWR3JvN3lBVWNB?=
 =?utf-8?B?MmlISkhqUU9QRzVqZXNwUkJtSEhvd3IrWVF6ajBUazk3eTRwWTY2UVZ6NnNW?=
 =?utf-8?B?dlZlNUFzb01ncGJsbitEVDkxeHF4YW1SdXR6enEzbFZ4NThmSFZuc3Q5MElL?=
 =?utf-8?B?V1BiME1KOEt6RzhSdDNHTDAxZnlacU5EUExzRzdmK2d4K05kcDRBSlRMR2VK?=
 =?utf-8?B?d0JIUjhzdTh2NmpLcDgzcFlGUjFPT0N1eVlnTFVFSXI4c2JXdHBEcTRDZENo?=
 =?utf-8?B?NVdGNW1HR3RuWEYvY0trYkFoUFFIcDJ5dFFRQlN1SjR4akdLNEl2Q3NhRGt4?=
 =?utf-8?B?NWdBWVVmdUYxUzhyM0hSaXZTNW5GUEh3cEVPN0ltMytwK1RsYzRTSnFXT1Q1?=
 =?utf-8?B?OERJRXNJNm9zSzVoUlJhNHg1WVBLWWhxQUR5N0tyNnNHd1NUV2NyRktROFVr?=
 =?utf-8?B?WUpiMWJZOHhOMWVKOEt3R1d6SVpBdXNqT0tCZmxDZDRRZFd3dDJudEI4Rk9S?=
 =?utf-8?B?RWtFZFU3VUFqMkVGeVMzWFNwVDRsZ294aGNjTDUxdmxGL0p4VUEyS2gyaXlP?=
 =?utf-8?B?YWhZa0gzQzJKTWpieUgvcFdCQTFJSm9iWDN5Mk9QTWdqODJRNlF3TmlyVHpC?=
 =?utf-8?B?djE2Wms1N05OMXZsa1hyZmF1OVlVOElTWEZZRUh1eEFQQ2p3czZLbHU4UE5H?=
 =?utf-8?B?MTR5RDduT0FTcUpkNmc2M2tmT2k3WUsxQ2poOVdlTTRnL3UvZ1RNWjM5d3d2?=
 =?utf-8?B?RmpnYUZENkdTL2hMYnZxeGpLL3EzdEFqS2VwcE1xSXRIQVkwYVI3MHZ2UmE0?=
 =?utf-8?B?ZzNrY24xN1pxc2xwcTUyWEtHbWJsby9mVVpINGpOd1FKUjgvYTFtaWlpWFZS?=
 =?utf-8?B?YVFvSjdxamhoOHFORk02LzUxRC9hNmFKeFFZTmYvRWhHeDBCSWZaS25iQk1r?=
 =?utf-8?B?SjhyT0RJRW9mMFVnL0ZTdzRTZXdJeU96WHgzZDZTaFl4Skg0dzlCNndKN2VU?=
 =?utf-8?B?akJiQzAzcU16bUZZczQwcEQ0eWhzY0dpVTdVU2duVS8xOXJJNzFROGNVbXZl?=
 =?utf-8?B?OWxFWk1Id05QTnluc2t5TVRVM05pVzRzbys4VithWHNvT3hxRzVhWjFuNXc0?=
 =?utf-8?B?Z1JteDdoeEJ0M29GNzV4YjJWbFIxODBaV1NweElGQ0FxU1EwWWZxQ3QvYTBo?=
 =?utf-8?B?YnV3Nm5LSFMyam5VQk1kdEZlM3FxcWdwV1BFV2xSRjlNYUQzQmlLVmZaRU1i?=
 =?utf-8?B?bXVWS3dkSUNVejVzRzdxTm1NTXV5RmRaOXVIbVZaYjB1VjdNeEh0YmJOTzl2?=
 =?utf-8?B?c0Jra2lUZm5kSjRpVGI0enhOUTYzTlFwaUZneGVkYWR3aFZnQ0VJQmV2QU5F?=
 =?utf-8?B?ZnZpNVlPeUpicUk0elBMMmgvU2NkY1UyUmorNXJGeGNWQWFQZlFxRFJoNVFP?=
 =?utf-8?B?TnN4RVJWOWVWRi8xd1F1NlVmVTU2VHNiM1VUbk5BNk9KOGJReko4TlNXa2s5?=
 =?utf-8?B?MjQvcVRLOFNRbXdoSXl3bFJJcUNKeC9WZTVFenBFdGQ2b0w1ZmtSOCszRHdq?=
 =?utf-8?B?Q0FBdDZIKzZGZVRwSGpNc3lWUHZBQ0M4NS9YKy9BaEhRbER6WmtvOFAxbUQ0?=
 =?utf-8?B?Z1Nic2RuVGF4YlhQR3UxeFlMZFRmMzdmSFFOWG0vKzE0SUZlNnFQOFp1MmNJ?=
 =?utf-8?Q?HLEePxkb4AI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RoQjMzRUlqVGRkN0ZNdkc5ejJNdEJOa2srQ3VnWUhtU1haeHV1SkdTdEM4?=
 =?utf-8?B?aHpOZzZNaE54TzVIMS9xQlZFVzNEWENNQUZ0SExNYkFORG9vQzllQ2liNHAv?=
 =?utf-8?B?alIvRWxRUFk2OXhPcHY2NGVTUU55VHpQdGxZejBaUlJqcVgxNXpPRjdSdjZa?=
 =?utf-8?B?dVZwdjdoVDB5aWdSUmJkZzhQcHBDQTFUaXNjSWFlbFhKQk41c2RRaUkzWExo?=
 =?utf-8?B?d2JIRVY2aWRDRjlKakErQnZzeVRnVVpYQnFleGFmNFJLYWJCZVlsSXNXdVRk?=
 =?utf-8?B?R0xYVkcyQ25Tbk93UElBdjlOYTByZ091QUltWUpJaDlDVkJoczhQamg0Ujh5?=
 =?utf-8?B?b1VmSXUwWDNvL2N6QThnUU1vRloyZkEzV2VCa3h3WWFrVjA0bFBUNnFDNDFC?=
 =?utf-8?B?eGhUOGpwNzJ3TTZWSThqejIzSWF6V1BtK3BsOFowNEJuSGZRSU96RFA2blE4?=
 =?utf-8?B?RjZnMVlPalFpbVdJYVRuYWhScTdwL294UFFMSmdyaHVWdlpIbk83MWhWVVBk?=
 =?utf-8?B?dFN0TmZwTjVyNWRFUW10blplSnBvZnpwMXgzd0h6WVhySTdacXJqSkNJNVl5?=
 =?utf-8?B?bFM4dWR6REZmSGFPcysyQWZUbkpsTEhick5HdlRrV0MwQzlrUk83OFUycWRj?=
 =?utf-8?B?R0lQbk5GdFNDMktEMHU5VXhWZXcwcCtURjZFWUVucXhPUGtzSUJVSndwbjF3?=
 =?utf-8?B?aSs3VWF3SndJZGsrUEZVcStPK2xwSFV3MTlBVnpOVWpGVTNMZUQrV0ZHdmNC?=
 =?utf-8?B?L2xXbVFBMjZiTWppVHJoMHFHMEdoN0FyTjYyVzdTVVc5TFI1ejlIZ1lCVXZ4?=
 =?utf-8?B?UkhrdXJ6M2RZUDhBR2FNMVhYM0VNckRaTDYwY2xoZXpmWmd1Z29Jam5nS1FD?=
 =?utf-8?B?UmhCcTFxenFvb3Vkak9MMWJycVVJbmNYdWtjZFlPa0hKVnlNUzJnMFVjNk1V?=
 =?utf-8?B?ZUtZaFh6VlhaREozZ0VQc0NqQmFsVG1vZVhLeXc2UTFZdldLNVpZbVlsVHBw?=
 =?utf-8?B?aXBBSUpQcS9QemQ1MDloR0NrVVN1MEJhc2MrQTZWQmsrdzRLTDFyQXQzNFhz?=
 =?utf-8?B?ZUhPLzg0dnhSMjIxeEFjQXFubDdBRmlqaC9zYVdoQmN3WVZzQ24vZkdic0s2?=
 =?utf-8?B?T0JaeWJvMmpQaGY1QzNLd0ZIYU5IWGlyaUV6akFvSXI3UWlCRFoxZzh5dFhj?=
 =?utf-8?B?SU53NFRETjAwakJnbkc2SlVwMzd0dU16LzAwZjQxeDZmYzZZT2lwWEQzK1Qv?=
 =?utf-8?B?S3BMQ3Q5U3o2YVB1TDFPZzh4dlA3bHBZbWhSOVpGRzBENnNzVzF5NXdGRkQ3?=
 =?utf-8?B?NVYyRm1xMVVIWi93RUU2NlpHUHdaamVOMDRENkc0cUlNRFEvZXdGWEZhWjZt?=
 =?utf-8?B?V2NSSC9SKzEzd2ViQXVONVBuTXBhaGpZQWJkV3pJSHI5N1NTT01iWWI2WFZq?=
 =?utf-8?B?QTJQTHo5S1JQRDRiVUNpM3ZwK0h3TXNKbW9xYUtBVE5Sbk5Pb3h6aVJjTjd2?=
 =?utf-8?B?VkQvK2ppakcyRWZiaUtIbm1JRHh2Q3l1OUV3dk8zUHhTejBneCtSTWlzSVlX?=
 =?utf-8?B?cGVRUlRPRTJzNjFTR3NVWmQzeGxlOUdVV1FJZ01ZVGo2RTJBQ1FkN2hGSlgr?=
 =?utf-8?B?NUw4WFFWYmgyb3RyN2N4R2gvdEhIRXpEeUxtdm1LUGxEODZUZWJvUnNBeHho?=
 =?utf-8?B?djgxK3J3bldTaDl0bWxWMlFKamJ1akFLdDRoZnpSZVhOSzdnNE1laTIwSW5M?=
 =?utf-8?B?aU45aWFFR1MzUmxPN0xGRDJQSG1WcGdwc2VYNGJTUWdoS3cxZkVldFFxcWxh?=
 =?utf-8?B?N05sNVhkQXZrMEZqVnpMTzgyUmNwdUw2UXRNaFdRZlJ6cTBEOUhhNDNweWhY?=
 =?utf-8?B?alRxNWpBc2dGUmlEbnVVejdhMXdVWVczNTV2VjVhRjdEeUdweEVwZG5sbnJv?=
 =?utf-8?B?UmVDc01MTGh5U3YzaU9jcHFKYjZWbDV4TWJyQTE3bnpDMkJWWVlTY2w5MEpz?=
 =?utf-8?B?dTFPV3FDemNScFV5NENQeDhNTG1rRlAxd1Q2UTg5SWZrY3lGcENuWG03OWI5?=
 =?utf-8?B?ei84ZWl0UTExWUd3TDFUdXB2d3hUellmaFZWWkllWWVzQTlOOVVEclI0aGdN?=
 =?utf-8?Q?C4OxzS3C01XL21ipAfWvbEd9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7467f599-9bbf-44fd-ccf3-08dd8d2fc8f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:24:13.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVtjZ1It+qIex88R/C3ImFHEIQOvJTYw9t4TL3lAukpk1vnhK0nZMgaFaKeye7O1tU3iPYc7lU8tJzRHqu+JPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744



On 5/6/2025 8:57 PM, Jason Gunthorpe wrote:
> On Wed, Apr 30, 2025 at 05:27:10PM +0530, Vasant Hegde wrote:
>>> +	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
>>> +	if (efr_hats != 0x3) {
>>> +		/*
>>> +		 * efr[HATS] bits specify the maximum host translation level
>>> +		 * supported, with LEVEL 4 being initial max level.
>>> +		 */
>>> +		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
>>> +	} else {
>>> +		pr_warn_once("Disable host address translation due to invalid max level (%#x).\n",
>>
>> s/invalid max level/invalid translation level/
> 
> This should have a FW_BUG annotation too?

Ack. We can add FW_BUG.

-Vasant

