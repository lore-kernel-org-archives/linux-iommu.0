From: "Allan, Bruce W" <bruce.w.allan@intel.com>
Subject: (unknown)
Date: Sat, 15 Nov 2014 01:49:09 +0000
Message-ID: <804857E1F29AAC47BF68C404FC60A1846586CB67@ORSMSX105.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
Subject: 
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Let's try this again as plain text...

For a PCIe device with SR-IOV support enabled (e.g. the PF device ID is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA read/write of memory that was mapped by the PF devfn but instead uses a requester id of one of the VF devfns (enabled but not yet assigned to a VM) it fails and generates log messages similar to:

[  416.800881] dmar: DRHD: handling fault status reg 2
[  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault addr ffff0000
DMAR:[fault reason 02] Present bit in context entry is clear

Shouldn't a DMA alias quirk that sets the PCI_DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF devfn for all VF devfns work-around this issue, or am I misunderstanding what a DMA alias quirk is supposed to do?  If a DMA alias quirk cannot resolve this, what is the most appropriate way to handle this?

Thanks,
Bruce.
