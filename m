Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0723BD
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 10:49:04 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso2000311276.2
        for <iommu@lists.linux.dev>; Fri, 07 Jul 2023 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688726944; x=1691318944;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c/4umIT6y8SepYggoiaDuEPxpm8rRlzqv1RS6EtUYsc=;
        b=fkqd8kqsVerPuWMKEachHnZrB/b1jdnkKsK5lYfAeHzs+UaA8MSq/j9664MUXBCUno
         C27s0BBBPvnEWu/LkVgd/oQprPywcwRaeWyDTlqwmXNlTe6LEjwDCTmLxHZxfZfM7MOt
         SrGdrNlBtMoEYyXQgHINB9Bbat7H9+Zm8Gk5CFevu/U4Uf1cclksGptS3YbDryRKH74c
         Kd6NQDVeXKWkkqaZNxSCc2mmJ2AKLA6YCDb6vhXGtLUAwj8DJWSqpDIqINHRyKSoW4RF
         GcJ0FsZxV8Y8XDx7ZjatrviiMkEZgtPfB3iOweTAvKs9SmtiryjAVYcZIdBoIJbmabHA
         /ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688726944; x=1691318944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/4umIT6y8SepYggoiaDuEPxpm8rRlzqv1RS6EtUYsc=;
        b=L38yoO8g1HVJ1d4zATjhhE5v8Nw+jBoQG1e1gFBC4JRWqI6JFgltlWIdPXiBLJEcxN
         L37bqcPE9E6vPRHldQmCE6aTqITqnjAixBfth40iW6pL/x9K+D0rp29byzytlgsBqji3
         lO9+QytRRJPhTDZub6pg2NI59lSBV3hpS5Jo8oL0v6kdc4x4UVNt0SaObWB3QDe+DvTm
         sZA+MON0PLtcOgw3rETGYjIt0Q71nobtYniA2xRX0XBrGFp2R15MSBndpWlL1focOZPO
         D9sRk2lLWOjEPjUtb1pm+/qPfaqwHAiphQhT7LGGCg0qYzAqYa8X2ZfbHhHQtcWlPyeu
         v2IA==
X-Gm-Message-State: ABy/qLaVzl0XCmRkd8aQeqwEloAvIPe7LauTAV+glD87n3qqWBKrPwpH
	XokegDTdRCdaRigNpo//kWSD1hUM6w==
X-Google-Smtp-Source: APBJJlFGTUIyKsUt16eI5FZWrckLP6pvNMuw29S+VDV0tG0/OvrJhu5919b6IElfGMAIbYEFd4787yoBpg==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:ae8a:0:b0:c5f:85f5:a0e5 with SMTP id
 b10-20020a25ae8a000000b00c5f85f5a0e5mr44491ybj.5.1688726943861; Fri, 07 Jul
 2023 03:49:03 -0700 (PDT)
Date: Fri,  7 Jul 2023 10:48:57 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707104857.348353-1-praan@google.com>
Subject: [PATCH] iommu: Expose an API to set identity domain
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: nikhilnd@google.com, mshavit@google.com, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The iommu driver has a function `iommu_change_dev_def_domain` that
allows the user to change iommu domain of a group through a sysfs entry.
Currently, the following steps are required to change the iommu domain
via sysfs:

1. Unbind the driver
2. echo `domain_type` > /sys/kernel/iommu_groups/<grp_id>/type
3. Re-bind the driver

This change introduces a wrapper function around it which allows drivers
to change their iommu domain to identity during the driver probe. This
faciitates bypassing the iommu for trusted IPs/devices for performance
without needing to unbind and re-bind the driver from the user space.
Additionally, it helps in achieving this functionality when the sysfs is
disabled for a system.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..36f158621dc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -2908,6 +2909,10 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto free_new_domain;
 
+	/* Make sure dma_ops are appropriatley set */
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		set_dma_ops(dev, NULL);
+
 	iommu_domain_free(prev_dom);
 
 	return 0;
@@ -2921,6 +2926,22 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	return ret;
 }
 
+/*
+ * Sets the default domain to identity of an iommu group
+ *
+ * @group: The group for which the default domain should be changed
+ * @dev: The first device in the group
+ *
+ * Returns 0 on success and error code on failure
+ * Note:Presently, this function shall be called only if the driver requests to
+ * change the group's default domain type to identity during the driver's probe.
+ */
+int iommu_set_def_identity_domain(struct device *dev, struct iommu_group *group)
+{
+	return iommu_change_dev_def_domain(group, dev, IOMMU_DOMAIN_IDENTITY);
+}
+EXPORT_SYMBOL_GPL(iommu_set_def_identity_domain);
+
 /*
  * Changing the default domain through sysfs requires the users to unbind the
  * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
-- 
2.41.0.255.g8b1d071c50-goog

