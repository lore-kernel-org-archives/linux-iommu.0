Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE49C433ED
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 13:46:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9322861445
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9322861445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 364096069E;
	Thu, 29 Apr 2021 13:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jvyURqul8YE; Thu, 29 Apr 2021 13:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04C6D6066B;
	Thu, 29 Apr 2021 13:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B67F3C000E;
	Thu, 29 Apr 2021 13:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A67C5C0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 13:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ED5E4199A
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 13:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzqc-jXnFOJm for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 13:45:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D06B4194C
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 13:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/+/oF0vy1kTgIM6qsGAhuFB0RjnbD9FwAs/WRuYUNZWtnEX6lJO1ApdtgsnkLRq35R2flfJRf6MenU/PME+hrkr5Df6dOS7ZvNe5JLuBQNgQ969GmetbyG0xQuRNWNuHtZ8o4+JkX3CM9u/ljYBgK7o/ceNbbS2u9RcnUT8Yzh/7SFhJjNaEX3DAuZu0SHJl/P2ZX3fo+hPL52zCTgPMF3N12ifkC6JYkUGkxvy6jayPeKDkA/d548aOW/3T1rYaWiGG6LZXH///BAURakqr+kbW3L16LU8cTJdDz2jEL/8PJHqxgOvVcD+QishrwNAMSc+syspk/08y1JWgt33Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGnNKptI0E+kqUA1yksItMifO3c5ln1MN4K94+TTOOU=;
 b=WsFF5S81V9nllY/W0RZ5TloJSlcuDab3iEc9nxbtT8NdT82vrT7oTWeM9/2T3qb4DKQ1zpH7Qf+knJrKuVyLmnrt9vgLXHxlybVs3q1K5IULZW7rXc1athg7XXBTSPEW9SnhP2VgnIRZAZVIZddW0DKHDufVQWdx5qQdyMv4j2RfwndgMrianiaTF1GrZ0n8c/ZF9vozO89M96bGUb+X6zzlByTIytHeqOFMx4LEMe9Imr0hkn30dY0AwdNiVihUxbs44PjtaO2i8rDzO5AsRPafuracItRbGI43LhKJedJOKv+uZdDTkNHa4VoLxmaRzBr+rKslaJ/NP5r68Q1wXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGnNKptI0E+kqUA1yksItMifO3c5ln1MN4K94+TTOOU=;
 b=ShTj6RHzf8Gi/UANpgms743pf9AbJL3DLkRMwq5Po3zoG2vouJ4rTFmO5s6IXxHRo40TSz+qzEPo6fUiIx3jc0tiB1qpPCFhoztQ8wOMLpZ5B5aCcuD44mdQnDxHXEn1V9VublYNwxYMBvN2qPyNBsPkAMIhGL2ootU/0PTLGGA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Thu, 29 Apr 2021 13:45:53 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4065.026; Thu, 29 Apr
 2021 13:45:53 +0000
Subject: Re: [PATCH] swiotlb: don't override user specified size in
 swiotlb_adjust_size
To: Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com
References: <20210429062859.2478387-1-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1f4453ae-9335-7423-e6a3-948d5c23a33d@amd.com>
Date: Thu, 29 Apr 2021 08:45:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429062859.2478387-1-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:806:22::32) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SA9PR13CA0057.namprd13.prod.outlook.com (2603:10b6:806:22::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.8 via Frontend Transport; Thu, 29 Apr 2021 13:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c2d1b1-108c-4cee-e5f5-08d90b151b8d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2504E6D557F0D30EFCFDDC13EC5F9@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dYQ0aBn1DXgwZ55y0ed95xXLkNER1NpsKV+uGy29V2wwA6LvFPexp6ZorxkgW84pjk6i63zFmPdIv6yowyGT1iWpkrsdW45ML/Zlfs/bqv2evbw6ta4EjcreCACFaXd23/eOO7JzoEmXkH9FCa5s/U+C+V7N1Y/HYXlPO7lN6jKSgREWfXSMzRTmdx1Z7I81Zm4Wk+ddmwNkULufpswZnaILcETwacg9VfZe3Lwyxft6rUZMJ0b4aBuRvk2cn56UtnrEUk/RfuM0Qz4iieTbptiCVckeAjqViAYJ/DFeboDnpEivG1TSNEGeXoo4dJPnaV0jdHeb+R1DeW1Jl/g4NEQIuN1nBbmgpcFfdgwMI4/bzkGBcEkeOrCt4ZiB8JdIS6eT0/iWL6fgThZj27JXzeH9qvFNzmwpbelJUCMCr8bapgB+d5IPO9UVEsxRhaNp150wRMtsEOQJl9s+wKTaFTJId3X0aoSZWuebpyWVzvErU0ImaBGanP53S1dzBo0LB6PJj2DZFahY7V2b0ruodp0aCEl6lH/e3WpzKjCOPAnYXpw7MDt9nkLKTY3og3FqLW5tXP5SlA+7dvdMTUQ0N86xcxdE6m+T78DUOEeOMpv9v+OjQv5sooGvrUmI+CNb4LJrE5WaeALknqQyVoOvQcvZwaA3Ko3TuiWy5sOW5IuuNaeqh6BqwDaQiCir6mL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(6486002)(38100700002)(86362001)(31686004)(478600001)(316002)(66946007)(2906002)(36756003)(66556008)(66476007)(16526019)(6506007)(186003)(8936002)(4326008)(5660300002)(31696002)(53546011)(6512007)(26005)(956004)(2616005)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NG43MDE3RkFOdUpWOWdMLzNGd2s1ZE9iU3lkcWMzWjFXK2xGejNjanhvTG9F?=
 =?utf-8?B?TlZSWEtoQVhXMDQ0UC81MkRwYWk5VFNLKy9kd3dDektWN21kNTExR1hsUFVN?=
 =?utf-8?B?SnZEbDlxVHYyOG9TVElmcHVITTFRa3lqRURKMWN6T25rV3NDQ0IvL3A0dVhO?=
 =?utf-8?B?OXVtUXF5Y3g0WGswVFJFNVA2cWhtdWZ6emdZWE43bnR5ZGwvY2E0NVhKSVB0?=
 =?utf-8?B?Um9DUU5yWXowaW9pY2hZcEg2QUdTSVIzRDdVdUhnY3NRYmhGTGtnVnh3cklZ?=
 =?utf-8?B?bTFUVGFzQjdpaVAwSnB3SDRGY1JaUXZyRG9kWjdQR09zejJXd2VmV2VYcFEv?=
 =?utf-8?B?dnUxb0tudExWRDBZU1l0QVNUOGxyU1JRUEZvWHdhd2laZkE3R1lvVDNFUHhh?=
 =?utf-8?B?MTRyZStQdkt4UERUZU94UnNkSFVXYVJBZ0w1RjhGZGNxbEU2L2JWaGFmQTRt?=
 =?utf-8?B?REZaTHROeFZ4UEpQMWlPWFlocGoyZlUrTHZPMEVOYVphRWtrd1dLajVuaEpK?=
 =?utf-8?B?RGZSem9OQnc3dlBXYTJWdjF6KzEyc2pnSmNreVZVMlpJODJEZ1JiRUVRbFhz?=
 =?utf-8?B?cGVyYVpDT3M5NkhsZkM1bzRhc0R5bTZKWmsva1ZVN0lzN1Z3MnF5UEhHYVBN?=
 =?utf-8?B?OGtBRkpMRUhqbERuTElUejRsdDJoOUxnc2FNRUxGZUhlQjdQZFR0dWxSRXZ3?=
 =?utf-8?B?S2FHLzBZM0dkZ1dCZlV5emZ5ZkdJalNKVGthSlFacEVzT1FvMHd1VGhxelQx?=
 =?utf-8?B?M3lBa3VBWnc3bytRbW1ZTTliczZPWXBlZVR0WVBJZ0pseUVNeVBqTm10MnlI?=
 =?utf-8?B?TDRFZzNib0FlOWlpZHk3aDdVSzc0YWxHeTRKcDc2TjYvM0orUFMyOVRiUDg5?=
 =?utf-8?B?SmtGQkJZSGJ5TmtZUmVYb0xlQ3ptWUxYMU9JaDVvdmNvNXRYSmdOZnJHNXRs?=
 =?utf-8?B?QVJVbVZ1WVMwMytyU0Q4a1FsNWJkUVROQlEwNlhWSTJ6eFBoaTJOMU9tRERP?=
 =?utf-8?B?dytOYWpyZVhuMUorQ0tRY3RWS2VOb1I2OHVLUENkbzRycEFvMDA3TkNDT3M1?=
 =?utf-8?B?SXljbXlON2Nqb2E1SnFwbEFudGhCUjdaVUNoVEVwVVAzeG5xUVlRMjZOb0pX?=
 =?utf-8?B?RTJNNm9YS0p3VVc5dkEzdzUrMWZrNld4SFFieGtqelZlOWE3a0I1N3lwUnRP?=
 =?utf-8?B?cng3VW4xa3JybXZObXNiS2JjbHRlcmpjR00wRlhrUU5USWluK1RCa2kxMHNC?=
 =?utf-8?B?eDZEc29lTUlvZFFVSnNRNDkyNEhhbmplMGZOdnFTU3pHdmdBQUZZUU9yenox?=
 =?utf-8?B?VzZycndTeEhiTFJ0R2I2VmVoZnNNWWpVUFJSTG5FREowOStwWXg1MWFaa29Q?=
 =?utf-8?B?b0RKRG5KUHNXNGxaNjVjTVl3dENqVXg1S3Znc2NndE1UOFpBQUN4V0kyNFAx?=
 =?utf-8?B?bHZqSDArckREbWFXOEh2NjRXYTFvWnRsZ2MwQkdzdEY5UTJiTGlhNXg4bjJ6?=
 =?utf-8?B?TzF3bElncHRXT2tXZnlaaEdacHRYWUw0MXJETXVUZUxSaXpGcW42d3pPWk1R?=
 =?utf-8?B?RFVoaGFOa2U3SlpZZGFQdGVWcDNibzlzeXhyQUhyQy93RXVjaEFlMUFLQS94?=
 =?utf-8?B?SHB2aGZleCttcWMrWXVmSkFwRC8ycVRCTXlvSEgzc3h6Vi81VmZlNzlwOXEx?=
 =?utf-8?B?U3ZpTEtaU1lVY0ZVYndPcWZUVG5mNDErWld3Z1BMREEzNFhjWk0vMkNQSzJo?=
 =?utf-8?Q?Jw+TgQKw46ljYE8rekc+Syu4wK1BG9gZTo3972S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c2d1b1-108c-4cee-e5f5-08d90b151b8d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 13:45:53.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sipo6I7gXcwNC8RJuobwoyydyH5EOW13YDpg8yzSXN8C7b3CqeQfnQXRiz8ENfvotMOV5dbt11BICR1gPjWRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Cc: iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/29/21 1:28 AM, Christoph Hellwig wrote:
> If the user already specified a swiotlb size on the command line,
> swiotlb_adjust_size shoul not overwrite it.
> 
> Fixes: 2cbc2776efe4 ("swiotlb: remove swiotlb_nr_tbl")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks, Christoph!

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 8635a57f88e9..8ca7d505d61c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -118,6 +118,8 @@ void __init swiotlb_adjust_size(unsigned long size)
>  	 * architectures such as those supporting memory encryption to
>  	 * adjust/expand SWIOTLB size for their use.
>  	 */
> +	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
> +		return;
>  	size = ALIGN(size, IO_TLB_SIZE);
>  	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
>  	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
