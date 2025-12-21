Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB223E330
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766303977; cv=none; b=EKJJedhh/muVO6RC8OczXZNPG4+fiMZZqwx/cjfCZLL2i1zJWmnZFm+60iVaKMy6zUDIpffJ+HDwrolKJrJLukmpzY4P+Qh3SIIfukAXuvAW29ibd4jUft4iGPSWkF58P/zY7My2olHnRSlMmm1y3R+XpNcF+5wRQ2GspAgLJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766303977; c=relaxed/simple;
	bh=9iqU47HwUFw+q8Ryl8E6TxFaeg1hA6ZdUv9syUfDYnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EImCeMwJ0kNWLQcYUBP7NJ7ake2FmsWGKNYqcb47e7p5KbxP14AbVSKJRBEPrYHrrotmRCkx6BKetqi+pDZSv9y9GRYoQeokcaoyRkCceQLjGpUkU5Aur/kx67MpZxaKQh9ShPwnsSmPb602m8rMAwiQRdLdWJETi5DUlMptpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjT2m28I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjT2m28I"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d0788adaso26698305ad.3
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 23:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766303975; x=1766908775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ/i3gg2RhHrVi7oTjeMCjSkh1TUB3W9zVzP6Ymc1nU=;
        b=MjT2m28IYx9lWUdVOtIhDBZTClE8E5Dhk7pUAsZ2rDhLo7bSaIebDyYDUZk5D/GCXj
         klvE+JSlNLGpjsWd/L2Yidg7e2a2o7SUclZBgNAxNikZviBJIcB4CxIlxJ/hyyJWubhJ
         WWV/B23w2ba02/yqMKeN8d+qcRrUQz6rOQHPxJprhQDAz0yTTyLN5y1SJomrVZDNmPHO
         wOyBMHaCdgkjDbGaIJLnOLK1NpjpgSVKgtH7iLqDBTr2EbVzm9sC/xPjndreNEkjPNCm
         s7v0KdRd/6oiFo/sdWz+waxb/voVu37Cy+l8rdv15EyX6sfNZlz4a9Gk4JmsxtJzVMRz
         r8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766303975; x=1766908775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQ/i3gg2RhHrVi7oTjeMCjSkh1TUB3W9zVzP6Ymc1nU=;
        b=D0M8ejKBR4WqNq27mqrpHV1LhTl5dwe1GFT5oVpyBfVZ0+MjZpBgDcfuSXgFFgAt8+
         osnx6xggwSXDaE/Am5lln6VRN0h2VwTbPrsqb8vsgoYv82D7/HhOQLuBUyrjEd9AVmwa
         SJ/pPfT9A7Da6yUjY+LFqgO/XxHhYmH4MyMm+gnQe80GWF+ylf7GqSrd+beraGbpJaZ8
         ecNmCpj5uLvN34yivVpJXpKtZ43cNn5PBrKqWhCcL3zhW88mg+PHXchau+KLFMPATXP4
         i/o5+jhgwEF8wLz/Gfi4rXnZfS2ffOnu1Xp4Iv+35XuCUqPmEHYPrP3vucPGm9X/cV1O
         LvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLack6BkMS2ZpWaV2a/dIapc5fDhHV+yhpMiXljaoLHR5Mp4PCWl7ShDOBsDa7xpaKHfIhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkgO8xSEhGrKivTe3BeRrp5FxZplCGEgs4S0njZqIwWjAfKHn8
	xboJLiXfF8uYJkndCNeISkUrfZTxEdp39O8BWSM6kWAHkJHn8D2NxL22
X-Gm-Gg: AY/fxX62TARX8S+TcnCWs3PWLoFDGWzIraS+9mRGa7bh8Q/WTazcUkzEEiqkd7sbii4
	/PlyrZqj/s1kHFp7DYO1dz0q6YA8GOD9wtSOzi3n68uWo2YStBSwpERveBXEuCDT3iU/diSyDJK
	AAo7arzP0L5AZ56g3EfV7TbOoGMmXSwvGhAmH6FEXoXYJs0GnatwhC/SCweRdZZBAltto8N2xAD
	UAjIOcDQkoeL9kXqhJY+1SscJhA4gmoIWPyKOuSIyOOcHEtZiV9Z7pOYKvWnN2iPdXTSJNdADkU
	TlUF6hpJpNdW1s8AyJ/0v6raADzY0xR0LNmtAmwC+E/R0GhWsO7cbJLf96JHo3Cw1VFehfLDdlW
	HxQyX9fQaLSJsrBpfyI0BGvjma0b+r/HAaQep8nR9+uu/GOdd0xg9fS27gDYcBPzMnHS43D/deM
	sNG7G4gDBNOzYnv3B5UBQEh/Cn
X-Google-Smtp-Source: AGHT+IGvott4j8QweZbGuwsDW70w3ULSK0vaWfXBfaowVt0tvY9dm8J5MiuZ3H4ez82g05E/xhvWJw==
X-Received: by 2002:a17:903:b83:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2a2f222bc6amr78335135ad.18.1766303974903;
        Sat, 20 Dec 2025 23:59:34 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fdesm6226424a12.8.2025.12.20.23.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Dec 2025 23:59:34 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: robin.murphy@arm.com
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com,
	maz@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: [PATCH 3/6] arm64: Provide dcache_inval_poc_nosync helper
Date: Sun, 21 Dec 2025 15:59:25 +0800
Message-Id: <20251221075925.65445-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <99bb1797-06ba-440d-b173-db62d5f54e08@arm.com>
References: <99bb1797-06ba-440d-b173-db62d5f54e08@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Dec 19, 2025 at 8:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
[...]
> > diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> > index 4a7c7e03785d..8c1043c9b9e5 100644
> > --- a/arch/arm64/mm/cache.S
> > +++ b/arch/arm64/mm/cache.S
> > @@ -132,17 +132,7 @@ alternative_else_nop_endif
> >       ret
> >   SYM_FUNC_END(dcache_clean_pou)
> >  
> > -/*
> > - *   dcache_inval_poc(start, end)
> > - *
> > - *   Ensure that any D-cache lines for the interval [start, end)
> > - *   are invalidated. Any partial lines at the ends of the interval are
> > - *   also cleaned to PoC to prevent data loss.
> > - *
> > - *   - start   - kernel start address of region
> > - *   - end     - kernel end address of region
> > - */
> > -SYM_FUNC_START(__pi_dcache_inval_poc)
> > +.macro _dcache_inval_poc_impl, do_sync
> >       dcache_line_size x2, x3
> >       sub     x3, x2, #1
> >       tst     x1, x3                          // end cache line aligned?
> > @@ -158,11 +148,42 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
> >   3:  add     x0, x0, x2
> >       cmp     x0, x1
> >       b.lo    2b
> > +.if \do_sync
> >       dsb     sy
> > +.endif
>
> Similarly, don't bother with complication like this, just put the DSB in
> the one place it needs to be.
>

Thanks, Robin — great suggestion. I assume it can be:

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 4a7c7e03785d..99a093d3aecb 100644
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
+.macro raw_dcache_inval_poc_macro
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,11 +148,41 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
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
+	raw_dcache_inval_poc_macro
 	dsb	sy
 	ret
 SYM_FUNC_END(__pi_dcache_inval_poc)
 SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
+/*
+ *	dcache_inval_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end)
+ * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
+ *	sy is issued later
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
+	raw_dcache_inval_poc_macro
+	ret
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 

Does it look good to you?

Thanks
Barry
