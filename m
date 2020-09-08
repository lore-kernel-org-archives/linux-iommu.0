Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7290C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 10:42:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD72074B
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 10:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD72074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BF97220551;
	Tue,  8 Sep 2020 10:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZiWhr-Kt76F; Tue,  8 Sep 2020 10:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C7FBF20378;
	Tue,  8 Sep 2020 10:42:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAC2CC0052;
	Tue,  8 Sep 2020 10:42:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1605C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 10:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E00A98574F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 10:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WL4LgUp2k3Zn for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 10:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E40778577A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 10:42:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE88931B;
 Tue,  8 Sep 2020 03:42:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AEF13F66E;
 Tue,  8 Sep 2020 03:42:28 -0700 (PDT)
Date: Tue, 8 Sep 2020 11:42:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
Message-ID: <20200908104226.GB22909@e121166-lin.cambridge.arm.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
 <20200827063517.GA4637@lst.de>
 <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com>
 <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
 <CA+-6iNzoz3pM2pJksXogeuou6wB9W-59rN-amCLERFLuY5zLMg@mail.gmail.com>
 <00e49acb-c659-de10-3e87-76bfd82e4a76@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00e49acb-c659-de10-3e87-76bfd82e4a76@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Sep 07, 2020 at 11:29:06AM -0700, Florian Fainelli wrote:
> 
> 
> On 9/7/2020 10:43 AM, Jim Quinlan wrote:
> > On Mon, Sep 7, 2020 at 5:16 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > 
> > > On Thu, Aug 27, 2020 at 09:29:59AM -0400, Jim Quinlan wrote:
> > > > On Thu, Aug 27, 2020 at 2:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > > 
> > > > > On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 8/24/2020 12:30 PM, Jim Quinlan wrote:
> > > > > > > 
> > > > > > > Patchset Summary:
> > > > > > >     Enhance a PCIe host controller driver.  Because of its unusual design
> > > > > > >     we are foced to change dev->dma_pfn_offset into a more general role
> > > > > > >     allowing multiple offsets.  See the 'v1' notes below for more info.
> > > > > > 
> > > > > > We are version 11 and counting, and it is not clear to me whether there is
> > > > > > any chance of getting these patches reviewed and hopefully merged for the
> > > > > > 5.10 merge window.
> > > > > > 
> > > > > > There are a lot of different files being touched, so what would be the
> > > > > > ideal way of routing those changes towards inclusion?
> > > > > 
> > > > > FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
> > > > > I have a bit of a backlog, but plan to review and if Jim is ok with that
> > > > > apply the current version.
> > > > Sounds good to me.
> > > 
> > > Hi Jim,
> > > 
> > > is the dependency now solved ? Should we review/take this series as
> > > is for v5.10 through the PCI tree ?
> > Hello Lorenzo,
> > 
> > We are still working out a regression with the DMA offset commit on
> > the RaspberryPi.  Nicolas has found the root cause and we are now
> > devising a solution.
> 
> Maybe we can parallelize the PCIe driver review while the DMA changes
> are being worked on in Christoph's branch. Lorenzo, are you fine with
> the PCIe changes proper?

I will have a look - the main contentious point was about the DMA
changes - if Christoph is happy with them I am OK with them
too - I hope there is not anything controversial in the host
bridge driver itself but I will look into it.

Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
