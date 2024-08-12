Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078E14D712
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454529; cv=fail; b=ql1RR+dVqG8bsJR6gGk4hsshrcwbh6e1Pm0jiw11pCvlTjRjLmWbPz2ZmD1d5FH2OLbWoDGFXCR6M9T++9+rqVGS8O036uACLDXT7cEQxwksbu0y3iBZ0tzAiKiI5Ru4IH1b98y8AkL2xk+OfStUtTr1YWHuQec7o+gob9qgcWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454529; c=relaxed/simple;
	bh=MIYd4UXfUOuy2XNnEc+vi/Z/2svlFm48GiHvMyrsKoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CgxGtZfeRmH/tpjHs7P6P6c3qzPd1yPOJ9j2G+eTq9eS33lLiKZxs1fJMHLokyYtPVwN2FH+OWGcdlv7Sgh9vKBnLpkhT7f23YFyIFL8LCu/ng6kbs5eJDjQT0/exiJx+MozAHmGL503FWXAOReFso9o3JQLb9De30XmSMiqUPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F4ym76+y; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F4ym76+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1DcSUcXmYywLQQoFSL3sFCoIgk5JpB+0aXYnlD1h7qpaR9qVA1UQKs7xmsDjVUIPLkCoTrOqDJL83p9v/ZE/L7kIvxRp8E5SCpaOxMDUYnOAhoiWDORQY4TqtR/k6MDL+LFf3gPb1DoXa9yIhzCO32WDWqMfR8A823VSR2BUkf+T9zgiBJ4mErYQCEpT//hE4d4upWXOTJjgCw/sg1jOissiSqGv7v/Dkxp+F6PzQSNVlEwxurjb6GB1R32HeVDdscdAPQjRL6Urt7WYGyqvvdJs8d9zaU9Pf55HYWaf8nTaAcQ/7ZheKl12VjLVnv5g0yLUdl1RP/YXzlvyERmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwWCXjkxrlZxDHELdGci9c9FfJmM84wRy+cxpsEV6nQ=;
 b=J/cQUq1T0/nbOezHVH+Vveb90ryvJ/yNznAzOfiM8OIn0zZ1P2cw8V97QgkJXT424jZP9NHtaapZGGdxsZJOLJ2in3anSUd4VSKjhxl10weAbBoigRUDk1o77wKKe3bhrwuJith/ZJJRTwcWIKHj3f0/jbThbhlO9z3GCT/vQVzVJoJ8UkHXqBW5zOaAA/R6XtOKFFOvYkGYbFIGuWayMRGNuSCFF/k/Ns17E1Rvc+xJRTtKAChmxTNBmZtyoDxCNiuKnX6hHLr/C3UiwjA7PBEAhwbXXPEDvy2/7jtwwAaLcQ2wQ7RGqMhgyBSOGnIV+Z9ujfOgGpi87EYeMT3DyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwWCXjkxrlZxDHELdGci9c9FfJmM84wRy+cxpsEV6nQ=;
 b=F4ym76+y/twZb8N3zFUIr5wkhRzev0Yvx8i5X7glZFeUuTLpQjxX5cISO+O7wfuFpJ+vTKbceZ36kpXsHbNvmFPapwt4MRCNJ6+UKudQojref7CW2f5r8NxSAFqTXxDcGdm+KGLyk72+R/frJoxytbKV37mYmgXbgMsYk+BI/pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:22:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:22:04 +0000
Message-ID: <fe275b31-41ad-4d7f-89bd-bef4788f58bf@amd.com>
Date: Mon, 12 Aug 2024 14:51:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca> <20240808011629.GJ8473@ziepe.ca>
 <20240808130814.GA1985367@ziepe.ca>
 <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>
 <20240809134454.GF1985367@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240809134454.GF1985367@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b2f48b-d0ed-493f-5498-08dcbab03a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXg5MlRxU255Y01JV255VkFkL3ZzeEJodG1UaFlXSUwxdmlOYjE5YU9HN2d4?=
 =?utf-8?B?Q3ZHdGdzUGhvOGJTWGNWMWkvbC9qRzNzODNxa21zQWpjRlg1TmVpd0RnYUNC?=
 =?utf-8?B?MFZWSVNNRXZRTDVUaVFvUmJGcGxnaWhFeHpQUjFtU01UdWhQaExBRUZuV3NR?=
 =?utf-8?B?RmJzcEx0QUwycHdvK0ZEV1E5WFhuMEFUM0dDOHFuVUZqRWpxTUxpQmZQY254?=
 =?utf-8?B?bUtjUmtsZjRDdnRyKzlTeDRxa1YzUWtUS1QwTk1Ua2prdHlmYXRXU2cyU25Q?=
 =?utf-8?B?N0xqN1RsaUZqeDZjSmIyOHlIOThzMk45ajh1Q05WanhDZEJnWVhkNmNrV0wr?=
 =?utf-8?B?VXRibjMycXhTQURtTmJnRno4blNSc09keEx4SVlWTVBzUTZOeS9iZ1pWL0Nt?=
 =?utf-8?B?Tlp2VG1XRkxNUEZoeUtKTDFpVjQ2d1RIYWxNOEdPOXk2NmwzdDlzU3AzQVhj?=
 =?utf-8?B?UUQxL2hjbFpnUFNyZG1UMUhXNmRzS0JKZWNYakQ2aS8xR2IxK2VudWFCSlFH?=
 =?utf-8?B?dzF5SkFFb0xtOFBaU1Jia1VPSUp3NVZUYWhJcXBJclVXenNWTFdDaWlTeUd0?=
 =?utf-8?B?QUxQOUdTcjl0NndJSXpNWEIwS3gzdW5pQnhjbEFoelRMYjNkcGE2bThjRXRY?=
 =?utf-8?B?MFBDZUNxY2xsTU5XQ092cHhJNVluSFhsakI1QkhKYW81WC9DL054TFltTUlO?=
 =?utf-8?B?M1NlcVRyaXlvQmtQZHBwYU1veEFjZWZsUnZtQTBXbzNGancrTzlLU2tObURB?=
 =?utf-8?B?eGo1VkNCUy9ZN1JaSk1xRzYzNkhWSTc4NWJzMGIxZ1NWWUt0ZEJ0WkhKSUFB?=
 =?utf-8?B?MGRNR3dRVGoyUVIzcUxVWnpNN3NqQ3NBNHhIN1VrZmRHRlZPd0RMZWt5R0Vw?=
 =?utf-8?B?cW4yQ1Fsd0IvYlpYQkFNS2NoTElNNmxnUU1PZjZBc0RWb2gvVDdLSUh1Y00v?=
 =?utf-8?B?QVl3VVBWTjlkc2VaYkdwY0ltRlhKVjBIOE9ocm9SczREOU5jY3RyQVVLMkFi?=
 =?utf-8?B?ZWxZZUVMOWhlbEpZaTZIVmVtMndYb3QyV3NUN0FYV21jTXlZVDZVYytjUnhQ?=
 =?utf-8?B?SFlJZ29kQjU0aml4cVc5dEZTRk1wM3EvclAvY2FqOVZzcXFUV2ZQamtrQ0tJ?=
 =?utf-8?B?L3dwVjUwbklPVWM1cC9wTUxraytFd2JGemdaZjJLa3U3ejlkQzNxZnpienNJ?=
 =?utf-8?B?OHRuRmZPOVVvMFl5R09iVVlEb1ljeVpkb0YyekwxMHJRVGZZbGN5eFljTkRE?=
 =?utf-8?B?R2RLS2FmQ1JxZHlsU3VMNVdqc25BTks1RTg2d3RDc0FuV2pidW5oNVBnZ2JC?=
 =?utf-8?B?eHl0dHNndW5FVHdIQnlocDNQcUxFWDNkZXNsTE54WFkxTDdiSnNnak5rMzJi?=
 =?utf-8?B?cXIwWDJkaWwvNUt2d3E4aUFlVmc0eGIxZ1dHVFFkOEtCUG1xNFJjaVkwSmpH?=
 =?utf-8?B?UTNyT0pWQ0lUUG5qdEp5ZGpvM0c0Nm5tVjRxczJ0WFBPWE9xZU13YkRRWUhz?=
 =?utf-8?B?Rm1rY2hleFVXVC8rS1pINDlaL2dWVXhIc3lubE9zTGRIS3hGMmNXWWFJbDNJ?=
 =?utf-8?B?M3VYT3FuRUZNcTNnMkRkUlBJWk5xVGpENnRwb0t5UEo4QnFEYys4SjdwV09s?=
 =?utf-8?B?T0xVaUM4cVJTK3Mzci8zN2FGUExHWHhXck9EVFo4UEVobUpadDFiUWJXN3c5?=
 =?utf-8?B?UWJGVXFCdHhkRVczaG81R0dTM2paQ3ZTem5hWEE2blVrUWVBNkpuVWtaK3RD?=
 =?utf-8?B?NGtkSExMa1p5N1UxcHNxTWJTT1o4V21sNVkyZWtWT1VtV0c0Z2lQdUpLb0lv?=
 =?utf-8?B?dXY3L29sVkIzallBSTV2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdkc0RGUGxJUFpyd1ZZUlJKaVNQMVI4aFJkQmx6ckJ3MjRDN1I0aHdnMjFW?=
 =?utf-8?B?UTAvbkhRa0lLemM2eG91RklUSHN0b25VbDFNMU5XOHMvamVmVURqUFNJcFY2?=
 =?utf-8?B?S0xsdmZRa2Q1djRSU3BuVitoakNYTEpTdFI2R0N0cFIrOWEyUnR1QlA4THdC?=
 =?utf-8?B?TFVJanBMRDVSNmFjd0hMTXdMQTBhcy9YMXZMR1FhVGM0eUVyaEduYUh2Q1Y1?=
 =?utf-8?B?TEFoZXArNmxscURPdXhqOHg2MWNmaUwyTit5dVRWRHRreWxUem05SXhCMkhn?=
 =?utf-8?B?MG5qMnRTMWZocWtIaCtQL1RrVnhmSkRiUEk3WXg5dkZwaFNEK2dGRVpGOU5C?=
 =?utf-8?B?WjhXZzFhNThrVDFieUZjemhSa0RIUDV6aVdzOEdScDZQZ2pJVkNNU2xlRXdo?=
 =?utf-8?B?ZFNBWk9sN0w3eDBUbmRHdUREaU5GZUNPUU5JVWF5SEljMm5LcU9kTDlOejg5?=
 =?utf-8?B?V2FXcXVaVlVrbjBMSkFNWElGSkdlTUVIckhhcXJ0T29YakUxQzB0cGdIM2NI?=
 =?utf-8?B?am1yOFhYOEpXc1V2WjQwNmFEQ1hEa1k5WjE4bko5MlZFMTJSdnBITmYzcVcy?=
 =?utf-8?B?OW04emlZRzhJaTk0MkE0QktZdWFzemJUOVFGZkNnejRUc2lFamFIUWhGaUQ2?=
 =?utf-8?B?bjdyNnVHRVEyaklBRXFiZ1NCa2Y0UEhjZ01CWm9kbk9ka0dqUmR6a05kSzZZ?=
 =?utf-8?B?UXJaUGNhOTIyZG9Db1NUTVNwTm1uaDQ2bFFLMU9zRkN4bkh4b0F5Q2xpVmVm?=
 =?utf-8?B?c0k3RG95djlwQWVJNTJYb2pqd1pMc3BvOEw0WXBQejVYbWJBWWl6MXZFTWEr?=
 =?utf-8?B?L2M1U0U3VVI1ZzluYk5oY1hqbW8vUXFlMnZVTnQrZWdlWUxTRkZiR2ttdTZN?=
 =?utf-8?B?UlQ5UkhjU1lsQ1JvVm45SG1mNmxIR1laaWMzTFVFSkFlK25mVUtULzBQV3dW?=
 =?utf-8?B?dER4ZnVlSEFMRDBER3ZGUG9hSFR3Q3MwNU5nak5kMm43YjNDOE94RDRkWW4x?=
 =?utf-8?B?a0I5dVZCKzgrQndtNWduYzdZNDlUdWluaEtqa1FJQ0ZoWEVoOW01RFRrd0Fs?=
 =?utf-8?B?YkZCMjdBSE1Pb25Dbm54STd6WG9ONUN3djBCRCtNTTFLODV0TXR2azA5VjJS?=
 =?utf-8?B?aGYwTmdnMkg3RUl5VnozdW5LbHFaOGg2MmlkSnFDRHN2aEdQQVEzSGd1MDFY?=
 =?utf-8?B?WXhpbFYzUEVrdW8wb24rT0IrVE51eUd5U3J5Mkpwb2k4MmVyT1JZRGRhK285?=
 =?utf-8?B?c2pHdHJnV3NYOXRJUytUUDYvS1dONjE1LzhFZi8xR1ZvYWFIeHpJdXA3empP?=
 =?utf-8?B?SGcwMGc0SVF4NUhMdEUyWlVhT21rV1haL2t4Q0tmU0luU0hhNytZeFd3bDBX?=
 =?utf-8?B?K1pKdFZTVDFCclNLQTd6bFpkbDdXY0dWZW1qM3h5bm51bW9WUEZHby9KVUM3?=
 =?utf-8?B?VkdKSmZRRTkyKzg5Y0JscUFmL0RLZTMzRFFrRFdKTzJjUUtVRGdHUThOLzF0?=
 =?utf-8?B?QmFWVjNYamdLazFqUE40WURseldvUGxWZWlKb3k4MXkzNHZnMzFjTi9qeEwx?=
 =?utf-8?B?QWpsSngrNGZnQnNoejdib0ZNN0VweU03V0tRc0lWaFFVa1dTZExiUnN3Vy9m?=
 =?utf-8?B?NU5FOTE2SlQ4cHQxRWxQTkdvQksrZkVxcFBaU1VSeVM1MzdwSTNuclhTQVVM?=
 =?utf-8?B?cC9jMDM4Z05mWTlrdHBHSWFaNEVVdTNlZ1VoaWYvUzdOSElybHJnSHV6Wnp5?=
 =?utf-8?B?ZFFEenY3UEZ5eHovM3ZTV2xYT05ObG82S3IrZjdJeGZvcmVGc3h5NEFvekQ2?=
 =?utf-8?B?b0NPYXRXRnhJWDFNTk1NNFFSTUNvSHpoN1JUbitFZTgzOHlJSFZoZzQ1a1ZE?=
 =?utf-8?B?OUQ2T2dxcWJRNWh2QzNFOENhZ2hTQzVseGJsSjcrZmZIZWJQUjFSbjhwNTlM?=
 =?utf-8?B?SklRUnd3VWZZTVhYditsVDc3ci8ycjNEMHBqSDl5UzN1RDFib3o2VWpjckRI?=
 =?utf-8?B?TmxCYnEwSG01MzNuTmt0SlN3ZkxUbmRINncwZTZIbjRaZXlwSXlGSUNtcEZ4?=
 =?utf-8?B?eDlSUWsvNWRMWXBGbitZRS9kcTlZL2VKMGFPZnJZRWZXZ0tYSDZPSjNkM2lO?=
 =?utf-8?Q?jFYfX+y27RHWxi8z6UQoSv04s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b2f48b-d0ed-493f-5498-08dcbab03a9f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:22:04.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDtg++GNhU2qqVD77ZDJSGvWap0J3Qs5Gti8zbrKlh0kRZxm4KB2O1dZOYwyG2gMOc+8eqyGkH2sGaYCms5iwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

Jason,


On 8/9/2024 7:14 PM, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:13:47PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/8/2024 6:38 PM, Jason Gunthorpe wrote:
>>> On Wed, Aug 07, 2024 at 10:16:29PM -0300, Jason Gunthorpe wrote:
>>>> On Wed, Aug 07, 2024 at 03:29:47PM -0300, Jason Gunthorpe wrote:
>>>>>> @Baolu, Do we need to make any changes to intel driver?
>>>>>
>>>>> I think Intel ignores this issue, they have nice HW and their RID can
>>>>> use both of their supported domain formats in all cases.
>>>>
>>>> On second thought it does need to accept, but ignore the new flags..
>>>
>>> And probably HW that does not support PASID should reject the
>>> IOMMU_HWPT_ALLOC_PASID flag at least.
>>
>>
>> You mean error out if IOMMU or device doesnot support PASID?
> 
> Just the iommu, yes.
> 
> Like in AMD terms if there is no AMDv2 page table support then fail
> it.
> 
>>> Maybe IOMMU_HWPT_ALLOC_DEV_PASID can be reasonably ignored if the HW
>>> doesn't support PASID.
>>  
>> You mean make it as optional flag? Meaning if HW doesn't support PASID then
>> still allocate a domain without PASID capability?
> 
> Yes, for the RID domain it seems harmless to ignore, I'm not really
> sure on this though.
> 
> Otherwise we'd want to report pasid support through a INFO return so
> userspace knows if it should specify this flag.

Let me summarize and see if I got everything right.

- Enhance iommufd_get_hw_info ioctl to get device PASID capability
  HW driver will implement iommu_ops->capable() to check PASID capability

- Userspace will use above info and calls iommu_ops->domain_alloc_user() with
  appropriate flag (If PASID capability present then pass
  IOMMU_HWPT_ALLOC_DEV_PASID as flag).

- HW driver : If IOMMU and dev supports PASID then allocate PASID capable
  domain, else allocate normal domain.

- When attaching PASID to device (RID), PASID attachment will pass only domain
supports PASID, else it will fail.

- IOMMU_HWPT_ALLOC_PASID  flag is optional:
  If we endup implementing this flag, then it will allocate PASID capable domain
if HW IOMMU supports it (It will not check device capability).


Does this flow makes sense?

-Vasant
