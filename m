Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F063B27E3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268762; cv=none; b=IIVq949wD+RwCcuHWbyzAhbfAYGjQDHeJ4ZOJGd+tW4/c+q1FUQaOwsSPTc5GsFFlYyxDvwbOjvNSeKovBhNA4zjQZCQ2ei8JBVrJr2WBOpgXfCxczT+tigusyGHrYogOLFXlEqxaVXJeOl+UdpXKect1qCunRhgCTS7gJ8O6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268762; c=relaxed/simple;
	bh=1mrJpHLdgZoQ9z8hnMeKjo6Nk1qat8gxfyVXkzyrD20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUVHRM0xiTz7S+rf82IV6B0HuusCCHO4lfl4nUHDC9HkKS7f0qiCwcSkfKqOCd8aJgaMXDhGWyVi8kBylOm2HY2d0mhRP814RGWOd6384xi/12Nz2yFru/kZv517ZdBkPCDRwJlgs4ircwQW9ti91Mq3u3PwWu+Myw1bg7D8vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW7TwHst; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW7TwHst"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82faf871346so3619843b3a.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268761; x=1779873561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oyw9vanLGG7tQ9dBSW9pJHSWXBGqZj5GxnQmef6pVg=;
        b=IW7TwHstsLxD5PX7oqIcKK4mYMTQRV7+gHNRLF7ptJI3fF0vyd6hlSEGfE+EkhYu7Z
         UdBbxlntS8gGBNfSnH3i/nU7CVM0oWs0EHQpSy3vIgU3rZeo6MHPKR+JKRNj8JDoXC6Z
         q+4wevnI5MhRRAU5FlMdZaSuRrOQF/idA7Z8MX+58mzkOMhpG7bNbRWlKKUZ2xizC2Ru
         XQ9QOg7px4Zncno/RP1xGmsWlT6PxH2r/xk99otTqE1iE7AHYZ7ByVSSKQQYbwMe5I7c
         upSHjXrJuWPULjTRO+WXjPoyFZwcWobTxFEpd4J6CcaVSOK7cT7KwQrlicxzXZsYXCp9
         ATpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268761; x=1779873561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9oyw9vanLGG7tQ9dBSW9pJHSWXBGqZj5GxnQmef6pVg=;
        b=IQi+UrDK3FC3IN+2Ymtutmhgr/4AeFx5D0OZFqBChu5tx8pDZKvD6lOT2Eir7ks0Mx
         +N7fqalFTwMqcGkxGwEjn4IPWM54+8c7614lFgK62P7K/OsrWi7ZAdt886zXIa3AwHRg
         EUGwV/nsjEP/A21UwoCfkbGeEqaiSyvBexLnmnf+1gPkRS9MEh8UUqVWRnl7EWNVIfxJ
         TuUEHF1SBfdMJZibkLxWaxCG1qtqO3Xdtfxut502sUF6xgIoaAkwzZSWt64OWQ8LcWwJ
         gyKe/JJbl9RWdxhUo7Sgy9mdDjjNCCeHxyX6WBheA5wAyCr4P71W4uio0epIKKRWjJ17
         du+g==
X-Forwarded-Encrypted: i=1; AFNElJ81RlGGO37QlH8807WeREnBb9GFzO0kFFSKxCM5tTudF3LvFilGTNgNMkAJ21bHJ2pem23mkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3DERtvC9Cc4Vx3+aQQOKoTfqzR2TYttq2H+96P5APyJ/nEfVf
	ubN/bh/C6Ft39OrjkY4tGdDwfitWxFJXTrRfaKi+X1Kmp9N4FJKTlf90
X-Gm-Gg: Acq92OGI3ntO2FYnzBuMM5yXnXDt+U+GUIM3AsFSdDmMLVpsqfFL+P5ehwsP0kKyZi+
	2o9OILQcEv3E24sLroAj3YUZ08CLAam3E0PZ3pXUMMHKVYgdJI+FkuO9xzhek7tC0XIUHDVmYaN
	kzPFi5O6fiXyP9fI1UZQS/k6zcAsfTfpBwVm9kBp1FmMrHmfinqHIfZw5T1CmvMd4WJ5V1Bmoln
	ymmv4QsfbczrJ88RSqqZBJ3JTa0kk9kMluS2W/FSEpqTQ/1+kMY4SU7KforQqYS1SGGcXnD+fFf
	2gmS6RvMEky0krDMGVhIp/yPDUHhDhxS3MV9QATpBfjomEwxHEIY7lORsrlq8PmY4IHwgJMbyU8
	mQXmL4aQDuzNbPxobSpAj7hAAPqrlF+vLyW+ItCLrx33ezcsUuDPLX74EMriWGlPvAgaSar/GLk
	gRZcJWTV5Ymk9FLYekUoSrTBDIPUnEXULLW1xZog==
X-Received: by 2002:a05:6a00:3289:b0:82a:7aa3:a2fb with SMTP id d2e1a72fcca58-83f33c9b2dcmr22248125b3a.37.1779268761111;
        Wed, 20 May 2026 02:19:21 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:20 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 2/8] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
Date: Wed, 20 May 2026 17:18:38 +0800
Message-ID: <20260520091844.592753-3-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun1@gmail.com>

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

