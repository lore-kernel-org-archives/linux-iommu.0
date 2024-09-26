Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E371D5AA2
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348524; cv=fail; b=V+6G8stww2rIX9Drr4knbRiqbcsYu9tkP1yjs2+VWT9ugBD5io2kgKbmu5RDFw/9N1jpR+7j1jBNBqTYiVjuqcjFk4VnB5vah13twQW/oHCS1S1/F0BX5E3zRVUDogKUBYZHM02XDdlr2HXsw7YGJiMHm54JUJPJDOjUizcNzYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348524; c=relaxed/simple;
	bh=M1MBjR9VAs8JEPlGrxPWk0Qx4RxpgCBAZjuhSuJAcsw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9fvLa0gCW93rmWLr7jYdfHPvP+dXRNfC8BBMF3JkDWLS7uHdlMreQOJDNSeSZihEF57IhuSdN8X2uJaRl6EQk4NeMeg0rJL78zOaT0gWS04asYQFLF1gF5OgylQOLs6YnRfUmB+i/mRVACiK3aldEPvyYVsJEpRXk543cfPdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KnN6wukN; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KnN6wukN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIqibROwT21pY6oTDSqTJJxg2clRp2MDg9Ux72KfjQHe24xAx7F2uFSYc2aaYSQyFHOzd61TYnYo3JtBaAE3YEkJCSHcmL75tl09ac+Qi5Oj5MwoTSPHqZX96MivYuY4RzNHe/3OfJUdbHK4b9bhbAguzjvkFt/QYoMFYHJWiIMh2AfbtimbwxqZQdCLRqsJudGyjwZYYtcJ5BvyoGU4irsxCzFQnDH3hmVpimDBarnzrNNv1cTzGeBSZCJj4WHbI58mar485d38j4hwsf+tCsQkgLVqIFYDpFfF6e/w2wtddWSweoSZZ8BK9JW0bluO1UljDSWrNDRMsW4vqdz+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOO7SAkq4zU6dIN+mJfBZR60FRk0nPWhhalgdgrTqNU=;
 b=Dgyijc+0kcbUjxZY9bdGL8vaYgJSRd3A5MdeJAZH4F/Ko0FpbA/+YQtrsj0+p9S9J/xHPswzbmaHR99WdxYw6SfDFcaX1TwkB6+C+7eZUVqSX0r/Ir2PslLGB6xi7Oc5rkF3HnlbYKpjczfNnEsOMkRVkV1H5oa6SoiZUQtM+myoQCzHmEwzjSCeBed2pdsP84vIkYABrORBZEvJLLrM/TJu61cAyYz3+sPLhjj63GI8I24bMQkDyvrCzZaN9ZW9R0tC2xEjIoU0J0+fqEoNJHiQBpM50N4vFHwuDcod7uAa4mwShFCxRkkYf+JpsLa4y1hQM1d9zXpqV5mm9JN+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOO7SAkq4zU6dIN+mJfBZR60FRk0nPWhhalgdgrTqNU=;
 b=KnN6wukNfqfoj/SKSmMGgs+SunlQDmBEdgIJDs/0ZkEykfSjbMSvepg7bZJLXzavykY/P63a04Oy0t1CQRrw2wl5fbHzKhs0F1mMjW2N3rmiCyFeyfq0WSdRXPkpDnsyqR3Mh8KBZ/1U+foxT+vyEJlf3FsKY2RGV8ftXOZaKtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 11:02:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 11:02:00 +0000
Message-ID: <c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>
Date: Thu, 26 Sep 2024 16:31:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
From: Vasant Hegde <vasant.hegde@amd.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, yi.l.liu@intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
 <dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
Content-Language: en-US
In-Reply-To: <dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d4625-862c-4f52-054b-08dcde1aa50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWZGMVkyV3BtTVByNGE3cEZ0Z25xSFI5bmZDVHNjTU12aGxMUkpNTWg4SDUx?=
 =?utf-8?B?OVBERGs5TCtVblJnZHU1TjlRWlJyZ0I2bGN5QmFyOXk2OFR1eVh4akloZ0ky?=
 =?utf-8?B?cjcvTjNsYjhSVWJMaTVSZ2Z0Tm1telVjT1BXRDBGa3pBWDhVOS95ZjhybHRl?=
 =?utf-8?B?dVVSemJSbmdLeXl4WkVUSjRjcmlSbDdZUzRrcmFnM2I5KzdhaUdCU3pLeGha?=
 =?utf-8?B?TE9KR09XS0xLbFZaa0hjNjVSazA1VE5LU1V4bDRXNkhteDNEOGowbDU5bW9G?=
 =?utf-8?B?cGIvdC9jd051aHc4dEUvQ2pER0NYSE5xblhRS3FnVTdFbG94c2FmMDBRdDEz?=
 =?utf-8?B?Nm5KRWYwVGxDU1Z5L3o4YkVQeU5IUHhSNXgwRStIN2UwdEhWVE5iUDNBclhi?=
 =?utf-8?B?VThrdjJTL0xFaDlRQVBRd244QzM3SXExM3M0YUJwNlhFNk92ZStVU29wQkVZ?=
 =?utf-8?B?aldNVG55ZHBRZm1CK1JxbFlEMHlzeCtDelNVNlhFQUVvNWhjU24wSkFRcnM0?=
 =?utf-8?B?UG83MFI3OWlDa0xjMDBOM0tnOHpkU1lGTTJhcTEvWlc4Z3J5VllzY09pcmxD?=
 =?utf-8?B?ZXlldFFrd3pMNXBUVFhLVENRcXE4ZlBDSFpHRFZDSW5QejdVMWJxYTdvYWxn?=
 =?utf-8?B?S3lLRTZJdTBNR3JINE5wUTkxOUlIVUtJRjMrbUJyMU8rN3pyOXVkL0NQNDAz?=
 =?utf-8?B?b3F5NTZCakNaeFRzeHdhY0NpUkxNSlM3UE05WmJsSnZnZGlXUGVFREhHS1BZ?=
 =?utf-8?B?RXdzQ2F5bUJEWVl1ZE9OdEJmaENONk5LWnN6dDU3bWs5TmJFTDNyeTRwU010?=
 =?utf-8?B?a1RkTlNmZlphUk9BaU85NzM5a0x0QW5UNEtPZUFkcVdWc1lYMGkrU0Z0YkIv?=
 =?utf-8?B?QW5URDJkS3FTMDg1L3RmS2NlS3NGa2hrUFowVzVUNXZzaTFUbHcvbnNma2Ex?=
 =?utf-8?B?d3BYN2gxNEk0bGJ5N1N5amNqRmwyRHEwaVdUVnJUTWlZMU8xUlhCSXdXUzBC?=
 =?utf-8?B?SUp2SE8yaXpiUC9xOG91SERkL3FteWE0bDcrOE14K3RZU1BUL1Z6UDNqekRp?=
 =?utf-8?B?cnErN0k4OHkrN2dVNy9wRmlSRkhxdmU5UnB1bHZnTnJCY3V0a014ZlFpWXR2?=
 =?utf-8?B?cHVqdDE2YmRaRWtyUzlLNCtLd3gwNkhFeXlEc0lVR0drWExtVE4rWHVLOFVy?=
 =?utf-8?B?Y2NCMGtjRVhnTTlzMzdES0syM2VtS0ZhUjNmcTZWeE1vaUpFeDUya1RuUTgv?=
 =?utf-8?B?M2VpRGNRWU5Pam41dC9ONFlHeHJYNElPcGZSMldKM1pYUWlRR1huVnpGb1Rw?=
 =?utf-8?B?bVZ1SFZ1bFpUMnMvZWMxU3VXNDhVK1BpdGhTTElhWWRYWnZoUTdrWW44OVE3?=
 =?utf-8?B?OC80c2JvRExpQkhiWWFEVTh1OXdoendmT1M5M0t4cktJTCs0WHZpbDFMeTc1?=
 =?utf-8?B?K3JVaFF0UjFoUFRmTzI1WVlzM3pHcEtJMHljV0xPOWV2elN4dHkxUlJFaURF?=
 =?utf-8?B?UUZjK0VDS0wwWk5KWllqRUpsakpWTkhlUHZiUHVKQnliRCtrTXJ3a3Zualdo?=
 =?utf-8?B?a3VTd2hUQW80R0kzSy9tZFQ4SnFOOFJrS0JjVjJzT2tJeEM3ZFJxcXYwV1Vu?=
 =?utf-8?B?Qi85RDFWSTF0S1NNTWpBQlFKR3BTcWJhUUFDV1BQeEhEcUUvanljTjJCc3V2?=
 =?utf-8?B?U3IyN043SWhlQUVDdDJ2Q21ibG9zNUFlalRTbHk2Mjl4MHg2UFhrVDJLekdS?=
 =?utf-8?B?SGJCbGxvY001NXhNQVJkUmdxNUxFL3NIMlhsRmVCSCtwMG1GekhNcllOb1U5?=
 =?utf-8?B?UDhsdm5oTEdqMjd6TlJ3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2tBWHZPZXI1dU9LZEl5ZVhiaitNaWFkNlVOK1NQT3FZNjJIWDZkR3dQRFNE?=
 =?utf-8?B?bW5MYk05SklyOFRtbzdtWWZhMHl0Y3VJTzUxVzdNRGp3S3RjWXVUNWVDZk5E?=
 =?utf-8?B?WnNNRSsxK1dEemlVNDZocHZITllZNzUwU3c4VS95NTJSNEpQanJTK1liN0tH?=
 =?utf-8?B?bW5rVGIrUW9zR0tzUFRqNWdEV2hiNURUZUtwMU5aMlEvZ1BzaU1qaXBqUEZU?=
 =?utf-8?B?bnhOWW5YM0JuT1lVaTRHampKenZsYnFtVXFEcWdSZVRzbitKMnlEeWtLdEpC?=
 =?utf-8?B?OU1KUEhyTkFZbE5BZU1qcUtkQ3ZxU0hhYms1K3NuTmlnTzh2NkxyZnhXanR6?=
 =?utf-8?B?dUNuRDRLcUpRelFTSFgxYXZudzdmbXVWTmpWcHBHY0ppNThGa01FRjJBdngy?=
 =?utf-8?B?d2FpZXpjWDVJbFdXT01yTW51ODM4TGMxZkRxTDV4NjJxWlQyTndzZldFaWF1?=
 =?utf-8?B?KzZ3SDZUSVRQUzZxa25MUGY2THdJK3V2b1YxMWdHaVZSZkgvTzQzamt4WFhJ?=
 =?utf-8?B?UFhEUUxZbTFVd0tHNWhURHhKbDNjdmdGL0x1eDZTU0dRQWlwSk5HQktaK1Fq?=
 =?utf-8?B?Z0o1emZxY04zcVk3REtweWdwTDlPdFpPNGljUU9aZVlLbHozU1hGdXdyN2ps?=
 =?utf-8?B?Uld2SnhRNFVJTmhmbFU0dHFSMGNQTEd4MCtyazRjd1R0UmZrQzlBeFlZSlJT?=
 =?utf-8?B?dVRJTm1rN2U4cnNuS0QxSU13Sm9yeFdwSXB3QkR4M1RUWWVYWnVmblhCSWls?=
 =?utf-8?B?U2cwa0ZxMGxlalptc3VubmFYaEYxWnB6THMvTlpEbFhYVjd4dmxnSy9sWkFy?=
 =?utf-8?B?eEd5MWZUbFQ1WGNpUjVJY010WE9uQnhXRnlldFY2Wmo4L1ZYZVBWRW5SYklU?=
 =?utf-8?B?RnJRQ3gxMDRNVEIrcWRIMVpvS1l5UThRTUJya2t6amRpZGRhdnQyb1Y2MCtS?=
 =?utf-8?B?TXIvdGpmMTN1U1Q4QXoxeVBTTGJjTWpLdk1mc1BFVU9zMG1YV3RTYlFEZ3Zo?=
 =?utf-8?B?clpraWIybE91TlpXR1JpVU1FdXM1NVRzN2dkODRPVUVlUExwRklFd3hsZmd6?=
 =?utf-8?B?WHpFL1JtZDBXOWEzaVMwWnZlTCtldVkzR0R6bE1zUTNFdjlsdUhyNG14ZXdF?=
 =?utf-8?B?cGVWY1J4bnZReE1YVTJZVVpVaHBRTDNmRGoxVlVjWkdGTWNCMHZuU25aaFVG?=
 =?utf-8?B?Zk41bDMrc1FJSzY3b2xkK1Jhb2J2ajB6Wlh5ZGlMSnJEZVdja3FyQUV4N21a?=
 =?utf-8?B?Wmh3TmF1K1FJdXJaMVF4YkpycEdmQ01YdDVNY1Iwblg1YnNsSldkRitGZko3?=
 =?utf-8?B?OVMxa1F4UmJRcnU3SkQreC9CUnIrRzhSbVZIYVVrcFZzeHV2eHU1VGFLMU1h?=
 =?utf-8?B?bmtqbkovM0EvaWhDNkw5cXVPM2hpcExnZ2w5cmlpL3h1b3Q0aTV1Ymx0d05X?=
 =?utf-8?B?TnZtU2hsaU5XeHZaM2Nsdk5GVXRHU1NUVjF1RmhNLzF4dTZrVWdvZEtLd0Ni?=
 =?utf-8?B?WXBRWXBBcVp0T2VTa2VvSzU3Yy9sTVl5T2I5ZkpJY3JoSFhZNEx4ZXF4RnlV?=
 =?utf-8?B?QXZjd0dvTCtjdTZCdUt3WS9uY0lObHpTbVVtR3RHK1R4dDhRdzcwakRlZDIx?=
 =?utf-8?B?VlhzcVZOQ1NYakw3RUFOVVE1UFJRVm84cUJOVEEvQjNiMk1aSGU3a2lDMXk1?=
 =?utf-8?B?RXpiaC9weFQ5L2k0ZlNwd2JEaXM0MkpQNVBtMUd5QVFOemhnYlFnSmhCRHo3?=
 =?utf-8?B?WTA2U0hhc0VaOHp5T2YzdmMreTlsdDAvVk9JcWZZVk9Yekhtc1JCNHNEVUJQ?=
 =?utf-8?B?R0crS2o0Nlg3MEdpeXpIWFZsaVRhamtTQzJJK1VtMHhOcjlNRzlVVDJtWXlq?=
 =?utf-8?B?U3ZUbmNDSlBXanJYVkN1b3JGU2JpaWpVOTEvTkFxNkUxMHZVZFlmOFVuOVI2?=
 =?utf-8?B?dDZjOWVLNE1XWDQzUW8xdzdMOW1RcFFiNHJiMmpVd0tWQnhnT2ZMcjg0R0pS?=
 =?utf-8?B?QjRKVUtnVHNwci95eFVDR0NDNFYzZ3JNdStBbUgzT1V3OHhEYitPRmtuMlZO?=
 =?utf-8?B?OFpReURSeVhPUHR2SGc1ZHBmOEhNdisrTm42SDE3bjBpSzRPNWl2TFNTZUM5?=
 =?utf-8?Q?9mExKgO+9VV4mKYu1dYC21a/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d4625-862c-4f52-054b-08dcde1aa50c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:02:00.2567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8xiXpEfRM9/8b5Z+v/0Xbad1pC9c7yDisY4FCO4vHUHPhWqThVQmnaEcJnIuDu84Gl7UXFbeXZTasKAYXzfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506



On 9/26/2024 3:59 PM, Vasant Hegde wrote:
> Hi Baolu,
> 
> 
> On 9/12/2024 9:44 AM, Baolu Lu wrote:
>> On 9/11/24 6:19 PM, Vasant Hegde wrote:
>>> From: Jason Gunthorpe<jgg@ziepe.ca>
>>>
>>> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
>>> If both IOMMU and device supports PASID it will allocate domain.
>>> Otherwise return error.
>>>
>>> Also modify __iommu_group_alloc_default_domain() to call
>>> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
>>> paging domain.
>>>
>>> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
>>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>>> ---
>>>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>>>   include/uapi/linux/iommufd.h |  6 +++++
>>>   2 files changed, 40 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 5d1cef36f633..f3f1244fe90a 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -32,6 +32,7 @@
>>>   #include <trace/events/iommu.h>
>>>   #include <linux/sched/mm.h>
>>>   #include <linux/msi.h>
>>> +#include <uapi/linux/iommufd.h>
>>>     #include "dma-iommu.h"
>>>   #include "iommu-priv.h"
>>> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>>                    struct device *dev);
>>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>>                   struct iommu_group *group);
>>> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device
>>> *dev,
>>> +                               unsigned int type,
>>> +                               unsigned int flags);
>>>     enum {
>>>       IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
>>> @@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>>>   static struct iommu_domain *
>>>   __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>>>   {
>>> +    struct device *dev = iommu_group_first_dev(group);
>>> +
>>>       if (group->default_domain && group->default_domain->type == req_type)
>>>           return group->default_domain;
>>> +
>>> +    /*
>>> +     * When allocating the DMA API domain assume that the driver is going to
>>> +     * use PASID and make sure the RID's domain is PASID compatible.
>>> +     */
>>> +    if (req_type & __IOMMU_DOMAIN_PAGING)
>>> +        return __iommu_paging_domain_alloc_flags(dev, req_type,
>>> +                dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
>>
>> This changes default domain allocation paths.
>>
>> Previously, the default domain was allocated by domain_alloc_paging or
>> domain_alloc. Now, it will be allocated through domain_alloc_user,
>> which, based on my understanding, is intended for user domain
>> allocation.
> 
> Right. This was discussed in during v1 [1] and Jason suggested to rename this
> API to domain_alloc_paging_extended() after everything settles.

Sorry. Missed to add the link

[1] https://lore.kernel.org/linux-iommu/20240821163147.GZ3468552@ziepe.ca/

-Vasant

