Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F4565107;
	Thu, 17 Sep 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653772; cv=none; b=XIOoULzbpC5sVN9OE4CgmSt6g3InxpSSr4GJI1JlhMSUbAt1O3cLgeXKYAeEwpRASASqlr6U9psau4juQLDyLSpVUFbebtpL4O1ysOmYy21Fd8MMY96/L+ppBXPMSOnt8LmQIiehEoSzV5l+vW5Lymv+/MAFYag3hdI7bz4L3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653772; c=relaxed/simple;
	bh=U3ruNC+aTwd2NW/FLlc8CFgc0Kc8+hGMcpCLR0Ta6n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMTuZJKRclCM1A7Lnx8W+VP7T+DvV6h+argmMaiP1fvuShVmkwfm4N9PyphFfIPhsDXfsBIUepSEDtsa2RlhO8Y85/FDP2W7sCUfKALI60FnzrrzKm+W4uIzqUy+1gIE2bVWAiXyI53gvQneQsS1UTt2OnqHWcEvQWxtlVp0ndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+VunlDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+VunlDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFAC1F000FF;
	Thu, 17 Sep 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653770;
	bh=rLwCfcv0m3AZLpWzVTe2rRR7huQPS33UjInoD8KSQpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+VunlDTMYfLzIvK7X0cB2DuzHaBCrMFHhGAIEFU95gPOPbzfTM16Eokw8G5Vvgsu
	 p31m8Q3vhXusdzvS5uObMdUx+02+fmNYKEGsFOhOCEj/Iagx9+HMLkxnc6sldPTwsK
	 GzWMhIaA52Ib5SCFV8ULBSHuCRYeOzSMja2gQ/YzouOnUGnzlPYmlFf+KY9ofjmXC9
	 z8odUohG8kw/Pyj5Z3nGhl6b137V2aoIaX5ka6ty6st5756/wDq/Lo4V9hAmKzu1cf
	 p6qYpfZqJ/g54CUfIjhRedNhI4y74A9jRWNi17ZIfaQozoTps1GysMM9Dk8R24du1I
	 HmTCq7SbdGy/Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 02/11] vfio: cdev: Reject duplicate bind before updating KVM file
Date: Thu, 17 Sep 2026 19:31:50 +0530
Message-ID: <20260917140159.1163281-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdev path only supports one bound/open device fd, but
VFIO_DEVICE_BIND_IOMMUFD only checked the per-file access_granted flag
before capturing the KVM file reference. A second fd for the same device
could therefore replace device->kvm_file, fail later in vfio_df_open()
because open_count is already nonzero, and then clear the active KVM
association during error cleanup.

Reject the bind while holding dev_set->lock if the device is already
open, matching the existing cdev single-open rule before touching the
device-wide KVM state.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/vfio/device_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index ca75ab8eb7bd..67e48f7ebfc3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -115,8 +115,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		return ret;
 
 	mutex_lock(&device->dev_set->lock);
-	/* one device cannot be bound twice */
-	if (df->access_granted) {
+	/* The cdev path only supports one bound/open device fd. */
+	if (df->access_granted || device->open_count) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.43.0

