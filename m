Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE86C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 16:28:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BFF206DC
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nwm8d//+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BFF206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E177D24BE8;
	Thu,  4 Jun 2020 16:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNf3DrsbzNEW; Thu,  4 Jun 2020 16:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E9276203DF;
	Thu,  4 Jun 2020 16:28:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5BDCC0888;
	Thu,  4 Jun 2020 16:28:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3968C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 16:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA2B6203F9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h4Vw+fhY7L-v for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 16:28:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id C2437203DF
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 16:28:48 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d128so6324393wmc.1
 for <iommu@lists.linux-foundation.org>; Thu, 04 Jun 2020 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CvFBAxlrt2J9jb0QdDsGu7K922VoXgCGTJpM/HBK+Qk=;
 b=Nwm8d//+sjH3Z9mufLz/+WKylqV8GnlqZP5cDZilNehMRs3XQT7l8Tg489oBe2Bv5H
 K23RVr8/sl/WjZcrBeLCXT1Z5LKkPJSqD059Mdrq9I69Yz6Dg0doVUUnBcL4wDHjhYva
 Qf30ZckaVxPcfdXWBXJlmMCnpDqNXJqy90Nhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CvFBAxlrt2J9jb0QdDsGu7K922VoXgCGTJpM/HBK+Qk=;
 b=DcKjBBDob77Zf5NA9c2+4i4faoZVWpWpM38leWOpK30xrR3JmEpyf/Aa1T2sWtPAcF
 TnSS1k0InyRfr9oI3/2Eqx/4GcMlsKSZniFKm8DKeeGAUc3IpPDgQksDjrBkpaN/pk6e
 qQPetwXrqMUK0UJFRDEFUpiJPTx272PmfJSPPDnGo+ypNxgrJM5fhzFwS7E0C5g3dGRM
 MPNrnNXMaFCO6s/7s/AT2l0RELRDBdKiiCaC1O8THM4mQDv7cttapEzpiqITwu8CgE8I
 HjBEIllx0gqEsCpRpzsSc0c2wkFBfmNuucE/sxrjoT1arLB7ICWz81Z8ZYGJ3epzp3mF
 kEdQ==
X-Gm-Message-State: AOAM532ZEgHW3HuSVcs8TWI006KigVtrUVN19Nvp/kKYVBS1U6yGSlIe
 4wxpxka6BIa+D2LVeH7V359ZtAW8AtGBbXNpLUTaYw==
X-Google-Smtp-Source: ABdhPJxNGHB1SSXPUoFwXoNSi05e8v/wl0KgveYrZK14zPrtDm8asHl5Z5GTJTxfyjyWg62aQanc89ULkV9YeVvY+YQ=
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr4493336wmb.97.1591288126871; 
 Thu, 04 Jun 2020 09:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-10-james.quinlan@broadcom.com>
 <09c451e24f62e226e1ceaa0fe5d0a81109cace74.camel@suse.de>
 <CA+-6iNz1-1wOurKoOJzhbVL0_YP7dbmp0wy1GWkLW_61yhRXyA@mail.gmail.com>
 <20200604150535.GB2428291@smile.fi.intel.com>
In-Reply-To: <20200604150535.GB2428291@smile.fi.intel.com>
Date: Thu, 4 Jun 2020 12:28:34 -0400
Message-ID: <CA+-6iNxze_tfWBsE0FkSFcWgihx=CHgNBiHi=BUC+9_=x-TtUA@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] device core: Introduce multiple dma pfn offsets
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
 Alan Stern <stern@rowland.harvard.edu>,
 David Kershner <david.kershner@unisys.com>, Len Brown <lenb@kernel.org>,
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

On Thu, Jun 4, 2020 at 11:05 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 04, 2020 at 10:35:12AM -0400, Jim Quinlan wrote:
> > On Thu, Jun 4, 2020 at 9:53 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Wed, 2020-06-03 at 15:20 -0400, Jim Quinlan wrote:
>
> ...
>
> > > > +     phys = virt_to_phys(ret);
> > > > +     pfn =  phys >> PAGE_SHIFT;
> > >
> > > nit: not sure it really pays off to have a pfn variable here.
> > Did it for readability; the compiler's optimization should take care
> > of any extra variables.  But I can switch if you insist.
>
> One side note: please, try to get familiar with existing helpers in the kernel.
> For example, above line is like
>
>         pfn = PFN_DOWN(phys);
I just used the term in the original code; will change to PFN_DOWN().

>
> ...
>
> > > > +     if (!WARN_ON(!dev) && dev->dma_pfn_offset_map)
>
> > > > +             *dma_handle -= PFN_PHYS(
> > > > +                     dma_pfn_offset_from_phys_addr(dev, phys));
>
> Don't do such indentation, esp. we have now 100! :-)

Got it.  Thanks,
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
