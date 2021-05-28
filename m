Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D76C4708C
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 08:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5C3613D4
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 08:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5C3613D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFCC4606C6;
	Fri, 28 May 2021 08:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6h3DDojLxV7T; Fri, 28 May 2021 08:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F987606A8;
	Fri, 28 May 2021 08:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17C08C000E;
	Fri, 28 May 2021 08:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7BE7C0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 08:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D510840EC7
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 08:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JefwHFqZFm9J for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 08:10:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi
 [62.142.5.109])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 789F540EC4
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 08:10:05 +0000 (UTC)
Received: from darkstar.musicnaut.iki.fi (85-76-82-161-nat.elisa-mobile.fi
 [85.76.82.161]) by fgw22.mail.saunalahti.fi (Halon) with ESMTP
 id 1822b824-bf8c-11eb-88cb-005056bdf889;
 Fri, 28 May 2021 11:10:01 +0300 (EEST)
Date: Fri, 28 May 2021 11:09:58 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 21/26] iommu/arm-smmu-v3: Ratelimit event dump
Message-ID: <20210528080958.GA60351@darkstar.musicnaut.iki.fi>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-22-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-22-jean-philippe@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 will@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
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

Hi,

On Mon, Feb 24, 2020 at 07:23:56PM +0100, Jean-Philippe Brucker wrote:
> When a device or driver misbehaves, it is possible to receive events
> much faster than we can print them out. Ratelimit the printing of
> events.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

> During the SVA tests when the device driver didn't properly stop DMA
> before unbinding, the event queue thread would almost lock-up the server
> with a flood of event 0xa. This patch helped recover from the error.

I was just debugging a similar case, and this patch was required to
prevent system from locking up.

Could you please resend this patch independently from the other patches
in the series, as it seems it's a worthwhile fix and still relevent for
current kernels. Thanks,

A.

> ---
>  drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 28f8583cd47b..6a5987cce03f 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2243,17 +2243,20 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  	struct arm_smmu_device *smmu = dev;
>  	struct arm_smmu_queue *q = &smmu->evtq.q;
>  	struct arm_smmu_ll_queue *llq = &q->llq;
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
>  	u64 evt[EVTQ_ENT_DWORDS];
>  
>  	do {
>  		while (!queue_remove_raw(q, evt)) {
>  			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>  
> -			dev_info(smmu->dev, "event 0x%02x received:\n", id);
> -			for (i = 0; i < ARRAY_SIZE(evt); ++i)
> -				dev_info(smmu->dev, "\t0x%016llx\n",
> -					 (unsigned long long)evt[i]);
> -
> +			if (__ratelimit(&rs)) {
> +				dev_info(smmu->dev, "event 0x%02x received:\n", id);
> +				for (i = 0; i < ARRAY_SIZE(evt); ++i)
> +					dev_info(smmu->dev, "\t0x%016llx\n",
> +						 (unsigned long long)evt[i]);
> +			}
>  		}
>  
>  		/*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
