Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6F3B27E3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268752; cv=none; b=LYW8vX/znwJC5X9OASS4laRP10inKuQsT1Zr2303wf9f4LkfzEfaEqlL9IQYZHhzWdjFrho2ID7M5SZOlk1XzxPMA7PMbS8llhmqiUsRG8uUmqujQDMrbxUUasjHhHrCoCSIXQVdOod5ZHzXHEj5SpO5UToL8KpSiMr1DIfdUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268752; c=relaxed/simple;
	bh=hg5xbWLp3AkSvJFbtRJektVz3soiPhwBudcg+chCZNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7zLUbS2hpAkl2mrAZYnJ4GgpIO7iQdJf9zdbrdZ2hP5RGk9NpOMUGmqltpCOYazlkI/N85BeJ6AQVdqrXcfmIBJ9oackASygVfz45COCwVhfAXD89swBEL1E8FaDjoSa4ZOrRFHSXbU968HfNHeC4XqpiIvQraXtt/RGNvHGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou9pmjuc; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou9pmjuc"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c795f441ff7so3725015a12.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268751; x=1779873551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlJTNnuSEkuOFcK//QE/3Ty9SdRnFwE8BVFotGGF+Qo=;
        b=Ou9pmjucm1isECljPDh7LMfIDC4q4xinneeJ6NATloQidXUFaJ7L97R2QYMkgOHU2Y
         Ic5j3+JSeNXpBUOei/sUT1j6KGtWl/HN5D/FlWoInyGHNEbgAPk0bYmx5NHeQTU2/ZxT
         udWRwCh3O0EdSm9EEAf2osV05jdwoe4cwpIJrW137jtFTlkUaDz4WaX0qHDLo3Or0UIc
         8KxHP79alfbX4F0lPtrqpwIc0CrNAURLEP7QKKG4nplx/vxJeuk6e5XkGLYjidpOBt6i
         VbutXzrF00+xEJl+nri9PwhdmzzeYo/MMubLdJkwaGzkHsCJGxqaRsFzbkmE9X5WKQnx
         2wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268751; x=1779873551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlJTNnuSEkuOFcK//QE/3Ty9SdRnFwE8BVFotGGF+Qo=;
        b=m0s2kNQLcXcLkw1indDz3/vHcn8dEQov3D6oxoP6SVxTc/6WkxLXYsI3voQTrNOGpY
         RojHiPjGbhnLKZ49CS5rxqx3Uk/QJSXLXGsiIEaUMPM/uSD2x/OnLTkmHMEXAs/6Viw5
         UuXwJDciS8Ie4TxjNBM25RcGMAXDZhxBvwBn3M6G9z4l5uMOZw8uVR7Rehnf6FPXh+4i
         uveeD9FLeN25lAlr3edEjvTqEIDNo8DbUmqLTLd2AYbQimK/C+0m/CTTOa2OJdBv1dek
         u3WurgMfM4RAoyXNF7lW0OgBbnuFPtUrlQfnYG8e4Y4jJ84rp3gbH+bcbMvaa+iyVOJK
         Ce9w==
X-Forwarded-Encrypted: i=1; AFNElJ++SIQ+uSf6Hpi5Anb/kmuE5oDPegjV2lIPXow92WEAwHfEIrA5yd90gM1ySzgsySe5hoLGIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9IR7fRgXHp4lhMsSRQcPUMHE0rqh1gTCP79Jkn1R4al6LQK0G
	uTOFqyweJeyAJTeIEacMixikbX8ty4fXFXF8/2cMTMNlTRVeb8p8SONF
X-Gm-Gg: Acq92OFJ8J/VX9M2ycyXdvXLMCIdETA9nRE41AR/nxndKlVD2kF0JlVl1KzkJzRaOsr
	r3hn8UfbLBoasZY0vWFTXmEdYt62ucBr5mfLy0lmQIURIhxzAZ5fLxgYVNu1CWEAARpwdYFz2Ng
	0apfMtko12FKsO+D/Yv1ZNGx2j82m8WVP6VH3uMgyFE4DusuUIlzNJzzqMyDpEcIOfFYbIJq+xL
	XnAy+GCNFTYM3+voRcGUo39g6Ge41kJTFSt0Qq2Z8H2FmJUan2OzsNQkwsKgMxF5aRh26naq3/y
	AZDbLWW4034abltmlnRiTo9E04TVSROO/DOjub6LT9fKNfzLz6swdI9rrJZS1t1+kh2g/rGOM3R
	PWYIq7EWi07wtMkqlYMq+5SNtVNPStT8W08iKfVg+3Txe1JK2GE3pJO1AIC3hGrfD6a5wN5TfKe
	dG1RFwjTI4pDkjAzFoSGRDhkUsnePhPS9p1jLYAQ==
X-Received: by 2002:a05:6a20:2454:b0:3aa:ec28:edc6 with SMTP id adf61e73a8af0-3b22ec63eaamr26158763637.39.1779268750848;
        Wed, 20 May 2026 02:19:10 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:10 -0700 (PDT)
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
Subject: [PATCH v2 1/8] of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
Date: Wed, 20 May 2026 17:18:37 +0800
Message-ID: <20260520091844.592753-2-chenwandun@lixiang.com>
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

Prepare for an upcoming change that appends /memreserve/ entries to
reserved_mem[]; such entries have no name.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8d5777cb5d1b..313cbc57aa45 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -788,7 +788,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 
 	name = kbasename(np->full_name);
 	for (i = 0; i < reserved_mem_count; i++)
-		if (!strcmp(reserved_mem[i].name, name))
+		if (reserved_mem[i].name &&
+		    !strcmp(reserved_mem[i].name, name))
 			return &reserved_mem[i];
 
 	return NULL;
-- 
2.43.0

