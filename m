Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2ECC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 00:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3191241ED0;
	Fri, 18 Feb 2022 00:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Z2ntjPlR3EC; Fri, 18 Feb 2022 00:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C06B241EC6;
	Fri, 18 Feb 2022 00:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB45C0011;
	Fri, 18 Feb 2022 00:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 533CBC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41EC56F792
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGS7DO56DTOS for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 00:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EB456F772
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645145911; x=1676681911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z96GxEBC+Q+GUaDOqHkjPNoRKRZDT2uZ37npGzcnohE=;
 b=f7r2Hi7C/t+Cvl6aaRuZaGf5u0nFmOzE8yXZ0GuCmI5RKXxqpO3gVSqg
 0lYbePNW3PGJ04iM58J0myaiffdMwQ1pzy4kHghy18PloeTh1wi2Ef+DE
 2RzKkj7L6QSonUsyn5G9bCHtuDbXKm/qW2GEU/uBOO9vA+e6Yy+wvZIvW
 LDKSlbZt7WeysT7mnqg2QxahSX/Gp5NnXc0TVVJvpbumV3th8ZN3WO6bl
 XeD9OTqj8MrGzMmdIT6BBA3z/WRoqh9LOj7N1dQKgv7W8PvtjeURD1j2Y
 J/NmDCofDdu5jjzqcRJeoFvr0v232CJ8S5eDo4NvKZCJnzo1wkfG10YG9 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231001192"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="231001192"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 16:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="637491390"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 16:57:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v6 08/11] vfio: Remove use of vfio_group_viable()
Date: Fri, 18 Feb 2022 08:55:18 +0800
Message-Id: <20220218005521.172832-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218005521.172832-1-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

As DMA ownership is claimed for the iommu group when a VFIO group is
added to a VFIO container, the VFIO group viability is guaranteed as long
as group->container_users > 0. Remove those unnecessary group viability
checks which are only hit when group->container_users is not zero.

The only remaining reference is in GROUP_GET_STATUS, which could be called
at any time when group fd is valid. Here we just replace the
vfio_group_viable() by directly calling IOMMU core to get viability status.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index df9d4b60e5ae..73034446e03f 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1313,12 +1313,6 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 	return ret;
 }
 
-static bool vfio_group_viable(struct vfio_group *group)
-{
-	return (iommu_group_for_each_dev(group->iommu_group,
-					 group, vfio_dev_viable) == 0);
-}
-
 static int vfio_group_add_container_user(struct vfio_group *group)
 {
 	if (!atomic_inc_not_zero(&group->container_users))
@@ -1328,7 +1322,7 @@ static int vfio_group_add_container_user(struct vfio_group *group)
 		atomic_dec(&group->container_users);
 		return -EPERM;
 	}
-	if (!group->container->iommu_driver || !vfio_group_viable(group)) {
+	if (!group->container->iommu_driver) {
 		atomic_dec(&group->container_users);
 		return -EINVAL;
 	}
@@ -1346,7 +1340,7 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
 	int ret = 0;
 
 	if (0 == atomic_read(&group->container_users) ||
-	    !group->container->iommu_driver || !vfio_group_viable(group))
+	    !group->container->iommu_driver)
 		return -EINVAL;
 
 	if (group->type == VFIO_NO_IOMMU && !capable(CAP_SYS_RAWIO))
@@ -1438,11 +1432,11 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
 
 		status.flags = 0;
 
-		if (vfio_group_viable(group))
-			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
-
 		if (group->container)
-			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET;
+			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET |
+					VFIO_GROUP_FLAGS_VIABLE;
+		else if (!iommu_group_dma_owner_claimed(group->iommu_group))
+			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
 
 		if (copy_to_user((void __user *)arg, &status, minsz))
 			return -EFAULT;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
