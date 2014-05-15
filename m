From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 00/10] Renesas ipmmu-vmsa: Miscellaneous cleanups and fixes
Date: Thu, 15 May 2014 12:40:41 +0200
Message-ID: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set cleans up and fixes small issues in the ipmmu-vmsa driver. The
patches are based on top of "[PATCH v3] iommu: Add driver for Renesas
VMSA-compatible IPMMU" that adds the ipmmu-vmsa driver.

The most interesting part of this series is the rewrite of the page table
management code. The IOMMU core guarantees that the map and unmap operations
will always be called only with page sizes advertised by the driver. We can
use that assumption to remove loops of PGD and PMD entries, simplifying the
code.

Joerg, is there still time to get this merged in v3.16 ? The patches have all
been posted previously and the only comment I've received was about a missing
#define in patch 04/10.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

Changes since v1:

- Add missing IPMMU_PTRS_PER_PUD definition in patch 04/10

Laurent Pinchart (10):
  iommu/ipmmu-vmsa: Refactor micro-TLB lookup
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Fix the supported page sizes
  iommu/ipmmu-vmsa: Define driver-specific page directory sizes
  iommu/ipmmu-vmsa: Set the PTE contiguous hint bit when possible
  iommu/ipmmu-vmsa: PMD is never folded, PUD always is
  iommu/ipmmu-vmsa: Rewrite page table management
  iommu/ipmmu-vmsa: Support 2MB mappings
  iommu/ipmmu-vmsa: Remove stage 2 PTE bits definitions
  iommu/ipmmu-vmsa: Support clearing mappings

 drivers/iommu/ipmmu-vmsa.c | 535 ++++++++++++++++++++++++++++++---------------
 1 file changed, 361 insertions(+), 174 deletions(-)

-- 
Regards,

Laurent Pinchart
