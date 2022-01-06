Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99377C433FE
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4300940424;
	Thu,  6 Jan 2022 02:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCSYz7dnVZ5U; Thu,  6 Jan 2022 02:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E83F940017;
	Thu,  6 Jan 2022 02:21:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6495C002F;
	Thu,  6 Jan 2022 02:21:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02BCAC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E277540424
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2MVEYLqG8xr for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:21:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC92F40017
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435717; x=1672971717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xKGR4J0OSP6uicbqMFdEjKsyZ291es72vzJYC31FqCM=;
 b=mjPDb+uSOJDSWHaPuZhzhsNWwnbECrJWSGHyDc7WEfweSBjPUfh1wGXc
 JH+UHNqQGVLXWxlhRXRVmFrtzlgsQgo642NtiDnBX5rzLusyONJRuaZlX
 89Q/UIiUUvYGPdCwlsWf4OAWBere7WHYex/TnfXDpJEmmd5j9fkV24gXD
 MP7/M8H5QinKzUvr8E9FbQcocqNJ0Xa8oREiNpwHw9jphBsj5e0RYbQgE
 2fQLC5D5iAFbRmOEktSzi3671I5wVoVyiyclQQ9/lI64Wb3PgCfcg0W7x
 lsLKolHwRHY1TIoq1XTPUoslm3LqdqHkGnMD+nWKE79Fkgw+UsMute2aw Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303325585"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="303325585"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794284"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:21:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 1/8] iommu: Add iommu_group_replace_domain()
Date: Thu,  6 Jan 2022 10:20:46 +0800
Message-Id: <20220106022053.2406748-2-baolu.lu@linux.intel.com>
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

Expose an interface to replace the domain of an iommu group for frameworks
like vfio which claims the ownership of the whole iommu group.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 10 ++++++++++
 drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 408a6d2b3034..66ebce3d1e11 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -677,6 +677,9 @@ void iommu_device_unuse_dma_api(struct device *dev);
 int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *old,
+			       struct iommu_domain *new);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1090,6 +1093,13 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int
+iommu_group_replace_domain(struct iommu_group *group, struct iommu_domain *old,
+			   struct iommu_domain *new)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 72a95dea688e..ab8ab95969f5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3431,3 +3431,40 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+/**
+ * iommu_group_replace_domain() - Replace group's domain
+ * @group: The group.
+ * @old: The previous attached domain. NULL for none.
+ * @new: The new domain about to be attached.
+ *
+ * This is to support backward compatibility for vfio which manages the dma
+ * ownership in iommu_group level.
+ */
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *old,
+			       struct iommu_domain *new)
+{
+	int ret = 0;
+
+	mutex_lock(&group->mutex);
+	if (!group->owner || group->domain != old) {
+		ret = -EPERM;
+		goto unlock_out;
+	}
+
+	if (old)
+		__iommu_detach_group(old, group);
+
+	if (new) {
+		ret = __iommu_attach_group(new, group);
+		if (ret && old)
+			__iommu_attach_group(old, group);
+	}
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_replace_domain);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
