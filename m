From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/22 v2] Introduce default domains for iommu groups
Date: Thu, 28 May 2015 18:41:23 +0200
Message-ID: <1432831305-11126-1-git-send-email-joro@8bytes.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of my patch-set to introduce
default domains into the iommu core. This time it has a lot
more patches, mostly because I added a proof of concept
implementation by converting the AMD IOMMU driver to make
use of it.

Converting the first driver to the new concept triggered a
lot of changes and extensions in the patch-set to fit all
the needs of a more complex iommu driver. Converting other
drivers might need further changes, but that is something
for the future.

A major change is that now the default domain has to be
allocated by the code that allocates the iommu group. For
PCI devices this happens in the IOMMU core, but drivers
allocating the group on their own can now implement a policy
that fits their needs (e.g. not allocate one domain per
group but let multiple groups share one domain).

The new core code is changed in a way to stay compatible
with the old behavior. All IOMMU drivers that are not yet
converted to default domains should behave as without this
patch-set.

I tested the patches on AMD systems with IOMMUv1 and
IOMMUv2, did boot-testing and also successfully tested
device assignment. I did the same tests on an Intel VT-d
machine to make sure the changes do not introduce
regressions on unconverted drivers.

If you prefer a git branch for testing, please look here:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git iommu-default-domains

Any feedback and further testing welcome!

Thanks,

	Joerg


Joerg Roedel (22):
  iommu: Remove function name from pr_fmt()
  iommu: Add a few printk messages to group handling code
  iommu: Propagate error in add_iommu_group
  iommu: Clean up after a failed bus initialization
  iommu: Call remove_device call-back after driver release
  iommu: Allocate a default domain for iommu groups
  iommu: Limit iommu_attach/detach_device to devices with their own
    group
  iommu: Make sure a device is always attached to a domain
  iommu: Add iommu_get_domain_for_dev function
  iommu: Introduce direct mapped region handling
  iommu: Create direct mappings in default domains
  iommu: Add function to query the default domain of a group
  iommu: Introduce iommu_request_dm_for_dev()
  iommu/amd: Implement dm_region call-backs
  iommu/amd: Use default domain if available for DMA-API
  iommu/amd: Implement add_device and remove_device
  iommu/amd: Support IOMMU_DOMAIN_DMA type allocation
  iommu/amd: Support IOMMU_DOMAIN_IDENTITY type allocation
  iommu/amd: Put IOMMUv2 devices in a direct mapped domain
  iommu/amd: Get rid of device_dma_ops_init()
  iommu/amd: Remove unused fields from struct dma_ops_domain
  iommu/amd: Propagate errors from amd_iommu_init_api

 drivers/iommu/amd_iommu.c       | 568 ++++++++++++----------------------------
 drivers/iommu/amd_iommu_init.c  |  34 +--
 drivers/iommu/amd_iommu_proto.h |   2 +-
 drivers/iommu/amd_iommu_types.h |  11 -
 drivers/iommu/iommu.c           | 369 ++++++++++++++++++++++++--
 include/linux/iommu.h           |  44 ++++
 6 files changed, 562 insertions(+), 466 deletions(-)

-- 
1.9.1
