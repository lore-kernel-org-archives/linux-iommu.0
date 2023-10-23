Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4F2579
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZRMtFL1"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3af609c5736so1732794b6e.3
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051358; x=1698656158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+X2xkuC2sNDVYH+eBpxyEkTF5MdtA/DFvlrj3oX7LY4=;
        b=DZRMtFL1wAmkw/P7FGTbiLiKITeAS+VYA+dVlYnltm6AaE9fVOlJtu213C2sj219qF
         GPZp660+mVg4dxjA91UOi+9Ms7ee4rQpKeZ9qEk+o3COYtrHfATTjhs/5UclnPc5HIam
         cSt6BSTFhh27YmzeOOnybBYL74hDIfW73QFqkpv+Wlu70AJTHUoAWK+iyyueaInmRbE/
         aHFXXk2XEuqGhuM190GU5fcN5LzOM3P/wBRRXwldd8WPVfMdP9UjxeMVnJFyZhNWKnvJ
         omXvW5cDhlzrTcmeGvX+Fg3fS8vrNjDbY+bhi2M00QpdXbvIVE8zH02Lgzgzskej9sJv
         XXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051358; x=1698656158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X2xkuC2sNDVYH+eBpxyEkTF5MdtA/DFvlrj3oX7LY4=;
        b=vMgVhL7sfPeCYDNh88zAwiPf4mF/Uz2xyVvuMn113DKHe2SqpYp90KYRj7Nex7oKUb
         /s7i3f8qSGODIlT+zr47XPXpjTT4vthrtWoC1IwqpJLR1mxAGCjI9SnnzG0+7F2Qg96m
         sEaw2fMa966lAfrg1sXtct6JpSR0TB35R07DAWvsI0vekkyqW8JruusGYny7Zpqn/Ca4
         x5x2jbttpi85D1P+/7K3gzkvY/rE9m4r9WPXvFqgxve8e6DtX8sOWPxQ9rILNJVufDy0
         UJOf+2WcTLax2Rr75kK9jTsZQZ7FfDsxsgm0FnK+yQUUkzhbg+Ah72firZ9ApjldF1MF
         VrZw==
X-Gm-Message-State: AOJu0YxOgwVAYvzHNEKjf5x+kJIhmswCVHMop2v+yFsrKu4KyI9vPBvZ
	ocoH1uhSvpPUXRgIfjTo3dI=
X-Google-Smtp-Source: AGHT+IGK5M3I1XBkXULHYZYJQIHmqj5zw0tR2Y5mLKSDTUXVgsjSEuijh8CEl4ZF0RXPYmXUoJoCcQ==
X-Received: by 2002:a54:4104:0:b0:3ae:e79d:79a0 with SMTP id l4-20020a544104000000b003aee79d79a0mr6968044oic.30.1698051358304;
        Mon, 23 Oct 2023 01:55:58 -0700 (PDT)
Received: from brag-vm.. ([59.182.192.60])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b006be2f4105d0sm5771083pfw.175.2023.10.23.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:55:57 -0700 (PDT)
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: fixing build warnings after merging the iommufd tree
Date: Mon, 23 Oct 2023 14:25:51 +0530
Message-Id: <20231023085552.5139-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After merging the iommufd tree, today's linux-next build (htmldocs)
produced these warnings:

include/uapi/linux/iommufd.h:433: warning: expecting prototype for enum iommufd_hw_info_capabilities. Prototype was for enum iommufd_hw_capabilities instead
include/uapi/linux/iommufd.h:497: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_set_dirty_tracking'
include/uapi/linux/iommufd.h:512: warning: expecting prototype for enum iommufd_get_dirty_bitmap_flags. Prototype was for enum iommufd_hwpt_get_dirty_bitmap_flags instead
include/uapi/linux/iommufd.h:542: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_get_dirty_bitmap'

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 include/uapi/linux/iommufd.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 50f98f01fe10..5585df5b393e 100644
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
@@ -499,8 +500,8 @@ struct iommu_hwpt_set_dirty_tracking {
 					  IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING)
 
 /**
- * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
- * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
+ * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bits
+ * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
  *                                   dirty bits metadata. This flag can be
  *                                   passed in the expectation where the next
  *                                   operation is an unmap of the same IOVA
@@ -517,6 +518,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * @hwpt_id: HW pagetable ID that represents the IOMMU domain
  * @flags: Combination of enum iommufd_hwpt_get_dirty_bitmap_flags
  * @iova: base IOVA of the bitmap first bit
+ * @__reserved: Must be 0
  * @length: IOVA range size
  * @page_size: page size granularity of each bit in the bitmap
  * @data: bitmap where to set the dirty bits. The bitmap bits each
-- 
2.34.1

