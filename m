Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E97C433E3
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 13:00:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A9F20714
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 13:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A9F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41BF787F44;
	Tue, 28 Jul 2020 13:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQPDzAcV-172; Tue, 28 Jul 2020 13:00:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09C2F8784F;
	Tue, 28 Jul 2020 13:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5DCEC0050;
	Tue, 28 Jul 2020 13:00:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E57EC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 13:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0ACA786538
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 13:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OC5_4gtDPMu8 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 13:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4A5D4864F2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 13:00:40 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id v6so4016040ota.13
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gQxWRGpK+7J5zPyI+x2auaL/xO1F0G6D2eChmPkLka4=;
 b=AMbeXh2wvpeaDn6cIST8epLKfBEs/fYO6bUIcUijfEHjv9VSM7BFQ86bbeaZkBxsFa
 JUOo74tS+A/a6RBd0uKdTQrM3MJ5XpVd/oSl+fJw6+D/AQ2fKBIV1W45ATHUpubj+Zvm
 IzGR5rO7PLHqKig4subipHvY0tXY919Sk4CJH7JGeidLQ6os9ZFq2RYx2EtPTyAkZxPS
 6624Z4qcKmVmIc2VdDGYjoWJVCVBfn4hFWBPC3nEZk5zveHoCGTG5jkOaVMNDM26SRnW
 C8mpuQrby3itdg44JEeiIv0gl4tIpCHWj/AsnH1uw5KvSN9bZ+BqKIOPPd0DPww08her
 YEog==
X-Gm-Message-State: AOAM530R9VHlxGN8mEs3/9yOJ6oc/INiDsPuuqnTVHoTTIRd/HYeZzHu
 3yaE5NwisQTvvKJibxO+C4Lt1RckzUTzkZcSuio=
X-Google-Smtp-Source: ABdhPJyjkPbmbdSrKoRnxAHeoGfwpBzGL7q9+aCpuvVIqlYJ3d/ztRYP2FQgQ2jADdtZcBOiq9wpwzTBFyKVN4fiMIs=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr24293860oth.262.1595941239566; 
 Tue, 28 Jul 2020 06:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-6-lorenzo.pieralisi@arm.com>
 <20200709093514.GC18149@e121166-lin.cambridge.arm.com>
 <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
 <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Jul 2020 15:00:28 +0200
Message-ID: <CAJZ5v0irrPd7kNqDX=BoPx7pf0zBgBRy3FHze5CA_UWi5Jv0Ag@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] ACPI/IORT: Add an input ID to
 acpi_dma_configure()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Makarand Pawagi <makarand.pawagi@nxp.com>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Diana Craciun <diana.craciun@oss.nxp.com>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jul 28, 2020 at 2:48 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jul 15, 2020 at 10:13:26AM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Jul 09, 2020 at 10:35:14AM +0100, Lorenzo Pieralisi wrote:
> > > On Fri, Jun 19, 2020 at 09:20:06AM +0100, Lorenzo Pieralisi wrote:
> > > > Some HW devices are created as child devices of proprietary busses,
> > > > that have a bus specific policy defining how the child devices
> > > > wires representing the devices ID are translated into IOMMU and
> > > > IRQ controllers device IDs.
> > > >
> > > > Current IORT code provides translations for:
> > > >
> > > > - PCI devices, where the device ID is well identified at bus level
> > > >   as the requester ID (RID)
> > > > - Platform devices that are endpoint devices where the device ID is
> > > >   retrieved from the ACPI object IORT mappings (Named components single
> > > >   mappings). A platform device is represented in IORT as a named
> > > >   component node
> > > >
> > > > For devices that are child devices of proprietary busses the IORT
> > > > firmware represents the bus node as a named component node in IORT
> > > > and it is up to that named component node to define in/out bus
> > > > specific ID translations for the bus child devices that are
> > > > allocated and created in a bus specific manner.
> > > >
> > > > In order to make IORT ID translations available for proprietary
> > > > bus child devices, the current ACPI (and IORT) code must be
> > > > augmented to provide an additional ID parameter to acpi_dma_configure()
> > > > representing the child devices input ID. This ID is bus specific
> > > > and it is retrieved in bus specific code.
> > > >
> > > > By adding an ID parameter to acpi_dma_configure(), the IORT
> > > > code can map the child device ID to an IOMMU stream ID through
> > > > the IORT named component representing the bus in/out ID mappings.
> > > >
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > ---
> > > >  drivers/acpi/arm64/iort.c | 59 +++++++++++++++++++++++++++++----------
> > > >  drivers/acpi/scan.c       |  8 ++++--
> > > >  include/acpi/acpi_bus.h   |  9 ++++--
> > > >  include/linux/acpi.h      |  7 +++++
> > > >  include/linux/acpi_iort.h |  7 +++--
> > > >  5 files changed, 67 insertions(+), 23 deletions(-)
> > >
> > > Hi Rafael,
> > >
> > > just to ask if the ACPI core changes in this patch are OK with you,
> > > thank you very much.

Sorry for the delay, I was offline last week.

> > Hi Rafael,
> >
> > are you OK with ACPI core changes in this patch ?

Yes, I am.

Please feel free to route it through whatever tree you think would be
appropriate.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
