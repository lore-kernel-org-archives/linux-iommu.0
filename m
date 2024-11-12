Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E07080C
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418509; cv=none; b=KmZjlbcOE60VzB4YFrEGJwiz9vGat4aU+77khkOnLT3azSRsmIhh7i0hVNe4jLHCdrCXBVZjI+zatj9ieJKWOZQUYfOtPRZPh6fdj8Sy0C3xR7lcoahmdz2y4ktNqDH3SRjFJ106BjDgSew/i9uh8+9YSAGrhs4wbRMTN+3j/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418509; c=relaxed/simple;
	bh=0mPjhSL26w+LsyPhnE05ElP18HK9dq75k99u1Eiz77A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kC0vLnuiFUb98HT7bo+Y1yQkqhLpXcZ4wRZ/SeqNc389GXasdk3vwLmkG1vFbTXXCTj31hzL0zeDCUg42OczKmHuJLNC0TWxsgc9rM3wiAja59ZyTNdAiSCo6616HZcIWDVfCR4N/BKeV5TKK2v2T3oiZV/j/z9qGpG9S/0MU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZEmkzF/p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZEmkzF/p"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3338391f8f.1
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731418506; x=1732023306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4uQtM40V/AAVLWbsCcG0T8laTlDVPnv9JhUGANTkL8=;
        b=ZEmkzF/p+6oScUSSDDAAOFltfhuDEXvFYefIMw4ziJNOR1vC/ouw6i4f6w4JoMaYQE
         C0Kqlgo3Zh8ZvdToYIoWC2JW0wpQEfSkFFANUhFeClKt+Wyg5pki2WuqXTOw7XkhX8Rg
         fWF84ep/8lf2dMhjfU0YnlXZAhRhvRe8ujwMqcPeBOF2u4aiq2wuWLGDQxV7NXv7HpUE
         AjJm3UKvAcmp1t4TuZElwet72tBrJhSWJOM0K2f+SZcDedieUJaUfBueaZodDmgO+2jw
         7qVftPj+k4K+FVA3UW1Dqdbs/kdUmM12BW5hw96vpJ7f+QXn9cIz7L2ptlQjV8Z3ucxG
         IBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418506; x=1732023306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4uQtM40V/AAVLWbsCcG0T8laTlDVPnv9JhUGANTkL8=;
        b=S6GkwgvhpTEJ1ppl851UzFPFDHwB8RRE2rGij36UCU+mkqeFtHLorT9QZLOOdZ4v/i
         N9Vy6QLo2VVaylZ6K0pQM6vHBg1/oU/0kWOTosOYNk/IdBuEVuJV51EHGzwLJVwaPYaz
         GLOwnxMTPmDOwyHfxZPiH2IKB9UQaSvH5TX5Ihwcg33CPSrsJyjARsuqc8rjmrVZce2d
         3HYBT9QuFTUj3Hpwk0RaMfvDod7IRsqxUSLvdZCi2h3vDd5flHb1cSKzm6L+UhfX+hxZ
         +lalICICwQ/je/bVYoqaYOtzuo3I6joY57caQ9rc2P9cQ7me2uuCjhy2K55/CUc+v96e
         0PuQ==
X-Gm-Message-State: AOJu0YzWDzguyj9ciJ7Q9txmMhG7IhRWmkLY/5OsZE/NGW8nF9Mij50b
	LS6jv7x6U7GRMsyv62iiBvLwTMdEPSVxa19RXLYj1VQ0Ko/o8do6c34hYYBN785OoDSl9+lfGaX
	COgw=
X-Google-Smtp-Source: AGHT+IHajeEER9F/q9qF7Wuph7Bji0x5a6RbiRsxvGe2BTVs4+IoqQQ9y3jR5ZA7i/VSAcSTGyez7g==
X-Received: by 2002:a5d:6dab:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-381f186b53cmr14933265f8f.23.1731418505982;
        Tue, 12 Nov 2024 05:35:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b3611sm241640655e9.13.2024.11.12.05.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:35:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	samuel.holland@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH v2 0/1] iommu/riscv: Add platform msi support
Date: Tue, 12 Nov 2024 14:35:05 +0100
Message-ID: <20241112133504.491984-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MSI support for a platform IOMMU. May be tested with QEMU when
including [1].

Based on linux-next commit 28955f4fa282 ("Add linux-next specific files for 20241112")

[1] https://lore.kernel.org/all/20241106133407.604587-1-dbarboza@ventanamicro.com/

v2:
 - Dropped patch1 of the v1 series since it wasn't necessary [Tomasz]
 - Improved error/warning messages [Samuel]

Andrew Jones (1):
  iommu/riscv: Add support for platform msi

 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

-- 
2.47.0

