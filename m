Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5EC4361B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 11:55:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2D023D67
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 11:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D023D67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34FCE87304;
	Thu, 10 Dec 2020 11:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0FCIU2E+-IP; Thu, 10 Dec 2020 11:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F9F187300;
	Thu, 10 Dec 2020 11:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 752D3C0FA7;
	Thu, 10 Dec 2020 11:55:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4A6C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 11:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5198320523
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 11:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pGVm0d49Yjjy for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:55:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by silver.osuosl.org (Postfix) with ESMTPS id 1492B20521
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 11:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvFkRfTxJxiKVI+K9T8xNn6imhMxHkT8m3/wGlATkZm5yA0zIKZSSgBlWvslGw4a/xOaGwASRo4lXbGwYN/NFUZvHbbvhdZ5kV3mvbeSnadulJfoejOrnQbQAIIvSjqhGC37RdRfFPiMMiPmMRWaambZbRdQstM60AYIz1ABawYclDiNvIHJaEUjgoIlNkncxZapgmVr8CUPEjXypJ9uPB++YrFQHs1vBjTil5u1xXTHnSMxMcJPSCeASCjLJQFPQAkoRpu8G2hXeA5NjZXj5VTwMoTocZgk+LgFh+CDm2+2poEurllpGRxiWC11RnRlfuyjduj+k9tRQJROtgf6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9r6wF26muUz3/L+sh3yGItvPWuDlicFqVMYP9exo1I=;
 b=njjBXENcGklyr9Mr6UjrufQafxRtvc+Pq38W1s/HSYIkuIfN/h+DGHaOtlnbrwYZ5flvs8FLs0rDDq889E8VDOE/KG18Xdva1yDaAqzoUOeiOOggVy/vU9ygyr39W0v82okgKWqPPBfLbcyJEv2XlLuCf0Qd9vEO+vuJKAqQJu8l0vMqPS+QvymYiMUozc7FWlNWHkqVv6UMFREoVYwODVf9qGbuPeXv3z+34dDaHo/UhQqfSuKy4NlT2uLLbGUNmlMzjgYHHUxNIlVMimCsGCtdSWPALL0w+FBPoP4+ER5vSGL7ynKZet7OFwDrkRH1g923E0Q6YSXBZblKGiWJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9r6wF26muUz3/L+sh3yGItvPWuDlicFqVMYP9exo1I=;
 b=qETLX+rsWdyyTpo6LYiIh1D2j4ck9KgNX+QdpF2fhp2m7epRCYDDhAlzUNC0RRXpFNXvT1IGvXfmCV4H+mJVOqU3qEi/TP1iSAWiYugtHtyBo5yWTodp6TzzZKZiZKEFgDnWiPvPBWdfXKnsp3uG5bClxzVw2fD6h0ea5ak3ywg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 11:55:14 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 11:55:14 +0000
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To: Will Deacon <will@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c9f2c7ac-d728-d964-e2c5-16b504588c45@amd.com>
Date: Thu, 10 Dec 2020 18:55:03 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201209185020.GC8778@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [2001:fb1:e1:f5cd:18a8:5405:8af4:3707]
X-ClientProxiedBy: KL1PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::29) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local
 (2001:fb1:e1:f5cd:18a8:5405:8af4:3707) by
 KL1PR01CA0113.apcprd01.prod.exchangelabs.com (2603:1096:820:3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 11:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8113482-adf9-4347-b7ef-08d89d02747b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:
X-Microsoft-Antispam-PRVS: <BYAPR12MB318959319841BEE3C50E805AF3CB0@BYAPR12MB3189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Irt+swVxwF1rRbrpMCn0vUFRZWekuPxXb1MuKHQDx0Zya9sg8SvxdFsMCx8Av1hq0ydv0A07dNqTYT+Svd4GIf0P54j4If/hfZ262IW7eRNb/94fNZSM7YpmAGO/5fVzv7eerX4t0VYfc/P4ygoyxNJjMFUXNB2UIQmxFAohtjE8FhJhXgV1VO6RYUL21KBdmin8DX3dWz96iCMQog8aEoXPjpKxWKVXCqnkR4nf9z8kck59pQ43i3Jpy7aw4QXBLIF8nOTQuLD9d5tFGaBVRJqw4A+FpKS7z4tRpNMJUFaEDH2+SKab0C34UeLplj2sSf/5TKf/tPrH41eaY1IAHLHvw7OKxEL1MEbjloKQSSBtE59p6w24vRZJNlxJlSs+FNBum5BFFkKOzrpnHywaubbUhnt+2QAxsuD0D7yva1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(5660300002)(2616005)(16526019)(2906002)(186003)(4326008)(8676002)(44832011)(66946007)(31696002)(52116002)(6666004)(86362001)(8936002)(66476007)(6486002)(110136005)(34490700003)(6512007)(6506007)(31686004)(53546011)(66556008)(36756003)(508600001)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ky9MNVVHY1ZkTisyT3pyeisrNlV6c25Md1BBaDFEMnpKdnBOVGlWa0YzUTVW?=
 =?utf-8?B?RmpsTEFqbTJoSlRzMHEydVFaQjRkOGtYSVdneVVwdi9ZR0xsYittY21aTnNR?=
 =?utf-8?B?S2pHWmRDVWdVbWhaZmp4QVNuNHlUU2lLcUNUb3prT2dKSTFHdFZiN0x3bFZl?=
 =?utf-8?B?UWFmZ2hxUzRBT2Q3dGlDZ3RSN1VpT0tOV3RLalpLRll4cXJjMjhUVlNwTjBX?=
 =?utf-8?B?L0hUWHdwdWZkcjlmM0l6MDUvNlpNQW1mTXp2U243SnVZcUs3UldSM2VtWThs?=
 =?utf-8?B?bHg4VHhPSGRwY3ZrSS81NWlmeFNCaFBpMjBPVTZFYTZCSVp6b1VsWDQzTEZi?=
 =?utf-8?B?eEswWUJQbHRXZG1yYjlsQUlYK3FjVDl4VWxQQTJEdU5SS2JRQWh0MkZMdGhJ?=
 =?utf-8?B?Umk2SXFHa081YnlUME4wN3Q2aXhsN3czdUI4SWRyVkthMGZ1RzRObTc1VTJJ?=
 =?utf-8?B?V1RqREd5OWh2cEEyT0Y1MDRJelg1VXJMRUhrdG5zeTJxdkt3RDlBRTc5MDUr?=
 =?utf-8?B?Z25DZUtOanIwcnhtMkxMQitWQzFuTXhLSFB1aEpMaXc2alVjUmY1Ums1bzhw?=
 =?utf-8?B?N3BVbnJidlNPY2ZGcnkzWXVFTldKTkoxUitFS2hld01YcFNxQ09ySmtITnNX?=
 =?utf-8?B?b2hqVHg0WmIyTXBjTEJQcEhkUWV0VUo1TlRnZlhGUHNzbjNMYzQzUnplWFhv?=
 =?utf-8?B?My90cmxmT3IrRUc2UC9TNVRrbzdEc2lwVjVUdUlYTTFuSjd4VUJveCs1UjlP?=
 =?utf-8?B?dE5KcWlXeEZMcXF2Q3hkdy9KcU8ybFNBcFF0b0E3TkRQbUFIU0gyQTlpUklW?=
 =?utf-8?B?dm9mL1diWTNiS1loTHB6OGE0SGJGd05icHNGNDVraEdsQ1pRdk9saG1qSVJE?=
 =?utf-8?B?N005STNSMVVhQ1BZZDFBb2NSV3Z3Wk9BZUxacHpWS0d4YWpid2NrenZvcFNY?=
 =?utf-8?B?d0p5MFIxY1AwTmxZc01VSS9oZWlGME5adERldFh0U3p3RnQrOTJBQXh1bXph?=
 =?utf-8?B?SHRmcHdhZVVuRDk5SUdmSUpKcHRBUXZJTWVFd2NhTXNQbGMvd0lnWkx1R0E0?=
 =?utf-8?B?Y3VuTTZmNmpISWxHQ2hHUWthdm5rcGROY1AxU2E1TUc2NVVQbzRCcG9RcmdO?=
 =?utf-8?B?UElJVVZRU2puQnczYWpHUWtMSTFmSjh0UTZKVWZqUmh2RU1QOUxMdVVnYnZh?=
 =?utf-8?B?SkMxYjFNSkZwQ3d4RFJvZ0d5dTdETC82a0ZVN3FoakNiMVk3TTVjWU56bTBP?=
 =?utf-8?B?TEh4SXN4dXpqcU5zNTcvQWNvbkhSRXhNUnhjUDAxZ2RRdnhET1ZEVUpiKzht?=
 =?utf-8?B?WlBMMWdmL3hTM3RSNEpZOEVuVTRHNDVXQ09PVGkrZEIwWWxiN21aWVMxRTVQ?=
 =?utf-8?Q?UTKUABZBPG4o7YsZF7rA9i99eYAmdlWY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 11:55:14.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d8113482-adf9-4347-b7ef-08d89d02747b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atAvqmMi77LE33ReXZvZCTTFEk6aKbkawlm44Mwzy1RyqXj71FHN8jj3MrXVQ9UvsbtzqEdRV4DL4rjISWwD3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

Hi All,

On 12/10/20 1:50 AM, Will Deacon wrote:
> On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
>> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
>>>
>>> Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
>>> for a fix, where the size of the interrupt remapping table was increased
>>> but a related constant for the size of the interrupt table was forgotten.
>>
>> Pulled.
> 
> Thanks.
> 
>> However, why didn't this then add some sanity checking for the two
>> different #defines to be in sync?
>>
>> IOW, something like
>>
>>     #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
>>
>>     #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
>>     #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)
>>
>> or whatever. Hmm?
> 
> This looks like a worthwhile change to me, but I don't have any hardware
> so I've been very reluctant to make even "obvious" driver changes here.
> 
> Suravee -- please can you post a patch implementing the above?

I'll send one out ASAP.

> 
>> That way this won't happen again, but perhaps equally importantly the
>> linkage will be more clear, and there won't be those random constants.
>>
>> Naming above is probably garbage - I assume there's some actual
>> architectural name for that irq table length field in the DTE?
> 
> The one in the spec is even better: "IntTabLen".
> 
> Will

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
