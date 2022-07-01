Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BB10E9
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 07:05:56 +0000 (UTC)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id VEE00141;
        Fri, 01 Jul 2022 15:03:41 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 1 Jul 2022 15:03:44 +0800
From: Bo Liu <liubo03@inspur.com>
To: <jean-philippe@linaro.org>, <joro@8bytes.org>, <will@kernel.org>
CC: <virtualization@lists.linux-foundation.org>,
	<iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] iommu/virtio: Handle return of iommu_device_register
Date: Fri, 1 Jul 2022 01:43:04 -0400
Message-ID: <20220701054304.6434-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid: 20227011503418d5d708f5b31f05e32cd5086aa14c86f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Message-ID: <20220701054304.d_oX-T9WJA4rjVkWfuXWx5k-11YiM0tSUfrAlgpzmzM@z>

iommu_device_register returns an error code and, although it currently
never fails, we should check its return value anyway.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iommu/virtio-iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..12e7d8364560 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1144,7 +1144,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_remove_sysfs;
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &viommu_ops) {
@@ -1175,8 +1177,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	return 0;
 
 err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.27.0

