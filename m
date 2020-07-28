Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B9C433EC
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:48:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA58206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA58206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5563D87ED9;
	Tue, 28 Jul 2020 12:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JgTWg3jmkTrO; Tue, 28 Jul 2020 12:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CAAD87E99;
	Tue, 28 Jul 2020 12:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74A11C0050;
	Tue, 28 Jul 2020 12:48:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C39C9C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3BED233ED
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oNhTn3YWn+Kd for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 12:48:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 2350B2013C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:48:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED431FB;
 Tue, 28 Jul 2020 05:48:44 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD4A3F718;
 Tue, 28 Jul 2020 05:48:42 -0700 (PDT)
Date: Tue, 28 Jul 2020 13:48:35 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 05/12] ACPI/IORT: Add an input ID to
 acpi_dma_configure()
Message-ID: <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-6-lorenzo.pieralisi@arm.com>
 <20200709093514.GC18149@e121166-lin.cambridge.arm.com>
 <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Makarand Pawagi <makarand.pawagi@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On Wed, Jul 15, 2020 at 10:13:26AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jul 09, 2020 at 10:35:14AM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Jun 19, 2020 at 09:20:06AM +0100, Lorenzo Pieralisi wrote:
> > > Some HW devices are created as child devices of proprietary busses,
> > > that have a bus specific policy defining how the child devices
> > > wires representing the devices ID are translated into IOMMU and
> > > IRQ controllers device IDs.
> > > 
> > > Current IORT code provides translations for:
> > > 
> > > - PCI devices, where the device ID is well identified at bus level
> > >   as the requester ID (RID)
> > > - Platform devices that are endpoint devices where the device ID is
> > >   retrieved from the ACPI object IORT mappings (Named components single
> > >   mappings). A platform device is represented in IORT as a named
> > >   component node
> > > 
> > > For devices that are child devices of proprietary busses the IORT
> > > firmware represents the bus node as a named component node in IORT
> > > and it is up to that named component node to define in/out bus
> > > specific ID translations for the bus child devices that are
> > > allocated and created in a bus specific manner.
> > > 
> > > In order to make IORT ID translations available for proprietary
> > > bus child devices, the current ACPI (and IORT) code must be
> > > augmented to provide an additional ID parameter to acpi_dma_configure()
> > > representing the child devices input ID. This ID is bus specific
> > > and it is retrieved in bus specific code.
> > > 
> > > By adding an ID parameter to acpi_dma_configure(), the IORT
> > > code can map the child device ID to an IOMMU stream ID through
> > > the IORT named component representing the bus in/out ID mappings.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > ---
> > >  drivers/acpi/arm64/iort.c | 59 +++++++++++++++++++++++++++++----------
> > >  drivers/acpi/scan.c       |  8 ++++--
> > >  include/acpi/acpi_bus.h   |  9 ++++--
> > >  include/linux/acpi.h      |  7 +++++
> > >  include/linux/acpi_iort.h |  7 +++--
> > >  5 files changed, 67 insertions(+), 23 deletions(-)
> > 
> > Hi Rafael,
> > 
> > just to ask if the ACPI core changes in this patch are OK with you,
> > thank you very much.
> 
> Hi Rafael,
> 
> are you OK with ACPI core changes in this patch ?
> 
> Please let me know, thanks.

Hi Rafael,

gentle ping, I think we are missing v5.9, we would need your feedback
on this please.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
