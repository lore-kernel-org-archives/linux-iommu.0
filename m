Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5FC56202
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 15:33:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC1322404
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC1322404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E3C08871A6;
	Mon, 26 Oct 2020 15:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ta87ZMwFU-Fp; Mon, 26 Oct 2020 15:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 277AB87191;
	Mon, 26 Oct 2020 15:33:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 125B9C088B;
	Mon, 26 Oct 2020 15:33:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA70FC0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 15:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C372A871A6
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 15:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vJP2AZa92DCb for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 15:33:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6558987191
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 15:33:47 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id k65so10322363oih.8
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 08:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Npr8JFXnNVuOd5JBeJSU1d/jU6NcSqcvSBeX3MQnMCw=;
 b=VUchZLA10TcGTHBJPHMpCzH6/TnTP7jffddVUO+IGj8Wqg+C/hd7w2pWw67mGyJ/zg
 MWcOYaTHfFDC523upqDL0cCySIb0eUAFnxu0He8MickJEHkty+e6GdNwX4YckQbD0McQ
 jzX4C6LAmb6KdaNjTA578E7Y64q47q3Ot1v3kyrbUYpDkcOBgf9nnqNjhEb6rUUJsGNm
 JRfDxfcR4XUZkXwrVc19OUmqhclgTIuNMu3n3uKrt1CUvqvyk1s8kNZvUOf5b8qVDgDr
 AY9QzrQ991BSy4eh7IoSDq5ai2roAWAAy+kgPMTJHN0YZdbnRZmI6j63pEMtKvhN8xFL
 1Aug==
X-Gm-Message-State: AOAM533Cwn5JvTqKryc90ZOvLrOjgE1RPg9dKZyOmH+gZMJoFuRx/Wgk
 l3tbsXp4oxfXXvYlZ/c1TId6HNjUlGZz2O6O4po=
X-Google-Smtp-Source: ABdhPJwLqZF2nUpKrvhcxyI34nr4X7bBy8icWsJGObwdQ8i/5k3Ztdf2PJq2vrTAVMJP3VVhuKLd7HTBbICac/wUeIE=
X-Received: by 2002:aca:c490:: with SMTP id u138mr13399294oif.54.1603726426441; 
 Mon, 26 Oct 2020 08:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200916061500.1970090-1-hch@lst.de>
 <20200916061500.1970090-7-hch@lst.de>
In-Reply-To: <20200916061500.1970090-7-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2020 16:33:34 +0100
Message-ID: <CAMuHMdX9c0va_EqBw1wfD_JiVPpjiBPLzE88EmLGVLfVhECugw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map,
 supplanting dma_pfn_offset
To: Christoph Hellwig <hch@lst.de>, Jim Quinlan <james.quinlan@broadcom.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
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

Hi Christoph, Jim,

On Wed, Sep 16, 2020 at 8:30 AM Christoph Hellwig <hch@lst.de> wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> The new field 'dma_range_map' in struct device is used to facilitate the
> use of single or multiple offsets between mapping regions of cpu addrs and
> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> capable of holding a single uniform offset and had no region bounds
> checking.
>
> The function of_dma_get_range() has been modified so that it takes a single
> argument -- the device node -- and returns a map, NULL, or an error code.
> The map is an array that holds the information regarding the DMA regions.
> Each range entry contains the address offset, the cpu_start address, the
> dma_start address, and the size of the region.
>
> of_dma_configure() is the typical manner to set range offsets but there are
> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> driver code.  These cases now invoke the function
> dma_direct_set_offset(dev, cpu_addr, dma_addr, size).
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> [hch: various interface cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for your patch, which is now commit e0d072782c734d27
("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset") in
v5.10-rc1, and to which I have bisected a PCIe failure on R-Car M2-W
(r8a7791/koelsch).

The first PCI host bridge, containing USB, probes fine:

 pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
 pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
 pci-rcar-gen2 ee090000.pci: PCI: revision 11
 pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00]
 pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
 pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
 pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
 pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
 pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
 pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
 pci 0000:00:01.0: supports D1 D2
 pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
 pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
 pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
 pci 0000:00:02.0: supports D1 D2
 pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
 PCI: bus0: Fast back to back transfers disabled
 pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
 pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
 pci 0000:00:01.0: enabling device (0140 -> 0142)
 pci 0000:00:02.0: enabling device (0140 -> 0142)

The second PCI host bridge, connected to an (empty) PCIe slot, fails:

 pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
 pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff -> 0x00ee0c0000
 pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
 pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
 pci_bus 0001:01: root bus resource [bus 01]
 pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
 pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
 pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
 pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
 pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
 pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
 pci 0001:01:01.0: supports D1 D2
 pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
 pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
 pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
 pci 0001:01:02.0: supports D1 D2
 pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
 PCI: bus1: Fast back to back transfers disabled
 pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
 pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
 pci 0001:01:01.0: enabling device (0140 -> 0142)
 pci 0001:01:02.0: enabling device (0140 -> 0142)
-rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
-rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
-rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
-rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
-rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
-rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffffff -> 0x0040000000
-rcar-pcie fe000000.pcie:   IB MEM 0x0200000000..0x02ffffffff -> 0x0200000000
-rcar-pcie fe000000.pcie: PCIe link down
+rcar-pcie fe000000.pcie: Adjusted size 0x0 invalid
+rcar-pcie: probe of fe000000.pcie failed with error -22

I've posted a patch "[PATCH] dma-mapping: Fix 32-bit overflow with
CONFIG_ARM_LPAE=n"
(https://lore.kernel.org/linux-arm-kernel/20201026152755.3738293-1-geert+renesas@glider.be/).

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
