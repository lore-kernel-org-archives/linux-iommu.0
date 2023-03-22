Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4851C13
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467779; x=1711003779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0RHdVtmElNj1Gz3aelx3dDSWLuFTYKQB4XyswkTwt0o=;
  b=PvvFIovksJ61RoIEXoaG6TUkvq6UYSfpn8WKX+vCpmAlUVWckcxSc6zS
   t6iDHmHBoxfLCLiXgnO1OSJOYREMaNjbq9NpImo1t38vEuWr7bUajlSi/
   CNGLmFQTvshP/8qUet4A1PEppIP4+T/Dp0cH2TADUf0NsUFeHpsDabIty
   PvPBydBL8AeN2FXkYyR2YgjdMh+7V8zqjrJ87F5oZ4QaTPxPSxv/l4Jz5
   6gYu1JJ3lxgblKsLwAbRq6/iRw5r9XoJAJM7nsMestfUrS5lNzdlLrJGy
   WjpHSN/zwZoZa13RAD26srhkQrXZWjg0q0vmjAVF7Qeo+aM9sEHVuSnI7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866728"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080374"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080374"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 1/6] iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path
Date: Wed, 22 Mar 2023 14:49:51 +0800
Message-Id: <20230322064956.263419-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322064956.263419-1-baolu.lu@linux.intel.com>
References: <20230322064956.263419-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iommu driver's release_device operation, the driver should detach
the device from any attached domain and release the resources allocated
in the probe_device and probe_finalize paths.

Replace arm_iommu_detach_device() with arm_iommu_release_mapping() in the
release path of the ipmmu-vmsa driver. The device_release callback is
called in device_del(), this device is not coming back. Zeroing out
pointers and testing for a condition which cannot be true by construction
is simply a waste of time and code.

The bonus is that it also removes a obstacle of arm_iommu_detach_device()
re-entering the iommu core during release_device. With this removed, the
iommu core code could be simplified a lot.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/linux-iommu/7b248ba1-3967-5cd8-82e9-0268c706d320@arm.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..bc135679523a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -30,7 +30,6 @@
 #define arm_iommu_create_mapping(...)	NULL
 #define arm_iommu_attach_device(...)	-ENODEV
 #define arm_iommu_release_mapping(...)	do {} while (0)
-#define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
 #define IPMMU_CTX_MAX		16U
@@ -820,7 +819,18 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	arm_iommu_detach_device(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	unsigned int i;
+
+	for (i = 0; i < fwspec->num_ids; ++i) {
+		unsigned int utlb = fwspec->ids[i];
+
+		ipmmu_imuctr_write(mmu, utlb, 0);
+		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
+	}
+
+	arm_iommu_release_mapping(mmu->mapping);
 }
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
-- 
2.34.1

