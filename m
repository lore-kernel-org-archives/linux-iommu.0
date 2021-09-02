Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C497C87FC4
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 16:30:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B056761248
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B056761248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8297860716;
	Thu,  2 Sep 2021 16:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEcnUJFcJq76; Thu,  2 Sep 2021 16:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F5A46071C;
	Thu,  2 Sep 2021 16:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13569C001A;
	Thu,  2 Sep 2021 16:13:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7866C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C031A401F1
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jCLs7ypYppzP for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:13:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A608B4012B
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UINBgE6jnb5VBf9moC2ugAd/EYsoT27mcWrP468KWi5Bv5K5FRLa1pH8H3p36/y+6ZfFchvjb5YQrscJ0g+LQKKSFCwtWJHcNIP3UmVNPrDvE1Iel8Rx9yvaBKBOewHylXNlImND8gMX9NPebfT0pCM/5FaQk+yxyPATPrRFkP3gNEyaOvN0KkEXbzCXS51p+tAoyVd+FrtGkxpjFOgXxd3OWpMcHkmSYVOjPpmf6ETHVEqb6sEvSoVLBzQdUVFwOWjvR2lG9ACqpUDEkwXxjvFqdA59/TF4+UvTxENmZV1BXb2E6lOFlFhxeaUZZzD/9IQmV8F+YEf4s0ok1wbXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1U2HPVIlm2qDs2x6YkCww5s0MxnKkkXieKlIYW4StYk=;
 b=EhjM3aH+1LOBs4IERGQka2bWZ5TpjuNxSD1foQV7MPlaKYjGkWu6NEyKbHRU9KYP9HkKs8ywZzSphV+/nJtgSjwK6v3W121HmnuitOTTCbnBr7Wfvx/dtbQJx/BAIFBU9WzESGr1i4Ma1NGdhR75EqFKUiGv3yxl523AQrkGQ7QqxVvC8rg/77aerRWcKg6d7Abmt91tcPHJSKq8Ciwm+AyEX/qJ592hk/2eXKSagho43YVfePR1S2mhGsg+zYdJmT8/Xh5LiVMUI6+JPyWN9UajrTM/MpeZGQluUOtcbp/ybps/hX5bx/hroekVXg0rXN2DPXmm6GoOl7Er80X7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U2HPVIlm2qDs2x6YkCww5s0MxnKkkXieKlIYW4StYk=;
 b=e7Q3rbt1Zae9FbZB9qF/Y5fGoRFqBO3QAruGUNziigRuEyedE76oAZsiYCiBkfkjJpNTkklJYZ6g1svcWACPpz2RTjd7bC6HUSVrndHCSr05rxXrbyPKVkiuq4aFeOaTWhS83wgt2Wf6tRLsphOGJYIkHhT6wxnJ+KyC5PgJNu0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Thu, 2 Sep 2021 16:13:03 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::4549:89a4:aa6:6fa4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::4549:89a4:aa6:6fa4%9]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 16:13:03 +0000
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to AVIC
To: Joerg Roedel <joro@8bytes.org>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com> <YTB/jWr9vb6xvTQp@8bytes.org>
Message-ID: <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
Date: Thu, 2 Sep 2021 09:13:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTB/jWr9vb6xvTQp@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:1420:e1b0:858f:52ba:7833:b96f]
 (2600:1700:1420:e1b0:858f:52ba:7833:b96f) by
 SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Thu, 2 Sep 2021 16:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df604d23-becc-4dbe-62b9-08d96e2c8a8d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55500D00A0AECB469289064DF3CE9@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnAStt/SAcqkOPj7vdX0vJ+fkgiAavZkZelC+5J7WQllBl141wvtA+IQLDNgF/V14CMGXdI5CUcUSNpSGEJqi6drZhp6d4S3xr+f8GT4YpMUF6Sj7AYy4oL2R7dDTixHddWsPRV4fEeF0UxATLJ1yuZYaGPqFjQKBpnhSHNWE8XZtuOfvs7cGaCtD/HonUDPfeb7XmglS9wdzP20xowdZgYxDXjASxGwY1WaRDyqtIvknM4Q+aTeseKDT2zlOu8w98XbF84ZZooAuG/AARG2vx0hwrxRfa/F59BGB3yUtk4QGJIUjPhFCkKrSO5NrLW90f8Qq33M5whzDu41k/xpTfsS7GKUjU7DthLSrEiOc9CbvZpkLXgFYM5ZpWvTE1aHeZcadjTWK1IM8gPs6ubo26DvaiwtIAQodIE3qes+oiAWzFOHgCib5T47XpoSg5962jfj2rr2YT3lwtMFtxw0yY9TIXwBbGzoP4teKhiuD06WmatkClbXSj7BFucekRoHMRkREmDnS7THSOIAUsi2/+cwsPNssFkcapP8BiX/uHR+5scR6SaYJmm/hKNgTZ+/VrO9caDf/6CNyaURV8DQTMOqHDNJ7q8kw3tCHvDwYtjqQrtaAXUU4uayqG1M0PY90P5hnbYyv6vBCYsZ0OP3sRxeLNu62baJ6/S2rvXzLSD2p4d9yE3heY7G5Up1Rko6NlWZs39s29TBrqtEADu6MXtkj12zd3Xij6d6HqH4dxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(31686004)(2616005)(6486002)(2906002)(8676002)(5660300002)(31696002)(86362001)(52116002)(478600001)(186003)(53546011)(66556008)(66476007)(38100700002)(6916009)(316002)(4326008)(83380400001)(36756003)(8936002)(66946007)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZiRnBZeEJiZE1YT2FTL0dXOXdtMkpFNVQxc3pYaDZPZHZYQVJoekNmc3NT?=
 =?utf-8?B?cXJGSmI4anQ4RHZGM0VUVG9BdmRnSlVRVGFwRDRvaEN3S2ZMS3BJV01Sd3lR?=
 =?utf-8?B?cDdTdnlBeXkrd1hYTGZsdmJhck00RnNtTEs5NDJWVWJLSEZ0TzlPVG5FM0dF?=
 =?utf-8?B?YmlNKzk5ZDVCUElFenZMZkFkVzFZM0NnQ2Y3NHplWGhVUmJFc29ucElKT0hv?=
 =?utf-8?B?S2NaM21xOGp1S0NUM0EwUU5EK29GOGxIeC9HampOZXJKRFh3L1ArTHVyZlJj?=
 =?utf-8?B?UnpIeTVELy9WWnkvRTg0QjhrU3lXblozVEdCdTNmcVZYcDFYM1A4Y2tmbnV1?=
 =?utf-8?B?SXBvOTNsMTBHem5zd2U2Vkw5bEh3WEU5ZWkyU2d4UTkyUmxRQlRtd0pKa3Ja?=
 =?utf-8?B?NHI4Y3dXeEJWOFZBOENKRnlxMWg1dkhGVGJrMjRTQzJERERxQnlONi9SK0Nw?=
 =?utf-8?B?ZG1DUTZvdEZuN0Q3bnRSMTJCUzc4SHdrL0J2bW5PT3g3V0JBaE40UExPQlkx?=
 =?utf-8?B?UDZJSmwyYk4wVVY2cDl0MVhWVmpCT0VmaHpucVBzcjEzVi85OUVpQ1pzVnRW?=
 =?utf-8?B?VHdlaVVPK2VKbDhBbWFwYStDdFdhNzF2SlgzZXhwTGZVQ25VcEh6TFRJTlNv?=
 =?utf-8?B?RDAyeW9abUl6eHpZb1NOZE1SSDQ0RGJ1SWpRVXVlT0tpMDVyZHFzTDRnc2g4?=
 =?utf-8?B?KzdDZnEyRkxDWkFNMmpWQjE4S2FQT1dsY1Y1RTNXZzlaWitXclBDNWpJR3ll?=
 =?utf-8?B?TjR1d29vOXRhMmxMWUVhRWFIak9KN1p0UzNyQkp3ZnhDV1R1TndmTks1MU9X?=
 =?utf-8?B?QUdXczFYRGVCZnBadXFLaHlFYkJUcDE2VlBSVFkrbG9OQXZpTWJpU1BJN1BY?=
 =?utf-8?B?U0dPbC9lakpVV29kSnBtbzBWRFR1Sk9WT2Rwd3EwYktHNitnSFBmNEhjOTNN?=
 =?utf-8?B?aWYrVmllbktkeElSVjZxZzJXVEw1VnhGdEdtZXphN0xZRGlFNDR5dXhsbzZD?=
 =?utf-8?B?bThYODM1UjFFc1kwcGhEM1BqRU5MVW9lTXR0aHJHZU1rNDdOYUh0d0dzTkw1?=
 =?utf-8?B?RmNLVXRueHNxSVZGU3lKMFdVZC8rMkF4MUEvdytDRnZSUGhudTRBYXZ3ZG0r?=
 =?utf-8?B?WTRIR0NpT29jVVBzMFlmSC9WS05KMGpEVW1PcGJKL2k5dEZBL3dkK0J2TjRG?=
 =?utf-8?B?OWs3TzNOTHlRRGJLa09Nb2tGYXM1Rkxic3dHMDUvMGlMT2hWWHVrY0wvNDRO?=
 =?utf-8?B?eU1sRXBWNFBsb0hzanRwT3UyYW8yV3N3N21wWSt0UWYvRlI0UG1WVVZhOXBj?=
 =?utf-8?B?alJFVlZjOVZuL1FlWGRjUmMyemwxcTZrcVJra3hjSXE1dmI5UDd3eGFoVE1E?=
 =?utf-8?B?UTUwcG5LSHFUQ2tpMS95eE1kOWNmU3JIUzIzVUhqZUZvUWVSSmdBVjNsT1VO?=
 =?utf-8?B?amJEbjBQOS9WY1VKUEtNRjJFTUp1S3pieGp1U04vVkhkRTl1aVpmOW95UzJL?=
 =?utf-8?B?ZXUwMWZXZk5ac2pTby9jR1k2ZUoyNVI1cG1zVU9WTlNOUS9FS21uR1Vsb1lP?=
 =?utf-8?B?dTNrSm9UR0ZhbWZ4TTlMUE01STFCWTkvcGw4UXplaUZqV29UTmhLUGtPU094?=
 =?utf-8?B?cmFGdkx4NG1SUWtRclhXbG5XaCtSamFpdnRvTGR5UTdJTDdYcCt5bmhIUXRT?=
 =?utf-8?B?YldjNWgzL2hWaUdIYVFEanR0dStiM3ZWSktURW0xV1JZa3B1MjZNOXBQMjVB?=
 =?utf-8?B?eFEraU43MVMzSHdMa2dzUVRxbW0zL1Q3YnA5YUszU2x1UERiU1NxdDRoMjFa?=
 =?utf-8?B?Wm1CRlFkWEZsYTcyRWNFVk51NnExSk5OM1piMW9EWVFybzU5Um9JbzFVNHN4?=
 =?utf-8?Q?uTg+0ROV8CBpF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df604d23-becc-4dbe-62b9-08d96e2c8a8d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 16:13:03.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIJpXHwtuyXwJnvbe9ew/SsjIiy92lQiB7VkiZuIeEOAp5/ZAVFz+fLOHthy1j4WUDAJF3LeXjxeHRShXyBVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, wei.huang2@amd.com
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



On 9/2/2021 12:38 AM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Tue, Aug 31, 2021 at 12:10:27PM -0500, Suthikulpanit, Suravee wrote:
>> Here is an dditional tags for this series:
>>
>> Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
>>
>> Are there any concerns with this series?
> 
> No concerns, please add the tag and re-post when -rc1 is out. I will it
> queue for -rc2 then.
> 
> Thanks,
> 
> 	Joerg
> 

I'll do that.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
