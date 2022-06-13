Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28510C43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 20:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7F834158B;
	Mon, 13 Jun 2022 20:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxebsZmEIRJg; Mon, 13 Jun 2022 20:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A3B741579;
	Mon, 13 Jun 2022 20:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 153F8C0032;
	Mon, 13 Jun 2022 20:57:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 716F8C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 580B281B99
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tn6VbtQsXFnd for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CD298142B
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655153857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMpM3RLOLxV7DfG66nG4CpZkyo8uEbAIJok5x0MS5a8=;
 b=T3dd5rfw5+16kkGgVdVi57oF/9Ghhsamsh1scD72h5TM6MsBgjmNSfZaEGVMSrn9yF9xDa
 HcQAmRDahuIaTJeQWpIdDfY9gOV+Zg6cuNEypzJib2FlDRB7q8n3FMVd0b+ELFUwjXbEz0
 oltIvqj1d6Nl7joxbuJiCgG1DIu7JM8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-leGX7dKzNGyayFKt1iNYzA-1; Mon, 13 Jun 2022 16:57:36 -0400
X-MC-Unique: leGX7dKzNGyayFKt1iNYzA-1
Received: by mail-pg1-f198.google.com with SMTP id
 d125-20020a636883000000b003db5e24db27so3900267pgc.13
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 13:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DMpM3RLOLxV7DfG66nG4CpZkyo8uEbAIJok5x0MS5a8=;
 b=Lg1lXXTKu+N9EpRoJcTeXJyElx0YpPP9lr+bRZdEOVqq0QOV3krSihEw5gsOtKSQoY
 i+tYrCUXT0Lc70Kv9R6rED/eeacHfR5f3WRImgcRR575XLHMG8TYYKpLIAg8rhkOCHp0
 Ot1ebareDlM4f2AIEvWKH2ryyjTd9SXOK0HJE8zsxZul1cxb9DzdvoXbb9cSMaBtMhKQ
 YXZ9etvyrh1YNkuWUU2b7BSxPl3EVsNRU2kicimIUJ80lluH3Mddnhh9ZwKqPUPy6OeK
 Q6h5ZyCfvW5bjHMI3fBjL+z3MhAbLIBW0YERhntNS4U/BE+ut625mIQUg1teV3JzK/gU
 AG5A==
X-Gm-Message-State: AJIora8lJpGaECuMNTnrR1l/iY3OlOPbz7q8aaQZOMqFMuB/ei0OkztI
 249YrQNPy2ok0yQlz0B5Ct6lFo0xfUnPu/AHc9imDIzSe1SjpPjr/qcsHS4g90v7GrECtrjL94R
 T+jG3/7mvkAxQF/Eao29RmXsgVqw2Aw==
X-Received: by 2002:a17:902:eb85:b0:168:b028:573b with SMTP id
 q5-20020a170902eb8500b00168b028573bmr1140659plg.158.1655153855686; 
 Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxvz2BCjhipic+Mg5uJOgnZfWvk5iX8yen2Z2mULX6gqvzjjwLap/PzmGC93Z+zJ4AwPc2Pw==
X-Received: by 2002:a17:902:eb85:b0:168:b028:573b with SMTP id
 q5-20020a170902eb8500b00168b028573bmr1140628plg.158.1655153855376; 
 Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 iz19-20020a170902ef9300b001636c0b98a7sm5545154plb.226.2022.06.13.13.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
Date: Mon, 13 Jun 2022 13:57:34 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220613205734.3x7i46bnsofzerr4@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
>  drivers/iommu/intel/Kconfig | 6 ++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 247d0f2d5fdf..fdbda77ac21e 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,12 @@ config DMAR_PERF
>  config DMAR_DEBUG
>  	bool
>  
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"

Also, should there be a "depends on (X86 || IA64)" here?

> +	default 1024 if MAXSMP
> +	default 128  if X86_64
> +	default 64
> +
>  config INTEL_IOMMU
>  	bool "Support for Intel IOMMU using DMA Remapping Devices"
>  	depends on PCI_MSI && ACPI && (X86 || IA64)
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 45e903d84733..0c03c1845c23 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -18,11 +18,7 @@
>  
>  struct acpi_dmar_header;
>  
> -#ifdef	CONFIG_X86
> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> -#else
> -# define	DMAR_UNITS_SUPPORTED	64
> -#endif
> +#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
>  
>  /* DMAR Flags */
>  #define DMAR_INTR_REMAP		0x1
> -- 
> 2.26.2
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
