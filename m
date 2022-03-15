Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D17C433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 14:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA6183FB8;
	Tue, 15 Mar 2022 14:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE_A_q91SOAj; Tue, 15 Mar 2022 14:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F9798411D;
	Tue, 15 Mar 2022 14:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0BFCC001A;
	Tue, 15 Mar 2022 14:35:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE383C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCF29409E9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plUnlShSZ5xx for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:35:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F00E54021E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcfd7cv9AbedPXWKb+dxawe2DvpPAPTDiz2QfgH0vAjWeQzaup3bzloOxD7Ia2zHobcWcrXS2UFj6Vr98XsN7Jvz7CyewN6mIJBrhfD9UWnVwWMwcIM6ruiN9S/NhQvtgJ6TqZWxGfr5ezvazndOxQH3I8KGLSbXajOx53sCJ7LCkdKUy71qPnVxZXJW5hM6MW7FAtWser+zeGNLZ7nUUVDMo7N2sK4ETS18Gq1NAf/ZBRY7dIrWalMdyejGswglxMg/oWwLeVsJlNTSCw6tNU/GRC9fmdTcxHtk55N3del6vSF3ER5yXqwhGUOXIC1B/+atdWfokWpuOQxqxp2efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8ROBHLn2KH1G0nFwDcDcxwV7QT5yQ9iMPt4Yvfqzok=;
 b=PvEuCgMReIeKgzvJUQcfjKYH3G4PzwKBKiCn/jC3Iva7RYKT7hufEf1n2ubXSr890vQQJY4gvG6TZP97d13YU1OgAgPW6OBFATfPOHexDmH7iLuraCLlDASzaFGuszXYukfXsQ6onjW88N38t53n82BwniUj9hjn0DHDhief1p8WZ64bIAmGg892gcznVVjlUIEvTlonOwa+eMyoHOi02T4y53sCdw/av0wwKKMfXC5+t2RT9mL/hVLQ5YtVq1bLAWsGT0yhXgkWIli2PTfNsz5Bad0AMjXAY2o+sD1LWysMcvaNpk/Rg5sRcoc3xE+YcHS2s+6HAGrCiTVrSY0l6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8ROBHLn2KH1G0nFwDcDcxwV7QT5yQ9iMPt4Yvfqzok=;
 b=FhkbTDgELw3Awn92xyl0da3kgtddXCLpLClQqe1x3Rf0Fc9jWcaWUL28OPgR36vqyaoZvAcUKISa8MB7XBCiPW/deaYwPfSujLLYFoZH7I6kychtDlOsFLBgQnYhYM6qqms4Jpw1UpjvaSsdZffzr9iHiL9qCmNjmaemzqkKjbeuuOjF1w9wNhbOMsGMBuEMf/aeRtWa4OQiAKinzKiF/bAbq+y54bIxMA93Mfij8xA6J9mmwK4HBEC5KAqgRzkOxu1QQbDvttfbXZgoXy6Mg45gyw/x4KWT237vHnAhRg4RyRVCHgS9yPkDU/dSz91Oy9NLCkP5SjAASX8wOgzjLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 14:35:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 14:35:36 +0000
Date: Tue, 15 Mar 2022 11:35:35 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315143535.GX11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca7bb9b-b20e-420c-3a0e-08da069111ce
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB482410300558F85E2DD4E467C2109@CH2PR12MB4824.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPSMtxfPnyC4C5ETGcxwVWdNUfL/HRTw09+TiBkDISvI5kDvnQV1vp7Z1m5tS6CfRiHsHkosNSZZ7ljaN8HSWS37vYhjNOqH3DlyB1LVGvRINN8r6ETLPfqrnpWJrH/555Ha5a61x5RdJa6QBHri/W34KvIts8UciqH3WTKS4A99kBW2/dY72Hzu4QHSGnMCO3XSYeXbapZSVqSVqAio9TyM65vR1fvPxivYfxPqLPP3qsqziYgk4oZAqeIt2uCDsrfGDvq6w4UQxKuP6mkwmVjyq2BGrDSq+8sK6Q0CebbtUMbH9YZdGiblKRsHBGwFnQcYpn4+l9pXRaCRGIzOwvEwQj2xLN+AcITEXtGMHg5C5O3L9wITt/lFd4+ODdL7d476TWeZ2J/dMt85anuEY6MHlotaZHmdCa+M2MFJqum8VHnEZ4weneRj/1yVAI7CK+xAoOIZnCr5BN7QQ+CoLGh7h68VlEqGe1oLos1rA6T+WuFu5rH+zMX5OlSUYkg6izeKDlql7DYv5QoIZuGWe34fei/b9dJls70Xk1eE/QYk+Yorqyhx7QtKoplZFWf01LSVoA1z1UJZs+Gt99U3rRuHlHfTlLJzPbLdSF5cFpMTUr1fYU28F/VDVGbmK6sCNrw370HMXKW3hWar6/JAYIzcjvV7eGWFrEMk9WRxkfIpCNiZhqUmxMtfiyI24B9jUtJlNmMHGfQbEeiZomLAAj8AEspQlpKBgDcAJw2EYQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7416002)(36756003)(66476007)(66946007)(4326008)(8676002)(5660300002)(66556008)(6916009)(33656002)(54906003)(83380400001)(316002)(8936002)(2616005)(6512007)(86362001)(26005)(186003)(508600001)(6486002)(6506007)(2906002)(1076003)(38100700002)(26730200005)(19860200003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMR79ECQybKv1yK0PZLUHuFOpn2Hddm6+RWvLSUMUCSVk443gwJbQPs03XbO?=
 =?us-ascii?Q?NNAoyPP8+ZcJBh/VPxKcwkvHw+jqan2Zh5c8IgrCYs8gudfAVGq9KtutOSw5?=
 =?us-ascii?Q?x91ZJIwocf4M+cma94T324aDOZo0P0P0ca1tDzOdfe+cuZNCFf+V8NAfTgaO?=
 =?us-ascii?Q?PpBmX9b43xv3cGor8aYUmRd7o5xEJkp0cU//7VHXsGcO5vhR2vTEqHgE+BIC?=
 =?us-ascii?Q?+2FyRFXMipYkw/PzLcQWpNEfLKWGNO24ZVbK6pqWaJ5A9rDVF2/vagQcuXlZ?=
 =?us-ascii?Q?Xd7fLUN44C93g4yMO3LnO+XtHPrws8kucMaKcnV6Mt6KGwngTCO+VpSQi77Y?=
 =?us-ascii?Q?rv2scccl9wqVNBZ+EXpetbTRyHDMuiQyXUMUssFXERxu/H8QH6fLjJP9ruhk?=
 =?us-ascii?Q?peO1OV7MD3JuaBtmdTYHnSaumHw2OmRLmqeewuoPKW4bXtL+Svueu8IE1YZ3?=
 =?us-ascii?Q?Awhkj72VyTs8Ah9F+Lqxpd7dEAzWP2eDBHkavpy36VeuLuI5qhBL71WFftRc?=
 =?us-ascii?Q?utk+plE+xGG9TbbsRzZjKh1g6+bXlJJNHBZJuwTYMHhxQJYfYCkAme0nv79A?=
 =?us-ascii?Q?w/FXpnWeMxj6Zw7iw1+2vawOaZwnR7Bh7nm4eo30rMWp3AQTHnq35XBpxm32?=
 =?us-ascii?Q?ExXg48EFwL0C5TUIg/sSweef6fOcYWlNpYfi/xA/Q2mLe6GL6EAIv5t4mBPG?=
 =?us-ascii?Q?CsW5htu8iM+56H+JvkHNeRh7YNpTA/7GfBddt3YDQDEhgnM4ZTRSt6D2hF+K?=
 =?us-ascii?Q?nb1ZLfC/n9PjY1p7D+qg+Xmjn7Be9NJtaCbEX6QmZc7u7FW+3vEXWNtzqfwp?=
 =?us-ascii?Q?7H7ZmhKdn575nVDQwBJjRQ9QsH6BzkN9WTHzl5eBnSU6+ibYO+ylsWEZocnX?=
 =?us-ascii?Q?X+yHvwKlH7/qskSvYa45beyN54acunDtKisqEJGQ0vzfO2dCYsTppFSYATKH?=
 =?us-ascii?Q?Yn+osUgVrkC7C7YPAoAwHGaAB8ZhP2/vNXq/9ycB4PT4wQKxlin4smwBEC1P?=
 =?us-ascii?Q?I2KPlYsnUnjh6dsxJqUUGQ1RTQNaZWO9vkB4z8SiHcZB4Syu1fRgxr9tnuGi?=
 =?us-ascii?Q?H6uxf/JkRaw9GpFr4D2kHgtrxzHrLzyC02RwkwY/k4/o6H42NbOLIJdAo3IR?=
 =?us-ascii?Q?F8UODB0w+6uWSmF2I3u7QW2il1qFEYLn32fmWf9wECDrIzJtKicG73ZA6n8b?=
 =?us-ascii?Q?qmKOzVdSrTFlbdhW1s72PTd7xEFsPycDSATYvhoj/8kXhyhFYdEZuVzWkQV5?=
 =?us-ascii?Q?a9NLOSbUMdXiNt+zeXNOqSjz1+Rkj2Hx/7tqQicMZ25Mh7AcF8kUiPLw99pz?=
 =?us-ascii?Q?v6E/dJIdxFXB6pk8v85cEiC3myZsqWz+q0ofaQi54NNq3wY2cPdijIYwRV+a?=
 =?us-ascii?Q?Iww9xtU18OMHC3qSm/sVUj1wL7IHDAkpp/A69OkEoFSjuZS5Q84qP/x7KpZb?=
 =?us-ascii?Q?kQuaQ7QEK25FWC7DqnwFoqhuvP9J0S21?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7bb9b-b20e-420c-3a0e-08da069111ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:35:36.6973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgx8Uind7fqolXKtE+6rN5Kd3gheNck3Perbb9YggTA2R8xUYeHctLl9222hukF6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4824
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Mon, Mar 14, 2022 at 10:07:09PM -0700, Jacob Pan wrote:
> DMA mapping API is the de facto standard for in-kernel DMA. It operates
> on a per device/RID basis which is not PASID-aware.
> 
> Some modern devices such as Intel Data Streaming Accelerator, PASID is
> required for certain work submissions. To allow such devices use DMA
> mapping API, we need the following functionalities:
> 1. Provide device a way to retrieve a PASID for work submission within
> the kernel
> 2. Enable the kernel PASID on the IOMMU for the device
> 3. Attach the kernel PASID to the device's default DMA domain, let it
> be IOVA or physical address in case of pass-through.
> 
> This patch introduces a driver facing API that enables DMA API
> PASID usage. Once enabled, device drivers can continue to use DMA APIs as
> is. There is no difference in dma_handle between without PASID and with
> PASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>  drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  7 +++++
>  include/linux/iommu.h     |  9 ++++++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b22034975301..d0ff1a34b1b6 100644
> +++ b/drivers/iommu/dma-iommu.c
> @@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
>  	IOMMU_DMA_MSI_COOKIE,
>  };
>  
> +static DECLARE_IOASID_SET(iommu_dma_pasid);
> +
>  struct iommu_dma_cookie {
>  	enum iommu_dma_cookie_type	type;
>  	union {
> @@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  	domain->iova_cookie = NULL;
>  }
>  
> +/**
> + * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
> + * @dev:	Device to be enabled
> + *
> + * DMA request with PASID will be mapped the same way as the legacy DMA.
> + * If the device is in pass-through, PASID will also pass-through. If the
> + * device is in IOVA map, the supervisor PASID will point to the same IOVA
> + * page table.
> + *
> + * @return the kernel PASID to be used for DMA or INVALID_IOASID on failure
> + */
> +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> +{
> +	struct iommu_domain *dom;
> +	ioasid_t id, max;
> +	int ret;
> +
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> +		return -ENODEV;

Given the purpose of this API I think it should assert that the device
has the DMA API in-use using the machinery from the other series.

ie this should not be used to clone non-DMA API iommu_domains..

> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 24607dc3c2ac..e6cb9b52a420 100644
> +++ b/include/linux/dma-iommu.h
> @@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>  
> +/*
> + * For devices that can do DMA request with PASID, setup a system PASID.
> + * Address modes (IOVA, PA) are selected by the platform code.
> + */
> +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
> +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);

The functions already have a kdoc, don't need two..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
