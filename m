Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1F7D412
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818961; cv=none; b=TeCWu4/ysaXmNDbekkAQ6/rbXDusaWhI6uqXcBoHTu1aIkgMeFP3jRS3tpGLdENl40J0TUzXSrKu9Hqoyw4g5fMSLaATJDX5/At14p4BEXSXBXPLjhjaBKXPYNFia19a6PyIX+fZE+N9omdW+xjf/9VH0keyXTw2RwzYeod76dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818961; c=relaxed/simple;
	bh=ud4FVBvixmqybTJpkYMtIYJPy3IRXCt7ASTyNTFo0Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ep0LaarZajXHEtVN4HpkpSixoTD1FEkVroawSmbmbc7R6ULhF1V8L3fPEgSwO5AaeXoVa+khUuOghZ/pbAvnj6CkzVX3jM+vxQZgMf8O5Eqefqxml2oYbs4RPJm7UIgc/J0mLwEeO10PE5ma/U0CKNzjlDq/vFXqIwieUGEzsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XscqVduP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XscqVduP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706a4a04891so1499488b3a.3
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719818958; x=1720423758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGhqSiLMzxESl6q2TXeHQ+QtaRhhPlHzzW1Ik7jwLak=;
        b=XscqVduP4WTEWAyPoE3b6ZwhLT+GwI9w5XnRyRFD2ew8cDwdKzdKT1Zz2vumg9Wli2
         xmElZZ5lr/6ycq8vmXxSm0BDsM4xwPsoziKqXsdjTdzo4iMLNb8JeHJ3Wuol3q8nPrPX
         LX+lpObNsMYjr6ZxyZEusvVZdl4Q6ah8eIMHAWIELRrZ+wd8Yew+tJ1UplXXKBrRMKvs
         PhbVaZSbt4QvvUxYlW8Ae+HWP5EsQP8XwN8R9VKm3OhElC/DiRLeCmAdW3OAF17qNrkd
         6QidteB6YiArOzKk8QBzQtMKhIukvzLUCwov3bWHaqaDqk9QyFZob5K/zDm8fsX9kvGo
         DKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818958; x=1720423758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGhqSiLMzxESl6q2TXeHQ+QtaRhhPlHzzW1Ik7jwLak=;
        b=IvQqvsJtm1ARWp2YBWIY6GtzTgieH63SGeC7w0Yx5iaTkThN1SkW27vDC54fS3XYba
         FNaIf7vmmhz+KaDAsCFnjoT0ez65BqD5FiZrEnGAuTrvnekA77wOuoC7KKlRQ6Z4qCrT
         9My24qiSVbarb7Lh6C06RpEKAdRfR4rC7RLp1IlE0ZumFVCRFzfs/kz+qOpMVlR+GuSh
         eG6Ef60RtR6npBda2ml8ByzNtaP62I1ptskzWBes8jRRUi93xYJXil+6TEJTHYM1wxDV
         9y0FNsqT0QSe+0yGoE3q9tM66yop7mxzZ5k5tAhTAYFnYWS6wFyvfXDJatbW7bBNmTs+
         5SnA==
X-Forwarded-Encrypted: i=1; AJvYcCV2fvNPkOT2sPhhmmbuHJFklm3bQ55HbePlm8e3GA5Xoo0WcBgGqoK8iJK4W/7K0BBrL3+/Ybiso4NmnRi9S/T+JR2phY4=
X-Gm-Message-State: AOJu0YxSqjpPjzsDfJlsU8sJ/Fa+3UtFpEjQn6QdYSVD39vZjHpAEGgJ
	nm9ehHk+VwN4lH5qQDVW/6zfxYct9jta5QaxxkHyyryTzXJHiQ/y/F8e9rWGODo=
X-Google-Smtp-Source: AGHT+IGMGQElpf9p3wHiQ0XgC52tuI2eBaue5vhEMaYrPXb1lA2D7IhLm40/sZqFmLeQyKwdlN8PBw==
X-Received: by 2002:a05:6a00:1909:b0:704:31ae:4fe5 with SMTP id d2e1a72fcca58-70aaaf25245mr3686034b3a.25.1719818958046;
        Mon, 01 Jul 2024 00:29:18 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf757sm5779337b3a.104.2024.07.01.00.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 00:29:17 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	sunilvl@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	baolu.lu@linux.intel.com,
	lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 0/1] iommu/riscv: Support sharing irq lines between iommu queues
Date: Mon,  1 Jul 2024 15:29:07 +0800
Message-Id: <20240701072908.25503-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an additional patch for Tomasz Jeznach's riscv iommu driver
patch series[1].

It seems that when the number of wired irq lines is less than the number
of iommu queues, iommu platform driver does not assign virtual irqs for
iommu queues whose id exceeds the total number of irq lines.

If it is a problem worth fixing, please feel free to merge this patch
into existing commits. And please ignore this patch if we don't think
it is a problem.

[1] link: https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/

Xu Lu (1):
  iommu/riscv: Support sharing irq lines between iommu queues

 drivers/iommu/riscv/iommu-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.20.1

