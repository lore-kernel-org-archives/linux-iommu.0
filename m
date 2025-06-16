Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CD285C9F
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079875; cv=none; b=DN3xji5QAemGmTGgqiBOBg8amqCHVrZ/PTwY9McNCSVmzx2a4txFSyvLScKZZ5L0k0kgaM0GLggLhFdaDVkQ+WrhqLJXPxR5j9q2lR/x6ERTTTB351ygeaeXY7VXqTktctt7iu1ciaej01PyQT6Wrok3GYDONfO7BOqV05kD+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079875; c=relaxed/simple;
	bh=WCTzazPX1mIZz7sRpdpGmgMyEbQM1FgBQK3W2dVT934=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T70lUiziY4UHW3Fp/b0uNzGZQdcXA09TTO6euYqA1DHKsxd494zJpAATRLhVSuVuej//m61L4plsLnIQzeWqMZOMY9x/mOL0cwQJXIRocqoEyGxWkN4d9Av+kq7+eZvFf5Vsyw8+9Gkf0Ly8JMvWbEDUrm7t0gkoLaYFaYZ0Ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=pXf4uSW8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="pXf4uSW8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5840ec53dso48653871cf.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1750079872; x=1750684672; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsQcJLbdBgsRqz45s7iUvZT+brdeeuX9+GwJaZcVB+U=;
        b=pXf4uSW8RQBvwRinouYP6IEMNipf8NuyQVofhEhh9fdKrEAEFuH2gcxcvLeVApiMYx
         FcAaUPwasW5H2UHs8nBsydK0U7J+J5gWrTcbXTHW9Mco4CKGMsbEiacae3lW5qCbMdYy
         4WtIe2+p8NOS4QBCWK3ah6v+DxEcSu6qjwpFAkD19avaGaHRqIiuypd8nrSljYzym+Uv
         /Bh11bx6oz3d+5Tnq8LGGYeMTNYsyRIQ8qTeJ331PTf/qWYHtcl7ilMcaBYpXKqXAa+e
         19QsPTW0LfRDaCeQP6kQi3DmTGm4uHt8qLbzpKyWHi9/SvhTHQ9oxNVaI/GaIKh3aGPl
         XEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079872; x=1750684672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsQcJLbdBgsRqz45s7iUvZT+brdeeuX9+GwJaZcVB+U=;
        b=jV3YoGfwF2nzgHVJFgsQXlrb3PN2DB/CKMG2q9/XjkufYN+Y/Bk3Gbns/2j9HKAlHl
         rsG82IGtKn1FxHA2oplXfWUZvUkH9L7AK9SgIddLfGuxeb0jK2Yzi7f4nzjOcjDqidn2
         zPvJwcU0OHbQO1fRvkQdh0/pqe0mboVfzqpREi0FKsjjcJN4Kyq1oJMbE1Zfn+jxEo1y
         1I96Pfha8DlREKrOKJA7A7gTHBNz2C6gZhmsxxWXb2YT5xQ0okRr3l4HNQuNvbVn8eqK
         H8Uzwo9vvTV76M/wnLTl4h1UWGZy2o5vLGJML0b01nafRhri6Va75W+fgrJbXtVNg5Sl
         qqxA==
X-Forwarded-Encrypted: i=1; AJvYcCW7wv2kYmYWhJN1kulaXTr9NJ2YQGGR8O1oxGF6EjxGU3/JH8ucbWUK+8YyeJqNrScHlmcC0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1goRUXXIT6mtqs2fOQ5hi9aQPmog0NSJCYge+cCBnVYbxfpf6
	6r+IuTcnpSZkUPkbz4hE9q4rvpX5W+78ioRQz08GGCcGun0h5aRxy0zn2eyDAyRK/sBnoDjW7cr
	zDJQ7
X-Gm-Gg: ASbGnctAOywM2wLwSz6kjs92xwMqOIxZiTvgO89aJOnbea09sWaHGR6TKbUsQ7qnDN7
	dXSdx9Wvw5gy3HZT30qMnheQCF5eO5ioznAYsxJD2Ug4DNRqpXJXTjQix/DZo0u5IzfDo9k+7ZT
	Q3ngUsK7vVqcSXc2LWi3vUxBFiheXfmeq8qq09chiv/qIT9frMl7NFA1yCueag8T2rDVxt4tKzR
	S9Vr0O9dCC1+01lmJqO6BF+5xfFmGblRAezmr4sE9Ae6Lp97loyu2amrQzErXP+frA/oI5tDlM8
	nT35L54EYT3zzon9Y/4BMYhpr13G+IV5+fq/aManaDJvSMDed9ilJ4zoGzRIYmyuuhqMaDSnS/H
	CqG7oN+JuVBt9ahUnO1himLYbMR+lqIh7VQ3f
X-Google-Smtp-Source: AGHT+IGlzrzTnY1QPDnvq4pMc24W67/yoV1eAYDGcwVm3JuMbewKGjqfbMw3ke5LLOoCY5fxbkqHKw==
X-Received: by 2002:ad4:5c46:0:b0:6f8:bfbf:5d47 with SMTP id 6a1803df08f44-6fb477758b2mr144489116d6.24.1750079872218;
        Mon, 16 Jun 2025 06:17:52 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb55e3bacasm11049686d6.123.2025.06.16.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:17:51 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	fujita.tomonori@lab.ntt.co.jp,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/vt-d: remove the CONFIG_X86 wrapping from iommu init hook
Date: Mon, 16 Jun 2025 09:17:36 -0400
Message-ID: <20250616131740.3499289-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu init hook is wrapped in CONFI_X86 and is a remnant of dmar.c when
it was a common code in "drivers/pci/dmar.c". This was added in commit
(9d5ce73a64be2 x86: intel-iommu: Convert detect_intel_iommu to use iommu_init hook)

Now this is built only for x86. This config wrap could be removed.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 drivers/iommu/intel/dmar.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b61d9ea27aa9..ec975c73cfe6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -935,14 +935,11 @@ void __init detect_intel_iommu(void)
 		pci_request_acs();
 	}
 
-#ifdef CONFIG_X86
 	if (!ret) {
 		x86_init.iommu.iommu_init = intel_iommu_init;
 		x86_platform.iommu_shutdown = intel_iommu_shutdown;
 	}
 
-#endif
-
 	if (dmar_tbl) {
 		acpi_put_table(dmar_tbl);
 		dmar_tbl = NULL;
-- 
2.50.0.rc2.692.g299adb8693-goog

