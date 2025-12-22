Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A18322B81
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416606; cv=none; b=iI1TZ+E+XfI5QIE9SDl2IMYQYPUNPZXK8399ssNoSvuwL+SLs9217u8TvBwgNxUx57o5mjrawdZZBMU2l+wCvPlAidv6hD2LmSwnbRI4woskOqs1jcPdBnkO7jseBK6YhMFufQafwSVRdF/pCZphhG7Mt2/+lMFqDZ0cJGSjRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416606; c=relaxed/simple;
	bh=omJvdU8AWfgVb6Vw1LtfMA+xbk2Xh65NfSOJvn2V69s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+UlCmqanFlUv3AfcU3NOl87pAYChPKa16kpWOX+Netr0YXst4zEEN6V31GNxbifKYiJaAB7w2Pt+ZOfcjt33rvhpo4H8umehHCl/Jqpe2P0YTVWIx5YlXfkIPaW53ckUj7JcKYkyA/sHHZDHXbYKD8ZoYarhT1NJhobzeDJphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkCk+n9/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkCk+n9/"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5943d20f352so4462235e87.0
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766416603; x=1767021403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOhpbiD30EOzMJOTDaD6LW0o3SAP0osk2RqB6dtZz9w=;
        b=WkCk+n9/tJL+0KU0pZiWwiYf307KIubr2YugOao+HnsqQX/qLQMO3vMWKS+BprP9YD
         h+sttvRVuSkYBN4NSterhkrg4CNcZqnv9i1SQiYEfd1jCNR2uHaWzAbY7qs1MVax/ylw
         otTFDRtmj3IrYxtmQP0pkDSY33zplzN8JFAXNofmmS5ZhPX2gqsQihQSyPqNV43Mspy1
         v3DT3c3E8j2AC7fCgoDpwF5rquhSVHQp/lPaD9eCIB1AUYSIm5up8pcH3GULQ4I7A6l1
         8MQHujQlCn2eMHkLk/+COjI54ZqJ2TBThYGDeBkxpj3fyRcQDis4E/8pnSVYk1do3ID2
         E94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416603; x=1767021403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOhpbiD30EOzMJOTDaD6LW0o3SAP0osk2RqB6dtZz9w=;
        b=f5xL9YjYSn7mExKc5KDhfApXxnfiG1TODd9Ie5jXLn4pQr6w9phQijjm9zhYui1/WQ
         4hQK0IqTHy8jA0IShH/kRBM0Tyr0jro18jai2f/1hMXyl+qWW/i7SQRCmGpbFcM4/dyi
         s9mEYfd8hGyU24O6leQoV9DMoy2bo3ZzKYYUWqrbvv/AaSbjeI8uYM/AwcZRi/+dpLpk
         EQYCCMrPYGVMHNMkeXhQQjoxz8Ti1+G8mpezKPW/5ze+VIUhen5s1Lfl8gjSjxYZ5PXB
         VDIOtRPYxtkrEkYXxJdc6Ajp7SI5wAKpwEpEODSiZDTYO6IOHEqf2rrat69ig7Yx1b7t
         4I9A==
X-Forwarded-Encrypted: i=1; AJvYcCVMSv8CUPc2ISiU+Am7/rp+fqB+pW98BNX9IQ5aAnMzEwSD87+nqirwb7+XZR5db0SUKVLyMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTJOQXqFR8iFgAXei0X98A+8lx8+QddEhEKwiKsUajGSn96Fhs
	0tUujwGzH0ctAOZPw/QeRQCBZZ6q+GmpaTzt7icc+1bBSmlviuc8wD8O
X-Gm-Gg: AY/fxX4UHUq73lfShpMUELq0KzQNbCCX7L/Dv938/VQ0KUDGkDzN/w53fRGddvk35Jo
	aTMHM6EbloXMsQDT68twpBABHDZObSVAo2jHlbEVRch7aYiCvOJrUa+s6JpC5Mr0QXV3rndSb8+
	QSW32VMbpubb7fMzlS8zyiPcVr/NL9PyzarWq9wYJwv3QMlCJfmjQM+4zjirevMvEj3JIJ/sGbQ
	Ce6k2BrLytlUK5k73BEYFflZ4yDmnI5Zsc61j6mNoVXck8w1KBANOIBfLFz+L4Vr8UkUP/OqMjH
	ArNKQFY4KswUlxRL+DTTIaDIonOOBj/Y8Bv/dn4Qnzkz2oYsvk45Txu1NLDvYmSxYP63gbCdQZp
	B0CKh6u0zZWzZPoGHFF9AWaq3nxXCmnHtmLt0kAKWCZFA908lNspVPs9KB551maamyJAKIkD5DW
	gJxD1HE/PyWMwF3pvw2U5DNn5Bzw==
X-Google-Smtp-Source: AGHT+IFDiNOFmtI+bsuMmANJj/IxkuWiRZG1UDwI686IycfQtSE8H4lpxzEMDRaaxB0lvLInfVeh5w==
X-Received: by 2002:a05:6512:b08:b0:593:f74:90c1 with SMTP id 2adb3069b0e04-59a17dec043mr3191513e87.42.1766416602980;
        Mon, 22 Dec 2025 07:16:42 -0800 (PST)
Received: from localhost.localdomain ([176.33.67.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5db1sm3284874e87.18.2025.12.22.07.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:16:42 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: tjeznach@rivosinc.com
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/riscv: Fix unsigned comparison with negative error code
Date: Mon, 22 Dec 2025 18:15:49 +0300
Message-ID: <20251222151550.987992-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_irq_count() can return -EPROBE_DEFER, but irqs_count is
unsigned. This causes the negative value to wrap around and bypass
the error check.

Store the return value in a signed integer first and check for
errors before assigning to irqs_count.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202512141551.kZLTle5r-lkp@intel.com/
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/iommu/riscv/iommu-platform.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 83a28c83f991..5ec8efedbf12 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -68,8 +68,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
 	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
 
-	iommu->irqs_count = platform_irq_count(pdev);
-	if (iommu->irqs_count <= 0)
+	ret = platform_irq_count(pdev);
+	if (ret < 0)
+		return ret;
+
+	iommu->irqs_count = ret;
+
+	if (!iommu->irqs_count)
 		return dev_err_probe(dev, -ENODEV,
 				     "no IRQ resources provided\n");
 	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
-- 
2.43.0

