From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/3] iommu/fsl: PAMU driver fixes.
Date: Sun, 13 Oct 2013 02:02:31 +0530
Message-ID: <1381609954-15283-1-git-send-email-Varun.Sethi@freescale.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The first patch fixes a build failure, when we try to build for a Freescale
platform without PCI support.

The second patch enables a default DMA window for the device, once it's
detached from a domain. In case of vfio, once device is detached from a
guest it can be again used by the host.

The last patch adds the maintainer entry for the Freescale PAMU driver.

Varun Sethi (3):
  iommu/fsl: Factor out PCI specific code.
  iommu/fsl: Enable default DMA window for PCIe devices once detached
  Add maintainers entry for the Freescale PAMU driver.

 MAINTAINERS                     |    7 +++
 drivers/iommu/fsl_pamu.c        |   43 ++++++++++++---
 drivers/iommu/fsl_pamu.h        |    1 +
 drivers/iommu/fsl_pamu_domain.c |  116 +++++++++++++++++++++++++--------------
 4 files changed, 117 insertions(+), 50 deletions(-)

-- 
1.7.9.5
