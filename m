Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502617C77
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486752; cv=none; b=U3wia/9QzgJEYWH7qes2q7iYheaVNGTZrLPmL5g0PQ2nMnHiY+ZvI1pV+VMNjKJ7aK0zjDHsdTJ6J6lU8ZGK0Lz6jarUMD5BdeBMqlMMuJ54edHoaxTq+p5wFt6xqzR2CM+G/qJxl2ONUQwgvjQGuOj2l1m5UP9RzWJDg9SIHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486752; c=relaxed/simple;
	bh=sJKyceLK2hp3R2DtYdyiGb4AR1HaM8zgJkN3aJUGyEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diABjeGLe/KL4sHVWnoWEP9M3FyeVPLFjFgNnVoWfjnKA1mRs2dLVW4fYj1VgEdTeqsVJXeZ9SP+if16l8c5/AK9jbESCbVT/MDU9Mi5KLu8KBSr/6s4Drts62v3zlB7GTIR1+eklZM2OLGwOQjcWm+XKkiSf+exZ8wiRgcuUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEWf9TxB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEWf9TxB"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-65c5a29f7f0so3289500a12.1
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486750; x=1717091550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6bfu+bhhkfLjZgMfcumMPy+A+KJDQ31ZI+nlFrepqo=;
        b=UEWf9TxBTgaBYwVTDWjYrNzE6nIVwbjAlaZP/7KG3splcy3o5rcV1MRQHnurWW/bX8
         kaEV5PKQU1XX3BiD5DjY/EwnmoDuk+80ulkC20PMIVNehKI8FSOBNTy0vXSqX0Yt8BE5
         PNVHM80sWl61lqZE8PL8pvACyjVIZbfFmXPQ1Nr0hzE4LLxxQ/k9F+wKbenAs8/aHs/5
         Vzn2atKwsc2XLfcz5GdvoiUMffpxdEPub04JfkYB8whjE+Y+qJ/9ia1FrpJfQCJ/Nhnw
         Ov22U1pnLAK6QGKdVLPsparjtqV4ffnK2CMHCbt62D0OOOz6F72YNICCaj7SiJGNtj6f
         i6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486750; x=1717091550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6bfu+bhhkfLjZgMfcumMPy+A+KJDQ31ZI+nlFrepqo=;
        b=Sr8Lk1giroEpew6Yz8ucCjzVakFyyUzu1m+3d05O9rhmfL4LBRwQc+CU1AWrvLhTOQ
         WnxTX1Jp09APGyJQ0vzAWY/gQvVDfu6MEK/ZiO8Ie4Ah/pwRnRKPbuJr4TZ640FtnsYC
         IxUTXDwL5dMRdK2pcmnyxxfHhkmWf2IZvMKNnihnmROvjFbX1IimLWCsFxWq3/sp9TaH
         hsAk6koeSP08vKtZOCIvF5EPF5Tw4w/vKVAxOZMhXYMiEKsyJB40s3JGm2QBCDas7Aqz
         mUQPCbaUPUeG9GuKJz219owXvSSJDciq9L1is1LpYVVXNw6Yq+zyHX5B9eXRMhWZrPZU
         dJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCmbjmdoG7NqiCeiYWBiA7CpINzcFUX8fx42BDNnX7H0lxwiW0fzValD28LkBdonZrkay7pdQbjJHQvFYleZebYeq7O5E=
X-Gm-Message-State: AOJu0YznodMUBnV0NLeT5Ur/ZwRo1l4lBPcDFCUvelGMAjX7bliVtA97
	gOD2EsFEf2WSdJeB4r7I2jDLGjVETby2gqPt2n98vfvcmV6giWf2
X-Google-Smtp-Source: AGHT+IHvfjzUer2CoBJAM367aQfyuIiKPe9JX5y3lgO0SB5+ywdrrZbwTN4dupnWt0YKqTjVHdV00w==
X-Received: by 2002:a17:90a:1788:b0:2ae:6e16:da91 with SMTP id 98e67ed59e1d1-2bd9f461d5fmr5924366a91.29.1716486749999;
        Thu, 23 May 2024 10:52:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdda058d7asm1825463a91.55.2024.05.23.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:52:29 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v4 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Thu, 23 May 2024 10:52:20 -0700
Message-ID: <20240523175227.117984-1-robdclark@gmail.com>
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
v4: Actually wire up the callback

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++
 drivers/gpu/drm/msm/msm_gpu.c           | 22 +++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++
 drivers/gpu/drm/msm/msm_iommu.c         | 18 +++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  5 ++-
 drivers/iommu/io-pgtable-arm.c          | 51 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  4 ++
 7 files changed, 108 insertions(+), 10 deletions(-)

-- 
2.45.1

