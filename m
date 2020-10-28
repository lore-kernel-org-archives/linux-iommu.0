Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4AC4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 20:50:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BA824825
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 20:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZY0xy2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA824825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 212FB87475;
	Wed, 28 Oct 2020 20:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cwVcWyXQa39; Wed, 28 Oct 2020 20:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E3FAA87403;
	Wed, 28 Oct 2020 20:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1BFEC088B;
	Wed, 28 Oct 2020 20:50:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FE31C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 20:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 28C7420394
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 20:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EMMyTybN+Iag for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 20:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 086C12038A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 20:49:58 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id s22so482323pga.9
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GCggY7e0E7+nEDdFJbxSTJMV/259kn8n+mAT+V0LfCs=;
 b=TZY0xy2kFqGd+ZGUY4CRMyZLZa8Hbgx5e8LnBp7IOxKc+9+OK4Zz3jPaiZOlWNPJzH
 OW3NGsBwGXMuuPLEBuOMfjyUGUtC6llZQlpH1lKz+64yNjMlPVDu8wFHRjhGnsg2heJB
 G49tB9PpHBeJBQlaBhUGjX9HWMUEo08B3yJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GCggY7e0E7+nEDdFJbxSTJMV/259kn8n+mAT+V0LfCs=;
 b=rRjkE+eAAlWyMRZ1Yo2qLJ8+imEHgQ/AKFLNIuOn542QQe6f5tXy8vvRo9aDFgo32l
 4bxhC88/CmjwD7YVD3zT+3Ys2eTAwCh6H91LfxEZG/pc2Cu59cka5a9yb7y2Uh4j7MGn
 dRFWQa1rExOAfv1IKfDz4xvQvXMT6ZXZEwpxNGp38UIbrgNFX2U7es7Kw//p15AARS7H
 Ttv6wToYpNoANMRzYzGZQ1ZVXBC83QNdQ6qk3Cbzkt4MAsprKqVd0u3m/oZ4WPtwyjgV
 RLUubinngBot/chcdBeMTXMHtkL6hkhND1rmlkvpjbAKFMdylOWTmP83vOYF41IqMwt7
 t8Ng==
X-Gm-Message-State: AOAM530qOmtvcFzqKSQjhwLrDAYAi0590UfqvQb+zxivJNMUVQ1mxDBi
 zFl6icEL5IVpEdqUwtIY60a1Cw==
X-Google-Smtp-Source: ABdhPJxzcqY8mMTSCp/VBFyB1A2e7ggZHaADS42KkBYmv7xlONUZAyNXRIEqFK1eCAZAFxTteJ2hAQ==
X-Received: by 2002:a17:90b:3785:: with SMTP id
 mz5mr668722pjb.215.1603918197590; 
 Wed, 28 Oct 2020 13:49:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id w123sm502105pfd.34.2020.10.28.13.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 13:49:56 -0700 (PDT)
Date: Wed, 28 Oct 2020 13:49:55 -0700
From: Kees Cook <keescook@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 15/35] PCI: vmd: Use msi_msg shadow structs
Message-ID: <202010281347.2943F5B7@keescook>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-16-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201024213535.443185-16-dwmw2@infradead.org>
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Sat, Oct 24, 2020 at 10:35:15PM +0100, David Woodhouse wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use the x86 shadow structs in msi_msg instead of the macros.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  drivers/pci/controller/vmd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index aa1b12bac9a1..72de3c6f644e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -18,7 +18,6 @@
>  #include <asm/irqdomain.h>
>  #include <asm/device.h>
>  #include <asm/msi.h>
> -#include <asm/msidef.h>
>  
>  #define VMD_CFGBAR	0
>  #define VMD_MEMBAR1	2
> @@ -131,10 +130,10 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct vmd_irq_list *irq = vmdirq->irq;
>  	struct vmd_dev *vmd = irq_data_get_irq_handler_data(data);
>  
> -	msg->address_hi = MSI_ADDR_BASE_HI;
> -	msg->address_lo = MSI_ADDR_BASE_LO |
> -			  MSI_ADDR_DEST_ID(index_from_irqs(vmd, irq));
> -	msg->data = 0;
> +	memset(&msg, 0, sizeof(*msg);

This should be:

+	memset(msg, 0, sizeof(*msg);

https://groups.google.com/g/clang-built-linux/c/N-DfCPz3alg

> +	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
> +	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
> +	msg->arch_addr_lo.destid_0_7 = index_from_irqs(vmd, irq);
>  }
>  
>  /*
> -- 
> 2.26.2
> 

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
