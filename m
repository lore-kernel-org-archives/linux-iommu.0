Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDBC433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FD721741
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4rwEj+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FD721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6457B2153B;
	Mon, 24 Aug 2020 18:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4h9lbDF+hmO; Mon, 24 Aug 2020 18:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 062862153E;
	Mon, 24 Aug 2020 18:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD896C016F;
	Mon, 24 Aug 2020 18:42:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF63C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B3DA8758D
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVkKLAc7RNeb for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5B9C28758B
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:11 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id k18so5304881pfp.7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kWycSi8/0OaxvdZxdOTDCmrk2sU9rNWY5PuqZqeV1sg=;
 b=r4rwEj+O6r+DxrTANoYOTdX6LhhgVZHiSCccBdDNrSo/wyXwo/qLbSGybpJlYchNd5
 4uOMmCRIPb7QG89OgxnkzeqEVvSF2yB5lmk/APS0miJQKs9fum30PA1zKedNQavescci
 xe5Nre1Am+p4ugxF3qjbckrlCuRi2P0G1Tlb3c1pPTB3Jb3P0Q78YwYpqGMP2vfc8y4t
 AvvzPQAPjg/i4PeS2hoYNW1/yea+iAvEmxVJ94Ut+BrYPvwyY18/m97KL01DRCIR3bem
 Dt6thI9Vb6rWe6np9yy9FsKsIF24vLoL4hlTvLYcX8T8+n2RIO6OJlhaT6QXcHNovGry
 OsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kWycSi8/0OaxvdZxdOTDCmrk2sU9rNWY5PuqZqeV1sg=;
 b=AVLy8JHEIEuU0VftUwtCQO3A99/RHmYL5U74W3+vQ5Dkw8enLb9JilIG3liqLz8Y5q
 pEbAC7C4/eZhUImfRSsRjtOxHOMqxuYL0mewKmanOunAcWSWZMAd/EwUFHO+ijtdEahm
 OflGEL8v388uO+EAZiX6GL6qjFHX6igiLS/MKFNYmh96j7AvBuPqEc/J+KlD+G7wVViZ
 C2yRlnz2ECUwDWBYMu6ZYb5XxUYC92d1KQlVnny2sTCui93T1HEJLX9h/VHkJDu62jLR
 TSnHdIRmEqdghL9iFZgbOru11slN6aPEJXAMK+I8Sw9WISwMubcAVOPVs5PKPbsxvW9R
 PLpg==
X-Gm-Message-State: AOAM530JALf6zUw+yr6VDPCf2R11Y+HSE+4oXnmGZ4sYnL8o7GZXqYrU
 fQoJgntZGpxz2loapiKGnL4=
X-Google-Smtp-Source: ABdhPJy1K46vS/XLW2Rghqha2/afjikWJYTKXUJdYFsRFmeCGtgIpOYe82nrsWdZjXAh0X0rM2Gd/A==
X-Received: by 2002:a17:902:24c:: with SMTP id
 70mr4620642plc.284.1598294530939; 
 Mon, 24 Aug 2020 11:42:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id c15sm12191543pfo.115.2020.08.24.11.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:42:09 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 05/20] iommu: add private interface for adreno-smmu
Date: Mon, 24 Aug 2020 11:37:39 -0700
Message-Id: <20200824183825.1778810-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Jonathan Marek <jonathan@marek.ca>, Joerg Roedel <jroedel@suse.de>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Eric Anholt <eric@anholt.net>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 John Stultz <john.stultz@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 Brian Masney <masneyb@onstation.org>
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

From: Rob Clark <robdclark@chromium.org>

This interface will be used for drm/msm to coordinate with the
qcom_adreno_smmu_impl to enable/disable TTBR0 translation.

Once TTBR0 translation is enabled, the GPU's CP (Command Processor)
will directly switch TTBR0 pgtables (and do the necessary TLB inv)
synchronized to the GPU's operation.  But help from the SMMU driver
is needed to initially bootstrap TTBR0 translation, which cannot be
done from the GPU.

Since this is a very special case, a private interface is used to
avoid adding highly driver specific things to the public iommu
interface.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 include/linux/adreno-smmu-priv.h | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/linux/adreno-smmu-priv.h

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
new file mode 100644
index 000000000000..a889f28afb42
--- /dev/null
+++ b/include/linux/adreno-smmu-priv.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google, Inc
+ */
+
+#ifndef __ADRENO_SMMU_PRIV_H
+#define __ADRENO_SMMU_PRIV_H
+
+#include <linux/io-pgtable.h>
+
+/**
+ * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
+ *
+ * @cookie:        An opque token provided by adreno-smmu and passed
+ *                 back into the callbacks
+ * @get_ttbr1_cfg: Get the TTBR1 config for the GPUs context-bank
+ * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
+ *                 NULL config disables TTBR0 translation, otherwise
+ *                 TTBR0 translation is enabled with the specified cfg
+ *
+ * The GPU driver (drm/msm) and adreno-smmu work together for controlling
+ * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
+ * updating the SMMU for context switches, while on the other hand we do
+ * not want to duplicate all of the initial setup logic from arm-smmu.
+ *
+ * This private interface is used for the two drivers to coordinate.  The
+ * cookie and callback functions are populated when the GPU driver attaches
+ * it's domain.
+ */
+struct adreno_smmu_priv {
+    const void *cookie;
+    const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
+    int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+};
+
+#endif /* __ADRENO_SMMU_PRIV_H */
\ No newline at end of file
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
