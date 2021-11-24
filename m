Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769C2C433F5
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 17:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E194403AE;
	Wed, 24 Nov 2021 17:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuRWMjmuHXew; Wed, 24 Nov 2021 17:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EEFD8403A4;
	Wed, 24 Nov 2021 17:51:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C378BC001E;
	Wed, 24 Nov 2021 17:51:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B43FC0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40D9C404B5
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0bFubmq2V5vw for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 17:51:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47A12400DA
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:51:16 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id r138so2799542pgr.13
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oTDchkafpOp/46IgeNxQuNHz+bM7M0+5Ox+wOnWqwfQ=;
 b=Qb2R4+I+DtEcOkXq0TYH/CagTNAxs9vdwiKlDdzULoiuVos13Xj0bBoEZSIPlJijzR
 C478wnOgwX2OIroiZLUXmkCPPl7ne/tYZ6BhKk2rJK6CwWNPOkQPdhuayJPTVdRrDcgL
 lYvMSdRGlCmlv6Yx0LePe8p8yv07r0peWf6/ErtsteaCes01s8SNwZ2q+UfiZQEciJ5R
 14+qbgLpmXR5b1sK15zTGPdKVkRwKQ9vgA4LZtRxlhr6dxnNSySqCpZULAsRTj6j4ZuC
 AymmMd7hKuQHEFmtp6YoDZPpoqm3daj0NDEv0m+0NdMYu4USrjQ47MKRLlI/ImkVjBPx
 BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oTDchkafpOp/46IgeNxQuNHz+bM7M0+5Ox+wOnWqwfQ=;
 b=JSciZP2SUZA3Im53bJaJoe178u0waB6W9EXygjK7H7b/EKWrRIpH78A7W5B+E1AnnE
 s/2y0IFG7Cl+V6vtaqFJL8Qet+HOjxGeJd6pQMp7MhioWXpUss37HAyS9+rpwESEKut8
 Q7/GJcda9rqWii9KCAHRqg0WHndhngZ5ic3f/h0D4mFG5QBmXv7h8wJJQPJccH4va3IZ
 VvCWnZBVAoP/Yy3jdhFkZaJCUrm5uMU/QVXOaKIBQFCyoVRsv+F28SFh5lSUnMLBgqu0
 2wINNTGXa8oKevLRuK5jZVry9JLPVUz/c9MJLDgMMlJISc1FpL3by13DYKlDkpoZpC/5
 SADg==
X-Gm-Message-State: AOAM53245lGirSQ/7EYoAXyaqDHooFj7+exJl8Pf4z71bJxSth5nZN0L
 QuEJ9IeDjPIhZBWazaWikMdZMw==
X-Google-Smtp-Source: ABdhPJwuLqZldVSYdI75Ai+PcBDkHa+xkpmfqt3+9vDSJ2R9/PWi5Orovy471RaYzID644RlCM4n+A==
X-Received: by 2002:aa7:9404:0:b0:494:6e78:67cd with SMTP id
 x4-20020aa79404000000b004946e7867cdmr7671622pfo.84.1637776275657; 
 Wed, 24 Nov 2021 09:51:15 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
 by smtp.gmail.com with ESMTPSA id d2sm330981pfu.203.2021.11.24.09.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 09:51:14 -0800 (PST)
Date: Wed, 24 Nov 2021 10:51:11 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 1/6] iommu: Export iommu_{get,put}_resv_regions()
Message-ID: <20211124175111.GA35341@p14s>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-2-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211116090625.53702-2-yangyicong@hisilicon.com>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, will@kernel.org, daniel.thompson@linaro.org,
 helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com, coresight@lists.linaro.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org
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

On Tue, Nov 16, 2021 at 05:06:20PM +0800, Yicong Yang wrote:
> Export iommu_{get,put}_resv_regions() to the modules so that the driver
> can retrieve and use the reserved regions of the device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  include/linux/iommu.h | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dd7863e453a5..e96711eee965 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2792,6 +2792,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  	if (ops && ops->get_resv_regions)
>  		ops->get_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
>  
>  void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  {
> @@ -2800,6 +2801,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  	if (ops && ops->put_resv_regions)
>  		ops->put_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_put_resv_regions);
>  
>  /**
>   * generic_iommu_put_resv_regions - Reserved region driver helper
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d2f3435e7d17..1b7b0f370e28 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -450,8 +450,8 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  			iommu_fault_handler_t handler, void *token);
>  
> -extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
> -extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
> +void iommu_get_resv_regions(struct device *dev, struct list_head *list);
> +void iommu_put_resv_regions(struct device *dev, struct list_head *list);

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  extern void generic_iommu_put_resv_regions(struct device *dev,
>  					   struct list_head *list);
>  extern void iommu_set_default_passthrough(bool cmd_line);
> -- 
> 2.33.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
