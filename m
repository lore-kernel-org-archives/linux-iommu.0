Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFC2EACE9
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705136; cv=none; b=FM7b/3Ib0iE9b60Eh7FtfLZ5s7v+BE/O0NSha/fBwgFOCr+vSZ5rAgHaltwz+fjRfZOSkD0vkUnKZnfpfG0J6O/3V9ckYss0Ir20WqI2GQM2t/OYsfuXkrbbYiSDEZHmNAVu1TYk4F2nt5q9Zy3QRn4ngO+FvPOWWzxWAlloQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705136; c=relaxed/simple;
	bh=hEllaWUDapEMGyxdObch3Q1AUPdojmO2+4mGzAGRdlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf2xU6bYp6kNS9ak16JKV0cicenFTPh1HfHE66/FTzUXCEG14Ehu6wGYe8zx5PomaA2MNHZyVRYNlE8SotRvYSqJTq8emoGm+g19YrRSfn0M4Zn80Mt75p3qrJdkGSriLYqWBp2VcyrOiWllOE50wMx0lV74l8SM1h9QsOsLBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa64OjlW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa64OjlW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so8553239a91.3
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705134; x=1762309934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUUL7svE/qO1mMkeybYnmgbSMQwYmeEBqJj7PT/8HRw=;
        b=fa64OjlWxfiiOKEdc6bWwtftBhyKEbJvO4utLstlDOBuaTWA6YqRaS49bQqk4M7Dyc
         ytyU9vwkgtdqrUh/PWiEQxm1BuaP7U2IN3zIvqijKH95ryaIC1RuZhKgO4ZcdeJJOUmX
         k0w35KDJBFn9OUG/VuM0OVfzh/IYmf1i6y1GVwZUeaC85XsOt2C60jq5EwmPsB2GIdLM
         o4poRJbZ5h5TGPFuPVDwpILErftncE9Xcn8Lf5h0Kzq2xCWxMCDdX+41ccmoJZ0GN8zU
         rnw+Mdh+8HwwOvnm8uTHsfq0I+dsVIFiW3MrEs/QlYDAhV+MAEPIq4rLIfseVv0NC3CQ
         j1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705134; x=1762309934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUUL7svE/qO1mMkeybYnmgbSMQwYmeEBqJj7PT/8HRw=;
        b=ewJFFNeS4cnZA6wMN0c7huaDSGUQ2yoRhScZpv2c5J4b+tt3d/+b01b9IYekY/xe7w
         IvnEvaN4tprOTXZGukZkCbAY2ubuSDigPEHTzdRQ5eYXl8+rW0l//7KvPUPjczB1Ep6c
         kkv8Kw/f05gt8BsN8SNH9vjz2/98/h+DL0pL2jXsg6dpN11Vr1lAYpTVsLqr2lI89yG6
         5bmYbfUJhtJY3mib1YqByemvpj1qAIlg/eTej7941xRPbq6Jd1f4RgOT4HMEUU62XAaU
         xnNmrpn16dikFvL5dvw1X64krNmWUU310MF2bqxw9tbGelz0xoYyqFLHNlWakqVbIJ58
         BGQA==
X-Forwarded-Encrypted: i=1; AJvYcCVnPeXg+APWPt6Ioqfd+B20/3r+56xP5iyZ5IoXWPoVYckhLPrL91Hll3RW4UZqhRir+ns7fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweN+5d1p5HYfIarZdhRuqzM78WIN/tGLBk+jxZKnzc25sR3UEC
	UDMwm13rWOis9yuaE5OCzn1u12GlzbJ+MQYrWkE78TzQ7ZJvWd/H9j1q
X-Gm-Gg: ASbGnctPHWMShz730Q3JmvsiyyMbjF352chpRpqO3gxWM6OkQxj7rpBCYazwWJjgNXF
	WixsRxYGUceCOfjFowfN5M9q/spF5fk4VzJrjWPGE2mfX04H4jMHX5DX53UzmDJ+0MqziT+N/q3
	FvucFFGcBP+J7FOqg4EGMnpUbaDKxFI8Ia4ER06/Bqp6MSrW86wWE3PuqHJ/b9c6kZIhg3ZfahW
	QFLkDcptcmTzv0GamfN34zDRvQonP+7FckX7M1tUQXQLKy6CFcGKykH6XjVdBDtZmia9iMzFcdy
	rprpSztUDEVPDeN9DXvuDsrDOpDeQ7BHSvZNQt5xf+BEzMrRz7gTQq3k6Y8S3boQFNGXT2M+Iyx
	wjk/8XZMgap1udpxjcyi8gkZcDSGEqRPzhZl4b1uewrQLtJdkzuSlvoesx4FUUhy9z2rfsOcqmH
	20SGS5eFDc+aUJgAQiL3IdXMktbuJG6BOF2HFkGXqlN9Xf5yLKwfzzsoNbhg==
X-Google-Smtp-Source: AGHT+IFvR7rogTcm5B+3ygGQw/lQVLBAuEII5+Xvx9q6E8V7+VzLsCmMzzmlIs3QIptMEm30AGJ2Ag==
X-Received: by 2002:a17:90b:384e:b0:339:9f7d:92d4 with SMTP id 98e67ed59e1d1-3403a265508mr1486973a91.9.1761705133912;
        Tue, 28 Oct 2025 19:32:13 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 3/5] arm64: Provide dcache_inval_poc_nosync helper
Date: Wed, 29 Oct 2025 10:31:13 +0800
Message-Id: <20251029023115.22809-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

dcache_inval_poc_nosync does not wait for the data cache invalidation to
complete. Later, we defer the synchronization so we can wait for all SG
entries together.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 43 +++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 9b6d0a62cf3d..382b4ac3734d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_inval_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 4a7c7e03785d..8c1043c9b9e5 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -132,17 +132,7 @@ alternative_else_nop_endif
 	ret
 SYM_FUNC_END(dcache_clean_pou)
 
-/*
- *	dcache_inval_poc(start, end)
- *
- * 	Ensure that any D-cache lines for the interval [start, end)
- * 	are invalidated. Any partial lines at the ends of the interval are
- *	also cleaned to PoC to prevent data loss.
- *
- *	- start   - kernel start address of region
- *	- end     - kernel end address of region
- */
-SYM_FUNC_START(__pi_dcache_inval_poc)
+.macro _dcache_inval_poc_impl, do_sync
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,11 +148,42 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
+.if \do_sync
 	dsb	sy
+.endif
 	ret
+.endm
+
+/*
+ *	dcache_inval_poc(start, end)
+ *
+ * 	Ensure that any D-cache lines for the interval [start, end)
+ * 	are invalidated. Any partial lines at the ends of the interval are
+ *	also cleaned to PoC to prevent data loss.
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc)
+	_dcache_inval_poc_impl 1
 SYM_FUNC_END(__pi_dcache_inval_poc)
 SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
+/*
+ *	dcache_inval_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end)
+ * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
+ *	sy later
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
+	_dcache_inval_poc_impl 0
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 
2.39.3 (Apple Git-146)

