Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF18C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 07:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54020615E2
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 07:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54020615E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16BE4401D4;
	Tue, 16 Nov 2021 07:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTM8CuVwQrar; Tue, 16 Nov 2021 07:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1CD540209;
	Tue, 16 Nov 2021 07:24:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8506C002E;
	Tue, 16 Nov 2021 07:24:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13AB2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC3E2401F0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h_jdZMq2Sy9X for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 07:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6581A40111
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:24:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="214360971"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="214360971"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 23:24:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="454348387"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.107])
 ([10.254.215.107])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 23:24:32 -0800
Message-ID: <4f95bea7-3c1c-4f12-aed5-a3fcdcd3fee3@linux.intel.com>
Date: Tue, 16 Nov 2021 15:24:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20211115204459.GA1585166@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 04/11] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
In-Reply-To: <20211115204459.GA1585166@bhelgaas>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Bjorn,

On 2021/11/16 4:44, Bjorn Helgaas wrote:
> On Mon, Nov 15, 2021 at 10:05:45AM +0800, Lu Baolu wrote:
>> IOMMU grouping on PCI necessitates that if we lack isolation on a bridge
>> then all of the downstream devices will be part of the same IOMMU group
>> as the bridge.
> 
> I think this means something like: "If a PCIe Switch Downstream Port
> lacks <a specific set of ACS capabilities>, all downstream devices
> will be part of the same IOMMU group as the switch," right?

For this patch, yes.

> 
> If so, can you fill in the details to make it specific and concrete?

The existing vfio implementation allows a kernel driver to bind with a
PCI bridge while its downstream devices are assigned to the user space
though there lacks ACS-like isolation in bridge.

drivers/vfio/vfio.c:
  540 static bool vfio_dev_driver_allowed(struct device *dev,
  541                                     struct device_driver *drv)
  542 {
  543         if (dev_is_pci(dev)) {
  544                 struct pci_dev *pdev = to_pci_dev(dev);
  545
  546                 if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
  547                         return true;
  548         }

We are moving the group viability check to IOMMU core, and trying to
make it compatible with the current vfio policy. We saw three types of
bridges:

#1) PCIe/PCI-to-PCI bridges
     These bridges are configured in the PCI framework, there's no
     dedicated driver for such devices.

#2) Generic PCIe switch downstream port
     The port driver doesn't map and access any MMIO in the PCI BAR.
     The iommu group is viable to user even this driver is bound.

#3) Hot Plug Controller
     The controller driver maps and access the device MMIO. The iommu
     group is not viable to user with this driver bound to its device.

>> As long as the bridge kernel driver doesn't map and
>> access any PCI mmio bar, it's safe to bind it to the device in a USER-
>> owned group. Hence, safe to suppress the kernel DMA ownership auto-
>> claiming.
> 
> s/mmio/MMIO/ (also below)
> s/bar/BAR/ (also below)

Sure.

> 
> I don't understand what "kernel DMA ownership auto-claiming" means.
> Presumably that's explained in previous patches and a code comment
> near "suppress_auto_claim_dma_owner".

When a device driver is about to bind with a device, the driver core
will claim the kernel DMA ownership automatically for the driver.

This implies that
- if success, the kernel driver is controlling the device for DMA. Any
   devices sitting in the same iommu group shouldn't be assigned to user.
- if failure, some devices sitting in the same iommu group have already
   been assigned to user space. The driver binding process should abort.

But there are some exceptions where suppress_auto_claim_dma_owner comes
to play.

#1) vfio-like drivers which will assign the devices to user space after
     driver binding;
#2) (compatible with exiting vfio policy) some drivers are allowed to be
     bound with a device while its siblings in the iommu group are
     assigned to user space. Typically, these drivers include
     - pci_stub driver
     - pci bridge drivers

For above drivers, we use driver.suppress_auto_claim_dma_owner as a hint
to tell the driver core to ignore the kernel dma ownership claiming.

> 
>> The commit 5f096b14d421b ("vfio: Whitelist PCI bridges") permitted a
>> class of kernel drivers.
> 
> Permitted them to do what?

As I explained above.

> 
>> This is not always safe. For example, the SHPC
>> system design requires that it must be integrated into a PCI-to-PCI
>> bridge or a host bridge.
> 
> If this SHPC example is important, it would be nice to have a citation
> to the spec section that requires this.

I just used it as an example to show that allowing any driver to be
bound to a PCI bridge device in a USER-viable iommu group is too loose.

> 
>> The shpchp_core driver relies on the PCI mmio
>> bar access for the controller functionality. Binding it to the device
>> belonging to a USER-owned group will allow the user to change the
>> controller via p2p transactions which is unknown to the hot-plug driver
>> and could lead to some unpredictable consequences.
>>
>> Now that we have driver self-declaration of safety we should rely on that.
> 
> Can you spell out what drivers are self-declaring?  Are they declaring
> that they don't program their devices to do DMA?

Sure. Set driver.suppress_auto_claim_dma_owner = true.

> 
>> This change may cause regression on some platforms, since all bridges were
>> exempted before, but now they have to be manually audited before doing so.
>> This is actually the desired outcome anyway.
> 
> Please spell out what regression this may cause and how users would
> recognize it.  Also, please give a hint about why that is desirable.

Sure.

Before this series, bridge drivers are always allowed to be bound with
PCI/PCIe bridge which is sitting in an iommu group assigned to user
space. After this, only those drivers which have
suppress_auto_claim_dma_owner set could be done so. Otherwise, the
driver binding or group user assignment will fail.

The criteria of what kind of drivers could have this hint set is "driver
doesn't map and access the MMIO define in the PCI BARs".

> 
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/pci/pcie/portdrv_pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index 35eca6277a96..1285862a9aa8 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -203,6 +203,8 @@ static struct pci_driver pcie_portdriver = {
>>   	.err_handler	= &pcie_portdrv_err_handler,
>>   
>>   	.driver.pm	= PCIE_PORTDRV_PM_OPS,
>> +
>> +	.driver.suppress_auto_claim_dma_owner = true,
>>   };
>>   
>>   static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
>> -- 
>> 2.25.1
>>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
