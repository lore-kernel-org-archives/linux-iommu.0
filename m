Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBD33EB09
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033690; cv=fail; b=iKeRaBscHF/VcnvcfSOzvznrQZarAPeKJi3sQqfKyo7KXDN9L3dI7UcYBhl4pyYTYFEwKEpQqfAk60EvDmopi0OYp8rbXbUXkpNksaC/VJ8NdQVlLN2AcqaKeaRitGwcsgzYC6F0qpXORwrErLDdEZwxnwyEPwlVvg1SFMDuPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033690; c=relaxed/simple;
	bh=5J8mvblP6zOW2upbcYFGzZo1wcqg2rhK156U8tDbGK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0FFMRdpkzioHgf7NEdh7VrAMjGjZ7xK+U60h9PilCzrdcNBzoZF/2e9sK5y3V77yRhGc93oC+jioClCNFrBc3RKit43UNB82hRMf3Zy2MPEGiB4gmPSb3JjE9Wh7XnXs11ZU7Hf+ayzJCGPwum7BjCp1fsW4hcAsnF8lr1j6Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HmUNkUBE; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HmUNkUBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwNCiBYeu/Py9Bkjwxb0fcq9Hes+0LedDv6pBXP/udJlm3GvJ+dHIC6qrV76P9Iw5mupVo7Q1G/WRhU0uknL6y+sZe6p36agxAoIaDVPx6jCXhT9mqlMtZ9w0DY3VR8sdtZB9AYEz5yj2AUp8fpGkiVvP1LOYSaWL7hdxtLCNp6STMcI1FGnCgvO5EGROTSIuQ5NTA03401d6rtc1tSCcmv8GaG1eVh5duAz7VCI6r1YPbAgmgxQZkILr9TL4g8QJuDqQ+SX3tAYIqpMZfbsNJ1JJB3vHFyp70l50J+j4t4x8+O3ttlSkHlm7SJqaD1Oq0RlQ9rdfiL01yZoFAQISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/54gZhpI5hQf/06te7Mve/uhnwLBQEprN4FG5ISgZjI=;
 b=pZ672Q1dYqbxrQbk4AXIdprALi9CSuiJ1Rlt6ZsJgZFh8M/Qrvs0/00mmpcxmjfBh9W6DECk+dgC2AiJnrUXLAwxyWaIlCPHQ36+8PA/PO1Eb786Iwe3KeCYBt6KVgCzaFFuNV86/tvwIKhjsebFmSMOztz162HMJX+BzR7YMZWCPVE+XPUJYRPsCkcMPp+n5/h1KhzStKFlQmvNFOO5vAiKnOdM2EtrNcJQ1qxsNdLkx1g6butW0UXC5Lm06GzSV1P4JLLWNqh0e7SnE7OmbzZZv5uf85A0n7HOe/B5daDUoHwDFOytxQf/xU36JFNG6TlUIhLhpWSR5/b1JqGvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/54gZhpI5hQf/06te7Mve/uhnwLBQEprN4FG5ISgZjI=;
 b=HmUNkUBEBXg9zdvTB8AcMTUJitEObL83RacOl3LicSbHZ8zx5TSxTYGJBdTV3SNYxLuNTEcxbIX7M8xYi6WF7FdlBykM6gCwzlsw2bEMOPFeWTbvCS5F1bsDFws6A9L2bhbvHG5C5TLVkuChh8zfBpEIkMl8UD1iMSJez5Y7tCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:34:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:34:42 +0000
Message-ID: <7433bd8e-4e09-420f-8708-3c148aca45e9@amd.com>
Date: Thu, 13 Nov 2025 17:04:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: suravee.suthikulpanit@amd.com, Santosh.Shukla@amd.com,
 Ankit Soni <Ankit.Soni@amd.com>
References: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bbaac6-c55f-4c3c-adf6-08de22a8a36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnBWdkE4M2hMT1VMZ0NxTkZ6aEFEK244U1JLN0V6T0RQTkRRVHNyYVpuY1pr?=
 =?utf-8?B?ZzRUeFNDRmVuTmlEVGY3ZnI2VEZ5WVk4M3NYdit3MytXeG56QkxISlJISkVH?=
 =?utf-8?B?Qmw4K1lRNEtXcVJjMUNMa1NlbGJFdjhFRThpek0wNUVuTXdzb01ncDhUc0pY?=
 =?utf-8?B?amY0bGIrclNUSU9VeHIweTA1aitGR1U1Y1FtTmora3l3Y1lUQWFhWEZXK0Rx?=
 =?utf-8?B?RkpFU1pjaVZMRHAxVUlOVjVUVjgrdC9RVlFUS1hrWnArbUJOK3pGNjBYYU1Z?=
 =?utf-8?B?M3g3SlJPdjVNZWhtSGc2QlF0QjJFQk5ZZyt4ckYxbE03TGRkeEJMN3dhTjE5?=
 =?utf-8?B?NUFiTEtaRk9wejlXZ1lPTkVpN3lFSWdGSjJVUlpFQit0bWM5eWRDK1hWQjNu?=
 =?utf-8?B?UmIxclNYMWRZemFSNVVqbm1iMzJjUmppMzlLYS9sYUxKRkJWV082c1ZNTTBl?=
 =?utf-8?B?ZXhDcmVSVFdqcllwMXQySFpDUHVRejFIWW0vS2c2WWJDMytiWmJaK3h4d0Ra?=
 =?utf-8?B?TFBLNUJvVzFOSzBWMXg4MGxGK3J5amFQWDRSSzFQdGdzOXpyMWVSNDFheEly?=
 =?utf-8?B?RVBvckJxV1lqdjlVNXJNQmd5OERRbS9telBpUytkdXVwQjk5N01LVE0yNFVJ?=
 =?utf-8?B?UUcwZUlSMHZXSWNsSERYNWkraUxBN0Vmb3d2T1RFOEtkdGgvU0xlb1NYd3pX?=
 =?utf-8?B?cFFicFMzWXJiUjdGcG1Oc2c3eEE2bU03djNPVjhPVVRhTWU2eTl5V2JEeThM?=
 =?utf-8?B?aTdwMHNvdHI4MXdWak9TUlN5bVgyMWZWaGpWSFpKNkYxVWdLWlplUFpMUXhm?=
 =?utf-8?B?VHpoNDhNNUFnSENtODFORG5hbmlkRzdZakRWbzY5Vnh4dTZCZzFCLzcrVDJz?=
 =?utf-8?B?ZU1iQ3R5cjMyN0ltaEJFanU1R2ZOTHRDdHdXTExnd3Y3YVNaUHFkSVpsOXA2?=
 =?utf-8?B?bjRoK202dTlUNDlZSHl5em9jNG1qWE1XMVpNL0RBV2V2ZDkxWFF6OWhmeW0y?=
 =?utf-8?B?cFRmaXpyMm1ZRXpuNzJ6WTFsQXBON0JKTDk5OGsveE9LUXh5VDgyYWtGZnpZ?=
 =?utf-8?B?UzRCR2lCSUZWKzdhUUg3MEdLbzM1R1dTb3NHc0ZpaDBzbEZFQllpVmF3UjRL?=
 =?utf-8?B?Tk5DNldpOXF3SUxYN3NsUDhpTTlXd3hTYjhTdFFOZ004NWRMMnhwTHRmT2lO?=
 =?utf-8?B?UitrV2gzUVpVdGFINXB2Mno2ZmZoNWZVSXJrRHZCelR6VVpMUGFsV0tsQkd6?=
 =?utf-8?B?SnhKNlJsRGJCSHBYemRtYXFLeXNDS1NVWXg4QzYvVUF0eVF0VW9XS1ZCZTV0?=
 =?utf-8?B?enljSnBGOVFXQ2JiK1lkUDlLWHUrdWs2c0RVTnFtMXkydVAzVVFpck43NWhF?=
 =?utf-8?B?OEZrMzJxMlM1cU5XWHR4bW8zWnVpYzJNZVIwT0RxUDBWQkNiOGc3VXhvaDRW?=
 =?utf-8?B?UmR4NE15L0lrM1hjenFoamNlbUcrQitka0xhMm0yTFJoRjltSXVDSlVIVUp6?=
 =?utf-8?B?SzRRK2VPZEQ2UFlBZElVRUpjQkpuR3FMZ0g3QlEzWmRtOWtzbWFOWG9QcDVM?=
 =?utf-8?B?eE5DQTRWRFBSWTU0Q04yb2hmVEhxZmw4VkpYZlhMY2ZQeDNRS09HQkptcEVh?=
 =?utf-8?B?L29DRXBsNWNZVDBUZ0wxVll2Q00yRytteFZaeTJYM1VRdDBjTHU2TktMMmZE?=
 =?utf-8?B?YlNGdm1rV1VXNWNrbERBZWlzTHdmM213WEtPcm1sNGxMN0k1WXNyTldNWmQ5?=
 =?utf-8?B?UUpDd2t0RlJhVk9Dck1Ed0s5cEtFYjYyQTNSQmRCYzAyeXRHYWIxRldlM29K?=
 =?utf-8?B?YkZhZFQzTTRBSkdXanpTaG45NkgzZ016bWtaeWN6K1JocDVIaEtialVwNG5H?=
 =?utf-8?B?bWxvZEpiRk0xRVh2Um1vR0NUR2J5a3F6S1IyRWZlUkZnVFNDbW43ZXdrY25U?=
 =?utf-8?Q?ggVa6bZbL5rODp3Hpzk79h4NaMqNhWrc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0JKMFhNbkpuRVdlV3cyZk83MnVhQ1FBSWJsaUovVjVGaVV5NkdTQXl2Tksy?=
 =?utf-8?B?YmpnQlEydDJoUmpVYWxJa242SWl3SXVhSStYU1B1dHN5aCtpTWdpZVdScjd2?=
 =?utf-8?B?eFVxUmZuQnZSSzczbEVwU3Qyc1FER3lOT0FLYk5vdGE4Z0w3U3d6dUp6cTlu?=
 =?utf-8?B?Yy8vWkU5RU1VRVk0S2hnTW9WRjd3MldBSlBneFV4WURhWFJvbysxd0QzeE9J?=
 =?utf-8?B?QVlTdEFCcGRqcWsrUDM0RHRrejU1amR6bFN1TkU1S042K2NsN3VzUkxlWW9p?=
 =?utf-8?B?SFdIcWJDakU2VDRJT09HMSs0NCtDelYyVWxOeFFoTmVxOVJvdEREa3VuTXhw?=
 =?utf-8?B?YnNuUElxQXBZbEpHODhLeFJLaVBZK0RLOW11MzVDUGpTdFpwaWIxN3JONW1F?=
 =?utf-8?B?U3dVTEpqRDdOZFIyekFlTXFqQXZyc21SSUtMK2ZxSitqbXB1MXgvMDkwVXBI?=
 =?utf-8?B?L1hCdzBmVDRRUlBHUitJNVpHS0YxS1AwdGF6UW5ucldGTmY1YURocmNNME9P?=
 =?utf-8?B?N1RkanpNem5zSVRldUt1VDBJWERWaXIvMkN5TkZURW9zTVYzaFBrL0F2dDg4?=
 =?utf-8?B?T2lFTDBYYk16dmFlY1NvUTQ0MWV3Wmdxb0RyOTg5UnlKV1BuL1ZzcUEzYStK?=
 =?utf-8?B?OUpaeit3UGNHMWJwK3M3S1A0MFZBdVVHYW5zWFYxb2FzQ3JQRDBWU0JTRFFn?=
 =?utf-8?B?V2FRendmNkt1S01NZEkrMnJKZHlLcW9aT0dPTGI3M2dYVlJxVVBTMGpHQnBt?=
 =?utf-8?B?MkRYVUV3eDZqZUljbHArVzRkUlNRS090MmN0c3ZDdnR6WW8wZ3hJbGcybFA1?=
 =?utf-8?B?UVVmUy9zVEwwN3R3Q3IwY284OXV3cHBNUnY5S2lZWTV4SE1vNU40UG5RYXpt?=
 =?utf-8?B?Z3ZRZzF3bGZ2Tk1UOFFRNmlGdlpuZ0VDb3h0TGNTcmwwbWlVSDA4YVd2K25q?=
 =?utf-8?B?b0ErQ2ZKWGlkMzNhVXlTeDBGUGRPNitvMUs3R2ZFZkY5K3NIVldFQloya1ZF?=
 =?utf-8?B?RENlUDAwUVVJbGNmZk5jSlFNTHNOZ0VYanNwNEFzb1BNRjdLMVdrVlRFaDJU?=
 =?utf-8?B?TVVKSmFvQUVCeEtQb2czMENZVDR3R1dXNU1LMmsxQmErV3hiS3BvYXJkZWg3?=
 =?utf-8?B?LzlXSmhqdnhNK3FydGExN1ZaWVhqT1RjOWhrdVpEWnUzaC84djNLczNxSWpv?=
 =?utf-8?B?MmY0aDJ4VXpUd3RWa05ycExUeWFoOVJWUi95dGhOaTc3VThjQTVKczNrWm9i?=
 =?utf-8?B?NWJEYVhoN3cySFZhOFVtak5yTEJQMGpybGoyU282aG1jYlhkWWFpd05LS1Vs?=
 =?utf-8?B?VzZDL0NvSFVaWHhJM0ZJcmhEWWp4TXVoWTZyQlZ6NGRPbEVlNkJMM2dVTkdB?=
 =?utf-8?B?LzlOWnpoM3h5blJqZWpibTdUL1BMWFIvRTRzbllQWHU1cndrZ2JrUDRtaUlF?=
 =?utf-8?B?RW5IVWF2Z1JNSnNsc2piRmpzZndISmpqaWU5Tnp4M0g3MEMzdEIyMG1Sam9p?=
 =?utf-8?B?cXoxRVcrc2RtbVQ4S1RudytFM1JnVlBmNTJaYkRtZUY2Mmg5Y2xkVUJqRTUv?=
 =?utf-8?B?clhKQ0NVekgvakNJT2VkRWY5TXd1S2tDY0dOMlhseWtEUjhuRFJWZktTbFBP?=
 =?utf-8?B?WlZvdnFHY0MvaldOc0kxM0dORXduaXRFcTlFY2dmeWg4T21TTUV1bDhWUVZn?=
 =?utf-8?B?dGFiTXQ1MVFlRTFGbGgxQlNTck1ZeDJTOXcvOGx1em9xQzhwcTZwWGRhZzBS?=
 =?utf-8?B?aEN1Vm5kd0ZnbUN2Qkt2RTA4YUFteGF6Smc4RFA2ekNpaFduWkxucjd5Tkgy?=
 =?utf-8?B?ME5tN256dmY5TlZYdnhmdW5ZT0IrQThOQzBWZk9yYkZWMTNzd0lCU3d1Z3hq?=
 =?utf-8?B?K2hkSjdoQzZ1R1VlZ1NzSm11clQwY3A0TVZXQVVXdVV0SG1JNjB4L3NPUWw1?=
 =?utf-8?B?T3hMWDM1bmR5WFJ4VUVaUjZOOUxQZzJtdk95QVB3VmZJSm4vUVJ6MlJiRlht?=
 =?utf-8?B?bWcvTkVNYkZqSWlBMXFiRGZJM0FLQzdaeklYV0EzdHR4QWU4MllucEw2MDh2?=
 =?utf-8?B?MkJpWGN2a0VJdE9yUHZ5OW5jQTEyWk1YZ2QwOEJaOEFDQWQvNFFDeUhQbktr?=
 =?utf-8?Q?rtAq0d3UhuxHLdYW97IWZMRv+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bbaac6-c55f-4c3c-adf6-08de22a8a36c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:34:42.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0d6tmiBytoQ+NLyT4odGl1Iw7xBJzOibMulXcelfXO/38dwsJ32G0rGXs+STXQnQR9nOEB9+NDS8FarNUHYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883



On 11/13/2025 2:43 AM, Dheeraj Kumar Srivastava wrote:
> Current IOMMU driver prints "Completion-wait Time-out" error message with
> insufficient information to further debug the issue.
> 
> Enhancing the error message as following:
> 1. Log IOMMU PCI device ID in the error message.
> 2. With "amd_iommu_dump=1" kernel command line option, dump entire
>    command buffer entries including Head and Tail offset.
> 
> Dump the entire command buffer only on the first 'Completion-wait Time-out'
> to avoid dmesg spam.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

