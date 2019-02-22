From: James Dong <xmdong@google.com>
Subject: RE: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Fri, 22 Feb 2019 08:28:29 +0000
Message-ID: <20190222082829.75567-1-xmdong@google.com>
References: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>, James Dong <xmdong@google.com>
List-Id: iommu@lists.linux-foundation.org

Baolu:

The reproduction depends on devices. HW passthrough PCIe devices with default
identity map could have the issue. Make sure that messages like following came
out in dmesg and their mapping does not change after booting:
  [   10.167809] DMAR: Hardware identity mapping for device 0000:30:00.0
  [   10.167823] DMAR: Hardware identity mapping for device 0000:30:00.1

Devices which make following true could also be used for the experiment:
  > static int iommu_should_identity_map(struct device *dev, int startup)
  > {
  >		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
  >			return 1;
  >		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
  >			return 1;

Once they are up, remove them first by following command:
  echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove

Then trigger the hotplug device rescanning:
  echo 1 > /sys/bus/pci/rescan

To provide an example of specific devices on the market, I need to try out.
Or, if it is fine with you, forcing a PCIe NIC card to be default hardware
passthrough by changing the intel-iommu.c is another easy way to reproduce
this issue.

Best Regards,
James
