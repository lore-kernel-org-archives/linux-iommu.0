Return-Path: <SRS0=+Z17=BJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F483C433E1
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 17:02:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3842A20829
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 17:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842A20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CDC0884C2;
	Thu, 30 Jul 2020 17:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1XOMIv7gjus; Thu, 30 Jul 2020 17:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1C29884C4;
	Thu, 30 Jul 2020 17:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4DA4C004F;
	Thu, 30 Jul 2020 17:02:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD3B5C004D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF123884D3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45fq01kc0uj5 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 17:02:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C686C87C0C
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 17:02:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0DDD9B02E;
 Thu, 30 Jul 2020 17:02:56 +0000 (UTC)
Message-ID: <1f3c4641a3058159a2923c1f5833a10b413747bf.camel@suse.de>
Subject: Re: [PATCH v9 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Jim Quinlan <james.quinlan@broadcom.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 30 Jul 2020 19:02:37 +0200
In-Reply-To: <CA+-6iNyi4c+ZUZhe=Zn5qX5GiGQVLR+BOcXmXSJkooX=S9=C0A@mail.gmail.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-9-james.quinlan@broadcom.com>
 <CAL_Jsq+9QE_uz+81O-Bm3xycSrJptx0xmwpPdP3x65KG00ugDQ@mail.gmail.com>
 <CA+-6iNwD1ehy6LPJ6gZJjvVeTBXAG_ybhyfUHTCvsDnM-HnmXA@mail.gmail.com>
 <20200729061903.GA31671@lst.de>
 <CAL_JsqLL_ZZFwinJpveybAtHg9KtrYCHgM3gNHero+Xujyd2eg@mail.gmail.com>
 <CA+-6iNyi4c+ZUZhe=Zn5qX5GiGQVLR+BOcXmXSJkooX=S9=C0A@mail.gmail.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 PCI <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM
 ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE" <devicetree@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Maxime Ripard <mripard@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
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
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "moderated list:BROADCOM
 BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>
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

On Thu, 2020-07-30 at 12:44 -0400, Jim Quinlan wrote:
> On Wed, Jul 29, 2020 at 10:28 AM Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Jul 29, 2020 at 12:19 AM Christoph Hellwig <hch@lst.de> wrote:
> > > On Tue, Jul 28, 2020 at 02:24:51PM -0400, Jim Quinlan wrote:
> > > > I started using devm_kcalloc() but at least two reviewers convinced me
> > > > to just use kcalloc().  In addition, when I was using devm_kcalloc()
> > > > it was awkward because 'dev' is not available to this function.
> > > > 
> > > > It comes down to whether unbind/binding the device N times is actually
> > > > a reasonable usage.  As for my experience I've seen two cases: (1) my
> > > > overnight "bind/unbind the PCIe RC driver" script, and we have a
> > > > customer who does an unbind/bind as a hail mary to bring back life to
> > > > their dead EP device.  If the latter case happens repeatedly, there
> > > > are bigger problems.
> > > 
> > > We can't just leak the allocations.  Do you have a pointer to the
> > > arguments against managed resources?  I'm generally not a huge fan
> > > of the managed resources, but for a case like this they actually seem
> > > useful.  If we don't use the managed resources we'll at leat need
> > > to explicitly free the resources when freeing the device.
> > 
> > The lifetime for devm_kcalloc may not be what we want here. devm
> > allocs are freed on probe fail or remove, not on freeing the device
> > (there is a just in case free there too though).
> 
> What do you suggest doing as an alternative?

I haven't given the idea much thought, but how about using a kref in the first
element of your bus_dma_region array. It should be increased upon assigning it
to a device and decreased it upon destroying it (triggering the free once it
hits 0). It would take care of this memory leak, but also useful where you're
sharing bus_dma_regions between devices.

Regards,
Nicolas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
