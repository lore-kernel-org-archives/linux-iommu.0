Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFF25A62E
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086465; cv=none; b=lhmcmYAMGhC/9wLYQHsCXmcr6SyKwpJ01ChEqDOpOI7touA1dBcebU7vwiKbp45lcwW1Y9KfdbrnEVj3eZbK8IHJVleUYl5IAozaBY1gU6Cu2eimR3a0fVM1ckP0oxeFQZ5jL3fatSFjQjnnWXFlefXFcObSl5nbOvHG+RGEKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086465; c=relaxed/simple;
	bh=K5fHpHWFykCx8GSNl+bRBubKB+z9YJLFyN3qkeQz+gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B5mST3ipSnkLfgA4gZkPlGsyC2DTT5bC3fT+nOaVSkblyjd08x9aMBuUFPEdwDEHvdHvFjss+Tsl47a24QcZm9lRwWaH0+16b2/bHDnHRxW1XgVLKuzOyycPuXyM9Q+NC4Yxf8KYWBdfFns7cdBmrcV+Lg2WKk/xsWuh9ioT3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRnGnNNq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRnGnNNq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244582bc5e4so42916905ad.2
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086463; x=1759691263; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCuO86qV7dZm/aG2Dppf5kSqYkYatsl7iuzcTQdCTDQ=;
        b=nRnGnNNq+RB8WOhxnsoosMeNWK/PcEGMU8U/Ng77JjNjRw6axeXHPFE2NdCc0NkvZM
         kN/Twvom+GmmEm2xQSaOPD6p8WEn0Lt+c89KkOf607qVXf37jqsfxs/Da5KqTPkpoZdK
         CuDka6kncqQD0HmZ9hfOSzpTMBbG3n8lo7pA6fQoQ6B051oYriUbNdwk3cHMWonYDuJ+
         ga8GmRkkMJ8zxiPwlSOOg6mGb7OgdkJcxvPVxFw3sSu9TOO8nvpeDFLlYKvMUV69PalH
         KhuOrVNWM5q6r9r15IOnBxji6EhaRpiHDBXO3xEYp7f8MsFNoxnoWVJ1Pu7Dx38nUxeU
         9pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086463; x=1759691263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCuO86qV7dZm/aG2Dppf5kSqYkYatsl7iuzcTQdCTDQ=;
        b=wI/Z6J8VtlHw/NjuTjI8XLWCdMmpJJaP/lHq7xjP4+z5p0BCD8rJUDghx7HiQpOmfr
         OB75g5kok7A2yygsJnE+y/lEdgj/l5vXfdhWs7msdD1/k1eYL06pOZwjoGGQgxsy3DpE
         ownhnz16jopCCl/uVIiJsrx7GKGjFRfQK0X9yBYdFbTIc5lxxZhUnVdBf77giawtnsrh
         3rDY0QAWvE3n3C2T9ERB7nWyLgRSekUJ1/QJgdiNOcUiZaO7Qx5Gp/ZWR95XxNVnoROG
         +1vzY7SiPv1rG/k9TSvHcsFJ2773ODkGhSJD6dUOrR/kGl7BeyufXj5BQr6DOgNN1rKb
         I2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW8AratArkIlI1huC3Rtgy7dLNAQO9t8WV3FDemIRA52xX2hHdyQT7eEz5fQdSN3XaEWSNR0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbC7+UpsbmvDRYlmZeG4XisFsjqMe/u0rPyVGdmBp9Ee7WfFVn
	Bq02DqmZ2bS7ozo/520aIMuaLwkVRk8KPwaJbcPFGLNXdccpAQbt8BhQ8lI3zyIPJ2j8JRpVZTV
	pxjiCuyfLetozVg==
X-Google-Smtp-Source: AGHT+IGpJ49K/7HkT1GORRMDUMXXC7GDu2XGPfU5JdrnHAHFnDeqzWXWkVU/StxzhY59C7N/ChZl6seiFoS9WQ==
X-Received: from pjbaz14.prod.google.com ([2002:a17:90b:28e:b0:32d:e264:a78e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2d0:b0:25c:b6fb:778 with SMTP id d9443c01a7336-27ed49fbbd6mr146672005ad.14.1759086462824;
 Sun, 28 Sep 2025 12:07:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:09 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-2-skhawaja@google.com>
Subject: [RFC PATCH 01/15] iommu/vt-d: Register with Live Update Orchestrator
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Register Intel IOMMU driver with live update orchestrator as subsystem.
Add stub implementation of the prepare, cancel and finish callbacks.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |  2 ++
 drivers/iommu/intel/Makefile     |  1 +
 drivers/iommu/intel/liveupdate.c | 45 ++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index baeda8a526aa..e038cdd6aa41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14228,6 +14228,7 @@ F:	tools/testing/selftests/livepatch/
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 R:	Pratyush Yadav <pratyush@kernel.org>
+R:	Samiullah Khawaja <skhawaja@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
@@ -14235,6 +14236,7 @@ F:	Documentation/admin-guide/liveupdate.rst
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
+F:	drivers/iommu/intel/liveupdate.c
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..58922d580c79 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..d73d780d7e19
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+
+static int intel_liveupdate_prepare(struct liveupdate_subsystem *handle, u64 *data)
+{
+	pr_warn("Not implemented\n");
+	return 0;
+}
+
+static void intel_liveupdate_cancel(struct liveupdate_subsystem *handle, u64 data)
+{
+	pr_warn("Not implemented\n");
+}
+
+static void intel_liveupdate_finish(struct liveupdate_subsystem *handle, u64 data)
+{
+	pr_warn("Not implemented\n");
+}
+
+static struct liveupdate_subsystem_ops intel_liveupdate_subsystem_ops = {
+	.prepare = intel_liveupdate_prepare,
+	.finish = intel_liveupdate_finish,
+	.cancel = intel_liveupdate_cancel,
+};
+
+static struct liveupdate_subsystem intel_liveupdate_subsystem = {
+	.name = "intel-iommu",
+	.ops = &intel_liveupdate_subsystem_ops,
+};
+
+static int __init intel_liveupdate_init(void)
+{
+	WARN_ON_ONCE(liveupdate_register_subsystem(&intel_liveupdate_subsystem));
+	return 0;
+}
+
+late_initcall(intel_liveupdate_init);
-- 
2.51.0.536.g15c5d4f767-goog

