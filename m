Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C568DC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:43:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81624206E6
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zo3wvxog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81624206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2489524368;
	Thu,  4 Jun 2020 14:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWPk1ZbPkWxy; Thu,  4 Jun 2020 14:43:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3193E23C58;
	Thu,  4 Jun 2020 14:43:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1555DC0888;
	Thu,  4 Jun 2020 14:43:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA4B7C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 851AD204E0
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQPovKjGumoa for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 14:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 3AFFB2033E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:43:54 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id v19so5510554wmj.0
 for <iommu@lists.linux-foundation.org>; Thu, 04 Jun 2020 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yrASyIBKHCebzBxwD+z9Y0Sx5KbX3AIS9EOUj/OsSEo=;
 b=Zo3wvxog4XFHb/YVpFj4s9xIrygC0gzFBySBqQZNw7sr6x//M1pIwpzb6eQiSawvt/
 lXxfDok/0izwAEybNnTwAlSClKsymf6ZNbvvqTZLcPoh0JmS53YoboI/Bc0cBmXUvBbS
 47R63jy0oSFePYBS0HLNUfVRO7FXvurSl7qQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yrASyIBKHCebzBxwD+z9Y0Sx5KbX3AIS9EOUj/OsSEo=;
 b=DmE7OEz+woSxg55xxKoewokH9w8s8E4HyqikED7JTjgtOWruYGZO1KsFqmxWs+9Xer
 e34Ovt9152co4rZdjBWuJZVZTvuEqcFyb76yRkOKw9RiRa3F6HQa431N8+U7IW0V+kWY
 qIqurzstt+EZDN9WcN/AsiX7QgWeQvCKEeyq9Oql0xhZPyXpLnWqnAsBEbxEMQeReVKV
 thLWdqkv7B9aJ/6dGa+3G1N8xfyRWT4KsvAwYMuNaFZgODeEtPBOJi4XGaRq558JKj0W
 xajz1Kw2xh5EWPBrQ8wHmupXVc+MGmlMUVM2eIQ9yQDS1aRHDmwgXWtdWPmEaYaKthQ2
 2Bzg==
X-Gm-Message-State: AOAM5305RuXqmWIUOIb8ackD4nslvA2gcYoCT1FPRXRdudWF7cT0LwgK
 kKhjniGcWO6VUMuNhEUH3sx34G5u6vY6/4XrqHS+cw==
X-Google-Smtp-Source: ABdhPJy6GhgxHSoger2ydUB8Z1ZADSP9s4xA+lVSOwpsNuaVTZK6gajJRSMryuNCt8+GdDFZpv9MjKz43PH9YKwUNdE=
X-Received: by 2002:a1c:4405:: with SMTP id r5mr4582574wma.72.1591281832459;
 Thu, 04 Jun 2020 07:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-10-james.quinlan@broadcom.com>
 <20200604110455.GO30374@kadam>
 <CA+-6iNyaL8izv5eHJyYkhwu9diPsqT0AD08UU_ECexNcdrT+jA@mail.gmail.com>
 <20200604141857.GH22511@kadam>
In-Reply-To: <20200604141857.GH22511@kadam>
Date: Thu, 4 Jun 2020 10:43:40 -0400
Message-ID: <CA+-6iNwF6gwkCVBtbWcp-frCG01LddFprqo7UeWJZ3bzDwG8zw@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] device core: Introduce multiple dma pfn offsets
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Will Deacon <will@kernel.org>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 ACPI/arm64" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
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

On Thu, Jun 4, 2020 at 10:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jun 04, 2020 at 09:48:49AM -0400, Jim Quinlan wrote:
> > > > +     r = devm_kcalloc(dev, 1, sizeof(struct dma_pfn_offset_region),
> > > > +                      GFP_KERNEL);
> > >
> > > Use:    r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
> > Will fix.
> >
> > >
> > >
> > > > +     if (!r)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     r->uniform_offset = true;
> > > > +     r->pfn_offset = pfn_offset;
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > This function doesn't seem to do anything useful.  Is part of it
> > > missing?
> > No, the uniform pfn offset is a special case.
>
> Sorry, I wasn't clear.  We're talking about different things.  The code
> does:
>
>         r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
>         if (!r)
>                 return -ENOMEM;
>
>         r->uniform_offset = true;
>         r->pfn_offset = pfn_offset;
>
>         return 0;
>
> The code allocates "r" and then doesn't save it anywhere so there is
> no point.
You are absolutely right, sorry I missed your point.  Will fix.

Thanks,
Jim Quinlan

>
> regards,
> dan carpenter
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
