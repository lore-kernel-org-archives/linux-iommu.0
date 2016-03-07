From: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 0/7] PAMU driver update
Date: Mon, 7 Mar 2016 17:34:16 +0200
Message-ID: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
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
Cc: scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset addresses a few issues found on PAMU IOMMU
and small changes to enable power management and to support the
L3 cache controller on some newer boards.

The series starts with a clean-up patch, followed by two
errata fixes: A-007907 and A-005982. It continues with
two fixes for PCIe support. The last two patches add support
for power management and compatible strings for new L3 controller
device-tree nodes.

Codrin Ciubotariu (2):
  iommu/fsl: Fix most checkpatch warnings and typos
  iommu/fsl: Work around erratum A-007907

Varun Sethi (5):
  iommu/fsl: Enable OMT cache, before invalidating PAACT and SPAACT
    cache
  iommu/fsl: Factor out PCI specific code
  iommu/fsl: Enable default DMA window for PCIe devices once detached
    from domain
  iommu/fsl: PAMU power management support
  iommu/fsl: Added cache controller compatible strings for SOCs

 drivers/iommu/fsl_pamu.c        | 322 ++++++++++++++++++++++++++++++++--------
 drivers/iommu/fsl_pamu.h        |  30 ++--
 drivers/iommu/fsl_pamu_domain.c | 160 +++++++++++++-------
 drivers/iommu/fsl_pamu_domain.h |   2 +-
 4 files changed, 381 insertions(+), 133 deletions(-)

-- 
1.9.3
