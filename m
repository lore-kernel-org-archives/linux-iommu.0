Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233A63A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917120; x=1707453120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k19+8t5+6EA5QNZSZAcLeFZS3iJLVeK/ORk8AVxHZ2o=;
  b=TNHKZYbpD3VF5NKIkeRUJ1nqBoXX0mr3OgYJJfe4/8gUsP5GMDIAprGb
   EKjfhCOeFBooNHqmIogScq3w+ICt+Qb+gjcHrfsy6XTdwGMPGvQng+dUU
   3heBykLZhbX8QYQ9C8uum+QAu2mH0p3ca/j+miPVRPwKohU0Y70Tsy1Q+
   6bJfa9+bs2qenPZX+BijxW8IhQGWbSdne2zvWH82pfU8d3XTYmH1vjC7z
   4FrQy3et24oGCDBTgb7l2Xmoj0wOcs9/lIOUupLNTlY0S6woSA1EJ6yIl
   34Q/mlifuYQ4QD2utjpbfo8RCcSRoSa0H5sEkX8HZ6DAlEbvNcC91uAR6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298593"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298593"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447438"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447438"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:31:58 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: [PATCH 01/17] iommu: Add new iommu op to create domains owned by userspace
Date: Wed,  8 Feb 2023 20:31:37 -0800
Message-Id: <20230209043153.14964-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu_domain op to create domains owned by userspace,
e.g. through iommufd. These domains have a few different properties
compares to kernel owned domains:

 - They may be MANAGED domains, but created with special parameters.
   For instance aperture size changes/number of levels, different
   IOPTE formats, or other things necessary to make a vIOMMU work

 - We have to track all the memory allocations with GFP_KERNEL_ACCOUNT
   to make the cgroup sandbox stronger

 - Device-specialty domains, such as NESTED domains can be created by
   iommufd.

The new op clearly says the domain is being created by IOMMUFD, that
the domain is intended for userspace use, and it provides a way to pass
a driver specific uAPI structure to customize the created domain to
exactly what the vIOMMU userspace driver requires.

iommu drivers that cannot support VFIO/IOMMUFD should not support this
op. This includes any driver that cannot provide a fully functional
UNMANAGED domain.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the
kernel driver. If a need for common parameters, implemented similarly
by several drivers, arises then there is room in the design to grow a
generic parameter set as well.

This new op for now is only supposed to be used by iommufd, hence no
wrapper for it. iommufd would call the callback directly. As for domain
free, iommufd would use iommu_domain_free().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 97b398d19fd2..214e3eb9bc86 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -230,6 +230,7 @@ struct iommu_iotlb_gather {
  *           after use. Return the data buffer if success, or ERR_PTR on
  *	      failure.
  * @domain_alloc: allocate iommu domain
+ * @domain_alloc_user: allocate user iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -262,6 +263,9 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
+						  struct iommu_domain *parent,
+						  const void *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.34.1

