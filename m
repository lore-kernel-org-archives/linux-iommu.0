From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/6 v2] Introduce device_iommu_mapped() function
Date: Tue, 11 Dec 2018 14:43:37 +0100
Message-ID: <20181211134343.10664-1-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sam Bobroff <sbobroff-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Russell Currey <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of this patch-set. It replaces
the various (dev->iommu_group) checks with a function call
which better expresses their intend.

Changes to the first version are the added patch for
rcar-dmac, a driver I missed before. I also added all
Acked-By's I received on the first version.

Please review and provide Acks, if there are no objections.
I have some iommu patches that depend on these, so I'd like
to carry this patch-set in the IOMMU tree.

Regards,

	Joerg

Joerg Roedel (6):
  driver core: Introduce device_iommu_mapped() function
  iommu/of: Use device_iommu_mapped()
  ACPI/IORT: Use device_iommu_mapped()
  powerpc/iommu: Use device_iommu_mapped()
  xhci: Use device_iommu_mapped()
  dmaengine: sh: rcar-dmac: Use device_iommu_mapped()

 arch/powerpc/kernel/eeh.c   |  2 +-
 arch/powerpc/kernel/iommu.c |  6 +++---
 drivers/acpi/arm64/iort.c   |  2 +-
 drivers/dma/sh/rcar-dmac.c  |  2 +-
 drivers/iommu/of_iommu.c    |  2 +-
 drivers/usb/host/xhci.c     |  2 +-
 include/linux/device.h      | 10 ++++++++++
 7 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.17.1
