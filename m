Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E7C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:23:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9803661019
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9803661019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59C8F40675;
	Fri, 30 Jul 2021 09:23:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zw3tedYSbdTe; Fri, 30 Jul 2021 09:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1716D40673;
	Fri, 30 Jul 2021 09:23:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7587C001A;
	Fri, 30 Jul 2021 09:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 294F3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA5F6605F0
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ut4Wc2BIP_ZU for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:23:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5F2F605C1
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:23:54 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id nd39so15662423ejc.5
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tIXbRWKq/HQmFBOdGZTzkl5HeUujMUi2hLQdEOwR0u4=;
 b=esn5HBbLaOhJyIi7lkzeS9GlpFThHxHEyTJVL35YeFv8sISxKfpRQJiAmg5G6TOyAO
 ocjzm9TeZIeNnawd8T24+SE6OBWPoAEljgz95pYy9slXdVWbOpOvrPM5D61MO3FXBBRc
 lPqV0hvtzb0aozwPI9wSa5HxJ50oQU7nKv9BLkK0Q0vHjAyVcT+MSiwjSG5NxYyyliw2
 9BTpZyCnAttWoaXXosIXvvppJ+kCtlXryaLLurzg0Du8fikzBAf36O6/HMj/4S3s9cL1
 mvbZd4sI5Q7S6hMFeNHTYmiGQqYf+/fE8DHWpgC++4YAvGFeh8tLjV0k0zDncMLa2QMX
 q4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tIXbRWKq/HQmFBOdGZTzkl5HeUujMUi2hLQdEOwR0u4=;
 b=AlMNUNHovkM9j9hUpQUZiX2afoeclXHz0nxUUPABEjyNf6B+pzR6QupNn1lIc2Osch
 ZyvFFSV2ZPa1d+nsRvOIT6B19robKK3itTDJLsOMqiD/nmnwJH44I3HgdqZnO47x9d9Q
 v0kD6/zehL0zh9q9WQbeL7Mqa0drOHTT0+panPjzdvWV4yoc+C6qLuM2b2BdU0sEelSF
 9Mg3IG/AMdnLortNOwLlzBadoHwYfeV9reAxYWjYxlReuLwzdOJnbQlBg2bonHw3V8KU
 W5C/IYHzlF9OBNqvCqvcak9ae/ArHu/HHJ0n7Tcg6HU1i/yHN9/md+w9dgCCucWttqFP
 sSJA==
X-Gm-Message-State: AOAM530NnqaEYzRkXoebs1Eln7sZZZgDg+GsTmjANxiOK3z+WdmBjJ0U
 n8dLPVUM79hmdrIKKHWaQNektg==
X-Google-Smtp-Source: ABdhPJynsCHmX81/7BzyCdDUBvueFL3Lg7KUrCN/UbxNdRr1Y+fMWhOHzIlvS1iHz3WiQRGTjywO9g==
X-Received: by 2002:a17:907:9871:: with SMTP id
 ko17mr1655599ejc.179.1627637033019; 
 Fri, 30 Jul 2021 02:23:53 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id lw22sm359494ejb.74.2021.07.30.02.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:23:52 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:23:32 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 14/24] iommu: Introduce explicit type for non-strict
 DMA domains
Message-ID: <YQPFFCnYDtmQkdvM@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <59a4d350c32a83e21de5dcfe6f041f38b0c35b82.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <59a4d350c32a83e21de5dcfe6f041f38b0c35b82.1627468309.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
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

On Wed, Jul 28, 2021 at 04:58:35PM +0100, Robin Murphy wrote:
> Promote the difference between strict and non-strict DMA domains from an
> internal detail to a distinct domain feature and type, to pave the road
> for exposing it through the sysfs default domain interface.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/dma-iommu.c |  2 +-
>  drivers/iommu/iommu.c     |  8 ++++++--
>  include/linux/iommu.h     | 11 +++++++++++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e28396cea6eb..8b3545c01077 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1311,7 +1311,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	 * The IOMMU core code allocates the default DMA domain, which the
>  	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>  	 */
> -	if (domain->type == IOMMU_DOMAIN_DMA) {
> +	if (iommu_is_dma_domain(domain)) {
>  		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>  			goto out_err;
>  		dev->dma_ops = &iommu_dma_ops;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fa8109369f74..982545234cf3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -115,6 +115,7 @@ static const char *iommu_domain_type_str(unsigned int t)
>  	case IOMMU_DOMAIN_UNMANAGED:
>  		return "Unmanaged";
>  	case IOMMU_DOMAIN_DMA:
> +	case IOMMU_DOMAIN_DMA_FQ:
>  		return "Translated";
>  	default:
>  		return "Unknown";
> @@ -552,6 +553,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
>  		case IOMMU_DOMAIN_DMA:
>  			type = "DMA\n";
>  			break;
> +		case IOMMU_DOMAIN_DMA_FQ:
> +			type = "DMA-FQ\n";
> +			break;
>  		}
>  	}
>  	mutex_unlock(&group->mutex);
> @@ -765,7 +769,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  	unsigned long pg_size;
>  	int ret = 0;
>  
> -	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
> +	if (!domain || !iommu_is_dma_domain(domain))
>  		return 0;
>  
>  	BUG_ON(!domain->pgsize_bitmap);
> @@ -1947,7 +1951,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	/* Assume all sizes by default; the driver may override this later */
>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>  
> -	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
> +	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
>  		iommu_domain_free(domain);
>  		domain = NULL;
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 141779d76035..046ba4d54cd2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -61,6 +61,7 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
>  					      implementation              */
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
> +#define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
>  /*
>   * This are the possible domain-types
> @@ -73,12 +74,17 @@ struct iommu_domain_geometry {
>   *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
>   *				  This flag allows IOMMU drivers to implement
>   *				  certain optimizations for these domains
> + *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
> + *				  invalidation.
>   */
>  #define IOMMU_DOMAIN_BLOCKED	(0U)
>  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
>  #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
>  #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API)
> +#define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
> +				 __IOMMU_DOMAIN_DMA_API |	\
> +				 __IOMMU_DOMAIN_DMA_FQ)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -90,6 +96,11 @@ struct iommu_domain {
>  	struct iommu_dma_cookie *iova_cookie;
>  };
>  
> +static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> +{
> +	return domain->type & __IOMMU_DOMAIN_DMA_API;
> +}
> +
>  enum iommu_cap {
>  	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
>  					   transactions */
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
