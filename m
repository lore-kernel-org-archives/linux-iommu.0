Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE941C433E2
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 17:33:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B599A206C0
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 17:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PeZ+do84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B599A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8527C86DBF;
	Thu,  3 Sep 2020 17:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCmKu2daHH6d; Thu,  3 Sep 2020 17:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E503B86DB2;
	Thu,  3 Sep 2020 17:33:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A8FC0052;
	Thu,  3 Sep 2020 17:33:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B043C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 17:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 43AD187431
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 17:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HrKjUWYWbiCM for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 17:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D9EF787427
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 17:32:56 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id k15so4076765wrn.10
 for <iommu@lists.linux-foundation.org>; Thu, 03 Sep 2020 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kdQAZvbXCVXJwkRywSLG6JnetvOXivYhmXNx/fFNfOo=;
 b=PeZ+do84XUsG8yX+y0xtDFdM3W7ihrw4+Eg7Lf0egrb9LtMBQGYbfe6kry3lmEqaZ4
 YD5uVyabXPVOVnG1zctNz091NT+5kRmWJ8Qxdde146p1G2TpEQ8aLZWKX307mJHW2sP5
 YOWr2Z/cspMQV4ehyL7JTVxf4sQxxzDheuxQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kdQAZvbXCVXJwkRywSLG6JnetvOXivYhmXNx/fFNfOo=;
 b=UiWSjwn33lsnWQMPAWqxjKnb1uG8I7Mj4/GODvGsP/iMTAi0NCVEOSdelys/u6JhFs
 swydZNXwtk7YbKlzmTH6+IrVjNr3x5034jSYTF40ogBGrkSUxdT6ruc6Nx3W4tAXTshP
 I/Kyn3qhpNTZti/VcIKldZkyqaU+wJi1nMdmD3TDlY2pOoNl8tMEclrPQo2GQve/wubT
 V9bAf8l11yiAXb0bbASEfdoHIktPX60vwxwj/NYydwTtxLqLSNK2ODgtxa0yDhjBb7hp
 LNBi+evH8ny8Azrn4o2E98CeOOTyTFSCyN1Bq7NvChsfN6doDwyGpi8K3oleNBYMF3QU
 8/YQ==
X-Gm-Message-State: AOAM530sn+sTj5712hEYh8IjOU6k2p3zljtxoMYdRZ7ZUFAWMsI1RSAS
 LrYRxBzMkkTM7XjVgobKC7C6NltrlC96R/hLJpyHjA==
X-Google-Smtp-Source: ABdhPJzlo38OUlokDbtl4G3RL3E1kLc3kVQIe+ooBj2Om40oPL84GGMLXmXAPwATVhS0dB/n9pwMRt0/2muUtlKoUvU=
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr3453960wrw.87.1599154374779;
 Thu, 03 Sep 2020 10:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200902215314.GA881878@ubuntu-n2-xlarge-x86>
 <CA+-6iNzc38OAL7TGxobpODKXOD1CW-VFNU0rK9Z043QfR3MfsQ@mail.gmail.com>
 <20200902223852.GA1786990@ubuntu-n2-xlarge-x86>
 <6922bc0b-1849-2f2f-ec2f-fe9f0124dcfc@gmail.com>
 <20200903005240.GA1118@Ryzen-9-3900X.localdomain>
In-Reply-To: <20200903005240.GA1118@Ryzen-9-3900X.localdomain>
Date: Thu, 3 Sep 2020 13:32:43 -0400
Message-ID: <CA+-6iNyv_sFJOxDi5OcYNWe=ovLnOnrZNsWFQk5b-bzQzA8T_Q@mail.gmail.com>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Nathan Chancellor <natechancellor@gmail.com>, 
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 ACPI/arm64" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Yong Deng <yong.deng@magewell.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 2, 2020 at 8:52 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Sep 02, 2020 at 05:36:29PM -0700, Florian Fainelli wrote:
> >
> >
> > On 9/2/2020 3:38 PM, Nathan Chancellor wrote:
> > [snip]
> > > > Hello Nathan,
> > > >
> > > > Can you tell me how much memory your RPI has and if all of it is
> > >
> > > This is the 4GB version.
> > >
> > > > accessible by the PCIe device?  Could you also please include the DTS
> > > > of the PCIe node?  IIRC, the RPI firmware does some mangling of the
> > > > PCIe DT before Linux boots -- could you describe what is going on
> > > > there?
> > >
> > > Unfortunately, I am not familiar with how to get this information. If
> > > you could provide some instructions for how to do so, I am more than
> > > happy to. I am not very knowleagable about the inner working of the Pi,
> > > I mainly use it as a test platform for making sure that LLVM does not
> > > cause problems on real devices.
> >
> > Can you bring the dtc application to your Pi root filesystem, and if so, can
> > you run the following:
> >
> > dtc -I fs -O dtb /proc/device-tree -f > /tmp/device.dtb
>
> Sure, the result is attached.
>
> > or cat /sys/firmware/fdt > device.dtb
> >
> > and attach the resulting file?
> >
> > >
> > > > Finally, can you attach the text of the full boot log?
> > >
> > > I have attached a working and broken boot log. Thank you for the quick
> > > response!
> >
> > Is it possible for you to rebuild your kernel with CONFIG_MMC_DEBUG by any
> > chance?
>
> Of course. A new log is attached with the debug output from that config.


Hi Nicolas,

Can you please help us out here?  It appears that your commit

3d2cbb644836 "ARM: dts: bcm2711: Move emmc2 into its own bus"

added the following line to the bcm2711.dtsi file:

+ dma-ranges = <0x0 0xc0000000  0x0 0x00000000  0x40000000>;

and for some reason the eMMC is not operating properly w/ my commit..
 Regardless, the only difference that my commit should make is to
enforce the bounds of the dma_window (whereas the previous code
adds/subs the pfn_offset everywhere).

Thanks,
Jim Quinlan

PS If you would like to talk, let me know and we can make arrangements.


>
>
> > I have a suspicion that this part of the DTS for the bcm2711.dtsi platform
> > is at fault:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/bcm2711.dtsi#n264
> >
> > and the resulting dma-ranges parsing is just not working for reasons to be
> > determined.
> > --
> > Florian
>
> Let me know if you need anything else out of me.
>
> Cheers,
> Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
