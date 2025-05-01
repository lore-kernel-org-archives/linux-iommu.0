Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DB33F6
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117439; cv=none; b=JTAFWg3tvaPqjXInim5UCjwVElXN3m42uj7FFUvRxi19n1ro7iQvY5h3zG0ioV6m9/gBPb2nW5zCb4M+oRLdBvbtcjv+yiS9EttO6vSdxfWOOcoRJWG3np7jqmprrbnzmD3rd5ZacpCwhy4ObJ61mzWdl1GW8T0pxnvJy0xBHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117439; c=relaxed/simple;
	bh=5wab0/otZ82OVE/rJrbhgL2wR2IQtZ76AkM3zQixsM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ete2ygRE+VRsu0193721VxgYUAWLaab9tzwemRl0Baz5AyCcdNwWqMplwQ/K1skII0eO1ClXMbTCApTMVR43khGtwD3PWv9TQBENjJruumt6c/r5hk6zCyDNuydjNIi4ilq8KarW0mAO2o5KzkN5KE+5dgiECZ2YvvKdLC2EjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/alEbvX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/alEbvX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso1483395e9.3
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746117436; x=1746722236; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzsO/skmVgtqLRk8Hn8ZI1p1OwGSLJGPUwYOe0XwdxY=;
        b=F/alEbvXZOMp5LCCExVCiKKyjDXYP2+vkkjM/bGOmtrR0grFW07emXKte1k3VAkRLT
         um7zkHZlwOUBGe0mkrCBUzJU3B5370/NLMK3NWc78HwCN0091k+eBeysfe+/oR4NXXUK
         CZFC1FH02Z5QBU3Y0ggqq4v+Xxwb6S8HrKbGTvsdrYlB5WqfZ2Ix6CWmIzFo11dth/O9
         LGcNfYbs0W/qPMER6ELOkJhDuTVyKr4WYdJbo26qNpw+foKetnPGeLrxUPUjqhuJ9H3I
         by/9ddXiYkDlybcZopgAlGrrrVLcAcmiREj5sArMxg9nv7l2mHZlpM6JrafPXmj5e5n3
         FBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117436; x=1746722236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzsO/skmVgtqLRk8Hn8ZI1p1OwGSLJGPUwYOe0XwdxY=;
        b=KjTph3JrpaDkuN+XnXoeskl+5uwfESLianwdkCLM5sxekqiqmk8qskivwqaMK7wSmS
         K1MNngtli7ZJ51KY27oS6NrsyOuqo5odCy8hBY/FfbvwzWPgdHmsTJvK5SyVUfSo5dZ0
         q15IXnxgpMZRkMmRB1erEDFgppU3QDs6Y9fxzfxGEFjIPe8awg0LEmK54fe8JG+hBAln
         rlI5lkKm07578hyCYxxLK1jUIdBP4mpbOC+QsqPt5Z8wnPB+0hRGu+qLT2f0SLr7GDqU
         iTWXr6CP7TbJdBF0gR3LXlL25ZHcVRKiSOCAQ/kjQt/qpp7/EoOWeXlfOVwJTMwbHKJk
         wJaw==
X-Gm-Message-State: AOJu0YwBoXQQsU/Qa/d63BUJJAir5wbhFGbjKh2Nx0V2S4Z5KCEvZvsQ
	Z62krcOTvNCYJVLKbPJSn0kMLg0f9D/eQFz33htx2chSX62cD6Qux5JnyCJZSio=
X-Gm-Gg: ASbGncv0VZqRcwpeMphNgFEXRCZKoaHaiBs7WgJAbSLf0Uw6U3/fEWylaqUCh0KQXqC
	opbpADs5N1yC0OXXPbZ+UCRlHKuuk2dFyWBzshe5xkZh48dHXv/GG/IE/E7Bx59847m37vXd5dA
	Ja71i10Vu0vfmvKqJR+8uYVWBt8aoCY2ihox0YkpUTg/56ZsNXbps7y61LaPGFuBP6DEl5CBRi+
	fuEAMTg2gzYrjMAU9uJyQRinhv+P7HM2oer9WApwUIpeE6oGfpf/9E0WNXghT+gzvCwiIFPyM/6
	yFCPX+yFZ7JSYQf18Pi5/IqIYpKNuCQbMCvGyAk9VRMuymBK0r+L1RnmMsw=
X-Google-Smtp-Source: AGHT+IFzBR3+bg1K+za0m3jmhBGaIEWJTaw2fxYEKMYSpYAY2Ghh2og1xXnvvNCVK4hKBJzyuscRFA==
X-Received: by 2002:a05:600c:2d0b:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-441b397e367mr14138705e9.9.1746117436018;
        Thu, 01 May 2025 09:37:16 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a288f0sm17166175e9.27.2025.05.01.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:37:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v2 0/3] iommu: omap: Simplify few things
Date: Thu, 01 May 2025 18:36:54 +0200
Message-Id: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACajE2gC/43NMQ+CMBAF4L9iOltDDyjEyUFWBx0NQ4EDLoGWt
 EokhP9u7eak47uX+97KHFpCx467lVmcyZHRPsB+x+pe6Q45NT4ziCCNhBDcLa42mk++bAbkyna
 OkxnHJwdUQkIFEKuE+f/JYkuvYN/ZtbgVlzMr/b0n9zB2CZOzCO0f+ix4xONMZg1imqdKngbSy
 pqDsd1nLRAg4BdRx62qklxWCXwR5bZtb/RUOqoOAQAA
X-Change-ID: 20250111-syscon-phandle-args-iommu-2ea162b223a4
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5wab0/otZ82OVE/rJrbhgL2wR2IQtZ76AkM3zQixsM4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE6M1PHN0IE6o7mwFsELVIe5+r9pleayfwxEbo
 f5oPBaEkyuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOjNQAKCRDBN2bmhouD
 1466D/0S9VB0/93O6znO1M37ZFRqm8qIG8w0AMML9qOAyuf6IzOdPuOkx7bkYPFE77CefdNI7lQ
 x+YPqVrO25vpVv1VDZh6DJ0thxYl/9rosz64P7VA5qcvAyAoQ23h/szrrHCcnI5AO+cSUyGUYdf
 lAQZjS1oLelqm/EqU1SX0mbmElBJh9lkWL51xc8IkR7TzG9Io4oRWK3ruCGto9uom2V9HLROx3k
 oUVzzP7rCrRCEJtH4aU2h9p2MdaulNZIzlpYoHwIONVm6IV90H8QfPp6ZnqjftlbUUDUpGiZMRS
 /TB+WOyd26I8CEJMlms/1irTj6R9Bxq2BIjlSyUM+ExuNjjGanakUy1jdgpyAPS1GMplNc9CWxx
 j5mmy3HqNeTwKzwfHx5mVzDAACfbG/U4bN5LFzr4HRcb2wc3CFksZ+SnXBONFFXYf964R3jRTox
 r5mQznXerKtYHGLnEN1HOjkZEynSzQ9QX8GWaOmnTP7uO01n/m1POcWglvL2v9p4Jj2LqqIHsud
 De056uHkSOMdZQBQKQP5Tgs0ykchwjQu3szjmXySLVwfusGtK76V4vhJjJMVtfivckZ7gc7Ft1A
 SFuLe8d+VVCLiraT1fYNoZHdZFV5Ymosp3TeQetnFf/heqHiD2HWqVzm7g6+vroQdvlOTtGjJSU
 r+nGXyDYUCnukAA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Combine patches #1 and #2, add dev_err_probe() and drop the comment
  (resolving Robin's comment)
- New patch: iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable
- Rb tag
- Link to resend of v1: https://lore.kernel.org/r/20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org
- Link to v1: https://lore.kernel.org/r/20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu: omap: Use syscon_regmap_lookup_by_phandle_args
      iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable

 drivers/iommu/mtk_iommu_v1.c |  4 +---
 drivers/iommu/omap-iommu.c   | 24 +++++-------------------
 2 files changed, 6 insertions(+), 22 deletions(-)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250111-syscon-phandle-args-iommu-2ea162b223a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

