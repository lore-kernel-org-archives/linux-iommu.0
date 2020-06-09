Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7463C433E1
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 13:14:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7797020734
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 13:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gDaD4KM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7797020734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C8F420468;
	Tue,  9 Jun 2020 13:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djiU2hvC5Rmw; Tue,  9 Jun 2020 13:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2AFB720444;
	Tue,  9 Jun 2020 13:14:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 010A4C0863;
	Tue,  9 Jun 2020 13:14:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E245DC016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 13:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C79782226B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 13:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-nN6USQeJUM for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 13:14:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 8762720444
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 13:14:11 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id r15so3078767wmh.5
 for <iommu@lists.linux-foundation.org>; Tue, 09 Jun 2020 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edVNPE5DX3OyCq+2fyjI6ylHeS+GOPrCyMzTtU1/fzY=;
 b=gDaD4KM/t8KX5Al7J/BjBhHccNF2kg3Pg0xh6Ed7ue9e77HSVyYvClYpogccUWVa0o
 sqMFc5fMJ7AvbB7JFU4K1yuD3yD/zO0J0V9y9SHUHDSSvISS8BVLyTPvZRaUOKotLugh
 kY/jDSW0d+ynzLoQkWgw09J4fzf/weK6pnQL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edVNPE5DX3OyCq+2fyjI6ylHeS+GOPrCyMzTtU1/fzY=;
 b=MBrLyug7mwthPlzyEfT+W/DzOiAhP3rc8lgS6jzuxbrzLtmh73YuUt2KB5LqWwfesM
 qBq4NzwZBIWQXw4Rv/0blTWm9qun0ytyHqdghnqiQG9Pz1WtXavTn7T+HPPxVtdF8+ka
 R2UcqyLTrPla89pHJZWWFHvSB7FEFOKkSJfYNj9917yGUjWKf9f2cZd2HHGI3mlNXgob
 QIlGaxlFoPxPdDv1ptxhIO7QLmVZKF6qxhtz9T2KBzmCDEMDfEV9doWU2QDTwaHXeAA5
 XonnmYyXeqUfOhtPzS8x1BZBraQ6Un1GId9kvI+XneTYoa+HFXuBA4WuXFMIDVTdE3M0
 9EvQ==
X-Gm-Message-State: AOAM530TJ9Htqldyak58DR+bdafr/LgnkYU24Hst4bPBz6I4mRozOUVT
 VzgDVU+egPjNqQGW5FJod76fimf9K8l7qBZNXZ69NA==
X-Google-Smtp-Source: ABdhPJwjOaQHBYP5HBHod5WDWXLMU0/xp0eCkWKGBg/hRiGblG95btpxH0ojmWyIZmWbwAeUqcEutxDqrlqPy0PnDd4=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4103395wmb.85.1591708448748;
 Tue, 09 Jun 2020 06:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
 <20200605212706.7361-9-james.quinlan@broadcom.com>
 <20200607164950.GX2428291@smile.fi.intel.com>
 <CA+-6iNyL12Z+igSrWnsmTzrwzyyeDtSK-9ULiZe0MwM5LO5bjQ@mail.gmail.com>
 <20200609111828.GI2428291@smile.fi.intel.com>
In-Reply-To: <20200609111828.GI2428291@smile.fi.intel.com>
Date: Tue, 9 Jun 2020 09:13:57 -0400
Message-ID: <CA+-6iNxPGKFd84zK3k2SsgZcC=ExR=fPsSM8KAxPDswnjzi7QQ@mail.gmail.com>
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

On Tue, Jun 9, 2020 at 7:18 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jun 08, 2020 at 11:48:51AM -0400, Jim Quinlan wrote:
> > On Sun, Jun 7, 2020 at 12:500f9bfe0fb8840b268af1bbcc51f1cd440514e PM
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Jun 05, 2020 at 05:26:48PM -0400, Jim Quinlan wrote:
>
> ...
>
> > > > +     *map_size = (num_ranges + 1) * sizeof(**map);
> > > > +     r = kzalloc(*map_size, GFP_KERNEL);
> > >
> > > kcalloc()
> > Since I have to calculate the size anyway I thought kzalloc was fine.
> > I'll switch.
>
> The point is to check multiplication overflow. See overflow.h for helpers.

I am aware of this check and didn't think of it as applicable here, as
the most dma-ranges I can envision is six. I suppose that it is
possible that this may change in the future to some big number.  At
any rate, the next version has kcalloc().

Regards,
Jim
>
>
> > > > +     if (!r)
> > > > +             return -ENOMEM;
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
