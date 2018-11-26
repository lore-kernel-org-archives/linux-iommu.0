From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date: Mon, 26 Nov 2018 14:15:22 +0300
Message-ID: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vg
List-Id: iommu@lists.linux-foundation.org

Recent systems shipping with Windows 10 version 1803 or newer may be
utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
different from the previous security level based scheme because the
connected device cannot access system memory outside of the regions
allocated for it by the driver.

When enabled the BIOS makes sure no device can do DMA outside of RMRR
(Reserved Memory Region Record) regions. This means that during OS boot,
before it enables IOMMU, none of the connected devices can bypass DMA
protection for instance by overwriting the data structures used by the
IOMMU. The BIOS communicates support for this to the OS by setting a new
bit in ACPI DMAR table [1].

Because these systems utilize an IOMMU to block possible DMA attacks,
typically (but not always) the Thunderbolt security level is set to "none"
which means that all PCIe devices are immediately usable. This also means
that Linux needs to follow Windows 10 and enable IOMMU automatically when
running on such system otherwise connected devices can read/write system
memory pretty much without any restrictions.

Since there is a way to identify PCIe root ports that are "external facing"
we can put all internal devices to pass through (identity mapping) mode and
only external devices need to go through full IOMMU mappings. We add a new
flag "is_untrusted" that is supposed to cover various PCIe devices that may
be used to conduct DMA attacks.

We also make sure PCIe ATS (Address Translation Service) is not enabled for
devices flagged as untrusted because it could be used to bypass IOMMU
completely as explained in the changelog of patch 3/4.

Finally we expose this information to userspace so tools such as bolt can
do more accurate decision whether or not authorize the connected device.

I can take these through Thunderbolt tree assuming Bjorn and Rafael are
fine with these.

[1] https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Previous version of the patch series can be found here:

  https://www.spinics.net/lists/linux-pci/msg77751.html

Changes from v1:

  * Reword Documentation/admin-guide/thunderbolt.rst to make the feature
    time frame/platform oriented as there will be systems shipping
    with Linux installed by default.

  * Rename the flag is_external to is_untrusted so that we could use the
    same flag to cover all kinds of "untrusted" PCI devices, not just
    Thunderbolt connected devices. I still parse the _DSD in PCI/ACPI core
    because that's where we currently handle "HotPlugSupportInD3" as well.
    Also updated comments in patch [1/4].

  * Added tags from Ashok, Joerg and Yehezkel. I'm assuming they still
    apply because I did not change the code with the exception of few
    comments and rename of the flag. Let me know if that's not the case
    anymore.

Lu Baolu (1):
  iommu/vt-d: Force IOMMU on for platform opt in hint

Mika Westerberg (3):
  PCI / ACPI: Identify untrusted PCI devices
  iommu/vt-d: Do not enable ATS for untrusted devices
  thunderbolt: Export IOMMU based DMA protection support to userspace

 .../ABI/testing/sysfs-bus-thunderbolt         |  9 +++
 Documentation/admin-guide/thunderbolt.rst     | 20 +++++++
 drivers/acpi/property.c                       |  3 +
 drivers/iommu/dmar.c                          | 25 +++++++++
 drivers/iommu/intel-iommu.c                   | 56 ++++++++++++++++++-
 drivers/pci/pci-acpi.c                        | 18 ++++++
 drivers/pci/probe.c                           | 22 ++++++++
 drivers/thunderbolt/domain.c                  | 17 ++++++
 include/linux/dmar.h                          |  8 +++
 include/linux/pci.h                           |  8 +++
 10 files changed, 183 insertions(+), 3 deletions(-)

-- 
2.19.1
