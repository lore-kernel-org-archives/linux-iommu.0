Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC223D7DE
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311746; cv=fail; b=qBzw+3I8WcldnR4/c1QycFG2qUqncavfzZ1QHExuRcf0uu5CeYb29ecc3lg++awigegiqhogCHIRys843OX4vI2XhwAHhgfLXx4NaTJLGHeVvrgR0Rm3lGvLhA1D0fWtEcA+DyXvXugIHPkX5wShti7x2HUHCbh2xKb1OzH2nUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311746; c=relaxed/simple;
	bh=tcKIABEWuJc+6JGxKUcdcOdMEkzBVR87g8nLA33Glvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxRJ+Vf3dPvsuJyUt8Ktef6Oy6cl1kY25mFFITf4G52WxsHuLVEskPvPv9p+VGakn59JAqLw4oAYkchyR3dGrRbQa0unNcd++m/uVk48xKgsZWovqvhQyiirq08FCNWyRfLxPsM+GpYmQqojnZhkbJ/XRURaZKKtLhYThMAW/fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UrLbqJpK; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UrLbqJpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4hjwvdtBk/oUU5tny9ebMxKKhOvH3mkSN1e+wBhDgw7wYw8oX8omk7PDzAwzzq2ReNSz2kqWxW/tSCWZYf5HVnBO5Bqzgt2uyaNrZd+C8pEeO15XkMoMZiJsCn0hWYBwkQpM1vW4xotyNSGP0PhzS+WjAD7rLQnfyz6OUxriTnux1JRo5cOcORgrGaRPaYj1JeUMaznFB5oIrvijZBb/uZxFhBQu8lNWMt6IO4VKnYlm9GcDCjW6MImrai6Gxjy+t25g97PhlACX0Q6pIPPRSsnSJehMS9MmeC9HGGpun5VJmJyHlxTL3i1fWTcCLqfQ3FlrB0ugIF1lhjJ4igF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD3vdLxqCAfYvx1mieXctA4UmKejoxkIFDU1CjBcfmA=;
 b=T5WsoBhe4PSP7PIfcl0RE6MFRkTE/ZMro4ykg3SBhUFmBSymWcPqXgWK7pO4sG76yE+LzS8POFNDuAYhyTXtOL2wCeiG/Gqk1LtWCxsbro2/DjLE0iG6jmD5qQvMzfDqvYE0HfrdIRFd47lciMlVpR4mag6R9iQWZDDpmAWB4sbWM8UZN0hT+Bj6iLTBDmSeXyZuYVgfdVuJDN4Xk+Waleqmwmp/5ZSRtYeK5u++gb40x3zchMOp5Sq7qe6OT7C/4hCPQ2kRrGkBhrwRciNEHOhgo5/Ea6Vd412B0jCo7EIyuwvb74VrAF3lcOxLpC4/AZ6GMZOnBR/rRO8XGWHwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD3vdLxqCAfYvx1mieXctA4UmKejoxkIFDU1CjBcfmA=;
 b=UrLbqJpK0P+iumMJuQ+YsV3f0KgzSR/fL0vpjsgiRvoSo+qmrTePUWtp81l3FMwFuTOllCHzHRh6UnKVsOfgZWOq3sf97ie8MrIBBvzuulrnsRoOmvf8cq+LSqNqdyZ9UTaDG2o/sQh+06H50K3pPC6tVLaiF8dG2gS0bgqEaTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Wed, 27 Aug 2025 16:22:16 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9052.023; Wed, 27 Aug 2025
 16:22:16 +0000
Message-ID: <61483c7d-80d3-4a89-b8e1-8f1263eb1ff0@amd.com>
Date: Wed, 27 Aug 2025 11:22:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Add support for hw_info for iommu
 capability query
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250827142250.5594-1-suravee.suthikulpanit@amd.com>
 <aK8opOZJGg7PI9Vb@Asurada-Nvidia>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aK8opOZJGg7PI9Vb@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::15) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: c708e5af-6f05-4b7a-1844-08dde585e2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDQxTkR5RnZxa1gxWVNNL0RaNXc4azA1QTJsNHcxaUxpaXdnaWRRcHUrcVYw?=
 =?utf-8?B?MG9pNnpwR3hVZ0pzc3duYjJyTlJrbnJLK2FWdk1jb0JqV0tZam9GdVVhaWZq?=
 =?utf-8?B?eTFLMFVpazkxZi9IMS9lcmMwRzNVaDZqb3gzZDdCaTlFbGhRRHBHN3V2ZmlK?=
 =?utf-8?B?bk1IV1NqSm8zQkRXQXZhTUR0UWZ4ZGRhQldpc1l2UmJLL0VUOEt3Slh0UDFo?=
 =?utf-8?B?b0ZBSytTbjNTQ0tzZGptU2hOSXY3NFNyMXpIWlptUmRVOHA3Wk5qejQxMEQz?=
 =?utf-8?B?U1Y3Vmp4TlhsWVBPWWhWYVMzMGxyMCtWWndnWkJTNFNaQndzNTNEMER4cVd0?=
 =?utf-8?B?ODh4OCtWT01KRGZQM2ZuZXlhMjlReldqNkJZbzZTVml0ZW9yQ1FIR2l6YTBY?=
 =?utf-8?B?bzR5U0FtTEtrMTNpMURzc0ZJRDBrM2podGtLNFJKbDRsNXFyVUJlTmd6VFRX?=
 =?utf-8?B?OEVYK3cwUjFxbDRXNFljQ0FMc29VdzFoa1JDRUVqcUZhaWxwTHlLNVRzWGU4?=
 =?utf-8?B?TU9ab0Uvc1hqemVFejRhVDlTZkc0NGhKMDZZeWZTTXRweTlQbm5ZcnY2Umh3?=
 =?utf-8?B?L010MlphdGFZcU5IWjJzb0tMb0kxOFZzTzV5VzBsdnNDTjh4cmliMGpUNFJj?=
 =?utf-8?B?Z0t0WExZZVRmL1hkb3k3Ym9sZXg2WldDajJ6Y3hSTTdpVUI2T2tMRWp5VmJY?=
 =?utf-8?B?UFY5VDEvU3hQNGllTTN0dWQ4VENHQm5GS2FpbE1pdFpUdlFPbzliT0d3aTZ4?=
 =?utf-8?B?WS9EalhXbW9NTzNmaFFQV05hSjRtNzNjdVNOOVlKQWFwL0o0b1NjZE1TMm9E?=
 =?utf-8?B?TThsWXdzQmJ2RVBBSUlLdGcyWG5SQ1dHcndsRUFyaE1mYWoxQWxsUVgyR0Yw?=
 =?utf-8?B?K3RNZlNqSitsNDN4Q3hFOHNMNHJaOUNWVFREMXpjdk1SbDBZYjUvd3RORENJ?=
 =?utf-8?B?Ty8wNUFhd1FYRzU4b2xabXBzVHRuemNMc0lEODZXVVZKR3hWZHBCMDRIOVlP?=
 =?utf-8?B?NEdHTW4wRFBZckpvT1NtQm5PcE5GalNQcDFYL0RjMkpaMjdzNnVzc0ZGU0pi?=
 =?utf-8?B?cWI0TjUzTVFDaHNkWGRVNGd2bUo5Wm4rTGp2NER0TFZPNjMrYm02bG43M01G?=
 =?utf-8?B?ZTV0TTErYzJIQ0lWd0pMNDd1M1lNU0tRTmtOYWpHMEhFNXpiWHVlSWw5L0Y4?=
 =?utf-8?B?YVJlUXFvZU1VRXNnb252MDY1RVYvYnIzRjlLaW5yRE5QK3pucFNWUUJrWVRB?=
 =?utf-8?B?eVM3TFloWnBVV3BhZjNhcGZyREFJc3QrQkRJc1l6b09aOU54anFSdWRwVEt6?=
 =?utf-8?B?ZGxZTDUxTG1IWE9Tanp4NFNMQjZDcWxWSTI2TDhUQVUvK29HUTd6QTNKWFV6?=
 =?utf-8?B?ZlVzTG1VMDBPNlRoRSthZHhZcVppQUdMNGhHY0dFSXJqdEJudU50aWxkYnRS?=
 =?utf-8?B?eXVta21ZNTI4cUc0ZlNQOWpMa0xaUXF4bVZ0d2p0N2FueVV0cnpnVTZuV3dI?=
 =?utf-8?B?NUVMQVRGZlI1QjlXT1pCYm0zdWNHMkFucFhiYmtLakZNSXJXNDI3TVFGTktJ?=
 =?utf-8?B?eDQvbHVTL3pCbldMUk1ZTS84MUl0SXhQN3NTclUrM2M0bVZMZS9HemNISXk1?=
 =?utf-8?B?OThzYXlmcyt6ZU5hZXZNb2VPSmR1dnRGeXNnTzZpd2pqWithdmNWS1JiaXdh?=
 =?utf-8?B?Uld1M1dhdkpGV3dua0s3UVo3ZCs5M2tPUXhoUU92T3dxRDlLbU9kTDdNM2dL?=
 =?utf-8?B?WFN0SVN0cFRnbVNCbGFwTGllcHh0KytZNkR3bm53S1dEaVpBbW1yVCtZZ1VL?=
 =?utf-8?B?anR0REJEL3BkMXZ3MVdxS2MzTW5YOFArQnFBQjZnU3lmMWVDMHd0NjhyTDhL?=
 =?utf-8?B?Q0FBNzU1eTA3K2E2b2Z0WXQwZWcvTkJ2bU1BYW5uSHhUdnFXUncrOHlZUitC?=
 =?utf-8?Q?BF95Aiwe78Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkxabUpGUWhCd0c0YWRhQzRyN1Z4K0JsSmwvbDJlWDhxc29CZytMcGxkRmJt?=
 =?utf-8?B?R0RzeFVaWHJsa0FMeUtIS2hBVS9zOXFKenZBUHdrOWtRUVkvUCtIZzNSVkda?=
 =?utf-8?B?L3JWRlh2MVFaNVNmRjRzVWdKTzNyWUZneTMwcFozcDV3YzRzbXU0TEdYV3NM?=
 =?utf-8?B?VXh0YXR0WGJ5R040enRhYzkzY1ZoNEZpYjFKcFRmTXZkdlYxMzJnS09SMlZH?=
 =?utf-8?B?TUIvbU0zM2VrOW8vWnQ0ai95cVR3L2s3endXeDF4eTlYN2dVaHh2enRNaklS?=
 =?utf-8?B?U1FINjFITUhucnNNdTZRazJzSmZHMUFwcmRDRmlTNTFOTVgyYTFEZDVsMG95?=
 =?utf-8?B?OUp0QnRrSXcrVUc2bGRmSTZPbDNYQ2g5Q2lEQ2JmYmlQaEQvSnRVMmlEaThO?=
 =?utf-8?B?eWNia1IxR0xnUTcycm5WSk0zVWlRdlI0ZU1NUElZRlR5cHFVaWdyRExIemFK?=
 =?utf-8?B?ZHJCS1JCNm5nZWdlbC8ySi8rS1RCQnBUUHNYeWhnZ2dad0NsRHcvSlJUaklL?=
 =?utf-8?B?cGFxdml2RkpDU3pQNmhiNUlBM0I5S0hRTmFOMnNabUV0Z1pUSllWdGYvVTdn?=
 =?utf-8?B?OWhSZUVUUTduVTFuS1hCNDkzN0JZb0xQT1ZlanlIVmQ3djhQOEZwdmpySE9O?=
 =?utf-8?B?K1ZIS3RHQ3NlQ1l0V0UxNHhlTnNFUmVaK0NRM0FObWNqeTdIaXIwZTQwaENZ?=
 =?utf-8?B?Y1FvZkFkVUM2d1dFZkJ5Z0NrOEhURkVuQitsRnhLMUhHOEhkVHBvWS9rVTNP?=
 =?utf-8?B?cDRyR1hyREdmT3dTVjVyQlkxWkRJLzRrMUg5c3RQU3JKQ09LbGdqeWYxbGdH?=
 =?utf-8?B?VmFTT3plUWg2SFJ4WjhnL1F4ZkhxT0hiRitLMGtSSkJGc25pUmhpRkwyQnpo?=
 =?utf-8?B?M01sTDU5MFNTM3BrMDc1dTg0SmUwdzA3NVY4dnV3a0dLQU1YTGN2M2JSaEJN?=
 =?utf-8?B?N201WUJMd3hjMitNcTk2WjRNQkJIeXJhbjM4S0h2eUtLVWc5R0czTTdyaGhQ?=
 =?utf-8?B?a3ZlYzNrQm45ZnVjd2J6OFRpenRuQmMzSGFXNmI0TzlUdVJ5K0J3TlhxK2Rt?=
 =?utf-8?B?cElMSWFVOCtTYVdMeU12cjFLRUZUUmlIYWRXTXhHcERHUzBoRzZJVzBOL1Z6?=
 =?utf-8?B?MTNmYVVja2hpOXlqdVdRRVduVXNTWXhEZlp3MjhaTW0yV1BJYTlXK0cxWThW?=
 =?utf-8?B?SlpXMVhkdGllV0Fvc3N5RE1vSUhmS25aVi9jOWVFbkF5bkMvd2gxWkVHbTU5?=
 =?utf-8?B?dU9ybkExZnlseTV3QjVrYlk3RTZFckcrbnRIT0lTZ0IveXZVTFJzM2V1RTdC?=
 =?utf-8?B?SHF3TU5LNkZSUmdXdWM1RDRyWEluYmdLRFI1S2Q1aGFEZW1nYVQ0ZmsrS0x4?=
 =?utf-8?B?RHhlQlk3T1VoR2J2eWcxTlFqQjhIUXQwYjBGcVBIbEFIWlZESGFVYWxPa3NJ?=
 =?utf-8?B?UDMzTFR3S0VndGRNVVFBVXh5TllpY3dYQWdxL2x2eGJxamp1azN1VHJqUGhp?=
 =?utf-8?B?UXVsWjQ3TGVnSExUM2tIYVI5azhtVytIL3RLWTRMTkxvNHFESW9GQjcrY3RD?=
 =?utf-8?B?N3pXSEczVThHMTMxTVpBY2V4aWZ3a3pPMGNJT0lqRHh3QXRld25sN01zcitJ?=
 =?utf-8?B?Q3c1dlhydlJJV1QzT3lRMHdaUUhMZUxtcERyZy9WUnNnNjdmeTMxUG9NMXhi?=
 =?utf-8?B?MXlta3k1akNUQUt4NmsvZWdZVFJWYmI4QmtSZVh3UjVXcWV4UExabmFoZXpG?=
 =?utf-8?B?bmQyMjhWaE80Qit3OE50Y2RkSzJYMWVha1NhZnBSWU1jdG5JV1lvZlBEZ3VI?=
 =?utf-8?B?L21GMGR2alhXVEJIblptdVVOcFhRT0QzTFlHOUpjb0VSMHVOQS9scVdWSW1N?=
 =?utf-8?B?cVYzdTZhdzdpRFJ5eEpqZ2ExNTBxeWVFbk1zbGJSM2xvYkNEOEZUZktXOXI0?=
 =?utf-8?B?UUErZ0VJeGlVdW4zSU0xd0lCaFo4VFgveDJ5VXpGRElDeTR6V0c5dDlTL1pJ?=
 =?utf-8?B?NnNxeUFXV0xlMGNLM1VZcWdtSlpOb2F2MndKV0U0UEl0NDB0THcxcjNnRWZJ?=
 =?utf-8?B?VWswZFdzVHlhaU5GV242dnZSZzRGRXh2UlJrZUNOSVNaVWpiYVJnTHlMNmJs?=
 =?utf-8?Q?oEZqRMd1VYwToSx3IjHSGsogD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c708e5af-6f05-4b7a-1844-08dde585e2e5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:22:15.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qcQsIAZtGi9wQIS1kZmmK5mkabjDsvR4jQ70Ku230Ds9WO9bfnrvORQ69+d4FtrqsL8xm+eTdnSuGf6coWxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490



On 8/27/2025 10:47 AM, Nicolin Chen wrote:
> On Wed, Aug 27, 2025 at 02:22:50PM +0000, Suravee Suthikulpanit wrote:
>> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
>> specify features supported by each IOMMU hardware instance.
>> The IOMMU driver checks each feature-specific bits before enabling
>> each feature at run time.
>>
>> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
>> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With some nits:
> 
>> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
>> new file mode 100644
>> index 000000000000..7c30dcc66a59
>> --- /dev/null
>> +++ b/drivers/iommu/amd/iommufd.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef AMD_IOMMUFD_H
>> +#define AMD_IOMMUFD_H
>> +
>> +extern void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
> 
> No need of "extern"?

Ok

>> +/**
>> + * struct iommu_hw_info_amd - AMD IOMMU device info
>> + *
>> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR) reported by hardware
>> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2) reported by hardware
>> + *
>> + * Please See description of these registers in the following sections of
>> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
>> + * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
> 
> The link gives me:
> 
> 404: Page Not Found
> Sorry, we couldn’t find that page.
> 
> :-/

Ah they just update the link recently. I will include a new one.

>>   /**
>>    * enum iommu_hw_info_type - IOMMU Hardware Info Types
>>    * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
>> @@ -629,6 +647,7 @@ enum iommu_hw_info_type {
>>   	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
>>   	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
>>   	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
>> +	IOMMU_HW_INFO_TYPE_AMD = 4,
> 
> Missing an update in the kdoc above.

Fixed.

I will update and send out v3 soon.

Thank you,
Suravee
