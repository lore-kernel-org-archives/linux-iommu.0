Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE53C352AA
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 19:45:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FF7205C9
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 19:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2hV/mPBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5C09515DE;
	Tue,  1 Oct 2019 19:45:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2790A1584
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 19:45:22 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9EF95D3
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 19:45:21 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 26F8A205C9;
	Tue,  1 Oct 2019 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569959121;
	bh=iuEl0oG1KnkC1p6/E5Wz2uBIvJyfmGalS5kJrSPDlLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=2hV/mPBtGU8oBcPBQvxE26QUIPzRLboN1a7KAwOaOZE1lpPoyVJG5/4rv3CiYrDzN
	uL1kVj4B0TKChZ7oBo9O48OKM+XZkxEg8M7raFz6GnIiuzvq+gO1KpkNu9loHUiJwF
	6tlzF/Y34Z2JKakjjPqBmUkb5VodKqlwihN5ekVs=
Date: Tue, 1 Oct 2019 14:45:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH v2] PCI: Remove unused includes and superfluous struct
	declaration
Message-ID: <20191001194519.GA63059@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903113059.2901-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 03, 2019 at 01:30:59PM +0200, Krzysztof Wilczynski wrote:
> Remove <linux/pci.h> and <linux/msi.h> from being included
> directly as part of the include/linux/of_pci.h, and remove
> superfluous declaration of struct of_phandle_args.
> 
> Move users of include <linux/of_pci.h> to include <linux/pci.h>
> and <linux/msi.h> directly rather than rely on both being
> included transitively through <linux/of_pci.h>.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied with Rob's reviewed-by to pci/misc for v5.5, thanks!

> ---
>  drivers/iommu/of_iommu.c                          | 2 ++
>  drivers/irqchip/irq-gic-v2m.c                     | 1 +
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c          | 1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/pci-aardvark.c             | 1 +
>  drivers/pci/controller/pci-thunder-pem.c          | 1 +
>  drivers/pci/pci.c                                 | 1 +
>  drivers/pci/probe.c                               | 1 +
>  include/linux/of_pci.h                            | 5 ++---
>  9 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 614a93aa5305..026ad2b29dcd 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -8,6 +8,8 @@
>  #include <linux/export.h>
>  #include <linux/iommu.h>
>  #include <linux/limits.h>
> +#include <linux/pci.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_pci.h>
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index e88e75c22b6a..fbec07d634ad 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index 229d586c3d7a..87711e0f8014 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/acpi_iort.h>
> +#include <linux/pci.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d3156446ff27..7a9bef993e57 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci_regs.h>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index fc0fe4d4de49..3a05f6ca95b0 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -16,6 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  
> diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
> index f127ce8bd4ef..9491e266b1ea 100644
> --- a/drivers/pci/controller/pci-thunder-pem.c
> +++ b/drivers/pci/controller/pci-thunder-pem.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/pci.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci-acpi.h>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 484e35349565..571e7e00984b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/init.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 169943f17a4c..11b11a652d18 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/msi.h>
>  #include <linux/of_device.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci_hotplug.h>
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 21a89c4880fa..29658c0ee71f 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -2,11 +2,10 @@
>  #ifndef __OF_PCI_H
>  #define __OF_PCI_H
>  
> -#include <linux/pci.h>
> -#include <linux/msi.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
>  
>  struct pci_dev;
> -struct of_phandle_args;
>  struct device_node;
>  
>  #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
> -- 
> 2.23.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
