Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1028C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 00:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F2E3418E8;
	Thu, 24 Mar 2022 00:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2OoWltr9EK2; Thu, 24 Mar 2022 00:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62AC941716;
	Thu, 24 Mar 2022 00:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2C5C0012;
	Thu, 24 Mar 2022 00:56:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD998C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A01484A24
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfRfiCqP8YvI for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 00:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B64784A1E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:56:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 563CDB821BE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D43DC36AE7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648083382;
 bh=XSMKqdpowKS4zMvCRW3XKEofmZJCPSV9ivTALsgmfX4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=An5CKLeHdf7/9txpAWBQT75PHUaIKJQiQDM8zT+fgY5K4IReMRFnxObbn9JKa/Wz6
 f9viVtTMjnGHQqWjJAB7r97fH4xLbWQvWhn6dccCycwkf397M6Xxi31dWPoLf1ZF+A
 h6mibZDOk1v3wpqfLIDXNcHRqYzj7iRxGoN8VyJeoY4880AnXqaBOM7hkWfDMkpUZ1
 szeTTek7iOlRUL6970y8jCuE1QUK6594PHU2P35v399eS6WvhhEbkTt5KJmVr8X+ej
 V/Gm2uN6smVXWsuFUiL194blH8yG1wYmtA/ohgj1j5mJc/fTalwLJVuhnARvdZV9IX
 JIEcnFUVCPCgA==
Received: by mail-ed1-f50.google.com with SMTP id a17so3836484edm.9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 17:56:22 -0700 (PDT)
X-Gm-Message-State: AOAM532ohS6mP0EQRpROW6q1XUciDLT2FGQlvXvhN66eEfZiXlmy6WNz
 kSTC/YssHMxGKqhtJsCBRCybrzh6Bpx886aDuQ==
X-Google-Smtp-Source: ABdhPJxhys4zf4xJ/ElQl1YL++ni1FtQNwJ6wwUXDLE4HUeSgKvIp/cLZrb6m/ZE6iYoYVh73P3RMdX9df0/9o6w2Us=
X-Received: by 2002:a05:6402:2711:b0:419:5a50:75ef with SMTP id
 y17-20020a056402271100b004195a5075efmr3669523edd.280.1648083380394; Wed, 23
 Mar 2022 17:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
In-Reply-To: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Mar 2022 19:56:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
To: Robin Murphy <robin.murphy@arm.com>
Cc: PCI <linux-pci@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, dann frazier <dann.frazier@canonical.com>,
 Will Deacon <will@kernel.org>
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

On Tue, Mar 22, 2022 at 12:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Originally, creating the dma_ranges resource list in pre-sorted fashion
> was the simplest and most efficient way to enforce the order required by
> iova_reserve_pci_windows(). However since then at least one PCI host
> driver is now re-sorting the list for its own probe-time processing,
> which doesn't seem entirely unreasonable, so that basic assumption no
> longer holds. Make iommu-dma robust and get the sort order it needs by
> explicitly sorting, which means we can also save the effort at creation
> time and just build the list in whatever natural order the DT had.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Looking at this area off the back of the XGene thread[1] made me realise
> that we need to do it anyway, regardless of whether it might also happen
> to restore the previous XGene behaviour or not. Presumably nobody's
> tried to use pcie-cadence-host behind an IOMMU yet...
>
> Boot-tested on Juno to make sure I hadn't got the sort comparison
> backwards.
>
> Robin.
>
> [1] https://lore.kernel.org/linux-pci/20220321104843.949645-1-maz@kernel.org/
>
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  drivers/pci/of.c          |  7 +------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b22034975301..91d134c0c9b1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/iommu.h>
>  #include <linux/iova.h>
>  #include <linux/irq.h>
> +#include <linux/list_sort.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> @@ -414,6 +415,15 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>         return 0;
>  }
>
> +static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
> +               const struct list_head *b)
> +{
> +       struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
> +       struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
> +
> +       return res_a->res->start > res_b->res->start;
> +}
> +
>  static int iova_reserve_pci_windows(struct pci_dev *dev,
>                 struct iova_domain *iovad)
>  {
> @@ -432,6 +442,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>         }
>
>         /* Get reserved DMA windows from host bridge */
> +       list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
>         resource_list_for_each_entry(window, &bridge->dma_ranges) {
>                 end = window->res->start - window->offset;
>  resv_iova:
> @@ -440,7 +451,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>                         hi = iova_pfn(iovad, end);
>                         reserve_iova(iovad, lo, hi);
>                 } else if (end < start) {
> -                       /* dma_ranges list should be sorted */
> +                       /* DMA ranges should be non-overlapping */
>                         dev_err(&dev->dev,
>                                 "Failed to reserve IOVA [%pa-%pa]\n",
>                                 &start, &end);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..d176b4bc6193 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -393,12 +393,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>                         goto failed;
>                 }
>
> -               /* Keep the resource list sorted */
> -               resource_list_for_each_entry(entry, ib_resources)
> -                       if (entry->res->start > res->start)
> -                               break;
> -
> -               pci_add_resource_offset(&entry->node, res,

entry is now unused and causes a warning.

> +               pci_add_resource_offset(ib_resources, res,
>                                         res->start - range.pci_addr);
>         }
>
> --
> 2.28.0.dirty
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
