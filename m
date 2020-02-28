Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96620C3F2D7
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:11:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6948B246AC
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6948B246AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2CA3D20488;
	Fri, 28 Feb 2020 14:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RiIA-UwVIgeo; Fri, 28 Feb 2020 14:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 356D220461;
	Fri, 28 Feb 2020 14:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13F5BC08A0;
	Fri, 28 Feb 2020 14:11:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA9F7C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 97DD220471
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xzOBZPT+sjvm for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 1974020461
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:11:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6DC31B;
 Fri, 28 Feb 2020 06:11:37 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B99B3F7B4;
 Fri, 28 Feb 2020 06:11:33 -0800 (PST)
Date: Fri, 28 Feb 2020 14:11:30 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 06/11] iommu: arm-smmu: Remove Calxeda secure mode
 quirk
Message-ID: <20200228141130.18be5bb8@donnerap.cambridge.arm.com>
In-Reply-To: <20200228135645.GA4745@willie-the-truck>
References: <20200218171321.30990-1-robh@kernel.org>
 <20200218171321.30990-7-robh@kernel.org>
 <20200218172000.GF1133@willie-the-truck>
 <CAL_JsqJn1kG6gah+4318NQfJ4PaS3x3woWEUh08+OTfOcD+1MQ@mail.gmail.com>
 <20200228100446.GA2395@willie-the-truck>
 <20200228102556.1dde016e@donnerap.cambridge.arm.com>
 <20200228105024.GC2395@willie-the-truck>
 <20200228134254.03fc5e1b@donnerap.cambridge.arm.com>
 <20200228135645.GA4745@willie-the-truck>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
List-Id: <soc.lore.kernel.org>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, kvm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, soc@kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org,
 Jon Loeliger <jdl@jdl.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Alexander Graf <graf@amazon.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 linux-edac <linux-edac@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Matthias Brugger <mbrugger@suse.com>, Stephen Boyd <sboyd@kernel.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Robert Richter <rrichter@marvell.com>, James Morse <james.morse@arm.com>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>, "David S.
 Miller" <davem@davemloft.net>
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

On Fri, 28 Feb 2020 13:56:46 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Feb 28, 2020 at 01:42:54PM +0000, Andre Przywara wrote:
> > On Fri, 28 Feb 2020 10:50:25 +0000
> > Will Deacon <will@kernel.org> wrote:  
> > > On Fri, Feb 28, 2020 at 10:25:56AM +0000, Andre Przywara wrote:  
> > > > > On Tue, Feb 25, 2020 at 04:01:54PM -0600, Rob Herring wrote:    
> > > > > > Seems we're leaving the platform support for now, but I think we never
> > > > > > actually enabled SMMU support. It's not in the dts either in mainline
> > > > > > nor the version I have which should be close to what shipped in
> > > > > > firmware. So as long as Andre agrees, this one is good to apply.      
> > > > > 
> > > > > Andre? Can I queue this one for 5.7, please?    
> > > > 
> > > > I was wondering how much of a pain it is to keep it in? AFAICS there are
> > > > other users of the "impl" indirection. If those goes away, I would be
> > > > happy to let Calxeda go.    
> > > 
> > > The impl stuff is new, so we'll keep it around. The concern is more about
> > > testing (see below).
> > >   
> > > > But Eric had the magic DT nodes to get the SMMU working, and I used that
> > > > before, with updating the DT either on flash or dynamically via U-Boot.    
> > > 
> > > What did you actually use the SMMU for, though? The
> > > 'arm_iommu_create_mapping()' interface isn't widely used and, given that
> > > highbank doesn't support KVM, the use-cases for VFIO are pretty limited
> > > too.  
> > 
> > AFAIK Highbank doesn't have the SMMU, probably mostly for that reason.
> > I have a DT snippet for Midway, and that puts the MMIO base at ~36GB, which is not possible on Highbank.
> > So I think that the quirk is really meant and needed for Midway.  
> 
> Sorry, but I don't follow your reasoning here. The MMIO base has nothing
> to do with the quirk,

It hasn't, but Highbank has no LPAE, so couldn't possible have a device at such an address. And this is the only MMIO address I know of.

> although doing some digging it looks like your
> conclusion about this applying to Midway (ecx-2000?) is correct:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226095.html

Right, thanks for that find. Yes, Midway is the codename for the ECX-2000 SoC product.

Cheers,
Andre
 
> > > > So I don't know exactly *how* desperate you are with removing this, or if
> > > > there are other reasons than "negative diffstat", but if possible I would
> > > > like to keep it in.    
> > > 
> > > It's more that we *do* make quite a lot of changes to the arm-smmu driver
> > > and it's never tested with this quirk. If you're stepping up to run smmu
> > > tests on my queue for each release on highbank, then great, but otherwise
> > > I'd rather not carry the code for fun. The change in diffstat is minimal
> > > (we're going to need to hooks for nvidia, who broke things in a different
> > > way).  
> > 
> > I am about to set up some more sophisticated testing, and will include
> > some SMMU bits in it.  
> 
> Yes, please.
> 
> Will

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
