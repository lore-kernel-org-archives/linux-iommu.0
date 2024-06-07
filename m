Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581315748C
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757896; cv=none; b=utY/PmmHSULbm0J9EcpLnhK+TWgMNDdzk0nvkZJGbXEhax6i8kuBFIB68Be2jEUd4yJXkFDQXEJhRj2/Fh2I2/PKzDHwQqJgiCep8gmCzqdcn/Ks+XJINmiPZEMQ8DuCMxsdvu0q45QZAet/0BhAJkbb7YE6G6k40Dd8Ori1YgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757896; c=relaxed/simple;
	bh=ycQv3nbAr7OcSxmuMzMW9XRFydQt5R7zli+aLK774Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYNmtHOQajG1Bb6Nt8SwAIz9gHP3U+IsRjA0Rs5V3PSYU0QecrPZDB8lsHnxcpwym1ojgfPeEiM1Uo3tjkqJ19/rVP2Yvy9iyVhTVKZ1ugMu+dc67dZKjbSje/vEwrbJEIbaCBkKdH+0XZ5wBiS50ZRAu2V/kInFmcG8uRzWaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PdhsuzNK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdhsuzNK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso1692524f8f.3
        for <iommu@lists.linux.dev>; Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757893; x=1718362693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGKUPLlaqu34zNkRMuwZus3nvKRpkYIBrcHRGCQDW/8=;
        b=PdhsuzNKDXaGYi6QREQ8nX0TJ+Rjv2AHA4ny8CXtq2g2Dgxj6RVCHjCV70BpogRQdp
         3AFPKA8jdLz6bGVPtEJ2k6Pqarnmjtvz7mPoPPih8pbqPRyZ7mz80UAg225bngwzoP4M
         y8iaSlU6NRiG5yPXP/pbxtdsKHiSTNjjhk8fJujNpDVVE4vULPnA4p4/RGOZP2NHUJMe
         3UvCKsjChgTQ/oxPsaid1Hy2DfEcmUQd37KCkAqRvhYe7/3le6Kkmrp6URGKhJMtYR3f
         nQPbrvHvBAkF0lWzraC6DI4Ly1r0v0RUJGEARec0RsjLR9jTO8INNSwaCaKBgrjcCFno
         nRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757893; x=1718362693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGKUPLlaqu34zNkRMuwZus3nvKRpkYIBrcHRGCQDW/8=;
        b=iUvr0tAgpMk2xRMbrnGZs/LFDI3xhLWXfQWGXTeSndyDOOyCHKtP2aNoXGzk0cJ1/f
         +6EpctK7jvFyKWvOUHLa9ARr9dWF8tsUUFyeLnUt+8dqzmOI5CjvOVP9HtbCeCk/Zy+9
         uE97HDuxB1/MXS94v+v9ZxPxJr094v9YA85GNMETGQcFrXvTt7woKFZpzzxzOtzBT2hx
         YCtMYlBFmbcIWdY/44r2DKtATm/e7pm4PBKHg+uvnjCX83SjUO5jmp0zJoyB6I4Tv1I1
         vpI3tcArTFKIoad7QlQnZnpavLLb8xbTwjxo+x/FVB7wcjMqNSpR1TQvFxnmOChNdsUE
         /hYg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Q5jEoZ1LvCv+ZgUXviqoSAwzeo6VgEMIVp5MsgX6oyBsLHrQJOzeV9YSlh5ljHs7gcU3RujMo0BezIboojraVi1prkE=
X-Gm-Message-State: AOJu0YyXZJ22rAtxM39rh2ef9VmdCrIT/FVSG1yZIZrcsHiqFcM3MZ02
	GhEwCjFMxPoWrdq+4dPvOxLUGnDdU46x4XatqnUiCaCTqekaubJOBg17AcfLM24=
X-Google-Smtp-Source: AGHT+IEq05dxkoUz5lyUwdXJILrFcWqbbvwqZompyFbB5WoQMQiG2JPbouhAI/2QDSQs2s1tVNVLaA==
X-Received: by 2002:a5d:4bd0:0:b0:35e:7dc9:49d5 with SMTP id ffacd0b85a97d-35efedf2a1emr1381990f8f.43.1717757892978;
        Fri, 07 Jun 2024 03:58:12 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Date: Fri,  7 Jun 2024 11:54:13 +0100
Message-ID: <20240607105415.2501934-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before enabling Address Translation Support (ATS) in endpoints, the OS
needs to confirm that the Root Complex supports it. Obtain this
information from the firmware description since there is no architected
method. ACPI provides a bit via IORT tables, so add the devicetree
equivalent.

Since v1 [1] I added the review and ack tags, thanks all. This should be
ready to go via the IOMMU tree.

[1] https://lore.kernel.org/all/20240429113938.192706-2-jean-philippe@linaro.org/

Jean-Philippe Brucker (3):
  dt-bindings: PCI: generic: Add ats-supported property
  iommu/of: Support ats-supported device-tree property
  arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP

 .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
 drivers/iommu/of_iommu.c                                 | 9 +++++++++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
 3 files changed, 16 insertions(+)

-- 
2.45.2

