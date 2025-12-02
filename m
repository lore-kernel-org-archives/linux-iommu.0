Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC92FB09C
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716592; cv=none; b=Ljz7s68UCq9JMkyDAnnns+tbVjTNozNJqPycLdhPfzBxqQFzDfAx4endE/qo1wn6jq7LahA9AvEU7ZZkbIBjOeIibbDr6IkXY2WvtPbjw9nSCGoi5Iy4yyMuxYbiqtLf73/aTRi5V8U27rBGcNsCVNBXu3N7xRwBQjKXnYHRDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716592; c=relaxed/simple;
	bh=q26lT5+QIjNMnp00mrlGaRjxtr3sYnivw5gh5YE54vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCG7D9WCWlkpWbpp69twwiQQiPq2g+5GbLm9TdrUQ+1tbB4+/MNYiEG82bRJA1JurpB4xbvIOa9QEEFzCIm6/ertVPvdq4OnJykYCfWQyEuSJjnIq/wfB/Zt4eBJdWsgTp81WFL3YBCwqXr0/JAAi6xbVdmT2vhfAft7qQintbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjJCVZSG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjJCVZSG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-342701608e2so6136233a91.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716590; x=1765321390; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OySWeHXiWI36ymuPEw+MqIzGz7lUdgksPphiWjhPm2E=;
        b=fjJCVZSGFGFzXCXCJqlPt2F5wKBR5wfAQgsP69BKBNxGtfApWK55L1Q4EyXe7o8mLD
         5Sif3j3fdj2UhZnZl+hxCPsfmkMBix0WFcrK+6Tawj2i1cfcqo618D09jwCwwhreThVt
         eljCZYHL7OTAh4lbjqvCkLoapqlv3gSWHGMh1GefoCv+99VZGz8i2iN+W2OILerfyKED
         MaQ/IwE7vd6Ea0IeqBPYGkBk3P7wetjs+LKgySYlpdbHVIaSJG40uXPd+1GHTRhn+N0v
         Tyyhkzoe/hsxwFzSsN3OcUNzfpgjRNL7RZiCqq1CfxIIsJ3qnCgv6rAlIJ6Mbu1mLNOc
         jhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716590; x=1765321390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OySWeHXiWI36ymuPEw+MqIzGz7lUdgksPphiWjhPm2E=;
        b=TjEdLQEsQqYlwGAbh0xCd69x10xUrk5RQjQ8f9CrB99vgAXx0ZHlniP/8LQVtYUCoE
         wN2JxZw2HQr1btgncJf9yBQRnDxsZiiboaPIQTGV8Bs+oyaZtbng5AFZT0pcqPVkNmTo
         b1U0CBMrelmkNi/DpCRRoEfjdJA2gWBT8zGtB0kDlFcdWUR6/+BEEnzmlZIjwKwhFeNr
         l5w9S6j265RiuaADrwr6g1KofaK+qfGOGn61wlb6QurZBPgL/ZM7kvKoay+ifOrd5Q6p
         gtSGOL6poHUzGJGIVqMyuIWaFeU9zj+SGXMsyahfoBvvN7veAsNZz+NY5NnwWwzobDh4
         EzCg==
X-Forwarded-Encrypted: i=1; AJvYcCVpzrxXcUNVyc0dFOQxAN6D0sxJgG4sujhOmHFV+V4zIKgHo9u0Fzv9+g8N12dlEiW9cBoVdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOybvCdF//o17AadbTkKVPczMmBh4wbt2paapM8fkWlBDtlACR
	7cKNTYUAe+PQ/QxJ59EM1I2SHdtDr7bZjRBzFVEUc44zRlb1kz8z9oIH8QWUHu+En8TmZEh4swd
	oI0BwQz3HO4g7jw==
X-Google-Smtp-Source: AGHT+IHHDpkeL0YedsPxbQcueUvTuPLbaLZw3dZHG5OyhPNPHXA1x4CCrTNX+v97FQpsslTyDcH9a17tkl0/mQ==
X-Received: from pjbpt15.prod.google.com ([2002:a17:90b:3d0f:b0:338:3e6b:b835])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6cc:b0:340:bb5c:7dd7 with SMTP id 98e67ed59e1d1-34912687d30mr399630a91.5.1764716589718;
 Tue, 02 Dec 2025 15:03:09 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:33 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-4-skhawaja@google.com>
Subject: [RFC PATCH v2 03/32] iommufd: Add basic skeleton based on liveupdate_file_handler
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

No functionality is implemented in this commit. Just registering and
unregistering of the struct liveupdate_file_handler for iommufd.

All operations are stubs returning either error or no-op.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++++
 drivers/iommu/iommufd/liveupdate.c      | 69 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 14 ++++-
 4 files changed, 98 insertions(+), 1 deletion(-)
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
index e43da269ab80..b6959ad55ad4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -711,6 +711,21 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
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
index 000000000000..d228157b6fed
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,69 @@
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
+static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iommufd_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	/* No-Op; everything should be made read-only */
+	return 0;
+}
+
+static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int iommufd_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return false;
+}
+
+static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					    struct file *file)
+{
+	return false;
+}
+
+static struct liveupdate_file_ops iommufd_lu_file_ops = {
+	.can_preserve = iommufd_liveupdate_can_preserve,
+	.preserve = iommufd_liveupdate_preserve,
+	.unpreserve = iommufd_liveupdate_unpreserve,
+	.freeze = iommufd_liveupdate_freeze,
+	.retrieve = iommufd_liveupdate_retrieve,
+	.can_finish = iommufd_liveupdate_can_finish,
+	.finish = iommufd_liveupdate_finish,
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
index 5cc4b08c25f5..18cc4af0a5c4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -773,11 +773,21 @@ static int __init iommufd_init(void)
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
@@ -789,6 +799,8 @@ static int __init iommufd_init(void)
 static void __exit iommufd_exit(void)
 {
 	iommufd_test_exit();
+	if (IS_ENABLED(CONFIG_LIVEUPDATE))
+		iommufd_liveupdate_unregister_lufs();
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
 	misc_deregister(&iommu_misc_dev);
-- 
2.52.0.158.g65b55ccf14-goog

