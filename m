From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4] iommu/pamu: Support generic iommu-device handles
Date: Wed,  9 Aug 2017 16:46:50 +0200
Message-ID: <1502290014-2890-1-git-send-email-joro@8bytes.org>
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
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Here is a patch-set to support the iommu_device_register()
interface in the fsl-pamu iommu driver. To make it work a
few fixes (Patch 1 and 2), an additional check (Patch 3)
were necessary.

Please review.

Regards,

	Joerg

Joerg Roedel (4):
  iommu/pamu: Let PAMU depend on PCI
  iommu/pamu: Make driver depend on CONFIG_PHYS_64BIT
  iommu/pamu: WARN when fsl_pamu_probe() is called more than once
  iommu/pamu: Add support for generic iommu-device

 drivers/iommu/Kconfig           |  2 ++
 drivers/iommu/fsl_pamu.c        | 24 ++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h        |  3 +++
 drivers/iommu/fsl_pamu_domain.c |  5 ++++-
 drivers/iommu/fsl_pamu_domain.h |  2 ++
 5 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.7.4
