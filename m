From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to return
	bus number and device id
Date: Mon, 11 Feb 2013 16:00:14 -0700
Message-ID: <1360623614.2950.60.camel@lorien2>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linasvepstas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

pci defines PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces, however,
it doesn't have interfaces to return PCI bus and PCI device id. Drivers
(AMD IOMMU, and AER) have module specific definitions for PCI_BUS() and
AMD_IOMMU driver also has a module specific interface to calculate PCI
device id from bus number and devfn.

This patch set adds PCI_BUS(), and PCI_DEVID() to pci.h, changes are to
use PCI_BUS() from pci. Changes AMD_IOMMU driver to use PCI_BUS() and
PCI_DEVID() from pci.

Files changed:

 include/uapi/linux/pci.h |    4 ++++
 1 file changed, 4 insertions(+)

 drivers/pci/pcie/aer/aerdrv_core.c |    2 --
 1 file changed, 2 deletions(-)

 drivers/iommu/amd_iommu_types.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

 drivers/iommu/amd_iommu.c       |    2 +-
 drivers/iommu/amd_iommu_init.c  |    6 +++---
 drivers/iommu/amd_iommu_types.h |    7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)
