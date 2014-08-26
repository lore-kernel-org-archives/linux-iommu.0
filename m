From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4] AMD IOMMU: Assign/de-assign complete alias groups
Date: Tue, 26 Aug 2014 11:36:10 +0200
Message-ID: <1409045774-32000-1-git-send-email-joro@8bytes.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Here is a patch-set to fix the following issue:

When a device is added to an iommu domain, the current amd
iommu code will add the device itself and the device it
aliases to to the domain. But this alias relation is
uni-directional.

If, for example, device 03:00.1 aliases to 03:00.0 and is
added to a domain, the iommu code will add both devices.
But if 03.00.0 is added, 03.00.1 will be not.

This is a problem with some broken devices that appear with
function 0 on the bus but use function 1 as the request-id.
These devices will not work with the current implementation.

This patch-set changes the behavior of the code by
introducing alias-groups (similar to iommu-groups, but
support non-existent pci devices) and always
assigns/de-assigns complete alias groups to/from a domain.

This makes the alias relation bi-directional and fixes the
issues with broken devices.

Thanks,

	Joerg

Joerg Roedel (4):
  iommu/amd: Move struct iommu_dev_data to amd_iommu.c
  iommu/amd: Keep a list of devices in an alias group
  iommu/amd: Attach and detach complete alias group
  iommu/amd: Remove device binding reference count

 drivers/iommu/amd_iommu.c       | 74 +++++++++++++++++++++++++----------------
 drivers/iommu/amd_iommu_types.h | 21 ------------
 2 files changed, 46 insertions(+), 49 deletions(-)

-- 
1.9.1
