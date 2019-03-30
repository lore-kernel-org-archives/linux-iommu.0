From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 4.19 38/57] iommu/dmar: Fix buffer overflow during PCI
	bus notification
Date: Fri, 29 Mar 2019 21:28:31 -0400
Message-ID: <20190330012854.32212-38-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190330012854.32212-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Julia Cartwright <julia-acOepvfBmUk@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Julia Cartwright <julia-acOepvfBmUk@public.gmane.org>

[ Upstream commit cffaaf0c816238c45cd2d06913476c83eb50f682 ]

Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
device path") changed the type of the path data, however, the change in
path type was not reflected in size calculations.  Update to use the
correct type and prevent a buffer overflow.

This bug manifests in systems with deep PCI hierarchies, and can lead to
an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
or can lead to overflow of slab-allocated data.

   BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0x2e0
   Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-02406-gd0a0e96 #1
   Call Trace:
    ? dump_stack+0x46/0x59
    ? print_address_description+0x1df/0x290
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? kasan_report+0x256/0x340
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? e820__memblock_setup+0xb0/0xb0
    ? dmar_dev_scope_init+0x424/0x48f
    ? __down_write_common+0x1ec/0x230
    ? dmar_dev_scope_init+0x48f/0x48f
    ? dmar_free_unused_resources+0x109/0x109
    ? cpumask_next+0x16/0x20
    ? __kmem_cache_create+0x392/0x430
    ? kmem_cache_create+0x135/0x2f0
    ? e820__memblock_setup+0xb0/0xb0
    ? intel_iommu_init+0x170/0x1848
    ? _raw_spin_unlock_irqrestore+0x32/0x60
    ? migrate_enable+0x27a/0x5b0
    ? sched_setattr+0x20/0x20
    ? migrate_disable+0x1fc/0x380
    ? task_rq_lock+0x170/0x170
    ? try_to_run_init_process+0x40/0x40
    ? locks_remove_file+0x85/0x2f0
    ? dev_prepare_static_identity_mapping+0x78/0x78
    ? rt_spin_unlock+0x39/0x50
    ? lockref_put_or_lock+0x2a/0x40
    ? dput+0x128/0x2f0
    ? __rcu_read_unlock+0x66/0x80
    ? __fput+0x250/0x300
    ? __rcu_read_lock+0x1b/0x30
    ? mntput_no_expire+0x38/0x290
    ? e820__memblock_setup+0xb0/0xb0
    ? pci_iommu_init+0x25/0x63
    ? pci_iommu_init+0x25/0x63
    ? do_one_initcall+0x7e/0x1c0
    ? initcall_blacklisted+0x120/0x120
    ? kernel_init_freeable+0x27b/0x307
    ? rest_init+0xd0/0xd0
    ? kernel_init+0xf/0x120
    ? rest_init+0xd0/0xd0
    ? ret_from_fork+0x1f/0x40
   The buggy address belongs to the variable:
    dmar_pci_notify_info_buf+0x40/0x60

Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI device path")
Signed-off-by: Julia Cartwright <julia-acOepvfBmUk@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index d9c748b6f9e4..7f9824b0609e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -144,7 +144,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 		for (tmp = dev; tmp; tmp = tmp->bus->self)
 			level++;
 
-	size = sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
+	size = sizeof(*info) + level * sizeof(info->path[0]);
 	if (size <= sizeof(dmar_pci_notify_info_buf)) {
 		info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
 	} else {
-- 
2.19.1
