Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE739DBEF
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805662; cv=none; b=XeHKzy25gUui7LbVIjicpMM9W44OegGDKu+dtE/Y5uXdb1oeZhMSB/I2H8W4l92bc7qJl74FAeKSQVi5KENDmEZA9j6gMPd/Mf1hwg8KR+bWBP7MqQ7NChUWxocWtOmXzPAsMA0D/67bfjLIK2ZGpbtX/rCyT8NmDLIX8gojbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805662; c=relaxed/simple;
	bh=ILe8sZYbhc1aPGHkfBxgnEvKOHpdfl8WUXOCF6YnUmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhB/4BHcm4M29UMNCdIn4h/cXvGrRkQf/hq5jn/pjl3+1pcX6eKn9uVr0+8BW3RN8eCB/R7iQjTOUGeWFZZ/bfrLxQWnSeM4GJP/OSbz3j/BjDXfNsvuoshU1dyxp88O+J10zwbIJUbMZLIds8HCYS96166vBb/4f2hkJBlMR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzSMIRHl; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzSMIRHl"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c9b125d64cso11159925ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805659; x=1783410459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=CzSMIRHlkWSB7m/G2ONVrhqhzbRLj2NnJTxOi+b4ao0ZenSCMkqM4JSlboeNoQPq9s
         QVYolRYpgERfXLDh9B8IftR/b/UwmQlwCgSCNlwPiLGFmiMoQb4sbhsINTNGnqw3S5hK
         kF4yoOrMzlwDjNclCjKzNukY6BtWyNWwOehj9xY0QBOPHc+Igy/yGsZt0j9wgUv08tvG
         yNKm3DpFkWJu9vvRZ9gqMlFLDvj3zHBXXKbIHlImZNhEETAgOzu09PEXNf6ABoj7I4tx
         9U4RBUGeEnK5hAuyvZWQ9Nkf2EUFuvFRm88H9oPX2cHNot62VXSv9RcG/VqIGnK+UkU3
         IOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805659; x=1783410459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=DReIcNjU2C3adyQknM0x4juYdbZ0y68G6rSitcFqr+H4BA80dsc8SBl9Ky0flWxobp
         jRC0x5GzzHIFlPm2tcNsHoKI7eu51Urs5jDYxn5PryIxciwr2KozTOrQAWyEohdsMMLO
         xQK3yJLosbYCugk6HxQkrWO622pl+XaCgm/CQxj09fVwXqb+7uZB8YcxP0S63w8Q+svE
         zRx0iqUil9o2lrD9Kvqw/W15ReKL7rsJodSdCIwnjeXgG+2aHjen3W5Dv/dSy/7pKjSA
         ldUHWIDta9X38jesLKgFb7YIDXb1QJr4is2QZ67fgGk73yDRHyT1RDurJ2moDwsVtkrw
         2fPA==
X-Forwarded-Encrypted: i=1; AHgh+RqHrB0MwhNek+Y6X88LbdeWhwBy6kQOadtmbqnSbSQ0CPXYPBfAgFw/ayRoYRLD9dKOuU88Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzehc/0oecTDYfS//WTx/zOGu78X93yQozZAXv2zd1uHbXgQxyR
	WLXt7sPMhUnr7B7d7D4333T9W5cHpUCtuig3Rv8WVCr8gUPHw3nwFBN5
X-Gm-Gg: AfdE7cmHx/eT7W7PppeOFwa7XkcRruZubDnXVDWi3KLOKN5qoHiPCDALp6b/2URbkWU
	rM8RqGz60+LDuEVUnEnsMpKlwRNMR9xumaPcD9Yk5Lq5Zfmy4w/teZAu0Gyu3lNxos9P4HF9kRC
	YdsRrWO/Zmj2g77vzWh0zKjsd/hWQQZWE3KBzICEI3kOUaV5XrCz5tdgU6yDiEmp6wt/ruooUrZ
	v/h14gYql9raONl9B5oROuL9AdWKDTCfJL4sWvd7TO/dBz8QjbSKKWhHm/FtA8N1yvW/nxOYJHA
	HDZPztEVJrmU9Mcm6XgiYgsT/+NUNu487+fyVgtu01yL3zIEB8P5PxgAXhlYuJSPCjywVGtKXqZ
	g6KQBxlh/uZO5+o+KClZ+t2ZQYV18zjhyGxntyEUBpC87QZslWMQQGQs3+bEjN8rdpzrr6ODBEa
	8Uq6PeugcfVlGevPE8Idk0i9hZHA==
X-Received: by 2002:a17:902:d58f:b0:2c9:fa31:850c with SMTP id d9443c01a7336-2ca2ea33e96mr19629385ad.39.1782805659205;
        Tue, 30 Jun 2026 00:47:39 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:38 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 01/10] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
Date: Tue, 30 Jun 2026 15:47:05 +0800
Message-ID: <20260630074715.4126796-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for an upcoming change that excludes non-dumpable reserved
regions from the kdump vmcore and will call crash_exclude_mem_range()
from generic, non-arch code.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/linux/crash_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..0033d4777648 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,6 +87,12 @@ static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
 static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
+static inline int crash_exclude_mem_range(struct crash_mem *mem,
+					  unsigned long long mstart,
+					  unsigned long long mend)
+{
+	return 0;
+}
 #endif /* CONFIG_CRASH_DUMP*/
 
 #ifdef CONFIG_CRASH_DM_CRYPT
-- 
2.43.0

