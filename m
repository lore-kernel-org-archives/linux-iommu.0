Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AA1411DE
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705129; cv=none; b=LDT/OtejbMakJ6R9J0db27ZORkAm6xiQiP48xmrrg3i14CBO/WlYishMP8y9HuFEyQrUtehPtcxZ5VxmGqu0yVa84iFpI9sFOa7n/Yf8fezuprcZXrtEMrpUjo3X1cR7pFAVrEyrCVGv/8dxP74YBKhU68ktgEEINIMETfZqJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705129; c=relaxed/simple;
	bh=zYNJmlon8r/JHG3Xpn9ntElzz/UgGYjwUNixebL2tkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcyXCoNSBhui26SoEP24BUuRLgF9kG+2ghotrZzsWE6pEy9vxHzkyYgdi6oOYdYnErChqbqALukXa5YVxuwkw9TYavZClRrmZTx32HUe/8lsetI8SpLEeu2EwwN0dm5plgK0J+U53WxIFXAPDvKsf7vPT/AfMGjNgoidV6S5ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDk9UaYO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDk9UaYO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340299fe579so1922104a91.2
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705127; x=1762309927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6qoeYX7P7dZob4Bvz9VKgpFSbzrkhmCImjfBPhgn1s=;
        b=fDk9UaYOFkQq3RXvyR/MDiIav/OD8Waj69iO9XF1MO9Y8FKDvUDlUudHG3tbBXptbp
         KLMwNgHePu+x2rulb2aqF+yRNz++p3eOl82RFHwKfiZJ+h11cfDPJSmcrBB9kBV80VL6
         C8pMgDZ5pDEumHioBrVDMqpqkcHO0YTazChfOzExSQKFKkjskEQSZdXdjFVay6qln9kw
         TMZLGRmv9tznhjyNrsAxbW5D4nILZ1tD33DY+exoesmR2M817kqiZXME9xmLO/ZosIRX
         jZIxqzRpaXhqiXQnJtsWPWJP09exR+e2C/BsHb2umWTsgtYpYhAQs8r+oPp9DEnoDAGp
         Yasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705127; x=1762309927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6qoeYX7P7dZob4Bvz9VKgpFSbzrkhmCImjfBPhgn1s=;
        b=A8CUCRk5ONbsazvFKXKOdrMMo5nXet9QF/bMvjQd82PVV3tViqZGworUWuiHzHbbiG
         g6ON0C9REH3V/9Ib+kdjSlRyFQ+ia33v8w+F+OXP1rfzoJIkarJQOtYZyGhl+zGPZKa1
         HSIcH+PqTFc0yCCIf7kyVA6FPzzV0G4QrPAjQw/cPtSofzzGuJgI7tII3KmNeBqiJU+9
         B7CesGrHBO+0X3LmCxk7Y8jBhb69JjjlmtvIqEU63DJ7O2D74bX5IYeY1cQaujm4kTvR
         3mW8Dr7F4Bpmx+q5qEC9qs9NbHLNTQfeVxRtWxXPtvg0naXjLbWLnnBbz75UH/sOy0Eo
         rLrw==
X-Forwarded-Encrypted: i=1; AJvYcCUrnFRB9mpsKBhQcTcxGOUlwP0QjBy66iF2JW7keMQ1zFuBftkZKyho7zJt6vdAxNSO+uoAvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4nnuOCi0SPK5mHEwa5X6vT+BHH/MDPoC+l/Tk3I6TcAYhqNT7
	lfKDTijUzs6MHMVpAwZjmTGPDjEn/0kv2eArd/+NxPpCefvdgeiMQ8Se
X-Gm-Gg: ASbGncsiij/BftpLyP7t2bviDzyn4ooP75T2e8VT1QXfxgIyjXKeKUaG2V3H2C6YfCo
	v4mkDt4e8xo+RKMueMVfXYJNAKaROid3yPyEe7htOdtfop6mqXecs69/+pDtuh9xcRlgbfXugLq
	1ilfn3+8VyJn1+FbtxRP9ZUKrEeBWTiRkHwP7MBHMQv8DPgFlnkEwSYdfhN2uWLSxQUSfcMk+k2
	E34w0owGi4lG8d5kXfic0X2JRJBjmpotCXnQIenIBsaJ+S8V84DT1c/a/x35HI8cFYgpkxB0KVC
	cMaXfn3ox2usXQKTfiayxBZfoUXaUXmqV/6PPt3f57x0EU6yJStaeNdJ/XaQytbhwmj79r3sT7i
	+jR81Y2CUBVOXNchfkHE9K/IQOQ7rRFNUYIltknfgOalyA7/D4POUkVmoh8edbGimN7aOwfiUDR
	nzEiHuNPg6FEYw2r1ca/UbkSqeDfCSW1PdRUrJD7tz8BVrG1TIIQ5cWfLUIw==
X-Google-Smtp-Source: AGHT+IELIohm+a85sePD0UFgSVnJbmnjewzzZy+ustTJJxjo6UFTuJaxy6bk5m8Cbv3z6kHyDqZwZg==
X-Received: by 2002:a17:90b:5285:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-3403a15d171mr1418626a91.1.1761705126491;
        Tue, 28 Oct 2025 19:32:06 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:05 -0700 (PDT)
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
Subject: [RFC PATCH 2/5] arm64: Provide dcache_clean_poc_nosync helper
Date: Wed, 29 Oct 2025 10:31:12 +0800
Message-Id: <20251029023115.22809-3-21cnbao@gmail.com>
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

dcache_clean_poc_nosync does not wait for the data cache clean to
complete. Later, we wait for completion of all scatter-gather entries
together.

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
 arch/arm64/mm/cache.S               | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 28ab96e808ef..9b6d0a62cf3d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
 extern long caches_clean_inval_user_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 503567c864fd..4a7c7e03785d 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -178,6 +178,21 @@ SYM_FUNC_START(__pi_dcache_clean_poc)
 SYM_FUNC_END(__pi_dcache_clean_poc)
 SYM_FUNC_ALIAS(dcache_clean_poc, __pi_dcache_clean_poc)
 
+/*
+ *	dcache_clean_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end).
+ * 	not necessarily cleaned to the PoC till an explicit dsb sy afterward.
+ *
+ *	- start   - virtual start address of region
+ *	- end     - virtual end address of region
+ */
+SYM_FUNC_START(__pi_dcache_clean_poc_nosync)
+	dcache_by_line_op_nosync cvac, x0, x1, x2, x3
+	ret
+SYM_FUNC_END(__pi_dcache_clean_poc_nosync)
+SYM_FUNC_ALIAS(dcache_clean_poc_nosync, __pi_dcache_clean_poc_nosync)
+
 /*
  *	dcache_clean_pop(start, end)
  *
-- 
2.39.3 (Apple Git-146)

