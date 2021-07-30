Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD8C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B70060F5C
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B70060F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 177E0605F6;
	Fri, 30 Jul 2021 09:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UQoSdRNWhNR7; Fri, 30 Jul 2021 09:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA6EA60671;
	Fri, 30 Jul 2021 09:32:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0095C001A;
	Fri, 30 Jul 2021 09:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40702C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20C0640686
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U8pFruzYqm7U for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:32:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16A2C40685
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:32:24 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id qk33so15615786ejc.12
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jXZmAj10YMwUuMQVsNud4Tjz/SN+TYKnCKl9JrvXlTs=;
 b=Ge8bGdXL7p43tS8UZ/M9cht7Pac8eSIv1YeU9Cgs/fe734gtfYaD+dzzM+tGKTwAXD
 2vEt9rFv+3hFvIfILimXdyVg0X7rAZLwSV0aXVXeeq7Iy83xcvqJst5FM2VrpDvc+TTy
 bCjaQldsrKFyLFE5qwLU/qebZwG3N22cnNm9Cbvt+8xMNKxqvWMXvzhG1Q8qXzozTJKQ
 6eNGHWJceAy0/9uMPenRhxWE8JalloYsKTHdoMF1jxOKZzwXljncjt+IVbDniWcPGe+4
 s8QPV3p5Aim4ntUteJGR9nfFeyWC0Kkvv8zRC/rHSkmk6UuKQjeOTp5ChYVNLeY0X0l4
 3TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jXZmAj10YMwUuMQVsNud4Tjz/SN+TYKnCKl9JrvXlTs=;
 b=Xc17DFq+ViML20NLFqchmPXp7Lt1nFT5SNcOFH6FpAJd8TBQFuitluPTc63mlPFPtV
 MEjHc+uvFHCaLTR0fePqW/y0obYsv2Ca9HPZ77Qnvq5iriqFRShScVoJXmqgoN9267KY
 sggPwfCG4a8wxLaJyrFDllLiZNO4NuBZ/8t/tSXIqeGSNYTL1LCxZFAF+MR9CQTa/F0T
 iqd4V19v7Kp+KzB9L/Xp/HZzHN8brFAbZHorFhGlkHfPNOTJPisae+latGG5BK+1YSCC
 BX10+FeS5CqKFO+iXm6pt9M6bKXdry+ff2G5/0XZyg0LeFno3ClfpjQLAYf0xY2y7CNM
 fRbA==
X-Gm-Message-State: AOAM530y/OxxS+MdtAr7SUUOkFBK1cgMLE8YKG92eHoiBBh2Lj0uVA93
 hCr383pGy289GBpEek7yAe9aLQ==
X-Google-Smtp-Source: ABdhPJz2wmY/H4t/1qZqsTeLCI1roKsM30OsGoE5ghmW5W6XCOsgW22Tu/F3Y6tz5gBO8MV5MCIa+w==
X-Received: by 2002:a17:906:1685:: with SMTP id
 s5mr1667118ejd.370.1627637543289; 
 Fri, 30 Jul 2021 02:32:23 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id j22sm365079ejt.11.2021.07.30.02.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:32:22 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:32:02 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 01/24] iommu: Pull IOVA cookie management into the core
Message-ID: <YQPHEpWLN3lZ92fp@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, dianders@chromium.org,
 iommu@lists.linux-foundation.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 28, 2021 at 04:58:22PM +0100, Robin Murphy wrote:
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/iommu.c | 7 +++++++
>  include/linux/iommu.h | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..ea5a9ea8d431 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)    "iommu: " fmt
>  
>  #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/bits.h>
>  #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	/* Assume all sizes by default; the driver may override this later */
>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>  
> +	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>  	return domain;
>  }
>  
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>  
>  void iommu_domain_free(struct iommu_domain *domain)
>  {
> +	iommu_put_dma_cookie(domain);
>  	domain->ops->domain_free(domain);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>  struct notifier_block;
>  struct iommu_sva;
>  struct iommu_fault_event;
> +struct iommu_dma_cookie;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>  };
>  
>  enum iommu_cap {
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
