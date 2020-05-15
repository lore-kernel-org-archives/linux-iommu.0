Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2784FC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 21:18:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83900205CB
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 21:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYw1rXpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83900205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 407DE89689;
	Fri, 15 May 2020 21:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QD1rbxOJqmdq; Fri, 15 May 2020 21:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 92E1189569;
	Fri, 15 May 2020 21:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 841EBC0859;
	Fri, 15 May 2020 21:18:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8B33C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9D8AC87E6A
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjpvGu8AAkTR for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 21:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E2FD87E09
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:18:23 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99B7F205CB;
 Fri, 15 May 2020 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589577503;
 bh=ZQ43XWvnomP6iief7qgRRbmyG/Bi9bziKV7eLxey5z8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=iYw1rXpYC7+iTiovQH69ZJN7ikDy6fxVEhYEdV1ssHJazsWRNLymxAPARP3cwPsrF
 MgKv6QPMsHDyZenI3gXiYZA2LWLuoVh7agD+i9unX1itmKntZUFYS9KRoZeKACj6y1
 SvAGo7FPYdfzQx+wZlqZKyL/uju5rWadJrrwKKik=
Date: Fri, 15 May 2020 16:18:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] PCI/ATS: Only enable ATS for trusted devices
Message-ID: <20200515211820.GA545575@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515104359.1178606-2-jean-philippe@linaro.org>
Cc: alex.williamson@redhat.com, ashok.raj@intel.com, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, iommu@lists.linux-foundation.org, bhelgaas@google.com,
 will@kernel.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, May 15, 2020 at 12:43:59PM +0200, Jean-Philippe Brucker wrote:
> Add pci_ats_supported(), which checks whether a device has an ATS
> capability, and whether it is trusted.  A device is untrusted if it is
> plugged into an external-facing port such as Thunderbolt and could be
> spoof an existing device to exploit weaknesses in the IOMMU
> configuration.  PCIe ATS is one such weaknesses since it allows
> endpoints to cache IOMMU translations and emit transactions with
> 'Translated' Address Type (10b) that partially bypass the IOMMU
> translation.
> 
> The SMMUv3 and VT-d IOMMU drivers already disallow ATS and transactions
> with 'Translated' Address Type for untrusted devices.  Add the check to
> pci_enable_ats() to let other drivers (AMD IOMMU for now) benefit from
> it.
> 
> By checking ats_cap, the pci_ats_supported() helper also returns whether
> ATS was globally disabled with pci=noats, and could later include more
> things, for example whether the whole PCIe hierarchy down to the
> endpoint supports ATS.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci-ats.h |  3 +++
>  drivers/pci/ats.c       | 18 +++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index d08f0869f1213e..f75c307f346de9 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -6,11 +6,14 @@
>  
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
> +bool pci_ats_supported(struct pci_dev *dev);
>  int pci_enable_ats(struct pci_dev *dev, int ps);
>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);
>  #else /* CONFIG_PCI_ATS */
> +static inline bool pci_ats_supported(struct pci_dev *d)
> +{ return false; }
>  static inline int pci_enable_ats(struct pci_dev *d, int ps)
>  { return -ENODEV; }
>  static inline void pci_disable_ats(struct pci_dev *d) { }
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f2d8d1fc..15fa0c37fd8e44 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,22 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +/**
> + * pci_ats_supported - check if the device can use ATS
> + * @dev: the PCI device
> + *
> + * Returns true if the device supports ATS and is allowed to use it, false
> + * otherwise.
> + */
> +bool pci_ats_supported(struct pci_dev *dev)
> +{
> +	if (!dev->ats_cap)
> +		return false;
> +
> +	return !dev->untrusted;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_supported);
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -42,7 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	u16 ctrl;
>  	struct pci_dev *pdev;
>  
> -	if (!dev->ats_cap)
> +	if (!pci_ats_supported(dev))
>  		return -EINVAL;
>  
>  	if (WARN_ON(dev->ats_enabled))
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
