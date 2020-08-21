Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC0C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6176920724
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpM+QAeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6176920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0318320428;
	Fri, 21 Aug 2020 13:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hv0+WgKuISc9; Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4DF2B2043C;
	Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC92C0889;
	Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6A29C0889
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7E046862C7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bqv-u4fBa91R for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D0C085FB9
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id df16so1372249edb.9
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
 b=NpM+QAeAtDS+vuHr/qsAxLGz0RzOZbBpb7eNNFUK3Kan9Wha3FSnGrRgODlSfxTHji
 jqPHivHK0RsfnSvZINhMJVXV5ePliRbvAny/XW+puDQKC9eSaVAT90nZ237E34X+jPYz
 kqcNeVfjnEsJ8Zd/HJrDBnyrln9AFE9kVmyfgvbVnVxLMTT6NChJuydDWP2g8r/bs627
 o/8F+GSTZ5LbFww31m11upQpAqghI7vnm3FSwkHTJlg1f7RR+pI4bBJ3Zi1Je66cAb+E
 K1wzyw+hhAwliNdzhiHjWsJXWyJbMOjB6LnZIj4Kyg9JvalM3Q+LR0JUdr19byex8jUC
 RJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
 b=kBUHyByP4UA5EnIfrzucONPo54NUOMk1QhpZndsawQwj9PQpnDbB3FyO/0FRj+9nEN
 7nmmzP9wi9ghEqp5o3MGMj8WNa+a2o/lDJFOIl8dDx+etKMpVRt17rVByCBfmiPxpl8D
 qPInwa+b94gw8fyZvLt5SZsJDFpsmRmnhNC/IKRwpOcHf4QcJbVSyKWINE3bud02sXUv
 PqmRKShA3EiP+RBqJJKLyJdURdbQfFVCNkAv0tpjyrH+bJB8euVgic6ozdetUDeFtan7
 JDeq/dvwQ82vOr3AiWrDoa0iGMWPfCrG3UEFGxgRml5GAWI/QPNtZ5+Qe235bsnrPK1y
 aXFg==
X-Gm-Message-State: AOAM532SAPBnFBJc1y6v2eiYlfVM0IZJ85HXEHNSZzDPqYtf+thpvxbZ
 PM2zwtSuUcMuLSXBCW4amQR7kU0MWX7mw6T2
X-Google-Smtp-Source: ABdhPJxokcQ0IuXysG4c3tg0Qxks3XmbNzQjbGHqNkBr899EEr9X26aBW5gNkvYxSfGRWPA0z+/VaA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id
 bm28mr2790782edb.116.1598015768219; 
 Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
Date: Fri, 21 Aug 2020 15:15:35 +0200
Message-Id: <20200821131540.2801801-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, bhelgaas@google.com,
 jasowang@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Before adding new files to the virtio-iommu driver, move it to its own
subfolder, similarly to other IOMMU drivers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Makefile                    | 3 +--
 drivers/iommu/virtio/Makefile             | 2 ++
 drivers/iommu/{ => virtio}/virtio-iommu.c | 0
 MAINTAINERS                               | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 rename drivers/iommu/{ => virtio}/virtio-iommu.c (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..fc7523042512 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += amd/ intel/ arm/
+obj-y += amd/ intel/ arm/ virtio/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
new file mode 100644
index 000000000000..279368fcc074
--- /dev/null
+++ b/drivers/iommu/virtio/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
similarity index 100%
rename from drivers/iommu/virtio-iommu.c
rename to drivers/iommu/virtio/virtio-iommu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..3602b223c9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
-F:	drivers/iommu/virtio-iommu.c
+F:	drivers/iommu/virtio/
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
