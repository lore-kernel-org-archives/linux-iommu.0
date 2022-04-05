Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6431C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 13:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6885E60EA3;
	Tue,  5 Apr 2022 13:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gi-JPGMfw-Jo; Tue,  5 Apr 2022 13:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B5B160C01;
	Tue,  5 Apr 2022 13:26:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 146E7C002C;
	Tue,  5 Apr 2022 13:26:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1297C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C031382F40
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3v9v1dkoCrc for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 13:26:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52261824EF
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:26:15 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-2eb543fe73eso76349977b3.5
 for <iommu@lists.linux-foundation.org>; Tue, 05 Apr 2022 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5bma3Hv9/Du0X4/97+r/i96qcpXIT9vsWsP+NmZQEhc=;
 b=xUXDPhh+hnI9OX+kmc36pE0G77vQ8cMhBfJ5ghz5ZbkFEGBuvcA1FDfZ6+SlJr9IzR
 wGv3X0Cl+G4sKhWVI43qmnaLVS7OxZUn4cTGMvlInub4pw3e0l9vq37ThcL02oaIpOTV
 IadoHjMB9ZdPCvjlKh1im3cSIsW+QTB2gHMXeQDUiUmV4jCqb32OdARlptHFSKXNgapI
 59ae6TBz9X6CnyWztlntE//ERKmEMqRJpmIE4DnCsabs6iFXnye4P8pe/Zc/3ORQS+t8
 mR6MYOJc7qxvvyIafN5kL6tAE0YDvsH//jhjXZGicO3sYCgiBWL2NHwyyG3H5LSiVQg1
 xPlg==
X-Gm-Message-State: AOAM532EVZ2Ba570vPwcKObXYFHCzp/9/D0d1v3MG9UrJu/czIlvb/md
 vkdeD0tiG35LZRoPiuy/ZxDBhkGekaK0Yj8/hX8=
X-Google-Smtp-Source: ABdhPJwSoRVMoL8d5NZt/uFMN/p5bnGsKoxUE2f3GX9NbHU0ViSKhN6b3N2cxmhRKLuKcvzdrUX4TUIagp1Us0uHFq8=
X-Received: by 2002:a81:1549:0:b0:2eb:3dc7:bd16 with SMTP id
 70-20020a811549000000b002eb3dc7bd16mr2689122ywv.7.1649165174251; Tue, 05 Apr
 2022 06:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com>
 <20220325184609.4059963-2-rajatja@google.com>
In-Reply-To: <20220325184609.4059963-2-rajatja@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Apr 2022 15:26:03 +0200
Message-ID: <CAJZ5v0hH-Xujak9jGLOvxnLVHXCms8SU-2qJnzPXpAGK4FBxqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: Rename pci_dev->untrusted to
 pci_dev->untrusted_dma
To: Rajat Jain <rajatja@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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

On Fri, Mar 25, 2022 at 7:46 PM Rajat Jain <rajatja@google.com> wrote:
>
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
>
> No functional change intended.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v5: Use "untrusted_dma" as property name, based on feedback.
>     Reorder the patches in the series.
> v4: Initial version, created based on comments on other patch
>
>  drivers/iommu/dma-iommu.c   | 6 +++---
>  drivers/iommu/intel/iommu.c | 2 +-
>  drivers/iommu/iommu.c       | 2 +-
>  drivers/pci/ats.c           | 2 +-
>  drivers/pci/pci-acpi.c      | 2 +-
>  drivers/pci/pci.c           | 2 +-
>  drivers/pci/probe.c         | 8 ++++----
>  drivers/pci/quirks.c        | 2 +-
>  include/linux/pci.h         | 5 +++--
>  9 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..7cbe300fe907 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
>         return ret;
>  }
>
> -static bool dev_is_untrusted(struct device *dev)
> +static bool dev_has_untrusted_dma(struct device *dev)
>  {
> -       return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> +       return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
>  }
>
>  static bool dev_use_swiotlb(struct device *dev)
>  {
> -       return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +       return IS_ENABLED(CONFIG_SWIOTLB) && dev_has_untrusted_dma(dev);
>  }
>
>  /**
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..9246b7c9ab46 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5570,7 +5570,7 @@ intel_iommu_enable_nesting(struct iommu_domain *domain)
>   */
>  static bool risky_device(struct pci_dev *pdev)
>  {
> -       if (pdev->untrusted) {
> +       if (pdev->untrusted_dma) {
>                 pci_info(pdev,
>                          "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
>                          pdev->vendor, pdev->device);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..79fb66af2e68 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1522,7 +1522,7 @@ static int iommu_get_def_domain_type(struct device *dev)
>  {
>         const struct iommu_ops *ops = dev->bus->iommu_ops;
>
> -       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
>                 return IOMMU_DOMAIN_DMA;
>
>         if (ops->def_domain_type)
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c967ad6e2626..477c16ba9341 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
>         if (!dev->ats_cap)
>                 return false;
>
> -       return (dev->untrusted == 0);
> +       return (dev->untrusted_dma == 0);
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 378e05096c52..1d5a284c3661 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1362,7 +1362,7 @@ static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
>                 return;
>
>         if (val)
> -               dev->untrusted = 1;
> +               dev->untrusted_dma = 1;
>  }
>
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..1fb0eb8646c8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>         ctrl |= (cap & PCI_ACS_UF);
>
>         /* Enable Translation Blocking for external devices and noats */
> -       if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +       if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>                 ctrl |= (cap & PCI_ACS_TB);
>
>         pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..d2a9b26fcede 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>                 dev->is_thunderbolt = 1;
>  }
>
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_untrusted_dma(struct pci_dev *dev)
>  {
>         struct pci_dev *parent;
>
> @@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>          * untrusted as well.
>          */
>         parent = pci_upstream_bridge(dev);
> -       if (parent && (parent->untrusted || parent->external_facing))
> -               dev->untrusted = true;
> +       if (parent && (parent->untrusted_dma || parent->external_facing))
> +               dev->untrusted_dma = true;
>  }
>
>  static void pci_set_removable(struct pci_dev *dev)
> @@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
>         /* Need to have dev->cfg_size ready */
>         set_pcie_thunderbolt(dev);
>
> -       set_pcie_untrusted(dev);
> +       pci_set_untrusted_dma(dev);
>
>         /* "Unknown power state" */
>         dev->current_state = PCI_UNKNOWN;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5f46fed01e6c..7ca3c2cdfb20 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5134,7 +5134,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>         ctrl |= (cap & PCI_ACS_CR);
>         ctrl |= (cap & PCI_ACS_UF);
>
> -       if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +       if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>                 ctrl |= (cap & PCI_ACS_TB);
>
>         pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 678fecdf6b81..b7c5fede0b93 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,13 +444,14 @@ struct pci_dev {
>         unsigned int    shpc_managed:1;         /* SHPC owned by shpchp */
>         unsigned int    is_thunderbolt:1;       /* Thunderbolt controller */
>         /*
> -        * Devices marked being untrusted are the ones that can potentially
> +        * Devices marked with untrusted_dma are the ones that can potentially
>          * execute DMA attacks and similar. They are typically connected
>          * through external ports such as Thunderbolt but not limited to
>          * that. When an IOMMU is enabled they should be getting full
>          * mappings to make sure they cannot access arbitrary memory.
>          */
> -       unsigned int    untrusted:1;
> +       unsigned int    untrusted_dma:1;
> +
>         /*
>          * Info from the platform, e.g., ACPI or device tree, may mark a
>          * device as "external-facing".  An external-facing device is
> --
> 2.35.1.1021.g381101b075-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
