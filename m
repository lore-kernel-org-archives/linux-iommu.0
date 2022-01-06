Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB16C433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6023E60D7F;
	Thu,  6 Jan 2022 02:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K7OJFdCTlQil; Thu,  6 Jan 2022 02:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A26C60B33;
	Thu,  6 Jan 2022 02:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17D58C002F;
	Thu,  6 Jan 2022 02:22:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFC8C001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DADA60D72
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LXN3MWtllnrO for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BCAE60B33
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435731; x=1672971731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=clG1gjGvOL9BSMyPbqgYNxozZZwO9e7BVS3UogrjHAs=;
 b=FBKWHB0KKkQJCw3cZA7UDlWDcYzqkCr1jcismEhu/vTOCML7p703PISu
 yZ32l5e5gE4josQ2W6GvuQKClxA1mWE2jhedUXo2J8AcfExfl7PTjr/zl
 2WBzAGy3YcDcFywZT/u3F4XeJSsCM/AXT3DGkzfQ4lAomfqsMcH/cOEfT
 uDG7CFkjMb0QPl6ybHjegTq7bt4v7Hr++8Q5MQnH0eY6BiB67GVKyOGOx
 UTJhpVgkqLw+txPK0OR1ef7zHvLepeM3wBLf3Nhp8kZyoHypRXK8j2UZH
 0SlFCc0HWLsVTxJCpZpwP/QS909lvwYjRHczjYyCwYt2UPitN6KEu1YZA Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229898940"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="229898940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794333"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:22:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 3/8] iommu: Extend iommu_at[de]tach_device() for
 multi-device groups
Date: Thu,  6 Jan 2022 10:20:48 +0800
Message-Id: <20220106022053.2406748-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

The iommu_attach/detach_device() interfaces were exposed for the device
drivers to attach/detach their own domains. The commit <426a273834eae>
("iommu: Limit iommu_attach/detach_device to device with their own group")
restricted them to singleton groups to avoid different device in a group
attaching different domain.

As we've introduced device DMA ownership into the iommu core. We can now
extend these interfaces for muliple-device groups, and "all devices are in
the same address space" is still guaranteed.

For multiple devices belonging to a same group, iommu_device_use_dma_api()
and iommu_attach_device() are exclusive. Therefore, when drivers decide to
use iommu_attach_domain(), they cannot call iommu_device_use_dma_api() at
the same time.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 79 +++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab8ab95969f5..2c9efd85e447 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -47,6 +47,7 @@ struct iommu_group {
 	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
+	unsigned int attach_cnt;
 	void *owner;
 };
 
@@ -1921,27 +1922,59 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * iommu_attach_device() - attach external or UNMANAGED domain to device
+ * @domain: the domain about to attach
+ * @dev: the device about to be attached
+ *
+ * For devices belonging to the same group, iommu_device_use_dma_api() and
+ * iommu_attach_device() are exclusive. Therefore, when drivers decide to
+ * use iommu_attach_domain(), they cannot call iommu_device_use_dma_api()
+ * at the same time.
+ */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
-	int ret;
+	int ret = 0;
+
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
 
 	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
-	/*
-	 * Lock the group to make sure the device-count doesn't
-	 * change while we are attaching
-	 */
 	mutex_lock(&group->mutex);
-	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
-		goto out_unlock;
+	if (group->owner_cnt) {
+		/*
+		 * Group has been used for kernel-api dma or claimed explicitly
+		 * for exclusive occupation. For backward compatibility, device
+		 * in a singleton group is allowed to ignore setting the
+		 * drv.no_kernel_api_dma field.
+		 */
+		if ((group->domain == group->default_domain &&
+		     iommu_group_device_count(group) != 1) ||
+		    group->owner) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+	}
 
-	ret = __iommu_attach_group(domain, group);
+	if (!group->attach_cnt) {
+		ret = __iommu_attach_group(domain, group);
+		if (ret)
+			goto unlock_out;
+	} else {
+		if (group->domain != domain) {
+			ret = -EPERM;
+			goto unlock_out;
+		}
+	}
 
-out_unlock:
+	group->owner_cnt++;
+	group->attach_cnt++;
+
+unlock_out:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
@@ -2182,23 +2215,35 @@ static void __iommu_detach_device(struct iommu_domain *domain,
 	trace_detach_device_from_domain(dev);
 }
 
+/**
+ * iommu_detach_device() - detach external or UNMANAGED domain from device
+ * @domain: the domain about to detach
+ * @dev: the device about to be detached
+ *
+ * Paired with iommu_attach_device(), it detaches the domain from the device.
+ */
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
 
+	if (WARN_ON(domain->type != IOMMU_DOMAIN_UNMANAGED))
+		return;
+
 	group = iommu_group_get(dev);
-	if (!group)
+	if (WARN_ON(!group))
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
-		WARN_ON(1);
-		goto out_unlock;
-	}
+	if (WARN_ON(!group->attach_cnt || !group->owner_cnt ||
+		    group->domain != domain))
+		goto unlock_out;
 
-	__iommu_detach_group(domain, group);
+	group->attach_cnt--;
+	group->owner_cnt--;
+	if (!group->attach_cnt)
+		__iommu_detach_group(domain, group);
 
-out_unlock:
+unlock_out:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
