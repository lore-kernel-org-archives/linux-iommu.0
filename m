Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47C15E8E
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7I89/+d"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2257430f8f.2
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698057568; x=1698662368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iakAHPOxKqOQUih7Sm03E4bR3Ewi1OC5ktvGhIrAhSs=;
        b=H7I89/+dhXDoAVTanfa58E3eriiwLi8w8Xh9I8WP4gCmbjzlDfW1qcK75qclk4I0jL
         U+GKgX4VkxzwR6o9LDPohFjN6S67DR6OApTegVx7HGepJpv7eQ7edUmP6A3QY2c+CZ+q
         AxSld0Vaq0X1yVz1qUgTxAXSouiBM4CvvwIPFmjvrmZU8gO06ddLMmnQ7W9dK7TS/rpw
         33XaOEXrYgKbOw00U8fro5IXaWRx/BWPVsUZ1FXv9w6fTwaUJekIgOqw5Ce+YwZj/mck
         5DXds/JuiAhKKgwAuhYoU311R8u4/XS4cm8vOYqnEsNXx0hQNhLbqrRU2MKhy3wGUc8m
         TWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698057568; x=1698662368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iakAHPOxKqOQUih7Sm03E4bR3Ewi1OC5ktvGhIrAhSs=;
        b=Nlkl18xYKNwvVGgIdCy5JbcBkPf2H99DzCmB6GXzPSVU/BCQYsac9KqdatcvS2P30G
         Yu0hNFqDNCrxfRw/ot5sLQigM/1Akvcaf2edr+YnKaFUdt2mZwKlXgEu3Bydauhfvicf
         bapuheaTlupVUPqPk/g0/lCNJoPBROf/oh+R2oQ1l7Q9yoSrouTOoyMmZMOqMFEwX5nW
         kwKi9VxsrTw0MsBH3dVSHM6D2iKNpjznUfCOfUBCvL91d1nWkDFz1DpXGTLA/ZV/5XzR
         A2kSGolPE2xLsXSt/Kk3DO6ckT0otyBVJG7TPaQosSx/7i8PbuQsTayBRp4urBcDlX4n
         gfew==
X-Gm-Message-State: AOJu0YzZbe9Z+VU1njRsKj7ncl4rwaQykJIf+pFgsrDfnwPBvS3iLKs/
	5EmV+ml+kP73KFHRaA7oGv8=
X-Google-Smtp-Source: AGHT+IHRWM3CpLE2aqOB2UbRawGgAMD79RG8VeNjeyax+v5VAOCCiiqUMw54GbjoE5jOotpwNggSyQ==
X-Received: by 2002:a5d:4527:0:b0:32d:a042:3b49 with SMTP id j7-20020a5d4527000000b0032da0423b49mr6332488wra.56.1698057567711;
        Mon, 23 Oct 2023 03:39:27 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id w5-20020adfee45000000b00317a04131c5sm7506265wro.57.2023.10.23.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:39:27 -0700 (PDT)
From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] include: uapi: linux: iommufd.h: fixed kernel-doc warnings
Date: Mon, 23 Oct 2023 15:38:52 +0500
Message-Id: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple kernel-docs warnings

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 include/uapi/linux/iommufd.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 50f98f01fe10..2211f1b53d6e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -419,7 +419,7 @@ enum iommu_hw_info_type {
 };
 
 /**
- * enum iommufd_hw_info_capabilities
+ * enum iommufd_hw_capabilities
  * @IOMMU_HW_CAP_DIRTY_TRACKING: IOMMU hardware support for dirty tracking
  *                               If available, it means the following APIs
  *                               are supported:
@@ -486,6 +486,7 @@ enum iommufd_hwpt_set_dirty_tracking_flags {
  * @size: sizeof(struct iommu_hwpt_set_dirty_tracking)
  * @flags: Combination of enum iommufd_hwpt_set_dirty_tracking_flags
  * @hwpt_id: HW pagetable ID that represents the IOMMU domain
+ * @__reserved: Must be 0
  *
  * Toggle dirty tracking on an HW pagetable.
  */
@@ -499,12 +500,12 @@ struct iommu_hwpt_set_dirty_tracking {
 					  IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING)
 
 /**
- * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
- * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
- *                                   dirty bits metadata. This flag can be
- *                                   passed in the expectation where the next
- *                                   operation is an unmap of the same IOVA
- *                                   range.
+ * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bits
+ * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
+ *                                        dirty bits metadata. This flag can be
+ *                                        passed in the expectation where the next
+ *                                        operation is an unmap of the same IOVA
+ *                                        range.
  *
  */
 enum iommufd_hwpt_get_dirty_bitmap_flags {
@@ -521,6 +522,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * @page_size: page size granularity of each bit in the bitmap
  * @data: bitmap where to set the dirty bits. The bitmap bits each
  *        represent a page_size which you deviate from an arbitrary iova.
+ * @__reserved: Must be 0
  *
  * Checking a given IOVA is dirty:
  *
-- 
2.27.0

