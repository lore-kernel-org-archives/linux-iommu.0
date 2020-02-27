Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C8C11D3D
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 20:55:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E19B246A1
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 20:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1eIeXpS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E19B246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 690D623109;
	Thu, 27 Feb 2020 20:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90gLhCMjejis; Thu, 27 Feb 2020 20:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1D242204C3;
	Thu, 27 Feb 2020 20:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB479C08A0;
	Thu, 27 Feb 2020 20:55:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D31FAC0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 20:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B96CB86D64
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 20:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oU9JSDm2uJAE for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 20:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF54886D37
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 20:55:42 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A6272468E;
 Thu, 27 Feb 2020 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582836942;
 bh=uo4pZ8pLnVJHt+X+KMHCkfw/S+qxfnVMzkyq2/sf/Q8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=1eIeXpS8HUAIuUBh9/tzJuBcJ+ccfhZwy41bHiqBUgYJacHs6Foi3Fg+K1o0I5KxN
 l5ZbqG+I0Te3bfwhBiAh3/eAUDZf/RsiG2jjBDNWyh3sOrAlZIAHTZEx57qWphCB27
 kuhWQ9DqHskFidgv7Jb6SxLtKoRz7JESO1q4DHg8=
Date: Thu, 27 Feb 2020 14:55:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 25/26] PCI/ATS: Export symbols of PRI functions
Message-ID: <20200227205540.GA131096@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-26-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

Subject could be simply "PCI/ATS: Export PRI functions"

On Mon, Feb 24, 2020 at 07:24:00PM +0100, Jean-Philippe Brucker wrote:
> The SMMUv3 driver uses pci_{enable,disable}_pri() and related
> functions. Export those functions to allow the driver to be built as a
> module.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index bbfd0d42b8b9..fc8fc6fc8bd5 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
>  	if (status & PCI_PRI_STATUS_PASID)
>  		pdev->pasid_required = 1;
>  }
> +EXPORT_SYMBOL_GPL(pci_pri_init);
>  
>  /**
>   * pci_enable_pri - Enable PRI capability
> @@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_enable_pri);
>  
>  /**
>   * pci_disable_pri - Disable PRI capability
> @@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_reset_pri);
>  
>  /**
>   * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> @@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  
>  	return pdev->pasid_required;
>  }
> +EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>  #endif /* CONFIG_PCI_PRI */
>  
>  #ifdef CONFIG_PCI_PASID
> -- 
> 2.25.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
