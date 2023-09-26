Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE0134C6
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720914; x=1727256914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZj72hwk6aGVHqUfVsQNiXvoc1GB8ZJ+RY64a2dEVnk=;
  b=mB9OJd9ZFfpX5ScPzvFKggrm6dPkiT3M3nx+5GvDwv5ch6HJlFIJP/kq
   YINNoXknVRH8Q0HxP14vWjN6qxhpco0vQHruBm/zMbRI1KoH2Ogc19tbK
   FZGG2kYtWbSsfsJ8Y5GnBAyN87oAdek3OjAaYs9hQgZYm+3B3em89yhLh
   zdfMmn+YWIhcpiD4TMISNGf202Qx46idU9xoaM+fXIfbtG9r+aaPpIPW8
   58ec9l8tEWgCGcIMuXOqaQSyTdd1+fSVtwHPDQJp/HTz+5VfN8Kgx35/l
   1GRLs+3M5FNITUqGKmxQxQPV+nKGpkU021wz6iNk/Q+qXEUQ3NYUf2WuG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412442912"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412442912"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725373049"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725373049"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 02:31:26 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	cohuck@redhat.com,
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Date: Tue, 26 Sep 2023 02:31:21 -0700
Message-Id: <20230926093121.18676-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926093121.18676-1-yi.l.liu@intel.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This exposes PCIe PASID capability to userspace and where to emulate this
capability if wants to further expose it to VM.

And this only exposes PASID capability for devices which has PCIe PASID
extended struture in its configuration space. While for VFs, userspace
is still unable to see this capability as SR-IOV spec forbides VF to
implement PASID capability extended structure. It is a TODO in future.
Related discussion can be found in below links:

https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/
https://lore.kernel.org/kvm/BL1PR11MB5271A60035EF591A5BE8AC878C01A@BL1PR11MB5271.namprd11.prod.outlook.com/

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 7e2e62ab0869..dfae5ad5ebc0 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
 	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
 	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
 	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
-	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
+	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
 	[PCI_EXT_CAP_ID_DVSEC]	=	0xFF,
 };
 
-- 
2.34.1

