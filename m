Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563366;
	b=fWJFyY8neT4BXam5uw+VwBUsDvW4sJgi7bHUoDfcdG3TUj7mbtzrcDKy5zNT/BfIpFq3
	 dsgvFIpWuOlva2RfxhDx/BTp3Ckq3exV835VIFvjy1as8hX3IJm0Bp+sudicX7bPLcGcJ
	 LmQMustD3UP/0NMEWmR/ZPH2ORErk493FjGN/vMOEAy+uMvF6UESFHrI71pdYkO5YfXOv
	 CAuxe07MP3kHVLz2lsmQNG98t0qCqM6o7WKb89wzPRKEKPOYEAPbuKfpo67OL9PRcyrLi
	 vTCfRoOifIpfmVi7B+wIWHYssOoz6xIVzsXCD74kvcCN180jorYtBs7nx4Novo24jEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563366;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=auwuHFr2K6/g9MscSHi5wXxfS8KALsiDENNQDsdnuMc=;
	b=qm3u/M0TMHEZg6ZXCzbyEuc90VltRyOOlQbU3ILxfP2tIa4ZtJco7zpHasbPXT1Lkvhi
	 nXez+N/NhXXFcSN8lHLmMzYbiqFIlKv39zGP7O377lfomHcTrNXlWirvpoYycekU1vjqp
	 cgrXy1kfbPHOuXWP4SbeV2l4qrfVi0LjI7AwDBxo3Hd05kGLTnPpiAUdjvcBQn2XwTIc3
	 V4Za1R2Ht2z7EY5YbrjnlORAirZ7VCOQSzAaQsHgq3Amk4x6dlxq96/qjuANLklhaoitq
	 0Zeo544Xnf7Zn0h5bl5uHX22MWOej6ykNEdPiNw0BT5y/wSoddnPpsuavYLotrLkaog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i2KT+gXb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.15
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96203606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 06:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96203606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i2KT+gXb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQ7tW8muC3zoAeKbU2q9y3knIxIWx5wkLBKJ5BFwxW7LFfwUuPaUIBduXzjqhh1+nLkOl9XJtGEk6Cp2gQl5j03udUixr8YT4+oAy7Aw9iMefqI6zB3SZ0fEXqfBdI9SJJ0z9Y8a8oiE8iyhCPE4t0d7Kcpd4yKZELu5XiMtZECWIYFZ5zJmAQ9maV9tdvrA2oRg38sCt11Lc2b78B7X9xL1y5bs3bSYjeDiKhFPMF8zF7yvPRKarMJwdUqZEdeoHVw/eRrW5lRO35XFB+PEZdZFhCXTyrmWqS1YmIv6hB98NCwMwxjNevHUy5Frovq+gylhXKdGMSSdKJplruPErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auwuHFr2K6/g9MscSHi5wXxfS8KALsiDENNQDsdnuMc=;
 b=lVdlaeuNPNoKaCGhk0lXWFpHFcoAmT26dq2VmS0yOHyAoU7bfGaNMALZKHhmBcPA01/xOrDf3bwzg95JyGC7I4467i/GJbqZvnsizgyPho6CQgeMbmZ6V68YwPM9Ol0tO44H+/3MBHg5/ewa90Vk+cPndq3NIi9comMBgg/zmF5jrvagFGrbWqpBlYqkbJDXXrvN6z8mabd3YBX7uzeUCx3fUlzpJ6jbd5o5VZOlScrv9KAfNyaS0pPBKOJAc19dKPMxxoI4E+aLBkC3JCmR9ZiLMf0SiMyLTz4rbQ4Z/JJUnJ5aN8FJjhfh/5q1puMijVqItnqoZBBC+cDrouiQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auwuHFr2K6/g9MscSHi5wXxfS8KALsiDENNQDsdnuMc=;
 b=i2KT+gXbahR+r34C0jyLutB1JeASruqmkkZfHb4V08zKiwgBhNbXRMtj5PJJX80+bKXDx/vfAOPt1ZLsbA32D4SfiKYKwPolVx0NfE+6rlhA82GBarKKU500ml/VuMEY/O61QXGUEqnOH2zNIPzlGRAaEiIZlLthqXTLFCoJdqc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA5PR12MB999325.namprd12.prod.outlook.com (2603:10b6:208:603::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:16:02 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 06:16:02 +0000
Message-ID: <75e9510f-1dfb-4c59-b2db-48feda7631c1@amd.com>
Date: Wed, 21 Oct 2026 11:45:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/24] iommu/amd: Add translation DTE and VFctrl
 TransDevID helpers
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-22-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-22-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA5PR12MB999325:EE_
X-MS-Office365-Filtering-Correlation-Id: 637b5aba-1a86-43d2-aed5-08df2f3ac82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|260925021911599003|260925022911599003|260925021311599003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+igUmGEauiV0T1JGSvIZ79N/bY3rWy45Lce22loj7Ja33HxhREyffmz06K0hb7Pkna9PmnSwgP1u4UJkLgirFCg1WS+uyMjMNVMp7OHBdDa9+wxRWQc+5YhGt69jNLxRzyY12Fx9SL8F08cCkRlC5Gv9fozA5ZTjYF0HarhA8nrDc3pFHlergJoapOlMvU/vHQw6PD4wwZtKCD1DnKTJvmo/KcGZ8MD5lwTMmaJKq+W20+qwvCtFYakMBGx++mYOlCpYjQlrKXETrIo4705SSdwh7lLHatHZJrmyPtuLvBgzf3462s5m2c/K5iPwiXg5i/dMyHNeiq3Hp/12NA0J2ioPUGow1/yE5KVctSfICXb08E2iuwlHD/VWzJM4t63iRNuYWCBWpYdOpAFpl107GnFVkruEgzfRL9KQpkyXz1XRdK93RiLmm58T1b0Z42UKiJ5hoOR83BpAkslJDxwBodCbNzUAaNoWQx0WcqpsajtUYS7lA9kyFoVTaU7C7kGnVq5L6msnf+h9XwUhlnlpDwqz7zFOIhurWqPcQgn2F/ur2lEGhniMc9zw95K7Ubi3Z91WkHH7FsAjMJ7yHaVEPR6r3r8wZWKSoFfq+HMKEgjGcmF4JqlR5G7861XjGbiFRgXNusfnpN9bjOkuTzkO+5mnMT+GeyyiX3yYAMsAS5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDgxMHdWMHNtMUxUSGtYVG5UTkpjTU01OXg4TDdIa215dzdVVlRES3piOFpq?=
 =?utf-8?B?emhuU0U2RW1aS2IyLzhkZ0hhSG5wRjU4b1RTMlpSYnFubHBUUVlxb2RTajFj?=
 =?utf-8?B?UXIrUDdzWEQ0U2w4WHI0anNvYS9Pb0ZRNlR5MW9Xb0VmOWpMNk9nbVl4dWdn?=
 =?utf-8?B?aFZ6b2hCRmNkeFB4ejZ2Nko1YXZaeXpqWDg5ZEYxSUVQd0JxQjF0eTFBQXk3?=
 =?utf-8?B?L2lIeHBzSUh0eDFFZU94WjlMeHZpaWduZ0U2aEN4TXBRT1g0ZU1KQTBSZFhT?=
 =?utf-8?B?alowb1B3MWdFYmFxeDZwdXVDTDFXdWNyaFhJL0hKYm5VOCtDNGRsL0NBWGZM?=
 =?utf-8?B?bUxOSHFtdXMrWHNvWmp3TmJQN2taSWpuZ2FVVHRsakNlTkJ1Z2NSVmNRbGJz?=
 =?utf-8?B?bjNxUVV5cWZxa0tUSGxvMDV6TFArT0FMbnNVUDVSVnpLRU1UZHhFa1ZFcXJN?=
 =?utf-8?B?Qjk5NFVaejh6bElhbFJsY1lYSXNHVkUxSkpudkRNSlA4Si9ER3FsdHhGOWZ6?=
 =?utf-8?B?VXU3UEZhZmpvUTEyYnE5NVRVcU1zTzQrTjQwQ3NacmdVZzh6dkNkV3ZFaGlV?=
 =?utf-8?B?VVdsY3k5UllpMFFsYlhza290dkREcDkzdjBRZ09tMlJ5RDBnTDh2WTE5VWxp?=
 =?utf-8?B?Q2k2djZHVGtudzM4WjNycHNxTndGd0VwLzdsaEk5c2pHWkxFZDVhakdheHJK?=
 =?utf-8?B?OFZkclJKN0drYnZUTnRBRW5XU25Na2dsaEVRYW9raUFYa1VNNUtBZ0pyRm5n?=
 =?utf-8?B?K0hzQS9XQUtidkRDNzdBM3Z1NEt3SGNOUk84Vk1icytCc25FUm52YnNaNk9a?=
 =?utf-8?B?K1NKRXhlY2UvUnlmRTJ0TE5EWi8xZkVYU25yQkVpR1BiTmR2dzk3d3dqQUlK?=
 =?utf-8?B?NG92aUlBbWlLMHJUejRHY0tocjZNQWZGVEs3T2ZoQnpJbWtWUjE2T044bk1E?=
 =?utf-8?B?YXIrMFNlcE9IbmlhZjVBWnJGM3Z3WERjenRmUW9rcEt4Si9oM2JvMmg5cWd6?=
 =?utf-8?B?V09YazBCellsdXM5OXo2ZC9BY3JYSk5GWk9mL0RDWHN0WHhiU0g4MDl0cm1k?=
 =?utf-8?B?ZjZ1QWl2WElCNWIveSt0MVMxM09ZZzM0YXhFSjhQOEl1aVFVYjRPSWxhZm96?=
 =?utf-8?B?bWE3bzJXNmNGSWRYNnVnSDFqODM4OGVzVWh6aWUrT2RmNVhzWU4wTkh1UWMy?=
 =?utf-8?B?WDdNUDVDZTdDQkU2eHNvMHlPSmNoMjhVblRZbndqSEFsTVorcnd4WjBIZDVr?=
 =?utf-8?B?L0dMVEdkTXVLSTQzbDF2R3NQVjQ1aUtyNlI3ZkhkNjR4bDEzVXZ1eFlTMzhu?=
 =?utf-8?B?TzkvSEExQVJhWFdJUmFzN3NHREx0cDFBSEUzdDRKamxXRWk5aC85NDhPM1NO?=
 =?utf-8?B?ei9sREJicVhlZ0IxYkx4U0szelJiRDBSMzV6RG1tdzFPSmR2cHJsWTBZK0lD?=
 =?utf-8?B?azVtdXp6SHY2b1JFZkRyRmZmak1YMkdXTlBuKy91SXJTdlZ4Q1lRdUJEWjRL?=
 =?utf-8?B?K0FxYzlmNnVjNkJTbW1oc1RRUStzcHhieTJkemM2V1hPdXZFbzZPVXBDWG4v?=
 =?utf-8?B?WnNSZDQ0WkhxdUdyeXVQQ0F2c0JITWdSWTA3dXZNclBHSUFnYnBmeGE2S2Vn?=
 =?utf-8?B?amlYVnJzVTNuczg5T1JjRU5iVUlVcit0d1RyZDdIWjFweDJMWnFvTHUyc0F3?=
 =?utf-8?B?dVJFVTh1SnpqOVRqczg4a21EWDY5MWVTalVYMVRGVi9MU2VVaHZqR0tiMDVO?=
 =?utf-8?B?VVA0Um5FODdtR0hkS09xd2VpcDh6Q3QwZXJNNXlSNWEvaUhtVk8yVmFDaU1R?=
 =?utf-8?B?K2drcnlvTm5Yc1UxTDVTVVBqQ05uWklpTysrRXkvVjErVmJaNXA0eU4vTWZI?=
 =?utf-8?B?Q0dka1ZKSkx2MnVuNituUWNZaTJ5aXcrRjV2bHZ4aGlIZUNzL1NuQjY4ZHZ4?=
 =?utf-8?B?Y3RUU3R2Z29vN0Qya2V6SWVMV3BwWkhzWGU0UlIyams3Z0NMOUhUc2xoZWpV?=
 =?utf-8?B?M0pxYUFqTG4vV0krMDhORG43Q25Td0dSSCtzeTBvN21mZnlVdndSZ3RMZ1pZ?=
 =?utf-8?B?NmJsSFRwcTQxbGRLU3lVLy9Pa3ZzYWpGbU1SWWNuUTNtZ2ZtVm9YQTN4akdQ?=
 =?utf-8?B?K1V6WktLMUt4ZXNsM2N0eFhQU3VRZjdFWHgvTkJvYVc1Q24wMWdDaHV3VGNk?=
 =?utf-8?B?dVJsZWdodGR2YStyME9ZTnJjb0JsNnd5Tk82eGdjTTA1MWxYU3JpZk1TYTky?=
 =?utf-8?B?TzBJVjcrNlNHbWdSQ09XbVQ3cG91SEpQVHBBNElXWlJkQnFQbDdyQmsrVTQw?=
 =?utf-8?Q?MtiIDPeXERdM/MgNiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b5aba-1a86-43d2-aed5-08df2f3ac82c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:16:02.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyjxTJJPUPE3CJuvHqPoTD1twrCKCo2kmyf3LirDbiR5+z2XXo0J7t7BOlWlHn9GrEFUykr8ZbPvsogAnLprwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999325



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> vIOMMU GPA->SPA walks use a per-vIOMMU TransDevID: VFCTRL guest-misc
> names the slot, and that host DTE points at the nest-parent v1 table.
> 
> Add amd_iommu_set_translate_dte() and amd_iommu_clear_translate_dte()
> to program that DTE, owned on amd_iommu_viommu.trans_dev_data rather
> than pci_seg->dev_data_xa. Rewrite it from amd_iommu_change_top() via
> pdom->viommu_list when the nest-parent table grows.
> 
> Add amd_iommu_update_vfctrl_mmio_translate_devid() to publish the
> TransDevID in VFCTRL guest-misc MMIO.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   7 ++
>  drivers/iommu/amd/amd_iommu_types.h |   4 +
>  drivers/iommu/amd/iommu.c           | 153 ++++++++++++++++++++++++----
>  3 files changed, 142 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 6ac64524208b..4aede6f6d489 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -213,6 +213,13 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
>  			  struct iommu_dev_data *dev_data,
>  			  struct dev_table_entry *new);
>  
> +int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu);
> +void amd_iommu_clear_translate_dte(struct amd_iommu *iommu,
> +				   struct iommu_dev_data *dev_data,
> +				   u16 trans_devid);
> +void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
> +						  u16 gid, u32 trans_devid);
> +
>  static inline void
>  amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
>  			 struct dev_table_entry *new)
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 6b3a43952797..5f84f25e3f37 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -489,6 +489,7 @@ extern bool amdr_ivrs_remap_support;
>  /* VIOMMU stuff */
>  #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
>  #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
> +#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
>  
>  /* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
>  #define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
> @@ -551,6 +552,9 @@ struct amd_iommu_viommu {
>  
>  	u64 *devid_table;
>  	u64 *domid_table;
> +	u16 trans_devid;
> +	/* Synthetic DTE; not stored in pci_seg->dev_data_xa */
> +	struct iommu_dev_data *trans_dev_data;
>  
>  	/*
>  	 * Serializes VFCTRL Guest DID map CONTROL0/CONTROL1 doorbells
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 65550b070a12..8943863105b6 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -148,11 +148,11 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
>   * So, only consider control bits related to DMA when updating the entry.
>   */
>  static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
> -			  struct dev_table_entry *new)
> +			  u16 devid, struct dev_table_entry *new)

Why this change? dev_data always contains devid right?

>  {
>  	unsigned long flags;
>  	struct dev_table_entry *dev_table = get_dev_table(iommu);
> -	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
> +	struct dev_table_entry *ptr = &dev_table[devid];
>  
>  	spin_lock_irqsave(&dev_data->dte_lock, flags);

.../...

>   */
>  static void update_viommu_self_dte(struct protection_domain *pdom,
>  				   phys_addr_t top_paddr,
>  				   unsigned int top_level)
>  {
>  	struct pdom_iommu_info *pdom_iommu_info;
> +	struct amd_iommu_viommu *aviommu;
>  	unsigned long i;
>  
>  	lockdep_assert_held(&pdom->lock);
> @@ -2884,6 +2893,17 @@ static void update_viommu_self_dte(struct protection_domain *pdom,
>  		set_dte_entry(iommu, iommu->viommu_dev_data, top_paddr,
>  			      top_level);
>  	}
> +
> +	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
> +		struct amd_iommu *iommu;
> +
> +		if (!aviommu->trans_dev_data)
> +			continue;
> +		iommu = container_of(aviommu->core.iommu_dev,
> +				     struct amd_iommu, iommu);
> +		set_dte_entry(iommu, aviommu->trans_dev_data, top_paddr,
> +			      top_level);
> +	}

These two are operating on different page table. So its better to have it in
separate function.

>  }
>  #else
>  static inline void update_viommu_self_dte(struct protection_domain *pdom,
> @@ -3463,6 +3483,95 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>  	return true;
>  }
>  
> +#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)

why not move this functions to trans_devid.c ?

> +
> +void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
> +						  u16 gid, u32 devid)
> +{
> +	writeq((devid & 0xFFFFULL) << 16,
> +	       VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) +
> +	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
> +}
> +
> +int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu)
> +{
> +	struct amd_iommu_viommu *aviommu =
> +		container_of(viommu, struct amd_iommu_viommu, core);
> +	struct amd_iommu *iommu =
> +		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
> +	struct protection_domain *pdom = aviommu->parent;
> +	u16 gid = aviommu->gid;
> +	u16 trans_devid = aviommu->trans_devid;
> +	struct iommu_dev_data *trans_dev_data;
> +	unsigned long flags;
> +
> +	if (!aviommu->trans_dev_data) {
> +		aviommu->trans_dev_data =
> +			amd_iommu_alloc_dev_data(trans_devid);
> +		if (!aviommu->trans_dev_data) {
> +			pr_err("%s: Failed to allocate dev_data for translate-device-id %#x\n",
> +			       __func__, trans_devid);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	trans_dev_data = aviommu->trans_dev_data;
> +	trans_dev_data->dev = NULL;
> +	trans_dev_data->domain = pdom;
> +	/*
> +	 * Leave off pdom->dev_list: this is not an IOMMU-API attach.
> +	 * Hold pdom->lock so change_top() cannot grow the nest-parent
> +	 * top between the sample and the DTE commit. Publish devid
> +	 * under that lock; it is the live TransDevID for
> +	 * update_viommu_self_dte(). If this vIOMMU is not yet on
> +	 * viommu_list, add it before dropping the lock so a concurrent
> +	 * increase_top() cannot miss the new DTE.
> +	 */
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
> +	trans_dev_data->devid = trans_devid;
> +	set_dte_entry(iommu, trans_dev_data, 0, 0);
> +	if (list_empty(&aviommu->pdom_list))
> +		list_add(&aviommu->pdom_list, &pdom->viommu_list);

Already updated in amd_iommufd_viommu_init() ?

> +	spin_unlock_irqrestore(&pdom->lock, flags);
> +
> +	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x\n",
> +		 __func__, gid, iommu->devid, trans_devid);
> +	return 0;
> +}
> +
> +static void amd_iommu_update_dte_slot(struct amd_iommu *iommu,
> +				      struct iommu_dev_data *dev_data,
> +				      u16 devid, struct dev_table_entry *new)
> +{> +	update_dte256(iommu, dev_data, devid, new);
> +	if (dev_data->dev)
> +		clone_aliases(iommu, dev_data->dev);

We know there is no alias device for translation dte right?

Actually why not call amd_iommu_update_dte() . It calls device_flush_dte(), but
for translation dte we are not setting ats_enabled flag.

-Vasant

