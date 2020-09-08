Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D284C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 12:41:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EA62220D
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 12:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EA62220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 116CA86A2B;
	Tue,  8 Sep 2020 12:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yf1s6kxSszdQ; Tue,  8 Sep 2020 12:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75EB486A01;
	Tue,  8 Sep 2020 12:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B8DDC0052;
	Tue,  8 Sep 2020 12:41:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87499C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 12:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 73E2D869F0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 12:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qw7rtguVS77x for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:41:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 62F8E869E5
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 12:41:07 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7CB5F68B05; Tue,  8 Sep 2020 14:41:01 +0200 (CEST)
Date: Tue, 8 Sep 2020 14:41:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <20200908124100.GA32476@lst.de>
References: <6922bc0b-1849-2f2f-ec2f-fe9f0124dcfc@gmail.com>
 <20200903005240.GA1118@Ryzen-9-3900X.localdomain>
 <CA+-6iNyv_sFJOxDi5OcYNWe=ovLnOnrZNsWFQk5b-bzQzA8T_Q@mail.gmail.com>
 <34aa0d6094e7d6fb3492d2cda0fec8ecc04790ed.camel@suse.de>
 <CA+-6iNyJ3ey0zPKj9nh8uL3AwTBhJqgD01wc=7G4NF35NXmV1Q@mail.gmail.com>
 <b4761ade39af346eebec917ca2a415c09681542a.camel@suse.de>
 <20200908072935.GA15119@lst.de> <20200908073203.GA15176@lst.de>
 <20200908094345.GA20959@lst.de>
 <e4c672bc5237f6efb415efb77353b018d191b5ae.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4c672bc5237f6efb415efb77353b018d191b5ae.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Sudeep Holla <sudeep.holla@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Sep 08, 2020 at 01:20:56PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2020-09-08 at 11:43 +0200, Christoph Hellwig wrote:
> > And because I like replying to myself so much, here is a link to the
> > version with the arm cleanup patch applied.  Unlike the previous two
> > attempts this has at least survived very basic sanity testing:
> > 
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-ranges.2
> > 
> > Note that we'll still need to sort out the arm/keystone warnings from
> > the original patch.  Do we have anyone on the CC list who knows that
> > platform a little better to figure out if the ifdef solution would work?
> 
> Had to do the following to boot without errors:

I've folded in.  That being said the whole RPi4 setup confuses the
heck out of me.  I wonder what thing was smoked to come up with it..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
