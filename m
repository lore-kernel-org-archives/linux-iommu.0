Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2610C433ED
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 08:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D19E6124C
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 08:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D19E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4993E401F1;
	Tue, 18 May 2021 08:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id heqlkg-LAooq; Tue, 18 May 2021 08:49:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21C77400D1;
	Tue, 18 May 2021 08:49:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBF4FC000E;
	Tue, 18 May 2021 08:49:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87C6EC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 08:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61C5382FA5
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 08:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5TMZLsQ_TFy for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 08:49:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8567D82E3B
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 08:49:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 76BDB2FA; Tue, 18 May 2021 10:49:38 +0200 (CEST)
Date: Tue, 18 May 2021 10:49:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 2/8] iommu/dma: Introduce generic helper to retrieve
 RMR info
Message-ID: <YKN/ocoHvOdbH43j@8bytes.org>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
 <20210513134550.2117-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513134550.2117-3-shameerali.kolothum.thodi@huawei.com>
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 wanghuiqiang@huawei.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 13, 2021 at 02:45:44PM +0100, Shameer Kolothum wrote:
> +/**
> + * struct iommu_rmr - Reserved Memory Region details per IOMMU
> + * @list: Linked list pointers to hold RMR region info
> + * @base_address: base address of Reserved Memory Region
> + * @length: length of memory region
> + * @sid: associated stream id
> + * @flags: flags that apply to the RMR node
> + */
> +struct iommu_rmr {
> +	struct list_head	list;
> +	phys_addr_t		base_address;
> +	u64			length;
> +	u32			sid;
> +	u32			flags;
> +};
> +
> +/* RMR Remap permitted */
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +

This struct has lots of overlap with 'struct iommu_resv_region'. Any
reason the existing struct can't be used here?

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
