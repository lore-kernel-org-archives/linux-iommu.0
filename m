Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C5CC433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 00:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A02E340887;
	Thu, 17 Mar 2022 00:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPqjbIEx2qDg; Thu, 17 Mar 2022 00:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D2AB40883;
	Thu, 17 Mar 2022 00:04:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D5E4C0012;
	Thu, 17 Mar 2022 00:04:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29F37C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1209484164
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KYXFaR-x4YQ2 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 00:04:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4F2184160
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYXX/cADQ13D0x0yZPQdKZmSLhlxZmyI1Pt7ohuggGcb1acM3ltOeW5JQbjsAS71sxaSNJUk0zOTPLx9NfYajD+Ddrpa4GcJtk6h5KOKENgR0VgaFyh80OaT2MBUuGvhkiCrsnzJ1AgXx/ZdAnJEwZFf8dpqfCDhlD8pLX19172OgT7oopceaYERDj/VI+1VjLVW0HYc9pRJymzS/ZEouC5LlOS3lOIlgu9ePbNZwesC1bKSnQW/gF4wfcI8gtotvOWfXVoVUaTQkLUq3coJkvmZWFHzlBqj6M+oH49e1xJTRbWWe4GYvx1qCkOMac5crf7VLJjw71DFNMwt0uI8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNIgX56iYMZRXil4vYlRx81cSS/fW1zfe28v5ogJmQA=;
 b=LSOjCngdcQaEbqHJlivuNuX7oY3/SXJePSjFdHqoEJYUrSWD+zD+rQhc2jNFzb5yjT5y+d3d7TUqj0xeBYReSFzFEBia9GoejhOoPEslo4pLqgaV6M3/Ze+Qu7FXOl0Rh1Z8vRHUpzEKRZ9Bn0TxkZkR4oo2weNyat5b+jzmvLBttz0ql4MwsEHoMUrfJaaGrKAvIpFP5wJDRliQELk/9IdMdAa8GqXaAGxgDwjbLyPs3kNS0WMfJcfgUgFElFa4yCySfBopvTHMXRToQqBhQ1Za6/2VtoKlsuagYwwVT6qRrZZKsF7Q0Uf2X+SObRt5Qv/9ZwZ6IvLQ1Bgg1FuGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNIgX56iYMZRXil4vYlRx81cSS/fW1zfe28v5ogJmQA=;
 b=mpBkhzDS5V9d3iZ+8iSV87AFyQgPVG6TEEf1k7VCTJW8koS0QkIVqqUUzvzmzzaH0rHaY5DQWCoAUGJnioHCGDsDM+aD1vItKJgdGpNWE5UnNJJhKC3qqFpsvKHf0dimTvVYRsZiNcK+ctGCrUu4gdzz4NrCQJrxRXrNOWpe/NqBAR+OadJJioEIwaJ2coB5wmINzToLATRhR+yqUUFykXJAWPFI5u/Givz/yvNsnCRQXpm3qD7qtUGAKnw0jloJtFtZPtlc2oTBSe1gSuvpdN3k+l4ZT504WgGGwDyWIDU1NdksgDUgwBHVTp50TUhUcx7pzI55h9MzUqwzNfK0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 00:04:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 00:04:11 +0000
Date: Wed, 16 Mar 2022 21:04:10 -0300
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220317000410.GU11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com>
 <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
 <17d73d88e08047f09636cf39edd69892@intel.com>
Content-Disposition: inline
In-Reply-To: <17d73d88e08047f09636cf39edd69892@intel.com>
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d907588-7964-4a13-91b6-08da07a9aa72
X-MS-TrafficTypeDiagnostic: BL0PR12MB4866:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4866C148981B2553D5C1BDF2C2129@BL0PR12MB4866.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YO38zTj8M9zjauMJJ212O3LNcHm+D5OUFMMWaBqR04wfiAcww0axRRkB1huZgEVpBxbW/YxUnqpKTeZOnOxjIeBxAFZZ1imDnS+5GZGDLxXCrEdVbzfWujezDnUVsVZPyT1PzoF9/hR8PDalJ7xY6VZCdyWGR2qDhoZiPoSQtCaUQdGeDcH+4XS/v/byaem4cOYtQNoU/9CTpumm4t+U5SlVvNHXKFUd7YOZAVM1SwFOpmnUJJbPOjK+GlsfJOg/7f7PZ6o5MvHXAv6nnB13SRPoVEbGJ502Y/8Qips7HG+ekEn269nWMpmldiqmb9hLtIGSRzopU/r1FYrfGSCbjaH6MfLIX9mmSu8qddz+A5fWbWU3N+W19lQqXkOUAW0Wzojt24QlO8rFEy1v8liP2Bp6QW90gdR1za4RZbE1wbnVvo3fbag4AXCffDte6a0oXNXsxWXWcIjcPmmbkzsAn1CGdgXIPVwHuxU6G8k2csyA02VRvm2639NPgJt+CH0wJ9AOqFOLg3d933emaVsoMhCY4K2Ns8FPlacKVwCNvZG04PjFjYHYfaxYQzi7zDv1Df5dzgNUprzXMtH84yM9E0Dk1bGQXyXq8XEfSIF47iaStLgunn7ZgnLCjiJzFAesslA8gCGSpAhzhT4y7y15w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(8676002)(66946007)(66476007)(66556008)(4326008)(54906003)(6916009)(316002)(86362001)(7416002)(186003)(26005)(1076003)(2616005)(6486002)(508600001)(38100700002)(6512007)(6506007)(4744005)(5660300002)(8936002)(2906002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqKU4jD0hfDZGkh/Ox2r2i1942+79kTMw2flyx76XPorfVsTMTbbMM+igR3E?=
 =?us-ascii?Q?u0hDAs+ASsWKcS8ifyWeEWYhfeiIgzlupvNvi1iRjqmoi9KoIg20MJafdgVD?=
 =?us-ascii?Q?oIbx0IO9HCDfaVwsRRl2aPn5l6CpMblyX3hjuG/52CV1tgEiChqTDa87UF75?=
 =?us-ascii?Q?kho3qB57YPnrOUp110GeOZjXB+kd0RAXtKH3S6f1Z2LQOwZyS8/7et8yFBJW?=
 =?us-ascii?Q?/h9Q2RbtuAPaJPGgT02xLwd0ng4YDJnX994/G3dH4V6arxzMl+FIo6UDpyF/?=
 =?us-ascii?Q?Wmx0KlTDN00kl37G7asGWltoKXPo9BK+3qnYepWIyHpYsg80mCyRUgc29lYi?=
 =?us-ascii?Q?9dch615JwZw9TgQNqjccLf8ER85Ve2vaSo2+uhqyWJTw1OwgPghTDQJatJJm?=
 =?us-ascii?Q?jkOfgu8Y2AF42OUD6YEEqc5EzsVxORM/mGIgP/HeJD28qR8c4ZqeWVm/6lYE?=
 =?us-ascii?Q?OwevKZ9NEtBrZjpa7TjZtg+f5baEMIxtmJIa+7uw9Y+PKx/cYXs750gXGZv7?=
 =?us-ascii?Q?zletdu8AyU4fijuGsrNG2cmkm4lXdF4Zv0Evg73a8M3PucAeQ1UixFPt1C+s?=
 =?us-ascii?Q?JWlTO/tUV8efuXWIf9E5Q6YGOur6No2thpBCWMmnfPruHHVP0UREmgNqL4jd?=
 =?us-ascii?Q?38gonWSYBX7WXAMlplVPNyrgoRYf9Dkq+4hpPbcsQz/tARQcyNGcaFxNjwp7?=
 =?us-ascii?Q?Esz9Wte/oNZDMqeLqloyrEKm8Au+I7NovsLGg9mEnccDVe3ol8gKg1ltN/rs?=
 =?us-ascii?Q?P8Cte0rcmGnKZ8IhuO4onHiiElUo1askLcf+k9rVHfHCpB9d3FOS5bfV8K/8?=
 =?us-ascii?Q?kuht1I9fL+dLMVC6WuYaH74R8fNNuI4tzUj8yozLOdrwVjMbA0n8kQBuhbKj?=
 =?us-ascii?Q?xHTF8m1KxJpArohDO4TVRL3miKMV6BC0I73Y61Lag+jLpGTXwEm9WST/CvCc?=
 =?us-ascii?Q?WCf6nIz81pWveofZrS66jJI/K3r6Wjg45YX9EufpP2zFIspYY0+qVvZQwp39?=
 =?us-ascii?Q?DZJh25BPBPvGDtjD2xQ/X/+XQnacdVxQclwqoRYI6dZ+exjBso+ffoHi45zr?=
 =?us-ascii?Q?vdLQB4KJrCCKDietYChq+06JyOzcv4CjjAIym9NEN9Ics5/RN8on+/XMA7il?=
 =?us-ascii?Q?ffDBkLI/Rt2Mn/bSN9LmP00qwTKkyAiDYAvYtLVd+VEpMg0yDwA9a93VWfWl?=
 =?us-ascii?Q?oIqflIqhj+ANFH3hAaQeSMxK9YWxfuLz0hLul5JCKzad4gERlPOAzki0R6pU?=
 =?us-ascii?Q?WkYaaT6lBCcty0+C1epBa93+D64K7SdEm5ins5Soutrh4Pxi+c128N8XEQgQ?=
 =?us-ascii?Q?4+mNzg+/Had0C6Qqn1Mcv1fnMq9IyzplTvDXETxt/116+9XMACuHr+QYmlYw?=
 =?us-ascii?Q?yS1y6UHO2/Q40rJzZENyD9MNH5z9PA6qhrPrmuaaz130wbEVBsLv34ook8jo?=
 =?us-ascii?Q?ZPAJEz7rd3S86Z9PRWTNG2hWkKNOLKxK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d907588-7964-4a13-91b6-08da07a9aa72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 00:04:11.7628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmZmPOIHW8yQbtW+jsLGD6VyE9ZY38CI3RErsxyc8Rj4HolJb/+hSKraq/tkZmhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Mar 16, 2022 at 10:23:26PM +0000, Luck, Tony wrote:

> Kernel users (ring0) can supply any PASID when they use
> the ENQCMDS instruction. Is that what you mean when you
> say "real applications"?

I'm not talking about ENQCMD at all

I'm saying I don't see much utility to have two PASIDs assigned to the
same device that perform the same IOVA translation.

So I would expect the list of attachments in an iommu_domain to have
exactly one device in it and multiple PASIDs to the same device from
the same iommu_domain is a oddball corner case we don't need to
optimize for, beyond being able to allow it to happen.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
