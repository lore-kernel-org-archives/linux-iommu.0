Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777D25B676;
	Thu, 29 May 2025 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497442; cv=none; b=RB47NPsHqzVIaa3lllaHw0R0fvwsd7kLAWMDtndmwDpIZG0K67JM8hwcKQD9vX+rqWdMcFiEPwfOEzWMPSnGAkTNe/vjZXQ9EEGODLOwaWf5f0TNuMan7/G4j2j+2hyLr+vLJOVBTi4/vspz/TeCufbX8On0aoKGkRuFoOfHmeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497442; c=relaxed/simple;
	bh=46/snHaJ8vYBoGpNl3amWuUUc5KyrzV3w87FzR6ysPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diGlztTmxUYW2UY0yNrtuyDcP9gLckcyBS0/Fbd+Leuvsr1WSS8qEH8F/SD/ok4IiT4DIOgyuyvU1Afvjx2ggbpf/7wfUGnJB6tGzb3fajqJfoy6kNRqu19Ys0Z33mUwIYf8gnFOPPuzsqg8Djc3A9ud8xPbcCTglPR0tgjtj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU+sTgXW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU+sTgXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748497441; x=1780033441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46/snHaJ8vYBoGpNl3amWuUUc5KyrzV3w87FzR6ysPU=;
  b=nU+sTgXW8WmcRZ0OnT3Pcaqc/l0jZV3VB1C7tadGrM4vQ97NIKXdgl1n
   HuYeX+WrSq9e8wAQ4V9utY+rjLkwvPw28gT8hgY2JWqR/DW3oqJw/fD6U
   7RlZzLVFjqOVPiub/cH6ZGgQUsuuhCu4FKwORTlyJtTFV/fmquPtVyrO6
   jpHVegyY1ntvNxoDBbL9IOwjtvh8RN36IN4mNHv9jiGWZTsHm2vcgGZ25
   uEXGyNBWgfdpAOUC6vcaGruweH1NuACY6uO3t5vI3QW+kn3oklyRRdnSw
   dxqLSL6TTXvdndv+wBz+RGk4ZjYR5785WuD0xEO7TvF/stnnDp7Mw41Ix
   g==;
X-CSE-ConnectionGUID: 3cicO1wxRIKGxJCaCXbKlw==
X-CSE-MsgGUID: HmNrcnldQM6AG6b42Lgi6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67963317"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="67963317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:44:01 -0700
X-CSE-ConnectionGUID: J+8tvmNbRximREaBwYmdow==
X-CSE-MsgGUID: PinTgIsGSeusrosn1EdYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="144443588"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2025 22:43:54 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kvm@vger.kernel.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	dan.j.williams@intel.com,
	aik@amd.com,
	linux-coco@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	vivek.kasireddy@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	yan.y.zhao@intel.com,
	daniel.vetter@ffwll.ch,
	leon@kernel.org,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	tao1.su@intel.com,
	linux-pci@vger.kernel.org,
	zhiw@nvidia.com,
	simona.vetter@ffwll.ch,
	shameerali.kolothum.thodi@huawei.com,
	aneesh.kumar@kernel.org,
	iommu@lists.linux.dev,
	kevin.tian@intel.com
Subject: [RFC PATCH 22/30] fixup! PCI/TSM: Change the guest request type definition
Date: Thu, 29 May 2025 13:35:05 +0800
Message-Id: <20250529053513.1592088-23-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the guest_request_type to IOMMUFD uAPI header file so that
userspace could use it for IOMMUFD uAPI -
IOMMU_VDEVICE_TSM_GUEST_REQUEST.

Add __user marker to all blob pointers to indicate the TSM drivers'
responsibility to read out/fill in user data.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 include/linux/pci-tsm.h      | 12 ++++--------
 include/uapi/linux/iommufd.h |  8 ++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 1920ca591a42..737767f8a9c5 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -107,10 +107,6 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
-enum pci_tsm_guest_req_type {
-	PCI_TSM_GUEST_REQ_TDXC,
-};
-
 /**
  * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
  * @type: identify the format of the following blobs
@@ -123,12 +119,12 @@ enum pci_tsm_guest_req_type {
  *	      for output, the size of actual response data filled by host
  */
 struct pci_tsm_guest_req_info {
-	enum pci_tsm_guest_req_type type;
-	void *type_info;
+	u32 type;
+	void __user *type_info;
 	size_t type_info_len;
-	void *req;
+	void __user *req;
 	size_t req_len;
-	void *resp;
+	void __user *resp;
 	size_t resp_len;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b8170fe3d700..7196bc295669 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1143,6 +1143,14 @@ struct iommu_veventq_alloc {
 };
 #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 
+/**
+ * enum pci_tsm_guest_req_type - Specify the format of guest request blobs
+ * @PCI_TSM_GUEST_REQ_TDXC: Intel TDX Connect specific type
+ */
+enum pci_tsm_guest_req_type {
+	PCI_TSM_GUEST_REQ_TDXC,
+};
+
 /**
  * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
  * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
-- 
2.25.1

