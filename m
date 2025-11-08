Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D651F463F
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622813; cv=fail; b=DkUPcGq6b+5EtoIedFsZ/bdBoUNqgBT+oH1UAcvVZ07XPK77tA6JHE617Llxa4Z0q9Uikn+dphab9MrBbl6IrCPJpp4dpGI7DFBVCHNZEH2wVApp4Fzt6lDvLcRP+ISmTmkB28XSfgsPqC01PEo2KgZ/lSV/DdtVFcXXPvRlH48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622813; c=relaxed/simple;
	bh=/2noZc922M/LtRHXUsiuJsY8jtVOoT53WFSxWCvYM5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWyuuW1+N0sq2XD1dtPgU9Tgnh52T9fTS1Vr3A3/RsY6seQUfzL3edTcPC2Imd/Ox6FLouPvHmIaeFptifB8wygcFrA6eyo51JTsTtjH0FeafpDY4jnv/cwofMWWcYDnu+Z8I9AWPptBjBEmUrqf98I9fEN1gi45TsBNXPhTfo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0yOTouM; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0yOTouM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFu+SKfkwiWJZemUwtfhGO64XppURdAQa0MMotiuIbh3g4sAZlEQ4qBLVCgUaBpaf5vkRwiE2Qc+YLt+9uK7N15TmYOAnpEORUUgTmDsUTwXO+qJ4lsGDPKnIIIGJ6UxlywkkP7JOpC5iDKvsMebqpDz0I5xG61tWr8yMMPOmximsuzzKxpwE5Kpv4XmWFZKOBW4wYqh/aSWBysCysp8Mdo50xvmQ2egCttXVe5j2XkocntKg5xG5t94uOavKoKjtcxBvOpHupgu8f19ktln6doOmUoFmDw6Go1SJjqCDgL6mU+Rn+XdN/sw3EzOpSWZtP7MsC/7Tqpm1CpI4fCC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiNpzCiYISvRZFrAbx3s7ozW6GgsfxHkUN40F14pCxQ=;
 b=AGDEE+85UpKyp17JAieRUZh1RlCJRrtSbfF2uM/oRCLdepyt9rLkAR6hEmxmEN9b/t8gL9JA/PiAXYddlUgrMtxBevGmKO5sEifJoUGwZkBIppOKtIJM5RbhfFgat+TXNv6/NGHt64hBKQhxH1/9JnHH9DpLtKlqPQa+TNFlbLGuFxcvzOwNX3wZqUKVJixGRZKdEcdfjVYBzo+I/UGcIU73e2jKv7G5PhaTm9cg7tqItNHwv3PP7ZwMTaf5C6VOKerUcKyrokbJ2acMNB3wCdvJQl3UOV1pNT2v/mcB1jxgVoi7MKfv2nRqCyGVYOQ1TR15cdBLKmCQ5n011X4MUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiNpzCiYISvRZFrAbx3s7ozW6GgsfxHkUN40F14pCxQ=;
 b=J0yOTouM0thpExBJfJaQwt1aAW6cRHY32uxSl/UoShjNPquQJWVCg2ZXYPFildK/ZpypOOxbZKTUb2HnvZgm8zJZ9QBI63O45q5UaGKIYgGjRDO7lBeYtcu7Oc0NfZQl4I2QzlHdjVr7ZlZrrPUzqFggr/9MxgADIaofwyMMugk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:26:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:26:49 +0000
Message-ID: <62ba61a5-d172-400e-beb5-e593297129ef@amd.com>
Date: Sat, 8 Nov 2025 22:56:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host
 page table in DTE
To: Jason Gunthorpe <jgg@nvidia.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
 <20251023130833.GF262900@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251023130833.GF262900@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6598eddb-68dc-4123-8826-08de1eebffbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtsSXROeXdJOElQTDZoUE05cDhoR1ltRGFMYnNoM0ZQQ3VZNklJMThreUJz?=
 =?utf-8?B?TDZ4RlczYzNJY2cxS2VadG9xckh5LzhKMTh4bnNmZ09jQUdRSlYyNXM0NXU2?=
 =?utf-8?B?RFc0VnlZeW9NN3FidjRzbTd5VnVGb2V6YU00WHRIMGFUWG1zL016Y2RvK1Rm?=
 =?utf-8?B?cEMrNjRHN2ZhalBybXh0MjFzbTNaQnJVNy9WdFo0SWpseHB0eExXUjJkUjJi?=
 =?utf-8?B?djdLcHQxSnpTOXpwSzI0U1Z5YXR5ekJTeHRVSVIxOTZzVmxkZXdsQmNOeDNm?=
 =?utf-8?B?WHVrZXhYZTFucXZ6VHJ4Y0l3S3ZTTG5qSW90em1OUmNVS0tDOERuQk9LeGN6?=
 =?utf-8?B?QWVkSVNiR3l2WE91bERYMWM0RWRkYUpDUk5jdTQ4c3UrTnZFeVo3NnBCMUY2?=
 =?utf-8?B?Z2NuT25tQnp5MUIzclVtRXlTeDdSaWlOQzFmYlhXUHpzWXNyODYvNGx1MDJT?=
 =?utf-8?B?MFpxM0JObFN3b3l1M3JVNWdrWmFLSjBEdEhmT2tpYUVOVXRWL1dEMk1qTVBW?=
 =?utf-8?B?QnZ5cTMwOUNNdmxaT0xTN3FZZGtOT1ZsRnRDZ3VCRlhKT2hIYmd3RUR1RkF6?=
 =?utf-8?B?dHdCR0xjQ2VKcGN6VVhSTFU3dytRK3BJdGQvUnhiWjdKUHZOWE92dEF0ajBE?=
 =?utf-8?B?YnFxTTZRbmVGdE5TMldBVDVyaUxmVnE0UjhTV096cnRjYXVhUHpscUo4cDJY?=
 =?utf-8?B?eWlyNHNhTzNTVmtoRVFESWFwZjBZREh2bnN2ZDVPM1JLdTNWY2htS2wxRGJX?=
 =?utf-8?B?aDNxQWlWMHJWMUI0YmdwZ3UzcWdGTCs4YW9BK0l1cVVSMm9HY2pEa1NwV1F6?=
 =?utf-8?B?RmdlU29wbWloTHpUcVkyTFhMYWtabXdNMEt4anRxS2UzYmc5Q3N0S1ZXejRW?=
 =?utf-8?B?bGJWMko0NzNXblhhdDRZdUs5WXNuTTMrWE5rNC9QVnQwRW1XM2Nub1VwMjg5?=
 =?utf-8?B?M2YxWU80NFh5eFpCTCt3R1VFOEoweGNiSEFlQXZyRmlUOEJaVVh1RGVJaldM?=
 =?utf-8?B?K3M4dEJaSUN4dG9COWJ5SnFXdlM3L2RlYm5wOC95QXRDRHYzMFQvN0RsYkwv?=
 =?utf-8?B?NEJ6bEpnUCtadzFPSjY1SVpzYUkzU0xBSVJsY2FBUU5HYmoyc0FMeHNvZXhJ?=
 =?utf-8?B?Tk0vdlRacWZvYWd5S0ZTL1lLZXJqZCtHeVNkYW52bmV6TnpMS2ZCQ1JuQ3A0?=
 =?utf-8?B?UTk0azBqaFJNL2I4eUJwbGtudHRNTzlHRS9xVUF0M2kxNDhmL0N1cFRsTGxV?=
 =?utf-8?B?OUNCNG1PeE9wY2ozTGoxTlE2UmZUbDNLcWlhdmZoTWsvV3prZGQxYmlXdkgw?=
 =?utf-8?B?TWtJd2NhOW0rTmgxYWdtN2ZyTy9sVFpVY3A1MGxsR09VclM4WjhpeSt6K2xN?=
 =?utf-8?B?eVlQNi9aZmROUTR1ZjVZdVYvMzVBdmhiRlIwMjVzQWRLSVoxT2RLWHhONzc1?=
 =?utf-8?B?RDQwWmdRRTRIcGdsVkpWVXluc2t1VXF6RmJ0VzRHUmxXd1ZUTFY0bk1PUHc2?=
 =?utf-8?B?UnNCeWFqajVyWEx4WmZyU1JRVnpYR2IxdzVLRFhMMittWDhSN2lrZnBnNzIy?=
 =?utf-8?B?UU4zVXBpYlpkczl0R3JWWlFocE4zTllteStGVFFlK0NXTE1XMTBjYXNPT28y?=
 =?utf-8?B?WFBLTWtuKzNFS3ZNb2ZwOEZtZ3NycnI2QzdoSkxEQk9hSk04ejNCTmc4UnhC?=
 =?utf-8?B?TUN3Yzg4Kzl0NFRGREcyd1BReTduQmZQeldCVUsyclZLaFRhbjgwc0lFb29y?=
 =?utf-8?B?WDI5QnkvNTNERFZBa1RXZ1c2N1lIS09ld0VqOUJhTTdkT0FNZkhEK2RYMGx2?=
 =?utf-8?B?dU1pL2srVU9FVHZVWkNMQWM1TlpRd0RmZjFVV3ZrZlphZ0pSZnhsR2dFYmNw?=
 =?utf-8?B?cUhPa1RiWDVRMFJObjA1dXdiWktMcTZPaHBmZVU2d0VnZGFzSzNyckRoYUxG?=
 =?utf-8?Q?8A6gKocWOgh/2gURmLNba9wSHPMNP0lK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURmUE5mNmZwbUtSL0t1ZzR2dkNYemVTOWNvcFRuZFl4d1h1c1RvT0ZDZnli?=
 =?utf-8?B?cTRkYTZSY2RmY0IvcHBCbktzMEVwaVBXdG5KTkRUV2tkMldZVWErMW5qYjFD?=
 =?utf-8?B?MVFEeitUZWg4bFpOYXN4VHVCRDR2SnhQQzJRbGpsQTRzMEpkTzVTb3RzcFZ3?=
 =?utf-8?B?RmRqNEg3bnRwd1VncHJ4U3FNNVdaTkZWNG9KYVhvMVExQmlBemo3MlZ2YnM1?=
 =?utf-8?B?QVR0WVFBQzQ4bmljMmlJSkV4Y0tQOUcxZHdKRGxWcFJpenIyTXBuVnk3eFJN?=
 =?utf-8?B?UEl3UUZXdDJIMk9DVnNJMGNpV056TkNJVDF1dm9sWFhhcTR0cVlSM21Bb014?=
 =?utf-8?B?RW1wZm5uU0thSmZZREVGcUlvWGJlNC9YcC9TRHRUVHRCeEtNb1dxQTdTZG4r?=
 =?utf-8?B?M2xvYkVVdFBuOHNyN1pEcWxpaEppR0tzT1Q3NVMydHJnRlUyNU96amJBWVVi?=
 =?utf-8?B?MjlYaklna3REei8wQi9aWWRGd1krRnkwMzdpR040WHpOZkJjTWRmTit4UEwr?=
 =?utf-8?B?V2w1dUtFa0lWVjJEbmxJakpWK3UzNjlPc08rcTgxOG5hRVFVMzlCSzUzVUJZ?=
 =?utf-8?B?RXVHVWhrdjJNMHMyaHF0d0Q3UlVBKzlrSXVucWhXSFdIZ2RNWHpoTUdIdUlN?=
 =?utf-8?B?OVZmeUVkY0xWdEdCZys2MjF0NWJGek9ia1IyZC9tUHdFWENQOWlGSlVvVkp4?=
 =?utf-8?B?SWE3OFRXamcxbWl2V1VDV3JCcU0xRnlCNXJJaTJVT1VDci9iNXVWTms0bFF6?=
 =?utf-8?B?TDM1T2ZMQktPT1FLeEF0cUpuTTIwNHBhWk0wdkdIWGM4REh4S3h2Ull0RWtS?=
 =?utf-8?B?SndtMlByTFJOWlkwV2F1eE9yV3Z3aFljTDBtSU1xQ2kycnpFZWRSOUc5VUpN?=
 =?utf-8?B?WEJoUEdNeEZaY0hvTDRNOWpxQ3JLQlkrV1JzWEhVeXltZWFmcnhvOXRpL0h0?=
 =?utf-8?B?cDVvOVV1UkRIRFFSb3hJS3JUMVAraEh1eE8wRmZ2ZGNRci9CRVFvZkpEWWJo?=
 =?utf-8?B?R3VNQ3FwaTZuYjJOVGc5MGViQVBYK0dQaEpWbURCMGdwYWQ3SGVITDIxRWIx?=
 =?utf-8?B?RkpaZnVCQnBBTGFnTkU3dHByM0pXcmRQNDM5THhCeWlYdzZWVGdiWll4b25v?=
 =?utf-8?B?WUtSY3BPK0pVK3R2QXVWbCsrRm0yZzlZRGUvbWtodlhpWlhWMFNJUVdGTzJO?=
 =?utf-8?B?QjFlVnlNM0F6M2ZxekhHRmxQUVVCTGw3SFNORHc1eE9HNHlJa1dTNHRpUEJO?=
 =?utf-8?B?OXFIYVBlRzZ2dHl5alVDbkJWUEk2TUs3d2FkWVE3TW85OXdmY3FCQ1l1MlNB?=
 =?utf-8?B?RnhLQkI4TVRFZW12M3B4WGV3YUFickZKQVVaV2dMS0pEdG01azlYdFdZbTlw?=
 =?utf-8?B?RENqa05iYjhnTWliOTRWL0JtWnNBV1FIWjRPa1Z0UFNEbWFxMG83dDdVcXBS?=
 =?utf-8?B?NGY5OENYSUxJMHV1dHdlbTU5YkR1bGFVMzNWNDZjcWo0VUMyNHZqV3VDeTFT?=
 =?utf-8?B?eUV4Y2tFNkNMTmNzY2o5WmRBLytMaWVPMWdUa0xNcG4yL2ViMk16VXVaZ1BT?=
 =?utf-8?B?MnF5NmlhRTNuT3dpSVZtMTFiMnZnUWhqcGhQMzFqeVZIaVNYbVFTWWY4U0h5?=
 =?utf-8?B?U1BTZFdUc2x0WUZ0ZlJYL2VPU0JUMWllOEU0SkcvREZ0Ymg1R3VKMlBJanEv?=
 =?utf-8?B?MytvV0xlczJRQ0ZvM1dmRzdhYnN6SlhvN3FQMjNDV29wZ01JSGJxdmN1ZVho?=
 =?utf-8?B?cVdvMUU5Sk42cDYrbFVsTmhOOXQ4VVYwSmNTSlBFd1VtMFpqQW1qN3NDS1R5?=
 =?utf-8?B?MnZwTG9iajJwQ2dJdnZPYjJOQTRhVTVNRWFvS0pvMVpZTnBnR2ovQjg0OVZO?=
 =?utf-8?B?THZEVmtib1JCeENvY3hUWk1qb2s1VGdjZlhmWE15VGsyWFZ6Y2dDaVo1MXdw?=
 =?utf-8?B?elYzZ3RKcE94Y1d1R08wSlIwSlRXNUo3dlVmZXBFc3VIU25IRW5wZWtzbnZu?=
 =?utf-8?B?MXVMSlE2TVgrbkZ1OGgwaDV0Y3JwMjNlaXlDOFNqNEdieTQ4TDZBVVlVVXBq?=
 =?utf-8?B?aERpSDgwTDJ4ekN3TnV0WmcwWkRzbnhOMHQ5bkgzc1IvOFJnTnM1OEFpVTlm?=
 =?utf-8?Q?eoh5sYGpGJbJwIlv9vEgDGfDq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598eddb-68dc-4123-8826-08de1eebffbb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:26:49.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GnULhgCZ7/5AwDGbDDuVuIFBQ6qNtJbss0xhadY1OgR+WM755q7Aucc61ArCQB9lXgzbaeQmaR2dBlePjdOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

Jason,


On 10/23/2025 6:38 PM, Jason Gunthorpe wrote:
> On Tue, Oct 21, 2025 at 01:43:23AM +0000, Suravee Suthikulpanit wrote:
>> @@ -2088,37 +2104,28 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>  	else
>>  		domid = domain->id;
>>  
>>  	/*
>>  	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
>>  	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
>>  	 * do_iommu_domain_alloc().
>>  	 */
>>  	WARN_ON(amd_iommu_snp_en && (domid == 0));
>>  
>> +	amd_iommu_make_clear_dte(dev_data, &new);
>>  
>> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
> 
> This old_domid stuff doesn't make any sense. I think the commit that
> added it is bonkers: 36b7200f67df ("iommu/amd: Flush old domains in kdump kernel")
> 
> The problem is that the dom ids that are present in the re-used DTE
> table have to be reserved from the domain id alloctor at boot.
> > If the kdump kernel tries to create new DTEs it MUST NOT re-use any
> IDs that are actively being using in DTEs already or you get data
> corruption. Randomly flushing IDs is just getting lucky..

Good catch. Thanks!

Looks like commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") broke
domain ID reservation in kdump path :-( We will fix it.


> 
> Not for this series, but something to think about.
> 
>> +	if (gcr3_info && gcr3_info->gcr3_tbl)
>> +		set_dte_gcr3_table(dev_data, &new);
>> +	else if (domain->iop.mode != PAGE_MODE_NONE)
>> +		amd_iommu_set_dte_v1(dev_data, domain, &new);
>>  
>> +	/* Note: The IR, IW, TV, DOMID are needed for both v1 and gcr3 table */
>> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
>> +	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid);
>>  
>> +	if (dev_data->ats_enabled)
>> +		new.data[1] |= DTE_FLAG_IOTLB;
> 
> These three should be merged into the two functions so they stand
> alone. These sets have to be made in the next patch, doesn't make
> sense to open code them in callers.
> 
> Like this, it is simple and readable. It directly answers the question
> 'what bits are set when the driver creates this kind of DTE'
> 
> static void set_dte_gcr3_table(struct amd_iommu *iommu,
> 			       struct iommu_dev_data *dev_data,
> 			       struct dev_table_entry *target)
> {
> 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> 	u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
> 
> 	target->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
> 			   DTE_FLAG_GV | FIELD_PREP(DTE_GLX, gcr3_info->glx) |
> 			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12) |
> 			   (dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
> 			   (pdom_is_v2_pgtbl_mode(dev_data->domain) ?
> 				    target->data[0] |= DTE_FLAG_GIOV :
> 				    0);
> 
> 	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
> 			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31) |
> 			   FIELD_PREP(DTE_DOMID_MASK, dev_data->gcr3_info.domid);
> 
> 	/* Guest page table can only support 4 and 5 levels  */
> 	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
> 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
> 	else
> 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
> }
> 
> void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
> 			  struct protection_domain *domain,
> 			  struct dev_table_entry *new)
> {
> 	u64 htrp = iommu_virt_to_phys(domain->iop.root);
> 
> 	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
> 			FIELD_PREP(DTE_MODE_MASK, domain->iop.mode) |
> 			FIELD_PREP(DTE_HOST_TRP, htrp >> 12) |
> 			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
> 			(domain->dirty_tracking ? DTE_FLAG_HAD : 0);
> 	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id);
> }
> 
> (It is nice to sort the fields by the spec order, I didn't do that)
> 
> Looks like an identity one is needed too:
> 
> void set_dte_identity(struct dev_table_entry *new)
> {
> 	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
> 			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
> }
> 
> Then the whole function is pretty much just:
> 
> 	amd_iommu_make_clear_dte(dev_data, &new);
> 	if (gcr3_info && gcr3_info->gcr3_tbl)
> 		set_dte_gcr3_table(dev_data, &new);
> 	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> 		set_dte_identity(&new)
> 	else if (domain->domain.type == IOMMU_DOMAIN_PAGING && io.mode == V1)
> 		amd_iommu_set_dte_v1(dev_data, domain, &new);
> 	else
> 		WARN_ON(true);
> 
> ?
> 
> (though how does IDENTITY on a device with a PASID installed work?)

Probably set_dte_identity() should call  set_dte_gcr3_table () and update
relevant fields.

-Vasant

