Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2C17E473
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415141; cv=none; b=g9SVH8bhOPthpZ8JthEznOkNO6soUUoEY2Ii+t2ehbVfnGfYGxTFIARpAFS0eH5YgWYMMAHpxCRHD4mZc5EwT7mibAzK5+Cl/AQfA/GmCRo23nbME0jgcBcM3TiIBRzf7I5uSyeT1fj6C0ZaJOxgCttyyVBfxAOAF2ndGv1sypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415141; c=relaxed/simple;
	bh=Ut8+scTSjVpQnW57Q4gARiffheiB676olnzlE55eiMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooBHe2beQFUAYY+HF96X6kSo2nxi/ekF9FN2bopnMLnP7ggti+e6rvqN1LfUkt5j4J1f7/o3wSK8/0A5EzypCOtA8cwkImzFQRcqh2LEZlkGrzFeW1ZfQ8OvEtrRtq6DcVWfRKOCt7RatIKJ3TpWl6oU1hOQ6dhiu5C5Xlrg8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TrQMFWMa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TrQMFWMa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso11929405e9.0
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733415138; x=1734019938; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+3xHwvrZFGkgILsc+8sbeeDFiAlqkrIqdKcR5hFeMk=;
        b=TrQMFWMagxRkgKWrWZ0Ht38HUYnAP3tvdIH45QwJvFd05eSWY8QfnZxcXt1TKbu0Ti
         53bCQifkpOQQN1iRx1o0GEaLNaxL7CxNCX/3dHX+9KExyAm33L/MZ9CSM/9yJhqMx8VW
         WZOT5XJSK/QIQiDoLrsGS0jzKuXMedsOGXbZqqMt+twz6P8bZsltNXb1VrBo8Xob9SAe
         xlUL3Itfh5SXjdfHkGFdnlaYOfidP1EOdU8mnj1u3p8XC6O+3VbSSDa5UAx0tPs/k83n
         UdGelaVH1YAViSG8VmTzNQVcWg5As0elPlw4oETZWSeovfnKTMX5f/G3sCnEpiRDMpjm
         pYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415138; x=1734019938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+3xHwvrZFGkgILsc+8sbeeDFiAlqkrIqdKcR5hFeMk=;
        b=DHU3JK7DOWyb/9EZoOTzhCtSf7jYzxYnXK16lXkS8EewWrkY40RpqxeO+wYvlFBnHv
         EiNbBb1vp8otPdQohx6Exh6KaXq8EYbu3Li7ZsfdacHhBd3XqBALGk7TP4NzrpVC9fZ2
         /96zWmfpzB3Uh81wiB2cp4JwDvjwndAY5ZuoLJxeAHiAIcsi9Zc2axWR5EkfUHMM8NT9
         0U8wj+mfyHwYGrHRvzJyJqLmk7RsYooTDNv9zAx/4vgJ5NiR9xO+jfVFDgaUWcy+s7O7
         JMfoath2/MFpR1cE1qMbY0tbX+oJ8aqCGIY1qiGh3SNhKmJqMuFMV8bAvbHOVc1VGbyI
         HfqA==
X-Gm-Message-State: AOJu0Ywm9MTx0o2mgHxZf6nfL1AQ4IqRgBVIPnNZsieOb53ILnMQOM3Z
	Q7HP8z4aVghzISQt9ACa9kkkf4vDTY7/N8vGVx1geXQWi4s4eYi4uBwahsauIyw=
X-Gm-Gg: ASbGncvrCqd5cOEqDFe3Dj/u9DDZUEnA6YfETo66ZYQQTlB/UAd87zeb4fjPdjYBTKc
	GtxO5AlunxtGUA5WUVYPZgT5OQSQc5k06IQarNHphzTpgXT/kPXbr07DiHXmo8HGfH47DhiuZRT
	zq6L67YJ3joelG+9JY8VSKL4I9ze9qNSr+0REKWCWBBwniVFATK6XXBVyEcFxR6pkhh9rCEbfK3
	mRQNNBO1pNhNn75513t/1EkURCLr+SG/Q3LXV6jhXw+ArwdZzQy3weiHjVarfyYZg4nAg9hwOau
	hV/mdYfA/MwxoSyGb7In4LbCDhG+ZWO8sIQ=
X-Google-Smtp-Source: AGHT+IHa5lee9Sxqmls08SUxS6uuiGe/lvzblZfbVXScCZEse7mEYCbZITkpv0Vj+gpxQag2jSxbIw==
X-Received: by 2002:a05:6000:18ab:b0:385:e8ce:7483 with SMTP id ffacd0b85a97d-385fd3ccbbfmr9165309f8f.4.1733415137730;
        Thu, 05 Dec 2024 08:12:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a874dsm2290643f8f.24.2024.12.05.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:12:17 -0800 (PST)
Date: Thu, 5 Dec 2024 17:12:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach
 irq_set_affinity
Message-ID: <20241205-2ed14db745f00a0ee9be444b@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com>
 <87mshcub2u.ffs@tglx>
 <20241203-1cadc72be6883bc2d77a8050@orel>
 <87a5dcu2wq.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5dcu2wq.ffs@tglx>

On Tue, Dec 03, 2024 at 05:50:13PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 17:27, Andrew Jones wrote:
> > On Tue, Dec 03, 2024 at 02:53:45PM +0100, Thomas Gleixner wrote:
> >> On Thu, Nov 14 2024 at 17:18, Andrew Jones wrote:
> >> The whole IMSIC MSI support can be moved over to MSI LIB which makes all
> >> of this indirection go away and your intermediate domain will just fit
> >> in.
> >> 
> >> Uncompiled patch below. If that works, it needs to be split up properly.
> >
> > Thanks Thomas. I gave your patch below a go, but we now fail to have an
> > msi domain set up when probing devices which go through aplic_msi_setup(),
> > resulting in an immediate NULL deference in
> > msi_create_device_irq_domain(). I'll look closer tomorrow.
> 
> Duh! I forgot to update the .select callback. I don't know how you fixed that
> compile fail up. Delta patch below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -180,7 +180,7 @@ static void imsic_irq_debug_show(struct
>  static const struct irq_domain_ops imsic_base_domain_ops = {
>  	.alloc		= imsic_irq_domain_alloc,
>  	.free		= imsic_irq_domain_free,
> -	.select		= imsic_irq_domain_select,
> +	.select		= msi_lib_irq_domain_select,
>  #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
>  	.debug_show	= imsic_irq_debug_show,
>  #endif

Hi Thomas,

With this select fix and replacing patch 03/15 of this series with the
following diff, this irqbypass PoC still works.

Based on what Anup said, I kept imsic_msi_update_msg(), which means I
kept this entire patch (01/15) as is. Anup is working on a series to fix
the non-atomic MSI message writes to the device and will likely pick this
patch up along with your changes to convert IMSIC to msi-lib.

I'd like to know your opinion on patch 02/15 of this series and the diff
below. afaict, x86 does something similar with the DOMAIN_BUS_DMAR and
DOMAIN_BUS_AMDVI tokens in x86_init_dev_msi_info().

Thanks,
drew

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 51464c6257f3..cc18516a4e82 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -36,14 +36,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
                return false;
 
        /*
-        * MSI parent domain specific settings. For now there is only the
-        * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
-        * possible to stack MSI parents. See x86 vector -> irq remapping
+        * MSI parent domain specific settings. There may be only the root
+        * parent domain, e.g. NEXUS, acting as a MSI parent, or there may
+        * be stacked MSI parents, typically used for remapping.
         */
        if (domain->bus_token == pops->bus_select_token) {
                if (WARN_ON_ONCE(domain != real_parent))
                        return false;
-       } else {
+       } else if (real_parent->bus_token != DOMAIN_BUS_MSI_REMAP) {
                WARN_ON_ONCE(1);
                return false;
        }

