From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 0/5] iommu: Introduce default domains for iommu groups
Date: Tue, 27 Jan 2015 01:08:54 +0100
Message-ID: <1422317339-22620-1-git-send-email-joro@8bytes.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

this is a patch-set to add a default domain to each
iommu-group present in the system. The default domain is
used for devices that are not assigned to any other domain.

This means, when a device is detached from a domain, it
is automatically re-assigned to its default domain. These
changes make use of the domain types introduced in another
patch-set. The default domain is allocated with type
IOMMU_DOMAIN_DMA to be used in a common DMA-API implemention
later.

For now the default-domain handling is an opt-in for iommu
drivers, as some changes are required in them. First of all,
the semantics of the attach_domain callback has changed.
This callback must not fail if a device is already attached
to a domain, but just overwrite the existing attachment.
This semantic change allows to get rid of the detach_domain
callback when all drivers are converted.

A driver can enable default domains for itself by
implementing a domain_alloc callback that can return domains
of the IOMMU_DOMAIN_DMA type. But these patches only
implement domains in the core code and do not convert any
driver yet.

This patch-set also makes the difference between
attach/detach_device and attach/detach_group more explict.
With patch 3 applied, attach/detach_device will only succeed
when the device is the only one in its group. This probably
requires changes in the callers, which are not included
here.

Any useful comments and feedback appreciated.

Thanks,

	Joerg

Joerg Roedel (5):
  iommu: Add default domain to iommu-groups
  iommu: Allocate a default domain for iommu groups
  iommu: Limit iommu_attach/detach_device to devices with their own
    group
  iommu: Make sure a device is always attached to a domain
  iommu: Add iommu_get_domain_for_dev function

 drivers/iommu/iommu.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/iommu.h |   6 +++
 2 files changed, 138 insertions(+), 10 deletions(-)

-- 
1.9.1
