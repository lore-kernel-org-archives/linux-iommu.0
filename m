Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A663DE
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 05:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425145; x=1716961145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6fZzsnppnyR7kpcIKhto0g6Vd7ftpsuL2xR0ieUO5k=;
  b=eScc8JQss+SPMgqYXI4rj2AkY1kfKs+21Tz7RAOepslz26zL81APCGuY
   6utyFrNfpyrQOLDkt7A/AKJZIJ1Tdt07LReLIjA8kDsw7vOwlyZayQ/8K
   qBkXWYe9A79OcfwOYj2Jstx3IyX4Ilzb05+iRzyi3c4V9QNEFbDHTFjSQ
   QbcqlIZzPuM/uORaer/3VpCOp5RMAZCuyFBrXrKysQtRXTXpL1BhtSjvq
   TYdqGRx6EAPgtqrJEz/Z7UTMm8ITaIZrJGopleClAF/q3B3xRRiz4uNo8
   Rx1HK3ujqOeSDf6Pcd4BkFqFsGdial/PISXnfW/Sy6l1OVMLZSuNdGSeq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579820"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369801"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369801"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 11/17] iommufd: Deliver fault messages to user space
Date: Tue, 30 May 2023 13:37:18 +0800
Message-Id: <20230530053724.232765-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a read-only file interface that allows user space to obtain fault
messages by sequentially reading the file. User space can determine whether
all fault messages have been read by comparing the provided read buffer
with the actually returned data length. Once a fault is read by the user,
it will be moved from the pending list to the waiting-for-response list.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 drivers/iommu/iommufd/hw_pagetable.c    | 66 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 67e5aa0f996e..6da0ba9421d0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -242,6 +242,8 @@ struct hw_pgtable_fault {
 	struct list_head response;
 	struct eventfd_ctx *trigger;
 	bool user_pasid_table;
+	struct file *fault_file;
+	int fault_fd;
 };
 
 struct iommufd_fault {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ca3e4d92f2aa..09377a98069b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -4,6 +4,8 @@
  */
 #include <linux/iommu.h>
 #include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
@@ -310,6 +312,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		iommu_domain_set_iopf_handler(hwpt->domain,
 					      iommufd_hw_pagetable_iopf_handler,
 					      hwpt);
+
+		cmd->out_fault_fd = hwpt->fault->fault_fd;
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
@@ -421,6 +425,62 @@ iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
 	return IOMMU_PAGE_RESP_ASYNC;
 }
 
+static ssize_t hwpt_fault_fops_read(struct file *filep, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct hw_pgtable_fault *fault = filep->private_data;
+	size_t fault_size = sizeof(struct iommu_fault);
+	struct iommufd_fault *ifault;
+	size_t done = 0;
+
+	if (ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		ifault = list_first_entry(&fault->deliver, struct iommufd_fault, item);
+		if (copy_to_user(buf + done, &ifault->fault, fault_size))
+			break;
+		done += fault_size;
+		list_del_init(&ifault->item);
+		if (ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)
+			list_add_tail(&ifault->item, &fault->response);
+		else
+			kfree(ifault);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+}
+
+static const struct file_operations hwpt_fault_fops = {
+	.owner		= THIS_MODULE,
+	.read		= hwpt_fault_fops_read,
+};
+
+static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
+{
+	struct file *filep;
+	int fdno;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		return fdno;
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
+				   fault, O_RDONLY);
+	if (IS_ERR(filep)) {
+		put_unused_fd(fdno);
+		return PTR_ERR(filep);
+	}
+
+	fd_install(fdno, filep);
+	fault->fault_file = filep;
+	fault->fault_fd = fdno;
+
+	return 0;
+}
+
 static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 {
 	struct hw_pgtable_fault *fault;
@@ -440,8 +500,14 @@ static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 		goto out_free;
 	}
 
+	rc = hw_pagetable_get_fault_fd(fault);
+	if (rc)
+		goto out_put_eventfd;
+
 	return fault;
 
+out_put_eventfd:
+	eventfd_ctx_put(fault->trigger);
 out_free:
 	kfree(fault);
 	return ERR_PTR(rc);
-- 
2.34.1

