Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00915B15D
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056044; cv=fail; b=D1OYhaAowtlgf15683iXrd/faijn79AGsfvh4NXuVk9bW0C5zOstrAholBSF8KwPVWhtxnqh7YmmnDyoCnvjP39/dYY46psUJtp8SOVarpK8WGEbMxWvbLWKy81461F/SJr1MKttreLopD9pkbh2Pl0Um3Dpa9N1p2OsHmxiVDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056044; c=relaxed/simple;
	bh=AAjZwP28/87HiW5pcSyhAyrNDEmdOOQqZrSgNpV5sN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkX4qPnq4688zl4I7NvfQH6AesiCPAg2aWy9UIKWSzVC7SSZhW7v6LFOCetl2GMQ7Y8oOk2WqJbQkmPJnjK8ccRcSdLieNB8rux83VuSRk6DTo9aClne4d20A6GzQctUXB/Rft0WdXaSCUuIHNeOJko1T0ijUb+fkzD3mpYnWW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCE42/4E; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCE42/4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi+3ZKRn4a7Z7cNwNDHcptSqlmOoa7iNWiIcUhQxhKVC9vCrfYtJLYD9bXIWqP0bvyzho9roMmPaiqHvAox/6xMQ/8aOPeALYEk5RA8BY/l/qJRcO23vXz7P1OYLzHhOpYUAaINVxNU8T4AB9Gn6T7Qg1HEj5zwQAYaWugPcjQRpCJwpqxKi9M0/ggdjmxsXPXTbndHFBKgTIwAF1J8Pk1pKSoUK3Dzaarh3LcfA1Y2Rti+bDeuxIoCZ2mqvSLTsRNOqL5/es7JwUBM8XvQI+uogOXOzwQaaYP9JgdaM4DDwBeRnkn7z/D90HMWPvPxp3AOCppPVVyKkV/hbEAzC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EiVWW/WoAvc4jVnVmc13asVZdsCNf/TD7Wl1nfC/Nc=;
 b=AqefcWHmRwlC7JCaUVzoWqstCOw0djvrdDdzg1S/6CpGDGFQk6SDRbOKo1cOtgur/4MmduMDDacTPeHw8qDRbFO7NfYcK/pTBoV4ugZCKGWV/jkU9267211ztFMGJVYq2YEzZFa2DO5OHeCl4qYfhaXB4OMc3r7e08wdp41S1SIeXSfmBvx6QEtwxl4LXHWTZvEtwrrToqZeT2wpLt5vK/M7K0NpLC+gkvyZaBe/Ix1TUqviW1tSBm0c00GmO8gaSMEQ1Rvc9WK4LCp4n9594ApIIqsCkkDOEy0WeVoKa8O3mpILSUbiHfXkps3HbI5TorSb6LU2CHyTR5XjlwJwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EiVWW/WoAvc4jVnVmc13asVZdsCNf/TD7Wl1nfC/Nc=;
 b=oCE42/4EobA4A0/tSDy14n/AkM33T0/ETOSkD4joNssYEfD2SBtyBzB84Z8ogKYIsbtHtdHlU2UcEqZoKLUuvx76M0u5v2awiGwazS2rxBgS1uYffk9bOszCqwIqipnGmFW4co6vJr/EB+x0EkNEfj6VhTYKxiaseQLzTJb1oRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 08:27:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:27:19 +0000
Message-ID: <de10a9ac-be2c-4db2-8870-86aca57fb48e@amd.com>
Date: Mon, 19 Aug 2024 13:57:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
 <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
 <20240816183700.GR3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240816183700.GR3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c42098c-406a-4121-26e5-08dcc028bd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDFzNXhDSjFPUjk3VGpFMXpCR0o1eUVHait5a1pzbEJXL0tURUorUVdvRnFv?=
 =?utf-8?B?cCtiY296SG8wTEZ3N0crYmw3dGpwRE03ejFRcW81SVl4aTlwSkVrVi9FOFdU?=
 =?utf-8?B?Q1NlbDN2ZUEwbW1OQU5WTXZxd3h3eHVlMFV1RDBaUHFGYVFTaFpaemRnWXdI?=
 =?utf-8?B?STVEZWV2bkJQL1ErZWNCNS9kNDIybStIc2wrdE1KV29WV1lRYmNCS1NoOFZv?=
 =?utf-8?B?RTBWcVJXbEwrc3VsUFNoV00rcUg1RUNORUk4dlhFMU1PM0pmTFNvbHJGTHJS?=
 =?utf-8?B?cDdnZU5Ua0dZRkliWUlxYnhBaC9SaUtaZzE4SXQ3WnkyOTJuKzNiNXh4d3Iy?=
 =?utf-8?B?Z043dFltVUtYK1hrOHo2NGhIcW1FR2dXbFh0S2J1ZHRkVE1IdlpTM0JrNmk2?=
 =?utf-8?B?eXQvYzNneWNidG51VDRqRGVjVmhkei9HYThpNUNzclNnaWV3TXc0VitDOGZo?=
 =?utf-8?B?NnJ4QjlsMUlBMVdzRnpqY1ptZ2U0YzNiYkhzS3piSTNIZSs4YTZ1bkhsd1lF?=
 =?utf-8?B?VmtDZ1R4ZE9kTStVVHJxRHNncElaVG0ramUvV1RFZ3Z4SHR1ajlBL01UajE4?=
 =?utf-8?B?Y1lpNG8vdzBONDA3REVuVGVnQSsxR01jM1JtcWdVYUV4TCtBcVRXNkYycm96?=
 =?utf-8?B?NjRxZlJOQ3NOZ0xTanZ5UWJaL1pnamYzdDZnd1cyeG1aZkJUWUl4QjcrWXBl?=
 =?utf-8?B?MjBGa1d0S0w0RXZ5M2VuQlN4Z096Uks5MEV4Wjdkbm1nOWdVSFRyUDdFZUpk?=
 =?utf-8?B?dGRpWk4vdE9MYWNzcWlEaWxoYTVEK1dNQXVHYnlQNXF4MHVaM3M5MW9WVlkr?=
 =?utf-8?B?SDNidFdzTk44YlJxaDYwK1UyRmZOWm96ZENKcDVqbUN5TFFkSlFNcVY0Y3ox?=
 =?utf-8?B?YU5yNjFvVUY4emk4alUxbk4wbkR0dWpIR3NpVUY0d1NxYWQ5MXdsTzFpNDZp?=
 =?utf-8?B?WnpIWHdOWk45cm9nbysxcys5a1NXRHpLMEFBQk9ra3doOElwMmJUOFRscEJ3?=
 =?utf-8?B?ci9kRTNzU29TRkRERk9Ic0dCSFBMc1hsTWw3NGo3bVVIOS95M0t5STJ1bG9n?=
 =?utf-8?B?Q21yODZ3dC9Ya0pwdDAyWE9KN3IzVG91SVU3VkFYTDFZRmovcGVoaGhLQTVy?=
 =?utf-8?B?RUw0dFRXNERLNjNqaDNOVEo2bHEzNkVKU1ZUeEliT0NPNVNWMmVGQ0VxMUln?=
 =?utf-8?B?aXR2TUhNUHhLeFdURWNXeWcra0hCWFkya0ZPL0ZCUG5CQUw0VGVJNUdSVUpz?=
 =?utf-8?B?NnVCbTJJKzFqdVZYckUvYmtlMTEzUHdnTDJuREczZHpZZ1YzekQ1bHBqMGxK?=
 =?utf-8?B?S0IrbjBmNzNudnRQZVVPU3E3bnNMdXlVc1JMVmxpZzhwa0lqd2Z5L3Mxa0k3?=
 =?utf-8?B?bldVZWdhMDk0Y2RBY3Jtd2Vjbi9qQnNmcVVFUXBUSGp3SEh1QmJ1WDBPSDFy?=
 =?utf-8?B?blg4NWkyczdDSXBmV3dEditUTzczRFFKSXZkQTJFY0Z1QTJLKzkrNml3Ulhs?=
 =?utf-8?B?Mkk2SjUxR053bjFJMzN3R3NrT05GMkNPM0N4MmhlanlVMGVoODFyZjh1eVNU?=
 =?utf-8?B?SmtzWUkrNzA2SDlkMDQ5Ny9XOXVLS0tBM2RSd2FZdW1tU1YzbWZURVdZVnpC?=
 =?utf-8?B?UVI5UGRNS2pMOXF1UzM5MTJob2t4Z1liUHZsRllvK3lJYlVYMDBWTDY0cWtR?=
 =?utf-8?B?WkttaURJcEYzWlkycitNZ05HWGNLRVMyRVVESzBZZW9EUHdicllHNStYdjlz?=
 =?utf-8?B?ampKV3BxQWY1TmpYK2NBYk50bWw5Y0N6eGNCaTlWaTB4anVUcTExL3Ftd0h6?=
 =?utf-8?B?Yk1FTng4eVI5eHdSVGlXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9mYWR5ekpRMFZxcFhML2VIVC82TEtzQnB2QUliZlRvZWM2WTlYRk1GUHl0?=
 =?utf-8?B?ck9qQ0txNzZyVWNHTGlISEE3Y0lDY2JKQWdjb1BLN2ZIM0VOU1JkUGVEV0V2?=
 =?utf-8?B?aytmTXd2Z2trQUVwamxiOUticWdjMkhOMUFCWlljRjNlVUs1OCtORWc2Lzc3?=
 =?utf-8?B?M2RBT0ozckZ4ZUhEcldHbFhRVkFjLzhzVGhEQWNpYjFsaGQzOFJrdkp2RDZ5?=
 =?utf-8?B?bXg0alRxcGkrZUYza0NaRWp0K1VMSkF6ZFg2dWhabFk1enZMN2NrYVBINDdo?=
 =?utf-8?B?S0tWSVl3VnFVb2drVVNQbnFzQlBUQnZkMnUzWFBoSU9yYVBwY1R3Wjh1eG9V?=
 =?utf-8?B?enMrTGt1ZDBpUnNJZ21wT0F3Y2lrWWpCMjlHSTQ3R2xRZ3hXZmhIVTFzeEx5?=
 =?utf-8?B?cy9kZk5LZHlJaWhzUEJRQ0pJZklmTStiVmZ1bjVaaVBWR1VNM1BLZWwzVDR0?=
 =?utf-8?B?bFF4UWluWEJRY0JrbGM5ekF2dVR3T2tRbjhLZmxHbmJuV0J5Qll4cDg5T3BV?=
 =?utf-8?B?Q2lWVWVFRlQxUi9zVVRMa3NsZVdGZGtBOThZM3NiUDgyR2FxaE4zellKRmhB?=
 =?utf-8?B?RWhOVVRFZC9tL1hiQUxncTZCTE9zeS80djRscUMyWldzVG9wekdBYllKYzgz?=
 =?utf-8?B?eFJWRWpibVZHOHZpMGVYbDEyVUUrTEFvWXowVHNaTWMycSthaWw4S1UyUmVT?=
 =?utf-8?B?aHBiVk9JYUt6TGRwdnFvV0Y3Sld5ZTRBMHhlTzBQcWk4RmRybFpTSXN3c09j?=
 =?utf-8?B?NEZVM0NYcGJvSG5QVDVucFM2QnVmUW8zaXMybXRGY1dHN1dWSkhOQlhCQlN3?=
 =?utf-8?B?Q1I5TFVEU1lQcWV4Y3JMdzlWMGlFYmZpVktibW9XZHVuZXVGUnVNbncyQWFz?=
 =?utf-8?B?a29RWGNmL2J6cWVpQ1VGR1A2UkFvZWNaQmR6K0JsR2c4bjBya2pzRURxOGMr?=
 =?utf-8?B?SEMzTmJsYzI0MFdDL29xTGdCVmxBeEZXS25yaENyOUNiN0dXd2ZOWnppWUNG?=
 =?utf-8?B?MGI0RFBoNU5DZDRJaEsyOU5zdHdzRDZ3L3lkelhvUzNwZWxTcGtZSnJNZVc1?=
 =?utf-8?B?R0hra0c1b0VvNTFBcndFdXNNU1pwVkZwUFllcCt2TitWaXFmME04OGJVUFdm?=
 =?utf-8?B?WU42SFdEYlppVEp0UEkyWVdNRFhGMDFSdm5WVUxCcGpPSjUzaitNbG9YbG93?=
 =?utf-8?B?eFR1OEV1SzJSTWZXdjJ5emN4b3NLNm9uNFZ5K2FMN2tLY0Y5U1ZyL1Z3YW01?=
 =?utf-8?B?NnBMTno5VENWRCtabldrODdEZWtpVmVhbmFiaHVnWFBnNU9qRTdmcGFlWktv?=
 =?utf-8?B?cDdvS3ErZDJ4SjhwQ1UycjZSNldieVFYUHJXVk9ZMTl6WkVwd2E5QmFEK1gv?=
 =?utf-8?B?dUhBOWgrdkJmSFdWVlNFQVl2QUo0M2I1Q0dqYkR3azRFRzJ5RUdYejR2Lytr?=
 =?utf-8?B?aVMwWkVsQ29SUnBURFdDaTNBZmNicU9aUi8xMVlRYm9sUy9KaDNXRWVxZzZm?=
 =?utf-8?B?Z3huSy8yOG1lSE5yMldlb3NSeTM0Znc1SkRTbDFqK2RZcU9XenpjUWFoWXRO?=
 =?utf-8?B?ZnVnQkhGcThtRUMxZGRsY0NQaU9DcU50eHU4Y1U3RUxwM3htOGk0SVk3MXZy?=
 =?utf-8?B?b0JKTXhMNWRaVktxdjhyanhoSkFWaXhXeWRiem5mRVYvUDRvWHJXQUVFbEtT?=
 =?utf-8?B?elZpSkZjKzlVSXNUZkxqN2cwbUNQU2JkdTgxK0dCS1BHZDh4VERyelpkdDk3?=
 =?utf-8?B?TnR1Z0pteEVQQ3hBb2ptVzBlelJBRTM3d3ZSUnRMN3pmekNFV1ZRUVM2M1l1?=
 =?utf-8?B?eU5oVWdKVGJpQkRIczhmd1R0RVo3ZVRnU0pySko5RFNXNE5wbW01OW5YS0hH?=
 =?utf-8?B?ZzdsQ0JWK3NZeUdtaUV0N2FtbU53RUtIQmh2SGk2SVlLemxYRmFkUzhQUFZh?=
 =?utf-8?B?R1hqRU9rYUxQWHRHVEF5K2llM3hCb2ZHWTJnL2lvQ3Q1T3MyRzJZSkxkc2sw?=
 =?utf-8?B?NVhVSm8xSGw0TzlhcENmQ2l5cmhhVWNMekJndFQ0YkN4QnlSVGdvclVjWmtr?=
 =?utf-8?B?dk94U0t4WkdtTkRHV0FFRE9ORlVkSWUxaVFTRFBQZCtOSWltbnFWZ3Y4ZGFa?=
 =?utf-8?Q?Kc2YKh3PBPAOGyjTA5VRRjY9v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42098c-406a-4121-26e5-08dcc028bd4e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:27:19.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZOQ4sRhWMBEXqkzHa7sot5LRaJS6rWnvBCOUdaOycYOGG8rIORUs6Kzb6kvqNnP/Jl9YJLtoG0sAfNTdaUPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

Jason,


On 8/17/2024 12:07 AM, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 01:47:52PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
>>> On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
>>>> I suppose that this also includes converting paging domain to user
>>>> domain allocation in VFIO (ideally vhost-vdpa as well), right?
>>>
>>> Another thought is to add a flag to iommu_paging_domain_alloc()..
>>>
>>> Maybe like the below. The small duplication with
>>> __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
>>> goes, then we'd be able to directly call iommu_paging_domain_alloc().
>>
>> This will work. But we have to define NO_PASID flag and pass it from vfio.
> 
> flags = 0 means NO_PASID
> 
> I didn't show it but the dma api domain's allocation path would have
> to specify IOMMU_HWPT_ALLOC_PASID to make it work.


That's fine. Then in your patch we have to prioritize domain_alloc_user() over
domain_alloc_paging. Change will look something like below (paste the code path
that's changing).


2037 struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
2038                                                      unsigned int flags)
2039 {
2040         const struct iommu_ops *ops = dev_iommu_ops(dev);
2041         struct iommu_domain *domain;
2042
2043         if (!dev_has_iommu(dev))
2044                 return ERR_PTR(-ENODEV);
2045
2046         if (ops->domain_alloc_user)
2047                 domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
2048         else if (ops->domain_alloc_paging && !flags)
2049                 domain = ops->domain_alloc_paging(dev);


-Vasant
