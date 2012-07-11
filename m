From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/7] Make IOMMU-API ready for GART-like hardware
Date: Wed, 11 Jul 2012 12:49:16 +0200
Message-ID: <1342003763-8139-1-git-send-email-joerg.roedel@amd.com>
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

here is finally a new version of this patch-set. Changes to the previous
version include:

	* Rebased to v3.5-rc6
	* Added missing Acked-by's

The potential issue with type-safety still exists. But since people are
desperatly waiting for the functionality of this patch-set I think we
live with it for now. If it turns out to be a real problem we can change
it any time.
Unless any major objections come up I plan to queue these patches for
v3.6.

Regards,

	Joerg

Diffstat:

 drivers/iommu/amd_iommu.c    |    4 ++++
 drivers/iommu/exynos-iommu.c |    4 ++++
 drivers/iommu/intel-iommu.c  |    4 ++++
 drivers/iommu/iommu.c        |   33 +++++++++++++++++++++++++++++++++
 drivers/iommu/msm_iommu.c    |    5 +++++
 drivers/iommu/omap-iommu.c   |    4 ++++
 drivers/iommu/tegra-gart.c   |    5 +++++
 drivers/iommu/tegra-smmu.c   |    5 +++++
 include/linux/iommu.h        |   36 +++++++++++++++++++++++++++++++++++-

 9 files changed, 99 insertions(+), 1 deletion(-)
