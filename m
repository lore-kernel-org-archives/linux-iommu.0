Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258E4CE685
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408547; cv=fail; b=Pu24IejxFBphzD30zlYygPpVQYp9ErQghKcG/17gdiw9PgOdzlSN1gDxn84IoTGQLGuoMinrjp1A825S+nK87hQ+mk8ubdzrUZDZcJ9hcZBLoOEcSFHktKXcnliIvzbv7DRCK+vBdhWm0u64n2Ez/6sCW1yN+lvApItvpT22Z7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408547; c=relaxed/simple;
	bh=+e2xWD8fla82tx6Q444ZRxew3vqPXdotMUs9zKNdxzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxE6q76zQDWuJ8uPiVvXedxHVDyH0uW42GRFdMsE1KRF5DQacAFStqh84e9oUiDcPfi82mf+jIBMiqIte4g/1v+aLupXOhz/Us+bbFGnB327j7/Obh09CGXXevasD8N5HCxzpI/VPDQT2OaBp0vdyI70E3WLl+z5kZF4Q4RAKiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jPr238H1; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jPr238H1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNEknKd+QJfZQ5ms+7SQIVSVX9Pu2b84cLLkralQUilpJDYy9q1jcI7b+t2IG+Wp5lh6C7CD1wH+JuIhBuGKv5Y+GdDJhUUGPeS8vStdls6xiIsXQF16gd/UB2ysYLTWqNP1Lx9cQx6dmOS+hN4xOL684+S6pmJqD4GiZSLQxVGIpx7RgcOOu4ac6Td0G+rsG/Xxao3uvG3AR68ZsmUSixwvtxpwUI6zQ/iTO+6IJlNipi9Zigyy0DKW2svWgbiN+AQFEkYalAAqmPu3nInVfaZmIw7d4FdtENX4BGFCZK90YnSkrvp1Nj1Befcywk9YKSyjDaQAGyqKDXi7j+QRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEL/77Ykx0EVUoK5kTN96XF8OvmbPiF+hc2EqE3x/K0=;
 b=SVJGF2G74Heet2hKD9jODpP8Z5UHvloiWnCtwBNmCzLfNcmQuY6EFHRUHsiEYg020JIes1eTxOxXv7YAh7D5ACBjEYnqpXrexwbdDUDt0VXmMoKmeMyH/QDUBLrk18tpQTJ3f62g99W8b3K+N4aNunPbxBBW2pqKC3xKs2biJ+e0LLeV/FSp1pYIRJ/GJzmygmjekMst6atJQQmVBCcGXHQOXomcKhA6n2qOrQxicLRhhqN6Yyl9CQUfUOALO/cqjRM4kCLIWEJ00N6OGAzLFwuztMghuI6g028AqM3LA53W6GnUUpMKY7BlawYLyIveYlRffJK8i6zB3utWFnyBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEL/77Ykx0EVUoK5kTN96XF8OvmbPiF+hc2EqE3x/K0=;
 b=jPr238H1RL88Vee5lHrKWjlZKnjsY9Hs0N3T6YcikLKPYcZFW0wrEmJvUGt9fQF7lXmkzPxws7ECcH4TumA7ajRc6d/sdru93/3ZZYN0ifa428lSLEcyOUa+RusEmVJvQAAkrsgOnUik5FEV4odCAQBePj/vhynTd8FHM3/rjmE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:15:41 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:15:41 +0000
Message-ID: <493c3009-e83f-4c95-8816-4927c06fff77@amd.com>
Date: Mon, 19 Oct 2026 16:45:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU
 instances
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
 <20260930092344.5616-6-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::9) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f913f8-b8d5-4af2-7abc-08df2dd24f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	INUfF9smOUrEU6BoZWB3C1TTSZr35BLT0p8i0gjC4EXsQHYY45Q9Y8LyjQ9WmQr3L156LMbNGJYuW9/7A8utPpUY1DMHXG+UrHpZzdCF/AAeuPvzKFZdagpypBHn/4uk8H08D6BT07ubdYQlsEN03+KyM28rqYey9VZVzP31pXJvltIscBujZxyQ3IfJ3PCSfvPlL0i5Ay1kglRcapxxPQxeVPvcDGrmOTA4H+HoKnsXkedIjkpJ8X70ue1gdwUI8UBz9kly0auFB3A2GkNS5gXHbUeTpfSsFBD/w5T6q6ufJwjvsRn39Heax1FSl/g+HP5oKIXrmNpZvYXOnSHNMgzGoIIDpwdCSt7BkzWsbA8i9dVw2r/DJ83yMTie/Oww05R8A4SL5aO/EK1X2Vo2VoQVRQ1JHf3EN0bSKzcQsRwpsEHaoTiAfNa3UITo/Ge4OuVl2w6rD5jlchuOsC0IdMeNbg0eSdPP9LUaiMiMAuQ7Z78c7ntMj8l0NJTxU1eQKTMT3SsRBuJs7qYZp7H86lc089hYog1FW2mMhMJ1aWWJtc25pts5uRKJ08DbomGtMGzauVsKbtaJ8XEhecHGcMweOvDtDX6QRbyvEEyybAHpdPn4mISMXXi20Yleezhy4gt1kp5nmFvDtHK0VlsLwQbB8z9D5cVjZtkJZmsLMrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE80N2x3NUxHbUVNSWk0aFBUak4wbG13eUhzL2g4em5uZE1sODBYc1hzSTFh?=
 =?utf-8?B?TFRFY2Y0TDFUNm41R3ViRFZZRnZIZVljOTBTNWpNb2pzcEtxT1lYM0NXekUr?=
 =?utf-8?B?Qng3VTdpZktSWFR0NjNmNnFqQVFhVlZCeW9ua2JIYzk0a0o2TjdRRDlxZmxN?=
 =?utf-8?B?SDhPMXM3a1M1NnhFbDJ4YThaWVAxNmZFTmpvcGJkQVh6Nkx6TGtCbGZLdWdJ?=
 =?utf-8?B?OXBjb3Y2SGlHQXJveWxSUDBVbzl6TW9neWk0SHdFS01WdVFaK2krVGFVRGJF?=
 =?utf-8?B?bzN2Wjg1MEk0K3BVY0M0b3VXdFFMeWVQUG5LWW4rRzhJWG8wOW5rWURXeUFh?=
 =?utf-8?B?RktUc1hvWlZjUTJCdTh6RHFsREw1NU5Gc2YwWVhOT0tQR1hrOG1BaGlPVFcz?=
 =?utf-8?B?S0p0bDd0U0liTVZsL2JsOUFqMGFYVGhxOW52aHlvZHNpeGtwRjVPN3VZYkt2?=
 =?utf-8?B?UHFzaGVtaEF0VlI4STVSYVI5eFF0cmFLYUcrM1hUYUZjQkFmUXpncFo0ZCtF?=
 =?utf-8?B?MWx0RlRwTzZST3dPbDhadEhROHpCY0M0bThrV2pOM2lFL0srN0IxeUdGN0ll?=
 =?utf-8?B?MHl2SS9QMmJNV21ybi9lNFJJU1RvaS9LbzRmYUR4Ry9JWFZ4NGE0TGpUQjNu?=
 =?utf-8?B?dzI3RzdMaENlNXhQa1BVYUgyZFYvL2xkVlhMRmE3NVZTV1FucExlOE4rYXdB?=
 =?utf-8?B?R0VKVGhlZUtMd0h2SDdaNDFWUi9JbHgyRDg2bm5WcG0zTXFXUFN5YWE4WWFH?=
 =?utf-8?B?QWJ1ZFE3ZHhyc0tkWUlwUjZWNTA1Tkh1NVJRNnM2ZGZEem5WNUNTMzI1UUNo?=
 =?utf-8?B?NU4xSE9vaUZoMmhTeGdzWXZhUm80T3pIazMvMjBGV1FBQjJxczBreWxiTzRj?=
 =?utf-8?B?cnU3YzBuaXhqTkF2ZUhhN3BQUVJacmEzaVhuU0ZmcThnL0FJMFllSlBzRHJq?=
 =?utf-8?B?WWNLY0F3dEw5N1VjT3NFV2c4YWxzOFdKWStVR25rM01Hcy9RYzM3c1g1dDdV?=
 =?utf-8?B?djJoME5RdFVOYlk5MHR1ZFRRV0pLeE1qOVVSeEZaWFBQYWZPTDJOUzBDTjB4?=
 =?utf-8?B?bzFxbE5ndVZJNU4wUUdtS0JJZGZKaWdsd0VkQ0Y3NW5LaGdTOTJqWW9oL2d3?=
 =?utf-8?B?M0NKOG9HYzJleS8wZEg2WS9WRG9rd1NXYjkzOFVsT2gxL2xDTE9pSXlRcjJC?=
 =?utf-8?B?Uld2Y3hEZGtpWWdhQ0lxcFNTeXFSa0hhUk43elhoZVJzSXRDNTFUL09oTFBx?=
 =?utf-8?B?TVQ0a0RlVkRvOC9CbU9BTTV0V3FBd0JocTVsQ2lQU29IYkk4ZFcyUXdRaklr?=
 =?utf-8?B?U0s3K2ZiQUNDTlNuZ2lSZ2dBbm84YkJDU1djTW05b1ZQUjhReHR1UmVORnpv?=
 =?utf-8?B?anVqWWRLVlk1b3c1VkV6REF6c3pJQndCenU0dmo1bmV0U21HT3ZZYUF2SmE3?=
 =?utf-8?B?YUlZM1haL1kvMzEwUVJseXJlNGxkWnZ5bkhzbmt6SVFDYXhjVkdZR1NYMnFk?=
 =?utf-8?B?Q3Noa0RJUkhSai85eDRuallGN3hnN2hBYXp1ZG1Ta3N2QlByRm5hdHhPMDF2?=
 =?utf-8?B?MDMzcE53SGRYM1pMalNXMGJBRWNDc2VOT01TNWRNQ3orZGdIa1RpcFBaWTdT?=
 =?utf-8?B?Uy93Tks4WFJDYy9zRzZUNGp3TWU3QnpiOGRubmYrUUlCTDJ5QnlaQ0dDajNw?=
 =?utf-8?B?czFRdUhBT2pUcnd5cEtOcWRTbVlBbUNpcm80b0duVXF3cVVLWXoraGEwTWdW?=
 =?utf-8?B?b3FYOFNtL0E5OFQzTERMRy8zQlBZa216UjA5U0UzTDJwVXF5d0FJRjAvNCs3?=
 =?utf-8?B?d2J3bEU0eWFFYVVyY0pJL2dJbkdPeXlqSy82dEVRa04vSVV4SnVJbUsvTkoy?=
 =?utf-8?B?bTdFQmtWUjBDcEU4Tkl3Ym12V1EvWnRES3pMRTc1TitDaC85VFl6a2gwenZi?=
 =?utf-8?B?ZG1VOFNmeUZEWm9EOVlFVW5BQTAydk9zWFg5NnpiZkIvbkVrL0R1SmZOakIy?=
 =?utf-8?B?K1ZDV2t0MDlUcm1sWnoybHN4MlJkWU5uZkZ2WEdtdGxVOHZyaE1ET0wyTnVt?=
 =?utf-8?B?bTdaU09qVnZCUHpvQ3k1anJKZnZ1YmhJTFRWME5XenBLYkpuT3pjVnR6ODhU?=
 =?utf-8?B?aGI2bTh4cytNZjFKRkx6VnRtS1BWSUErNjJGS1J5SEdMc1ZubEJtNFFPOEtX?=
 =?utf-8?B?a0VOVXdoenFyQWJ3Y0FmeDBoSElGOFBjelZyRHl3bWg5bFNWQjRDZ3BmZG4r?=
 =?utf-8?B?L0tKaWhjdy9SZ3ZITWwyelUySzUyQUJQRGhqNHZVS1VZRXVZZ281T29YaWk1?=
 =?utf-8?Q?eQjrLWGhOz/or0yS5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f913f8-b8d5-4af2-7abc-08df2dd24f68
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:15:40.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+u8GILGD7Ehc/aLcVKl/BqBu0JFAIJumsYZ3DjRbj3YGAt80pvyfe0FRL/Ug7mefWsxqMbouZohNmtnqquJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Hardware vIOMMU uses a 16-bit Guest ID (GID) per guest IOMMU to
> index driver and hardware state. Allocate one GID per IOMMUFD vIOMMU
> from a per-amd_iommu IDA (unique within that IOMMU; a VM behind
> multiple IOMMUs may hold more than one GID).
> 
> Add amd_iommu_gid_alloc() and amd_iommu_gid_free(), store the ID in
> amd_iommu_viommu::gid, and call them from amd_iommufd_viommu_init()
> and destroy. Initialize gid_ida in init_iommu_one() and destroy it
> in free_iommu_one() with the IOMMU object.
> 
> Reject amd_iommufd_viommu_init() with -EOPNOTSUPP when the IOMMU
> does not have AMD_IOMMU_FLAG_VIOMMU_EN.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  4 ++++
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/init.c            |  2 ++
>  drivers/iommu/amd/iommu.c           | 16 ++++++++++++++++
>  drivers/iommu/amd/iommufd.c         | 14 ++++++++++++++
>  5 files changed, 43 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index b2ae17e3df34..f6cf412a9820 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -227,4 +227,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
>  struct iommu_domain *
>  amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  			      const struct iommu_user_data *user_data);
> +
> +/* Guest ID for vIOMMU */
> +int amd_iommu_gid_alloc(struct amd_iommu *iommu);
> +void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);

How about moving these two functions to iommufd.c as this is vIOMMU specific
functions and not called outside iommufd.c ?

-Vasant

