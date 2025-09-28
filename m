Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DD2652B4
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086480; cv=none; b=JLNmNQP1qShhFpNWDX9VSZ1bbxSghbkaE6FZEqhq/VkK5fQZXZJJ9N38uegXgxlzK97itKq4VmhZ34i4xzA6dEKsaPlemMh7Tds0bkLJWlzl8EMl7tP51TDPOTV6mhaeC/2ccsv5cn4D18xQBNkvxaY2ta6oe+AGLBhQoOE2g5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086480; c=relaxed/simple;
	bh=dUFxCLs7p9f1eI8l4b/ZFNt/1ECQtCPnVCtAG5CC0cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ELnJMUS47mItWaiRZZCfRLiGYwxm95ed+gsibEPwKjioNX4SZ8g58tXRSy36304o6vs49sKmbQL3axH834Fw3TvmOlh1ADnj07UtEht8uZccNygQga68gRH9e1+gjSNuJ8Sxshu5UH90k+v7lfSWnsfgu9PkG67ePrSV9V00o/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUB/8c4v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUB/8c4v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-286a252bfbfso21150475ad.3
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086478; x=1759691278; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIOurj+2nVVUDk10T5jpgRKE6q2CDkbGgR0n/0hZqjQ=;
        b=pUB/8c4vK/TF4KF+YA4wyON3g0FSwK97VwfYzksnADaIb/mCseTP1iwiQdvUro1r5z
         +2L3MzsbE9CU4EX9AaaT00rOAuTOrsSe5yo6Bai2IlDpzC7JIG33QfQFioW0T6tZDr+r
         gnX1rOf55+gItEFYt+Mjd6msOHB/O6nmGim7zg93D5UXxkpGWReG2Ld4EbMoUplF+LoH
         u70TVMC7OO+/HdpBCDngBHNlw8DIyZK0kL1P9AYZFOS8+X/YtKit1pXEjOIajVdFAeCC
         Mupe2uiXrg5IiT6gLE+KdkrsfTZ3U4e6Rc05dW5XmTwmfUNyN3sTY/pRC3i/CjfPagsT
         MTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086478; x=1759691278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIOurj+2nVVUDk10T5jpgRKE6q2CDkbGgR0n/0hZqjQ=;
        b=YdpwZ/rrL6N0UCy7CsHgWo27WUk1VuYt2UoFDFpEWZhMq/6S5K4WgtjhRZxDHdaFmS
         1wrUml5Hheo+IdvUAMDj4HK3mGUZmKtWixUtLhMEbpk9cXFqSsDqCoYuk48SSUJD/XeE
         hw1gjCYnrSiNzgMZGmm1xGnNDrDGp2RQTBpAgjTDkaph34DAQuVx1fkQh3fzjogLHNGC
         yaEEGMjhROSw66kTI3caMPX9T8Aqph6rjxkXJJNCidacfvSEgcttwP41xLheql3FsNHK
         USriIBRY0KllWMA5gxaN0r6+0aTZ6bPTsS2TWfF7fEjNPLj9ToIyxkY2Q45DeH6Kmz34
         rSkw==
X-Forwarded-Encrypted: i=1; AJvYcCVm53Ex+A7dtGQfCK64KxchIVwxtMDt6Lww9INWSKmJ60zPctYBv5QvE1CXN74Ahd/sTnohww==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf1kIff2C2YdeVpZvKJPod2tCppKbrMrYaKrlbKhPDtJqS7f3F
	PNWX2wSw2zzRX1MoxZPBKtm8P21f+lrhTEOi7QngwhsctUgQvDQbAYLi6r18Sazf/G8uWPHIIz4
	JqmKYIDYNoPkPLw==
X-Google-Smtp-Source: AGHT+IElf39/DKJfyLea14v/9U1aXLe5jJdoyOqxRTz9WC5PCBwphXq5PQNOB03FmfvrzghM771xyTnwDScHMw==
X-Received: from pjbpg12.prod.google.com ([2002:a17:90b:1e0c:b0:32b:50cb:b92f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:27cc:b0:269:63ea:6d4e with SMTP id d9443c01a7336-27ed4a3de18mr105082665ad.37.1759086477777;
 Sun, 28 Sep 2025 12:07:57 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:19 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-12-skhawaja@google.com>
Subject: [RFC PATCH 11/15] iommufd: Add basic skeleton based on liveupdate_file_handle
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

No functionality is implemented in this commit. Just registering and
unregistering of the struct liveupdate_file_handle for iommufd.

All operations are stubs returning either error or no-op.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++++
 drivers/iommu/iommufd/liveupdate.c      | 68 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 14 ++++-
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..f37830ff7229 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0da2a81eedfa..faf48ca9e555 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -702,6 +702,21 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 			    struct iommufd_vdevice, obj);
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int iommufd_liveupdate_register_lufs(void);
+int iommufd_liveupdate_unregister_lufs(void);
+#else
+static inline int iommufd_liveupdate_register_lufs(void)
+{
+	return 0;
+}
+
+static inline int iommufd_liveupdate_unregister_lufs(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
new file mode 100644
index 000000000000..6d2a64966335
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/liveupdate.h>
+
+#include "iommufd_private.h"
+
+static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iommufd_liveupdate_freeze(struct liveupdate_file_handler *handler,
+				     struct file *file, u64 *data)
+{
+	/* No-Op; everything should be made read-only */
+	return 0;
+}
+
+static void iommufd_liveupdate_cancel(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 data)
+{
+}
+
+static void iommufd_liveupdate_finish(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 data, bool reclaimed)
+{
+}
+
+static int iommufd_liveupdate_retrieve(struct liveupdate_file_handler *handler,
+				       u64 data, struct file **file_p)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					    struct file *file)
+{
+	return false;
+}
+
+static struct liveupdate_file_ops iommufd_lu_file_ops = {
+	.prepare = iommufd_liveupdate_prepare,
+	.freeze = iommufd_liveupdate_freeze,
+	.cancel = iommufd_liveupdate_cancel,
+	.finish = iommufd_liveupdate_finish,
+	.retrieve = iommufd_liveupdate_retrieve,
+	.can_preserve = iommufd_liveupdate_can_preserve,
+};
+
+static struct liveupdate_file_handler iommufd_lu_handler = {
+	.compatible = "iommufd-v1",
+	.ops = &iommufd_lu_file_ops,
+};
+
+int iommufd_liveupdate_register_lufs(void)
+{
+	return liveupdate_register_file_handler(&iommufd_lu_handler);
+}
+
+int iommufd_liveupdate_unregister_lufs(void)
+{
+	return liveupdate_unregister_file_handler(&iommufd_lu_handler);
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 15af7ced0501..b3bf65bc8da4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -723,11 +723,21 @@ static int __init iommufd_init(void)
 		if (ret)
 			goto err_misc;
 	}
+
+	if (IS_ENABLED(CONFIG_LIVEUPDATE)) {
+		ret = iommufd_liveupdate_register_lufs();
+		if (ret)
+			goto err_vfio_misc;
+	}
+
 	ret = iommufd_test_init();
 	if (ret)
-		goto err_vfio_misc;
+		goto err_lufs;
 	return 0;
 
+err_lufs:
+	if (IS_ENABLED(CONFIG_LIVEUPDATE))
+		iommufd_liveupdate_unregister_lufs();
 err_vfio_misc:
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
@@ -739,6 +749,8 @@ static int __init iommufd_init(void)
 static void __exit iommufd_exit(void)
 {
 	iommufd_test_exit();
+	if (IS_ENABLED(CONFIG_LIVEUPDATE))
+		iommufd_liveupdate_unregister_lufs();
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
 	misc_deregister(&iommu_misc_dev);
-- 
2.51.0.536.g15c5d4f767-goog

