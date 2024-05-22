Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE157E10B
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414627; cv=none; b=kUVAX8IwfnYyErwDM9euxKEFO+Z6R2YGBejjjeBBm1JkmkCll49C9Fs6/tebi8OZWP7APY4U6dCpI6gbmgANo0yu8rKbR/VRAh1cvuo3UIw9n6o2Z3hPdyH9hOk6CzKBgYagDLZXcRF39P2d5yMqBvNnGA7MViyC7xD6MjMxnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414627; c=relaxed/simple;
	bh=L//sNRivVqdwa73OnOET5hl3cywNzWVR2sKrxJQ9x1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ko1WMeU2YBFiaVF1juR6R8CsZ2PlXWVN4OEWR2HNvUgxBL9dr8MmdYNEvjk3gFO/5g578KEeelilzA2cSEVx7wZ9ecJVG15DlqDavFeX5EiSSlDWQlxGxB2L5P/SGNsI0UdF4RkayFudBUAc0UM8fLw1OD6GUKnCUL7ew2gzaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFOVa6JW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFOVa6JW"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b273b9f1deso3298833eaf.3
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716414625; x=1717019425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBAoZG0al1m+JA3ktgdRMgrP5Z9mDaaNRS9hpWp/qPE=;
        b=FFOVa6JWw4WXo7zdyE6SuWlkpkjNcWS3Y6ZyG0RpHF8PoF8MhRlDZTbw8WbE2w4sMy
         ujwf25r06OuXgqR20jHPdA/sI77Ky1ZZS5mH1qz3Ns0qdYM/NMrEJfKfkFQWtMy/AYO+
         qn8iaIGpKLi0v1HVsi6MbBPyoOI9H5lmWHPCv0MEL35vX7VdhxMJfMf/eX+FSd/c3XGg
         5yhoNtdU4o6Iqym6tChCunwpkB5iOEK6Ma3cS5bFJf5LkblYxkFUc9bo3QQ4JSgn3Hzc
         HVwFdXXzYOlU1/1x7TYJmeCHzhPFuBBZNjG9a7nxmXZZZ+8hIJNHRqfYQ3h2yH68o+Bm
         8u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716414625; x=1717019425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBAoZG0al1m+JA3ktgdRMgrP5Z9mDaaNRS9hpWp/qPE=;
        b=vDSxX7awVQGGVsxUhwYKWxm2hDkJnHLfVRQbMHWI+tsaPf434MWgimXlu10x4HphqD
         DoP56ObRLDFyr+AK1wsvyqS9YR41Su0FBXIye4IMfTQ5WA/r7ZwVVvv4HfBf2w8wlf7l
         B+Mhjk7ZsI/nxYkmjtQh9UUBKZ1rT8SrxMEmzxzBLAKSPRUhtMgl5HRGNv/VTl9sHj0Y
         szBz/HeYqXjToeDcOc+0wriTSmxj4hmYrRdAl4LZ+LRESXaRqkxQaQvRKCMAEhc8PEBt
         +GSg9WpdLfjLueudfQhFcFDrmlbkTm5mQcR/gRCk/mbgq5TR2j1VCLmZsmY2b9oX6Kui
         RNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs/9WTM2g5wk7vdxEjkxAAi3QvKHi9JwK1cu7uj72jeWuQODXhDzeh2mG+tDePfqECiKdizczZ2deVrQNMO1q9UoxNuv4=
X-Gm-Message-State: AOJu0Yxs/FtlpPyFFvvGMyOj15hfwcU1AerS2pCa9qSgUpiYOrZygykg
	QW2X3JTrwwQfiSQDECArzMjCUMtu7L/BigZu6KRLLTPvTDyPO8KY
X-Google-Smtp-Source: AGHT+IEJ5Jxw6Dx7ysWEw9SOQIKtcpP6HWnvE1UIWEcK7zpJ4dBNansEqpDAUp5l6zKniQsabf2Azw==
X-Received: by 2002:a05:6359:704b:b0:18d:9e5f:aaec with SMTP id e5c5f4694b2df-1979213ec36mr296068055d.31.1716414624804;
        Wed, 22 May 2024 14:50:24 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f677a20c6bsm13037190b3a.129.2024.05.22.14.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:50:23 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v3 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 22 May 2024 14:50:03 -0700
Message-ID: <20240522215014.26007-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

This series extends io-pgtable-arm with a method to retrieve the page
table entries traversed in the process of address translation, and then
beefs up drm/msm gpu devcore dump to include this (and additional info)
in the devcore dump.

This is a respin of https://patchwork.freedesktop.org/series/94968/
(minus a patch that was already merged)

v2: Fix an armv7/32b build error in the last patch
v3: Incorperate Will Deacon's suggestion to make the interface
    callback based.

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++
 drivers/gpu/drm/msm/msm_gpu.c           | 22 +++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++
 drivers/gpu/drm/msm/msm_iommu.c         | 18 +++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  5 ++-
 drivers/iommu/io-pgtable-arm.c          | 50 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  4 ++
 7 files changed, 107 insertions(+), 10 deletions(-)

-- 
2.45.1

