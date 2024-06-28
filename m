Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2525634
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596978; cv=fail; b=QYL1tm9FugItUi9hsNrG6ThfgNT68h9wBDznthODq5SW/mX89M1lUMKONPezC6rdpkUN/FS7HmEwijJUzI8j9hk1FdZKHagf1k7MsVx2CuzI3mFQpDoVu8LcPonEggoB6OyKMYF89qtFFpqCUkGkdaMi6Qaw7KYeJznqXoFoYPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596978; c=relaxed/simple;
	bh=fKIfdBCy5vWxsVnE2LLETGh0CcxYN+H6zgBRcK0X+vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyswPyPWX1Y/8OociWWXbRQ83aT8hQ3Opchca0GfNnizASPL/Dw3mMbVAwXuuIuxAxAlfJ//Q9KCww9lWBgCBd2QpRjzy6Ozb4R1sYi1AFo5V1NcnjsWW73rNngIBeLiap6PNBEpTklvosdYV+ut/tgKZb4QZxXrtvoq3Awz0mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jIexGoQ; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jIexGoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5RxctkXWyM3YxrqLmbXpLOoppoOCeccqBEcT9N29xtdjBHG8xR0fKNCKKdEo1t6+IvEiN8Wgc+IT4h5+9bE9ntDmNup/ZqDL7TW9UYtKg2XzSuFBSCPVfZ9nOSG9xRaMk5FHg4i+lp3of+pFY442meBWP0pOSoM5Jb/pC1xy/0l3v1PgRr7XsmBm9y4ZngaJ6sUiY1yteJJ82XMNI2PriQANo2g8ECXaq5OhQWrfUjkohhs2y9uNqOkp0TjNmTLt86Kyc44+j5CQfA9cYDD3EcJAJ2gLqcRGtGVdNxLLCECeWO5PDNubketXzh3dA9yUiydo0zLtQu0Og1qS1tT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX3EKHix+OrSicHaiG6BB4WnFG6d4C1aFxVSWamM7VY=;
 b=n95aX4xH97zZfmFo3DqETv09xDxTzkc9pEwhQtVfLvbgGPUoLcxlPacKuirTmMwPUbyYICBnYQs7LEDvcug64qMO2kFeE75idScayf04xb8/0lzgHpjMdIVltk2vbSHUcJJHIHgMi6huXvq/maOAvicbfZox31F7pmFR3ZqtKYTFcQWh1YJ47qZdHQI472RlVjPm5xnhtNincOZP82bErc2qTXwLD4p5aVAGxKWIfZrdxnBULPQfkXU3PaknaNLKOvd7Qvno/r+JOhn7DO2ynrvZz6RchXrQF5OhTPg1cMFP1fhLPWY16/mQ70gAQP2l+Vm+8kbq+LTW8Gzt0HEfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX3EKHix+OrSicHaiG6BB4WnFG6d4C1aFxVSWamM7VY=;
 b=4jIexGoQMlkd89Wf+/KYGNZXw1wmxizLl4PuNoaY3NlcjEAWV/9d/svf43dvzZzjis6gwf1rKvv+XdWPKTSIbGhAT8csYBG66RP8qve4YKV1jA2uCCoVASo7QNfobv6yxhwRKmcnpS0wmafR987cE/O/lQ1P6kC+4g5HtjG1rig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Fri, 28 Jun 2024 17:49:31 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 17:49:31 +0000
Message-ID: <26524622-971f-47f5-936e-d0173d342288@amd.com>
Date: Fri, 28 Jun 2024 23:19:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240628130330.GY791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: a009eba8-da59-429f-40c1-08dc979aa9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEF4WjI3WStPeFd5T2Z2eHhnRWxHOU5zYWEwR3ZTTlJXcDUzQ0ErV0VPTzlQ?=
 =?utf-8?B?STNzbllzNVlNYU0xY0I3bXBUZ0hwMEFMTUdSaTZROHdrdFl1d2lFVGhldHRI?=
 =?utf-8?B?ZU1VaTF1d3VMZ0gvS1o3K1NRYkV0azYybFdubThYWmVTc1l3dEJ6WldiL0tq?=
 =?utf-8?B?Mmh3SnJyVkh0ZTNPbE8xYTQya2J2UW1YRnV3aVRxbmJza21mY2dWcDArdSts?=
 =?utf-8?B?MWdWbWFjUHpiai90UGMyTWsxM1BpSkllTHZUV2d3cGppbjhtSWxHd2pFN1ZD?=
 =?utf-8?B?NUM3dTM5czNvaVVxZTFOZHN3cEF5andvbUs3V1ova0hkb05GV3cxTGtCbStN?=
 =?utf-8?B?aGZNQ0tCUjFhcm1taGJFVXdTRnluSmFhWFAyWjBaVnJOMVZ6Vm8zSXZwNkNs?=
 =?utf-8?B?ZmxHMFNCdlRUQXRFbDllb2xsbjkzbkl2WXNLdS9vb0ljSno2RGdGUEFwQTB2?=
 =?utf-8?B?Q1Vhd2x4QTR4NjMzNy8rcHJkSGNwNGp4S2oyYnM2TGM2VjZMWWlGc2NOZTR5?=
 =?utf-8?B?Z3BReW96TGxMZWJvOFNjMU9iTkY3Y29NWVdFQ3drenEwUWFHMFg3VWhlaEY1?=
 =?utf-8?B?NExYVlh5Z3pYdSttYzNPRUFrTjU2VUdHWUppRGQ4alVQM1p6N0Z4SWJGa2I2?=
 =?utf-8?B?dldjdlg2V3dLOTJxdWNmYURDUzA1bElXUHpmZHpPTWZmMldCRGs3THl4ZHdh?=
 =?utf-8?B?RU1UTVBBam94M2JQOGlDS1BVRnF2TVFlS0FPT0oxZ09qd1duTkV3MW8vUFVS?=
 =?utf-8?B?L05YeG91SmpkRTRRSWhoTS9lZ2R6NjNNaHFEY2pSNUJ2S2tVNCtsTFA0TlZN?=
 =?utf-8?B?d2w0citGTDFZKzBJZ1JHQU1GSWdLMi9BUVphL21CdUxNbGNwRFZPVzJwNEF4?=
 =?utf-8?B?cUR1Ky82UCtMMUV4N3hpMzM5TkhZNjd6aDlpeTlac0NLWUMvdm1vWUxnR1NQ?=
 =?utf-8?B?eWZBWmtmM2M5YnNyK1ZGVFk2SDBOUzRlTit2bU5zaDRSVW1LVEsra1FzeDdR?=
 =?utf-8?B?S0h2QnZJOUdmd2grWXBvOFRzSUFxVDdlazMzWCt5b3c3VXM2VUg3c3FXSllv?=
 =?utf-8?B?SWN3SFlXbEE0VVhFV3djMmxjZVBpbHZKb2txbmJyZk8yUHZNV0x1NGxBSzJN?=
 =?utf-8?B?cHg0ekpXVnF1cEJpMTcrcEdVWktZSHc4OU9FckZXdVZnbFlCR25MM3ozZFBO?=
 =?utf-8?B?UTFtZ0VpWnVGM3BvdTVqNzZlMnpuNzFhcko4YXRQTmZreFY3UW1DbkY4YlRP?=
 =?utf-8?B?UWxBZUhBdHR4UUR2d0lxVUtEMXlsT0FJdTY1LzBCOEJVNzVCMlhSTzRQL3du?=
 =?utf-8?B?SU9NMkZwWUlNeVlHNXpGR0dnbTdNYk1xazk0Z0lGNE1HZVNjNEJXa01iVFdy?=
 =?utf-8?B?YkNYQ2hXd3pJbGlzVFl1cmQ3ZlVDOUNHS2RkUHBwUzY1c3NtYzBDTzhENXFu?=
 =?utf-8?B?aDg5Z3JiOG1vMlVsYjJGblMreXVNcDNmZXhIVkE5VG5sbGhXcCt6Z1NUdzFw?=
 =?utf-8?B?TXR5T25rbHBrTk0yUnMraGNJeE9qbFJVTHlxTkJlV3k0Z0pTQ2ZzUVFFUm9N?=
 =?utf-8?B?SDFvdmozZ3V0cW9Zc1g1ZXl1clBRaEROc3NDNDgwVjQ1ZmNmOW0veDRTT0Ny?=
 =?utf-8?B?WTVDT25GeTVRdmgzMlpTOHMwNVJRRlMwVCtwMkR6WlAxU2Y1SjRORE44VUUr?=
 =?utf-8?B?NE5kcisvdVdNdUYwV1VjQ3d6VERHYnJadmUzbG5YQmpTMHpTRlo3YVFJWXF6?=
 =?utf-8?B?cDQ2cE0rNjR1aGk0N29semdFMWhIQnVpNEwzNGpHeEk0UGR5RVVQaXJCVXZi?=
 =?utf-8?B?SGxsc2JkQnBuc0pBN0JNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1BOTHBSNUpIQXNJSXdHQWJrQTdLMEZBQ0FJMVR5a1ZLd001eGtFNXBzaU0v?=
 =?utf-8?B?N2MvUEFVWkNwbllKL0t6M1NLbDhDUEFERUdNbTdDTXdJeU4zS1VUaXRvcHAz?=
 =?utf-8?B?cEtjU0I1ME5TalRYTTNjYUw0UnZMRlhIWUMrSktxcFRsYjhFT3NGL01VYWlX?=
 =?utf-8?B?c2VBZGJwaVNKOWx1S0tBZUl3d3NnaVQwemp0TGNPRGJ5T2NzVnVZVXl1YmEz?=
 =?utf-8?B?Tnd1b3ZqYmlrUnI1NU94TUdnYW9OeVZPUzFHOGg5TzllQzhmb1lXOWtUVXBS?=
 =?utf-8?B?Y01Rb1B2M1BkSXovdUJCakNRSGZzVmxMNDJrLzF1WFhlMk9UdjA5SXVCYzRP?=
 =?utf-8?B?cjFXMS9YOERFUTFFSG9zekl4dVdROVhuNVUwYUdiSjg0bTJhS2lGTnhpSU0w?=
 =?utf-8?B?TVkrVXpvVXZOL2YrQUpyK1lEYUpHRW9SL0tCZnFZaHFiUGlrNVpVekhTQ091?=
 =?utf-8?B?VDZsdGc4a2tNdkR4V1RPblFEMGhoUlVONWJLUE8wb2F0T1IxNHBCVnU1YzZ0?=
 =?utf-8?B?YjBjT3ZjWVJua0JVVStoRTRmaVFzekg0cjFPaHAxQ3BuMDY1b3ZCM1BsUG82?=
 =?utf-8?B?bXZmZ1NEeFJlT2MrTm16V2RKVlNvMVVHR0N5MXRsNVZiOFlXcjN5dWlQWG5m?=
 =?utf-8?B?blVMWUdtUG52U2tyUy8ySU04R0JKeWVZWWp3RzBNdElyeVZIOUhoZElUT2w2?=
 =?utf-8?B?bmNpQjdscHlxTGdYcmZNYTdmT2VycC9FejdDbDhoUXNVRmJidU4xaTVxdlN3?=
 =?utf-8?B?SGxKaWFDUXZIU2h2K1lzMC9MVk9aMTF5aktSMGdPVlFxSGsyNlZEaWRUZTlh?=
 =?utf-8?B?bDcvNG55ZnZYd09UTzRyYTFHc2YxMlhGVDlhbWQ1QjhOTEUrZFVnaFE4WFlw?=
 =?utf-8?B?Sy9ENG1USjd0czFmMlV5WHhrdHo0THZVOXlVeUprWm9TdjJsVlhlRGtSZzhJ?=
 =?utf-8?B?UzhLc215VGJxSFVXeVM0QmhYa0g3VGc3WVVtN2ZYSDBBNVM2RWlGZTRSODdV?=
 =?utf-8?B?NTZLcVVDVXd2N0dvakJZOFZRNDdpY0NDbVZpTVNEQ2VzejNWRFp0d0V4cXJN?=
 =?utf-8?B?YXVVbDJQVFRNclAwelhaRGtpWXJ0YUgxaXRSZXgzSmlvY2tMVzRqTEtyajlo?=
 =?utf-8?B?LzkzdENUK0gwdTVQdmlOck8yaEwvSE9Qb1NRN2JlZEVEdjRDYmNDbDRqUzV6?=
 =?utf-8?B?RkYyamVJcGxZNzg3YlVSaFdzWUxhRHJEK0pBbmcxY3lIN0xWTnRSUm91Z3hO?=
 =?utf-8?B?aU05TStrMjlNUGwwdU5UY0hLV0NPaGRhR2tKUU9JSitnNnl0M3lOSURZZi9p?=
 =?utf-8?B?bStjczRFaEhXUktBWmgyL3FsdzJSZXpJU014eWN3M3E5dFY4VGIxREoyWC9I?=
 =?utf-8?B?bmh6aEF3alFjRTlGemRTVzhrczV3ZmZ2YWhNZE1wQUdHaGMvTmFhUEJJYTcz?=
 =?utf-8?B?Y0pibDB4RDk5akRFQWVqbkdUTm1nSGZadk05MmtsUTZ6cWoxS1IvTXE2bWdt?=
 =?utf-8?B?RExYOFBSM1dSNjJ5TVUrNWw5VWY3Q0dBbGhrd2tnSURqR3J0K2pHVEJETnNi?=
 =?utf-8?B?MkpMVjJtSitCdkJVaVhwOTRyM0VqSjlpQjdlbGdSTVZ3VThyalBwU2hLenpR?=
 =?utf-8?B?eW5GTUorb2ozenc4UEVpM1pCZitDRkR5bmN4Y3VMOXdvWmxDQ0Z1RkhYL2dR?=
 =?utf-8?B?RjBIQVMzN1RXMmhZQ3lCcjl3VnNXWWM0UCtEWHdRZU4rekNBOS9oWFc5MFlx?=
 =?utf-8?B?TENqWWZLS3VoVHU4TFJzc28xVTRMYXNUbDl6Mk0xVEtZUkc3WmlnRVZvdVBG?=
 =?utf-8?B?N2ErL0MwSzRJTWptSHptSmh4b0M0MjJZUVE0OVhRTHVIZCsrSGg1NWRqaE9J?=
 =?utf-8?B?ZHQ2Wm1UTU91cHN3NE1sVVA1WkRid2tOYW9NOHdFdjBpRGtPc1dHS0c2T0Ri?=
 =?utf-8?B?cGNFWnZXOVVnWDZnQjBjcVVsYlk5ZUFpSzQ0bDNYZTYxbmJCS2xwSmdQSmZF?=
 =?utf-8?B?NnZSaHI3ekdpaFJTeVB3NFZDT1BIR0dkQ0hOczJvZSs0Q3h0V3ArbEI2Q2FH?=
 =?utf-8?B?V21zMUdpSTNVMWZQNGxpV2tjK044SkdRL0xuWjVld1Qwc1d6VVpaclBRcEY1?=
 =?utf-8?Q?OxdFjplfiBQwBzK06I2Gb3ufX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a009eba8-da59-429f-40c1-08dc979aa9f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 17:49:31.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU/bqRCMaP4hN1lvLs+MOm/cfHvgtBoLFveuePhUuT43lEiP0l4kf//NRYxYZyzx6XME6WCt/rimIIt5qLVnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

Hi Jason,

On 6/28/2024 6:33 PM, Jason Gunthorpe wrote:
> On Fri, Jun 28, 2024 at 12:13:43PM +0530, Vasant Hegde wrote:
>> Hi All,
>>
>> We are working on adding domain_alloc_paging() support in AMD driver and came
>> across below issue.
>>
>> BACKGROUND:
>> ============
>> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
>> (guest page table). Only V2 page table supports PASID and PRI features.
>>
>> - With V2 page table we have an aliasing issue. Hence we added
>> per-device-domain-id when domain is configured with v2 page table. See upstream
>> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
>> TLB aliasing issue")
> 
> Yes, but IIRC this is a shortcut to developing a proper packing
> algorithm to optimize the IOTLB. HW like this that has aliasing issues
> needs some more complex SW support to get optimal usage.
> 
> ie you can share DIDs if devices have a logically equivilant GCR3
> table. Optimizing this is a SW problem inside the driver and should
> not leak out to API.

Its not just SW issue. With V1 page table HW supports variable page size. (not
just fixed 4k, 2M and 1G). So in terms of HW cache management, V1 page table is
better.

Another issue is with VFIO device passthrough and mixed device passthrough (few
w/ PASID and few w/o PASID), type of domain we endup allocating is depends on
the order in which VFIO requested for domain allocation. So its not deterministic.

> 
>> With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose best page
>> table based on device capabilities (V2 for PASID capable device and V1 page
>> table for rest of the devices).
> 
> Yes, this is correct.
> 
>> But we would like to continue enforcing V1 page table for UNMANAGED domain. As
>> in terms of IOMMU caching, it performs better than V2 page table.
> 
> We are getting rid of UNMANAGED domains. And we are adding PASID
> support to VFIO.
> 
> There is no reason VFIO should have a V1 domain by default and end up
> with a non-working VFIO PASID API. That doesn't make any sense.
> 
> You need to actually explain when and why you need V1 page table
> support in the VFIO context.

Adding further to above explanation, driver should have enough information to
decide page table type.

> 
>> Also while adding SVA in AMD driver Jason mentioned that we should support PASID
>> with UNMANAGED domain. As I understand currently we don't have this feature in
>> upstream but we would like to support it in future.
> 
> My patch series enables it on SMMUv3 and Intel VT-d already supports
> it. Only AMD is missing the funtionality, which is why I keep asking
> you to structure things properly so it gets it too :)

I have not looked into this series yet. We will look into it after fixing domain
allocation path and few other things.

By the way, can you point me to your series please?

> 
>> Please let us know which one is preferred -OR- is there any other better way to
>> handle this.
> 
> Neither is really going to work. VFIO will have to assume the user
> will want to use the PASID API and will always request a PASID capable
> domain anyhow.

Even to make PASID support with VFIO, some way it should communicate the driver
saying like "I need PASID capable domain". So that driver can allocate with
right page table type.

> 
> We already have a path where the VFIO userspace can request a v1
> domain by using the NESTING_PARENT flags during user domain
> allocation.

That's with domain_alloc_user() API right? As I understand that should work fine
for AMD driver.

> 
> If it is really important and logical we could also add a NO_PASID
> flag to hint to the driver that userspace doesn't want to use PASID in
> combination with this domain. That could also trigger v1.
> 
> But I don't see any option here that doesn't involve userspace itself
> making a request and indicating it wants a degrated VFIO
> functionality.

That's along an option. We can explore it later.

-Vasant

