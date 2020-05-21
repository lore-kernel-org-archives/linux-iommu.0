Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD931C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:02:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C18520825
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiYUJx3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C18520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42C15884D9;
	Thu, 21 May 2020 23:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDUt5q+csQWo; Thu, 21 May 2020 23:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B16C8884CC;
	Thu, 21 May 2020 23:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97FE5C088B;
	Thu, 21 May 2020 23:02:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01FD0C0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDC3620418
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HErfq+qBhXPj for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 23:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id A37A2203ED
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:02:32 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 497AF20885
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590102152;
 bh=u4I01Bd2QyL8HPxDkUrMsX0HSNDq0LynubrHvmfSbXA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RiYUJx3r0NSHRBi8CE9gwpJPXRgz5WqYyZuoDvG/k/mV29oeCTMPA50Plh9HX9ac9
 ymVWclaGK1LCxKJKteoWzNj5exfqEiApBISSekxqsOLadecgNFhpB0S6E23smC/RO1
 UqBvA944tDh1FRa8/kjEC+nhcFSqtsgenhggmGKc=
Received: by mail-oi1-f174.google.com with SMTP id i22so7686491oik.10
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 16:02:32 -0700 (PDT)
X-Gm-Message-State: AOAM532cWYQsieScopxX/EZ4P0/nsSQD343aG6LWG0kjqy9kzdNWHu1n
 YKHxBgqep9+Qh7rZWEyPF6wrvHBGGzlLGvWWXQ==
X-Google-Smtp-Source: ABdhPJyTEOAtWUCXqQRm64QnwpCZ0isYcN6LyugKOxRT91W8qbotthhsTXaUlNcGWLVO8KSMeec5LvCcv0JMwyl2JAA=
X-Received: by 2002:a05:6808:7cb:: with SMTP id
 f11mr710834oij.152.1590102151546; 
 Thu, 21 May 2020 16:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200521130008.8266-8-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 May 2020 17:02:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJw3wyiUrbd1AekwDc5+uqhHi9BwoB-rYpypUEGNgzCtw@mail.gmail.com>
Message-ID: <CAL_JsqJw3wyiUrbd1AekwDc5+uqhHi9BwoB-rYpypUEGNgzCtw@mail.gmail.com>
Subject: Re: [PATCH 07/12] of/device: Add input id to of_dma_configure()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>,
 PCI <linux-pci@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Devices sitting on proprietary busses have a device ID space that
> is owned by the respective bus and related firmware bindings. In order
> to let the generic OF layer handle the input translations to
> an IOMMU id, for such busses the current of_dma_configure() interface
> should be extended in order to allow the bus layer to provide the
> device input id parameter - that is retrieved/assigned in bus
> specific code and firmware.
>
> Augment of_dma_configure() to add an optional input_id parameter,
> leaving current functionality unchanged.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  4 ++-
>  drivers/iommu/of_iommu.c        | 53 +++++++++++++++++++++------------
>  drivers/of/device.c             |  8 +++--
>  include/linux/of_device.h       | 16 ++++++++--
>  include/linux/of_iommu.h        |  6 ++--
>  5 files changed, 60 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..8ead3f0238f2 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -118,11 +118,13 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  static int fsl_mc_dma_configure(struct device *dev)
>  {
>         struct device *dma_dev = dev;
> +       struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> +       u32 input_id = mc_dev->icid;
>
>         while (dev_is_fsl_mc(dma_dev))
>                 dma_dev = dma_dev->parent;
>
> -       return of_dma_configure(dev, dma_dev->of_node, 0);
> +       return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
>  }
>
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index ad96b87137d6..4516d5bf6cc9 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -139,25 +139,53 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>         return err;
>  }
>
> -static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> -                               struct device_node *master_np)
> +static int of_iommu_configure_dev_id(struct device_node *master_np,
> +                                    struct device *dev,
> +                                    const u32 *id)

Should have read this patch before #6. I guess you could still make
of_pci_iommu_init() call
of_iommu_configure_dev_id.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
