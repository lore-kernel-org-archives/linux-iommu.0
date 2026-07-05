Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54D369D67
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278856; cv=none; b=Uzdvn2Hso7vvzOESkdiIEW2dBuJWy/Su5vb39pA0ySRVV0gT3zEvl/UaCvqodlAD9Vw0PhWAxsMlLAZFxsUJRgaBMWD71goWRQEgVA5wJFZIn6D8LRs/xSiBuK+f3Q92vYNPFEwhFLSiqwluFAsxbatMC611WnM9F8090Xp486k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278856; c=relaxed/simple;
	bh=8dMwcHoLl0Z1JzcMDPMcwAdi90HhpnlCPh0AzVY5gFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=liPxDkccsc4bVZhPIhqRsYhC60mabPhUymzvWRu5nJ8UMJy2yxB+njXKIaGtmJQLPyo4YlBZdrP/tyMvUyE67ZpPyab37r7dAUDt1HzHRVkGlwM+ktjmuKAQCcxkb3UKHwWnRoPVYvoyN/LhVV3L8/TWIlENeruS7jmkUdnMVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHSZcivN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHSZcivN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1930385f8f.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278854; x=1783883654; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rfOoMuZEApI7TKZXEN8dHfuOQq4puRHMEr9ArXWgLU4=;
        b=mHSZcivNrz8pL7pQxuBPLXN5xQUUp8fr9LFPwCqhLRdcARwLa4+I+xHRrpQNkWocft
         mHkx1rMOQRfVcFgtQnfli8lwHIhlDSXZXopBCaP1mdRKbkrk6vP2BMF5pJdMt8Tme0vr
         g9VoPvMFUul6g7zN3nM2hXZbZZm8tgLkbfOEzGUSH7xbDU+wFnwr45M5eAHPaR5pHPhE
         OM8dvvlVUSKcEBbTgpk9VAEQ/Hg7ievebFvpa5hqwUD0DYs1/+4/frvZCEnId9y7k2F8
         g4cR52nAnlUgnFFht5uEQrbfJbNEx4AHTO+CKohqPWFakKlqcFi7TBCFaOiy9Ux2ZRlQ
         GuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278854; x=1783883654;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rfOoMuZEApI7TKZXEN8dHfuOQq4puRHMEr9ArXWgLU4=;
        b=fPpO1j/j2EfYsOL+tsVICrPGqBlnheyx5ue4zL2FN2h0o9yK/9NLf63kn+XFRtdpff
         QSnfJtGCh2EspOvOqMKlZkj2OLXCOyEpWa2ygeiC93eS53WqtJ/UGa5kSO+c2sCEsH42
         irdLjCwrMaYptY2hlQS2HE5oQyV9JujDOgX5rs4Nmcu7IkrpnwZfKrx/ITvo9sgDhbg2
         2hELYlozhOMr0vZFUbO+27fwf0wFLDBM8S6hQNzbDhD82yZ4TXPwTTMoChhlxItfXN+N
         A3yBqtY0NRg2BywqZWbUM37eCWxd0RFiKyxeAF8zrsWnAhpfrsVDZseuHY+GWb43irk6
         fV5g==
X-Gm-Message-State: AOJu0YxcMqCvd+ZLZf3rnz+bYNwr27YCbhafH9G+j+0JxMtFFa96fpbf
	+8tURVLrbKjQ6IsmQADrSFj5EgWHxg8OIQaGV8G2+P8qGlAuGYqnm/w=
X-Gm-Gg: AfdE7cl8TZCweLi5xR2Ao2FtZkr2Fxsep7SABPlCoD+XPUdMQOq6tjZiG/qMcd4flJW
	Wjk+lE8k0H20rKC3NmjdtDbzGpWSy+Ws0nnEHGC2Anj9ooejzMs1BplJHbPepskKqxQ25Nwjncf
	fKLOTUlZ32opoM6kJLtrsg9QkXAIB1tqKAJtToQw+i4qbL0iYdzEB6q1nNmIbvnZIxzByWrv4Mr
	l+iofq10MxdtMmDG33rJD8yOogLTjfiXPvqhshkEaPZyIWlcapaihv0VOpZvZ295gf3cM/kzpMq
	9UWeLY14HgnaoeG4ehoRojqlc4kfc3asgJjZ2hhTTuI3GnMGaJGa/BykpOWNiVdz7LFabj/5kN/
	kvbGy1mACBNI1vMSmNH7PVDs2Nljqp9eKhQWShye+7dO7x9HUqfT2BUzBJjLY509q2I6L88o+1D
	9xx8DrhTlmRUIepEc=
X-Received: by 2002:a05:6000:469a:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47aad6435e9mr5514134f8f.29.1783278853423;
        Sun, 05 Jul 2026 12:14:13 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:13 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Subject: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
Date: Sun, 05 Jul 2026 21:13:34 +0200
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMAyA4VcZORtIN63gq4iHtosacbUk3RDG3
 t2qx+/y/ysYq7DBqVtBeRGTV25wuw7SPeQbo4zN0FPvydOAI1tSKVUWxhwmxmcJCediVTlMeBw
 oOL+Pjg4RWqQoX+X9G5wvf9scH5zqtwrb9gEd3ZUqggAAAA==
X-Change-ID: 20260603-descriptive-name-lpac-upstream-730a164b105b
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2538;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=8dMwcHoLl0Z1JzcMDPMcwAdi90HhpnlCPh0AzVY5gFw=;
 b=Q83mQkQCI/ZbHgZyMczAaUD07W0pExCURYUI+AfeuCtFffXnVzp1aiJOAaTDPf13rw1Fzn+7X
 WRuPw2v96y4CWwkfRLibXR6NQ9DulNdUY/gYM6XuxmEibN0Vv7DXr+i
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

This series enables LPAC on a7xx GPUs

Currently hangcheck and recovery are broken as the patches to make them
work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/

The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
to work correctly.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Anna Maniscalco (13):
      iommu: arm-smmu-qcom: Configure lpac device with split address space
      drm/msm: add support for lpac_domain in msm_mmu
      drm/msm: look for lpac from dts
      arm64: dts: qcom: sm8650: move smmu sid 1 to new lpac device
      firmware: qcom: scm: Configure LPAC aperture
      DEBUGGING: print contextbank and other ttbrs on fault
      iommu: arm-smmu-qcom: Fixed mapping between sid and cb for gpu and lpac
      HACK: use cb1 address in lpac dtb node
      temp: add LPAC regs
      drm/msm: initialize LPAC ring
      drm/msm: Add LPAC submitqueue
      drm/msm: set ctxbank and asid based on ring
      drm/msm: add lpac ring to devcoredump

 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  12 +-
 drivers/firmware/qcom/qcom_scm.c              |  18 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 191 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |   6 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  79 +++++++----
 drivers/gpu/drm/msm/msm_gem_submit.c          |   6 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |  29 +++-
 drivers/gpu/drm/msm/msm_gpu.h                 |  17 ++-
 drivers/gpu/drm/msm/msm_iommu.c               | 158 ++++++++++++++++++---
 drivers/gpu/drm/msm/msm_mmu.h                 |   7 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |  11 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  14 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |  37 ++++-
 include/linux/adreno-smmu-priv.h              |   2 +
 include/linux/firmware/qcom/qcom_scm.h        |   1 +
 include/uapi/drm/msm_drm.h                    |   2 +
 19 files changed, 492 insertions(+), 103 deletions(-)
---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260603-descriptive-name-lpac-upstream-730a164b105b

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

