Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912BC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7212361158
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7212361158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33F0E404DC;
	Thu,  5 Aug 2021 16:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qcwm_sr9OPkJ; Thu,  5 Aug 2021 16:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C489404B4;
	Thu,  5 Aug 2021 16:29:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74CA9C0010;
	Thu,  5 Aug 2021 16:29:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBB1CC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8158405FD
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fu2OsVUspJrs for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:29:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5983F405F6
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7YHEF1RkHMSQQJ0YP7RNCf0JTVhonV79xWdulWL3vjxmQmFCu+C+4Xf/NTpw8MrVM8jJ8K+octbDD0H+fQfm1Zl/MGH3WiqZxgp/UCANFp3BN5dMUwJ1r0/iRX73qh7CIg55pVBnZojmTxrStuL9T4QAf3XIewSop/QRdvtUvbxqOGVu/2snpVMX5wPeupgOHYNoSgNrZ8GKy6UlVCypYFrzISZiN2XEibwhj0MKIRLnWIMGt3mPFgLlxvBPg11GBIxHjl8Vzr6t1lftKqkKUc5/MHGE45E2UMlATGmwFAARybRGEx0FySFMiv15OQfFbfthiSQyUIOQdbTK82hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNxta7ryBdch9BX6boZFf8vPpxvI7t4A8059q9ka8QE=;
 b=IMUO+EjU6+JGTnxsFxVPYZ3Ek+uib04VD6SsvQ2I/mpgde2SAKqUp0TeLLKDuM1fbbnzSYncgGmWvm6HSraCcNF6bQ9vnjlExkGoBYbpDM63Oh3LzBMz+LWDlElnyRU91lFXqzW3RYBmOCLemnMqPO7ScMvBQwH7lZBYOMlFcmlardO82RcVk7u6/FH/LYaVsasazCMX4BA6UJmjw3kZDePOwbyxP0u/wtxO6X9y59ypO4l0K0Abuh/Y4eD+xwI6sfwTHTWy0ILHnT02aVWshu4ymNrS+sfp6uSSDbRItduB82Ixfp4pu0CC769W0mPGxGdgPSI63Wb0muJlcxiwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNxta7ryBdch9BX6boZFf8vPpxvI7t4A8059q9ka8QE=;
 b=w/2lbYcusrIekf52I0N5tAEs4DK4yZ3sojHa75LzHw/6WMrBbHfM/vI1mtZnFPj6fgeF+qxQFfGEDWJqg2wRGv4vOwzORh+NYZtD9FcZ/gpxzmpeOoPypmb2AtFIW4mPR3/38rQOj4egCkK2TueVW4urHvtgw1/rZ7DOJ8RCL20=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 5 Aug 2021 16:29:16 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 16:29:16 +0000
Subject: Re: [PATCH v3] iommu/amd: Use report_iommu_fault()
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <YQlsm1vED/lEKoZw@wantstofly.org>
Message-ID: <9f0ed779-40f5-99bc-6169-c7c3a134041f@amd.com>
Date: Thu, 5 Aug 2021 11:29:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQlsm1vED/lEKoZw@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.65] (165.204.77.1) by
 SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 16:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af97d009-6dfd-462e-bf48-08d9582e2b0a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB527831A41E7F06D6B639B36AF3F29@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkSuwD5w/FYFjPBD+KNF+sG7/x7iccHODFUmZNsDgDIEVD+VFhh8MYuGwvehF7+VY/g8p41w8n5Wn2KWjnY1jC9LxMZXfofAXJ9CEpNVwU3KYs8yT95GcX9X1EsaSPPCk/KSKEjWaosCMFSEopKXXCUjO/bzldjMd6J5adiQBqtK+3qZ0jMq/Sum5c3Js4b0IE6qo++0IcYOGKqm7iTZHy8mdUB9CIpGSqh+7utTnnQzeLH5tyYURWcUF4tny6WlEAgRyoEUh1HlZ3o1Dm9IsI6i9mSRyj1Y4mXQcejo8MFVu3vzHpcgBpKh8r2UW6aJsv3MTN4K9h5bNupth9/dikD1vhtIwY5fDOezSUxBWkXwvaBfOWZRuUdRu0KOLGCiKOExZBoPWp/Lr1e78pAB2Fv6Z4vYchRG+ghlkopfIKydBGRFL1mgKC2UQad2yjChlKHQKSStlLJQCKr0a3zG1WjeDqzk/MBTakMgR4vmoYf/v/QaKU2Vm7/HWa4zC3N2fE0ilTcZM7tEahb0r4ga2riKChdpWLl3Uw2igepUBx+JuzSEpwpKadw7BTXuWUxA1fJtugy0xHh5MP/jMrUeYGWRw1UKSxnf8Fyo95jNtN95gGgTvWQuweVkFMNvZgeaP+kdw7Yjo/9ahzP/OlnVkzhsid2H4+mNqDPu6w92MgtgzhOLYUs783d240ps/0glNJL8svMUCwywi+09T/1z6AMTJ6yi/i6nHE3Rtl2E5pl/nIEuAxLA9heUlieu0jzX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(38350700002)(31696002)(316002)(66946007)(558084003)(66476007)(110136005)(86362001)(6486002)(36756003)(66556008)(31686004)(26005)(52116002)(186003)(478600001)(16576012)(38100700002)(8936002)(8676002)(2616005)(2906002)(956004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVkwQ2QwazZoM1lMeWsvU2NNekt1VHVzMmM0WVlxOEZIbWdINGMrMU9ha25a?=
 =?utf-8?B?bFJFTnRsYVBpeWZwa0lZNzQ0SUlWYXJCTXd3OEtiWGFNY3l0NW5UcUR4Y1Qv?=
 =?utf-8?B?VHRMNVYvMnFaamZKaTdHdlI0WDBvNC8wUTRDalp2TkkxWVE0VFRGUWNXWDlN?=
 =?utf-8?B?UXE2YUl5N1h5aVR5YzZZaTJ3cUhYUCtiMHc3MHU1YXhYVFJPTWZGTFNZRnlC?=
 =?utf-8?B?cDR0OENramxoUWV1MEc5cWo0YzBJTmdGUmVRYzU3ZGQwZVBYaUNONkc4dSsx?=
 =?utf-8?B?bGNVKzA1MHE2cWN5cjZ6LzJkVFJINlcvbFY4d2loOVdKdVhFcGZrYVlKV3di?=
 =?utf-8?B?ak5tOHk0eXh5djdjTXhKYm9qODBLQkJRVXpkeVdnMjZBaFp0ODc2RVNDMUI0?=
 =?utf-8?B?ZnhUaEJzN01tcDRUYzdra0hvZVFhTWRGTjdlMnFWUTZCTU1sQmlnY0gvT1BC?=
 =?utf-8?B?R0I0ZjBIUWhIY0xrYVk1VHQ3NHovTmdnZmVkZGE2a3Q4TkhmUzY4amtHYlRp?=
 =?utf-8?B?UWc1YWJmL0JJWjF0UG00aHpLSE9BVTBiWHg3R0Y1L3JGaVlDem1GNzV0eUY5?=
 =?utf-8?B?N1dLeGFzZkZuNWF4MGtIdjlRMmdHdCtLR0lBMDFNWWNMWkducmlWcXZtVGYv?=
 =?utf-8?B?MTFZNkpHUnRTMnVhQjZQdWI3T1U1ekNwM0VtRHp4Q3o4VTlDUXNraEZHbThk?=
 =?utf-8?B?OVorQzczeHFIZU1LaE04YUJQdnlZVmtNY3kwdll3dVFNYU92RWUrUkZLUnYv?=
 =?utf-8?B?a2taQVIzZUR6ZlYwR2ZlSjJjZkVUcGFWanJVRyt1WDBvZlF4OGVvRHpWejcx?=
 =?utf-8?B?NU1YOERnLzlqMXZsZk1zQzNVbStBY2tNY0srUnJra1o0MFF0L0t3SFNqYmw1?=
 =?utf-8?B?am5yQWtobHZIR2VaNFFkdUZtWit5UXA2dDc1RXFkWUkzR1BvWHVxbjVkT3Vq?=
 =?utf-8?B?a1NES1R5UGs0eEhhTEJpeWN4dTAvVWIzSEx1NHQvQ2k5WFBuQzZJNkNLS3Jv?=
 =?utf-8?B?VVhlWlN4YVA5WEVZaDg2YkdXMUVxdTFMZFlmaVZ0eCt3WjlSNWdTS3JLUlBL?=
 =?utf-8?B?Mm81akNPWkwzT29SbnJBQUUvb1d4SUFpZHBhUG82ajhjZ0dvUGoyREFnclVN?=
 =?utf-8?B?K001b01nYkVoK3FrZlhGODVpNkVOemVXd3BxV09TajlaNHFDcXRQK3pEOElz?=
 =?utf-8?B?TVQzWkxKY0htSHpZRjNHWjlJQlRYVUJEdE8xa0tyQ0dIQk4wMzM4T3JXZE1z?=
 =?utf-8?B?NWV1NkJQbkZ2bXc3c01Mb2xQMDQ2QTFKb3hXTnRLY2R6dS9EYXdNTGw3ek0z?=
 =?utf-8?B?VGhoeE8rMGlUYWdKNTZiVzBrbHF6RTg4Q0l2eEZ0ZU9qZ2ZBbndrNGRxNDZv?=
 =?utf-8?B?L1pnYVpUNUJBdXR1ZG9ETC8wQ1dRekV0VWtHQmZKZnNIK3ROckVwWkgxM25Q?=
 =?utf-8?B?aHpXcUw1RUJVblM5aXI5ZVNpcExDajQ0MVIvWTc0K3E4T28rZXNJbFRrNUts?=
 =?utf-8?B?blFhK05WUnBsV21HOFhNbWZXdEJDNGw3bzdaZzhpamRBWFJrODdkQTNhSEVm?=
 =?utf-8?B?N29lZzd3MHZRaFFmbzZzL05KYmlmM01NTzZtNlZSWmlnd3ZDZ2ZITHZvZWNa?=
 =?utf-8?B?L2tPVGxlSGdFbU9pdGFuZGZ5WWFIa214TUxiMC9INksxcXJmbGxtYUtxSlhV?=
 =?utf-8?B?ZGpvQmZZSy9tamhXNFpoNmViUlNpK1o5a21wdERIbEJVUE5aRXJIOTF2L0Y1?=
 =?utf-8?Q?wCek5FinoJ599Zs+R8XBHGtl2tSLZw8f9YY7419?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af97d009-6dfd-462e-bf48-08d9582e2b0a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 16:29:16.4565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwmIfjAfstKGT/AS6DTnXV6MEk4slGdzqTx22SwYj99ZZfo6xvDziQuH7A+X9ppBnnBPXkeDSO6NaKRzz7/JwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

Lennert,

FYI: I have made some comments in V2 thread specifically around the new changes that we discussed in that thread.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
