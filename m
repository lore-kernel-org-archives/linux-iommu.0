Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA91CB320
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023139; cv=fail; b=rrjynF7Ww/7GP4ae9AKwCD9S184wtytBZKlMJtAI7Zey7Mt/DaABZmOv/H0X2LT6cRD96jvA+5Q+rDnnFIrjnD/+KP6b/1bdcba2Xed5p0Imc5JmoFR+gTscmpI8PrePE+VxjQ2wYDb5zh4Oe5YfqpuDPEA5YnnIYIDE3aIwIbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023139; c=relaxed/simple;
	bh=72E6Qyth/kSGyyChu/ubeIDKj44b8Q1PzDwwQ3kR26w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3v50CY2NZzsBTDHRs/lEOLhOrkfowuvEWH5GyMBhVbaKVjN2ESVZukxsUm4fp8PSoAgdpNv+h6QpTsjFSqIQXQr56nuSFFYWUnaeeccR4YbhKU62L3gx9/q0mXjNRpVI3qO63TJlHD45tU8Ax3CpOD2Bg9yrT6gS+ZjVzjOK+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lI3FnnRx; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lI3FnnRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhNKuNzi0SLz5u6l97GFvNPyEUajKkeQZ2LKHLsPdBv1qCf7xFcDuDxbFPRDyZpvT3iq5gLLm7LeiSpQ7B49UlT0iUv0I2gQ0wHZc9kqbeBi3K/MjMM9PE/kCB79TaTu3q27j5h45Ujj2OEEjb11kK3WEmibLUFsQI5e5adfOoBYJ+T3YH2Ct2caG+GfI29hypt/YDPPbm/44y2d1dCDwaJ0KzmTlo+ufG0TTBTv9GTEBJDvpI2FdBHfkqwhG+T4yNtTGyWSAs7R6Gjk2ZRwa0s0dHayTfkk9RN2ZsuiHrpJw6Wz0lNketkRnp/zaHL0LcXnC4yQuEX0I1ipX2WDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg8ABatJODyyXlj9lexn/lKiSW7+cK4IWQIKMcOCfY4=;
 b=DW0+JDIyXs+SyM8xxQP9g14Q89DLHreixTIXFzoHW3Rqd/yxGeGHKyr342X2r5Ae+Tf9rG3UbxQwSiI2prbOYXYytz+rEV5ZsfR7/yteswiPeJmG44B6fFW5GfyZwRm2J19HEoomN6ixH8mCyluSwZQaOb0gCkkYCRfoxjFK0FNUxdckVjdQaQbB4cTsfBwJHOMaBT0N3eJavP4mx3wfNEBGKt6I0CO+3oUJeOnYFNlBzR43nfJtq2C7yZF3U2tz9kDlcvNkz2YygoPo/mxQMHemDNIU8DYwbGbVV/3gq6DR86KVzUO2i66xYBJKY0IX7NAWQiEVBAEOggiZMQr6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg8ABatJODyyXlj9lexn/lKiSW7+cK4IWQIKMcOCfY4=;
 b=lI3FnnRx/9BV3V+N9/t9yxrpLNLWCNI1OI4VC7hc+bpx5ou07jTkBOqZ+kIILrqbKii9+a5wA+AjcqMFJjvIfQfAUbBfkapiqZj/fW0XQA6eBxSD+oteMQmtB4fuFqnwek4gnxhUxg3+VSIXu7NC4GdWu3LzpR53Ku1tEA+Dptw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 09:32:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 09:32:15 +0000
Message-ID: <a0ff60da-a7f9-42db-9942-a7ded659884a@amd.com>
Date: Wed, 7 Aug 2024 15:02:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <2c537d82-c511-4367-8a5c-29122745326d@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2c537d82-c511-4367-8a5c-29122745326d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dca7b07-7631-4e6f-7f93-08dcb6c3d2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFSN1NTV0ZPUFNMdUZTb2RUcWNpNWdJN1JDMWdMbEs0bm1UeCs1N2RLTnlB?=
 =?utf-8?B?c2I5NlFEM0JoNGpWY1JoWjVxS1dGczdibWc3QlUwcmNGVTQ3MzgyRGVKVzRX?=
 =?utf-8?B?V2lieFNFT2NaZjh6NElnSWhiaWM5bUpNdkwrb2VrQzhGbks1SUZRcVFiSGo5?=
 =?utf-8?B?TjgxbFpUL0I5ZHNvS1NieVJveGJaYzJJaTk3bm5ianhrOTNCMnJkbk95RitS?=
 =?utf-8?B?ZFlTbVJZQ29hSGhpODJlWnVETjFrWHUzOVdtcUFJN2xuYWJIdmVydlhxb2U4?=
 =?utf-8?B?WWtONkFuVkNoa3ZVUmdONWkvcWRLL1NnTjA2Y2F1Z0RMNHRNS1JHLzlKQnd2?=
 =?utf-8?B?VXIzUCt6Q3Z2RVZVaUZmNEhhcFU4eGM3YytueS9HVWxIYXlSUm9TVW9OTzIx?=
 =?utf-8?B?TVBjUlNneXk4cFFRYXdXeWw4b1FvMWRBM0xRd3BGUGFIRkUwRHdaWHBPZVY0?=
 =?utf-8?B?NHc0cWUrc0FKbE5BQVdRM29BZWZISzBhbHNuUDhLN3R0RWFmWUNZcFNoNkZt?=
 =?utf-8?B?ZE4xR1oyOEx0aWYwcXQwOTUxdytqVlJGZE1FbnNpYlRocWhTZ1BVT2xweEow?=
 =?utf-8?B?Z3pTakxuZVExa3RBMlAzT28vcmZDUUk5eUNuNm5VQTd1bEpOcU1OZFltVE1Q?=
 =?utf-8?B?WUdwYlNuNm5TU0QrWVBxZE5qS1hUbE5oL3RvVmM5RHRUZTNDQ2pLRE9iWVpM?=
 =?utf-8?B?QmVGU3Nxa0p1OEkyazNrTVdVcWlDZm5oc2hzLzlsdWVaN2pacjdPMHZSTjFF?=
 =?utf-8?B?SzlIOHRuaE9KQWFvc2k3US9hVGhXMzVEZUp4LytzQkVDaW8xWFFMckhKYnM2?=
 =?utf-8?B?Y1pWUmNoeVAyUytUZnhxQmJEbkhDajhFMWRINUVkSHQvM2dKWXk3MndTd2dx?=
 =?utf-8?B?ZWxZTFZWQXd2dy8wWExDYS9EU1N3ZkFIY2ZPUm1CRzEzRGxteVhwSHI1c0RN?=
 =?utf-8?B?Yy9YVkU4SUZJdlA3emdmTEROQU5EVHJ4Ri9wbUpYZzYzaW5vR2dUM214MGp0?=
 =?utf-8?B?dU1ueHhRenF1U0hjK2tuTW9qWW1xNGNPdnh4eXErdWF0MVpheWwwSnFnN2tE?=
 =?utf-8?B?LzhDSXhjVmlvaDY4U3hpRzJqZGM3Yk9IbHlpTFdSMmp5cTc0ZGMvSGxOWE5r?=
 =?utf-8?B?VVN6ZkxMZHJxK0FaZ1NNQ0NqTng2ZzZKcmlCUzcwK0VzOElUeVVwd29VWmRn?=
 =?utf-8?B?SGFSWk5Wbkt2YlRUc1h3OGNDTW9hZVVBcVJXVDBNRVdpTXoweUp5NG5tSEhR?=
 =?utf-8?B?Uk9vSHA5ZjVFSGZWbzc0c1NLTEgwV2dYTStpRlcvdFBySXdqRTJQT3dYVE5H?=
 =?utf-8?B?WmNzMS8wc3hscW9lM2NkaDFwcnFOVXdscnJrK0VvWlBnekNESlI2c1Z6ajRa?=
 =?utf-8?B?LzgyVzVQaHprVUpxeUU3Ry93U09TMS80RGpnT0t4aHVMTWFDeEhGZ2s0Y0Mx?=
 =?utf-8?B?bmpqRzJNejU1Sm1xMUZZWk9VM0RrQUdsL2YvczlwYnJvVkptck5mY21aclJx?=
 =?utf-8?B?b0ZWT1VFZTM2UHJWK1dRVXV3WXRrZGp1U05icXZvVkVuQUcyQVZRaG5XS1dx?=
 =?utf-8?B?bGtmU2U5bnhOaU16VVdFZGRVdGNLRGZGUTIzcjNtelpsYUhqWUVITUNUZWFo?=
 =?utf-8?B?VktRNlJSMUFXb1BPZ0M2NTBtN20rdHB5S1ZlbU9USkVaLzhITFQrOUlka2JC?=
 =?utf-8?B?TDZFWDZFOE9MamE1YmcyTE5uUTlrUGZUSW1KV0dkSjMwWm5NNlBYT2RCM1FY?=
 =?utf-8?B?Y2s2YzdaZVVISkE0OWR2c0tDSEFyc1BoY1d5Vm04ZzI1T0lTby9FcHFqOVZW?=
 =?utf-8?B?U1ZiL3NTeU9kY0FFV0hCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWxlQm92c3AxSFVFL3VBNExpWmZBU2RmWGpuaThkNXo0a0xEUFcxb3V1ZXBM?=
 =?utf-8?B?dWhIbFVFSGVCMlJCQm1JMUlWZjdFS3p6dFR1VUNQYTNPMHJIUFRXa1FjQnFt?=
 =?utf-8?B?aXBacVlQejlodjUvTEVUR1o5cnd3NUMza0d4UFc0V1Y0bWlsUGdTMGlQNm80?=
 =?utf-8?B?eTJoT2w1L3NYR1NlNmNUTmNwUHNPN3psRzZLNHpqT2lkSlBEMURWVnFpZ2Jl?=
 =?utf-8?B?dHFiejQzZnFubmJpcHdnWVNPcVRCV0FCVVRHWE1TTWhGZERsM3BSRkxpcXF4?=
 =?utf-8?B?WFNQeFA2Vmo0bVlQaCt1L2Q3c1kvOW4zTk8yejl5VXFqNHZMRVEzVmgxRDh0?=
 =?utf-8?B?V3N1N1Vvck1hMmtCRDdQcXBNcXRKemNxS2FQcWl0Sng0WENDa1NrVTZBVFhR?=
 =?utf-8?B?NkhSejFYSEVSV2RSb1dhdUIveDBBc3Y4NkFxallIU0t2a2NzQ1RPNUJ1blhM?=
 =?utf-8?B?ZXUyT0VXUmhHQWRLalV5WllSTjE1T1NGR3ZaUWgrUWdNSkNHc3JQS0FpaDVj?=
 =?utf-8?B?UXFQc1lhdlc4b2ZodEVPUnJWQXY1Q2VNRXdmUlhaZUFXMFptY0Ezbk81L1dX?=
 =?utf-8?B?VUlLNXZnVEgxR2h3ZjEvZFRSelExa2J1bjA4ZXFOcm00L0xqMkZ3dGRtaTZj?=
 =?utf-8?B?UFdoRTB6QXY1TW1HSnNYMDMzdHN5ZkJDWjlBZ0lkNHdtVGhRNmxGdmZ2S3ND?=
 =?utf-8?B?VHJrQ3B3QXR4Szk3QnBYT2V1WkNjVFlFYTVERzNrSkFYQjZRelh3VjRDeDBT?=
 =?utf-8?B?OVgySDBJeGFtalFPaTZYTGRHeFJzbTZMVUh5bVRVaFlBbHZUZndkd0ZaMHov?=
 =?utf-8?B?VkNwenl0OWxIRkptY3pJYmpieUpJZUhsV0RqNFk5amhlVkozNU5idnp5WGFZ?=
 =?utf-8?B?d08wTEVWU2RNR09uWVFBbE00K0R6R3dlMFRFTDhXM2ZiUHM4aGo2b1FTcEZj?=
 =?utf-8?B?U3k1UlhFa0M4UGhHMUM4eFBGbC9zajdsY1VqakdwR1IveFVEdmZzSFZnaWFv?=
 =?utf-8?B?TjFlYVRZS3YwWTc1VG1kQW01TXk2RnhhNmYwc090RkNBOGFDVGxqZEhrS0J5?=
 =?utf-8?B?RXdZdTcxb3ZMb2tCM0V3K1E2c0Vpc2VzZGRjSEFWR0laRjNabERWcnZ5SlIv?=
 =?utf-8?B?QUIreDBoVjA4OWpNMWNTbzBveTRrWjdoeE1BdWhjN0tleXpxbUhFNFR3dFNu?=
 =?utf-8?B?T2dVWGlnMW1yMDB2eGZZRkdjdVVLVWZCLzZNK2c4a214Q0FUNFhsVWZlMFlO?=
 =?utf-8?B?OGJmSkxxNlNneE9qNkZrM2cxdnB4U0M2a0dsTHlucEQzdUg4dVM2Y1BVRGpp?=
 =?utf-8?B?L2Y4TU55ZmlNWmIzVEY4NFVzOTdud1EvaFE2RFNSM1ZvWWp2Wi9JQXFJeFZK?=
 =?utf-8?B?UDhwRG1oUVhIUkNiRHc1UldOSXVTeVRQdmYwY215TUk1L2xWck1jMXhVcllV?=
 =?utf-8?B?SHV3elRuTnQ2R0tEUDRXUGtjUzRMWFJ3a2dyTkJDRmxwK3dyZHZYWTNTK3By?=
 =?utf-8?B?OXNDWUMrWnp6YXBzOGk0SU02V2pLa3VYUmlza0F2WEROM1EzUE5LVUx2Z1R3?=
 =?utf-8?B?aWZUZXgvOTBUdjM4cnRxZUl0Vll4bHJlRDZVK04wcXhvY1EwR1BrTStCMmNZ?=
 =?utf-8?B?S2lub3hybW5ISVhaU05yeXNIcm91YXZMNDN5Y3VZTVJ2WmFWK0hrRWNpVkNK?=
 =?utf-8?B?SHFXOFUzWGljb1lCQytQQWdiZDBJQmhYaTE4S09LK0VuaDhZL2ZyajNIUmJi?=
 =?utf-8?B?TmxnUEJYeUxhT3VWaGpuOTJ6VG55YXFONUNyb0cwVlZ5VjVqZjlrQnpSdnBs?=
 =?utf-8?B?Q1FDNnlSNUpTT2RpdEEzanh4bVc4Z3dQSHJtL1MwektMRUdmMnladEZxU2FR?=
 =?utf-8?B?M09ia1IyTEJUSmZJaEptcHdmUE5Cc2VoTWNRK0IzbzM4MUw0WEtMR1lNRUVJ?=
 =?utf-8?B?VThOZ3ZHTkdFRHhGSWxGYjFYRzB1dmNSQVdxUlJTQWVXcGdySkFpWkh2cTFh?=
 =?utf-8?B?OXRtTnBzUjNHOUJBcDNxKzJTSmd0R0tCbDZMeVdNbVZCWHAzc2laRUZKS0Mv?=
 =?utf-8?B?ZklNaCtieHF2cnlyRnZZWTZadWFKMUprKzlCODF0V01rZVlrZUdkVW96blM2?=
 =?utf-8?Q?d0qNRjQSzfEnRU0bURmvzLrAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dca7b07-7631-4e6f-7f93-08dcb6c3d2a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:32:15.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt6Zmf5ILMoO0wiy363fhvDV3gCZeAmNWAhTAZC1Nx1aqs7xkHJX7o+yOZZqBdwizLlQB8WYgGRIlkOj/jr75Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

Hi Baolu,


On 8/7/2024 11:19 AM, Baolu Lu wrote:
> On 2024/8/7 1:32, Jason Gunthorpe wrote:
>> On Tue, Aug 06, 2024 at 08:11:19PM +0530, Vasant Hegde wrote:
>>
>>> I only have issue with allocating right page table for UNMANAGED domain. In this
>>> case just 'dev' param is not sufficient. Ops should send some sort of indication
>>> that its UNMANAGED domain (like its non DMA API domain). Otherwise AMD driver
>>> cannot allocate right page table.
>> Be specific, you mean when VFIO allocates it because VFIO is almost
>> the exclusive user of UNMANAGED domains on x86 hardware.
>>
>>> My understanding is we essentially have two modes for device passthrough.
>>>    1 - Existing interface where vfio driver manages page table (call
>>> iommu_paging_domain_alloc()). No PASID support in this mode.
>>>    With this RFC I am trying to solve this scenario.
>> Honestly I'd prefer you change VFIO type 1 to call domain_alloc_user()
>> instead of hacking domain_alloc_paging().
>>
>> This is a lot more explicit than trying to push new meaning onto
>> UNMANAGED which is trying to get itself removed.
>>
>>>    2 - via iommufd - It will use domain_alloc_user() ops. This is the interface
>>> where we want to support PASID w/ passthrough device.
>>>
>>>     This is where you/Yi suggested to start discussing with Alex on Yi's PASID
>>> support series. I am running behind. I will start looking into Yi's thread soon.
>>>
>>> Is my understanding correct?
>> Broadly, but I'd rather VFIO exclusively use domain_alloc_user() and
>> it can accomodate both cases. So add a flag to indicate if PASID
>> should be enabled.
>>
>> It makes sense to me that type 1 would just always disable PASID
>> support, it should just be done explicitly without the word
>> "UNMANAGED".
> 
> Convert paging domain to user domain allocation appears to be a
> reasonable solution. But I think it's not VFIO-only, vhost-vdpa is
> another case, right?

You mean change iommu_paging_domain_alloc() interface and add some sort of the
flag that caller can pass it ?

-Vasant
