Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A569C4338F
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 19:35:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B40F60EB2
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 19:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B40F60EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B5C383578;
	Thu, 22 Jul 2021 19:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltzlyqA6cBx7; Thu, 22 Jul 2021 19:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C87B583576;
	Thu, 22 Jul 2021 19:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88FEAC0010;
	Thu, 22 Jul 2021 19:35:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49334C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35C91405C9
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7cMAxVSJCku for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 19:34:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42F35405C8
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldm0acIo9jDf0q2jVvWva5Z+0xbqz17oTaRecs1hl8rSmKr0ud1gzqSE5ZN8OeYFWWmx156ScylOAVcoqTliW+uAZx/a+umu4AEyil0bICv9DrvExdf/KO+ROCo4zxW3oOYpQH4fMVjyrrS9w0nnQ2E0h4yzQQPpdVGbga9IH9E0HpzIs+EaLMuxzixXnZiA2HIq/fGiUdWZg8Q0KzIAoy4LYb8bVDgrecXKXByG8jdi64Tlgqyrwue+RKf553g9NoQPUiVXlrXs6uXhjR/gFVm7s3Fpp9qU1h7a5hMKT+VrTPnGkWmJEWYyAD4+tuzA2Lz87W+fuZiot8gW0//TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOjHm7GUA+5KENaoL5A5KXnJdP/+5RQtlkLfn/h9wxQ=;
 b=gjUptb21gSUH3/pTBm4CSARsmHvJFFeJnt9pWslBPqzZ8euVRkaS1zdntu8lpEIR8HipkJHm/pz60O5BbGHyeazA3eXiD+aduglcSldLgeUJr80tLJVAgOyDQNdqmDXS1AkFM0wS3GoBuq/nodGbU+XMZcdUlacoKDbsHBaN0BwfhPEjTmvv6k+bDa5IUafDbOsuMReKCuZx+no0LLHPPoEOlrbDhj2z3TROPXOzsC0K1MKowl3gzGY4SxbichBQuZOQO7xRsdS3qjb5YtE5NfW2F3kg63NzwAel7B3ppwxuABpSPJhgXZ6NbJY3D8Di2181HqYqNhn1RqbvWAu23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOjHm7GUA+5KENaoL5A5KXnJdP/+5RQtlkLfn/h9wxQ=;
 b=bAd63bOu6mtBQ53gbQt92EIdtV9IgJr3y4lGRLwP1l8wWVQI3NjYCq2KaABa4BUt7RKyp65s0sEQJiiH7cIHIsR2hQ1CFWP3SaiguFj8Ax0qkCPaEZ1hJoG6fJZnc/gXKYfBj30ke4T0bvZ89dAHBDZjo0aa6wrmP+/6JgQNlTU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Thu, 22 Jul 2021 19:34:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 19:34:56 +0000
Subject: Re: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 pasid_state->count
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1626683578-64214-1-git-send-email-xiyuyang19@fudan.edu.cn>
Message-ID: <ec476aa0-dd6b-852c-439f-89735f5b08e7@amd.com>
Date: Thu, 22 Jul 2021 14:34:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1626683578-64214-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Language: en-US
X-ClientProxiedBy: SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::6) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.117] (165.204.77.1) by
 SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26 via Frontend Transport; Thu, 22 Jul 2021 19:34:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89584513-c60d-4ca8-406f-08d94d47c8f5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-Microsoft-Antispam-PRVS: <DM4PR12MB519883947120A4A57066F2FBF3E49@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CXfDmmCX9Ua8RbzHohbFmIIhDPKcIEIaiOAGguBKru7GNVD1o9EYkzdHXq1DTAJ3/ygKPDORiIUfbL9LtcKYAwJrGVX84m25z0UmgRuLEeWIrhnfqaUAAerLimRbksFXxc71Wl/qnAXJ2+LU+ggai7Kkh63Fc/be5MJ1wT1+GcLseGAxxhuC35wtaDo0Nyu7A5unYg4zkd1fWTP4SqjEpfKdtzw1MI3eKzmyM2RIxGeriPIBjiO5lT0cw0JtAx/Q0H9P5LaMblgma3dX2dfSrnPyYUYDy0C85Gmv9rnztIwQOLO/lrlCVsERePVtl7ENOKo90d1UlhUowbLTPudfHiz5mDx530KhjR4TpFA4023pged3ix2GieuNncWQlbvUaJSTJ/B8e2HCwk3/lFKZ90rhaXpZHIenuKP6ZVN9Hw4EHWKIXWCx7s0j4TWjUvCRXeX8nqohseqOXjLIkCWVCazULyu+Wh/Qln/3vMqUv3CcUixNAFVZmtpjNDWqXf3Fsul8IBjuBNcZF+EvcLrvlixHb5OvlLRWgy5pe/BKpF3Ji68noPtyevbjhhJysAsXnqnUyoCDkCyTSePJ0lq49ufOmhXcb0B3c99RJhtTrll9V5iiuT9RSzpdch5Ax9Yh2WOjycp1jeD+3Ki8Hdt4wAyI8UpwU0CYoTWWKxsDWMZhikua+dzCV2hl0Q/WNs0xTxPkRHzHTC9yz/3BfD5g/kWwuVH2Sxl9SDcgS2ZioOkOML2VYdC0hZgBs636/Bc2wXAjqVJcgnpYsMqTtR35w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(956004)(8936002)(66946007)(4744005)(5660300002)(86362001)(66476007)(66556008)(2616005)(36756003)(53546011)(316002)(8676002)(6486002)(26005)(4326008)(16576012)(110136005)(38100700002)(38350700002)(478600001)(52116002)(31686004)(31696002)(2906002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJZYWFBa3MveTNQb2ZGR3NSWGZ6ZUorU0FsNW4yK3VqajdwMUh5bHdyNGRa?=
 =?utf-8?B?aGRZbEFSTG5jd0ZjVHN4WCs0bXJobHBKd1BqeURGQzNqaitpd2dmZDRDeHpD?=
 =?utf-8?B?dlZjRldzYW5sWlFsMjJCU1EyeFIrNVlWT2cvYkh4eUJ0SU1sSC9rbG5YVXBL?=
 =?utf-8?B?TGw5R3UzTFQzTmhCYi9icHRaeVBZQWRLT0FOYXNUa3FIQnEySlhWek83Q08v?=
 =?utf-8?B?TFJRbmp1eUZTZG5mSVBBVFpXK3Y5NE8yWUtNVENnbUNEUGlSalhzQ3dROWdx?=
 =?utf-8?B?WEU0OXZqYml3K1dpM09Nb093Rmw1RDhxNFpzUi84ckFQYzhHdWZXenpzWGNs?=
 =?utf-8?B?TDkzUVJyd0FESDZLMXJDcVRvK2NkU0tsN01IS1lnNGZjbDBDMTBHR2FVcGR5?=
 =?utf-8?B?VkxDb1JpUjU3cERZTGNWMUhYa3pwQWp5cjFETFA4ZWFNblcvRHhNL1pDODhW?=
 =?utf-8?B?czFwTFNtdUVyUE9ZRm5PZ0R2OURQczhBR3JBSW9zMmdsVE5RaTArWFdHRldm?=
 =?utf-8?B?cGFJZmxCVDFRSWYvaXRKcjB5Tm9ud05aMmlTTDA0WXN5YTVsWXhlb2d1RWdX?=
 =?utf-8?B?ZURCeFVLM3FFaHhQNmVRQ1RaR2ZHbzh1a3BnVFczWElKMzhFZkkvYzQ4NDNO?=
 =?utf-8?B?VWNHbEV5NG02OVppQi9tWHd1RnhjQUY4VjJCSGUyQ2FVYVE0bDU3WDhEdjR2?=
 =?utf-8?B?VmpMN1NwR0p0RlNkRHRybktGVkI4MUtUNzhPMExTdTVWTi90dlV0Q1ZaQXFX?=
 =?utf-8?B?d3ZRdGloWERlMWcrcnVLTnlTcFg1b0Y2QlRxK3dFOC94eG5TNm1oL2o5cU90?=
 =?utf-8?B?MFB4RFovU3NBQkRDT09HMEFFQ21hNGdyeHdpYWxYRURmdFBZMjRwUGo5dk1S?=
 =?utf-8?B?ajFleTZNcXF5d3hzQkhwTmtGK1FlREVOZnh4cTN2TEFTbllaam5QRmhsb0FO?=
 =?utf-8?B?OHBXZVM2ZWtxSmxtQUdObTZnTzJhSmMrd3VEQ1BpWkVYL0EyUFBtSHhqQ1Zl?=
 =?utf-8?B?VUhKUXcxditiaUZoNlZVTk9kTDIrN1IxdlNlZjlwbHA0S1FjaXc2cnhKRDdY?=
 =?utf-8?B?cEFHWXkvb0FMN1NDa2dwQ2dWYXZReUR4clRhOWxxYWxXeU1qS2NuVGZJSk0w?=
 =?utf-8?B?NUtvVHg3SDhhUzd4RVdCc0ZTVElJYkxRMzN0VFR6K0prZGh6VmIray9IL1Ax?=
 =?utf-8?B?eUtONURWWHFJRGlVOHhIK0JZK0J2TE9HdWdmOFVMejhKU3JMNVRGck1ycXBr?=
 =?utf-8?B?S2l5am05dmZiNlBwcytLVnNMS1hMTjlqTVA1THFGTUg2VnYxVklLN2RSak1S?=
 =?utf-8?B?Yk8vcERIQ2lyRGl4TUgweU9VbEFRcmd4cXh1VFVpaVFLa1RNeEtMQk1sUmpS?=
 =?utf-8?B?ZVFwaXgwcDFJOFRCOUxZZk45R29ZNkhmdTFRNHhCVG5CdnlaaUhRVXNFOEdT?=
 =?utf-8?B?ZVdzT2YrTTRjSWlLWUh0cGh0YWo5QjhyZ3gxeWdlaldCNVhETFBzQnpQcCtK?=
 =?utf-8?B?NTJJU2J4NkkrUG9jRHhRdXUwcFlFbmk3d2ZPdFppZThMNkVLOW5pVi9qMVpD?=
 =?utf-8?B?QU1IUTVIcUNnWDhtdklpVXlZT0RTQTlvNFh2VFhhZ0VqOE8vMk5ZMGlIVUEr?=
 =?utf-8?B?RjBuWGR3eG9iTUp3c0wwZndsekhmSFV6TFJVdHpSdVNPWTAzUDliNkJwOUVi?=
 =?utf-8?B?U0VkamRYZUZxN0J0K09mOHJlSmVpQVltc0I1c20xS1FXVUFGd2oxdnpwTFE0?=
 =?utf-8?Q?1c3fJEAQPY2/OBFt/4J1Q6/IvURbzTh3lu+p373?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89584513-c60d-4ca8-406f-08d94d47c8f5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 19:34:56.1020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jon6BoN3QPBrXH85HGjcIVrdsLdJvOyQjFfjDYwiMjwHwFHJ0GKbMmgV7Urg2k/Akn4oo9ymKV5gACbxkdtuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
Cc: Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
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



On 7/19/2021 3:32 AM, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Thanks,

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
