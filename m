Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F15C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 07:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B0784660;
	Wed, 22 Jun 2022 07:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71B0784660
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u4SfuY2z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mwdtvFMtzRN; Wed, 22 Jun 2022 07:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C54284684;
	Wed, 22 Jun 2022 07:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C54284684
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F37BCC0032;
	Wed, 22 Jun 2022 07:55:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9843CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6490F84684
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6490F84684
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glg8XyZWF93C for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 07:55:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60F3984660
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60F3984660
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffEjdK1wZ8c66DKOoFJxAVQ1dpYcr/Z1HmSi/EG46OrPewcgY2kWEPb1SYmUeeeBUR/IVo03An3vzt8/imBi3IU3UJcw/cBjBuPc72Tv6edNLUm0xbphkbVv2qz/Sy7F359D9tkOoP4sVWbfFPKQwrRfDuedBWLpSad9RF5Eg5BA9KAszzN7q2dBuJn9wEGv1NjrRP2VDBYOEtRXSys+mXjs9Sly9yFHUFOf9ijrTmrcGiCbaU1m4u2Pp9/9Z3DNwx/K/8wEzVa9+Ay/xiTFBThiD7T4pkHjGYKL9RuZdhlq6iu4AexW6gaTDAvoNpMdGRLbskRnVSikMm6VvqgmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b5Q5C7c5LGmLwWuPxvz72CjpEFUzstW7cis6ou9TMA=;
 b=NhBSaKRXi6P78hCYorCamrETaiE4Nc/dzXStix8W1zhQ87YyZyKT+pirFS3Sne5GJLhqX90//ODCiHDuAMJOJtl7sZL8II36F+11k5vHJTq6ClMiOGpYMaXTgWtaXxGDGWlmNFZ+1iZF5nwAu7JGRnya3hxfbwJd9b5fUWz9nM70dUQItP9kmntWmoN69DQ02Uci/ZnmLurdyHMtMl3VusP/BEBMdi0kwP+E4fCA4N5l91ZJarls/BuHzlgxKu/F+2R5M3EChiL8hz6MOVU80/6FW8zNe7zW5Tg4wy/tQAvzup1aQFIctiaDZ/KmV1UH2CU4uw+3qN5xtatTyca8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b5Q5C7c5LGmLwWuPxvz72CjpEFUzstW7cis6ou9TMA=;
 b=u4SfuY2zJA7yX5J+E+uO08f5vc3FhFuPCkhIL516inYmODVJK426vMupK37tLR/BuVW5UdaZkoj/TbSNDtreQ7Grahd3JZB24ky98pJ97A53GoajUa0i3RjnFze1Yq6v5FKUUO1/x0MaP8j+kcuisgKkSDhNW3Y1wL8QyPdjXAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Wed, 22 Jun 2022 07:55:38 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%9]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 07:55:38 +0000
Message-ID: <0e3441ac-f648-7a5b-0abe-1108c30320d8@amd.com>
Date: Wed, 22 Jun 2022 14:55:28 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/7] iommu/amd: Introduce function to check and enable
 SNP
Content-Language: en-US
To: iommu@lists.linux-foundation.org
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
 <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
In-Reply-To: <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14731e85-ad28-4228-741e-08da5424986a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5265:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB526551AC4516F1C8BE0AC94FF3B29@CH0PR12MB5265.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3XbqNH+rUnCkPwlsBqfNJpcfkNWb6fWt5rrdxpGTFRXLzRqdg7djBJrTNR7meu/kquSrf5dNKcqLyXHraN1w0dpBymwz5e7yVYOts72fvnrZ3+khJONSIctkgqqXY/+UkRke2K9R1qk8ZEtWdEqVjYJCKJSDR+8hYZzft9146M9HYUyRe16kSpL5z6YfX9GdpX7jSxBeZp80WWh2SnEIxY416dXJ3bfpxhfLLKfxFHREYkwTuBbbKNlwhTnjyftcbvulM4QOHCBP4bflH0F5aXJoQkGJbzi2x/cGboc6YBt/C8uhznDcs3ARA4EKTbqTHHH28CBm4Q4M+9t6TjUtFDDdDdNOdOHzTEIrB9OPyv8QXPp2PsMicQ0orQFkI4dtElmkbh5+/dcq4aNft+Qpo+5hsxxmaYqjSaZdL2lF/T+zxKCumTcQnvXt5sFvvuZoAnNGLe5OHy140k7dphvwtna4gNFZpfOG6w39hE3Y/qrJR3yXij2XFlgpCX7Kt8ElwJgK2YCZ3BrBsuhZEy9GYpcDsZ9U3bW+scrR8L5JFkE4WDVhoAzahe03RExaOot6mMl/nEiCM0MAcGbNf5eOXZZO3wY2ct8oJlzftrb2XNATJfTWscY5VjewNHU9AsD5A/18PednBC6VSTrWrg2MZwNK+GCZXYosb72S7wnXUYltOamF/uHo34YSBagOVrGM1fCSpBRpgNmuUXBS7/bE5PHme/symbWRqcJsEQZ+c0wSRkOnIGK6wfTae3inLnXwN/VYzFnA6fmlPTKqIqA8viG7X23e/fBqdlqr75KTf2Xg44c4SrngHBHd2pApdM8+AB1gIy868mhGqWQFH1wUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(66476007)(6486002)(54906003)(6916009)(8936002)(6506007)(8676002)(31696002)(66946007)(5660300002)(478600001)(316002)(966005)(86362001)(4326008)(66556008)(31686004)(41300700001)(83380400001)(186003)(2616005)(38100700002)(2906002)(36756003)(26005)(53546011)(6666004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRGSUJJaWRjZDQ4VSswRGd0YWt0OEl6cGVOektFQWt2U1VuSko1Q1VXSnlu?=
 =?utf-8?B?cit5M3RVUUl5M0ZjcmNyblJVVXpzajN6cXpGVUVMSEd6SjlxSlRiVkM5NFJk?=
 =?utf-8?B?dWY5eWt0QWoyaDBWRWcxblRVWnNHMWw3b2JyUzBBdW1FYkRDZmZ2bE55YnI0?=
 =?utf-8?B?a21QZ1J6Lzk0NXFqemMxUnF4ekFKd3R4RTZKY05LL0ZBSkZUam1JcHdNbi9T?=
 =?utf-8?B?b1FEeUtHMHYwOVRJb3BGU3owU2VGSXRDQ2tYQmpYd0hiZmc5NFZYbjlHRks4?=
 =?utf-8?B?QVpmK1dSWmxqeGJ1V3BQOW9saGZpUlpXL1ZQY1pFYk1LTUtNNmdZend0Z1NS?=
 =?utf-8?B?RmdCRE5wVmgrQ3FpU2hUcGNGQkVKdFEwWCtEb3BIS2FSRkx2MU1TQit6cU5E?=
 =?utf-8?B?VXdYdDNHWVk2aGJWT0NqRXlZcmZOTEJlYkxUMmxHbjRrb3dmeDgva2M1bzVl?=
 =?utf-8?B?T0FqeTlpeURwUGNMbG8zWTVZL210ZW84cGFPWGRmTCtJWXU0bmcwMlUwVnV1?=
 =?utf-8?B?V3k2Wko4RitpVGFvN01CYUxocUxLWWZvdUJZMWFIcnBpTEhiY0xWaUZFUFFw?=
 =?utf-8?B?YUhSSC9jKzlpa1NWRHZkVVZTRkdsZ3pUcy96SnNpZkwxTFo4SUlrNi81eSs1?=
 =?utf-8?B?cGQxUXNWenhIMkdwRGtuc0tGTU5LYWJnaUNoUmkxUUZ0dGtyYUcveU1VZXBn?=
 =?utf-8?B?d01USHYzKy9sSjl0UVJUVkVRNzBqQkxvV3BSb1JGM3NLRnJOYldpL2FRRGVr?=
 =?utf-8?B?cmNtcnpDWXREZ0hubHNmVmdTWDBwQ2NlYzlmZnNsaFRYRDd2S2ZLbVpKYldz?=
 =?utf-8?B?dHRVNkJNR1RkaEVvb2FPNVJXbVBsVXB0S0ZtdWk2YitjZDBDOG56ci80cGJ1?=
 =?utf-8?B?RFVFMWprRURWSHphSVA1cUkxTFAvanp2MmdzYjBZR1RNSjFKT2MzNzBmRmNz?=
 =?utf-8?B?dmlXU3JsRThlSmY0RlVJSmVGSzdxRWVtWjZKaDRFQjRZYlJiRENOSkNQTFhn?=
 =?utf-8?B?T3FBeDZtdnFiZittMjgvR2FaWWJEcytJNzJJWS96bWl6a25mN05LeXp2dDNo?=
 =?utf-8?B?QkxESVUwbVNxRzBvNy9wMS81TzdFcnVXaVVvOWtRTitPdm1qV3JyYTRhZ29M?=
 =?utf-8?B?ZHZHcXJZRGZpMDMxNWxtSmtMVGFvalI5MHplalptamVGYzZtZmEwaXpPWVEz?=
 =?utf-8?B?ZWQvU1M5TWJyc0d0bWZRVTBHTktyKzR6bGxadVFWWjh3WEh0SGx2aElYazdu?=
 =?utf-8?B?U0paREduak9lTVJUOWZreTdUSzgvRk5EWkprZFAwbUN6OEpIblE5WCswMmFa?=
 =?utf-8?B?STFnTWdtRWRINkdGZ2pZV3IyaERpLzdGWWViSUlNNXl5OForK0dOR01rMjh4?=
 =?utf-8?B?anlqUTh2NmxxcGtpOVRkRSt1NWZ6NXRibFhFeEowZ1l0NC9HNkVDamVzWmVk?=
 =?utf-8?B?djg0Y0NneEhxSFN4UGJEVHR2UDEyQk9PZFJ5QnBYQnBrbkhtUkIvUFkvc3J3?=
 =?utf-8?B?cUY0MDlUUkVkL3BxZFgySXhGWHd6Z1kvN0tlbkF1WktqcWVlY0p2emUveEVK?=
 =?utf-8?B?REEwYzREK2FFeE12VERybitVUDI3cHVWUllRZ1VOei9leDRNM0ZpbGh1YzNT?=
 =?utf-8?B?RThoYVAvNTRoOUUxUTRPZXBWVXc4eGJWQk9GNmNVcVRBVXpya0tuTzRPUzBi?=
 =?utf-8?B?bVdta1JMQzNSTW1FQW14QnBrZzRaWjRPaUJjS1hMeDRxTGdzTFIwQ2lubWVp?=
 =?utf-8?B?V0RPdUgxcks3dDFDd29WSWVmZU1Jb1M4d1JRY0d0VXJhOTlGZ1E1dXI5cnlN?=
 =?utf-8?B?eGNhTnlFamRTYjVOQkdBazVTRDFjMlNXM3RRQ1liamNoL3BqUVN5RnNUOFNm?=
 =?utf-8?B?UUVCcmZQaUtVK0VHdkpwVnliTDVnOWpIbjQ3UmdQQ1hxN0dOMThndU9nZUhp?=
 =?utf-8?B?ZGNmaWdGUENMN1p4SnVmYkl2aUhqVnRkKzRJM1YzUk5Pc21VQTcxSnFPVkpa?=
 =?utf-8?B?WkFWellmYXJqTElZb3J1dEtwcUVRNEt3RHhKOVlFd1lrQW9zby9EYUhCTkhF?=
 =?utf-8?B?cVRjbExxbWFvc0t6K1hvVUdxeUJ0Mzk0UkZ3WmZ2TWNUdE9JQzJrUGdOOGcr?=
 =?utf-8?B?N3d1eG5zRTYvNDNqWFFLekVuRFNIZEZ0NDg2L2Q4eXVLNW5vcU5IcExJWTk3?=
 =?utf-8?B?QUhYMWhOWkFZQjJkK2VQRU1SVEVyQWRncUVPVHFrTFBIM2hSV29FeENpZHlV?=
 =?utf-8?B?OVJGQUNEakd2VVhsT244R28vYXlqQkp6SDVjdVplVU9IUGJYQmJCM3djQ3l6?=
 =?utf-8?B?NE9yYXpCQ3RtV3RyNkxHUFRaS0luYk03YzZMS291RjlsbndRRkN0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14731e85-ad28-4228-741e-08da5424986a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 07:55:38.1528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Uy1N3IH1ZP5h/K05ydJx+6slA4lyp3dyDfdwfXy1fBYJ6nfV56ZuCpt3vGKUeCZEilUcOvRh/N+OMN9RDNXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com,
 Brijesh Singh <brijesh.singh@amd.com>, vasant.hegde@amd.com,
 Peter Gonda <pgonda@google.com>, robin.murphy@arm.com
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
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Recap discussion on the other thread.

https://lore.kernel.org/linux-mm/CAMkAt6qorwbAXaPaCaSm0SC9o2uQ9ZQzB6s1kBkvAv2D4tkUug@mail.gmail.com/#t

On 6/16/2022 8:55 AM, Suravee Suthikulpanit wrote:
> +int amd_iommu_snp_enable(void)
> +{
> +	/*
> +	 * The SNP support requires that IOMMU must be enabled, and is
> +	 * not configured in the passthrough mode.
> +	 */
> +	if (no_iommu || iommu_default_passthrough()) {
> +		pr_err("SNP: IOMMU is either disabled or configured in passthrough mode.\n");
> +		return -EINVAL;
> +	}

Peter has suggested rewording to something more descriptive such as:

"SNP: IOMMU is either disabled or configured in passthrough mode, SNP cannot be supported".

Thank you,
Suravee

> +	/*
> +	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
> +	 * affect how IOMMU driver sets up data structures and configures
> +	 * IOMMU hardware.
> +	 */
> +	if (init_state > IOMMU_ENABLED) {
> +		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
> +		return -EINVAL;
> +	}
> +
> +	amd_iommu_snp_en = amd_iommu_snp_sup;
> +	if (!amd_iommu_snp_en)
> +		return -EINVAL;
> +
> +	pr_info("SNP enabled\n");
> +
> +	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
> +	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> +		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
> +		amd_iommu_pgtable = AMD_IOMMU_V1;
> +		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_iommu_snp_enable);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
