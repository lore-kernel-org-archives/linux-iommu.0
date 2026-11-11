Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438298;
	b=OpF8vESqiOInucYQEC9/IwBkMS46EU3xIyyqZZ7wxDaAplVDdEqNuQL+5Uhz/cc+Smi0
	 UnDqbyXq0gg/gyVvmzmxeVTr01wOTHpgu7LBnxira4aamyeAUayoTCgOFfFk0QIitQsql
	 r1CSrsA4fDvBWw/EaSmjFGiNm7orcRbimjXGslsPafii3ceCFxX3PRmfsYWw98fGFM/Zg
	 ueQr1d0vAVvPa/uewsCzWfKZ4x6mZYZfuViYx95Vlni1TGOvQbVhQUZL1Yo1P7RsaafrY
	 2nCgf6iv1qM+6OGrDW/iKTIxf/a8Bu8Obvwq0fYvLjxxtIGotPPRrvizG0jUoNEyNZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438298;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VDizH9UQlJDrepSMCVqebqfI8dVRrw1tTfp8o4jN0b0=;
	b=M1jlHamsOBT8TAmgiQEUyA3V4pLSeR9oSF1omYdQB/QtHb4tCO3y9je8yr6wDeSkvtxI
	 ZELHe7VXZ/JmyutSUsgON+7/RY0n8Xeq5JEhBqitf7J81lg0v+ZTx4zdOsD4MmGt46Tmb
	 3NEBuk+vnsti903ZQ6VqLMLha8osG6aCesCdfK6gxj7KG291qSue2hSpm2f3tYlJHyw89
	 k8wJ+7vIkXi3IgHZF/1XN2inIYAvva84V3bTf0FfDwEzWWyTk03DBukWqNc/cvhOnJa6q
	 AR6iznDgxe+xlYk/byaJKtLiTVihjcT2w03+ANBYNVoApACBMwzyYntcDQHKqPEHIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=UMqWaeRi;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C01606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C01606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=UMqWaeRi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438296; x=1825974296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VDizH9UQlJDrepSMCVqebqfI8dVRrw1tTfp8o4jN0b0=;
  b=UMqWaeRiCpW89sE7m17lUWRbu9CdCsONyD6+pNgQXq3DjPT/Col1fIJH
   mpqdZCV1Krermc6Dq1yZ2FrOAe2Bg06vCEnbv3xYbFPzPfDxGWGnxt5L0
   Z3xfn312MuBwdnIOip7Pn5M9aEZ1lrS/lvfN3tswWQBJxlY5OoshIGlrx
   tk/Y8+8twHr+u+KdgM4qiPcxn+CVF8MRrrxnP/dnzuVyXIQARgNAA5tda
   fif/byD826FFRG4m+LreH2iQ/h/D8g6RNqLTPbeTwz6ukP6xogHULnC+5
   CpHTdXbVkLtAhN6ScIlIir6WlA0tOlEX4NzXdE2xBo3uG5U2Cr6JjwXAN
   A==;
X-CSE-ConnectionGUID: 2Z2qPgUdRGiyPPZRhSVGgg==
X-CSE-MsgGUID: ZTCm3efdRCi+Zh0l5MYAXg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33551036"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:04:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:8802]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 2ea21bb7-5cd9-4159-9d18-e65c0640ea10; Wed, 11 Nov 2026 23:04:56 +0000 (UTC)
X-Farcaster-Flow-ID: 2ea21bb7-5cd9-4159-9d18-e65c0640ea10
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:04:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:04:53 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 24/40] nitro_enclaves: Add NE_ADD_DEVICE
Date: Wed, 11 Nov 2026 22:59:28 +0000
Message-ID: <6dc9984007af3ef768d10cc7586e4d180c98e873.1794393490.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Nitro Sandboxes allow the parent to back arbitrary virtio devices:
virtio-blk, virtio-net, virtio-console, etc. Their backend runs in the
user space process that drives the nitro_enclaves device.

Add the NE_ADD_DEVICE ioctl to enable user space to drive device addition.
It takes a device type, the offered feature bits, a configuration blob,
and struct ne_shm_region entries that name the NE_ALLOC_MEMORY allocations
the device works out of and the id the sandbox knows each one by.

When the hypervisor successfully added the device to the slot, it adds
the full device info, including VQ mapping, into the info page.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/virt/ne_overview.rst        |   6 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 463 +++++++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  19 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.h  |  16 +-
 include/uapi/linux/nitro_enclaves.h       | 195 ++++++++-
 5 files changed, 671 insertions(+), 28 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index ba030cde59989..012fcb394a2ef 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -212,9 +212,9 @@ NE_SET_USER_MEMORY_REGION is unchanged and still takes the address of a
 hugetlbfs region.
 
 An allocation lives until the last of the things holding it is gone: its
-descriptor, its mappings, the regions given from it and the enclave it is the
-info page of. So neither closing the descriptor nor unmapping takes memory away
-from a running enclave.
+descriptor, its mappings, the regions given from it, the enclave it is the info
+page of and the enclave it is a device's memory of. So neither closing the
+descriptor nor unmapping takes memory away from a running enclave.
 
 Slot pool
 ---------
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 208c1997609d3..7698c7210eb86 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -125,6 +125,8 @@ static int ne_alloc_memory_ioctl(struct ne_enclave *ne_enclave,
 				 struct ne_alloc_memory_args *args);
 static int ne_set_info_page_ioctl(struct ne_enclave *ne_enclave,
 				  struct ne_set_info_page_args *args);
+static int ne_add_device_ioctl(struct ne_enclave *ne_enclave,
+			       struct ne_add_device_args *args);
 static const struct file_operations ne_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= noop_llseek,
@@ -2189,6 +2191,45 @@ static long ne_enclave_do_ioctl(struct file *file, unsigned int cmd, unsigned lo
 		return rc;
 	}
 
+	case NE_EA_IOCTL(NE_ADD_DEVICE): {
+		struct ne_add_device_args __user *uargs = (void __user *)arg;
+		unsigned int usize = _IOC_SIZE(cmd);
+		struct ne_add_device_args args;
+		int rc;
+
+		if (usize < offsetofend(struct ne_add_device_args, vq_info))
+			return -EINVAL;
+
+		rc = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+		if (rc)
+			return rc;
+
+		rc = mutex_lock_killable(&ne_enclave->enclave_info_mutex);
+		if (rc)
+			return rc;
+
+		if (ne_enclave->state != NE_STATE_INIT) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "Enclave is not in init state\n");
+
+			mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+			return -NE_ERR_NOT_IN_INIT_STATE;
+		}
+
+		rc = ne_add_device_ioctl(ne_enclave, &args);
+
+		mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+		if (rc < 0)
+			return rc;
+
+		if (copy_to_user(uargs, &args, min_t(size_t, usize, sizeof(args))))
+			return -EFAULT;
+
+		return 0;
+	}
+
 	default:
 		return -ENOTTY;
 	}
@@ -2228,8 +2269,8 @@ static long ne_enclave_ioctl(struct file *file, unsigned int cmd, unsigned long
 
 /**
  * ne_enclave_remove_all_contig_regions() - Drop the enclave's references to the
- *					    allocations it was given.
- * @ne_enclave :	Private data associated with the current enclave.
+ *					    allocations on one of its lists.
+ * @regions :	One of the enclave's lists of held allocations.
  *
  * The last reference on an allocation's file frees its runs and gives back its
  * %RLIMIT_MEMLOCK charge, so an allocation whose descriptor and mappings are
@@ -2238,13 +2279,12 @@ static long ne_enclave_ioctl(struct file *file, unsigned int cmd, unsigned long
  * Context: Process context. This function is called on an enclave that is on
  *	    no list and has no file left.
  */
-static void ne_enclave_remove_all_contig_regions(struct ne_enclave *ne_enclave)
+static void ne_enclave_remove_all_contig_regions(struct list_head *regions)
 {
 	struct ne_contig_region *ne_contig_region = NULL;
 	struct ne_contig_region *tmp = NULL;
 
-	list_for_each_entry_safe(ne_contig_region, tmp,
-				 &ne_enclave->contig_regions_list, list) {
+	list_for_each_entry_safe(ne_contig_region, tmp, regions, list) {
 		list_del(&ne_contig_region->list);
 
 		fput(ne_contig_region->file);
@@ -2397,7 +2437,8 @@ int ne_enclave_free_slot(struct ne_pci_dev *ne_pci_dev,
  */
 static void ne_enclave_free(struct ne_enclave *ne_enclave)
 {
-	ne_enclave_remove_all_contig_regions(ne_enclave);
+	ne_enclave_remove_all_contig_regions(&ne_enclave->contig_regions_list);
+	ne_enclave_remove_all_contig_regions(&ne_enclave->device_regions_list);
 	ne_enclave_remove_all_mem_region_entries(ne_enclave);
 	ne_enclave_remove_all_vcpu_id_entries(ne_enclave);
 
@@ -2648,6 +2689,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	mutex_init(&ne_enclave->enclave_info_mutex);
 	ne_enclave->max_mem_regions = cmd_reply.alloc.mem_regions;
 	INIT_LIST_HEAD(&ne_enclave->contig_regions_list);
+	INIT_LIST_HEAD(&ne_enclave->device_regions_list);
 	INIT_LIST_HEAD(&ne_enclave->mem_regions_list);
 	ne_enclave->mm = current->mm;
 	ne_enclave->slot_uid = cmd_reply.alloc.slot_uid;
@@ -3751,6 +3793,15 @@ static int ne_add_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		return -NE_ERR_MEM_REGION_ALREADY_USED;
 	}
 
+	list_for_each_entry(held, &ne_enclave->device_regions_list, list) {
+		if (held->file == fd_file(f)) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "The allocation is a device's\n");
+
+			return -NE_ERR_MEM_REGION_ALREADY_USED;
+		}
+	}
+
 	list_for_each_entry(held, &ne_enclave->contig_regions_list, list) {
 		if (held->file == fd_file(f)) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
@@ -3885,6 +3936,7 @@ static int ne_set_info_page_ioctl(struct ne_enclave *ne_enclave,
 	struct ne_pci_dev_cmd_reply cmd_reply = {};
 	struct slot_add_info_page_req req = {};
 	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
+	struct ne_contig_region *held = NULL;
 	struct ne_contig_mem *mem = NULL;
 	int rc = -EINVAL;
 
@@ -3961,6 +4013,15 @@ static int ne_set_info_page_ioctl(struct ne_enclave *ne_enclave,
 		return -NE_ERR_MEM_REGION_ALREADY_USED;
 	}
 
+	list_for_each_entry(held, &ne_enclave->device_regions_list, list) {
+		if (held->file == fd_file(f)) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "The info page allocation is a device's\n");
+
+			return -NE_ERR_MEM_REGION_ALREADY_USED;
+		}
+	}
+
 	rc = ne_contig_make_read_only(fd_file(f));
 	if (rc < 0) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
@@ -4007,6 +4068,396 @@ static int ne_set_info_page_ioctl(struct ne_enclave *ne_enclave,
 	return 0;
 }
 
+/**
+ * ne_add_device_region() - Take one of a device's shared memory regions.
+ * @ne_enclave:	Private data associated with the current enclave.
+ * @region:	Descriptor for the allocation the region is made of, and the id
+ *		the enclave sees the region as.
+ * @req:	Request being built. The runs of the allocation are appended to
+ *		its backing ranges, each tagged with the region's id.
+ * @regions:	List the reference taken on the allocation is recorded on, so
+ *		that a later region failing gives every earlier one back.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex held.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+static int ne_add_device_region(struct ne_enclave *ne_enclave,
+				const struct ne_shm_region *region,
+				struct slot_add_device_req *req,
+				struct list_head *regions)
+{
+	struct ne_contig_region *ne_contig_region = NULL;
+	struct ne_contig_region *held = NULL;
+	struct ne_contig_mem *mem = NULL;
+	struct file *file = NULL;
+	unsigned int i = 0;
+	int rc = -EINVAL;
+
+	if (region->reserved[0] || region->reserved[1] || region->reserved[2])
+		return -EINVAL;
+
+	file = fget(region->fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &ne_contig_fops) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Not an enclave memory allocation\n");
+
+		goto put_file;
+	}
+
+	mem = file->private_data;
+
+	if (mem->enclave_id != ne_enclave->id) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Allocation was made for another enclave\n");
+
+		goto put_file;
+	}
+
+	/*
+	 * The parent drives its end of the device's queues through a mapping of
+	 * the allocation, and a private allocation cannot be mapped.
+	 */
+	if (!mem->shared) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device allocation is not shared\n");
+
+		goto put_file;
+	}
+
+	if (mem->donated) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device allocation was donated\n");
+
+		rc = -NE_ERR_MEM_REGION_ALREADY_USED;
+
+		goto put_file;
+	}
+
+	if (file == ne_enclave->info_file) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The allocation is the enclave's info page\n");
+
+		rc = -NE_ERR_MEM_REGION_ALREADY_USED;
+
+		goto put_file;
+	}
+
+	list_for_each_entry(held, &ne_enclave->device_regions_list, list) {
+		if (held->file == file) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "The allocation is already a device's\n");
+
+			rc = -NE_ERR_MEM_REGION_ALREADY_USED;
+
+			goto put_file;
+		}
+	}
+
+	list_for_each_entry(held, regions, list) {
+		if (held->file == file) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "Two regions of the device name one allocation\n");
+
+			rc = -NE_ERR_MEM_REGION_ALREADY_USED;
+
+			goto put_file;
+		}
+	}
+
+	/*
+	 * The device takes one address and one length per run of every region,
+	 * and the request has room for NE_MAX_BACKING_RANGES of them.
+	 */
+	if (mem->nr_allocs > NE_MAX_BACKING_RANGES - req->num_backing_ranges) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device regions are more than %d runs\n",
+				    NE_MAX_BACKING_RANGES);
+
+		goto put_file;
+	}
+
+	/*
+	 * A run's length shares its word with the id of the region the run
+	 * belongs to, so a length that reached into the id would arrive at the
+	 * device as another region's memory rather than as a wrong length.
+	 */
+	for (i = 0; i < mem->nr_allocs; i++) {
+		u64 run = (u64)mem->allocs[i].nr_pages << PAGE_SHIFT;
+
+		if (run > NE_RANGE_SIZE_MASK) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "A device region run is longer than %llu bytes\n",
+					    NE_RANGE_SIZE_MASK);
+
+			goto put_file;
+		}
+	}
+
+	ne_contig_region = kzalloc_obj(*ne_contig_region);
+	if (!ne_contig_region) {
+		rc = -ENOMEM;
+
+		goto put_file;
+	}
+
+	for (i = 0; i < mem->nr_allocs; i++) {
+		struct ne_backing_range *range =
+			&req->backing_ranges[req->num_backing_ranges++];
+
+		range->phys_addr = page_to_phys(mem->allocs[i].page);
+		range->size = ((u64)mem->allocs[i].nr_pages << PAGE_SHIFT) |
+			      ((u64)region->shm_id << NE_RANGE_SHMID_SHIFT);
+	}
+
+	ne_contig_region->file = file;
+	list_add(&ne_contig_region->list, regions);
+
+	return 0;
+
+put_file:
+	fput(file);
+
+	return rc;
+}
+
+/**
+ * ne_add_device_ioctl() - Give the enclave a device it drives itself.
+ * @ne_enclave:	Private data associated with the current enclave.
+ * @args:	Descriptors for the allocations the device works from, what the
+ *		device is, and where the wiring of its queues is returned.
+ *
+ * The device works out of the runs of the allocations, so they have to stay where
+ * the device was told they are for as long as the enclave lives, and the
+ * references this takes on the files keep them whatever user space does with the
+ * descriptors and their mappings. ne_enclave_free() drops those references
+ * after SLOT_FREE. The allocations are not donated, so the parent keeps writing
+ * to them and reading them back to drive its end of the device's queues.
+ *
+ * The device writes the wiring of the queues to the info page and the reply says
+ * where, so this reads it from there rather than out of the reply, and returns
+ * it to the caller.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex held.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+static int ne_add_device_ioctl(struct ne_enclave *ne_enclave,
+			       struct ne_add_device_args *args)
+{
+	struct ne_pci_dev_cmd_reply cmd_reply = {};
+	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
+	struct ne_shm_region *shm_regions = NULL;
+	const struct ne_vq_wiring *wiring = NULL;
+	struct slot_add_device_req *req = NULL;
+	struct ne_contig_mem *info = NULL;
+	LIST_HEAD(regions);
+	u8 buf[NE_MAX_VQS * sizeof(struct ne_vq_wiring)];
+	u64 wiring_off = 0;
+	u64 wiring_len = 0;
+	u64 copied = 0;
+	u64 n = 0;
+	unsigned int i = 0;
+	int rc = -EINVAL;
+
+	if (ne_enclave->mm != current->mm)
+		return -EIO;
+
+	if (args->flags >= NE_ADD_DEVICE_MAX_FLAG_VAL) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Incorrect flag for adding a device\n");
+
+		return -NE_ERR_INVALID_FLAG_VALUE;
+	}
+
+	if (args->padding)
+		return -EINVAL;
+
+	if (args->num_vqs > NE_MAX_VQS) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device has more than %d queues\n",
+				    NE_MAX_VQS);
+
+		return -EINVAL;
+	}
+
+	if (args->config_size > sizeof(args->device_config)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device configuration is longer than %zu bytes\n",
+				    sizeof(args->device_config));
+
+		return -EINVAL;
+	}
+
+	/*
+	 * The device reports the wiring of the queues by writing the info page,
+	 * so a slot without one has nowhere for it to land.
+	 */
+	if (!ne_enclave->info_file) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The slot has no info page\n");
+
+		return -EINVAL;
+	}
+
+	if (args->flags & NE_DEVICE_NO_SHM_REGIONS) {
+		if (args->num_shm_regions || args->shm_regions_ptr) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "The device names memory it works out of anyway\n");
+
+			return -EINVAL;
+		}
+	} else if (!args->num_shm_regions) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device names no memory to work out of\n");
+
+		return -EINVAL;
+	}
+
+	/*
+	 * Every region is made of at least one run, so the number of runs the
+	 * device takes bounds how many regions it can have.
+	 */
+	if (args->num_shm_regions > NE_MAX_BACKING_RANGES) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "The device has more than %d regions\n",
+				    NE_MAX_BACKING_RANGES);
+
+		return -EINVAL;
+	}
+
+	if (args->num_shm_regions) {
+		shm_regions = memdup_array_user(u64_to_user_ptr(args->shm_regions_ptr),
+						args->num_shm_regions,
+						sizeof(*shm_regions));
+		if (IS_ERR(shm_regions))
+			return PTR_ERR(shm_regions);
+	}
+
+	req = kzalloc_obj(*req);
+	if (!req) {
+		rc = -ENOMEM;
+
+		goto free;
+	}
+
+	for (i = 0; i < args->num_shm_regions; i++) {
+		rc = ne_add_device_region(ne_enclave, &shm_regions[i], req,
+					  &regions);
+		if (rc < 0)
+			goto free;
+	}
+
+	req->slot_uid = ne_enclave->slot_uid;
+	req->device_type = args->device_type;
+	req->num_vqs = args->num_vqs;
+	req->config_size = args->config_size;
+
+	memcpy(req->device_features, args->device_features,
+	       sizeof(req->device_features));
+	memcpy(req->device_config, args->device_config, args->config_size);
+
+	rc = ne_do_request(pdev, SLOT_ADD_DEVICE, req, sizeof(*req),
+			   &cmd_reply, sizeof(cmd_reply));
+	if (rc < 0) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Error in slot add device [rc=%d]\n", rc);
+
+		/*
+		 * A negative return does not say whether the device took the
+		 * runs. The command may have been turned down, or it may never
+		 * have been answered and still be in flight, and one request
+		 * carries the runs of every region, so a device that turned it
+		 * down may have taken some of them first. The enclave holds
+		 * them either way and ne_enclave_free() gives them back after
+		 * SLOT_FREE, as the two SLOT_ADD_MEM sites do.
+		 */
+		list_splice_init(&regions, &ne_enclave->device_regions_list);
+
+		goto free;
+	}
+
+	/*
+	 * The device works out of the runs from here on, so the enclave holds
+	 * the allocations even if this call goes on to fail, and
+	 * ne_enclave_free() gives them back after SLOT_FREE.
+	 */
+	list_splice_init(&regions, &ne_enclave->device_regions_list);
+
+	if (cmd_reply.add_device.num_vqs != args->num_vqs) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Device wired %u of the %u queues asked for\n",
+				    cmd_reply.add_device.num_vqs,
+				    args->num_vqs);
+
+		rc = -EPROTO;
+
+		goto free;
+	}
+
+	info = ne_enclave->info_file->private_data;
+	wiring_off = cmd_reply.add_device.vq_wiring_offset;
+	wiring_len = (u64)args->num_vqs * sizeof(struct ne_vq_wiring);
+
+	if (args->num_vqs && (wiring_off > info->size ||
+			      wiring_len > info->size - wiring_off)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Device put the wiring of %u queues at %llu of the info page\n",
+				    args->num_vqs, wiring_off);
+
+		rc = -EPROTO;
+
+		goto free;
+	}
+
+	/*
+	 * Where the kernel may have highmem a run is not contiguous in the
+	 * direct map, so the entries are copied a page at a time rather than
+	 * read through one address, and the copy makes no assumption about how
+	 * the device aligned them.
+	 */
+	for (copied = 0; copied < wiring_len; copied += n) {
+		u64 pos = wiring_off + copied;
+
+		n = min_t(u64, wiring_len - copied,
+			  PAGE_SIZE - (pos & ~PAGE_MASK));
+		memcpy_from_page(buf + copied,
+				 info->allocs[0].page + (pos >> PAGE_SHIFT),
+				 pos & ~PAGE_MASK, n);
+	}
+
+	wiring = (const struct ne_vq_wiring *)buf;
+
+	for (i = 0; i < args->num_vqs; i++) {
+		args->vq_info[i].msix_vector = wiring[i].msix_vector;
+		args->vq_info[i].notify_index = wiring[i].notify_index;
+		args->vq_info[i].msix_entry = wiring[i].msix_entry;
+		args->vq_info[i].doorbell_offset = wiring[i].doorbell_offset;
+	}
+
+	args->device_uid = cmd_reply.add_device.device_uid;
+
+	rc = 0;
+
+free:
+	/*
+	 * Whatever is still on the local list belongs to a call that was refused
+	 * before the device was told about any of it, so those references go
+	 * back. A call the device was told about has already put its regions on
+	 * the enclave, leaving nothing here.
+	 */
+	ne_enclave_remove_all_contig_regions(&regions);
+	kfree(req);
+	kfree(shm_regions);
+
+	return rc;
+}
+
 #if defined(CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST)
 #include "ne_misc_dev_test.c"
 #endif
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 59374a35c3c7d..4f695f1410aec 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -39,8 +39,8 @@ struct ne_contig_alloc {
  * @nr_allocs:	Number of runs in @allocs.
  * @size:	Size of the allocation in bytes, mirrored in i_size.
  * @shared:	Whether the caller asked for a shared allocation. A shared one may
- *		be mapped by the caller and may be a slot's info page; a private
- *		one is neither.
+ *		be mapped by the caller and may be a slot's info page or the memory
+ *		of one of its devices; a private one is none of those.
  * @enclave_id:	Id of the enclave the allocation was made for.
  * @mm:		The mm charged for the pinned pages, held via mmgrab().
  * @nr_pinned:	Pages charged to @mm->pinned_vm.
@@ -52,7 +52,8 @@ struct ne_contig_alloc {
  *
  * The runs hang off the file, so that closing the last descriptor does not free
  * memory an enclave is still using: a donated region holds the file with
- * get_file(), and so does the enclave the allocation is the info page of. That
+ * get_file(), and so does the enclave the allocation is the info page or a
+ * device's memory of. That
  * is also what keeps a mapping's page table entries from outliving the runs,
  * since a VMA holds vm_file for as long as it exists.
  *
@@ -67,8 +68,8 @@ struct ne_contig_alloc {
  *
  * @enclave_id is compared, never dereferenced, and the counter it comes from is
  * 64 bits wide, so an allocation cannot be donated to, or become the info page
- * of, a later enclave that happens to have been placed at the address of the one
- * it was made for.
+ * or a device's memory of, a later enclave that happens to have been placed at
+ * the address of the one it was made for.
  */
 struct ne_contig_mem {
 	struct ne_contig_alloc	*allocs;
@@ -85,8 +86,8 @@ struct ne_contig_mem {
 };
 
 /**
- * struct ne_contig_region - Enclave memory given from one allocation.
- * @list:	Entry in the enclave's list of allocations given to it.
+ * struct ne_contig_region - One %NE_ALLOC_MEMORY allocation an enclave holds.
+ * @list:	Entry in one of the enclave's lists of held allocations.
  * @file:	File holding the runs, held with get_file() so that they outlive the
  *		descriptor the allocation was handed out on and its mappings.
  */
@@ -121,6 +122,9 @@ struct ne_mem_region {
  *				held for writing.
  * @contig_regions_list:	List of %NE_ALLOC_MEMORY allocations given to the
  *				enclave with %NE_ADD_MEMORY_REGION.
+ * @device_regions_list:	List of %NE_ALLOC_MEMORY allocations a device of
+ *				the enclave works from, given with
+ *				%NE_ADD_DEVICE.
  * @enclave_list_entry :	Entry in the list of created enclaves.
  * @eventq:			Wait queue used for out-of-band event notifications
  *				triggered from the PCI device event handler to
@@ -162,6 +166,7 @@ struct ne_enclave {
 	bool			detached;
 	bool			slot_freed;
 	struct list_head	contig_regions_list;
+	struct list_head	device_regions_list;
 	struct list_head	enclave_list_entry;
 	wait_queue_head_t	eventq;
 	bool			has_event;
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 3445318b84672..a0bca5863e2a1 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -7,6 +7,7 @@
 #define _NE_PCI_DEV_H_
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -346,10 +347,23 @@ struct slot_add_info_page_req {
  */
 #define NE_MAX_BACKING_RANGES		(4)
 
+/**
+ * NE_RANGE_SIZE_MASK - The part of a backing range's size that is a byte count.
+ */
+#define NE_RANGE_SIZE_MASK		GENMASK_ULL(55, 0)
+
+/**
+ * NE_RANGE_SHMID_SHIFT - Where a backing range's size carries the id of the
+ *			  shared memory region the run belongs to.
+ */
+#define NE_RANGE_SHMID_SHIFT		(56)
+
 /**
  * struct ne_backing_range - One run of enclave memory a device works out of.
  * @phys_addr:	Physical address of the run, in the parent's address space.
- * @size:	Size, in bytes, of the run.
+ * @size:	Size, in bytes, of the run in the low %NE_RANGE_SIZE_MASK bits,
+ *		and the id of the shared memory region the run belongs to in the
+ *		8 bits above them. A device tells its regions apart by that id.
  */
 struct ne_backing_range {
 	u64	phys_addr;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 4f604712983f1..6f83a8b0762b3 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -317,11 +317,11 @@ struct ne_alloc_memory_args {
  *		     Donating does not take a mapping away, so a parent that
  *		     mapped a shared allocation can still write to it through
  *		     that mapping afterwards.
- *		     The allocation lives until the last of the descriptor, its
- *		     mappings, the enclave regions donated from it and the
- *		     enclave it is the info page of is gone, so a caller can
- *		     close the descriptor as soon as it has donated it or
- *		     provided it to the device.
+ *		     The allocation lives until the descriptor, its mappings,
+ *		     the enclave regions donated from it and the enclave that
+ *		     uses it as an info page or as device memory are all gone,
+ *		     so a caller can close the descriptor as soon as it has
+ *		     handed it over.
  *		     The ioctl can be invoked on the enclave fd, before an
  *		     enclave is started.
  *
@@ -396,8 +396,8 @@ struct ne_add_memory_region_args {
  *			  contiguous run it is made of, or fewer where runs turn
  *			  out to be physically adjacent. The argument is input
  *			  only. The allocation has to have been made for this
- *			  enclave, cannot be its info page, and can be given away
- *			  once.
+ *			  enclave, cannot be its info page or the memory of one
+ *			  of its devices, and can be given away once.
  *			  Writing to the descriptor stops working here, so an
  *			  enclave image goes in before this call. The allocation
  *			  has to be %NE_MEMORY_PRIVATE, since memory the parent
@@ -434,7 +434,8 @@ struct ne_add_memory_region_args {
  *					  before being started).
  * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
  * * NE_ERR_MEM_REGION_ALREADY_USED	- The allocation was already given to the
- *					  enclave, or is its info page.
+ *					  enclave, or is its info page, or is the
+ *					  memory of one of its devices.
  * * NE_ERR_MEM_MAX_REGIONS		- The number of memory regions set for the
  *					  enclave reached maximum.
  * * Error codes from the NE PCI device request.
@@ -470,8 +471,9 @@ struct ne_set_info_page_args {
  *		      made writable, so the call fails while one exists, and a
  *		      caller maps the page after the call. A call the device
  *		      rejects leaves the allocation writable again.
- *		      A slot takes one info page, and an allocation is either an
- *		      enclave's memory or its info page. The driver holds the
+ *		      A slot takes one info page, and an allocation is an
+ *		      enclave's memory, its info page or the memory of one of its
+ *		      devices, never two of those. The driver holds the
  *		      allocation until the enclave is gone, so closing the
  *		      descriptor does not free the run the device was given.
  *		      The ioctl can be invoked on the enclave fd, before an
@@ -501,7 +503,8 @@ struct ne_set_info_page_args {
  *					  before being started).
  * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
  * * NE_ERR_MEM_REGION_ALREADY_USED	- The allocation was already given to the
- *					  enclave with %NE_ADD_MEMORY_REGION.
+ *					  enclave with %NE_ADD_MEMORY_REGION, or is
+ *					  the memory of one of its devices.
  * * ETIMEDOUT				- The device did not answer. The slot keeps
  *					  the allocation, read-only, until the
  *					  enclave is gone, since the device may
@@ -510,6 +513,176 @@ struct ne_set_info_page_args {
  */
 #define NE_SET_INFO_PAGE		_IOW(0xAE, 0x25, struct ne_set_info_page_args)
 
+/**
+ * NE_MAX_VQS - Highest number of virtqueues one device may have.
+ */
+#define NE_MAX_VQS			(64)
+
+/**
+ * struct ne_vq_info - How the enclave reaches one virtqueue of a device.
+ * @msix_vector:	Interrupt vector the device raises for the queue.
+ * @notify_index:	Index the enclave writes to notify the device.
+ * @msix_entry:		Entry in the enclave's interrupt table holding
+ *			@msix_vector.
+ * @doorbell_offset:	Offset of the queue's doorbell in the device's doorbell
+ *			window.
+ */
+struct ne_vq_info {
+	__u16	msix_vector;
+	__u16	notify_index;
+	__u16	msix_entry;
+	__u16	doorbell_offset;
+};
+
+/**
+ * NE_DEVICE_NO_SHM_REGIONS - The call names no shared memory region, so
+ *			      @num_shm_regions and @shm_regions_ptr both have
+ *			      to be zero. A device that works out of the
+ *			      enclave's own %NE_ADD_MEMORY_REGION memory is
+ *			      what it is for.
+ */
+#define NE_DEVICE_NO_SHM_REGIONS	(0x01)
+
+#define NE_ADD_DEVICE_MAX_FLAG_VAL	(0x02)
+
+/**
+ * NE_DEVICE_TYPE_VIRTIO - A virtio device. The low 16 bits of @device_type
+ *			   carry the virtio device id the enclave sees.
+ */
+#define NE_DEVICE_TYPE_VIRTIO		(0u << 16)
+
+/**
+ * struct ne_shm_region - One shared memory region of a device (in).
+ * @fd:		Descriptor from %NE_ALLOC_MEMORY, made for this enclave, asked
+ *		for as %NE_MEMORY_SHARED, and named by one region only.
+ * @shm_id:	Shared memory region id the enclave sees the region as. The
+ *		driver puts it in the top 8 bits of the size it gives the device
+ *		for every run of the allocation, so that the enclave and the
+ *		device can tell one of a device's regions from another. The
+ *		parent and the enclave agree on the numbering; the driver does
+ *		not read it.
+ * @reserved:	Must be zero.
+ */
+struct ne_shm_region {
+	__s32	fd;
+	__u8	shm_id;
+	__u8	reserved[3];
+};
+
+/**
+ * struct ne_add_device_args - Device to give an enclave (in / out).
+ * @flags:		%NE_DEVICE_NO_SHM_REGIONS or zero.
+ * @device_type:	Type of device to give the enclave. The top 16 bits name
+ *			the class of device, of which %NE_DEVICE_TYPE_VIRTIO is
+ *			the only one, and the class says what the low 16 bits
+ *			carry.
+ * @num_vqs:		Number of virtqueues the device has, at most
+ *			%NE_MAX_VQS.
+ * @config_size:	Number of bytes of @device_config the device reads.
+ * @num_shm_regions:	Number of entries of @shm_regions_ptr, at least one
+ *			unless %NE_DEVICE_NO_SHM_REGIONS is set, and made
+ *			of no more than four runs in total.
+ * @padding:		Must be zero.
+ * @device_features:	Feature bits the parent offers the enclave for the
+ *			device.
+ * @device_config:	Type-specific configuration of the device.
+ * @shm_regions_ptr:	Address of @num_shm_regions struct ne_shm_region.
+ * @device_uid:		Id the device gave the new device (out).
+ * @vq_info:		How the enclave reaches the device's first @num_vqs
+ *			virtqueues (out).
+ */
+struct ne_add_device_args {
+	__u32	flags;
+	__u32	device_type;
+	__u32	num_vqs;
+	__u32	config_size;
+	__u32	num_shm_regions;
+	__u32	padding;
+	__u8	device_features[64];
+	__u8	device_config[64];
+	__u64	shm_regions_ptr;
+	__u64	device_uid;
+	struct ne_vq_info vq_info[NE_MAX_VQS];
+};
+
+/**
+ * NE_ADD_DEVICE - The command is used to give an enclave a device it drives
+ *		   itself, out of the %NE_ALLOC_MEMORY allocations the device
+ *		   works from. One allocation is one shared memory region of the
+ *		   device, and the region's id goes to the enclave with it, so
+ *		   that a device made of several of them tells them apart. Every
+ *		   allocation has to be %NE_MEMORY_SHARED, since the parent
+ *		   drives the other end of the device's virtqueues through a
+ *		   mapping of one, and none of them is donated, so writing to
+ *		   the descriptors keeps working. They are not enclave memory
+ *		   either: they do not count towards the memory regions
+ *		   %NE_ADD_MEMORY_REGION fills, and an allocation is a device's
+ *		   memory, an enclave's memory or its info page, never two of
+ *		   those. The driver holds the allocations until the enclave is
+ *		   gone, so closing the descriptors does not free the runs the
+ *		   device was given.
+ *		   The device is given one address and one length per
+ *		   contiguous run of every region, and it takes four of
+ *		   them in total, so regions that a fragmented node splits
+ *		   into more runs than that are refused. On a system with
+ *		   that much fragmentation, you wouldn't get enough
+ *		   contiguous memory for the enclave itself either.
+ *		   A device that works out of the enclave's own memory
+ *		   regions says so with %NE_DEVICE_NO_SHM_REGIONS and names
+ *		   no region.
+ *		   The slot needs its info page first: the device reports how
+ *		   the enclave reaches each virtqueue by writing the info page,
+ *		   and the reply says where in it those entries are. The driver
+ *		   reads them from there and returns them in @vq_info, so a
+ *		   caller learns the interrupt vector and the doorbell offset
+ *		   of every queue from this call.
+ *		   The ioctl can be invoked on the enclave fd, before an
+ *		   enclave is started.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * * -1					- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * ENODEV				- The NE PCI device is not available.
+ * * EFAULT				- Argument read or write failure.
+ * * EBADF				- A region's @fd is not an open file
+ *					  descriptor.
+ * * EINVAL				- The argument is shorter than @vq_info, or
+ *					  @padding is not zero, or @num_vqs is
+ *					  more than %NE_MAX_VQS, or @config_size
+ *					  is more than @device_config holds, or
+ *					  the slot has no info page, or the
+ *					  argument names no region and does not
+ *					  set %NE_DEVICE_NO_SHM_REGIONS, or it
+ *					  sets that flag and names one anyway,
+ *					  or a region's @reserved is not zero,
+ *					  or its @fd is not a descriptor from
+ *					  %NE_ALLOC_MEMORY, or the allocation was
+ *					  made for another enclave, or it is
+ *					  %NE_MEMORY_PRIVATE, or the regions are
+ *					  made of more runs in total than the
+ *					  device takes.
+ * * EIO				- Current task mm is not the same as the one
+ *					  that created the enclave.
+ * * E2BIG				- The argument is longer than this kernel knows
+ *					  about and the excess is not all zero.
+ * * ENOMEM				- Memory allocation failure for internal
+ *					  bookkeeping variables.
+ * * EPROTO				- The device replied for a different number of
+ *					  virtqueues than it was asked for, or placed
+ *					  their entries outside the info page.
+ * * NE_ERR_NOT_IN_INIT_STATE		- The enclave is not in init state (init =
+ *					  before being started).
+ * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
+ * * NE_ERR_MEM_REGION_ALREADY_USED	- An allocation was already given to the
+ *					  enclave, or is its info page, or is the
+ *					  memory of one of its devices, or was
+ *					  named by two regions of this device.
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_ADD_DEVICE			_IOWR(0xAE, 0x26, struct ne_add_device_args)
+
 /**
  * NE_START_ENCLAVE - The command is used to trigger enclave start after the
  *		      enclave resources, such as memory and CPU, have been set.
-- 
2.47.1

