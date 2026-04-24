Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3145372B24
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022591; cv=fail; b=gbwTX5onRn4elrjxNBQYOcEsLr/b3ndkMFEzYAXWLLEiE+UlHG4UB7c3TEebQfxOn7u5SwCvmGxt1HGFJNV563PeAqCrrTlW4FnlfLQ6ipI58DyxAgTOYJB4kweqhvpEjNlv9PJh6cocS7u3lQceGsGWfMbw2oMHCDdXafUHbD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022591; c=relaxed/simple;
	bh=/eY2FUCN7sm6KIg7axCwA5NWub+bJIz4u9a4MRYtDyY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ksdhINQfF9YvbQpRDllW4rbjkXI7ikSP6sdYe7rZfA+xNSCulCa1Jy12Emb3Ctnx7mAhxybAEbh2YLv3ECq7/XC0iIXtBr2U5aHyS+qHoeGZcyuIqK+HHDhfWGJf4DcQbM6R+eenBOBC5tqpqi/pLVREADgR9lu8/t+BXcbzFgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SPJsab4e; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SPJsab4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG8BWMHpJRYn8/RJz6sbGNihZi5dNj84sap5ZfQcRAHsOJTL5LMAkhuvDEv+tdd6E1UhT+PGI9Z6PYd0r4GNSdvTEcvxKN5pczxU0hMCOBHUeBCCsMGZTiOp03PhzSPZZ6tix46dV8fmYZVmN7gfrd8La/Dhq3HX+gKe4ehSFWpoJNBo1dv7l4LP/wCKfmez2HNo38sw2syg806t+KzuOOhhvJAbtkzcSNeQ6xb2E3sUfXNrW3vu9pkIygeZfHs58a65xGs2gCFAGokF0JeP+mLc5VeBH2taiXFJKy8J+WsaglEa6lAIzCypw97OcE1u06rJup2jHAXaVLtkLx/cBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVQb2j4mGwur2Hd9rloBcWol/yXkKgQf+VLoRrWtLEs=;
 b=RKyfSWkfI+ImykqvPV6m26t6BFqNnXC6TGubYqyQiYRlPW5Gsi9T2x8j8Tx6GpmnM0HrOJMOl/cwgf/QhecXZ5FiB+9GS/xTzJ5uk5wn73jK7CaBABPyDJ5YhFpcyLUWHY3x3L2zvvwyoO5PryEXSFrAJujaUA3DZZr6uVH+E4NvC8uA5hwmV9Rc5/3UuAmYetB/JLdA+NGsNv0N3PCgUsOsqIAiFP3CKa+1Cu+e/MJcBjTPpxXiR8QDqGzUrW+lNHpQl5iuFgvpng/8ZAFAmr4t3gkcX+dRHKRbVlojBEQyp0HcI2cREqIfJVDPGM7dg1SsAS+WWvvBZjq7R73/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVQb2j4mGwur2Hd9rloBcWol/yXkKgQf+VLoRrWtLEs=;
 b=SPJsab4eH1hOSiu0yXpsJbdmQzdjfDpqDBe8J1Y08f1qok+JI4/rvRZ6jaWzaPR9GoRh7udVTPDg+82d7QAe7t4LgjHBQw1w5kGhL2rgZztqlbUfB8xDsY6l6ac8/J83sJiE8QTaSlkxJETtB1/gHvMMajmqsLqCkLd6xL78Fsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 09:23:03 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:23:03 +0000
Message-ID: <32db5a5d-1f81-432f-829b-3bdd480711cf@amd.com>
Date: Fri, 24 Apr 2026 16:22:55 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/4] iommu/amd: Drop unused global exclusion range fields
 and init
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jon.grimm@amd.com, vasant.hegde@amd.com, frank.gorishek@amd.com,
 thomas.lendacky@amd.com, santosh.shukla@amd.com,
 jacob.pan@linux.microsoft.com
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
 <20260420170033.6780-2-suravee.suthikulpanit@amd.com>
 <fj6hhycko3nsxq7w3oj7mbnsa4ttmd5c7xcnjkcqmv4qyrednr@qbsiizpo4dma>
Content-Language: en-US
In-Reply-To: <fj6hhycko3nsxq7w3oj7mbnsa4ttmd5c7xcnjkcqmv4qyrednr@qbsiizpo4dma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:3:18::27) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 554c9401-7496-46e2-448d-08dea1e315da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TmJFDJ/vaTCF7alXpTyBYj8+A+Tk139z3Xn1E1DmGdw+2c8CfYFiylhdOCCbgTTWAzz1uORZxzw0lHn3Vcs8IOwR/M8nZzSn+kulZy36FSW0zkQtchuN+3UG8wTN6/CnQBhD7OYENnMSH/EVHsoXWfkxf2pYccRZSK/pttRg9q4vVTMtalVnmte5V0YJmDG6e8Th2sxUZb7EvZ2u5DdmJNl7qgIKdjZqZM+ESPuQYLv5cB689BkBUEAPi/Oi+5lwQrE3JXbqbG7kWeRAfM8Etg3b4d5kEWfkBQRUYshPtKpa0lJ4jumufets84ao78wH9H67/R7hxXZ3gHiRAyW0C+7LLu6xXYpL0KmEVHKE3e31ceCJhpZQi+lRJefKWC77+6iAiUWnjsFC6b6eIHTM8/syvzFX5rAsWiiI+V98qkaqd9T0nw+3fVXqYHy+wsXM1FhISqd+FznljEklRasXItLwh3+CeZSNrsSEZh35guGntcvJSV/QTt5HfQpCO1sTziyjXtn2JYCbYT4U+vsyqJ5IN5SmkVa7qoAFJJwfxW/yQSUxIDk0ScFclaA+5R+qhJHO5upmww2URBuRCPPw1jVPG6j26fftQ1mYBLpaQLp4mWpdQdZmMgGOn2Os5h0NMgDwqGrz56dKPaSwioRngEug8O4tq/WL4eg0eegFIsbsrxULZl2Kl9ALaOUXWtPZhUov/Ar5vZZfUiW81XjCHiWyKGL7fcxbNWEzSzGx3Zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZyQnBtS2l1NjJRSituVjRleDdGVUZJNDQ3azJHZWpyVzltZnFKVjA0VEhU?=
 =?utf-8?B?bS9qa3ZVUTFRNUNuSTBkR1hya1o3TE1JVUdoTlE2M3FqeHduRnByTHMwZUlZ?=
 =?utf-8?B?WXhwUVlJNnNCTHV2V01ydEllVitlb1lOK1ZONExuN1FSRW9kSHhvdVk2TWdk?=
 =?utf-8?B?ZklXVWtFKzBSbWdKRHR1Y1JxemE2cUZVVjF3YWlXZUpscmlrbnpsb0JIZ1h6?=
 =?utf-8?B?SU9yeUlXclg5VGY4SWFrelBVK0hrK2xzQVhURTF6K3NSQ3lBaDEvc3RGZlhv?=
 =?utf-8?B?VDZ3NFhSYlQraERVS1YxRjZWeGl4WlBYdVFBVjFJejNxY3BRenJtWEMzbStL?=
 =?utf-8?B?NDZEaDdkRGplLzNDbU4rYlZGb1Jyei9lcGFSQVpxbUdPMnI3YU5MR2tMTFI4?=
 =?utf-8?B?Tmx5Zkl2R2loakJqQjFnbjB2Q1UxSWpEQndCQmR0c0Qza3ZIdGRFUms5b21S?=
 =?utf-8?B?N2RHSGJYNHpPVElQUWt6UURYajlFM1FkTzlqWVZyak9aSWNIM3BvQlk0L01o?=
 =?utf-8?B?b24xeUxYZDVUbnpGUGFUM0MwRXdjYUlQNWt5Tko2clZFSmwzZU5GTEo4aC9O?=
 =?utf-8?B?NEZJQThVSGpWajBrL2RLSGZUUnZoRWNoaHdURXdIWWxhR2xwYzNqbnM0NXdh?=
 =?utf-8?B?VkI5a0VYNmVzZE03N2laSDJwaG95VDFoWDFoNCtGK0EyTm9zbklTckZaT2ZP?=
 =?utf-8?B?RHFKRWUxb0tCTzM4UWd2WHlRaVhBLyt4bkVZSXF6ZGp1SFdFRzhwbmVzUTNz?=
 =?utf-8?B?L1hVYmx3elNkZlNmWWZid0MweEdabWo0cTJWaENmTDkra2dNdEc0TWpWQkYr?=
 =?utf-8?B?VWNwRlAyZ3FNcHlaNkNtTkRTRmZtdVRSdjAvT0lYRnRJcG8vOEg3c3JFS1Z4?=
 =?utf-8?B?VVdDN0lvdmRmRWYzb0ZDR2RwWFl0ZmIyVUhsdWdUVE5qL1p1UmlrWkM4dnhJ?=
 =?utf-8?B?WGErQ1FFOVpjeUh1YjZ5eG8rK3g2bllMcFJBTjJydmo4UUQ0TDdKbzZiakJO?=
 =?utf-8?B?UjlyT3JtRnFldENMUlEwRnZ1emI0cU01U1o4SzZ2MGs2TFZWaVo4dFJOU0JC?=
 =?utf-8?B?U3RzUDI1STBMZ3Y4WXkzNG9vQ2hDNW8zNXZRK1RKNW1RZ0hmQnJFMWVmK2g1?=
 =?utf-8?B?ZnEweUk1b0x1bU9jb1gzWGE5YWY3eGlnSk5JQ2JsYnpiTDI1c0pSQnpvTFhC?=
 =?utf-8?B?cHJkOXhmWkVlODRKUGxiUVR1VGdsNENvQ3c1Rm9oY1puV3ZsZUlSdVVxSU16?=
 =?utf-8?B?M3pzck9EUVBWcU9tZVhxdVdjOXhPRDgrSU8wT3Z4UWF0OWcwcmZMTmJIaTMw?=
 =?utf-8?B?cU9tS1RNbnMreVorL290bm5yMndBd0QwOHRnN1NXS29hSzFIb1Nscm03cXky?=
 =?utf-8?B?a29sRHZyNTI0VitERllmSit5eEVHbVFyaUpRMUxyZzhQVFBZeTFYNlZkaFAy?=
 =?utf-8?B?eDl5YU1LcFpjY0toWnJGOWZldCtndXBOdEdVNFJORDVwcFd3a0ZFdVZTVi9a?=
 =?utf-8?B?WTI4bVBsUEpHRzVwK2V0NlJWYURHa2Q5Z0djcjQvUk9QOWlSV1FhN0h1SDhC?=
 =?utf-8?B?R3ZaRmRoVk92VEpkZ3c5THEraTYzUFZJZWJqWDAxemtDcGM5NzJ4MDdTbGVj?=
 =?utf-8?B?RUYzalN2dEN4bGR5Zjl0KzdWbjRObVQ1azFWakk1SEpUaFFzQnFNbmhOc05C?=
 =?utf-8?B?dDJydm1nV0IwS293dDM2YTl0eFJNc0pPM1NnTkFkOXY5dHZ0M1IxTHR0RldD?=
 =?utf-8?B?dUZkV09VMDRBT0pHeVFRQ0lFYi8zb1ZPOHMrcUphb2d4ZkcyOFJJWlRIOVhR?=
 =?utf-8?B?bTRTN0s5cEo0WFpLNXNjd1RUalVpc2hMZE5YaHBLRjZNNmI0d3JSZjg2QWlG?=
 =?utf-8?B?bUV0SGtmZ1JFMkhSdUcvQmlYaDZhMEI3Tk9hQ3RhRGZRYlFqZlhyUUV1bENJ?=
 =?utf-8?B?QmJNaytxQXFQTFlucTdBZFFod1JHb1NHTXFjRW4vc2lwaDZ6QnJFSGVYaUdM?=
 =?utf-8?B?U25TSzlNS01rVkNqUU9OcVRUQ01IcFFhekpCYVhOUSsvMTZNb2JrVloxVHN4?=
 =?utf-8?B?a09EbWJ4cnFKRFNTTXMydkF3d2NTQXI3VEJOdXd6eFVsd2JiOXhacmNPM0Fa?=
 =?utf-8?B?dzgwQ0Y2UXdrZ0N1dG1lNCs0SXNtTTBlNkVGY1l3UE4rcEFCL3NrMkRmVDMr?=
 =?utf-8?B?dno1bkIzLzZhVEdZaEV4c05hRytGcHFsTW1QT2hYMDVxNHdORTM1Nm1POXRq?=
 =?utf-8?B?U3ZjS3RrRkF5aDlJRTZxMnIyRFg1MUdkcThYbU9IMndnU0QwQW15dm9Ha016?=
 =?utf-8?Q?2yhbEwbGfoHVxkwliD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554c9401-7496-46e2-448d-08dea1e315da
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:23:03.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKYKvZD5po2bAhP0jgwY1k5AekF4wunE33WTW9QLjHEohNLKnahTB7NwajAzYcH6TuEHdDFyKWD6C/p7SQPcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604



On 4/22/2026 4:03 PM, Yu Zhang wrote:
> This patch overlaps with mine [1], which was sent on March 31st with
> you on Cc. Jacob has reviewed it.
> 
> While I was still waiting on your comments, I realized your series
> goes beyond the dead code removal. So I believe I do not need to follow
> up on mine.
> 
> [1]https://lore.kernel.org/all/20260331152550.479841-1- 
> zhangyu1@linux.microsoft.com/
> 
> Thanks,
> Yu

Sorry  I missed that one. I will follow up with that thread. I am 
sending out v2, and will rebase my series on top of yours.

Thanks,
Suravee

