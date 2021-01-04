Return-Path: <SRS0=ghm9=GH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25FDC433E0
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 11:01:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F9C207BC
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 11:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F9C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04BE1868D0;
	Mon,  4 Jan 2021 11:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKC6rZWDZf3p; Mon,  4 Jan 2021 11:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9D99868C5;
	Mon,  4 Jan 2021 11:01:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFB4C0893;
	Mon,  4 Jan 2021 11:01:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C27BC013A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 11:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3DF8D85FD5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 11:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8R9-am63OCQ for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 11:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 71BBD85FC1
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 11:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhhvQKmgmriF9GYzwyy3DYN+KgqzNPc6pXUcp9fZzbPITrKca6CATFCALWEi4gQjeBACyK81QliPTaA6AUqYoldWRuyhqDSIoDcnHB+xTcp0kkgGfsu53wJotTKFarR6asfy7/jhNBBo5cyJTbMzoBRgahLE4U3XKfbMzT8MQ38IqDlBjhJ02vJst+6zpH8q2NmpXoOZNZVzKC1WOFoINw3ntF0tSSaYo0BURbUIVeTLqM70wV7Ii5dELs9lw8rx2MFZ8FV54GU6UUKfeyMGp/GrRjxmdx+hsTzy2ydmfT3Zz3r4bOw5prSHwUUulM/OlrCAUbF6P12mvkjaeG8hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EArthR1BWG00XvHRsc262Ew9ftyEzQNgrrNgsdMO9nU=;
 b=aME9LQEVwA+3OAbn0SxKkPYRvKZ+N/JjufLB/lBnD5snt0gMgh3KP3O2piPCNJEB4Rlg0J5Bot1prrdLyll+otsQylgpb0kdCSeB1mcTuVNYX4LtOpPm2iElhcO3ESAWAB5BjaGdCknWvHIkiF2foC6LNM9pY0INX9mdr7ymw4gr+yvq4Of6L8n7Q3Eq0tjcfRi04aK6SA7aL1/+Q0peHWUvDNugM05Z0YKdwGMcqtRLirfFhk4BGnepE5AwFOiLbYLfEfOdGxEWrwok89W6zj0tkCva0jpvE20HQqN2fIJkR8XpOD4d2P6zdfASaH6uU6LYm3rpCWKa9/VdEH4OYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EArthR1BWG00XvHRsc262Ew9ftyEzQNgrrNgsdMO9nU=;
 b=HBPAF5fKKT8XLiv2+ffsa1f87WFdcIM7ivbIQKf10xRVd7w0LPNnf6apWPvS28oujr+XAsBvgkRS0FKULFegAoLp6AIg0Jf8mzY1u8rjvgOUQ8rGVfrlPI0Yu+fpnDQV07xUMqdDIojNsbNDoKDTIjoFi0oZXqAQgRhCIxEz6ng=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Mon, 4 Jan
 2021 11:01:48 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 11:01:48 +0000
Subject: Re: [PATCH v4 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f9674d19-74bf-1209-5d9d-1517d3ad27f7@amd.com>
Date: Mon, 4 Jan 2021 18:01:37 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-Originating-IP: [2001:fb1:e3:c9d4:89cc:2e93:10a4:9f87]
X-ClientProxiedBy: KU1PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:802:18::19) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local
 (2001:fb1:e3:c9d4:89cc:2e93:10a4:9f87) by
 KU1PR03CA0007.apcprd03.prod.outlook.com (2603:1096:802:18::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.4 via Frontend Transport; Mon, 4 Jan 2021 11:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 339399e8-1295-4eef-62e9-08d8b0a021f1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3605:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3605948BA7539381B6AF1FEAF3D20@BYAPR12MB3605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMBSc0Sj8Uny3ZqC0cSZxpabzkBLQ9fQ44zqC6lbnW84BTMTIeSKrNp9hHVhGVhFlBNGuGXLcNRQBNWxa+0pH8PPCAa/M84kHctaJoHOHEWpsx9T0Oq1UKE8HsWyEC5DZZSQNhndhG7MDG8deSkrC5seh4Bez0JL8ZVqA8xGDa2RdFfFKFJC6wiHtajFvUHbk3smhlpVhhoS/XL0g0v4QLHa4NQNimeY0PCXXdU00plrLyVTp2RRwvw+gw+WSgnZKnia9lDmOSTs8TUAWiD2SeDrrnSPirxnQOuY/6MeqCFZtqubduf9pCDewIWmYhqDFq4jy5YmXUM2iLSqwghwpR80GHwJ4O1toROdQdMnX/2emOWB+eNALk6fa8ILlIC4TG8aICjDXFG/TisNpVyGxz9qlXuPpRIl7U8rMvZLSC4W/4gujURIYvaahslGN4JDIiV6bOLfpgoNpkyEyyE/tLgGmH7Lc0bdyE2xsCfgJJLkRWa22c4BQd7XfHu0xCZaLenj8c0Yxz63kq4Mcj8ivQ2CFS0oly2g/oNifWkTuFVGcFu8alXznQCsGYlXOW/s68hVeF5eEJ97LEpu+07QBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6486002)(6512007)(31696002)(31686004)(316002)(66946007)(4326008)(86362001)(52116002)(66476007)(66556008)(5660300002)(53546011)(6506007)(44832011)(2616005)(83380400001)(478600001)(36756003)(8936002)(6666004)(186003)(16526019)(8676002)(2906002)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXJaM1RSVUl4TkxYRmFEczFrYXpkMVBLWnZVcUw5aDRPKzhickJOeFJreXlY?=
 =?utf-8?B?bzVGV1BqVXl3TkQrajVEeTJkWjVLRnpQY1V2WlNGbjFqN0UreGtQd2paSllU?=
 =?utf-8?B?ZVU2ckdZa3RybktIRWswNlY3SXROQnRvZHlCODJwQ3RjNzNxanRKT1cwWXNX?=
 =?utf-8?B?aVVNaEFHUURZRkJzUnFsaklCN0xjTmsyK2VqWVdqK0pUc2JGRGsrTXBmdlRG?=
 =?utf-8?B?a2dqVmdFV0tSdE54b3o4aEFmUjRYRDdLaHNIUDFVb1RoQWJCRXVpTFExcmFi?=
 =?utf-8?B?Z01EdzRQQWxnUXcvMWNkTVU1elR0R3JoMjkxNnpBSWlBRm9yV2cva2ZtSzF3?=
 =?utf-8?B?N09KekJwcFZmVGZrcDRVaVRMa3hEVlNCT1lVY2lYeVZKL1BlYWs0QVpWVEtL?=
 =?utf-8?B?cHhHemgrYXc5L1h3Qk1ockIyTzZlYmtGU3hrVitHTGZaSGdOSWlIcVRFRFlW?=
 =?utf-8?B?bm1lMjB0VDdxS0FCWm9tNDlSWTg1L2NkQ0IxMXdHazJxT1JFMzVWTXY3aGJY?=
 =?utf-8?B?RVBiS2t3RzdOYk1IVTJWZXVFclU2anJOU1lxN2VtNGFnajI1SHZ0ZVRUTGRv?=
 =?utf-8?B?SjI0ZkZGcWQvbU5IaE83UFB6Znp1aDF2OWpOM1R4eG5waHNSOStJcCtvazhn?=
 =?utf-8?B?amw4VUhDNkNQdTVpWEgxeXI5MUs1OXJoYWVZSTl1ZVp6a2ZRZ0dTSFp0U3Ez?=
 =?utf-8?B?Mjc0WXNLUHhmbjUrTnJYTkxDclV5eHlya1VSVHFoYVFpWU0xeEYzaU1pUkFl?=
 =?utf-8?B?YkJjdUhOd1pRaVZSTzV6ZGNJekJXR2pVQjFQKzFUZW9VbCttM2VQcTZGbFFU?=
 =?utf-8?B?RFVkNSt0KzdKa294MVRyOHhvTTdZcmZDRjV0cGRJZFp5VUhRYU44UmdPR3hw?=
 =?utf-8?B?TG94Uy9YeThVWm1BWnN1cG5EZjF2K3A4dHVKSDdJNVNyVnVkbkFkREhxYmZ3?=
 =?utf-8?B?NGpvL0hPTnFvdXJaSEVGSHRwN1hnam1aVVZkbE12SjV4NGhFVHRIRW1yWDkr?=
 =?utf-8?B?V240cFlaNURSTWM4Y2pxc3NhVi9jdlI4TmdodUd2UWpQUmVpMUVYNDlxN0RK?=
 =?utf-8?B?QWxuanN5eE5CbmR1alpiMStGZEV3SWc2UFNXWjRyZjJwWCtFRkJHcUMrL1Zk?=
 =?utf-8?B?dXQxNC9xb2N5bWF3UGw4M1o5SWpBZlNQMkVla3FSZ2hBREJrbDVnS0d3eVA3?=
 =?utf-8?B?dWtFdXAvVzF6RWlDYzY2emg2NFpJSVRSSkUrVDdmditaUWtROFg3S0JpMHRX?=
 =?utf-8?B?bDZ0ejduc1JzWXJrWjJxTjJCV2NEeldCd0YvWWFDcHFBVFNuUGdBY0hzQWl5?=
 =?utf-8?B?MWhIbVBjOHRpVUlMUi8wYUtiRXlNeTNUV213NkVqVC9icHcveEN1b0ZRV3Ev?=
 =?utf-8?B?eVFTZzI4MGJ5VlRXdFVzcCszdE1zUjZXYk54ME9IN3VzTWkvNWZEWkl4WlBl?=
 =?utf-8?Q?zwDEfDiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 11:01:48.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 339399e8-1295-4eef-62e9-08d8b0a021f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubPFVEdLUOZy51kh72bguWdR5REfewWFeTyJWYGye9sCBId9QtMr+qzhKnGtCoCcUFkIIa4fY36pAOOhfgfTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
Cc: will@kernel.org
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

Hi Joerg / Will,

Happy New Year!! Just want to follow up on this series.

Thanks,
Suravee

On 12/15/20 2:36 PM, Suravee Suthikulpanit wrote:
> The framework allows callable implementation of IO page table.
> This allows AMD IOMMU driver to switch between different types
> of AMD IOMMU page tables (e.g. v1 vs. v2).
> 
> This series refactors the current implementation of AMD IOMMU v1 page table
> to adopt the framework. There should be no functional change.
> Subsequent series will introduce support for the AMD IOMMU v2 page table.
> 
> Thanks,
> Suravee
> 
> Change from V3 (https://lore.kernel.org/linux-iommu/20201004014549.16065-1-suravee.suthikulpanit@amd.com/)
>    - Rebase to v5.10
>    - Patch  2: Add struct iommu_flush_ops (previously in patch 13 of v3)
>    - Patch  7: Consolidate logic into v1_free_pgtable() instead of amd_iommu_free_pgtable()
>    - Patch 12: Check ops->[map|unmap] before calling.
>    - Patch 13: Setup page table when allocating domain (instead of when attaching device).
> 
> Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
>    - Patch  2: Introduce helper function io_pgtable_cfg_to_data.
>    - Patch 13: Put back the struct iommu_flush_ops since patch v2 would run into
>      NULL pointer bug when calling free_io_pgtable_ops if not defined.
> 
> Change from V1 (https://lkml.org/lkml/2020/9/23/251)
>    - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
>      not currently used. (per Robin)
>    - Remove unused struct iommu_flush_ops.  (patch 2/13)
>    - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
>      patch 13/13)
> 
> Suravee Suthikulpanit (13):
>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>    iommu/amd: Prepare for generic IO page table framework
>    iommu/amd: Move pt_root to struct amd_io_pgtable
>    iommu/amd: Convert to using amd_io_pgtable
>    iommu/amd: Declare functions as extern
>    iommu/amd: Move IO page table related functions
>    iommu/amd: Restructure code for freeing page table
>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>    iommu/amd: Rename variables to be consistent with struct
>      io_pgtable_ops
>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>    iommu/amd: Introduce iommu_v1_iova_to_phys
>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>    iommu/amd: Adopt IO page table framework for AMD IOMMU v1 page table
> 
>   drivers/iommu/amd/Kconfig           |   1 +
>   drivers/iommu/amd/Makefile          |   2 +-
>   drivers/iommu/amd/amd_iommu.h       |  22 +
>   drivers/iommu/amd/amd_iommu_types.h |  43 +-
>   drivers/iommu/amd/init.c            |   2 +
>   drivers/iommu/amd/io_pgtable.c      | 564 +++++++++++++++++++++++
>   drivers/iommu/amd/iommu.c           | 672 ++++------------------------
>   drivers/iommu/io-pgtable.c          |   3 +
>   include/linux/io-pgtable.h          |   2 +
>   9 files changed, 707 insertions(+), 604 deletions(-)
>   create mode 100644 drivers/iommu/amd/io_pgtable.c
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
