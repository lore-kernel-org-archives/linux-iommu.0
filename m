Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC7EC433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8904408C1;
	Mon, 21 Mar 2022 11:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JADvLgLnraj; Mon, 21 Mar 2022 11:47:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79372408B0;
	Mon, 21 Mar 2022 11:47:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E03FC001A;
	Mon, 21 Mar 2022 11:47:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21153C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E68660AC2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01b7Y1uiwV_u for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:47:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B221460AA3
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJuQfi4+Wlt4/o9JOtJde9AUhmwebq6OdTVaYEyHkieCJACHFFFJ0NowBMQQV+K60dCKmckOnysnU875APaVjV/hYNxINd3eyARWB4UWp3NIMXubOCOEVZX9ne4gCSEUsVsQKjsMxLM7o0Ec0lMzLYNoP4RKi8sp3GkfYx61pWjKpC+wJUWgAZCljZeaTyZplG0lzldmKHurfG0A1FOFTbHa4lsjOJpAfFzRgqCMZ09Oroo7gNlNje6swXr3yOqHf4JtuAWsXAMN6NsJB62Xs0ZI//8nCLDO1zksmsZldRpqcjSzwAjDbWqKVWQFycYfJzNRshsRH2LXAK39d1sf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W07knZePk0LVmQIDAJ+2Ng3S73tAZk5nVvA/5dJvek4=;
 b=Nyzd2/+SFCYXTaPZWCJnnZvkYdXE734SfJ5hBc2RrUQHKWWXQXarXNJWx43iCVoHePO4I3FfMrkfPBpcwXiahNbNB7V3XG33jmyiuTCcQCZzBehGehJH0p5R16lhJIBFS1v5aOgW22IKx2MbFsBuXAiSmC9u3AfSxmqmq+4z1rZpYAV8R+V/+x72YmWmWzwluxDcRfYoIIRNZW2stwolVLG2mi8kPUlGpSEf23vzNzJ7oFQVz53E9U9rcZdZqGU9hzzYoIb9P6CN0nQ/f3UEwGzKdxZnP0gETnv9JQ9/A5fUUsuDokUH87jPmX85U4CvquAJ35b5+Z1HJvR88xMqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W07knZePk0LVmQIDAJ+2Ng3S73tAZk5nVvA/5dJvek4=;
 b=daWH0Y72W9xL4IUIwuzKMYYLoL2/w1vXUSghGW35Iv8KSPpHaqx0gsJ+E2nuEzb7EywpmcbF/5NWkT7MzDdnRft9JyRqcGI5spjjFQzTooMeKJdjg8e8qtm6d2+O5EsLDBGd4xUePQLtbn3RAO9QMlC9JuTJM8yFApssXg+5rMNGXD90Rd9SMTCwSUyDmSU385cEHTX+IL0NdvRFiPfkzgCEQ5L3S76zEx3Hp0ctTnKN5rMu07651PqH8U4IgiA8sIe/V8S6nSZjwmu8w0+UJezVOxTq8coOqsG6bXEzpgZiOmBincRC6UH7q87b5Uuxz7ll6Yr9gBLdMkJ7weo6Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3806.namprd12.prod.outlook.com (2603:10b6:208:169::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 11:47:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 11:47:46 +0000
Date: Mon, 21 Mar 2022 08:47:45 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Message-ID: <20220321114745.GI11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8239625-7501-41d9-2c8d-08da0b309de0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3806:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB380698138B58BC5901BEDC5EC2169@MN2PR12MB3806.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sirm9SOVHt3qngXnNgmao24nWFhmbBc9uX672XWg7h0qM8aqGG/C34kFDiXVwwKUTU90kLesO5Ju2jbjCUwIW27HsUQKlZRiZKVpsUBViBNeAx2IzAUHeicPpMVwUy/h7dBBuvb2vIx/eaqF8JBvTP0OZ0e8qaVK9DewG02j9f62PoKKMwwVUE/teqz3FXvFzX38XCeYhlb1n9pm6tJ23Y35pTrCbGNLmzY8MHRoCdSxd7bEyWS07zaqFxIXuyaIBfM38Q99nxB8453fc54fjwRe0PDaeuXLPUxgpIlQm+Kdfujy1Px0KhgU+2pcMmxaOh5KO9fO7ObXsTYHB6OOc264sehngHLpA2iy4pl9c401ymAqHYEgccEaRcSQOxkK9u72+zkKyOx6P7WPxh0imYuveMqofGAr73GP3t+QtP3iiA+ywfzqQl8r6ZEI1vlHOETEC0TBzRfJ+gJCkDWA4bxsTHFLHYmIV5OmuvcR2v7QB+qMtRCxA29m3UHL6tfXY8smeIH6Z6e3Zw1nDnJi5jDpy/QIkdzPQQnUBT7EhcU+g9OKm9cwrWXV7szGqORaovbMD2+LJR7cxY1k2m2h7/+SmJrD/MkJWakXvM7x9nt/5ST1f4wDCN/GPLE4Bg3SZYPfHE2hCjkBEWJsrN7+hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(4326008)(6916009)(54906003)(66556008)(66476007)(6512007)(2906002)(5660300002)(33656002)(66946007)(7416002)(8676002)(36756003)(316002)(86362001)(508600001)(6486002)(38100700002)(1076003)(8936002)(2616005)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oleunx/Q/sNli0jdN4wbM2DXVunmbKF6aaameW/Xb7Uno1gGVpyv3kmOKDRx?=
 =?us-ascii?Q?+c6QzHqtBpBdayu/WrOnc2OyhtB+2ruKkzQdAWs4qmWTRzKoN1ghNQ+cJz7T?=
 =?us-ascii?Q?kt+qdZP901yj1YdShJAGrdf7TkcFfs5QX9xg+jC4QDtRUSeUtTEftHcbeEUK?=
 =?us-ascii?Q?Keiv/m40cQhKIqpbAwFJISdjZ4H/INKAAijCa37W1Hglnl8ZLq2a6jVD/kkK?=
 =?us-ascii?Q?DWf9pFcJeJFbFehYv0MvzK1id1cJR4eQIS8hKF12kvlAAowkTCyi1oj+HoMX?=
 =?us-ascii?Q?q/6j9rQhUSA7thOpks4Bp9Bx4tJzBB0qS69T0KuOiIBSocf7TdIsOL4B9jzv?=
 =?us-ascii?Q?Ms4JS0qYDvSyirl+Z53yqAW4WTW1eamhL/HqfskbJKy5hMpXm0F1KcaEhTbf?=
 =?us-ascii?Q?oIUw29pnRr1sJ6BA8pFRemjmyARlA3I1i9Bgai4WvdmY9pRz4UUrj0OgmOGj?=
 =?us-ascii?Q?U3KMmp8/WsVgy9D7bulEepR/ye92X3cMwg1s0RkAMqdT5qzr0RiXHvm2R7mM?=
 =?us-ascii?Q?hBe74/ZJm05C9HjU3Umqjj1w+RKBH8wH6HdWGZlGlDoCHc0jPCkaNWg40Amw?=
 =?us-ascii?Q?Jol8cZKT0kNdCRXlxKz3tJTSYD+8c4cUpUoEbu5w1udeYdMtxCpOXEeW0UI7?=
 =?us-ascii?Q?BOWdtCW0YCbhUsmeY/3gHJMMr3OkKwQUIE5lzYAAVAxQBIJ8D4wYhqZEn2B1?=
 =?us-ascii?Q?OnYwrlpP/lAANGtl4SEPlBshHqdvgor0D0ftnhJP3UVXHvvvVtudmj8VWIJs?=
 =?us-ascii?Q?7p70CXAy8d0Z0+w0cd7nr2YsVG1yjXcY0Qxl8SHnRa0QNSqT7EtoZGKkeNUX?=
 =?us-ascii?Q?CscAkmETsgzDtfL4246YKzKq8O6dwWT9nPXdUikLr9xfnti7FbWRfWx/qBhu?=
 =?us-ascii?Q?MvImNT1LDmdoqrzlbeCzN5iAnuX3w7GcuAP3aKCQgyP8DMC+xMmd2eqM8mEb?=
 =?us-ascii?Q?n4ZDCjAPYNM7lRhTBwuA0z9qJsg2KwVjpJLLeWbOf2FHXWj/aXX85ai0V+rp?=
 =?us-ascii?Q?6QGQYKJxHipcz4K4O2DmLlrraHQrZSp4piUz5gCuUcjEtSGD+CjMkZwaigrV?=
 =?us-ascii?Q?3X+Qhk9mebo+qI1iYNgaBpB9pJehExUPVtkB5aWko9m8D9c4DRCQW7o9+0Ft?=
 =?us-ascii?Q?V5OCfM6k3pwZG8Co24rm6/sShJQu8/W9BxPkQXfPnVZ41DikDAm0kuyjItsb?=
 =?us-ascii?Q?XgYnmwC2iXKC5tpRre0Z/1sMkdFANOxx9Xg6HHDm5dAHNty2YlD3cVAIgZIj?=
 =?us-ascii?Q?E8Qmbdjno3fxQ/eIgzq26z+wniN6IRWR9rzDJwZpdsmB4IcRJX3tZ3rGnewA?=
 =?us-ascii?Q?KYa0vuP3sHNFwqqnh3ksND5nbNCY/RjwLROZys8bKeHr7BOQxZDIudCCg9N9?=
 =?us-ascii?Q?oC2+I62xUxhUAg/FbKeRfaF0wcFvuzxVtDgTsA5g7Ef1glT/rDpEXjl/tPpT?=
 =?us-ascii?Q?iIRIMHh5wQ9hrp9qBeABHlOlPXz4nfs/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8239625-7501-41d9-2c8d-08da0b309de0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:47:46.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJterOGFqvdGEe0FGNT/lWfzqV/gAkgu/FJispyt2twnyret2IGKU5WCnn+8c219
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3806
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Sun, Mar 20, 2022 at 02:40:21PM +0800, Lu Baolu wrote:
> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O page
> table which is shared from CPU host VA. Add a sva_cookie field in the
> iommu_domain structure to save the mm_struct which represent the CPU
> memory page table.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36f43af0af53..3e179b853380 100644
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)

Is there any use for this in the core code? I feel like flags should
only be created if the core code needs to test them in some way.

> @@ -95,6 +100,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	struct mm_struct *sva_cookie;

Don't call a mm_struct a cookie please

And why do we need this in core code?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
