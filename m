From: Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/vt-d: Don't register bus-notifier under
Date: Fri, 6 Oct 2017 15:08:23 +0200
Message-ID: <20171006130823.a4rtzhusjpbgo3ar@suse.de>
References: <4e9f9665-38f7-c5f0-2a9d-13bb3a00aab2@siemens.com>
 <6ed4183a-b2eb-b8d3-c54c-fb0c4fd7a813@siemens.com>
 <82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hey Jan,

On Wed, Sep 27, 2017 at 04:19:15PM +0200, Jan Kiszka wrote:
> If we could drop the dmar_global_lock around bus_register_notifier in
> dmar_dev_scope_init, the issue above would likely be resolved.

That is true. Can you please try this patch?

>From dd7685f84d3954f9361bfb4290fb8a0dd033097a Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Fri, 6 Oct 2017 15:00:53 +0200
Subject: [PATCH] iommu/vt-d: Don't register bus-notifier under
 dmar_global_lock

The notifier function will take the dmar_global_lock too, so
lockdep complains about inverse locking order when the
notifier is registered under the dmar_global_lock.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 59ce0515cdaf ('iommu/vt-d: Update DRHD/RMRR/ATSR device scope caches when PCI hotplug happens')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/dmar.c        |  7 +++++--
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 include/linux/dmar.h        |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 57c920c1372d..1ea7cd537873 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -801,13 +801,16 @@ int __init dmar_dev_scope_init(void)
 				dmar_free_pci_notify_info(info);
 			}
 		}
-
-		bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 	}
 
 	return dmar_dev_scope_status;
 }
 
+void dmar_register_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
+}
+
 
 int __init dmar_table_init(void)
 {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6784a05dd6b2..934cef924461 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4752,6 +4752,16 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+	up_write(&dmar_global_lock);
+
+	/*
+	 * The bus notifier takes the dmar_global_lock, so lockdep will
+	 * complain later when we register it under the lock.
+	 */
+	dmar_register_bus_notifier();
+
+	down_write(&dmar_global_lock);
+
 	if (no_iommu || dmar_disabled) {
 		/*
 		 * We exit the function here to ensure IOMMU's remapping and
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e8ffba1052d3..e2433bc50210 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -112,6 +112,7 @@ static inline bool dmar_rcu_check(void)
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
+extern void dmar_register_bus_notifier(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
-- 
2.13.6
