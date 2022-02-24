Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C56C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 12:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E2D76102F;
	Thu, 24 Feb 2022 12:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYf9LUCAUXXS; Thu, 24 Feb 2022 12:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDC4B60A7E;
	Thu, 24 Feb 2022 12:59:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7116C001A;
	Thu, 24 Feb 2022 12:59:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CBD9C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BC5B4046D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDbr5C5HjDJc for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 12:59:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0B1840122
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ron9I8gujXTV0HnQUWXwIqEXledWKJdxCE02GD/tPyvvP3TKepjaeOb//tTa6d0ctpz+oqgE2ikItsYG1fBu14eDzpNrEvfXvbJM08FUoD8WJU0AiC7nblSliL9DzhICShKJpFLtkz34g0xVtiRut4TC0WWV2DYkQLr9+nHC1WA18tWJwh0tNqNtlFE6JJCOc4X6wKIomxTdRZ8RAMPpd+cCCri06ATKB9ydeB30heffn6lV32/Ntb9TJfu+n2HKguN1cTdASN2fISHY4Ra2ZYNmbANzpNXdYJdTNjUm2B5d+++TDns/iYkfa9BDTDcOungfdzD5NKrWdRqOB1Ekvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zgPhtEEJiceI/185Mul5fSXxUrPUEd0DZva/V8G11I=;
 b=jPpIk5nNA1a+mXn1JLKEh1C+qDNexG5MVknXNmXvPUy1y09g+y6PnJkOMkDSVFKGvn59VJqSzlh71fU+h+XgDr6y8OjzFf00QS9E2sMzSRbsGF1+gTvpyvXFAH30zSVVXcSE6OOZraSkA0BGwHKasDErN++IokOKFIWUJRKaLoo6uPNwAQvP6ss3iqLtJRj1DwcFVuUi3g1qkBhrypvBK0sSylDtcJB8TvkB6DfRHiUokG9XtqvOVDQh1cyDWcVSOUIi0jCbVVJHSLXNH8pAvBknSn7vlWqJ6qM+4KrgMmSVyW1DVOTpXoimc89y+y4sFQxPBh6ux7XH9N0D5Lc8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zgPhtEEJiceI/185Mul5fSXxUrPUEd0DZva/V8G11I=;
 b=Ls1j06rIXPsVIanqRq89QJQhNfxlR/qm4gFkW1ODJUcQ/SI0rB1SlIaHJv8OTs+lDPUpyUKoXZB+FQOK+SBycbbpsqlJaFUx6lwtqWWHOfNJJ3X6zkdsgR5W0RJOcaDD9Sdps4gRUdix+eWf73zhL6yaqb8Zd90Yr3KkWp1n/XKcl3jpSO6g0HAwNwcZxVKaOgvogRYUoEzsBYS7TeYDXdW7YnwAaA2AnN1AzF6txF+NKtM9nBUXJYS8rDD9SPWdiWYWW2xmewXULj55AZhjF8G4JOxmVHFGw88+dSxuzqFIf203/x2mS10sVPZXqQNf8CebuNOey+wKU9/pwqn0TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 12:59:46 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 12:59:46 +0000
Date: Thu, 24 Feb 2022 08:59:45 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/11] iommu/vt-d: Remove finding domain in
 dmar_insert_one_dev_info()
Message-ID: <20220224125945.GE6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-3-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5481bd1b-0d0d-4038-9048-08d9f79588c9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3250FD1A5F3C02DB5F592154C23D9@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eOgDiy5//1/AkUHMzAxioHmyTNt5rhlZoH/deqkQTlD92KbEsbv/+RFjmZi1cJp9QyiBE6H0fWnU7vkDdQ04lub7+rxdrbvmkjBkgcZh0LKrScL4W41CJu0k0ngho/gNfh6q6sC9UTi0+yKazhJy11oRi6RKKFZW13i7u/6+ZT54aVmklGz3QhdfDFdMHaIizB/LRaszgLbQeXZv3Xh147rsdCZk17MTM1qlSetWGLg2XbUoBV/M8u0lsucjM0r2PgwVCyZADQPJotqM9o4f8BQFxUSaWIpKtZpEjuJoEYCvQXySTC82+zRmqf4ZMoMgxNQoIuvotVF2v20yrj95wZ8MthK9sKkNSDy6FHTGosPir9jHOPWdpK+3rKxCXzh/eFNX4Un+ANk093EoscUzevso/v66S5aNrO/V4kO4Sf7zk9Y2E3EIIqRcAaouo/1N0/dMSzUTEnzdaqVx0SJHyL/7v+atSglsMyUY9Sa5oSysss0JunIWMHHgTjRk+1mm18u+ne1K//JmLIDq6LMDuP0SBi/+qK4JesYnbLf0FmNVwNHN2nYzmEE5leVFcq1pY26t8tjr8NglmL9R/B4YTBuR1fUbFDR5MkNoIKZSK7LlbZxLy0C3PXLigY4n3xx1/b2WXf4qg+M2kYbODtL7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(83380400001)(5660300002)(6506007)(33656002)(186003)(4744005)(26005)(86362001)(7416002)(1076003)(6512007)(54906003)(38100700002)(6486002)(6916009)(2616005)(2906002)(508600001)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GIYXeU5rYnL4kYKkCwVBJlaL3VhA8vhE2XWfbaQwQKsRWQzKOOg38VWzDDHO?=
 =?us-ascii?Q?MWal6WG+dqvRW3gJ2vBPxRnoAsfkV/+dRUrC5/GF2f81FdQRT+G/xJOlw3u0?=
 =?us-ascii?Q?6PHRC0gRXKs5ejVo4eqnIufJ8JDFUtRjx44FNswwmGb8SQYwIgthCLIwJ8Y/?=
 =?us-ascii?Q?y8AR5qhjQr8u2lcyZ4hdSjORusMui7JMn/M/vTfbH1Mf6lGSnan8JH9X9qDJ?=
 =?us-ascii?Q?dkcxg1fHq33q9nssoSebwmtnPmJExWf7CRQH4WKGPpOyg+gHW7mMv2jiZTOe?=
 =?us-ascii?Q?aFVAdUbXtLmIYvHiJTO9ijOkkQEHxoTWAfU44EuQZSHoev8Pda3+9Cg9xZzh?=
 =?us-ascii?Q?puff4UlTVeSePCvd2nPPsKUWaCSPPbFaz+Y7crwoB50EIBQmtF70eARmbv0A?=
 =?us-ascii?Q?iNlD5WwsNYwUAyJKzGxCT4HV1aryOJChNAo2AGhr5Gel+VjCo5McX5y4N6Vl?=
 =?us-ascii?Q?S8F3v4cngtIeMw62LTgf4U4YidYoLuUuu1bWhNKAVV0h8nV+sFRei2FkqF8J?=
 =?us-ascii?Q?IpMB4zI+eljkQiECJ50NvAQsIs4cdG5jUD4aBO4Jv+0wWZoWAcaSjE6Fa7Oo?=
 =?us-ascii?Q?wr7Bctasf1Xfdp+0XpT8Kv+9wk5SHSQ/fQXk53Ort7c5R7qE1MaMF2iTJ0Aa?=
 =?us-ascii?Q?mwog5Hi8HcdN2be8wUecYUk+GrNWVEbJz4i0OZqqF/cylUhe93FNiYSq4u21?=
 =?us-ascii?Q?oM9ytFBEmxgXt+TvQZL3uBpBQ+/RsKnOuhCAdKs4SGBCUV2q0PQXpDaIq+WC?=
 =?us-ascii?Q?/TQhwlibRvWplL72puvkPWopOc9vMlWj7C9WUDq/wogJ6sMO8AsuhRTaSA/b?=
 =?us-ascii?Q?gXOYBCzSRSQhOCPFX6Va5co0X/e/AeoYx9UBKEEdBn+ybVo/VkE5CW5VGGhF?=
 =?us-ascii?Q?dxYhzyU67icDrdI4rWX1EposfExgcjzEtTZYtl8Cq77n40rs/G8M8miPTnKv?=
 =?us-ascii?Q?JHpI57SiKn5kRNKE1O/IWLxMtz9y9zKsJyYzMghIyXQBpzNqUwbc399wcdPA?=
 =?us-ascii?Q?0BEbM+hesYQ9P5hMJnwydrx10n8zsD1zAjksSOieOWVojksNjSVM1nX5Ftwx?=
 =?us-ascii?Q?gvBNkSt3VLpOkblCk0GNOYcSueFwzzhLQ6f197w4q6DQeDDrZupLW4Kpk/li?=
 =?us-ascii?Q?plLh/VfvPVsi60g5JdWoAHf5q0ZvVnRPbf79P5NK0RcafehEeKIoUo5Bub/m?=
 =?us-ascii?Q?wfvHevYa1ypPQasGarU2YvELGNqRxDm/YpwBSxRrftIQu8VVHroIk8FHljFK?=
 =?us-ascii?Q?cZeKG7jJSouCOIsSDvONr0JBauL1lZP5JkQ4KXYCsT88SUJS/roXvYycdu/n?=
 =?us-ascii?Q?0hZgiF2rieHI7/Z4erA4X5M4BaRME/ROXcLZQK+BCIfKVm/zHQK7Gwd8Jcda?=
 =?us-ascii?Q?etIRdnAejXuSuohBQzXRCRytW9ylvlGwuQ1JMSy+ANfpmniJ4LAg4eDEkopi?=
 =?us-ascii?Q?oyTe3fGPzc53G8DkdPFlz15vo9G0Pjbi3LWkaV+S9mLjngZXuE0EhHoGlw2p?=
 =?us-ascii?Q?DByGK0SRAnkeUa7850fqi5XO4RDVhmesf1oaH082GpAOPF3lMXJeGtlKaD0/?=
 =?us-ascii?Q?aITech8+xD7sdSDnOZM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5481bd1b-0d0d-4038-9048-08d9f79588c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 12:59:46.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MiScTFpKOzrqEpFBzHi24vXukiNr92/ySwOL9qVsY1UlvEdw404+NGCzoHlbRcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Feb 14, 2022 at 10:56:55AM +0800, Lu Baolu wrote:
> The Intel IOMMU driver has already converted to use default domain
> framework in iommu core. There's no need to find a domain for the
> device in the domain attaching path. Cleanup that code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/intel/iommu.c | 21 ---------------------
>  1 file changed, 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
