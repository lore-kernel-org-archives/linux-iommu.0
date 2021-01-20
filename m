Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C0C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 11:03:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F584223E8
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 11:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F584223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2CE084D09;
	Wed, 20 Jan 2021 11:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gh-r6NOu7ijf; Wed, 20 Jan 2021 11:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 172EE848AA;
	Wed, 20 Jan 2021 11:03:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D93C08A1;
	Wed, 20 Jan 2021 11:03:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44ACDC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0535184BDF
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ6pXxyxG3rz for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 23584848AA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQqk+xMR0wPT+qGPhfTVq7mCqVnmCcaG9qKfMlF7UfYggcO7pxOYZaqKcsXrkB3NtfsN1by65E/7KxQ0FBIQUuMuXI+XiQD+8/1hlsBBoOQcbt1Rg2iUKYxZS+qmO87Oa9s/LoFzFzTCLHkkonBlZyhZg7FH28NvoTT+dGzeQtV0wwjjk/P9U7MW42qFSIdph/bHeEwdHlx1HsmgRa6zerMHux+nfrbTdg6pQZ5gBIcOcBezJ9JHNVOXsdf8W+oZCHTiiXX8gpn38g1M2jSMzT9lkOU5uHZVPJwanUDjujRkE0uCea3Bxlsmdr3CDe9GirO5jYNW5LJ0Mq5BxHRrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXMlbSM+hj9oyV1f7EiikUXktJNnLAhn5ykvDVO8MOg=;
 b=bqNRsDDTSkaRnNoIj7+f/kk7g5rT3iSvNGZePwvl58LUX0i8my3q/sUYDMx4sGBCVvK4SYxvBqeQ7DVF1mS917r8sng2S0xXhqiwcwcss3PbA+CiZN+jkkJdanff8ZygQAdGKJ73IU2JL6P5Ug6nM/wuVEkXBfAJwOpD1/4NdWJQqCcOf0oZp5B2aFg+quXGSGJClCK2P6xM9ZW60900rR1LQp6E4an4zTVCKize5+1kRGTs+Yws7PEDV5tPO+A7ReS59He9MyEEs5kmRzhyf5Vht82Sw2Tld+JT15gKCkxVE/jM4CtolIi5klA+nuKezfEKfecDwuG06jm/ZMby2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXMlbSM+hj9oyV1f7EiikUXktJNnLAhn5ykvDVO8MOg=;
 b=zQ+InMIiyhRWkYj/k3M6PHgJ7gwiYu3zpGerOqtK5qBrADW/1IwVz7uF9bnnM5xctb1xizbkGh24VO4i9YMLXl9UP8ltJesZrJmc+dOBMKVfBlp6WvBOeS3FLcu2wVoySDJZJ83Q4ZoVHK+qK+4l9ygEFDgdOVQHBJQejqjGyuo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4601.namprd12.prod.outlook.com (2603:10b6:5:163::16)
 by DM6PR12MB3628.namprd12.prod.outlook.com (2603:10b6:5:3d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 11:02:58 +0000
Received: from DM6PR12MB4601.namprd12.prod.outlook.com
 ([fe80::847d:8fb1:64af:b25]) by DM6PR12MB4601.namprd12.prod.outlook.com
 ([fe80::847d:8fb1:64af:b25%6]) with mapi id 15.20.3784.013; Wed, 20 Jan 2021
 11:02:58 +0000
Subject: Re: [PATCH] iommu/amd: Make use of EFR from IVHD when available
To: iommu@lists.linux-foundation.org
References: <20210118051927.2905-1-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <17cb527c-ab98-8b00-e355-3538326f92c9@amd.com>
Date: Wed, 20 Jan 2021 18:02:38 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210118051927.2905-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-Originating-IP: [171.96.72.163]
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DM6PR12MB4601.namprd12.prod.outlook.com (2603:10b6:5:163::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (171.96.72.163) by
 SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.0 via Frontend Transport; Wed, 20 Jan 2021 11:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec482206-7923-4f7f-c42c-08d8bd32f218
X-MS-TrafficTypeDiagnostic: DM6PR12MB3628:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36288E0F936C66E69117C354F3A20@DM6PR12MB3628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDx66YH+dQvCgqfzyhfVewY3B/D3W22jupSdvZ6lD994FGzixMrjn4a93Ly8hDH6WG5UAoXMj9gWGXwcKj7kKbd/LusrKXZjQBxZYy/GUk+9QHbgOv1sSi7B3b7ync7YD3zYkgF6bDo5jgP54hMwkD4mBlMZjV6maPH6Li47HzWY70YvdJb0VjWVug1ExhuCJxANkFr3o5NEFa7CYGbIABrz6zB9F7I2yIJViZsUpaJCNaQDLk256gGZYODbJzpPczrBcae4LIJPvkbKAdS28nRhDTs2+u/mU4Z/pD4fugthkTj02oQhFbbCqP+MHg5+wpztUsLyGsa70AeduXX+CUIyMpLpaVAKDO4VbquWFpgvOQZoMC87yNNO/sZAuKE6TFBmUcIORwgB99TNe0y0KleVEGUPN1eZ+i2XYg0luvA3Z9AW/CFsYnxD42ZVkseNlYlY4MyNTV7GjzwhKtd6uL9yDNae839LwRU1IQD9WG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(2616005)(66946007)(6486002)(86362001)(36756003)(478600001)(956004)(5660300002)(26005)(6916009)(6512007)(316002)(31696002)(66556008)(83380400001)(2906002)(4326008)(52116002)(8936002)(66476007)(6666004)(8676002)(16526019)(31686004)(44832011)(53546011)(186003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjBDcCtYTHQwR3FiQ2ZMSXZYUWtuejRWUTNZZEZya0NUK2NvMGdWSkNsd0dN?=
 =?utf-8?B?aGZSSEZpU3ZwN0FZRHkyVXltRXRxbEpCd1g4UEs0Rm80T24wM0pzMS84TXpB?=
 =?utf-8?B?YlBvdzIvMDJpMXh2dmFzVndiM1FybHpXNnc2YmI4M2NtT1hCM2xMUCsvNURF?=
 =?utf-8?B?aS94RlRjL1F5bjJINEhtUklBd1lIWUlmOVg0NE02T3VmWTNQcVNscEk0ZHlP?=
 =?utf-8?B?WWZ3TmlLVlNzdlBzelpleTRMTHZNcDR6dzhDTmJ0dUZLK2krd1dobThyMDl6?=
 =?utf-8?B?VFpKOFpmTGdrSWUyQlNOQ0xkTU5SSWdYZDlWaE1NRFJKZjdRV0p5WWNTd2VC?=
 =?utf-8?B?ejhtdThoaEc2K29KelM3WXNVNmQ1NVFVNDA5SUNkSFdKamRjazFJVmdsK2Rx?=
 =?utf-8?B?UUFDWjljUHRvUFQxMDhLeHNlOG1FTlpHbXY4WElzL0hHeDNHUXJLTTJwd241?=
 =?utf-8?B?K1J0bkVCbFFCOUZtVld4YklONEg4MFhqckxQQ0R1UTN6d2tPb3p3ZmpRczYz?=
 =?utf-8?B?bVExTW1ISTRla2VtRmk4Sksyblo5K0t0ZnF6R1RQMFZHYk5KRkFZcVUyZThm?=
 =?utf-8?B?cStwcy9HNzAxb3RLUHN4TU0xY24rcmIxZlo5Vmpzc0xzZ2o4Y0tCTjZuYThv?=
 =?utf-8?B?L0pEMGRSQWhneS9EN05FdmpQVEpKejB5M3BZd3gvYjI4YXVCTUowZVkzUmdt?=
 =?utf-8?B?eDFrcEZwOXNwM3NKT3RXQmlsVkpRTittSmJDdFZsZ1RNUngyOWRxRUh1RGVp?=
 =?utf-8?B?TmtrcXlUc3RnL200MmFja3BYeXpWYVRyYlhJQXZGWjE0bVh3WmxLRUppUkE1?=
 =?utf-8?B?N2E4Zm1wdGtucy9SZ01maHB2TTB0M3U0dStmaW11SWJLM21COU9lLytoQWFz?=
 =?utf-8?B?N2hJWWZKR1RtcHFRWmZIeXgyRHBDM0JKdVJhejJEaTBJWURwZGlZNVptL2Ew?=
 =?utf-8?B?cFlDMVBNL2xBajRJbjAzYkN3QTBnVWZyTWV3VHFyYmxVQmNhSW5zY3FZWGxU?=
 =?utf-8?B?VVRBQnlrY3hVWDM0Qkk2OThFMFpyRGJKQXdSQUFLTTFMUUp2UXdxNDBMc24z?=
 =?utf-8?B?cEtRZElYa1lXa2t2a2RDMzB0NWJmUHR5TXNsdWdvdDFVQ2Nya3VtOE5XTmVN?=
 =?utf-8?B?VklsMVVGRVhOSFhQQUVzcE1oNUlDb29mVHNvb1RNSDJ3TzNmMk1NQVpGcVlW?=
 =?utf-8?B?Y1hRc0xHcTRYbW9VU1hIZHZsRU9CcHFySXFhNUQ0dmF5VXZid0labnliSFRq?=
 =?utf-8?B?WXpKTHdpbDR2YlZaVXRRSjJ4NE5FQml2VmxPSmJCQXN0YlVGQ24xQWdwbzNX?=
 =?utf-8?Q?uR9q0xpeL1gE7D7ushL9puxfpRSe5Grx6F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec482206-7923-4f7f-c42c-08d8bd32f218
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 11:02:58.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR37+VGdIuAIehvpd9agiUPXijk+QsiNBzbLJx0FhdRD6WfleS0YKNq9l1XQa8nJwusiP6j4dpSUgcsTV51RzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3628
Cc: brijesh.singh@amd.com, Jon.Grimm@amd.com, will.deacon@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I will send out v2 of this patch. Please ignore this v1.

Thanks,
Suravee

On 1/18/21 12:19 PM, Suravee Suthikulpanit wrote:
> IOMMU Extended Feature Register (EFR) is used to communicate
> the supported features for each IOMMU to the IOMMU driver.
> This is normally read from the PCI MMIO register offset 0x30,
> and used by the iommu_feature() helper function.
> 
> However, there are certain scenarios where the information is needed
> prior to PCI initialization, and the iommu_feature() function is used
> prematurely w/o warning. This has caused incorrect initialization of IOMMU.
> 
> The EFR is also available in the IVHD header, and is available to
> the driver prior to PCI initialization. Therefore, default to using
> the IVHD EFR instead.
> 
> Fixes: 6d39bdee238f ("iommu/amd: Enforce 4k mapping for certain IOMMU data structures")
> Tested-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h       |  3 ++-
>   drivers/iommu/amd/amd_iommu_types.h |  4 +++
>   drivers/iommu/amd/init.c            | 39 +++++++++++++++++++++++++++--
>   3 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 6b8cbdf71714..0a89e9c4f7b3 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -86,7 +86,8 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
>   
>   static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
>   {
> -	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
> +	/* features == 0 means EFR is not supported */
> +	if (!iommu->features)
>   		return false;
>   
>   	return !!(iommu->features & f);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 553587827771..35331e458dd1 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -387,6 +387,10 @@
>   #define IOMMU_CAP_NPCACHE 26
>   #define IOMMU_CAP_EFR     27
>   
> +/* IOMMU IVINFO */
> +#define IOMMU_IVINFO_OFFSET          36
> +#define IOMMU_IVINFO_EFRSUP_SHIFT    0
> +
>   /* IOMMU Feature Reporting Field (for IVHD type 10h */
>   #define IOMMU_FEAT_GASUP_SHIFT	6
>   
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 6a1f7048dacc..28b1d2feec96 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -257,6 +257,8 @@ static void init_device_table_dma(void);
>   
>   static bool amd_iommu_pre_enabled = true;
>   
> +static u32 amd_iommu_ivinfo;
> +
>   bool translation_pre_enabled(struct amd_iommu *iommu)
>   {
>   	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
> @@ -1577,6 +1579,14 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>   
>   		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
>   			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
> +
> +		/*
> +		 * For IVHD type 0x11/0x40, EFR is also available via IVHD.
> +		 * Default to IVHD EFR since it is available sooner
> +		 * (i.e. before PCI init).
> +		 */
> +		if (amd_iommu_ivinfo & (1 << IOMMU_IVINFO_EFRSUP_SHIFT))
> +			iommu->features = h->efr_reg;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -1770,6 +1780,29 @@ static const struct attribute_group *amd_iommu_groups[] = {
>   	NULL,
>   };
>   
> +/*
> + * Note: IVHD 0x11 and 0x40 also contains exact copy
> + * of the IOMMU Extended Feature Register [MMIO Offset 0030h].
> + * Default to EFR in IVHD since it is available sooner (i.e. before PCI init).
> + * However, sanity check and warn if they conflict.
> + */
> +static void __init iommu_init_features(struct amd_iommu *iommu)
> +{
> +	u64 features;
> +
> +	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
> +		return;
> +
> +	/* read extended feature bits */
> +	features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
> +
> +	if (iommu->features && (features != iommu->features))
> +		pr_err(FW_BUG "EFR mismatch. Use IVHD EFR (%#llx : %#llx\n).",
> +		       features, iommu->features);
> +	else
> +		iommu->features = features;
> +}
> +
>   static int __init iommu_init_pci(struct amd_iommu *iommu)
>   {
>   	int cap_ptr = iommu->cap_ptr;
> @@ -1789,8 +1822,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>   	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
>   		amd_iommu_iotlb_sup = false;
>   
> -	/* read extended feature bits */
> -	iommu->features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
> +	iommu_init_features(iommu);
>   
>   	if (iommu_feature(iommu, FEATURE_GT)) {
>   		int glxval;
> @@ -2661,6 +2693,9 @@ static int __init early_amd_iommu_init(void)
>   	if (ret)
>   		goto out;
>   
> +	/* Store IVRS IVinfo field. */
> +	amd_iommu_ivinfo = *((u32 *)((u8 *)ivrs_base + IOMMU_IVINFO_OFFSET));
> +
>   	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
>   	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
