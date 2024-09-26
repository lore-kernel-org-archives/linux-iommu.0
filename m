Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BC5647F
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345881; cv=fail; b=WFuDpWZ3WCUTpnoxreMdcS7sKIwRIw+8Sr+I50MDoY4ql0afp0/xs7b+UKALFxskT5gkvLaLkqFVvxu9UIBn2iUnXfWl5fUty3NTEzzEInneXi6F440Zl0VVW581zzQRribj6pvgEI6yOCcEuvJSgLpF4WcbNStPWaboAiZm6Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345881; c=relaxed/simple;
	bh=CLfhc5HHOdWluf3zs5t2wJDoKude5nop/gw+1UCnmFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKtNFritlYqulsRBKZgEglYwUu+Mmgkn7z/0W+bY/+ZVcwYHX/VEOkIZIUxZ+PMGJcDx+vYlcqZe8Ij6Y2P1Ba1lWrjQqOG8pQtHeGVqNhqfrP2vEKXGlQEY05X1KV5WuH4hBMEsy6B9WiXzpih9u6ThBgYmlavkKjaa9ogmTZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qDVS4MFz; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qDVS4MFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC8MD3OkJGzTGdiL6f8k+ID8KJsVOVRL0lLBn0FCDcVeaWu7DmLxWwd2k3F6bl7849GQDlKpXHNPoY+8BoaeMs55Z1jrBtdtor1Aw5NUuDg6GrNQ8iVnJbMxfiyQxpAVz8cKDhIi7poDdOZuULSBDVgE7RFHvlPJAXHTfiLbJEYxhEqSyQYQ4amLachOAaeegqZa0FVOoqo3JDE1PoCatIyp+DoJtPQZyY9NPDTZxP8MWUZOOqTWvC6m0RLI4Uk+6yh8utOEakttIrZ6vqIMetpjN1AWTBxi8+vrVydLKY7U6xy6iICuH9zkoqH2lILcPP7UFgr53aH8DFOXE7itlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acacl2w+Yc11dP0XAJBX+vdIDrRyZ6o2LA1JYMbGfTY=;
 b=kQOKp+J0jGKJ+i8v7wM/ZANl1TKrfgI5eh/hf3E3x8txQfBGJ4bS4GK2NqsfKTx2RGxvedXXwjODgKl+hsO/tjS4BEA/y6zRtjggk/fc7QwhYUOUEus+sRWcIOljhAebE1Wu2UugbN2fVIW9t5ERx0A4uWJEk+Y2MBR05v0HmDuC81F6G0vSFc5T+tuBhciCaRUUYpDlOfLZaryFE8HD9wPVd7LG+wa9vCZ/HkHOiekeOjWBJgK4D/6I8QiBnIODFaWH5ziVV1HRUohO3MJ+WhUSUgfFPeH4Qh4HcJl2j3LHsH/Gk7tW79yq6xCNfy9DQqjFaIMObSfPSlNrCt+Qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acacl2w+Yc11dP0XAJBX+vdIDrRyZ6o2LA1JYMbGfTY=;
 b=qDVS4MFzxaQeznL0vwgV7AuAKFRUv9PV9W6cBOYm3yo8yWrh/IQ03HzdFpRpaHeaJF079kmNyTTqCcg5rfRk/cyXOz5NQmeITrMzt29eAsPXiF+QiPuUR+ZupYfJgwFl/Sldo4eJunWzzJSiPuCPhfCnvr7cxsO6uBzLxkXJ2Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 10:17:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:17:57 +0000
Message-ID: <d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
Date: Thu, 26 Sep 2024 15:47:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
To: jacob.pan@linux.microsoft.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
 <20240912210207.4ba164c2@DESKTOP-0403QTC.>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240912210207.4ba164c2@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: c4390b50-3546-47e8-0d0f-08dcde147d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFVMdkp6MU1GSHRabm9JM2tlOTRCTHkzWkpWR2NZT3dUQ0V6Uzllbmc5YU42?=
 =?utf-8?B?VTB4TzIvNWxqOG54ZmtwTEJNQ1dJOCs0WUFJa3JmQVlTTzBkZERBZmxQZ204?=
 =?utf-8?B?U29Qa0FBRnNKeHQvOE4yYUZ1NjNlNnN4Z0VVNnVBUUlEVlhlZzNOdGJ5RFM0?=
 =?utf-8?B?RlplcDJvYlozN3E0c1ZXWUlvZ1ZVcDJoTFhxNzRUQ0dkYjZCQWtuNFhyYVRz?=
 =?utf-8?B?OXZwT2tKQXRzYVI3TFl4Z3lTVkkrY0U2YUQ3Zy8vRStaMXZaOGdxVUhRZnlX?=
 =?utf-8?B?L3lVa0RGZDkrdkw3KzNRVndQU09MRzV0anB4WWEySGE0elQ0RXRERHNPcm9q?=
 =?utf-8?B?QytLRVRxY1VDUmhLV1lubUNoU2U3bmVjOVU3d21maGtMRmhrQTlIalgzWlAw?=
 =?utf-8?B?ODRja2VmVWJ3Z0FQc1B5Z1RSVDVidDNFNW5NUUMrLzZvdks0UlNTYjgwVWVn?=
 =?utf-8?B?WHh5R0taeDl6QldHb2pjVnRoRUsvdEJGb0VhbU5ST0ZtZThFaGcvbnRxTWNm?=
 =?utf-8?B?bmNkS3lFNHc2Q1A4ZzV6alp5M1g0cit3MitMQlhsTVFpRHBkZ2hsam4zNWt0?=
 =?utf-8?B?dWZzZVBSOW1PSXlpeXNSOVRFZHBONEdDamhKY3FJOE85YzV4MDhPZVFEdW4y?=
 =?utf-8?B?MDVPNHBTVWxPbjdHWTdmanZNRmJ0S09TY3VYTnE5TUdxWWxoclJQcWdTMlVs?=
 =?utf-8?B?ejRzS04vRS9yaHJWTnBmZENreUxUMElMd2lCYkU0dDdEaTQvRWZjWVJaNDRD?=
 =?utf-8?B?UHBqWWo0OTRNUXpwSWYxeGhlMHZwaFZUNE05Q1JpbVNVc3J4c2xrK0kwcncy?=
 =?utf-8?B?ZVg3eWhQdk1LNG1GYUs1V0thYTEyRmsxQURHRXk3VzZFa2xlY285dGF4LzA3?=
 =?utf-8?B?Z0VJMHdxeXFMbFlHano5L2FSbmxJSWhiRUE2amgvaGZZTHZxdzBMNmMyanpE?=
 =?utf-8?B?SklLWTdRQUc5ZldEVWkrczRrL0gyS3VHSERTVTRKMHJMK1B3eW9TUmlscEU1?=
 =?utf-8?B?eTcwdmU0cXl4cGZqckdROXc3alJ5WUJTTmtTTmlPRmhReGpkdmk3anR0RXh2?=
 =?utf-8?B?VXVvL3NWTExDSXcxa1FrWU54RTNhWG1iMVBkM1lLMldrbjhhZmlmUitWTjlJ?=
 =?utf-8?B?VFkyYkFxdzMrdVNGcWUramM0ZzhURHhxREo4cUNjem52dVZoa2Q2SHgwamhH?=
 =?utf-8?B?SWJDdG45dTkwWXNsb2RmaDFUWklqZ3k0M2p4RFVnMDBQeWlXUVdKTSttTmh2?=
 =?utf-8?B?VFJYWUdhS29TYkpiZXN2MFBncTVIYXA0cEJqMjZWQkNhZ1paK2lrSm1OY3Bl?=
 =?utf-8?B?ZHRWWU5LYVZYdGxjZ2F6ZjV6ZUhtdWpROHpPWEdZQW9yK00xV2tpVUMzV25Q?=
 =?utf-8?B?dmtDc3dXd1E4eVFFZmVnRzhoWkZmTFREcmxkaW82b1JlNUJ4WWVaYmdrS1lU?=
 =?utf-8?B?QmNSTHI5NjZCTkM0aHhWa243NnpnQ05DL0pRa2I3dzU5VUx6V29rWGFLZzZK?=
 =?utf-8?B?cDFkMVBJdjZac25yblBFbnMxQXlEYW1vZEVBdzVMdCthK0JvZ2xPZ0tWdlI3?=
 =?utf-8?B?OFd2WG5Qb3lubSttUXB2QlYySHJ6MzVYZGJJN25FcUVZY0J1N00zeHRJZ0pQ?=
 =?utf-8?B?MEpOcjE2cTRTTENqeWhtUlhHS1R6bEM1cW9obnNNN284WDgvaU5NSWtCZEU5?=
 =?utf-8?B?d1F1b1dmczlLYTNMTUhxZVlIL3RlbU1yd0o2NzFtbmZLakR1R2tDUHZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHo1SktPcmErMUZmUVlsRjJ4YktyQ0JqZERoTEJYVkFVYXJDK0hKZ2xaTEVK?=
 =?utf-8?B?bG56KzBzWUFsaDJxNnRDTTFNVjFESmVTVHJMaG5UNTA0S0VmT3VwcnA0Q3JW?=
 =?utf-8?B?QVFmWUZIcTJRNmlMb01YeTlVblp5cm1UeXY4T05SYmFJK2pBY05GandGUEt2?=
 =?utf-8?B?eEVpalhMNUo4NTBEbzgvZlRlWHhkRnovWmttTklwQUVBOXBGejhhMC80NlJQ?=
 =?utf-8?B?UjBvN01MNTM1QkZFKzBheC9DTzB2M0x1TVQ5eUxOVWhITnhmRWRXL3NvNXZR?=
 =?utf-8?B?NkdnOWZoYUF0VzRYeHdCTHNEQWpEWWFJaDRRWERXTWh3NHpHZHc4VmNDTFpW?=
 =?utf-8?B?dk1rZnY2WXEzMzFpS2k0VFZRT1RUWCt4UDR1RGpCbnkvWVl2UXVwcVBRT0Rk?=
 =?utf-8?B?Q0lTWWhFdWYxMG56VlZYREJENGVSanBLUjVHbXd1c1VDYWxqSGJKeXBBTEpX?=
 =?utf-8?B?eGNIVjJRMjQwQWJkK2JuWWYwWllGZmpuTkxGUXZqNG5Da3p6eVQwR1VmUkxm?=
 =?utf-8?B?L2hteEpEb1hNSWsrSHluY3BjTHVpNThjMVhmd0p5UnorVkxaYldRVEE5SHZq?=
 =?utf-8?B?SkhvREhnMXFRR0FNVXpIb1dWclptUmxiZGg3Tys0UlN3MVRRS21FdU92dmdS?=
 =?utf-8?B?bzFtNTNELzZBZEYzNjEwTzRTRmxZZ0FtYS92UlNvdHJUelFYZ0J4QWtPME10?=
 =?utf-8?B?QXVPaFZiOGpHUCsyNmp6dGlZamhsZFFTTHk1eWM5azAyS0dsbDdHRExibjlD?=
 =?utf-8?B?R0FrQVdscTdsYnUxdGhJbVlvYmcvZldUUEpZZmg4cEQ4VDFwWlNmVHkyeStj?=
 =?utf-8?B?b0dWWjhDeTF1VTRDaStTVndoYVhLelNwcy9OeFE4NkJneFprMDZNRW83Zm5Q?=
 =?utf-8?B?TWE5WGxPU2VvNzBnc2lxRnJva29zaGpKaGROWnd3aGR6WnRZTkgrbnE5ajVn?=
 =?utf-8?B?NGk2b2FBNHkyMGpqczc0U1dyaDZQb0x3cE1VNjc5TXB1bVRIZzNBUXNRdTJh?=
 =?utf-8?B?bFpGWiswYXErbXdaYlRoY2dodXhTdUdzR2ZWNDVqS1N1R1BzMmNGV1Y1Nkp5?=
 =?utf-8?B?L0xGN0lxTlVXRFhhVkdOYlB5SkpuN3RrcjZrWDNUU0VwMlVlOXByejQwbVBp?=
 =?utf-8?B?TmlMVWRmRDJZRVdpTmJCeTBMN3dzQzN2UjladlRoL0RFRlpUN2syRDg3aUEy?=
 =?utf-8?B?SjRWV0lVNUhsamRRczZLb1k2UlVVZlZkZmoyWXc5SDNPbWZzOEIwbloxVHlZ?=
 =?utf-8?B?SWdXa2dieHd5UjJCYy9wcnpraEN5VTl3TWhnVW95RnQyTjFZUmJNSkl2M3Nj?=
 =?utf-8?B?dDNkV3dNZlhEU1ExNGFGYVEyUG8zZkhvSXZ4bUMxY05yTjhsZ2svOWpHNVZ4?=
 =?utf-8?B?QUlrU3pKbXpsOHJxejVFRE1xajdLcTR6VklnVEtMQVpNVVBuanVhZ0R3N0dZ?=
 =?utf-8?B?YkIrWnNFMGo0d2tVSFVuUUkvcjZ6MG5aS096a3ZLblFvbUpnZkhRQTBHWEl6?=
 =?utf-8?B?QUVGMG9kWXh4WFF1a3UyZWRkemkzWlRId3lNM283MFN6SVpoNldSMzFyaXRB?=
 =?utf-8?B?V3JRcCtIdGNocE1iV3E1SUtwMjk2UVFuYWN5UHY4aEY3S29SU1p6cmMwWnZF?=
 =?utf-8?B?U3ZtUXlIdnRFKzdRR2pxelJ5MDNIeVQ4SzYrdERYQXNzWGJHOXI3dWEzOTRr?=
 =?utf-8?B?cXlwckJOTkg3TlF1YnozVytkWVV1ZVFuR2NiaVowRDNuN2VidC8vMk5UMVJF?=
 =?utf-8?B?ZjdQS09NN1pvaEljV3pEbk9HaDlqRTB6ZFd3MUVIZHlNVTN4cEdGcHZKak5K?=
 =?utf-8?B?RjI1M0hiYS90SWRFbm1yb05xb2xqc0VMTGg4VUIrZExlYUpYWEhZdVVqT2pV?=
 =?utf-8?B?ZHF6ZXJ6MjJTbkZidEs4bWtvZmQ1dEtVMnlLNUN4R3Q2WkcrbEh5VEFUTEha?=
 =?utf-8?B?YUJSM3ErMHhjdk5EeWhSbm42NEdKV1VRbnRuVHdhck5MOG5WdTRJQ3FGZVJa?=
 =?utf-8?B?a2dSQXVuM1V4MHlORzg3QUZRd1ZGcDNZd0Y4bzdlYnF5N2dWZ21qNFovVmxM?=
 =?utf-8?B?ejV0VjhyZnQ5YWdjMWtzODlvZXQ2ekdoei9hbzQrbXdNYTB0Zkp2eUpCclhy?=
 =?utf-8?Q?l2Qx6bifdr+/6xK28ObhbNClZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4390b50-3546-47e8-0d0f-08dcde147d88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:17:56.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9eR/ScxQtylhn+B91svv5BNizW82/eoTz1EBeAWyxDnCOHW1kz7I51FLZTmSsIC/hZF/wtOo669/bahDKBbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

Hi Jacob,


On 9/13/2024 9:32 AM, Jacob Pan wrote:
> Hi Vasant,
> 
> On Wed, 11 Sep 2024 10:19:04 +0000
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> @@ -1962,27 +1978,7 @@ static struct iommu_domain
>> *__iommu_domain_alloc(const struct iommu_ops *ops, if (!domain)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	domain->type = type;
>> -	domain->owner = ops;
>> -	/*
>> -	 * If not already set, assume all sizes by default; the
>> driver
>> -	 * may override this later
>> -	 */
>> -	if (!domain->pgsize_bitmap)
>> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
>> -
>> -	if (!domain->ops)
>> -		domain->ops = ops->default_domain_ops;
>> -
>> -	if (iommu_is_dma_domain(domain)) {
>> -		int rc;
>> -
>> -		rc = iommu_get_dma_cookie(domain);
>> -		if (rc) {
>> -			iommu_domain_free(domain);
>> -			return ERR_PTR(rc);
>> -		}
>> -	}
>> +	iommu_domain_init(domain, type, ops);
>>  	return domain;
>>  }
>>  
>> @@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct
>> iommu_group *group, if (group->default_domain == dom)
>>  		return 0;
>>  
>> +	if (iommu_is_dma_domain(dom)) {
>> +		ret = iommu_get_dma_cookie(dom);
>> +		if (ret) {
>> +			iommu_domain_free(dom);
>> +			return ret;
>> +		}
>> +	}
>> +
> nit, if a user changes default domain types via sysfs and the current
> domain is already DMA API type, i.e. DMA to DMA-FQ, I think it causes an
> extra round of iommu_get/put_dma_cookie() compared with doing this in
> allocation time.

DMA -> DMA_FQ will just initialize flush queue and exit. It will not enter
iommu_setup_default_domain(). In case of DMA_FQ -> DMA it will do new domain
allocation. Am I missing something here?


-Vasant



