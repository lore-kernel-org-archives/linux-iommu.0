Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB012036E2
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915467; cv=none; b=QYeNVTQO0BYig7E1Q3h1nRl9H0KdY1gByl/ceTZcW6wSfPDdKY9AYXh3eifHp8yeEKBylILxOHSIW14m0oEZ/wcvq9uqZm4uY5U4Bom0Hy6/WAIhlD1x+utZKUPobKD7NwltWI5ZEC/pI589ua1CDULByeHedaxUpT16Q/kbwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915467; c=relaxed/simple;
	bh=AmNubWSFsMbGUCbqMjD6qzHq7thjNbyHZT8pPh3Hg6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbmZWt9hIJmKfC/JvqlZonTPkNN14Ke3XCfWgvdhHFhvDJNCniFFnsm6e1bIuVClftAhERL7+WkGQOEg8ujKwuacHyPPSUFivUFKIJ+rJI8AtXfjMp6MtThjeOmF7vjyVPoN9Nj20rAyFGzLWsmde6fsJKv0F4NcMpMVbtNkrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a3Ed/VsU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a3Ed/VsU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so22099a12.0
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730915464; x=1731520264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVcjUYi+p2tO+HyWvtxM4cA353hNsNdE371FkKVPyL4=;
        b=a3Ed/VsURBfkPKljMhnszAiZiTb27z53M0sat8yjA6GxWbDWbVGdmZz4A4iVw5gJDf
         z5lVTfInHlOc4VnfcLJe2gYFdJxDv8p0cjZ4MZgRFdqpmMwaGpIII0GLMHPeZ4G2L70c
         vwrrtwT0HUn0pkJFazN7SqmJGYB4GPWSugC+Ecyacsxji/y0b1ft3zT76T7DoCwswvH/
         Away4ucq44RIXIUhRoCxDPr1R4LSrlYKodoAw63LIXv/c9m6iErVnKRL/5vJxy8QKBIF
         MNkG/n47DT7sjVu5acRIUWNe9ocRh3+CvFlfA9tUDwTp7SEEwre6xa5HzgASYu6V+MBG
         +/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915464; x=1731520264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVcjUYi+p2tO+HyWvtxM4cA353hNsNdE371FkKVPyL4=;
        b=ZOo9uZpCu8osdjGJqP5wznzsE77MAe4MUa8Esq4l8hSeBySJRiMYJ5OZamIv+IWaKm
         1H9Qxw+Ze6F6nI6N0Ve98Yoo4i7SEWroQCNTU9/MszwfYXPhihkeR14N9UJfW2UxONUn
         Xptv8ah/xiiYj14Fk+JitTy9PcwrelaGeJnSGjfhlxv8tQLuSBqGzPlIXgn0INYZYMAo
         xZNzl05z2nD26BgX1OpQ98JNF0KcWi4VGv+vYUTWzjYLwxwH1xiHHgTyzSsHB5QpxpuO
         3x00V/X9y3xPCVdyjTSZ+HbnCxEtMvivYjjbTnLYbPBvOE+BT4hmtTAwJLQ8kD1z/fy2
         XTNA==
X-Gm-Message-State: AOJu0YwNjnBCS0hpSJ7S1dCQZK6PtqnDg0tRugaz/l3A7ErDMMxV6vAX
	Us53UUycCkncJOxpgPwnWD/yL3zJ18SZt+A9a50sqxrfbsjPV3OhZNMO1uhz9T3B9TLAR7+6w2h
	B
X-Google-Smtp-Source: AGHT+IHXfsJQTYy5HHptGM/9osFkvYFJQ5HtzeFTl1ShVaweHG9C+gB1ii3r1lKuqPbvrPZMSrlCpQ==
X-Received: by 2002:a05:6402:510e:b0:5c2:439d:90d4 with SMTP id 4fb4d7f45d1cf-5cd54af9db7mr20651491a12.30.1730915464436;
        Wed, 06 Nov 2024 09:51:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6b0fc63sm3075873a12.83.2024.11.06.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:51:03 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH 0/2] iommu/riscv: Add platform msi support
Date: Wed,  6 Nov 2024 18:51:03 +0100
Message-ID: <20241106175102.219923-4-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is fix for an issue found while preparing the second.
The second patch adds MSI support for a platform IOMMU. The patches
may be tested with QEMU when including [1].

Based on linux-next commit 5b913f5d7d7f ("Add linux-next specific files for 20241106")

[1] https://lore.kernel.org/all/20241106133407.604587-1-dbarboza@ventanamicro.com/


Andrew Jones (2):
  iommu/riscv: Free irq vectors on pci remove
  iommu/riscv: Add support for platform msi

 drivers/iommu/riscv/iommu-pci.c      |   1 +
 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 18 deletions(-)

-- 
2.47.0

