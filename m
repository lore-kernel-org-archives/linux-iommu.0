Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB1C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 18:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C0382BD6;
	Wed, 15 Jun 2022 18:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPyZyeCKhjqc; Wed, 15 Jun 2022 18:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C8AF982B49;
	Wed, 15 Jun 2022 18:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F55BC0032;
	Wed, 15 Jun 2022 18:39:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 097FBC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBC8340483
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3DV1mbPGeQ0 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 18:39:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3100D40347
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655318381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RcdFFREUfEJEOuSG3gYO2LQRqJJ/FELQTHyfQNEdXjk=;
 b=OSZPncvsLnJk1ykjwD1bZgcf4tcF99GdxIYdVuMC3Cd7KPVIMtTf4dYUSedKaqSPUI5fi/
 VFOa2JXji2BxUKJdA6RHQYjIZGL8L0tHsvcjfn24lN3JuwWTrKHr1+G+Bthjg+pl9NyPmQ
 FPbsYUV25d61wZeCWYgDgu54v+31wPA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-x95LWjpuNfupKAB5pW6Ilg-1; Wed, 15 Jun 2022 14:39:40 -0400
X-MC-Unique: x95LWjpuNfupKAB5pW6Ilg-1
Received: by mail-pf1-f197.google.com with SMTP id
 w190-20020a627bc7000000b00522a88383d8so1892846pfc.6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 11:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RcdFFREUfEJEOuSG3gYO2LQRqJJ/FELQTHyfQNEdXjk=;
 b=isNG+eF6BveMacfZmnKQw9uPRbfvENRfazLV29mHS6nEz4sEaFnAjmw60ViWiZubqH
 9OGOh6O+ZZNrLUJ2jRZJivSFNDnTxtaraYC2rcB17A2piJsdi5wPl6A5q8X+tvbf6j2y
 bARpTWAgBMPPqj7y9dVV632Yh+Cxf8EnP9BqoByOhIVJPVMCISVL7F+SZEayH9Ut0rbf
 jyY4lBJBhfanO+KULUUN/20R1Z6U1MAyfJHftB2tQStTdA73e9hA/hQ9UjeOC5heT9SK
 3bqF+jKYN1WPKLF1Etjv/F73ue6OchTt11+t6k4YxbfpiNu2R+iqTJptyEZaV+1nFfB/
 3Rqg==
X-Gm-Message-State: AJIora+X6ZufAkn+ns1HYooU27DLjWN+RR1e7rvLrVriI+UwyiLDY1Uq
 tQfBg/0jsJBRPO7+Qw3Jx8xiSN0FQPKUZMLhZ84JGlwV3jLH0+Kocg9HtnYVHVaM7CavX3pgqv4
 t1I/+0FRjdsXAPmTLDOemh5vTWH6fvA==
X-Received: by 2002:a17:902:6b4c:b0:168:aa50:ddc with SMTP id
 g12-20020a1709026b4c00b00168aa500ddcmr881389plt.59.1655318379449; 
 Wed, 15 Jun 2022 11:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfw24CKmrnxFPIkKzt0RPQftwNck1wdP7tXppKFhlJfFekT0x1FwP0e7fCgN4lHWCzgV5KNg==
X-Received: by 2002:a17:902:6b4c:b0:168:aa50:ddc with SMTP id
 g12-20020a1709026b4c00b00168aa500ddcmr881361plt.59.1655318379065; 
 Wed, 15 Jun 2022 11:39:39 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a62f901000000b0051bb79437f7sm10250845pfh.37.2022.06.15.11.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jun 2022 11:39:38 -0700 (PDT)
Date: Wed, 15 Jun 2022 11:39:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220615183937.6k3swpax32lsdhkq@cantor>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
MIME-Version: 1.0
In-Reply-To: <20220615183650.32075-1-steve.wahl@hpe.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dimitri Sivanich <sivanich@hpe.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Russ Anderson <russ.anderson@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Wed, Jun 15, 2022 at 01:36:50PM -0500, Steve Wahl wrote:
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
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

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
> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> 
>  drivers/iommu/intel/Kconfig | 7 +++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..07aaebcb581d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,13 @@ config DMAR_PERF
>  config DMAR_DEBUG
>  	bool
>  
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"
> +	depends on DMAR_TABLE
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
