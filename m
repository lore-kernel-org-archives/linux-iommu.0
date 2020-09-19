Return-Path: <SRS0=mFID=C5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E0C43463
	for <iommu@archiver.kernel.org>; Sun, 20 Sep 2020 04:33:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7CF21789
	for <iommu@archiver.kernel.org>; Sun, 20 Sep 2020 04:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHIQOZ0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7CF21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A00B48723E;
	Sun, 20 Sep 2020 04:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wf-gCMriEmOj; Sun, 20 Sep 2020 04:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A0CE8723D;
	Sun, 20 Sep 2020 04:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C671C088B;
	Sun, 20 Sep 2020 04:33:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA2BFC0051
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 22:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B371A87441
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 22:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwoeV03HQvWt for <iommu@lists.linux-foundation.org>;
 Sat, 19 Sep 2020 22:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B685871FB
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 22:29:25 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id v23so8015938ljd.1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NKi+wjC6dWzf+Z7xGQjWsEc0rij7x/ja/YI7q4yBabs=;
 b=kHIQOZ0CB9+LA4FOUvowUp2lKrrUOWcfne+NEfcfXJk0OTupohDxTLR43rdPYnpU5U
 GicCbI0EvyF77t+uvfFgtPParoW7MY/QP0EkmSsc2ro8g3fNiPcAMdMmRDU9CpFLDQVD
 o5gGX+mk1OtmrvatXkrMovoRWzxpYSg+jfHCjZsjENQNSzY6KylvlDdh1BRYn/Aa4Czn
 W2itJWQNQynupCSvO/KbveyopSz6z7xXAn+2LJEjL9Gg2X0HY1P/+AfLFYXXdtIxXOKn
 msgL17woaTsPj05OK1vNY+w48J+/Uphiyvq6mEPxYaIuguoZ1m1m1EKqjBV7lxcwGW+k
 ciTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NKi+wjC6dWzf+Z7xGQjWsEc0rij7x/ja/YI7q4yBabs=;
 b=kzSzfop3ZO1pPmb8lBLQUcUM+HTXSsg8Ky9+RtdKhlb6lN1MQjRXlBg55D4m9mY2zE
 NqDvdG1vvo0YU4w+GTczhnfzdDi6u2owGEsiYzA8i3u1Hh3mVILA2UEU6SSIHUNa+0Go
 TaDPV8EPBLYO78z3YjyldLxd2Ef40ciX5xFjtKIPMIFvzcLy2V8ECJtPEmPdQpghqcS5
 kqJ1Rm8sBMlCcBfXOZpTumqL6mb8R/E7UEG6WmHuWNEqWgFX4RP8BsgL+6WIZauAy3Mp
 M7HXQruP34Vdt6RA4YiUmuTQXH6S0G5pqTCd1QEDxuhiDKOG2vbP2thTNDZECO1i577g
 wjPg==
X-Gm-Message-State: AOAM532B7fg1ImP9bts12ZA8AXCd5JCJy+G1+V2SZUfYosguCGPlCwPK
 IXHYroI8dVXyDnxWw2PHRx8=
X-Google-Smtp-Source: ABdhPJyKClnDWdlUib5KUXzdnN+24azy9IRGBZhTe+irm0IOao3KfXeA08PP2jHuylJgT4MIk5ApWg==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr14590542ljc.48.1600554563573; 
 Sat, 19 Sep 2020 15:29:23 -0700 (PDT)
Received: from z50.localnet (109241122244.gdansk.vectranet.pl.
 [109.241.122.244])
 by smtp.gmail.com with ESMTPSA id o128sm1435563lfa.126.2020.09.19.15.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 15:29:22 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM/omap1: switch to use dma_direct_set_offset for
 lbus DMA offsets
Date: Sun, 20 Sep 2020 00:29:20 +0200
Message-ID: <2184547.ElGaqSPkdT@z50>
In-Reply-To: <20200918054933.GK7101@atomide.com>
References: <20200917173229.3311382-1-hch@lst.de>
 <20200917173229.3311382-2-hch@lst.de> <20200918054933.GK7101@atomide.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 20 Sep 2020 04:33:22 +0000
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Tony,

On Friday, September 18, 2020 7:49:33 A.M. CEST Tony Lindgren wrote:
> * Christoph Hellwig <hch@lst.de> [200917 17:37]:
> > Switch the omap1510 platform ohci device to use dma_direct_set_offset
> > to set the DMA offset instead of using direct hooks into the DMA
> > mapping code and remove the now unused hooks.
> 
> Looks nice to me :) I still can't test this probably for few more weeks
> though but hopefully Aaro or Janusz (Added to Cc) can test it.

Works for me on Amstrad Delta (tested with a USB ethernet adapter).

Tested-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz

> 
> Regards,
> 
> Tony
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm/include/asm/dma-direct.h         | 18 -------------
> >  arch/arm/mach-omap1/include/mach/memory.h | 31 -----------------------
> >  arch/arm/mach-omap1/usb.c                 | 22 ++++++++++++++++
> >  3 files changed, 22 insertions(+), 49 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
> > index 436544aeb83405..77fcb7ee5ec907 100644
> > --- a/arch/arm/include/asm/dma-direct.h
> > +++ b/arch/arm/include/asm/dma-direct.h
> > @@ -9,7 +9,6 @@
> >   * functions used internally by the DMA-mapping API to provide DMA
> >   * addresses. They must not be used by drivers.
> >   */
> > -#ifndef __arch_pfn_to_dma
> >  static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> >  {
> >  	if (dev && dev->dma_range_map)
> > @@ -34,23 +33,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> >  	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
> >  }
> >  
> > -#else
> > -static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> > -{
> > -	return __arch_pfn_to_dma(dev, pfn);
> > -}
> > -
> > -static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
> > -{
> > -	return __arch_dma_to_pfn(dev, addr);
> > -}
> > -
> > -static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> > -{
> > -	return __arch_virt_to_dma(dev, addr);
> > -}
> > -#endif
> > -
> >  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> >  {
> >  	unsigned int offset = paddr & ~PAGE_MASK;
> > diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
> > index 1142560e0078f5..36bc0000cb6ab8 100644
> > --- a/arch/arm/mach-omap1/include/mach/memory.h
> > +++ b/arch/arm/mach-omap1/include/mach/memory.h
> > @@ -14,42 +14,11 @@
> >   * OMAP-1510 bus address is translated into a Local Bus address if the
> >   * OMAP bus type is lbus. We do the address translation based on the
> >   * device overriding the defaults used in the dma-mapping API.
> > - * Note that the is_lbus_device() test is not very efficient on 1510
> > - * because of the strncmp().
> >   */
> > -#if defined(CONFIG_ARCH_OMAP15XX) && !defined(__ASSEMBLER__)
> >  
> >  /*
> >   * OMAP-1510 Local Bus address offset
> >   */
> >  #define OMAP1510_LB_OFFSET	UL(0x30000000)
> >  
> > -#define virt_to_lbus(x)		((x) - PAGE_OFFSET + OMAP1510_LB_OFFSET)
> > -#define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
> > -#define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev_name(dev), "ohci", 4) == 0))
> > -
> > -#define __arch_pfn_to_dma(dev, pfn)	\
> > -	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
> > -	   if (is_lbus_device(dev)) \
> > -		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
> > -	   __dma; })
> > -
> > -#define __arch_dma_to_pfn(dev, addr)	\
> > -	({ dma_addr_t __dma = addr;				\
> > -	   if (is_lbus_device(dev))				\
> > -		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
> > -	   __phys_to_pfn(__dma);				\
> > -	})
> > -
> > -#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
> > -						lbus_to_virt(addr) : \
> > -						__phys_to_virt(addr)); })
> > -
> > -#define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
> > -					   (dma_addr_t) (is_lbus_device(dev) ? \
> > -						virt_to_lbus(__addr) : \
> > -						__virt_to_phys(__addr)); })
> > -
> > -#endif	/* CONFIG_ARCH_OMAP15XX */
> > -
> >  #endif
> > diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> > index d8e9bbda8f7bdd..ba8566204ea9f4 100644
> > --- a/arch/arm/mach-omap1/usb.c
> > +++ b/arch/arm/mach-omap1/usb.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/io.h>
> >  
> >  #include <asm/irq.h>
> > @@ -542,6 +543,25 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
> >  /* ULPD_APLL_CTRL */
> >  #define APLL_NDPLL_SWITCH	(1 << 0)
> >  
> > +static int omap_1510_usb_ohci_notifier(struct notifier_block *nb,
> > +		unsigned long event, void *data)
> > +{
> > +	struct device *dev = data;
> > +
> > +	if (event != BUS_NOTIFY_ADD_DEVICE)
> > +		return NOTIFY_DONE;
> > +
> > +	if (strncmp(dev_name(dev), "ohci", 4) == 0 &&
> > +	    dma_direct_set_offset(dev, PHYS_OFFSET, OMAP1510_LB_OFFSET,
> > +			(u64)-1))
> > +		WARN_ONCE(1, "failed to set DMA offset\n");
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block omap_1510_usb_ohci_nb = {
> > +	.notifier_call		= omap_1510_usb_ohci_notifier,
> > +};
> > +
> >  static void __init omap_1510_usb_init(struct omap_usb_config *config)
> >  {
> >  	unsigned int val;
> > @@ -600,6 +620,8 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
> >  	if (config->register_host) {
> >  		int status;
> >  
> > +		bus_register_notifier(&platform_bus_type,
> > +				      &omap_1510_usb_ohci_nb);
> >  		ohci_device.dev.platform_data = config;
> >  		status = platform_device_register(&ohci_device);
> >  		if (status)
> 




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
