Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EDB67E
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545249; cv=none; b=j70bveiqJ9VkXu/PDaFJiCFjp4odqIP0ikoHwkLpFi16BhkM5HXicgeazIyYxp6Ob8eiTWft1myCIu/9Bcq6JpBJssCcMiXGMu/BevOBETF3gcqlqCcPGS+9nipFANca4Qw634cIGFWW71cm2HPFEOM6QqyfPSfsIOThsymB8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545249; c=relaxed/simple;
	bh=s7Yv5cYnK7lz1o+mJE2Zg0/f6Jz7JTl7QoI36ZaKikE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOeo/i/HRMHGP7AIRIADBBiWNyarc4wP8EXkptn4vny4OMwCNqa10zh5ik/SNESHFcg5Hg86wIUWJHDPrEQNYvHbiwR4iA1tlfno//J2bOKya4c2E4GngCScsCXydf+X8707bNYYhuLiV3RFUDsDsualLFlj2bCDAMkTU5ihZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbbGwY5i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbbGwY5i"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83ab94452a7so2130039f.3
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 16:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731545247; x=1732150047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAnmVBwWFf3Xhdog2eQqQl/DSldjwsVOe2c/bV8ijyY=;
        b=cbbGwY5idTSaJZIe6SaxTUOI9qIu9uJhYq1Dnt/F1MSvwFtTLIDZUuj4BqLteM7XUv
         VSFusMG9ZSZn5XYE+Mmi8MdMg+pltLhrzC04EgYFqkSX2sONT2ShbezvIMClGx9rDm+Y
         L2gx3mCJYoUaERWrl7Imlv2e2ySGiETpckkIUTP6fxdDS0jKEhPuK62x2VxOo8gRuR3e
         4/8msjV5vfWSX5Ojl5OxyIzjcXQBRPhVqBawXLT9taX4StCFU6jX9m/J2p56lJGmWn+A
         nU4+nre2NBOqntwiHZycLaioVkEWSyp8mbiqBSxJaelL+PiAdt2mtznMq+LNAyNGStr0
         6HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731545247; x=1732150047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAnmVBwWFf3Xhdog2eQqQl/DSldjwsVOe2c/bV8ijyY=;
        b=ZYdr5qUZDqzKc/3tkVX3jaIqKNPrlFFnoFm8mjS91vUXwhdIhucRASuwRstp+MlosV
         ROSqv+FPEdmFcKzyD1khXWBsgZe3tcKykeKIk+EFT2smY2AiPJabBoah0kyb+Ww+pzLj
         vVfu2AJQeh3s2OQO/ook9+VxeYb7r48ON5QdVkpcpp6L5wUhjLEzilyVNICbZIkrvAx/
         wPnkxUyZWskwVgRFDZ8/huPNpgNlDIepwZHjuLFriDjkntWfjay2u3raKwgxQ0CYkhke
         dJfz15OH4tP/qZbEP7JVLru0PbDIQ7tyoUKUCWjCsM+0VgQc/v1L+F6PbtwkuO3QZbZo
         fR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUimhvECIMTYWfucVqgFxpCFpruQOivO+WkMSHDZAEfVXpFU5hhZRE62FCbZ9spJLKEx5bZHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2Kku2+G0o97I0EyNnWltrAe5LXpzydAPm9QLJISy7joqhxqKD
	/VLcDzCzP5XKxdZ0mRD8nAAnTpac2R3pPeBZ5RjQ6UFN4SWrAlQx
X-Google-Smtp-Source: AGHT+IFxRqbD12YhC4U8wkPfDwTQO33ThQkh9I8WnH/R9DUcJXRSMyZaEJfwBf3KNdmT3lZ2JubIow==
X-Received: by 2002:a05:6602:15c5:b0:82d:16fa:52dd with SMTP id ca18e2360f4ac-83e431d3082mr1061871039f.7.1731545247358;
        Wed, 13 Nov 2024 16:47:27 -0800 (PST)
Received: from localhost ([2607:fea8:52a3:d200::8f60])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e02fd148fasm2446173.86.2024.11.13.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 16:47:26 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-qcom: Add SDM670 SMMU v2
Date: Wed, 13 Nov 2024 19:47:14 -0500
Message-ID: <20241114004713.42404-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the SMMU v2 for the Snapdragon 670, used for the Adreno GPU.

Changes since v1 (20240730013820.41702-4-mailingradian@gmail.com):
- explain need for specific compatible in iommu driver patch (2/2)

Richard Acayan (2):
  dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
  iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.47.0

