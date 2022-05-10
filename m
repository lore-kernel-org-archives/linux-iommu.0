Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D1BC4332F
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 11:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6BF78239A;
	Tue, 10 May 2022 11:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnPr-ZgpVBSx; Tue, 10 May 2022 11:23:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF10B81D9F;
	Tue, 10 May 2022 11:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 892CAC0039;
	Tue, 10 May 2022 11:23:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C0AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 563AF4163E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtb9uCSzWrUO for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:23:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D8604161F
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:23:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B03CB81CDA;
 Tue, 10 May 2022 11:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FE9C385C2;
 Tue, 10 May 2022 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652181816;
 bh=5ZJgn0Zghtzaiu2qbpmdNbr1rwDe/IiPV/mYtoG6HA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OW/Ke/sgpzuHPUyRzpms1qOc2XLOIcXoZcZbY2dWEX8ECxIpYNcCh6v/5omvQpb97
 sTdKM2jeHUVartD2XdpvYbOW29XN4joTf1kTBYQIwsr3upSynALi/l82MXrk2Yalgb
 pIu4qYrAobipn8F2FA8Rsshm9vtlEbFtJ/ul6SeMd9GlWlaKJcgLK5hDR96vVtm2Bs
 ivKOZ8fI7xV55CEsvMJ4uymfOqK4k3+G17XSVvfVSNyxzVJFvzxs1jEdNgWQDS+OBg
 SWx3hHs7uf6wtz9fPqHZL6oZ9L9FI7ooPrULOYtT4DLftRW1+/zeAvWR/xCrfmDEa+
 e5n5OMiBvmIIg==
Date: Tue, 10 May 2022 12:23:27 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v7 1/7] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Message-ID: <20220510112326.GA27790@willie-the-truck>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-2-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220407125841.3678-2-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, daniel.thompson@linaro.org, peterz@infradead.org,
 mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
 mike.leach@linaro.org, suzuki.poulose@arm.com, coresight@lists.linaro.org,
 acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
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

On Thu, Apr 07, 2022 at 08:58:35PM +0800, Yicong Yang wrote:
> The DMA operations of HiSilicon PTT device can only work properly with
> identical mappings. So add a quirk for the device to force the domain
> as passthrough.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I still don't like this being part of the SMMU driver, but given that
(a) Robin doesn't seem to agree with the objection and (b) you've been
refreshing the patch series:

Acked-by: Will Deacon <will@kernel.org>

If you do respin, then:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..5ec15ae2a9b1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2839,6 +2839,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>  	}
>  }

It might be worth adding a brief comment here to explain what this device is
and why it needs an identity mapping.

> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> +					 (pdev)->device == 0xa12e)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
