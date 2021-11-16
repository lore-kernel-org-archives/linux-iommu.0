Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4B0C433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 20:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E1F617E4
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 20:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8E1F617E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FC7E60805;
	Tue, 16 Nov 2021 20:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tnsy7mVzo9my; Tue, 16 Nov 2021 20:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BACD0607FD;
	Tue, 16 Nov 2021 20:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 900A1C002E;
	Tue, 16 Nov 2021 20:22:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE37C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 20:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 287C640454
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 20:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1PlbW8vhA2i for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 20:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E35F40425
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 20:22:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A201617E4;
 Tue, 16 Nov 2021 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637094123;
 bh=8Nzv2cPbd00BDsI1fAdB/LfuCL2nT15qZoftCaEc4tM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Gjg3zvVxAKilsJ3ONEcJx/zQWFsZfUCfzp+owCZnqhbIuQj8qRiRqMapWs1aNYMy6
 A2XIAJJrYp+vFy3CDfT5L4Mt+U3jxLDClzYAbOWx2aYDYkG6dZysYJGZKiKao0sfO5
 gAJtbWVHAkH6qpNZ6gFYP5//vTvuLP3GTIkBK9fHxkd+yZOE0/VOerNpE5U9XE7MPJ
 3p39EWggDyJsR4mRE/wsMglgC3ZS6/vT0Am13HjFNr7aFFu5duBkksG2RSxHnfVAuO
 4FuhU2dai49w1dyKDdKAC2xRqVnBib2wih+bHW8GlvOVER7qcODYeIQi6j4/LtprVM
 UkP2T7LCnZu5Q==
Date: Tue, 16 Nov 2021 14:22:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 04/11] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20211116202201.GA1676368@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f95bea7-3c1c-4f12-aed5-a3fcdcd3fee3@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On Tue, Nov 16, 2021 at 03:24:29PM +0800, Lu Baolu wrote:
> On 2021/11/16 4:44, Bjorn Helgaas wrote:
> > On Mon, Nov 15, 2021 at 10:05:45AM +0800, Lu Baolu wrote:
> > > IOMMU grouping on PCI necessitates that if we lack isolation on a bridge
> > > then all of the downstream devices will be part of the same IOMMU group
> > > as the bridge.
> > 
> > I think this means something like: "If a PCIe Switch Downstream Port
> > lacks <a specific set of ACS capabilities>, all downstream devices
> > will be part of the same IOMMU group as the switch," right?
> 
> For this patch, yes.
> 
> > If so, can you fill in the details to make it specific and concrete?
> 
> The existing vfio implementation allows a kernel driver to bind with a
> PCI bridge while its downstream devices are assigned to the user space
> though there lacks ACS-like isolation in bridge.
> 
> drivers/vfio/vfio.c:
>  540 static bool vfio_dev_driver_allowed(struct device *dev,
>  541                                     struct device_driver *drv)
>  542 {
>  543         if (dev_is_pci(dev)) {
>  544                 struct pci_dev *pdev = to_pci_dev(dev);
>  545
>  546                 if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>  547                         return true;
>  548         }
> 
> We are moving the group viability check to IOMMU core, and trying to
> make it compatible with the current vfio policy. We saw three types of
> bridges:
> 
> #1) PCIe/PCI-to-PCI bridges
>     These bridges are configured in the PCI framework, there's no
>     dedicated driver for such devices.
> 
> #2) Generic PCIe switch downstream port
>     The port driver doesn't map and access any MMIO in the PCI BAR.
>     The iommu group is viable to user even this driver is bound.
> 
> #3) Hot Plug Controller
>     The controller driver maps and access the device MMIO. The iommu
>     group is not viable to user with this driver bound to its device.

I *guess* the question here is whether the bridge can or will do DMA?

I think that's orthogonal to the question of whether it implements
BARs, so I'm not sure why the MMIO BARs are part of this discussion.
I assume it's theoretically possible for a driver to use registers in
config space to program a device to do DMA, even if the device has no
BARs.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
