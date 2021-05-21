Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD1C47076
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 19:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1655613AD
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 19:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1655613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EA2283D45;
	Fri, 21 May 2021 19:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnhYnSl9SPaZ; Fri, 21 May 2021 19:03:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 549E083D19;
	Fri, 21 May 2021 19:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB95C000E;
	Fri, 21 May 2021 19:03:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1509DC0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 19:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E199E4026E
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 19:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJS6mb1OTGn0 for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 19:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15EE1401F3
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 19:03:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A036E613DF
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621623815;
 bh=Lb4zWukxynJKdO2B6fwy3BzW7bBXcRFkXw0A4mCRUHQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=G1VmxBiFqfMxKCZgUxm5/dufKpsN8UooefbIEeO+qjKy8iJR9nZ5AyV6zhRALRsXR
 80XmULrvhGK4sQmdheZYFU2czJEzljEQZqEFOZdA0nq0/OeBbwhaEHkM7EpLq8WYsR
 L54ePSUyOqlooWI2ug0A+/Lv+6cZw8YAhpRY4zZzzfRwTEJG+ocKZC10rZtv/V1kOX
 KpK4q29X3FCc5i3zZ5l2tDdpnxEbk+YREHCkQdzrNQYjPwiNd4ovuKHSaAnq9+PtcR
 2v9HI0MZQ0uOQOyST+x61zP9qjTNaQQC5YDsZOJshzsn78twFLYVYga2dEjwUFMMVm
 15TWWEw8mCQ4w==
Received: by mail-ej1-f50.google.com with SMTP id f18so1792346ejq.10
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 12:03:35 -0700 (PDT)
X-Gm-Message-State: AOAM5320Uxe5/3nj6vTxjRVOOZ58tI/3LLIGwxpOis+IdVWzZWnucpSJ
 w8BiFKFuY0pJYrP/GplDGYiiUEUStx7g4Icx5g==
X-Google-Smtp-Source: ABdhPJzTd/Izr3P8oRUa1vk5tbtMeKhoGatTazTM5IQhKTJl5fJ+reQP7EFsCN74T8NNpYBMngBLD9DRlthlOPfJv7s=
X-Received: by 2002:a17:907:76b8:: with SMTP id
 jw24mr11708266ejc.359.1621623814193; 
 Fri, 21 May 2021 12:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 21 May 2021 14:03:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
Message-ID: <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Wang Xingang <wangxingang5@huawei.com>
Cc: xieyingtai@huawei.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, PCI <linux-pci@vger.kernel.org>,
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

On Thu, May 20, 2021 at 10:03 PM Wang Xingang <wangxingang5@huawei.com> wrote:
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
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

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
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..2313c3f848b0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  {
> -       if (!dev->of_node)
> +       struct device_node *node = dev->of_node;
> +
> +       if (!node)
>                 return 0;
>
> +       /* Detect IOMMU and make sure ACS will be enabled */
> +       if (of_property_read_bool(node, "iommu-map"))
> +               pci_request_acs();
> +
>         bridge->swizzle_irq = pci_common_swizzle;
>         bridge->map_irq = of_irq_parse_and_map_pci;
>
> --
> 2.19.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
