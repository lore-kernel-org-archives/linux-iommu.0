Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587710E3
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 05:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyhKFk1QrVXt4Mj1ojnTwxDifP1oq6PuQo3wGzXXfwSkZT/FaCmril0YkKftyBERTWJPlLz/T/LAAa4M3Gc1saCta9Mf7oz1yczTPG0KnPQX2YOtWiJUdyhKxruSRwFhjfRZua+A0GtEIdcBxLb01I22Ou3w3pVt8ZuXRovwyvu+3FPp5B3kpegJfjMn83NfSvc3w6an/WP64SJNy1dyFLVla6QXF/jkBMXPu5+KjPEnxLlGKgfv9Fh5USpM2mRvhM716Q/5cIYiVC68xpPixIkxYYDAl3GxITsVlkJOS4CvKX22SZa/aUiatx1ozgPC9Dklep6ezFbIBQJX7Y67oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COe1OJJExaHHKjNPM/gfdJR2e1anyxxaKxG6lR2MGk0=;
 b=AeXHGBsab7Swwe+/ztx7W+aVTPMmGOVGp0lfXZyMJj4mDUTo9nFnW9caHawGy6x3IVB2/hUrXobjc4mbcDZzeF4aLgiOdssuwTE05GQ8wjxgLKduO69yhsCF3YH4uxXn75puhMtii6l2YrkL7BrTTLIHl5U1DcDy6QfnBi28zjt+yW++nSb/pOJ08CQMiPCV7MuGWL3YXmZjy6vA90emKtPaC+vPXsoInm+TbQTOQ1r4WaGvRBnFWKqN4MD8fDCg/uJhqHFBmyU89lNbyo2/BPl0upeO4ifIjci9pSYm2hEMpgtL64Ee7BN5DUZmqoLzTrsjsCUUweZ3DF3f87iTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COe1OJJExaHHKjNPM/gfdJR2e1anyxxaKxG6lR2MGk0=;
 b=JKdarAAX3tMLI8azv84fEHwdOcHWcCTcLVG0vIfUCZVcZe1G6QyolHuJYXw9u6CErRSynmXKhQq2U/JnZxh84dtASGRc8x/ymkrVedVN2EtyTVZQ/Dhmx6WDdk77G50oI429cPuJ6QNEhOT01JbpLIc61+ggpidR3DFwn2QlkAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 05:24:12 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::9c21:b741:5bff:f8cc]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::9c21:b741:5bff:f8cc%5]) with mapi id 15.20.6178.038; Wed, 29 Mar 2023
 05:24:12 +0000
Message-ID: <52179d8b-c49e-f07c-decf-63ad3f8798a9@amd.com>
Date: Wed, 29 Mar 2023 10:54:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: AMD v2 page tables
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
References: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3c0e41-20e4-4be1-813a-08db3015d433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P9ROR1JWcw2Xp3kL9J1xszo3BoY6gvSsQSnb0+15oSwGyAG5qoBCtvfeIGqek6dvjTOp1Zcg0MUnEvwyE2Oxv2aSQMmJvvQvyOVRVi4xqp6ita/N+FTv4rmThczf1oAAOmHkECnXtyiatZAbKMZYFaqXVOeZmm3SZdbWNl0Fjvp01Swo6Fu9Ax3ZVYWDSYjw0YXF5TD5vK8a2QGjWubenkoGAvlSz/BZb8+jnmbgISVGZNtnHloACpDqwWsRgTY+En9ijrOyM/1ijpEE3n10k8NCVEBwMnB2EkXAthkzON8nWtzes1nmQrzG+Dc9Yh/G1tZcH5xNYfbnkDu7ZVSDmuDZWWd5ROvd57NdYz1W7eV+x93TYr/NpIjQEr86mrHPEXWpizfsFXb0+6cy0r7qBj6nPFsAF76lxN2m6jP2kDP+1dpspojW3vkwNkKI3K+K2Dj+HHzYXjWAYt983eJArMvvq+fOrglRzmVRmqfVu0HM0J+SjAwHEGfXYR4tbzC2FWcHeqjGW4gyMlrRSTzp8l2XM+PlEaEZoWmWzmlfpbYm+zNQBDm+1uBAREdCsTV+DOl1Watzugx4jXOJFEgFhwscOOiJe1ZeAVuCEEU70jj9O2m/JReA1p3uknl7Rr2Ile59H69LMpHrd7ojmb6SAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(6666004)(53546011)(26005)(6486002)(38100700002)(2616005)(186003)(44832011)(2906002)(8936002)(5660300002)(6512007)(6506007)(36756003)(478600001)(110136005)(316002)(86362001)(41300700001)(31696002)(8676002)(66476007)(66556008)(66946007)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snl4dnROTlh2SjRScjcxekcyMkNRUytpT3JYY3hkVWtsTDBkSHlVK25RL0VY?=
 =?utf-8?B?NWJKcGFyYVNKOGZVQTlNYU9LcVRvVlV5cE5VVHJaeHZvQWJKZTMxaGFNTTVi?=
 =?utf-8?B?TDlUZ1dkQjB5T3VsQTJnclMzek1ETGgySmMzQWRFdm9LUk1yeE0vRWJKcHJu?=
 =?utf-8?B?Y0J5dXdzZHU2V0VrRlRZc25ldTE1YnJ2UUF0L1FZWlBoVDJiK2pLMWl2eWFo?=
 =?utf-8?B?U1I1eU5BYXhwakRmWlFrMDhIZXdvUkVSNzZVelJqT3NTODgvMEVMMjFQRG1H?=
 =?utf-8?B?eEo3b05VVXBON2NxdXVjTWlIMVhmbExOMTRmdDlMRUpvT2tMU1ZMZlA2SW9m?=
 =?utf-8?B?QzJvVVl4Z2s5YXJVU1puVTV3Mkh1NU9ITVpiK3IwUGE5ZkhyeTV6Z29MQVpK?=
 =?utf-8?B?TFB1ZmhMR1ppaEpKMFJWcGNFSDhVeS9kMkRGWkppcnd2TXJsdUcvMTd5YTd2?=
 =?utf-8?B?Umk4UFl4eC9mUFpqK0JYZmFadkpDNGY3aFY0WWZtWFBmRFk5OHMxQWptTDU3?=
 =?utf-8?B?dXZKQjFoN3JDWjZEM1RyY0ZHdU1POFJRYTZjYzB4dTFqU3cyS1lwcUVyOW92?=
 =?utf-8?B?VTBUMm9CZjUrSlN4SXVwcVdvZzNLeHc1cjJFZ29WM1FEcUNOOURBL05sN0tP?=
 =?utf-8?B?M2NPRE84QVZtVlF0Zy81eUppNWRxdkxnSElNdDN5M0sxUFRiYVJac3U2VGg5?=
 =?utf-8?B?b2xnM0Q4M1Rnak5UWk1oMEpaSy80SDhqSVJHL3FlSlFuK25JckxSVkNUWTZ6?=
 =?utf-8?B?Tk5KdGxkLzQ3dnhBNWc1bU02Vmh1RHdYSTBMY2dvcG8rSVgxTWRIcjk3WS9Z?=
 =?utf-8?B?dHBaSVRjVTM5V2FtVFVFU1BUcEppKzB6c2U0bGE5UkRaRWsxRTdkZDN3QXRz?=
 =?utf-8?B?a3hJOHVHRkExY1ppN1M5enBzRlpIclFVNnduK3RqL3ViMnliQlVVWmR0WWNu?=
 =?utf-8?B?MHRhRk8xSmplc2h4U3RzeDVTUUZOS2xoWnpJN3ZQdHBsUkhteEdoWWVkbmda?=
 =?utf-8?B?dmlPek9LK28xaFh4WG9UOGx5YmxzU0Mwck56Sm1UQys2YStWdUlyMkErSkVa?=
 =?utf-8?B?bjlNazhzOVZlaGp6TG1RdnBEb2wzU3dEQno0U24zNGdFbWJmMVNOdVF6Y1NX?=
 =?utf-8?B?aUhBMWVrVkE4YU44Q0wwWi9kLzZPQUE5emNBN3hHNjg5ZVRmYlhjVUEvdXI0?=
 =?utf-8?B?ZmRudFNFdUw3OXZWakg3NUlKMXlqUzY0Q3ZDYVhzSk1GUXIyRS9MaWhBNm11?=
 =?utf-8?B?c1lkd3h2aFcyTlBLQkVON0lCekdKSVpPRm9hWXRpSE5MOVBFbTQyVEl4Wkph?=
 =?utf-8?B?b2ZoT2kraFlDOFJlMVYyMk80NThOdEs3by9YcE5TZ2RGaXJ2cVB6ODExNmx4?=
 =?utf-8?B?TlMvYmY4MlplUENJZmEwSzhjWWQwOVNGbGRGUzBieG1TSCtCQzNFK2NFb0JN?=
 =?utf-8?B?YUJPTnpFcGFZWElSdlVXMkorNXJlSlFPY3VseEJpcTJRbWMyV0lhbmdrTWY3?=
 =?utf-8?B?OTBKeHg3akU4czArOXE0ZnYvMGlHUWJ5Qit3UDBhUXN6RXRDbE12R09BRVgv?=
 =?utf-8?B?Ym4zVFp6UGY5NTYrbnNBaForNUtFWVhuaFo4bTVHUFZ5eGVmSWdvblcxNWp3?=
 =?utf-8?B?NnhENi9KVlpRQlNOK3haeDk0Nkt4VjNsZGRNTHQ2VUVHMDhhb21yVXF5TkJo?=
 =?utf-8?B?ZlNGQ1BrLzlCNlFYSk9lM3lUN1A3OG80MHYxelU4bVVDSDlQaUhnKzNKL0Jz?=
 =?utf-8?B?TmF5anMyclFuK1pPRHAxd3NTZHA2TVBtejFXZmRyOEtUWXFRc2JuNHdlOTdP?=
 =?utf-8?B?RUkyTlFxSUMraGVUUkdJUXhsUks2YldybFIwRWhXSEhGMkJ5QktmTndaK2ky?=
 =?utf-8?B?TEwxdi82NVRNUnhzQ1h1UUhHeDdyMjQ5WTZYOTVoUHhiZ2NWMnFnbXEzZ2NO?=
 =?utf-8?B?WFZObXVWZ0ZMYTlhTURPN1JVdFRTdVJZcjlVWGdRNXNyNDN4S1B6cWdkZVV0?=
 =?utf-8?B?bWFzeWY2UUsrTjU3a1BDRGwxTWFjUkFtRWF4UjJ1bi9wNzZ2ejR5cFFPQ1Qr?=
 =?utf-8?B?Y0VpdG05OEZmeGhyQU9TNVFIOGVCcUFMd2cxNnlIeW1JUkpwU1A3Z1o2Nkdh?=
 =?utf-8?Q?rs7QoAfGuQ4/Qdw/emifkA3zk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3c0e41-20e4-4be1-813a-08db3015d433
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 05:24:11.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08rZocE7Hb8YoOsQiNASs94+/fNbsS4cAv5qWvWUKuKnqEQZ2L1kogT3eWJG4jjyhPrIuN563St1p9FLsoQRDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

Hi Jerry,


On 3/28/2023 12:03 PM, Jerry Snitselaar wrote:
> I was looking at this the other day, and by chance booted it up on a
> system with a megaraid_sas controller in it. So it had an IVMD block
> for the scratchpad or whatever it is they do. During probing
> iommu_create_device_direct_mappings() gets called, and pgsize_bitmap
> for the iommu_domain is set to the V1 bitmap because that is the
> amd_iommu_ops default. So iommu_pgsize() uses that to figure out what
> page size to use for the mapping. Then when it gets into the amd
> mapping code it checks that page size against the io_pgtable_cfg
> pgsize_bitmap, which is set to the V2 bitmap, sees that it isn't
> a supported page size, and bails out of iommu_v2_map_pages().
> 
> The following worked, but I'm not sure it is the right answer.

Thanks for tracking it down. Patch looks good. Can you please add below cleanup
changes and post proper patch?


------

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..167da5b1a5e3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;

-	/* Override supported page sizes */
-	if (domain->flags & PD_GIOV_MASK)
-		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);


---

-Vasant



> 
> Regards,
> Jerry
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..040199ac8546 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2048,6 +2048,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->flags |= PD_GIOV_MASK;
>  
> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> +
>  	if (domain_enable_v2(domain, 1)) {
>  		domain_id_free(domain->id);
>  		return -ENOMEM;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..e70e5cbec8cc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  		return NULL;
>  
>  	domain->type = type;
> -	/* Assume all sizes by default; the driver may override this later */
> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +	/*
> +	 * Assume all sizes by default if not already set;
> +	 * the driver may override this later
> +	 */
> +	if (!domain->pgsize_bitmap)
> +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> +
>  	if (!domain->ops)
>  		domain->ops = bus->iommu_ops->default_domain_ops;
>  
