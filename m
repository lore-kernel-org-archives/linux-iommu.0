Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2E1AAE0F
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880600; cv=fail; b=ufV4Voe+HP6F+abUe+HjWaAFWGYA9t3Jwg1Y3iFRi+BAfJtXpqeIp61V7/3Nah7dtw5icTneArfhIasGVm7QRtGhY/tL1ZoEGQGB67KsWsLZ/QCSQ1jb3SuEiCmGiQch4KqIFPwfSjLTwkesTGl/HAUZQKqNVi+VgnmTNx+I3uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880600; c=relaxed/simple;
	bh=frrQpEyYIwgXZWdn6C0Vzo2VYxi8yQdeqMJA71opZt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=feSo3q3WQ0wPxPDNpUiRbKvuf2s2ZMt31lF5HukXb87iF5mLtdrY6m/S6peUfryfZHIkQ0MgyUZX/rH/sHqCSI8JyBA1SA0ShXQkLrfvPYdbj+o5izaSe9BMfKbDYpPcnDfGn2rigUdqY4yzbopiof2JU0374JUD+nV0cFkKBIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XtSt6r5n; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XtSt6r5n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJN0IvhOww85MrGyEr0Wjm2VEDS5Lv5vlYd+5LcyAsBoO3NRhRv8RzOEiBEFaJbCoYFzAMgpbyHfnpwbbxdpCdwiM6LlVA8rLF9w2Mu9Ap1jXGymIY+yTC6Os1cOjvsNLy7tt6TSB9vR9zzFfw0xqaG7c3epQuI5EGDwe1gPhIzNrtSkfiy1Il/iT4a8QUVRAdSdxDX/t77YqB/Pmddj74UovyMFM27+l6ghewyGv6gklHbCu9kI2qIdDLrUjXKaDaSFTR22jUNqiQHrPqoK+GY4huwwsWLibTpWviXpwYQAHaUwZgT4TtKKwvPgCaiDKGJiOo9Y1rcbT9mCZMG/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znr0S+gZu97w+AshjVfv2Q68iJxzEtsh9N67NCZFcRc=;
 b=DFUx+5mGpfmGo/9Hh5/+HkitryHcxVO2fbr2k8pCT3lHP0kGDOo7rUPKz5PNztWZrbbg68vCAYxE2JQ8z4W1UE6ON4u07na8C5XEwQJISVHslZso98T/SYz8WEAkOeKfc7XgIDjms6BzH6WoNgQpmIdhk+YES25qQZO5p92CdUcmCVhT2sl7Y1sIF7v/IZD3qN8yq1hWQtufGPVs1lSkPkHGSszz+1zh9A0DffFLVvIyLRNFtRSRyRQ4hIQOVupiitx6EtNH6EG5q3uCw//tPsZw1zZ7KZplctJhvUpj0WG83IRho/ZBR4ouEYICH/gSbCkrx1z97E5eCzNlN6Ifww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znr0S+gZu97w+AshjVfv2Q68iJxzEtsh9N67NCZFcRc=;
 b=XtSt6r5nduQxeM+R7VMxId7Nm/AG8EkVJCN6QS2VJdol3z+U8dbKiglJc+6bxyyu+g4Pv/n6kExgU8lh9GrgbSTZ1tjVN6Zsb9R0lRu05oKwwa/uqwFlYjWHlJX4O/E2dbDe8FnVhJpunJRJOiQERBm3b9QNypcA+OTO0cmxLlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 10:49:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 10:49:55 +0000
Message-ID: <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
Date: Thu, 20 Jun 2024 16:19:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: ca62b156-7d41-4557-a37d-08dc9116b868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWRkbWdVM1liSnNDYjd0NEVydzFjZ0Fzc1pvejdpdXVwclgweTJITG1EZmZv?=
 =?utf-8?B?SWZBRTgralI0clRXQmEyR3NmNDhadktQV0svSk1YalRkZEg0eDFaVm5jVlVi?=
 =?utf-8?B?V2hkaVZteUgyaHJnQzJ0ZU1kL3gvZG9IK3RyYXNXSTk3d0xnVy9CQnJEdFYr?=
 =?utf-8?B?ZTF0cHlVdzN1WVpJTVFhR1drL2pVdERVRHZla3Z3V2gxRVM5b2N4cDdkWmtk?=
 =?utf-8?B?eWZNYzRhSy84K1puY2o4SzgvKzZtWEM1TURSTXJ6WDNZV1loZjBtaFI5VllV?=
 =?utf-8?B?WW8rVzQwZ1J6OWVad1lyU2dvS0NOdFV5Qll5VWFDeTdESFZnVDRNT0tmL1c4?=
 =?utf-8?B?dUZvODA4OVhIRytNbDU2ejdjMEV5cHlmcEgzdkhDNUpKbGttVXlUd3FuaExO?=
 =?utf-8?B?cXg3SThKTXMvUFptSU9QVEcwM2V1U1EvRHV4WVpIendsTW1MN2NUNFFFZTVX?=
 =?utf-8?B?ZHBwRXNmWWZoelNsZjFqdk5iK2xsQU80TjNnaVYydWFhQkJldmF2Zm9xZVk2?=
 =?utf-8?B?N0RGNUdOVk5wcGhobVNSMEJ5anE2RnZIYXIwZ2FUN2pWYW9pMlNYd3hwcjZy?=
 =?utf-8?B?a2VFcWs5U2FjUlZoRW1Lb2wvQmN5cWdabWZaMUN4T3htdTM2Y0NjbnkrR2hy?=
 =?utf-8?B?U2NEVWdlTE9RK2phY0lpWWhTaDdZTzNHVEt3QXBIQ1ppK1NYSlpkanJGOFpq?=
 =?utf-8?B?K3BsSVVGWG0zUFA2MUpEVlZLd1ZrTXJRMUNISTU1NjRYSmhlOG1UTFZtNDlG?=
 =?utf-8?B?QUlnQmh3b0gwdFJtaktpVHpUZkVoYXpWOHBvSlhLemJRdzI0dHpJa1dLUDZV?=
 =?utf-8?B?SllZc0hqeGRyYStsNXFiRjdMQ1ZsMTk1QyttS1FzdGpvRXRMMHVCUG4zSEJj?=
 =?utf-8?B?bUphMlhFR2d4dkRnanUzS1ZtQ0RaYmlFQWhSdVBkQ2RvUWZnZ2EzMnQvREZO?=
 =?utf-8?B?QXhYZDRlQnhPeHIzN2E2eHNWVTlWejYydVBqWS9nOWV2TGxTVy92RjJNVnBH?=
 =?utf-8?B?Mk56ZHhNN0VBNTJqNXZtb1d1NmcvSUFES3F6b3liekJQSDRkbFFSVUNZU1Jw?=
 =?utf-8?B?RFZZVGtzeU1zRkZhUXJyTUlGelo1dzhwVHlGci9qUWZWM1EwZ283RWw3WC9o?=
 =?utf-8?B?ZG40bFgwMW9zdy9VcFpxUTRpZlRXbjFPaUowK1kzTTZiU3l6VHZVY2d5OEdX?=
 =?utf-8?B?dURPZTllVWt0akNUUnp5MEl3Q1pZdzZxK2FuRFNhcE9VTU1YY2lndDl2d3FF?=
 =?utf-8?B?V3loT21XWDFDc0hoNUlXOTJaNDVsbmRJZmJnSlFPdERQK1NHTUVkZjF3cmRi?=
 =?utf-8?B?ZWRvYU9HMm1VWXRiNlI3bzBxK0ZIMFlRUVJoMHNQSXI4SXJRYnRBZFFHanNN?=
 =?utf-8?B?OXRkSFVJcWNwK0d3aS9uNlhsVFRpTGZHNWVOMVZWdm5QdC9Ob2ptYjJrU09X?=
 =?utf-8?B?MUs3cG1RQThTVTl2YXNobld2Z1dLMncrYlNucGxlWFpVUHNJZGJ0aUV2NWhO?=
 =?utf-8?B?Wm1BbnU0bzdVbUhkcWdLcEFOY1lwUzkrVzlha21QRGdrZXYxcHRzS005WnZx?=
 =?utf-8?B?T1k3Q25DYVI3aGcvRldOcU1lcTRQNVJiRjhmcTZyWERYelBMclpPUzRmczhm?=
 =?utf-8?B?K3ZGWkw1M0FTUGo4SC9seTY2MC9mTHZrMXBsaXNaY3pudDE5RjEzSHJOdTRW?=
 =?utf-8?Q?wA3Uj8tg3tQBN9byX8NZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0Fvb2ZYbnZJd2huRUlaZFk5NGgvdGZWZ3NIOTNaUHU4bnl1YjB4VHZxSVNu?=
 =?utf-8?B?R05VVWhwZlpkeC9WMVlMTFgrTjYzQi9QdWErRDMxQk9sM1RZaWRoNFp2Sm9D?=
 =?utf-8?B?K2tOUWpSZUFseGY5Q0dJUUQ4N2orT1Q3ZnliVWJwbFFZV3hOZVBPWjZnakZk?=
 =?utf-8?B?cDAxMzJMdG9rMlJSd0dLUm1kcVNqMEZnbHBmdDRVZFVCSnVKODNhTUo5Tkpz?=
 =?utf-8?B?KzZiTkJzZmhNZ29EV1NCdk1UeGZpdzN0TzgwU1krR0lPQnRJdGNLQUNZQzRU?=
 =?utf-8?B?R2wwRk4wQTY0WW5SclRaa2Q1T041QTNjQjlOMFFpWDBkS3Y0a3Zudjl1dnNO?=
 =?utf-8?B?ckRJc1M1WGpVb050aXgza0duTGoxMC8yY3N1ZXhVU0o0QWxzWTBwZDhxY1Zz?=
 =?utf-8?B?cGRMeE1SbGZpUnhnWlBHZWxLc1ZoaElNSFZyMGJuNG9JcHJvbkUvOTVLZ3Rs?=
 =?utf-8?B?RlBhYkJ5R0Y1c3pJUW9nSEU2RzRaSUVrMmpOUllHelA1LzJwNHk3YkU5a1dB?=
 =?utf-8?B?Rk5HTHo0cHUrb1pmOU5xRTNCOGlZcy9IaFgrRStQT3NYcWlhVWlYWjdXQnUz?=
 =?utf-8?B?azlEcnphWVEyR1hzZVZwMkxvK2Vkdm9BSndZMTRKbzQwR3NLd2E2RFNrMnV6?=
 =?utf-8?B?RUw2UUFTRWcwUjNDU3Y4OHZlNFQ2ZCthRWVTSWthbXBYNlJwQzFHUVBlK2pz?=
 =?utf-8?B?Z3pjd3NsSWpJOE9xUGs4MFJFNXNuT0xVcnNuRmpqT0JVbjVqVGZ3eVczMHJF?=
 =?utf-8?B?b09zUDZ1SE42SEpqcVQyY0puZUdBbERsQytyZXhOM0xtWTJEN0Y5d1VYWG9Q?=
 =?utf-8?B?TzUza0FNUDY1ckZnSXRyQXYxaFZHMzJlM1RwajhkQ0p5T282YzZoMXBET3d4?=
 =?utf-8?B?dnhoTFNybm5QcDZ5UVhNUTNiZXJJd2UrWDA5VWltTitzeXRDTmV6VUdabDc5?=
 =?utf-8?B?d2VReHh4Z1dNK0JWMGI5WmlnOXkvWU9ic2l3UGVxRENPbjJHbW1TNXlKZk5T?=
 =?utf-8?B?Y3ErWjlnbUR5TmxXbi8rOW5UaDh1L3Ryb1dxK3JrL3lRczZSUnVUQ0ptUnZS?=
 =?utf-8?B?Z3ozeWk2cU0wQkx6cDhYV3Vkc1JoMWlkS2pKUStjZTV4NzI4NHFLbkRVZ0pR?=
 =?utf-8?B?WDRiUTZpVkptMW01ajRMNjl1cFV5Sm51UzJrYzRMdUVNb25ISG9vTisveFFI?=
 =?utf-8?B?aFEvc3dMVm5zYVVSZk11dlFIajVtWjVOSTI4Vk1OU0Z6djVjZ1MzaEVOSTVP?=
 =?utf-8?B?Z3RYMDQwYUlSSFBEcno5YnFhU1NHd2pJSTM2TnljM2Q4RTY1ZmNUVEtzY3BP?=
 =?utf-8?B?WG1jNDVsOVhFS1ovZ1A1cnB1bWVQMjFxcTF2bGlwdjVnemFmaDVVcjE0VnZK?=
 =?utf-8?B?b3poSnJmR2JUOGJNRFY1RVJucnR3SWE1clR6KzRLVzhBaG9LWkNCZVVsd2M3?=
 =?utf-8?B?MGtKVWtMdzJ4RmlxN0o5QXJHcTFDcHVzWC9XSm9WZlVCMkQxV2hNRDZnZ1Fi?=
 =?utf-8?B?cy91Z0ZzaXBRUGpYTGFpNXk1ZU5XV1JMS1hZNHlnOGZUMlRlWjV6Q3FHWnp1?=
 =?utf-8?B?SHg0ZFNKeCsyRmJVT0VJVjE2aEg1emtLRnRxTWxUUitJc09oRUs0eGFaYUw4?=
 =?utf-8?B?TldzZnYxa3ZOVWlRK1FJTndLVHljSUI0bUlEVnNjRkc5citkdzBxM1RRUVdS?=
 =?utf-8?B?QnlrYXhuRFZOd2t5NnJtc29SU3VXV25NNjc4anBsMVRUZXdFYkZvcjY2b0V6?=
 =?utf-8?B?UVEwODAxUkpaSldWa1hIYlNodzhHeGZOUCtlekhBa0xGZGJ0emlacVhYb29i?=
 =?utf-8?B?QUltcktQRGJmRW9lT0lPRGsvK29QeWw2bk9uMjJHWElnbUtlNmpxK25MKy9o?=
 =?utf-8?B?S0ZMSzRubE01ejVZOUR6amVGOHU5MCs5TUhFTVUxLzRrdU83bzBmcUxPbzZL?=
 =?utf-8?B?U0FPdzlGczRlRVVBVExFU2RiN0xrQXcyZmp0czRIcE1HVFhBeWtKeGlnblMv?=
 =?utf-8?B?N0lSTHdmck1PbmJhaGZ0Q0xYL0hKNnAvOThPN1BHRkNXendLNjF4U3NSUTMx?=
 =?utf-8?B?Q09VR3U2akN6ZDVEd0dUV3Q0azVwTDFMTWlmRlRvR1RzZHJSbWFlbUFXekRX?=
 =?utf-8?Q?PkZOx1jLAey4nZZDXqjDMN02f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca62b156-7d41-4557-a37d-08dc9116b868
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:49:55.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHL8ab3Lpf5VOIUiFAgUS0nlhYFOdDZE4k0vJcIFNI3Znu3i+RqwUyzxvS4Jy7j8uKiVOLKAgBAdXXTC8fNAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

Hi,


On 6/20/2024 11:57 AM, Baolu Lu wrote:
> On 2024/6/20 13:54, Vasant Hegde wrote:
>> On 6/20/2024 8:43 AM, Baolu Lu wrote:
>>> On 6/20/24 11:04 AM, Tian, Kevin wrote:
>>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>>> Sent: Thursday, June 20, 2024 8:50 AM
>>>>>


.../...

>>>>
>>>> seems that for all domain attaches above is coded in a wrong order
>>>> as ats is enabled after the cache tag is assigned.
>>> Yes, exactly. But simply changing the order isn't future-proof,
>>> considering ATS control will eventually be moved out of iommu drivers.
>> [Unrelated to this patch]
>>
>> You mean ATS setup will be moved to individual device driver? Is there any
>> reason for that?
> 
> Not exactly to individual device drivers, but it should be out of the
> iommu drivers.
> 
> https://lore.kernel.org/linux-iommu/BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com/

Got it. Thanks.

I remember of this discussion. May be we can provide API from IOMMU driver so
that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).

-Vasant
