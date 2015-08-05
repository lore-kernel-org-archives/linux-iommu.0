From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/26] iommu/vt-d: Clean up device<->domain  attachment
Date: Wed,  5 Aug 2015 17:18:31 +0200
Message-ID: <1438787937-7340-1-git-send-email-joro@8bytes.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a (bigger than I expected) patch-set which cleans up
the code to attach and detach domains to iommus in the Intel
VT-d driver.

In particular, the patch-set does:

	* Remove special cases around the handling of
	  various domain types and align their handling
	  where possible

	* Rework the data structures for the domain<->iommu
	  relation to better match with its usage. This
	  allowed to get rid of a couple of search loops.

	* Make the domain attachment and detachment path
	  to/from an iommu more symmetric. This makes the
	  code easier to understand and maintain.

	* Rework and simplify the locking around the
	  domain<->iommu attachment/detachment path.

A few rough edges and special cases are still left, but I
expect that these will be removed with the conversion to
default domains.

I tested the code with some additional debug code to make
sure that domain and domain-id allocation/deallocation works
as expected.

As test I booted a kernel with the patches (with and
without iommu=pt) and ran a KVM guest with devices assigned.
No lockdep warning popped up and the debug output was also
fine. But of course this is no guarantee that there are no
issues left, so I am happy about feedback. Please review!

Thanks,

	Joerg

Joerg Roedel (26):
  iommu/vt-d: Keep track of per-iommu domain ids
  iommu/vt-d: Add access functions for iommu->domains
  iommu/vt-d: Split up iommu->domains array
  iommu/vt-d: Get rid of iommu_attach_vm_domain()
  iommu/vt-d: Calculate translation in domain_context_mapping_one
  iommu/vt-d: Simplify domain_context_mapping_one
  iommu/vt-d: Pass dmar_domain directly into iommu_flush_iotlb_psi
  iommu/vt-d: Don't pre-allocate domain ids for si_domain
  iommu/vt-d: Kill dmar_domain->id
  iommu/vt-d: Replace iommu_bmp with a refcount
  iommu/vt-d: Simplify io/tlb flushing in intel_iommu_unmap
  iommu/vt-d: Simplify domain_remove_one_dev_info()
  iommu/vt-d: Simplify domain_remove_dev_info()
  iommu/vt-d: Move context-mapping  into dmar_insert_dev_info
  iommu/vt-d: Rename dmar_insert_dev_info()
  iommu/vt-d: Rename domain_remove_one_dev_info()
  iommu/vt-d: Rename iommu_detach_dependent_devices()
  iommu/vt-d: Pass an iommu pointer to domain_init()
  iommu/vt-d: Establish domain<->iommu link in dmar_insert_one_dev_info
  iommu/vt-d: Unify domain->iommu attach/detachment
  iommu/vt-d: Only call domain_remove_one_dev_info to detach old domain
  iommu/vt-d: Get rid of domain->iommu_lock
  iommu/vt-d: Remove dmar_global_lock from device_notifier
  iommu/vt-d: Pass device_domain_info to __dmar_remove_one_dev_info
  iommu/vt-d: Only insert alias dev_info if there is an alias
  iommu/vt-d: Avoid duplicate device_domain_info structures

 drivers/iommu/intel-iommu.c | 664 ++++++++++++++++++++------------------------
 include/linux/intel-iommu.h |   2 +-
 2 files changed, 295 insertions(+), 371 deletions(-)

-- 
1.9.1
