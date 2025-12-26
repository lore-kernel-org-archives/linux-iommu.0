Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24452820C6
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789615; cv=none; b=nHmPTyRzxnVJCQ0iGMi175a/oT43NMJm6/pGog9bVLF/KX31PypsIXCeLWYibzL2Wy6JrF2+DqMonU9SKElJFASf4gILG64ng1+V4Roy1Eyx28hiCXpw7RnwWKvIDHyDwgtDM+hyrHgqjgBSmkzQnbUWeuaEKfIbAwXeOZ9KTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789615; c=relaxed/simple;
	bh=SYPssGIhYatri/BaiGbT+Fj74/Zx3I/RX0AzqBEd12w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJZnDDzjY7TBpwu16JcFgpltxDB3WpEL4YwU4ozXG1VCLrKojJDiGTQBPWdH9lnj0nNBM38/XQWQiICE4iweX1iDXOnQ8xGHwNw6dOom8pCLAyOlPXZ4dBXnJklsS2Ms6SqtqhX/ITKHo1nT8nQZvqIfUpSRypANtVxsWOLf/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHZdovan; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHZdovan"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a102494058so41715825ad.0
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789613; x=1767394413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ietD9HqJ7J3E+f0491dnZq0rlaTb/buis2UihkMu59I=;
        b=cHZdovanJ8WKT7JhNo6WSSZfTvQRZeuHJCzUCNbHouUwQ0jSoDgJX+Ebt5uLEGxPT9
         9jd3p8CoiH+5tj2QA4DIT/49FcVjyZg/pZd12JWry6Cw4ulkjyNJrjzVmTt+65vZn2GL
         +F64CYZ1n4SIh/Ia0kN8QgsC+atAQM3mzANG7C1HcKrnxNGk2R3ogJi9f+nfWQFh6BpC
         CFs5dOfmGtkAfcIoy1fS3ZmGWEyoQf9MnXIA1LBJ6iUSlEEQl9XrJ+qLrp3Uqd/2mRt5
         Q23Iq85+ngRadx6tVQ2Kyy4L17nlmWpaCIhkX2mYDIgX58Az3edOHRfSVDMTEsUbSzVf
         Q2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789613; x=1767394413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ietD9HqJ7J3E+f0491dnZq0rlaTb/buis2UihkMu59I=;
        b=eJCNMDbA3jM9eMYhbgPgUOElOYZxzCwslLfCO3giDNGSRToK4yR9N6QX3MNypgIe3G
         ia1l+oQw6NwKOxobW73N1+CfTvIpV0wVo//KBRsthhHQBy+Xi+ACvjkQmDPWyQvVcajz
         rZsClMYEWXJuM+XrNFkOpdHGdW+XxMhZu6+gL8sGEUlExXLuV9IU1SWDdP5QW7XZ4M3B
         SqtjfYE/p4YXLv8io3oQmWR1G5e2tqm3beYBicyJ+oC2h/R6PkBo6xMHXaM8sBVF25qp
         w/riOIa2V0jOPgFd/WYBiPLgKJafaJNeObc8c4E1d0CNsmLFSnwGyuknkWR+BagfQUxl
         p9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWatfdK7sCu4rCO5iA+8+8n5GnjUGzCTebyp4wZ2M4Pp2dPG2WxvtWxyyEhP1lUVEPfnh6gVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFRqVUmT12qPyIQI5p2SqtSKgyMBCklQE7El+vHrvtOvzYNbIO
	mQF7FmSqkRWYAsVdlK3RGjB8qmiz+0XcV+suU8FCpqdcSgqFHMCRNYB/
X-Gm-Gg: AY/fxX6KBfjl7ereE2/fz7ZlT8hsb+MhMyoBZk9icD5kojBrO9yZ1oFf2XS645qupPN
	dPnR+K6NIV2n+WURoWejZnnTsnq2dP/kXj0xeW8htiOYKbuGu2Ee6E0sMrPevWqHj8HyRWgMWsY
	tsQrwzfozjWZJzQWbERXgbxTZeux1YbEstTYHQ3PjXaVKIXvCyT4FW4RSSmd4bk4EI/1bkfI9S+
	M22vHew8zFw5ligMr9tgu1ScyWKfo8LxoR4aBi/MLiCjo2l4NLpAFUSbAc0SQUCu8MqXTcAwI+4
	KXuF9nie/qel1eg3WAdW1wXlvVJ2yjWRvpCGWhOBqaLJvRIc8uHphfSsBAI0tt4tywhsDIagALR
	1+RiI7xeRC95wBnScvvlqmwnnXyDZez+/mHS2qxXY8ZTIaO3OHkpzbKo8HybLSbRNqAZwEYFLmM
	w+7dHNKVrsKEpM
X-Google-Smtp-Source: AGHT+IE9oZQXckIJDcXvuEcMulX/ZaTRdgyK2lgHN5sr4Zh2/8KW3byPESPfAHlQDRzMXfnr9Ddibw==
X-Received: by 2002:a17:90b:2b46:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-34e90d6d322mr21171859a91.8.1766789612867;
        Fri, 26 Dec 2025 14:53:32 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:32 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH v2 2/8] arm64: Provide dcache_clean_poc_nosync helper
Date: Sat, 27 Dec 2025 11:52:42 +1300
Message-ID: <20251226225254.46197-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

dcache_clean_poc_nosync does not wait for the data cache clean to
complete. Later, we wait for completion of all scatter-gather entries
together.

Cc: Leon Romanovsky <leon@kernel.org>
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
Signed-off-by: Barry Song <baohua@kernel.org>
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
2.43.0

