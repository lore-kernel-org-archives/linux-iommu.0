Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E337404F
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180812; cv=fail; b=ct/0cK5koDocaiTEkEM9pUox6f4s2sr+cAtc9jrrdXP769GHVJPsS7XPycvOxwHlgFalE94/+O7X8AnG6Ya6JGGltQfkcbdzBgHtFXbYWwFOJAXwthbtDNlYVM00GLac1Z+33rnIZ++jPqcLfHxCs3NUpcRr9ug/vxlHvE/tj+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180812; c=relaxed/simple;
	bh=NZR/gTCL0+QK6KyxGFWLey2GlGexBepSYPgmU5mLKmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paHaYBZI389YQNr8VYst/qabP+pC/xoAEF3aNkB+rYmriAslZDD4YZaPMnsqe7JPVmjPjkgobx5Ed6+i3Jg/GBC3Tz1UG0wPWI3h2ejscCseuLOAZgPW3Km+FPnVXlIqppcFE/vDqnxvGml1oFEyMsc34iuTC8EeP5PQXOIP4V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vM6GqPWO; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vM6GqPWO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qmra/psyXBDa+I12k8mInVaRJdSIhJW5BnY2PVx2VQKtyBUQuzk4B05nrBggWXgxdQaB/xi3et6s49jRYVHJuizl6Q/Sc9N5YN1vRl4j9yFZzwM4i1dgfyM6ULnZtiu636RMPZbq+Qy7ne/OfutudTVgnSFfiALmzQxHVibZA++x4TIIwzpXaC7x5XaWCI2CLhWWyGNlNFUEofrAGsUiYJSrjVXJisPcuX0/qAIq/W0DU91fSd88F175rBk8bEWb1BFcEVrRuytyVKzfj3XuS7J/DXOuLVQ7YMcEb2FdTZia7mQmCm4IcE19thv9MfiXrJkw41Xm8D8MECuTw9LHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmZ0d0tzWvfPLJS7EKfRGobqGjuH+5geGv5lXujExqU=;
 b=jEb+yVbUVwrRO3ceOg7opwNkuLrIxdhMoK3g+xkNH5SmFHP2snKgwxCPgjRN4F/bmVTtCgjUlfL6ZhL1pcloy9O32V8e05DpnzBPImTY0+Hlv5e7uQDKFdrEcIfT8rQuQrgdMwbUNK4THddzqFo++cDEnkxorgrmrgDj3KK0H+W3+bCFVLddB1IvBjzNidg5DPT1GF2jdH1BX+9xkmdA7+/8Cv9Zn7yfLkSOq31FeO7dDT9uB1H23f/aDU3kT5iTbdtVa994tErOL5929LPZxNJ6TqR8zvO7MESV6gPxvXBQJhfC6HXd0/50NUo04BRWujVVuykaj6iJ0ReXgXbx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmZ0d0tzWvfPLJS7EKfRGobqGjuH+5geGv5lXujExqU=;
 b=vM6GqPWOh3N0Wkm1MlUqyV2B+cduCYD80ZAfPH+Es3BcOKRVEV32f107bfPd1AhEEMb2wlyaUfn1moskBpZ23NqK/SmvWDFaQZaFsfMAVF627lwJRFA+p1ebFo/q0aJzl5Zh62dG9L6n3CIr/yox37DH+PU9PmkTBCBpjiSI4LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Wed, 12 Jun 2024 08:26:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 08:26:48 +0000
Message-ID: <0192198a-8150-465d-ba74-fd7ab7af1b72@amd.com>
Date: Wed, 12 Jun 2024 13:56:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Fix "execute NX-protected page" when
 running CPU hotplug
To: Adrian Huang <adrianhuang0701@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Dimitri Sivanich <sivanich@hpe.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
References: <20240611155444.860-1-ahuang12@lenovo.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240611155444.860-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e96c4bd-1528-40a4-a497-08dc8ab966d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVQwZVdEajZzUnBCZmorcHg3TGNVVDJJZEhobzV5SWsxT0NrcEIyVDdlZnFF?=
 =?utf-8?B?Ym9XaUFLU2VKcHZwaXk3V0JFOExnQ3daQ0ZtOEJtckpQQkdydEl3bk1YVFha?=
 =?utf-8?B?S2xQN0syc3VVN2dJMktFQmNEQ0JlOXB1cVNqc3VFWWFzbkVZOW8vVGdmMGc2?=
 =?utf-8?B?dEl0c3hHOWp2aS9jYUZ2RC9DY0ZCU0FmK1FUeDdTdXR5Mkl1dU41eVgxYTBV?=
 =?utf-8?B?UmlERUhLWWNQRExqVzZhWHBQd1BZM0FkNmVic3dJSG5BVUZqUmZhcDBFeDZM?=
 =?utf-8?B?NVo2MXhHdlp3WTdubGRETmg1b3h2NEloRkJrZnIrdDRwc2N3TXNETG5wdENj?=
 =?utf-8?B?b1JnZVlrMzNqOE0wVFdrUG1tQ3RmZWVmaStGQ1NRK01nRmVaTWZPUkJodG03?=
 =?utf-8?B?dklaUzVGR3BLWG9kTUk5KzJDQ1NNaHZnYVltMGkxQ0ZKOHpLNHpPbFg5MWx2?=
 =?utf-8?B?TjdncHdJSEUxb3V3NTNRZWhVTFV0bGg1UWNZeVlFUk02azBIQngvVDk0Y1Fq?=
 =?utf-8?B?WUVFNEVmRXZsNzNRM0FwN1dvOFQwTVJNZ3doUVZuelFNeU50Q2FtU0lIcGJR?=
 =?utf-8?B?K2U0cHZ1NGE5bDFOZkY4VTlJNGV6VUlmZms4TXlROFpETis0ck5nb1JOUlZU?=
 =?utf-8?B?SFRPSjVMbmEzWlVjbFpTUGNROTZrZEZRZEovMGIrOUhCbXVsRUlFbHR4aTdi?=
 =?utf-8?B?L1hWWkEzVDFMdDVNMWhvR2hyblZTWXRQSHlhSDFKaW1pRVdNMjdVcVh1OGxh?=
 =?utf-8?B?UFN3RGw2SDM5VXFCckFlMUh2Z0c3SmdCWE5Rekl6OUtkSHhTQmIzTUxOaXhq?=
 =?utf-8?B?ZllWT2hnU1pHYWk4a1RRM3pYckZWS2lZSXRKNW10ZmhJdW5IN1ZlUzg4K1lJ?=
 =?utf-8?B?Vm42MzJyN2RpUnZmRjZFdEhjdGdNb2I2Y1l0TmZHcHJjYmovcG00RHZpOUZW?=
 =?utf-8?B?Ly9HZXhJZHFyelVsYWwzYVZHeFJjbmN6ZUg3aGVCWHBqUmFIN09VSDRMVlBo?=
 =?utf-8?B?Tm5FcFphUlZ5RVkyZkYrdHErNzVvbmVqbGUwN21OR2VKZXo2MEZ2YVFMRWRB?=
 =?utf-8?B?VVZuMWpDcjVMRXIxUko1OFZxVTdveWxuK0huNEdGak5TaS9TZ2VyWDBSMTVX?=
 =?utf-8?B?UTBqa3gxNEMxNDI1YWc4RVpNYlVtUVlvVVE4U1pZcTdRY282Vm5MdFByMzNm?=
 =?utf-8?B?Z1ZhZnM3RS9nWS9QUmhRRUM5Q2l3dHhiOElEWUQ3YXRtZnU5eFlEcWdubHVn?=
 =?utf-8?B?VTV4UDFRMWMraHpIRU5BR0kvSUFEV0l1WDlaQ01rRVNDSDBFZTVQNDRuVmVW?=
 =?utf-8?B?UktNbDhXSkgzVEk4b29vRVA3L0lVQUdDL3c3R01PWGN2c1JsSHZEejhBR0sz?=
 =?utf-8?B?NElZYncyTFdrd1B6dFFOMGFiUGFUd1FnTS9vVmYxNzRPc3ZYbTBQR0ZuNUI4?=
 =?utf-8?B?VUFlUVlBL0FnaDRJZ2FodUMwTkpMbWFqZml3VllVdkpjSURvbmd4dzdmcTF5?=
 =?utf-8?B?RnVHUVdrT2YzaE42Ung1SmJsTXV1OVZySEhtQWVNTWNTRjdkUkZGUmd2enNm?=
 =?utf-8?B?eDVXbnh1UCs3S2lXdEk4Mi9tOWMzSzZkRlNKTy81OFJHMkpnUy9UYUkxZjBl?=
 =?utf-8?B?aDBJdHhVczR0WmorYXp6MCsxUWlwOUp6eGRvOGFOcjNNVzc4SUtOdUgvTWRs?=
 =?utf-8?Q?nn7NJtZt3emX25mLW95j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S24zYTBoTGovTTdkUEpEck5zZ25HWEtpUUc4WGdic1dZNU5KVEZwSzVKNW5s?=
 =?utf-8?B?blR4b1hVMDIzaVU1NDRCWm5pU3B0bGFYZmRrR3VqZEJwb2o3aUJpZDUxOFRL?=
 =?utf-8?B?SGlBLzF4b2h3NXpiTWxhWGk4bk9IMkdZZFR6NDhYUGxHa0c4M0RjdFg2SHZE?=
 =?utf-8?B?bHF4MGdYOE5jbm5aclUvaUVGcmFCamZ2NEtvakEwbFk0Um1xT282a1ZtK1pw?=
 =?utf-8?B?Y3BBeUc1NTNac0E5RnJ0SldLR294eVZUY2RlZ0E1QVZ0R2ovYlRvaUdaakY4?=
 =?utf-8?B?QThINGd4OFRKVWdLODBMVitheUtaNjFVYThYaHcrZ01wWUdjRU9UcWxVOFpl?=
 =?utf-8?B?MHNpUjJmS1ZQSisvS2pHRUpBSExpdGprc2dQSXFXYlo4TFhYUGZsUm1QMTBN?=
 =?utf-8?B?RHoyOFMzT0xVb3BCVTdiWFJnQ3ZoOEhCZUM5OEZtVm5RZVdPMXJ0ZDFPcW1N?=
 =?utf-8?B?aGhET0twdis2ZzNuU0k4OXVFdVFta0hseFpNWDhKZ0hsalJDeWJLRHBrVEM4?=
 =?utf-8?B?cFhnY0hjWDRiYVJVeXNnU2h0aC9MalJMckppVzZRUzIzbk5oQ1FJMXFyQys3?=
 =?utf-8?B?RXFlUVEyOXhzbFNTai9WZGlNSk1FVGdOTEo2VGgzL1dOcUlCU0V1dUY4RFVY?=
 =?utf-8?B?NXArbFNPL2lZa3Z0MW5YMkplQWtDY0lxbXVBdWRJNlRYbnNBVE03YnU0dk9r?=
 =?utf-8?B?VTFrU3N5NzJBT01WUy82KzhPZWRiV0FPZnBOaXdqMUlta0ZNV0NacVFLVVZj?=
 =?utf-8?B?TnA5d3FZeXROWWxmUlNZNEVRRHRWWUh5YjE4OTduTDdjbkVneXpVYk9iTnFK?=
 =?utf-8?B?SnhzN21CS0VyaDJiaHRORVBKQ1ZqUFAwOWRBRXo2UkM4bkV3YXJBNUZpa3hw?=
 =?utf-8?B?bGR3NEdscHpobDFtT2dUN2xFckpDUzl4RjhFSVErTXNTNlVoRUZYQ21jOWZ2?=
 =?utf-8?B?cnNjUmV4RWV3R3JTR29YUm5XeU04ZndTcWh5UG9uWTNTWnZNMlBPSldzVU9v?=
 =?utf-8?B?SFFNNnZDeDhrbjNOaFV0T0VuY2JsK2hZNDY3a0E3ZzZPck84UVl1d2g4NHBq?=
 =?utf-8?B?Q3VEbFRzTlh4SXJzWWxrbHB2Y0E1STJjbjdzOUl2L3c0V0RkeFZGZXZqZEQ1?=
 =?utf-8?B?cFFFNitNcVBjbnlIZUoyTkNhQUNJOGZocFU0dnNQdC95a2UrUDM3dHhGSFVr?=
 =?utf-8?B?TlRpSDZTb3EwdzlFMkxuRzZLR0FMVkFWRE4rN2F5UWM3Y1RIRENxQStiZ3hq?=
 =?utf-8?B?SExyYkJJQkFWZ0VxTXk1MDUzQUorNW9vTlluTkVSQ0tDd0tjNUZlbUU3citO?=
 =?utf-8?B?R0pyL0lSREdDQjNpYkZObXhpNTFtVXdqMGVUTVRJVnJRZjRyNW5XRDRYYWNu?=
 =?utf-8?B?WnlNaUM3aUlubzZSZ3lKallZU2dlSkNvQWxqcnpWQTZ5RFpKV3V3WjYxNE15?=
 =?utf-8?B?NHczVjM5K2RUbmVKTXcrUmlGUHdnSEl3RzVnRUxLNUd5c2xIQmdlSEhXSXV3?=
 =?utf-8?B?UE1UeHVlbmZCSmZ1anliRVVtWDJLbjgyRkdZWEc0UWV2TjVRR0VmVmN1cWxS?=
 =?utf-8?B?TkluMTJWOURMRHJDMVptaFE0TlY5SWduT3RVQ0Ridm5mRUpIOHNjam50YkRw?=
 =?utf-8?B?dFdCZ1g5UDI3bDZzR0dDRU1xVUZCbCs2bCtGSm15WHVKNEJkdHZVTzF5bnV2?=
 =?utf-8?B?YmxtaGV5dzlQQnVLUGJNTTNSS1JEOUhnVGxOT1Q2RVJ2TVcwR2VSTkYvTFVK?=
 =?utf-8?B?RkUzZEU0Rk1kVWZ3U2loVHFhRitNZkFJQ0ovU2dodHdiaVU5cWlmaWdMbU5p?=
 =?utf-8?B?bVRLQlJKcjJaT0l3ZE52WUVNeFVXYllhd1VDUmJrb0NHVDdKNUUzK3RRZDJ5?=
 =?utf-8?B?bS9aNy9WN3N1WC9nOUNVUk1BRlVlOXBPWkZLWGcrWjQxV3B6ZmNLTXdoT1BD?=
 =?utf-8?B?RWxKd1d4S3dnT0Z2cG0zTnNCUEhRd29ZSjFGTGUydm5MU21kU0NueDlHM0JW?=
 =?utf-8?B?TDFDMitrNU8wcUdpSWtpekFHTFRoc1JaRU1BNTNvYkkrSk1CVm4rTmZYQnBG?=
 =?utf-8?B?M2RHUmhlY0F4VDBaL3pDWXBTMkcwZlhDQjdNMi9IZSt6WTAyUmFXeCtLZ3JY?=
 =?utf-8?Q?cDY2kcE68bXnIwIxLYAjqJxqr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e96c4bd-1528-40a4-a497-08dc8ab966d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:26:48.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wFuypnCzVNj5S7iZDfiRfLw3wWNQtOg8ObAExSBTHGUM2WhHVIrkSph78iInQc3sKUOlL3v7ILxGgudSm7hYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

Hi Adrian,

On 6/11/2024 9:24 PM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When running the following command (cpu hotplug test case of LTP),
> the "execute NX-protected page" exception is triggered.


Thanks for the detailed report and fix. This issue has been discussed and we
already have similar patch [1] from Dimitri.


[1] https://lore.kernel.org/linux-iommu/ZljHE%2FR4KLzGU6vx@hpe.com/

-Vasant




> 
>   # /opt/ltp/testcases/bin/cpuhotplug02.sh -c 1 -l 1
> 
> Here is the call trace:
> 
>   process 14301 (cpuhotplug_do_s) no longer affine to cpu1
>   smpboot: CPU 1 is now offline
>   smpboot: Booting Node 0 Processor 1 APIC 0x2
>   LVT offset 0 assigned for vector 0x400
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffffffbb559170
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0011) - permissions violation
>   PGD 1ae25067 P4D 1ae25067 PUD 1ae26063 PMD 134abd063 PTE 80000000
>   Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 24 Comm: cpuhp/1 Kdump: loaded Not tainted 6.10.0-rc3
>   Hardware name: Lenovo ThinkSystem SR665 MB/7D2WRCZ000, BIOS D8E121K-2.20 08/12/2021
>   RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
>   Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   RSP: 0018:ffffb4e243fafe48 EFLAGS: 00010202
>   RAX: 00000000000003c0 RBX: ffff90f4baea0820 RCX: 0000000000000000
>   RDX: 00000000000000ec RSI: 00000000000000c0 RDI: 0000000000000001
>   RBP: 0000000000000001 R08: ffff90f4baea0848 R09: ffff90f184a90d00
>   R10: ffff90f184a90ce0 R11: ffff90f1834ebaf8 R12: 00000000000000c0
>   R13: ffffffffbb559170 R14: ffffffffbaa4bd00 R15: ffff90f4baea0848
>   FS:  0000000000000000(0000) GS:ffff90f4bae80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffffffbb559170 CR3: 000000001ae20000 CR4: 0000000000350ef0
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>    ? page_fault_oops+0x75/0x170
>    ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>    ? exc_page_fault+0xaa/0x140
>    ? asm_exc_page_fault+0x22/0x30
>    ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>    ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>    ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>    cpuhp_invoke_callback+0x2cc/0x470
>    ? __pfx_blk_mq_hctx_notify_online+0x10/0x10
>    ? __pfx_smpboot_thread_fn+0x10/0x10
>    cpuhp_thread_fun+0x8b/0x140
>    smpboot_thread_fn+0xd9/0x1d0
>    kthread+0xcf/0x100
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x30/0x50
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> The address '0xffffffffbb559170' is the function address of
> 'amd_iommu_enable_faulting()'. However, this function is declared with
> '__init' keyword and will be freed in free_initmem().
> 
> Fix the issue by removing '__init' keyword since this function is still
> needed for the up-and-running kernel.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 27e293727095..161248067776 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3362,7 +3362,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;

