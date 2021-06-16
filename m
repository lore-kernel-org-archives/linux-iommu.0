Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C12C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 09:35:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF0D6128C
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 09:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF0D6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE4EE608FC;
	Wed, 16 Jun 2021 09:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JgADVj0IDR-r; Wed, 16 Jun 2021 09:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82A6860908;
	Wed, 16 Jun 2021 09:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C4E1C000F;
	Wed, 16 Jun 2021 09:35:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E507C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 09:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CBF583AFD
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 09:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WhHJyvNt8Llh for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 09:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7298A83AE4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623836151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Pi4WvYcIjHt6IhtICBC7du7MWrbhRe5X3CJSC67khs=;
 b=TIFqrO7zsf6Pv5BTYcqmELQ9oy3SrurkCKPZV9D7/0MYR+vjkj2Y1faeCjo4OMC3a0qL7E
 Q4jT9+EqT3bJLfa4ERJcXRUDbCwJ+bwsGUpfN+GPrep6O5gVaiRaWXLbouGB0FIMnt+J/0
 mC3toz3gwXo/WPHiiYH5ViXCs026UMI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-aSyGQ170O9GCFj0HKlnMjg-1; Wed, 16 Jun 2021 05:35:50 -0400
X-MC-Unique: aSyGQ170O9GCFj0HKlnMjg-1
Received: by mail-wr1-f69.google.com with SMTP id
 p16-20020adfe6100000b029011a599a471dso838971wrm.15
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 02:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=0Pi4WvYcIjHt6IhtICBC7du7MWrbhRe5X3CJSC67khs=;
 b=CqN55qBfRJp5Y2GDoY4yUXcSOpufZGDDCmvCOsXvgb6MhS6h+AwAJbqOnY8xA2cEZX
 wGTgUlzsvi4X+DdZgTAvjP5tszCpzrlukRJX39LWwHQ1lXt5vtbIWKgSWzMizgHP+jLE
 ANeQI3xcql4T/bL0EnGmvL7YzrKhY6UUAHu4S9JlvOgmQW+xLYsg2Wq6TRZG2xaOUPke
 x0HPNoq72BeBmMY+x36Qww9DUXqBfg4tAw+fUkHz8QWeTGe2jjqNXECQI4g9pzAK1Y+l
 Jbs3XXpJ8iETb18h7pN4zTfO+76t7Q5ZKqrRDoIJ8b6UrjuLqg1qk3ZL+uth0ySyuz8S
 UUuA==
X-Gm-Message-State: AOAM5318YjXH+Mldk8XD1dJhPB4lPjIS6OyH2xebl3pscv61bVGoA0Jj
 PdXHdqZ01pTUPFQDD0tyqkrZggllOms2y6ohAs0ZdG0OxEfKupGH6oavEk8uUnNwm+ziecPAvz5
 KnL9H85wDBFgbkjsIttN7USz2/7HChg==
X-Received: by 2002:adf:d23a:: with SMTP id k26mr4347722wrh.68.1623836149423; 
 Wed, 16 Jun 2021 02:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhBcDfUiCH2ZK0E1QZJdxwCxqPTc4INEFxeTDZt5btsWX0u4OXfmwePLVBFGWNJY+vhym3pg==
X-Received: by 2002:adf:d23a:: with SMTP id k26mr4347702wrh.68.1623836149273; 
 Wed, 16 Jun 2021 02:35:49 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id z10sm1302151wmp.39.2021.06.16.02.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 02:35:48 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] ACPI: arm64: Move DMA setup operations out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-2-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <a34eea45-8313-1320-5e77-12a1b09cc900@redhat.com>
Date: Wed, 16 Jun 2021 11:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-2-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kevin.tian@intel.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Extract generic DMA setup code out of IORT, so it can be reused by VIOT.
> Keep it in drivers/acpi/arm64 for now, since it could break x86
> platforms that haven't run this code so far, if they have invalid
> tables.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric

> ---
>  drivers/acpi/arm64/Makefile |  1 +
>  include/linux/acpi.h        |  3 +++
>  include/linux/acpi_iort.h   |  6 ++---
>  drivers/acpi/arm64/dma.c    | 50 ++++++++++++++++++++++++++++++++++
>  drivers/acpi/arm64/iort.c   | 54 ++++++-------------------------------
>  drivers/acpi/scan.c         |  2 +-
>  6 files changed, 66 insertions(+), 50 deletions(-)
>  create mode 100644 drivers/acpi/arm64/dma.c
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 6ff50f4ed947..66acbe77f46e 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-y				+= dma.o
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..7aaa9559cc19 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -259,9 +259,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>  
>  #ifdef CONFIG_ARM64
>  void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
>  #else
>  static inline void
>  acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> +static inline void
> +acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
>  #endif
>  
>  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..f7f054833afd 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -34,7 +34,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>  void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
> +int iort_dma_get_ranges(struct device *dev, u64 *size);
>  const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> @@ -48,8 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(
>  { return NULL; }
>  static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>  /* IOMMU interface */
> -static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
> -				  u64 *size) { }
> +static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
> +{ return -ENODEV; }
>  static inline const struct iommu_ops *iort_iommu_configure_id(
>  				      struct device *dev, const u32 *id_in)
>  { return NULL; }
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> new file mode 100644
> index 000000000000..f16739ad3cc0
> --- /dev/null
> +++ b/drivers/acpi/arm64/dma.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
> +#include <linux/device.h>
> +#include <linux/dma-direct.h>
> +
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +{
> +	int ret;
> +	u64 end, mask;
> +	u64 dmaaddr = 0, size = 0, offset = 0;
> +
> +	/*
> +	 * If @dev is expected to be DMA-capable then the bus code that created
> +	 * it should have initialised its dma_mask pointer by this point. For
> +	 * now, we'll continue the legacy behaviour of coercing it to the
> +	 * coherent mask if not, but we'll no longer do so quietly.
> +	 */
> +	if (!dev->dma_mask) {
> +		dev_warn(dev, "DMA mask not set\n");
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +	}
> +
> +	if (dev->coherent_dma_mask)
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	else
> +		size = 1ULL << 32;
> +
> +	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	if (ret == -ENODEV)
> +		ret = iort_dma_get_ranges(dev, &size);
> +	if (!ret) {
> +		/*
> +		 * Limit coherent and dma mask based on size retrieved from
> +		 * firmware.
> +		 */
> +		end = dmaaddr + size - 1;
> +		mask = DMA_BIT_MASK(ilog2(end) + 1);
> +		dev->bus_dma_limit = end;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);
> +	}
> +
> +	*dma_addr = dmaaddr;
> +	*dma_size = size;
> +
> +	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> +
> +	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +}
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..a940be1cf2af 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1144,56 +1144,18 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>  }
>  
>  /**
> - * iort_dma_setup() - Set-up device DMA parameters.
> + * iort_dma_get_ranges() - Look up DMA addressing limit for the device
> + * @dev: device to lookup
> + * @size: DMA range size result pointer
>   *
> - * @dev: device to configure
> - * @dma_addr: device DMA address result pointer
> - * @dma_size: DMA range size result pointer
> + * Return: 0 on success, an error otherwise.
>   */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +int iort_dma_get_ranges(struct device *dev, u64 *size)
>  {
> -	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
> -	int ret;
> -
> -	/*
> -	 * If @dev is expected to be DMA-capable then the bus code that created
> -	 * it should have initialised its dma_mask pointer by this point. For
> -	 * now, we'll continue the legacy behaviour of coercing it to the
> -	 * coherent mask if not, but we'll no longer do so quietly.
> -	 */
> -	if (!dev->dma_mask) {
> -		dev_warn(dev, "DMA mask not set\n");
> -		dev->dma_mask = &dev->coherent_dma_mask;
> -	}
> -
> -	if (dev->coherent_dma_mask)
> -		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	if (dev_is_pci(dev))
> +		return rc_dma_get_range(dev, size);
>  	else
> -		size = 1ULL << 32;
> -
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -	if (ret == -ENODEV)
> -		ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
> -				      : nc_dma_get_range(dev, &size);
> -
> -	if (!ret) {
> -		/*
> -		 * Limit coherent and dma mask based on size retrieved from
> -		 * firmware.
> -		 */
> -		end = dmaaddr + size - 1;
> -		mask = DMA_BIT_MASK(ilog2(end) + 1);
> -		dev->bus_dma_limit = end;
> -		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> -		*dev->dma_mask = min(*dev->dma_mask, mask);
> -	}
> -
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +		return nc_dma_get_range(dev, size);
>  }
>  
>  static void __init acpi_iort_register_irq(int hwirq, const char *name,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e10d38ac7cf2..ea613df8f913 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1537,7 +1537,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  		return 0;
>  	}
>  
> -	iort_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev, &dma_addr, &size);
>  
>  	iommu = iort_iommu_configure_id(dev, input_id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
