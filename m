Return-Path: <SRS0=+Z17=BJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F165C433E0
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 17:25:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2F520663
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 17:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AkMCmmdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2F520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97E7F86DE1;
	Thu, 30 Jul 2020 17:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nWfm6IzuWSNn; Thu, 30 Jul 2020 17:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C68DF86DD6;
	Thu, 30 Jul 2020 17:25:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB5EDC004F;
	Thu, 30 Jul 2020 17:25:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D014C004D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A670884F6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3u0hOHdYXr0G for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 17:25:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3B29A884CC
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:25:54 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r12so25594843wrj.13
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sNCo6OJL+Y5+7WCILwksqAoVSYtXLlNGjRLNsvxRptk=;
 b=AkMCmmdx4ZYztnIqSxTU7eHQ7kz3Bgwfdvyvk3PbB8Ufzi1fnd6wpYsukRza3AjZKO
 f9GrP+jyVuj94/4zxrK7UVD3fTxTX4QTD6xD49ZS3okDsAmexy29Vj0VOeVrFGIWgf9c
 5J0nRQGVZGHveCiYa7R8OIsik4aMGkHCjpHrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sNCo6OJL+Y5+7WCILwksqAoVSYtXLlNGjRLNsvxRptk=;
 b=dxYjbvfnc5XptzfX71g1GCKfYZls/r57NOmt2ZyXCz3XuZSwTYe5oVnCzwgoLFhIWV
 AKYBQkZNJO1AHw7HzKkC/HbjphS4CNXv/lndccU1aznzJGI8D6ZnZG9k4r3qxmzvXbY3
 8SEAROKBx1blcemZOHvWRn4kUtvzAfLjTRx2idh9o05gchD8FSifrU885wfJsBG2IDvt
 5DsZ4nfzkF0hsLyhvWw4ZuYTlSSvuISl478dBZkqO9GoiKeEOrYHSwTDs+wPNUcdYYfg
 F2YqsxyPTCyDkrvjGnwx5QzgHbqtsN7Pm9+EyjZq+728qoVD5t1L9ogND9d6CXr20siD
 qlKQ==
X-Gm-Message-State: AOAM5319E/Zurhu9ILgljXgP61Uto4rr6fEpToRH3fHZVwuU7syMYp1U
 Omo43JkLMkKPvoGRjhc6AREYr7mWnKsB9Yn/Di1htQ==
X-Google-Smtp-Source: ABdhPJxTkYgyrGJD0qoy7N/a5I5qMSrg3FcI44+ukNzAvdEAsGO6nqACjClSIjeMLjqunOwwyXtKLsvE1bArMJ5wOXQ=
X-Received: by 2002:adf:9501:: with SMTP id 1mr27386326wrs.413.1596129952322; 
 Thu, 30 Jul 2020 10:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-9-james.quinlan@broadcom.com>
 <e0a46f4cd0a603801d343c15d807d0f08c42e900.camel@suse.de>
In-Reply-To: <e0a46f4cd0a603801d343c15d807d0f08c42e900.camel@suse.de>
Date: Thu, 30 Jul 2020 13:25:40 -0400
Message-ID: <CA+-6iNzWYvX_7G8=EOMt5X5U8_csymyvDwKVUwRBzw_dF_YYjQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 30, 2020 at 1:05 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Jim,
>
> On Fri, 2020-07-24 at 16:33 -0400, Jim Quinlan wrote:
> >  static void __init of_unittest_pci_dma_ranges(void)
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index bfc2542d54a8..8dacb9d3b7b6 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1197,6 +1197,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       ret = brcm_phy_start(pcie);
> >       if (ret) {
> >               dev_err(pcie->dev, "failed to start phy\n");
> > +             reset_control_assert(pcie->rescal);
> >               return ret;
> >       }
>
> I think this sneaked in from another patch.
Thanks Nicolas.  BTW, at some point will you be able to test my
patchset on the RP4 to see if I broke anything?

Thanks again,
Jim

>
> Regards,
> Nicolas
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
