Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C495C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 19:55:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3792E2078E
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 19:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbKyE1eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A10FA86702;
	Tue, 15 Sep 2020 19:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kdbTSE-9u7Ib; Tue, 15 Sep 2020 19:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 14357866C8;
	Tue, 15 Sep 2020 19:55:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF6A8C0864;
	Tue, 15 Sep 2020 19:55:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9B17C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B79D486963
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYqYUBsDs-zF for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 19:55:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0B99D86947
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:55:05 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id r19so1904056pls.1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ANJOfSdlpRaHSBBO4TQnqknbM6J+0XuYtQl6sOjOU6g=;
 b=vbKyE1eGXl1ab37xPuCgN3XERmZgx8c72CmccznAaQT/qdPIFWgEvL2g7tdxHUje1+
 uH3g5E43P/o9/UJXb7GQiTNIYyMi0BTbo9lWzld48up8d8Dpu5ogNRBAKeUa8TQgWld4
 mXnM7bosw+BwFaU3OdjM3MkSleUZ0pAHWgLipyCpVaQWGWHMKkgE5EtkjCyhdPbfacRb
 BF4zvVAEvnt46T2LrUiCt+Ej1O5VNJn4gCUeqdOMVp0NP959/LyLVZ2HbrBpysEqZZ7U
 /glUHqltfoq9EtlZslQ0cG+F+Ocwp8nEhATulLHJinhygWWgTymGqXK7y09zkav+1GU6
 8HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ANJOfSdlpRaHSBBO4TQnqknbM6J+0XuYtQl6sOjOU6g=;
 b=riPLq7Dw+IsIiDRWCXMUFEprVjszpyVaQxLEJxwc+yyZfB2HZT+2xr4BpCvfUKMQXf
 5KMq10YmjkjAH5CfzjWLQ5J0Zs3sa+d+OQzt41duNObPNQa1jSsVzZ89xnQJIE4Soo7O
 eT+NSHUl2XSU6ELK5SJH8KbW+R+HEErSou2gOgzLkNOxlyMEUAwwbsbpYmVlEV6hOzU0
 fg7Q+Ts8N+yQo4Y9zikDdYLa51uQ0OkNLJA5YbKp/hKWah4w+tyAyzvQEPtYJmiJUYV4
 JI+OKNTHxaqLfEfwGFM+gHQXsTNV+gyfnC2TBjAN5t1mwU0OSYQy2aOFmlAIS+GS5S+e
 9C1A==
X-Gm-Message-State: AOAM532hFSzhaDRY9Kvy6YeE5dTHCj4MGy6i5A5UPR4oXHfZZg0VIi+L
 DOmwFghqNeCFarBu6Y3T7G6CrA==
X-Google-Smtp-Source: ABdhPJypvLei95eAIfBf9YhOFqqQKZ1C34DJmEf5yt+0uB+ckb9ORNsADCaKLRMdqq9zVPIXlUuLOA==
X-Received: by 2002:a17:902:9685:b029:d1:e5e7:be1b with SMTP id
 n5-20020a1709029685b02900d1e5e7be1bmr3266435plp.78.1600199704611; 
 Tue, 15 Sep 2020 12:55:04 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm14594221pfr.197.2020.09.15.12.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 12:55:04 -0700 (PDT)
Date: Tue, 15 Sep 2020 13:55:01 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200915195501.GA3666944@xps15>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-7-hch@lst.de>
 <20200914230147.GA3251212@xps15> <20200915054122.GA18079@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915054122.GA18079@lst.de>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-acpi@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org, loic.pallardy.st.com@xps15.osuosl.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jim Quinlan <james.quinlan@broadcom.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Sep 15, 2020 at 07:41:22AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2020 at 05:01:47PM -0600, Mathieu Poirier wrote:
> 
> [700 lines of the fullquote deleted..]
> 
> > > +	for (r = map; r->size; r++)
> > > +		num_ranges++;
> > > +
> > > +	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > > +			  GFP_KERNEL);
> > > +	if (!new_map)
> > > +		return -ENOMEM;
> > > +	to->dma_range_map = new_map;
> > > +	return 0;
> > > +}
> > > +
> > 
> > This patch seemed Ok to me but it broke the stm32 remoteproc implementation.  When
> > I tested things out function dma_coerce_mask_and_cohenrent() returns -5 and the
> > rest of the initialisation fails.  I isolated things to function dma_to_pfn()
> > [2].  In the original implementation __bus_to_pfn() returns 0xfffff and
> > dev->dma_pfn_offset is equal to 0x38000.  As such the function returns 0x137fff
> > and dma_supported() a non-zero value[3].
> > 
> > With this set function dma_to_pfn() received a face lift.  Function
> > __bus_to_pfn() still returns 0xfffff but translate_dma_to_phys() returns 0,
> > which forces dma_supported() to also return 0 and that is where the -5 (-EIO)
> > comes from.
> > 
> > Taking a futher look at translate_dma_to_phy(), @dma_addr never falls within the
> > bus_dma_region ranges and returns 0.
> > 
> > I'm suspecting an initialisation problem and if it occurred here, it will
> > likely show up elsewhere.
> 
> Can you try this incremental patch?
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 088c97181ab146..c6b21acba7a459 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -46,7 +46,7 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
>  		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
>  			return (phys_addr_t)dma_addr + m->offset;
>  
> -	return 0;
> +	return (phys_addr_t)-1;

That did the trick - the stm32 platform driver's probe() function completes and
the remote processor is operatinal. 

That being said the value returned by function dma_to_pfn()
is 0x137fff in the original code and 0xfffff with your patches applied.

Thanks,
Mathieu

>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
