Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F7C43141
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 15:53:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A66720803
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 15:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMiFXHmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A66720803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56C4D86A53;
	Tue,  3 Dec 2019 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRJUooQ2PGE9; Tue,  3 Dec 2019 15:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BDCC086783;
	Tue,  3 Dec 2019 15:53:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AA4C1799;
	Tue,  3 Dec 2019 15:53:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAF6C087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 86C15226D3
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ0uUan9bxQd for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 15:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id CFE9420107
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:53:24 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AF652073C
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575388404;
 bh=cKUlQJxyEbNNE534SxNpTQSfjp4RJhfRU1TUcm+QH08=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dMiFXHmpNBjs6cKOB8CvjUJiJ6u9uJDyuZKrCWaPzddVAcec4y8Tf8b0hxgHJCdRV
 Vw7p8wFgb2ERIDgsVwocw6j+XwLGjCncIbAx7ygjoAl5f5VqxwXTwGbILn3LugM8vM
 96Hi6Mac947zfCjwa8gODuJ05eslnEL0H1rHwIbU=
Received: by mail-pf1-f176.google.com with SMTP id s18so2057881pfm.4
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 07:53:24 -0800 (PST)
X-Gm-Message-State: APjAAAUCd9TseREpf9zHjSx3YwZ2vHACL7SfhRI+6NUKZ9A9iyc/qZ2F
 rEQV6kWm7HF1HLEKH0bTHmOEl3R8Og8jXVZU4w==
X-Google-Smtp-Source: APXvYqyICjW3HYnUPFqTgR4rEp2A1uuQE3BOephqhDMI2H3gFhNk2aTw/xPKbNHQEIKUpgOnuSfcOdrza+JvE1yn/H8=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr5459306qvu.136.1575388397912; 
 Tue, 03 Dec 2019 07:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
 <20191203114743.1294-9-nsaenzjulienne@suse.de>
In-Reply-To: <20191203114743.1294-9-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 3 Dec 2019 09:53:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMCXdnZag3jihV_dzuR+wFaVKFb7q_PdKTxTg0LVA6cw@mail.gmail.com>
Message-ID: <CAL_JsqLMCXdnZag3jihV_dzuR+wFaVKFb7q_PdKTxTg0LVA6cw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] linux/log2.h: Use roundup/dow_pow_two() on 64bit
 calculations
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Heiko Stuebner <heiko@sntech.de>, PCI <linux-pci@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Eric Anholt <eric@anholt.net>,
 Hanjun Guo <guohanjun@huawei.com>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Phil Elwell <phil@raspberrypi.org>, linux-acpi@vger.kernel.org,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <mbrugger@suse.com>,
 netdev <netdev@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
 Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
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

On Tue, Dec 3, 2019 at 5:48 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The function now is safe to use while expecting a 64bit value. Use it
> where relevant.

What was wrong with the existing code? This is missing some context.

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/acpi/arm64/iort.c                        | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c    | 3 ++-
>  drivers/of/device.c                              | 3 ++-

In any case,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 ++-
>  drivers/pci/controller/cadence/pcie-cadence.c    | 3 ++-
>  drivers/pci/controller/pcie-brcmstb.c            | 3 ++-
>  drivers/pci/controller/pcie-rockchip-ep.c        | 5 +++--
>  kernel/dma/direct.c                              | 2 +-
>  8 files changed, 15 insertions(+), 9 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
