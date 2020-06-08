Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A66C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 15:49:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6499D206C3
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 15:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XPgpdZtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6499D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 39E66881CC;
	Mon,  8 Jun 2020 15:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nwEwXGRH7Vo; Mon,  8 Jun 2020 15:49:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1FDC3881A4;
	Mon,  8 Jun 2020 15:49:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02DC5C0863;
	Mon,  8 Jun 2020 15:49:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8595C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 15:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BE48D2152A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 15:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7iV6FkmvCavh for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 15:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id B133C207A1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 15:49:04 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f185so2623wmf.3
 for <iommu@lists.linux-foundation.org>; Mon, 08 Jun 2020 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Zatdh65W3aH6MhJdNTH/AWqzt1N9QOAuNbG/kKQoQk=;
 b=XPgpdZtMZfiMPg5da4wdaof5iSzhA/ZVCghQbqTrDuqbo6ZHBkJ+6hzW6Rtuswt2th
 CucS7L68rAc9A2OMX3t2hThgLQkSf86045BbVp0BSipvykLwZzc3TREpeZqGeurMVBb8
 4aYqZctCI+0ceRS4poPN+NvTaALqxbr51DJqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Zatdh65W3aH6MhJdNTH/AWqzt1N9QOAuNbG/kKQoQk=;
 b=h3vXAON60TPWBbCu7yuKNVKtsDxr4nKGu1TEFNa6yiTkkZFRwuhszgXT+4LHgGm6b/
 jzvO4g4chCMVbHc+WTBMpPiYV1BAvV+f26IJVPWmvT5hfMg/YoFW0lBaJWopCMNlfJc/
 g+bA3WYynKK0ni/PnlU/H5nuqqlAetjvwlKarZBKNwEmyIlbh2k2PISawZWUS/nDwvMa
 g9weZtGAHSuxSkJmHZJ7SnZqm/En2yPTY/R6DwAOQHoM8uZDMLjjswnAAMROH69T1NeX
 cVIGrDXlX8xWmX88aW4V8CMUUyH8lEZmIFvHsmspI2ImYxu73W4FhegiWFdNZliRpV9c
 FG3g==
X-Gm-Message-State: AOAM532ynV3yiD8rzLlGrhEarXFI/Oykz6lXRjPSdPTXqTwuIP2lIf3A
 krcMctbfbw+GhTJ+EYTVv3EMDppOO0ADa+g8ky4Amw==
X-Google-Smtp-Source: ABdhPJwc8WgkB5baQneSP3O56E527r0CcFTd8E6eqmfIQH4X1bWsduigHTlQQV7Hic/QVkEEt7XICj+d1DgqVMzgDVk=
X-Received: by 2002:a7b:c44a:: with SMTP id l10mr19134wmi.92.1591631342886;
 Mon, 08 Jun 2020 08:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
 <20200605212706.7361-9-james.quinlan@broadcom.com>
 <20200607164950.GX2428291@smile.fi.intel.com>
In-Reply-To: <20200607164950.GX2428291@smile.fi.intel.com>
Date: Mon, 8 Jun 2020 11:48:51 -0400
Message-ID: <CA+-6iNyL12Z+igSrWnsmTzrwzyyeDtSK-9ULiZe0MwM5LO5bjQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] device core: Introduce multiple dma pfn offsets
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Wolfram Sang <wsa@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
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
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

Hi Andy,

On Sun, Jun 7, 2020 at 12:500f9bfe0fb8840b268af1bbcc51f1cd440514e PM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jun 05, 2020 at 05:26:48PM -0400, Jim Quinlan wrote:
> > The new field in struct device 'dma_pfn_offset_map' is used to facilitate
> > the use of single or multiple pfn offsets between cpu addrs and dma addrs.
> > It subsumes the role of dev->dma_pfn_offset -- a uniform offset.
> >
> > The function of_dma_get_range() has been modified to take two additional
> > arguments: the "map", which is an array that holds the information
> > regarding the pfn offset regions, and map_size, which is the size in bytes
> > of the map array.
> >
> > of_dma_configure() is the typical manner to set pfn offsets but there are a
> > number of ad hoc assignments to dev->dma_pfn_offset in the kernel driver
> > code.  These cases now invoke the function
> > dma_attach_uniform_pfn_offset(dev, pfn_offset).
>
> ...
>
> > +             int ret = dma_attach_uniform_pfn_offset
> > +                             (dev, keystone_dma_pfn_offset);
>
> It's strange indentation. Have you configured your editor correctly?
> Seems to me as fit on one line.
I'm using emacs with the c-style set to linux.  I may have some custom
tweaks; I'll check into it.  But I think I can fix most of your
objections by using the max_line_length of 100.

>
> > +             dev_err(dev, "set dma_pfn_offset%08lx%s\n",
> > +                     dev->dma_pfn_offset, ret ? " failed" : "");
>
> ...
>
> > +     *map_size = (num_ranges + 1) * sizeof(**map);
> > +     r = kzalloc(*map_size, GFP_KERNEL);
>
> kcalloc()
Since I have to calculate the size anyway I thought kzalloc was fine.
I'll switch.
>
> > +     if (!r)
> > +             return -ENOMEM;
>
> ...
>
> > +             r->pfn_offset = PFN_DOWN(range.cpu_addr)
> > +                     - PFN_DOWN(range.bus_addr);
>
> Ditto (indentation).
>
> ...
>
>
> > +             unsigned long dma_pfn_offset
> > +                     = dma_pfn_offset_from_phys_addr(dev, paddr);
>
> Ditto.
>
> ...
>
> > +             unsigned long dma_pfn_offset
> > +                     = dma_pfn_offset_from_dma_addr(dev, dev_addr);
>
> Ditto.
>
> Check entire your series for a such, please!

Will do,
Thanks
Jim Quinlan
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
