Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A45193064
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434443; cv=none; b=Xjs2/Sa9Z6sAv3i5RX/EbrR0H8Z5ZpADhQD4u1FtLJqyv9bAO1DaAI+vrU4Fs0/cD791C4BlG2wmBom3Smp0+xE+S7wPCgjSVkvQTObgb6bLBnKzMorER1rgFXX1SC2wDbVMuAwgAgzMcuayBECfL4cMhcZ5K8AMUoMQoqEjjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434443; c=relaxed/simple;
	bh=22Ko6EUlCppzoVb0x55QzmkAFqFzXxmLUukogzwq/2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDcpyBo3d9Nle6KhuOtGrOKaCEA8UzqgPapM8nBx9pVESyAIvJ//1TQ9suHTqQ9TXFXyUAFH7EpjBvw6LmG59ZlW6Zoki5aZqZUJ1RrRcQm0drrO1NhYIpV1VbgTpnsK838Yr/JGXlSsBExupcQYF3XS006VnCUcv1yyGtOrnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRTHd1EL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRTHd1EL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7b121be30so5346310a12.1
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434440; x=1720039240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbOHayuQJNiEIov1gYrLNhraOo1uckdkGZa6Izlq/48=;
        b=jRTHd1EL8Lcnef8yCuqRs5LkjeAAvQyDqJTS4u5A7hpcDsQQ/RcCelye6RBWR0SqQt
         Ga98MV/1cm977pVuUGPs60GD1ZZrBKrKE1+skMYpG3A+OGBGU+AtW+EdsBOAN0RIl0k+
         kIwADvwXgjmHIn0xh/UgqjL75dLbz0go44g6rAEB/CWLs95Dd4E6yyBcT141O0cKzv4g
         ErCIqFUfizJIbQqJ1za/O5m3C+pM3iTt29jwZhG7GaGN4mL+PFHDthVmqV/R8tEm54BH
         3fAcU5wEEz4XuK+JaGDr2RkONFtgByJlHLAxEeopi3DkAKmRVtGwxwV1IXHzT06OZvUk
         bVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434440; x=1720039240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbOHayuQJNiEIov1gYrLNhraOo1uckdkGZa6Izlq/48=;
        b=ZGl2ZE6T/NgxRdn2FGbWbL+yRLQT5/24QYUVotc9W0N2gcM7iuSd6GTHxT2EkP36L9
         3rH3mcvXoEZ6E8X6ARN7s+pVloI/t+JnsHFXmqXq/s7hqy2tGFoDrwSxy1StnMiZ+dBC
         e45Jg+KXKa2xvc6jaKCbrq7WTYVk8zBurgA5LsbPXJqkD/zwmXsdlgA+xCdnUZ2APcUH
         shjliR3AtB0gdJIT2JADQL1IF8/o8s0Kdtd8IiJE+J/pcWP48tas/k1IF5glZAeNgodx
         ipCFDHGn2kqlqdCj4NvvJxWr7LyJwXY/dPp1AKvNauHXJRSnc22UHQkxw7Tp7G2+UB9I
         kJxQ==
X-Gm-Message-State: AOJu0YzI2mG+7JEX5zoJYUeuuhwxBp3Kx8lCIXySfmU6q85WqmHJoJVS
	i3cDHEXRHDCZXHqdjsyjX4owoLcot21ZCVpcw2MuDb3hqcI+izQna0C/tg==
X-Google-Smtp-Source: AGHT+IF3IekAjZVaykmQWQEV/CWbBuXRqd14xzAhjMZ8QLFh0Na24yFedXvOlLwgPR38grbkYKuKzQ==
X-Received: by 2002:a05:6a20:6387:b0:1bd:1e0f:efa3 with SMTP id adf61e73a8af0-1bd1e0ff0dbmr5381451637.4.1719434439963;
        Wed, 26 Jun 2024 13:40:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb323636sm103241125ad.102.2024.06.26.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:40:39 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v5 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 26 Jun 2024 13:40:25 -0700
Message-ID: <20240626204033.255813-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
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
v4: Actually wire up the callback
v5: Drop the callback approach

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++
 drivers/gpu/drm/msm/msm_iommu.c         | 25 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 drivers/iommu/io-pgtable-arm.c          | 34 ++++++++++++++++++-------
 include/linux/io-pgtable.h              | 16 ++++++++++++
 7 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.45.2

