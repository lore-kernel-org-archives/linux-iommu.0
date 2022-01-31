Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA60C433F5
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 22:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F373580C97;
	Mon, 31 Jan 2022 22:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vho0k33Sy3xd; Mon, 31 Jan 2022 22:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADD4F80C8C;
	Mon, 31 Jan 2022 22:29:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83BEAC001A;
	Mon, 31 Jan 2022 22:29:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08257C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 22:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFF404053D
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 22:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8oORO3lISmh for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 22:29:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C84EC401E1
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 22:29:51 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 k23-20020a4abd97000000b002ebc94445a0so3573890oop.1
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=HIrK/ll1TuZEnp2gfWjGUr6nhrl/RDbWrtbWrrFF7+Q=;
 b=FWRJLJWX37blE6SLGzHmlsU0MZaU9sC2V0CKgL2guyKi7ulFdCvCxfSgomLcISQkgy
 Ghq8SQIK4GU/McVbpX2lJ7OYShY6Lw5N7YDemT7S61dxt4UkLuWkbDmiWtLV762XImzN
 iPIwaCk0oidTkqG5YTSOx1D94ZX/cJ8UT38VexR809vDAIRCTgiUw9WdmH8i4zF4TaOY
 sjkQKwFCacqbbThjmKuhVAZ23rOdKjSaGbe/NcrwAPbrDF4+HCEGEKm+QiAzCwCa95P5
 wn42EJBxoXEh5EO4PWRYI2RctRR7vXFMjMJ7lAfqUaFIvg6vDktEasPwIfoCZezXf5fQ
 Un3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition;
 bh=HIrK/ll1TuZEnp2gfWjGUr6nhrl/RDbWrtbWrrFF7+Q=;
 b=r/Ka0ImVC9sN331fm1/SdDacw5O2+KQ/xLV0NAIqaDYSD4TokmVGHZrwgIZHWztyKX
 bhg11IuBA9rkKufmdB4/vIBGRahtxxCigp3nZSCc688z+ZLi1E9ZzHeQj/ijNoFnPwl5
 gTkcgEfRIG6G2tuyV6uPS45nljOeJx8MsMEvy9buvrPNFF+Fw11BwzBSV6YWtqde2red
 6JmZIGDWBMoVh3dkOBBp5lKZvbMTzi0FE4maZOj5npJ4nz91REkTNQQlnuKWsirbTUit
 hzyYhcSBXGBk47vjC4iXXbpTuXoB3DLjrZx0FKuF8XOpxBRdRNLFF+aYhKqR/z0Z/s7L
 H3FA==
X-Gm-Message-State: AOAM530IdXfQnJ+TFawe954Fgzh5hkTPe4IN3P9wJ2cPfF0Am20C2Qup
 B4kztne5Zlvmar9/ZpSXXpU=
X-Google-Smtp-Source: ABdhPJx+o1YTpwbEBbSj59Y5iWO00V4GxVy7uT2QJWPM1Z04rC1/i4P0mk8FIqDSuUFbw+Zw9FPkQg==
X-Received: by 2002:a4a:7656:: with SMTP id w22mr11304612ooe.79.1643668190906; 
 Mon, 31 Jan 2022 14:29:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g4sm9441095otg.61.2022.01.31.14.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 14:29:50 -0800 (PST)
Date: Mon, 31 Jan 2022 14:29:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Message-ID: <20220131222949.GA3467472@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
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

On Mon, Jan 31, 2022 at 10:16:41PM +0100, Thomas Gleixner wrote:
> Guenter,
> 
> On Mon, Jan 31 2022 at 07:21, Guenter Roeck wrote:
> > Sure. Please see http://server.roeck-us.net/qemu/x86/.
> > The logs are generated with with v5.16.4.
> 
> thanks for providing the data. It definitely helped me to leave the
> state of not seeing the wood for the trees. Fix below.
> 
> Thanks,
> 
>         tglx
> ---
> Subject: PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 31 Jan 2022 22:02:46 +0100
> 
> The recent overhaul of pci_irq_get_affinity() introduced a regression when
> pci_irq_get_affinity() is called for an MSI-X interrupt which was not
> allocated with affinity descriptor information.
> 
> The original code just returned a NULL pointer in that case, but the rework
> added a WARN_ON() under the assumption that the corresponding WARN_ON() in
> the MSI case can be applied to MSI-X as well.
> 
> In fact the MSI warning in the original code does not make sense either
> because it's legitimate to invoke pci_irq_get_affinity() for a MSI
> interrupt which was not allocated with affinity descriptor information.
> 
> Remove it and just return NULL as the original code did.
> 
> Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/pci/msi/msi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affini
>  	if (!desc)
>  		return cpu_possible_mask;
>  
> -	if (WARN_ON_ONCE(!desc->affinity))
> +	/* MSI[X] interrupts can be allocated without affinity descriptor */
> +	if (!desc->affinity)
>  		return NULL;
>  
>  	/*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
