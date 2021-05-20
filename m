Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C621C433ED
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2081613B0
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2081613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DBCB83DFF;
	Thu, 20 May 2021 14:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7e_2z_fmpqBJ; Thu, 20 May 2021 14:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63FB883B9E;
	Thu, 20 May 2021 14:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7E0C000D;
	Thu, 20 May 2021 14:01:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5EF2C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D411860BBD
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Te4v6yYnrdGg for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4010B607BE
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:01:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB2CA613DD
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621519274;
 bh=Ge7XZxLDW+zMOSFfG3zNBpDQtYmYLTcf7b+kJArHktY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kcfbk3PTJlyH3WsFAtlj2mZ4X9aUQ3iCidACFlNhz/CMFskrQzHU0QjNbP+B6xoVA
 SVQiCf63t4AIf/BH4O9jahKeIwLF0M/e/RarR9tHFULAIuv+ICmhY4g9OR0cK6D65p
 RlorI0oyxNAEYM/8RsOiUiWhuMHLzBvTnj5krvHVOG+0GW9OGMhSYe1QojtsoQeZ+U
 lsMB7ojn0Xl0PnDFEpbOcRIMurodzyxQzbFj7TPdGfSOyITKfRIP0AgfP2KwVW6gTs
 3Y9HJIsB+NMPqv9OFSXW2uZRG8r1BkbwIROIckf2PQX6vYRSZm1MCLmFXkBNYBxOfY
 zTtv6qhw8Ve8w==
Received: by mail-ed1-f53.google.com with SMTP id t15so19525237edr.11
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:01:14 -0700 (PDT)
X-Gm-Message-State: AOAM531/oLNImmEB0LLYyfSBB+A/YW61+3WLP+sZtyFK9PPl/3QGvBmF
 4PeBEemQn9Wz/deLsvag1SsT/Pfn9ZHruGCvnw==
X-Google-Smtp-Source: ABdhPJygU39SIGejwYFMYlAUxTlCuIit4tLdWH8lb/SAqwmEiZrm2Uy7YrF+M/9NQti0/RvkcjX4BV5Aa30TfpucGfQ=
X-Received: by 2002:a05:6402:c7:: with SMTP id
 i7mr5293139edu.194.1621519273257; 
 Thu, 20 May 2021 07:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
In-Reply-To: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 20 May 2021 09:00:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUjUN2c8XzCoL7xepb5xZHLQktqTSekYva6bGEZ5Sx2g@mail.gmail.com>
Message-ID: <CAL_JsqKUjUN2c8XzCoL7xepb5xZHLQktqTSekYva6bGEZ5Sx2g@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Wang Xingang <wangxingang5@huawei.com>
Cc: xieyingtai@huawei.com, Will Deacon <will@kernel.org>,
 PCI <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 20, 2021 at 2:28 AM Wang Xingang <wangxingang5@huawei.com> wrote:
>
> From: Xingang Wang <wangxingang5@huawei.com>
>
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
>
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c                 |  1 -
>  drivers/pci/controller/pci-host-common.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>                         .np = master_np,
>                 };
>
> -               pci_request_acs();
>                 err = pci_for_each_dma_alias(to_pci_dev(dev),
>                                              of_pci_iommu_init, &info);
>         } else {
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d3924a44db02..5904ad0bd9ae 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c

This file is generally only for ECAM compliant hosts. Are those the
only hosts we need to support this? From the looks of dts files with
iommu-map, that would be dropping support in lots of cases.

Perhaps in devm_of_pci_bridge_init() or one of the functions it calls
is the better place.

> @@ -49,6 +49,21 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>         return cfg;
>  }
>
> +static void pci_host_enable_acs(struct pci_host_bridge *bridge)
> +{
> +       struct device_node *np = bridge->dev.parent->of_node;
> +       static bool acs_enabled;
> +
> +       if (!np || acs_enabled)
> +               return;
> +
> +       /* Detect IOMMU and make sure ACS will be enabled */
> +       if (of_property_read_bool(np, "iommu-map")) {
> +               acs_enabled = true;
> +               pci_request_acs();

Given this function just sets a variable, I don't think you need the
static acs_enabled here.

> +       }
> +}
> +
>  int pci_host_common_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -81,6 +96,8 @@ int pci_host_common_probe(struct platform_device *pdev)
>         bridge->ops = (struct pci_ops *)&ops->pci_ops;
>         bridge->msi_domain = true;
>
> +       pci_host_enable_acs(bridge);
> +
>         return pci_host_probe(bridge);
>  }
>  EXPORT_SYMBOL_GPL(pci_host_common_probe);
> --
> 2.19.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
