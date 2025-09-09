Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623233CE90
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422567; cv=none; b=uaMhCNTRgspAJzNtnp13nKqjREYdLZVSycCvLMVo83RPGQPj5xBils8jo05M00bA7fDqSAeQqGmrkO6GYWG4ITvTLVdEoVdnFdIz9M0FBG52bXbz50VOcQcof6De2r3tjsivjvjD7wlbPqVlYopQgn1quClPEnyFa4MZ+/ruXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422567; c=relaxed/simple;
	bh=KEiKKbuO8utEr+1Jde9IolozlT4BpIE8XDjbap1AcQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKtp0aGZ34lgggR68nKfAJ6Km4SxcP2fMGSWkCYdJ6kzdmNdDP6fGFtrjW1coZzRaBwKMMdwEWglWzfdFuxRfp9au8I0nOJlOpyOfqe4BqDIKbW1s10pNt3sILHUMzK1iQXWPWqovn4mU80z1l5LVc0vGgkt0uMIE//IayRv9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=phL+2f2K; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="phL+2f2K"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757422557; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+UgBkQMvBIjn6/mKuZZ5tg3YT4ZjYDx1z5lvq4RO+6k=;
	b=phL+2f2Kxsjt153wQxa7848LTev1+9GcCxsDs6OeZX2Lc2JtasKp4gY2W+xioFrr1vzCEOl2eY0O9bXUOVZo1jeSy/hBK2qXWEXkq5ikoMF023XQhpRi2ZC0AZTuVB1ecbfYzkCvd+QDNQABZNigARaWDjPlUeurOQ9nZDRuR3o=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wne8PCM_1757422552 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 20:55:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
Subject: [PATCH] iommu: Fix iommu selftest running test mock domain fail
Date: Tue,  9 Sep 2025 20:55:52 +0800
Message-ID: <20250909125552.125969-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When intel_iommu=on is enabled and the iommu selftests are executed,
we observed multiple test case failures. Our investigation revealed
that both the Intel iommu driver and the mock iommu driver registered
iommu_device instances with fwnode=NULL, and both were added to the
iommu_device_list. Later, when the mock iommu driver attempted to
create a device, iommu_init_device attempted to retrieve the iommu_ops
by searching the iommu_device_list using the provided fwnode
(which was NULL).
Since the iommu_device registered by the Intel iommu driver appeared
earlier in the list, it was matched first instead of the mock iommu
driver's iommu_device. This ultimately caused probe_device to fail.

Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
and set it to the device which mock iommu driver created.

Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
PASSED: 229 / 229 tests passed.

In addition, this issue is also can be found on amd platform, and
also tested on a amd machine.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Tested-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/iommu/iommu.c            | 12 ++++++++++++
 drivers/iommu/iommufd/selftest.c | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..cda5e1c039aa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 struct notifier_block *nb)
 {
 	bus_unregister_notifier(bus, nb);
+	fwnode_remove_software_node(iommu->fwnode);
 	iommu_device_unregister(iommu);
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
@@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	if (err)
 		return err;
 
+	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
+	if (IS_ERR(iommu->fwnode)) {
+		iommu->fwnode = NULL;
+		dev_err(iommu->dev, "add property failed:%d\n", err);
+		bus_unregister_notifier(bus, nb);
+		return err;
+	}
+
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
@@ -335,6 +344,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 		iommu_device_unregister_bus(iommu, bus, nb);
 		return err;
 	}
+	WRITE_ONCE(iommu->ready, true);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register_bus);
@@ -555,6 +565,7 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
 }
 
 DEFINE_MUTEX(iommu_probe_device_lock);
+EXPORT_SYMBOL_GPL(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
@@ -2914,6 +2925,7 @@ void iommu_fwspec_free(struct device *dev)
 		dev_iommu_fwspec_set(dev, NULL);
 	}
 }
+EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
 int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 61686603c769..076902f097ea 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1126,12 +1126,22 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		goto err_put;
 	}
 
+	mutex_lock(&iommu_probe_device_lock);
+	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
+	if (rc) {
+		mutex_unlock(&iommu_probe_device_lock);
+		dev_err(&mdev->dev, "init fwspec failed:%d\n", rc);
+		goto err_put;
+	}
+	mutex_unlock(&iommu_probe_device_lock);
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
 	return mdev;
 
 err_put:
+	iommu_fwspec_free(&mdev->dev);
 	put_device(&mdev->dev);
 	return ERR_PTR(rc);
 }
-- 
2.43.7

