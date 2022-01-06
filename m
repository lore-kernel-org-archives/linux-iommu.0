Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B28CC433EF
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B14060D7F;
	Thu,  6 Jan 2022 02:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhyTnxbU_-2o; Thu,  6 Jan 2022 02:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3C5360B33;
	Thu,  6 Jan 2022 02:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC53C002F;
	Thu,  6 Jan 2022 02:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E28EC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CEFD405CE
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayIWfthBzafo for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:22:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BFDE40582
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435723; x=1672971723;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6YLQxZeVjKNGLWHBhbTA2BZXJ8CXUGVnJDAzUyu/JQ8=;
 b=dOXqKwqh645TYN6QVRP1EvlzKn3p/ZxwzbGR1je8o52TWuj9c6JGh4Bp
 LOJSaDkAsUfcmqJ/LvYwHqKKDmOzsvOeEe6b41tHBIgQpe1zaf7bm4ZbC
 gVWIyt+cm/379z5QpOvJtDBnx9wZI00MRvo5F5N40gXAwL0diuhIfHtPH
 u/CULbfEknDes6fH25QxGT3kr76zkRMTtyQ7Tch8AAVKVywsxI52wl1Wq
 yHwg5JAKMiL+I5mPSWuNBPywD/+lA0ocEUPNQ9S2P5Sds8LtIszk66ts9
 qkmfO1OWqrckuv7Er00IdoEr8aN5MFMN8swYX2Q52SCESbIjG+Yr8AEpx A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222570922"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="222570922"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794313"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:21:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 2/8] vfio/type1: Use iommu_group_replace_domain()
Date: Thu,  6 Jan 2022 10:20:47 +0800
Message-Id: <20220106022053.2406748-3-baolu.lu@linux.intel.com>
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

After an IOMMU group is placed in a vfio container, the domain attachment
may be deferred. During this process, other kernel modules can attach
another domain simply in the following way:

	group = iommu_group_get(dev);
	iommu_attach_group(domain, group);

Replace the iommu_attach/detach_group() with iommu_group_replace_domain()
and prohibit use of iommu_attach/detach_group() in other kernel drivers
can solve this problem.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f17490ab238f..25276a5db737 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2213,7 +2213,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, group->iommu_group);
+	ret = iommu_group_replace_domain(group->iommu_group, NULL,
+					 domain->domain);
 	if (ret)
 		goto out_domain;
 
@@ -2280,19 +2281,14 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			iommu_detach_group(domain->domain, group->iommu_group);
-			if (!iommu_attach_group(d->domain,
-						group->iommu_group)) {
+			if (!iommu_group_replace_domain(group->iommu_group,
+							domain->domain,
+							d->domain)) {
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
 				goto done;
 			}
-
-			ret = iommu_attach_group(domain->domain,
-						 group->iommu_group);
-			if (ret)
-				goto out_domain;
 		}
 	}
 
@@ -2327,7 +2323,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	iommu_detach_group(domain->domain, group->iommu_group);
+	iommu_group_replace_domain(group->iommu_group, domain->domain, NULL);
 out_domain:
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
@@ -2488,7 +2484,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		iommu_detach_group(domain->domain, group->iommu_group);
+		iommu_group_replace_domain(group->iommu_group,
+					   domain->domain, NULL);
 		update_dirty_scope = !group->pinned_page_dirty_scope;
 		list_del(&group->next);
 		kfree(group);
@@ -2577,7 +2574,8 @@ static void vfio_release_domain(struct vfio_domain *domain)
 
 	list_for_each_entry_safe(group, group_tmp,
 				 &domain->group_list, next) {
-		iommu_detach_group(domain->domain, group->iommu_group);
+		iommu_group_replace_domain(group->iommu_group,
+					   domain->domain, NULL);
 		list_del(&group->next);
 		kfree(group);
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
