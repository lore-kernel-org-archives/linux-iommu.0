From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] PCI: ACS enable quirk for link balancing switches
Date: Wed, 26 Oct 2016 12:01:11 -0600
Message-ID: <20161026175156.23495.12980.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A series exposing and extracting bits of things that the kernel
already does, culminating in an ACS enabling quirk to work around an
errata where data through a Pericom PCIe switch gets stuck when the
upstream and downstream ports are running at different link speeds and
P2P Request Redirection is enabled.

If you have a Syba SD-PEX24033 or card making use of this PCIe switch
in a similar way, and find that it doesn't work right when installed
into a 5.0GT/s+ slot and the IOMMU is enabled, you want this series.
Thanks,

Alex

---

Alex Williamson (5):
      PCI: Make pci_std_enable_acs() non-static
      PCI: Extract link speed & width retrieval from pcie_get_minimum_link()
      PCI: Extract link retraining from pcie_aspm_configure_common_clock()
      iommu: Move REQ_ACS_FLAGS out to header and rename
      PCI: Balance ports to avoid ACS errata on Pericom switches


 drivers/iommu/iommu.c   |   18 ++----
 drivers/pci/pci.c       |   57 ++++++++++++++++--
 drivers/pci/pcie/aspm.c |   17 -----
 drivers/pci/quirks.c    |  147 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h   |   11 ++++
 include/linux/pci.h     |    4 +
 6 files changed, 218 insertions(+), 36 deletions(-)
