Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5780C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B26784129;
	Thu,  7 Apr 2022 16:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FB0LhEoQ7kXl; Thu,  7 Apr 2022 16:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A116F840B8;
	Thu,  7 Apr 2022 16:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BBACC001D;
	Thu,  7 Apr 2022 16:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D7E4C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 800A5612A2
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmTHMnEHxH80 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:21:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23B70612A0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=04waCzc1/d2UZmMXuw2PXk+J6f5XQzdg3pAe0UrfN/Q=; b=oPIlPQycw1S8szXF8c4/CHGjLW
 WDDeDe9Uey3MFlX3GtCyEOhz+eXrl1620/AAeT3ggWKwmgLqA7KjFZ9Kf1C7YauNtvwL/liMpVZgt
 +VifA7A6vNtOzvs+EYnliJtR0aG7sp4TGmAXxesxGb09iAHzdIadpsf8Kdw69APIW8qNqk0sa477b
 kzjFLziSX5kGOFBk7ig4p1AYKkEJkPZHeD1+mxLzTtrcw70zdeiDhUVbmH2+7/7vW8fn7W7ofKDsa
 ajRu7/EBT65I0zeYp0FJFB2IPG/jfcmG2sBHDcI1sdz8cBj/RTt0yXRfvZh8drzcE5f9n95EVAaZ0
 AaDPDijg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMI-002BBe-Nw; Thu, 07 Apr 2022 09:47:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMF-00022Q-Ce; Thu, 07 Apr 2022 09:47:39 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:47:16 -0600
Message-Id: <20220407154717.7695-21-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
a hunk of p2pmem into userspace.

Pages are allocated from the genalloc in bulk with their reference
count set to one. They are returned to the genalloc when the page is put
through p2pdma_page_free() (the reference count is once again set to 1
in free_zone_device_page()).

The VMA does not take a reference to the pages when they are inserted
with vmf_insert_mixed() (which is necessary for zone device pages) so
the backing P2P memory is stored in a structures in vm_private_data.

A pseudo mount is used to allocate an inode for each PCI device. The
inode's address_space is used in the file doing the mmap so that all
VMAs are collected and can be unmapped if the PCI device is unbound.
After unmapping, the VMAs are iterated through and their pages are
put so the device can continue to be unbound. An active flag is used
to signal to VMAs not to allocate any further P2P memory once the
removal process starts. The flag is synchronized with concurrent
access with an RCU lock.

The VMAs and inode will survive after the unbind of the device, but no
pages will be present in the VMA and a subsequent access will result
in a SIGBUS error.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c       | 340 ++++++++++++++++++++++++++++++++++++-
 include/linux/pci-p2pdma.h |  11 ++
 include/uapi/linux/magic.h |   1 +
 3 files changed, 350 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4d3cab9da748..cce4c7b6dd75 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -17,14 +17,19 @@
 #include <linux/genalloc.h>
 #include <linux/memremap.h>
 #include <linux/percpu-refcount.h>
+#include <linux/pfn_t.h>
+#include <linux/pseudo_fs.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
+#include <uapi/linux/magic.h>
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
 	struct xarray map_types;
+	struct inode *inode;
+	bool active;
 };
 
 struct pci_p2pdma_pagemap {
@@ -33,6 +38,17 @@ struct pci_p2pdma_pagemap {
 	u64 bus_offset;
 };
 
+struct pci_p2pdma_map {
+	struct kref ref;
+	struct rcu_head rcu;
+	struct pci_dev *pdev;
+	struct inode *inode;
+	size_t len;
+
+	spinlock_t kaddr_lock;
+	void *kaddr;
+};
+
 static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
 {
 	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
@@ -101,6 +117,38 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
+/*
+ * P2PDMA internal mount
+ * Fake an internal VFS mount-point in order to allocate struct address_space
+ * mappings to remove VMAs on unbind events.
+ */
+static int pci_p2pdma_fs_cnt;
+static struct vfsmount *pci_p2pdma_fs_mnt;
+
+static int pci_p2pdma_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, P2PDMA_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type pci_p2pdma_fs_type = {
+	.name = "p2dma",
+	.owner = THIS_MODULE,
+	.init_fs_context = pci_p2pdma_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static void p2pdma_page_free(struct page *page)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+
+	gen_pool_free(pgmap->provider->p2pdma->pool,
+		      (uintptr_t)page_to_virt(page), PAGE_SIZE);
+}
+
+static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
+	.page_free = p2pdma_page_free,
+};
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -117,6 +165,9 @@ static void pci_p2pdma_release(void *data)
 	gen_pool_destroy(p2pdma->pool);
 	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 	xa_destroy(&p2pdma->map_types);
+
+	iput(p2pdma->inode);
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
 }
 
 static int pci_p2pdma_setup(struct pci_dev *pdev)
@@ -134,17 +185,32 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p->pool)
 		goto out;
 
-	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
+	error = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
+			      &pci_p2pdma_fs_cnt);
 	if (error)
 		goto out_pool_destroy;
 
+	p2p->inode = alloc_anon_inode(pci_p2pdma_fs_mnt->mnt_sb);
+	if (IS_ERR(p2p->inode)) {
+		error = -ENOMEM;
+		goto out_unpin_fs;
+	}
+
+	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
+	if (error)
+		goto out_put_inode;
+
 	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
 	if (error)
-		goto out_pool_destroy;
+		goto out_put_inode;
 
 	rcu_assign_pointer(pdev->p2pdma, p2p);
 	return 0;
 
+out_put_inode:
+	iput(p2p->inode);
+out_unpin_fs:
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
 out_pool_destroy:
 	gen_pool_destroy(p2p->pool);
 out:
@@ -152,6 +218,54 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static void pci_p2pdma_map_free_pages(struct pci_p2pdma_map *pmap)
+{
+	int i;
+
+	if (!pmap->kaddr)
+		return;
+
+	for (i = 0; i < pmap->len; i += PAGE_SIZE)
+		put_page(virt_to_page(pmap->kaddr + i));
+
+	pmap->kaddr = NULL;
+}
+
+static void pci_p2pdma_free_mappings(struct address_space *mapping)
+{
+	struct vm_area_struct *vma;
+
+	i_mmap_lock_write(mapping);
+	if (RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
+		goto out;
+
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, -1)
+		pci_p2pdma_map_free_pages(vma->vm_private_data);
+
+out:
+	i_mmap_unlock_write(mapping);
+}
+
+static void pci_p2pdma_unmap_mappings(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
+
+	/* Ensure no new pages can be allocated in mappings */
+	p2pdma->active = false;
+	synchronize_rcu();
+
+	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
+
+	/*
+	 * On some architectures, TLB flushes are done with call_rcu()
+	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
+	 * before freeing them.
+	 */
+	synchronize_rcu();
+	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
+}
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -198,6 +312,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
@@ -209,6 +324,11 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
+	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
+					 pdev);
+	if (error)
+		goto pages_free;
+
 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
@@ -217,6 +337,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	if (error)
 		goto pages_free;
 
+	p2pdma->active = true;
 	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
 		 pgmap->range.start, pgmap->range.end);
 
@@ -1018,3 +1139,218 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 	return sprintf(page, "%s\n", pci_name(p2p_dev));
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
+
+static struct pci_p2pdma_map *pci_p2pdma_map_alloc(struct pci_dev *pdev,
+						   size_t len)
+{
+	struct pci_p2pdma_map *pmap;
+
+	pmap = kzalloc(sizeof(*pmap), GFP_KERNEL);
+	if (!pmap)
+		return NULL;
+
+	kref_init(&pmap->ref);
+	pmap->pdev = pci_dev_get(pdev);
+	pmap->len = len;
+
+	return pmap;
+}
+
+static void pci_p2pdma_map_free(struct rcu_head *rcu)
+{
+	struct pci_p2pdma_map *pmap =
+		container_of(rcu, struct pci_p2pdma_map, rcu);
+
+	pci_p2pdma_map_free_pages(pmap);
+	kfree(pmap);
+}
+
+static void pci_p2pdma_map_release(struct kref *ref)
+{
+	struct pci_p2pdma_map *pmap =
+		container_of(ref, struct pci_p2pdma_map, ref);
+
+	iput(pmap->inode);
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
+	pci_dev_put(pmap->pdev);
+
+	if (pmap->kaddr) {
+		/*
+		 * Make sure to wait for the TLB flush (which some
+		 * architectures do using call_rcu()) before returning the
+		 * pages to the genalloc. This ensures the pages are not reused
+		 * before GUP-fast is finished with them. So the mapping is
+		 * freed using call_rcu() seeing adding synchronize_rcu() to
+		 * the munmap path can cause long delays on large systems
+		 * during process cleanup.
+		 */
+		call_rcu(&pmap->rcu, pci_p2pdma_map_free);
+		return;
+	}
+
+	/*
+	 * If there are no pages, just free the object immediately. There
+	 * are no more references to it so there is nothing that can race
+	 * with adding the pages.
+	 */
+	pci_p2pdma_map_free(&pmap->rcu);
+}
+
+static void pci_p2pdma_vma_open(struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap = vma->vm_private_data;
+
+	kref_get(&pmap->ref);
+}
+
+static void pci_p2pdma_vma_close(struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap = vma->vm_private_data;
+
+	kref_put(&pmap->ref, pci_p2pdma_map_release);
+}
+
+static bool pci_p2pdma_vma_alloc(struct pci_p2pdma_map *pmap)
+{
+	struct pci_p2pdma *p2pdma;
+	bool ret = true;
+	void *kaddr;
+
+	spin_lock(&pmap->kaddr_lock);
+	if (pmap->kaddr)
+		goto out_spin_unlock;
+
+	rcu_read_lock();
+	ret = false;
+	p2pdma = rcu_dereference(pmap->pdev->p2pdma);
+	if (!p2pdma)
+		goto out_rcu_unlock;
+
+	if (!p2pdma->active)
+		goto out_rcu_unlock;
+
+	kaddr = (void *)gen_pool_alloc(p2pdma->pool, pmap->len);
+	if (!kaddr) {
+		pci_err(pmap->pdev,
+				"No free P2PDMA memory for userspace mmap\n");
+		goto out_rcu_unlock;
+	}
+
+	WRITE_ONCE(pmap->kaddr, kaddr);
+	ret = true;
+
+out_rcu_unlock:
+	rcu_read_unlock();
+out_spin_unlock:
+	spin_unlock(&pmap->kaddr_lock);
+	return ret;
+}
+
+static vm_fault_t pci_p2pdma_vma_fault(struct vm_fault *vmf)
+{
+	struct pci_p2pdma_map *pmap = vmf->vma->vm_private_data;
+	void *vaddr;
+	pfn_t pfn;
+
+	if (!READ_ONCE(pmap->kaddr)) {
+		if (!pci_p2pdma_vma_alloc(pmap))
+			return VM_FAULT_SIGBUS;
+	}
+
+	vaddr = pmap->kaddr + vmf->address - vmf->vma->vm_start;
+	pfn = phys_to_pfn_t(virt_to_phys(vaddr), PFN_DEV | PFN_MAP);
+
+	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+}
+static const struct vm_operations_struct pci_p2pdma_vmops = {
+	.open = pci_p2pdma_vma_open,
+	.close = pci_p2pdma_vma_close,
+	.fault = pci_p2pdma_vma_fault,
+};
+
+/**
+ * pci_p2pdma_file_open - setup file mapping to store P2PMEM VMAs
+ * @pdev: the device to allocate memory from
+ * @vma: the userspace vma to map the memory to
+ *
+ * Set f_mapping of the file to the p2pdma inode so that mappings
+ * are can be torn down on device unbind.
+ *
+ * Returns 0 on success, or a negative error code on failure
+ */
+void pci_p2pdma_file_open(struct pci_dev *pdev, struct file *file)
+{
+	struct pci_p2pdma *p2pdma;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma)
+		file->f_mapping = p2pdma->inode->i_mapping;
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_file_open);
+
+/**
+ * pci_mmap_p2pmem - setup an mmap region to be backed with P2PDMA memory
+ *	that was registered with pci_p2pdma_add_resource()
+ * @pdev: the device to allocate memory from
+ * @vma: the userspace vma to map the memory to
+ *
+ * The file must call pci_p2pdma_mmap_file_open() in its open() operation.
+ *
+ * Returns 0 on success, or a negative error code on failure
+ */
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap;
+	struct pci_p2pdma *p2pdma;
+	int ret;
+
+	/* prevent private mappings from being established */
+	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted private mapping\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	if (vma->vm_pgoff) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted mapping with non-zero offset\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
+	if (!pmap)
+		return -ENOMEM;
+
+	spin_lock_init(&pmap->kaddr_lock);
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
+			    &pci_p2pdma_fs_cnt);
+	if (ret)
+		goto out;
+
+	ihold(p2pdma->inode);
+	pmap->inode = p2pdma->inode;
+	rcu_read_unlock();
+
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_private_data = pmap;
+	vma->vm_ops = &pci_p2pdma_vmops;
+
+	return 0;
+
+out:
+	rcu_read_unlock();
+	kfree(pmap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_mmap_p2pmem);
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 2c07aa6b7665..040d79126463 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -34,6 +34,8 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 			       bool use_p2pdma);
+void pci_p2pdma_file_open(struct pci_dev *pdev, struct file *file);
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -90,6 +92,15 @@ static inline ssize_t pci_p2pdma_enable_show(char *page,
 {
 	return sprintf(page, "none\n");
 }
+static inline void pci_p2pdma_file_open(struct pci_dev *pdev,
+					struct file *file)
+{
+}
+static inline int pci_mmap_p2pmem(struct pci_dev *pdev,
+				  struct vm_area_struct *vma)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f724129c0425..59ba2e60dc03 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -95,6 +95,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
 #define ZONEFS_MAGIC		0x5a4f4653
+#define P2PDMA_MAGIC		0x70327064
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
