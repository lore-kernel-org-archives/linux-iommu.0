Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE3CC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:44:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B23E2078E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B23E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50AC6864C1;
	Mon,  5 Oct 2020 10:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h3yFdoaOi1BH; Mon,  5 Oct 2020 10:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34EB785FF2;
	Mon,  5 Oct 2020 10:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A03AC016F;
	Mon,  5 Oct 2020 10:44:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74F57C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 46E262038F
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H19RZrcZDrT3 for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 10:44:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 847D320381
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:44:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7505113E;
 Mon,  5 Oct 2020 03:44:17 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C2A3F66B;
 Mon,  5 Oct 2020 03:44:15 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:44:10 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
Message-ID: <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928164224.12350d84@w520.home>
 <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com>
 <20200929121849.455af184@w520.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929121849.455af184@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org, hch@lst.de, eric.auger.pro@gmail.com
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

[+Christoph]

On Tue, Sep 29, 2020 at 12:18:49PM -0600, Alex Williamson wrote:
> On Tue, 29 Sep 2020 09:18:22 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
> > Hi all,
> > 
> > [also correcting some outdated email addresses + adding Lorenzo in cc]
> > 
> > On 9/29/20 12:42 AM, Alex Williamson wrote:
> > > On Mon, 28 Sep 2020 21:50:34 +0200
> > > Eric Auger <eric.auger@redhat.com> wrote:
> > >   
> > >> VFIO currently exposes the usable IOVA regions through the
> > >> VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> > >> capability. However it fails to take into account the dma_mask
> > >> of the devices within the container. The top limit currently is
> > >> defined by the iommu aperture.  
> > > 
> > > I think that dma_mask is traditionally a DMA API interface for a device
> > > driver to indicate to the DMA layer which mappings are accessible to the
> > > device.  On the other hand, vfio makes use of the IOMMU API where the
> > > driver is in userspace.  That userspace driver has full control of the
> > > IOVA range of the device, therefore dma_mask is mostly irrelevant to
> > > vfio.  I think the issue you're trying to tackle is that the IORT code
> > > is making use of the dma_mask to try to describe a DMA address
> > > limitation imposed by the PCI root bus, living between the endpoint
> > > device and the IOMMU.  Therefore, if the IORT code is exposing a
> > > topology or system imposed device limitation, this seems much more akin
> > > to something like an MSI reserved range, where it's not necessarily the
> > > device or the IOMMU with the limitation, but something that sits
> > > between them.  
> > 
> > First I think I failed to explain the context. I worked on NVMe
> > passthrough on ARM. The QEMU NVMe backend uses VFIO to program the
> > physical device. The IOVA allocator there currently uses an IOVA range
> > within [0x10000, 1ULL << 39]. This IOVA layout rather is arbitrary if I
> > understand correctly.
> 
> 39 bits is the minimum available on some VT-d systems, so it was
> probably considered a reasonable minimum address width to consider.
> 
> > I noticed we rapidly get some VFIO MAP DMA
> > failures because the allocated IOVA collide with the ARM MSI reserved
> > IOVA window [0x8000000, 0x8100000]. Since  9b77e5c79840 ("vfio/type1:
> > Check reserved region conflict and update iova list"), such VFIO MAP DMA
> > attempts to map IOVAs belonging to host reserved IOVA windows fail. So,
> > by using the VFIO_IOMMU_GET_INFO ioctl /
> > VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE I can change the IOVA allocator to
> > avoid allocating within this range and others. While working on this, I
> > tried to automatically compute the min/max IOVAs and change the
> > arbitrary [0x10000, 1ULL << 39]. My SMMUv2 supports up to 48b so
> > naturally the max IOVA was computed as 1ULL << 48. The QEMU NVMe backend
> > allocates at the bottom and at the top of the range. I noticed the use
> > case was not working as soon as the top IOVA was more than 1ULL << 42.
> > And then we noticed the dma_mask was set to 42 by using
> > cat  /sys/bus/pci/devices/0005:01:00.0/dma_mask_bits. So my
> > interpretation is the dma_mask was somehow containing the info the
> > device couldn't handle IOVAs beyond a certain limit.
> 
> I see that there are both OF and ACPI hooks in pci_dma_configure() and
> both modify dev->dma_mask, which is what pci-sysfs is exposing here,
> but I'm not convinced this even does what it's intended to do.  The
> driver core calls this via the bus->dma_configure callback before
> probing a driver, but then what happens when the driver calls
> pci_set_dma_mask()?  This is just a wrapper for dma_set_mask() and I
> don't see anywhere that would take into account the existing
> dev->dma_mask.  It seems for example that pci_dma_configure() could
> produce a 42 bit mask as we have here, then the driver could override
> that with anything that the dma_ops.dma_supported() callback finds
> acceptable, and I don't see any instances where the current
> dev->dma_mask is considered.  Am I overlooking something? 

I don't think so but Christoph and Robin can provide more input on
this - it is a long story.

ACPI and OF bindings set a default dma_mask (and dev->bus_dma_limit),
this does not prevent a driver from overriding the dev->dma_mask but DMA
mapping code still takes into account the dev->bus_dma_limit.

This may help:

git log -p 03bfdc31176c

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
