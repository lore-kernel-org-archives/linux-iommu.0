Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A034C433EF
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 15:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE18860BAD;
	Mon, 10 Jan 2022 15:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlGzg26rnE9I; Mon, 10 Jan 2022 15:58:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B2C1C607C0;
	Mon, 10 Jan 2022 15:58:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A993C002F;
	Mon, 10 Jan 2022 15:58:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD8BFC001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A531D825CA
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDzO4vbRTfAb for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:58:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 045BF8254A
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0ZQi88D2wPlYWuQVGwFmNoaXy/yNruxf3tk4+AMmBgGOw7W/7YsBLg4RCQJOoLz49ZUC2ggi+trO1nimss4+riXmIfb+Jd8QpHDUSlBIUScNREcozPyEOxxQGP70c5e6vuvBH+e3+3OI8Ek5TjugkvGpu2+AVqlzKjOJh8n98BwxdrS9Dl3q6Ym9FPoEittvXEJoAeQDWOYDFaR/z1EgxTSjXkYNw1EP3+UyVobkNfKZz5qRU9X0kOsy3sZM4DJMHrxmqEMJ1gQhyk3z94rmF3QbhzG75s9w5/MwPAf2TSIM4PZnoA+FP7JjDwBtOrjpdTTTNePJoLIOG5VsQ/pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9Jr9lNkAJFKeTL8CLs8FVSxwSmFxeEN7okd6k3BvZI=;
 b=R+jAhBy2ZAsPYpGGOdeo6SH/l9UPKukrcjI02Wn9QngWiANR9unl/paTAcyd823zJURm8rpWz0d1gnzTN0MNkEBIbGO1QpI2XD5xlpTbhjVfYjLiQzmXceUQyp/Ur7KlCy5+yfffWKIZry/Y9yC4FX1ph1CDbSLw+9LM3vUjZoVkzZd4IKF6X+HfmQIFmldaxAOaYJBBelitIBIBCLZ6mprmm+Zg5fjvY6ZwUCpGuBqbu3HqftxLrOnqEnscVKFnDRrctcit2m57gTGOKF0IHJfd1VYwgDVucjcdyMJthU4WgYDcLaUUHmRBP7+xQfymJlTnpOf3PPX1AVr/Fuh+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9Jr9lNkAJFKeTL8CLs8FVSxwSmFxeEN7okd6k3BvZI=;
 b=pMuk7LEo0ijpTBGo4R2aTGEkxsdG3cF6v6CviREC6hgsXREeM3RwdteGrHNCyj3TDXSjpxolk+2wZF9I2igKy8vYTrfry1sCgPvtWD/zdES1qEDw/TBfQQzn5E3KQEX5iLwSvdvcLOXLRM11JSqq+JRzkhNN6R+deu2NcoORFuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 15:58:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 15:58:39 +0000
Subject: Re: Memory clearing in swiotlb_update_mem_attributes()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
 <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
Message-ID: <6ed94f6c-f359-eb4b-80e8-9063228c59fd@amd.com>
Date: Mon, 10 Jan 2022 09:58:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
Content-Language: en-US
X-ClientProxiedBy: CH2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:610:57::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627538bf-cdab-4288-39af-08d9d452116f
X-MS-TrafficTypeDiagnostic: DM6PR12MB5517:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55177F809291A2309637EC4CEC509@DM6PR12MB5517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpdaqanuCX18Wt6noMKOdoCrn5Lwsd/y4UqT5oiqPXW/rCM+9kayiL+eYlQe4z+2wf7ejdOc5rvD0H0VclMDhhUVQzqCSzgEmL2GguSBuqyTh0040YNoPXgmjhKeRSDM73S77pL7/sALI3dGbud+s42fWHlYhsiz8qF5u5A58l8WXFwXVlY87V454YDlsVFlyybW3nnsXvKJRgTJAk8ImxCZe0TUPvcZlY7ct2IOPRH8B0vIVTi8Fl1j6LZz1KIrkpSB9E1oFU3y1box8H0Gs5qfZpg2dxtWksm+OOIGxHLtO0xY9noyWRLxfsy8NkCNIkhsVbrsJz+HQUmDQ6V81d/D9IKsh14OQLqOO80oVHGDz3hcWf0y2peKX3rORIVMNtYXsHKYk9YgO9HOxvvIv5ig6MeV6+lKx1Ki9Ix+P3oeuUux1qqpD6hTWc4jD27KY6/SjXd0V4rsosHA3UBht8QvcAwWHUwgYbVFUNldnDt9nhiKgqWEZWJZHrPXLzQTRbtHQif5l7ZzsAnRY909hPwgfWBkuOIb01PJBXYwxk3gGyqEl8Q4fF7qm8FPm66nmd40R+JRQqSjzVWxW5zrNrSjrtDjLniGmqfwr5tcf30+Y7POSP7QMmWGaiRKDEwtY0m8VgzmTmVYUFfqkmDtAL5lFFc2h9/vvpfaI8ggpWAL5kr2qv6LBRz/W7rWwM5fexltZxKkE7BX4KQEmnQzk4HlEu6T6sO2WvcO3ibvNio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(8936002)(31696002)(53546011)(5660300002)(83380400001)(66476007)(66556008)(6486002)(4744005)(4326008)(86362001)(6506007)(26005)(8676002)(316002)(36756003)(186003)(38100700002)(508600001)(31686004)(54906003)(2906002)(66946007)(6512007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRGNFN1MENKVlFoWTVjZTRSTEZhVk9lUFFhNXMwREFnZ3NTendPcXRwdG81?=
 =?utf-8?B?eDJCVi9pZjNleGFnQldyM09FRnJpc3dyZllEZ3BJbTV2RlIyRHhTckRZRE91?=
 =?utf-8?B?cDhyaW1pVDRwbjNIaFJEb1RQWHlidnJEUk9yN3RNN1l6am80K1c2UVJrR0hU?=
 =?utf-8?B?THBZQVFENFpUZGFaZ2tJSFRsZUhGWlpyQy9qRVNaSXp5aXdaVDhjS3BPRmRJ?=
 =?utf-8?B?L0JSVVpxV3gxN2VkQTFhKy9jQzQ5NHJtVlErVlBZbUpxUnZ1SzM1QzlNZitu?=
 =?utf-8?B?aVVDdElZbU55T3NyYS9KejMySExPdlpZeW5zVTk5a2pnVnVsYkNkTnBFdTVn?=
 =?utf-8?B?TmJPZ2xZTzcrS2N6SEpKNVAvdFJCcXRveGRkRWZ4aVJZT2JwWjB2S3RJbnFC?=
 =?utf-8?B?TFhuckNCQ0x5RTRQMkxqa2NvMENmQURVdmRFa3lrdDgwNHVhWVdwUEd2RDhq?=
 =?utf-8?B?MzRQM3E5ZXNodW4yT3lpMWpMYWJ4YnhWY0oxN3NoQVBKS3lmRC9hS2JSNmZX?=
 =?utf-8?B?QVBBVUNGY0gwZWQ2b3IrV1ZXOW00N0V0aTllOU9qWWdLUUxvRUZQZ0hQZmhk?=
 =?utf-8?B?UjJLeGVKaEkrTWdYaDRVZlZ1TmVwU0Z4cnUrNXlrTzd2Y0dHd3B3Z3MyOVJI?=
 =?utf-8?B?czVlOEh4eitrNXZmejQ3cFkycWl1cy9QZ2ZUSUFOcmk4RDBKNEhVSkFVUFc2?=
 =?utf-8?B?bFNvM1VoanNERDlDdStZMTV2N00xY0gyRU91a2s1VnpncHAzSDZvRTUzTzBQ?=
 =?utf-8?B?dXU4MWV2OVFPR2x2KzVtMWg0VDQ0NEFpYnRjbXJ3dFBDWXpNaTZBQ0VYYkZR?=
 =?utf-8?B?aWtOR1ZBNW1SL0plN1FNakxTWnRlNjRvY0NrRVFvNXFxeEVXQ0VMM2NxOEpn?=
 =?utf-8?B?Y05kaDdMcFJKZ0JmNzlDSmt2SjJGemFSamNnL3U0V1NKMXlHSHVvTnVYcWYv?=
 =?utf-8?B?dS9icUhnZ1FiNjIwWWhhVCtERFFBdklpQnpQQUVaVU92cG5WQWhzSWFYWTkr?=
 =?utf-8?B?WUlPRWZvSDEyczBxbjNRVWxsT3A1YmE4WWtiWlRSdldWNlg3a1JGQTJvbkgr?=
 =?utf-8?B?ZlJGbVZSSjhkQjlRNnp1M21CM0JSN0l6K1Z5azFIRlJ1VTRsZTFoeVlYMllk?=
 =?utf-8?B?Q3VLQlEvVjZEL043Yjg2R1c2Mnh5MllHcGpBZUlNVS9heWZXOUNNRmE5YWhD?=
 =?utf-8?B?NnVnNlYwSUZzQ3NWN3dsMVpJSk9HcmZab2lkWWczY2pqSkY5aVFPZVN1QjFX?=
 =?utf-8?B?QjlPQjVpK25jUHBGWEpnSmhPVldqQktVUnZ2UWlyd21yTGp6NHFxMTFwUEZP?=
 =?utf-8?B?SHBDVnkzQTdWSU80UHZKSkF4RGN3Yk5XMEJ3blhFaVNrZVYrMlV0NFpoSzRY?=
 =?utf-8?B?SFhQK1NFT05QV3djMkg0SDdURVdIV0xSNmpuZThNcjdmSE5iSTRETUV1ZUl4?=
 =?utf-8?B?amp2R29kbGVDYnhQb1ZrOVNLVUhpMkx4dTUxSms1dEV6NXNEMjU2S1pGdG9Q?=
 =?utf-8?B?TzVJNXNQT2ZReWIrZzBFUHd0elczRVhnZ2tYUWQveTR4MU9uSzJZRExLdXRI?=
 =?utf-8?B?N3NWcSsvd1JONVBtSHhoNEp3eEpBWjgxaGpWR00yVHRJRmxpenpQVjBjTk8z?=
 =?utf-8?B?RkJzNzFDYnZZZE4zRnFjVERvUDA3R3M0V1o0VTZlQ2VzSzlpYWkrRFIvNXBa?=
 =?utf-8?B?QUFybXRCN1J0UE5OclFaR2VjekRZTHdnekY5cUZjbWZVN0doN3pmaXZ0NUNX?=
 =?utf-8?B?d0RHektGNm5HSSsvRjgzN3dEZTNmSzl6MkFGN1cyZEJCNy8vV0ZmWHpSeVB3?=
 =?utf-8?B?MmpMaU5wdmlLc0ZuTWgzNnZOd0d5dEg1eWpWbmxtdXBnMFJnNnAxazdDOWg1?=
 =?utf-8?B?ZWZXWVpSdnRNOWhHVWQ4bUNyNnNRV3AyMHJDVW1aUHdHUUVpdmVDT1hEN25s?=
 =?utf-8?B?WW1wWnJLNVBHMnN2OXd2cGxmV1ZSeFBrNzdjazd3bDJrbzgzeU5tSEd1U1VD?=
 =?utf-8?B?QXpaR3R5NVdiUkRvcDZTUlMxWWVZdDZxRnJWT2daUmtRN3BJbnVoQVZQVXlB?=
 =?utf-8?B?c3VRZkZoL2ZyT002K0V0c1o5eFRVelRzSTNTSHkrNVNTRjE1OUJscDM4akN6?=
 =?utf-8?B?djJDT09KL0JwanVQVE5sZTFYUUFSbkx6WXJubzI0ektqanJPbG1KZjdtUTQ1?=
 =?utf-8?Q?unmGpoQnjT7hpxlC3tJ4bPs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627538bf-cdab-4288-39af-08d9d452116f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:58:39.8007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLQEgtcdsdF/e4dYTBgzI7Ea4js2IHGzpAj4Lhm9Ry82mr5UTUGRK1CXkHHDjwjwzw4LeL/zPTGDSbCbGplfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/5/22 8:06 AM, Tom Lendacky wrote:
> On 1/4/22 4:49 PM, Kirill A. Shutemov wrote:
>> Hi Tom,
>>
>> For larger TDX VM, memset() after set_memory_decrypted() in
>> swiotlb_update_mem_attributes() takes substantial portion of boot time.
>>
>> It makes me wounder why do we need it there? Malicious VMM can mess with
>> decrypted/shared buffer at any point and for normal use it will be
>> populated with real data anyway.
>>
>> Can we drop it?
> 
> Probably more a question for Christoph. Does SWIOTLB need to be 
> initialized to zeroes? If it does, then the memset after the 
> set_memory_decrypted() is required, otherwise it will appear as ciphertext 
> to SWIOTLB.
> 
> If I get some time over the next couple of days, I can also try and test 
> to see what happens.

FWIW, I removed the memset() and it doesn't appear to cause any issues. My 
tests weren't extensive (boot, kernel build, netperf/iperf), though.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
