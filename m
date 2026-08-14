Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504933D093A
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714787; cv=none; b=ahzBsk64an9xEmtbJpXqYYfyomcmty9Apha1ngRX9EwHOdFXeIiTt6zLKv9jcW7ks7n39cizIWfLHiIriB5w9zOwIOTMzOvX0B3cRgq7bnuVFbCXGyiiS1p6kwGe7byDFSRMmxA7An2J+3QhaJkh7+jgD/Ym1Gw7G3Jz4+ENefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714787; c=relaxed/simple;
	bh=M4T/XKvyLQRe89mGAnILG1wCu5GQjz+m+aaDNSsMXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sl+i4LxHpi+fDko3IKdZ7Zwc/UEV8kwEVcZYaJEngdxcwMaPXEbqFOa8VVyqCyB12BD713CASCmPYwkBU8vkaqKfMuQFsSbojVLS1X/jFc8QFp0lugSsqSNDK1cIQKuJNqS8HIsIsvXkRa9oVSmWmWGuih3LKm0vYtHq/2d4Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY+EDmmQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY+EDmmQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedda4c154so594311a12.1
        for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714785; x=1787319585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4kO0JaiBBnnltUiqSOwY9zKyhYcIekp3YnHUYrb9Wic=;
        b=DY+EDmmQIMPWMZlDtMm37L0WTbtvkVfvAgsTw+apy4aHBtZ4CyY91st6+V/+EMakQZ
         EaZzNyKP1acYiQ8XraXeKmbPYx6CRbmnZXSnIWSwhQHZo7M4Kchslj0eL1dJ+cxQATxF
         3rMveN9X2AN8apHM2U6m2LhWRvVX3DUP+P42q7uFVxupgs0y0qNvGzsb6fQk9f62R1pM
         61AY/TZT+mkGwihQoxa6FvjAws4sC2iLs9yig3Tugrb960OHBgU46nIAeqcW6gP2XzBc
         v1lOdLVgYhbLv1TE19xh/D/2FMzloaeWu+QrrciHrjYnKmDQFND75xwxqwQ6OolhMzbn
         oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714785; x=1787319585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kO0JaiBBnnltUiqSOwY9zKyhYcIekp3YnHUYrb9Wic=;
        b=SogOhAsyphPUBOztR5Lr8saANIbMzeJd13LLg104jS0QFc2fYC8ahY+r6O2tNMm+fn
         RzXnGo10QLyz+gWx6CYXf+BPs1D+dlPnMPwOfeV8keIrH+mVGnb3H38aSMYSMzCOSGNe
         dM4xsLURXLMnhn5TJut9pqwQ2tmQiV2bUs7UewYko1j/lkzpHsUPtEq47QbisLu4pKh/
         2S+O5+5nmHUExMVvQcX9nJpumMBDtzWlX4Vz4VUrrswcbScZZNcwWQWswE7SROxw0rCD
         yTenf641kI7gMSNXK9WtbM8EJM6/t9nkJkVWOd9JotUTib95AfZ+jypEliVAaKnLZy9S
         NBsA==
X-Gm-Message-State: AOJu0YzRN9Y3WASSELld8UII/amIjMz0Cw0MusI29CnTvXN+6YHR9K2i
	G33glVM/TSNqdjO6Z+gYqrewtgZ0ybOEK7Tm2agp6pjw35qEqLPU6I0I
X-Gm-Gg: AR+sD10GXQCef8aAQZjF/mp1ypZwQoKFsJNT91QC1P/AAlOZbgwdftJnCBg+Ccgv47B
	A3u9d/GtrtKvWDHA8iS/U8otSbg+zGKaF5+J+rJICGedazCgyWxChvfdPrMTjvmeLetw5iT+6sM
	qBY9Y0hBPbP9PT6t9av066P67ag6fIemNHALx1VzVUjtRumnAqqXgRj2h2serZYN61jNiwwELAs
	XR+ag87lFqOSs3Wbbkuck2I/+ZX7ImJPK7XjtLsJUtSwjfdETkoP9TVNWA64fIoPqiS7iDCzhIS
	D29SUr6T14tBvVwctNnqgmmyGNbbxC8ZVCGwGyHFiQ/dBTOd5P6tsu2LnpfL4nzlN1UpxpvwdwJ
	Ua5Fa74+T/WeYvITdrNp7D4dGKh69AJevf+WOUMY2XSOLfyaaCusQgOk6u1vQTEvBcBHg+TafP8
	6h54QfEOz3THIP6xpGRmlKlmjC3u1zuwq0Eykyg/BpGi6KCxknTBW/sEKqTKaDoAVpXPJM0bEI2
	VgSOEGt
X-Received: by 2002:a05:6a20:160e:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cc719ff645mr7300940637.8.1786714785389;
        Fri, 14 Aug 2026 06:39:45 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a4c7a4sm591739a12.31.2026.08.14.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:39:45 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Wei Huang <wei.huang2@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] iommu/amd: Fix PCI device reference leak in PPR handling
Date: Fri, 14 Aug 2026 21:39:38 +0800
Message-ID: <20260814133938.1385879-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_domain_bus_and_slot() takes a reference on the returned PCI
device. iommu_call_iopf_notifier() fails to release it after either
reporting a valid PPR fault or completing a rejected request. Each
handled request therefore leaks a reference and can prevent the PCI
device from being released.

Call pci_dev_put() after the final use of the lookup reference on both
paths.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/iommu/amd/ppr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1f8d2823bea42..1e4392b17bd8f 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -151,6 +151,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 	/* Submit event */
 	iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
 
 	return;
 
@@ -159,6 +160,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
 			       IOMMU_PAGE_RESP_FAILURE,
 			       PPR_TAG(raw[0]) & 0x1FF);
+	pci_dev_put(pdev);
 }
 
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
-- 
2.51.0

