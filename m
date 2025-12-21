Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864A173
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766338493; cv=none; b=l/gETmIXvqs4KGDRY1T7emdQlFZNVUv4gK21Y8uJJo+wObBlgoqwppKhLWX312onV6LJCdM8ofYg9nBqneAvGkjPzbZ+VtZMPyJu8aSmFANIysmnFUEL5QwYHk08++OJPXJhNEIU2/X/0aoiIcV1MYeRWDJj3ZoX+9UQzaZxS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766338493; c=relaxed/simple;
	bh=WxVX3F5abxiksJPllEOT4QVLa6idYV3QNId0eo1KGnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTBdfzg+yrARPziA3xpewuJMw6JyKZX3MpXC6BTrEdFl03JqfZnAa0EvZCBRhBmMiSurvSOx/9XVE0TmqDNRh0KqxZmCQnZR4Rf8KCm/ohy8dG/NLLKxxSBJrMVqdPsd153zkKDzqJtAmOoXGSH75BTiqr6+AKdiQyOqwvqrBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMIVsucL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMIVsucL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so3469002b3a.0
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766338492; x=1766943292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KrzrVgYrqwN2sqBtIPlj1s0XjGGWWfGC3z3Sib6B1A=;
        b=HMIVsucLdsz/56o8LGmDVUHWV3XNOZEChALvnPs/3tXR30PEMZCIVqM0zpVe9N9vJh
         x4eb+ipFerqUfFBb9I2DQ9ibbqOU5YZBps3sOSww0c3+WtOAMgglp7JXT7/hWncYRnmr
         Zn5C+Wo7+5VeZIX+D+AuLgUKi4tLGpog6pM8+MTXn2AYc9NbXj/YyGHVi8WCCeRoBWzS
         G3HyGlVHk3WDTXxk6Ci1gfC60wP4BCwCchOM6WOg+qeDYqrsk75Pa1zIHMYM6Fss2quq
         Dk/7kGXbsMx5GcxaBKu6WiIA/pKxsNK26W9AVAT4maGOCfA83VvFo9nAvTiD/SD7kLKk
         hSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766338492; x=1766943292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KrzrVgYrqwN2sqBtIPlj1s0XjGGWWfGC3z3Sib6B1A=;
        b=qJG6AGk9SqI9hFLFhVIkcHf8MSnQmfKa4sn0lo3fWxdqCLS8u1tA+kFfhDYQDCNGHN
         l6lBlGUp7EgRflvAjcKgF/61/je9LGijvH+Zsew+kaaz76GBoMSNo0xu40D7r0RhMqBF
         gsGRHgIMpdff+2tL3RnX0FoL9TFzAWIIqMHVZ/Z1hI09dkIj0uYWRG7pKm6b/lCWA898
         ObDvVQLeJQ0EOCmPZalh0+2tayNQYBP4vv0FuC8wQ9Sc1mFtMTF75JxoNet/wxd76Ljl
         gkx+hkVRLN3aAYRvp8V1tQVnxh8XXB4wtdFtSvRr4SDXTkx6qyDfLfHO8T22Ckxw0Hqq
         jSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrBKXgrFFEzMRfikOBiylhz7WVa5/5CDmFQS3/lF9/341uTHi1tbIjkqlsrd1ApWxyQubSpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt+wLdiBpO6JT0J17BEynMtn7Im8sZOArS5HsXXdb1QgGUdb89
	jpXTnYUMkcE2Gct5mRJXK+ILvNSXh65xCMR7D8qlTud2Dcv0QirKPBqe
X-Gm-Gg: AY/fxX7O87OfjZZvUMx8iAjNzuT2nZW1g5IQ/90FM/yU7iZHHVoDw9rRFs3mCrYXI4O
	u0Zxiim/0R5+KetHp39OxlbEPOU+gVng4nUGryMnkaEjQI5r9ELbAGIvndIZNmSrqryUuGcnU/R
	0oJoNLYJRKXWfkIXmS8GyD5t6qGicVwnSLIMkLpQHFgZDII3lCrEYZCtRdQlYm3UVz/BZjHF7Eu
	I8rHCysYMEC4q2RcdMv4mCTrKBNItAiUb/HjsvBNytL1cK9DL5Z36jHI9caspACl8ZsbnmYy/ck
	UfmTSJqW1fMB99Cb888qWPOgQs9s6Bi5CcsDNGL1qknmpaXC4XEVjOFMq2cxllVEqAejVT2t3J/
	GzVaD1QI/ET+NvjdQHPtRQVEfQxQxfjO8lHgo6GPfj6gK+eF4GkYTEg7XoB5pBVeVoUpa0uJDVq
	suks7dT2PLhfLrMItplQ==
X-Google-Smtp-Source: AGHT+IEvioj+ZptXQ8FnpuRwwS2JUU+hZ+viSb+CyqVe0Oyil5z+mLKm3cSiCe59x34NbrKhv/SBJQ==
X-Received: by 2002:a05:6a00:8c11:b0:7e8:4433:8f9e with SMTP id d2e1a72fcca58-7ff6607e33emr8307839b3a.38.1766338491505;
        Sun, 21 Dec 2025 09:34:51 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:67c6:26a8:e1e1:a093:320f:53b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843a18sm7976174b3a.14.2025.12.21.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 09:34:51 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com
Cc: dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com
Subject: [PATCH] iommu: amd: Fix uninitialized dev_data on probe failure
Date: Sun, 21 Dec 2025 23:04:16 +0530
Message-ID: <20251221173416.132656-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_iommu_probe_device() may jump to the out_err path when
iommu_init_device() fails. In that case, dev_data has not been
initialized yet, but the out_err path unconditionally dereferences
dev_data, leading to an uninitialized pointer dereference.

The IOMMU core explicitly allows ->probe_device() callbacks to
return ERR_PTR() on failure. Return immediately when device
initialization fails instead of falling through the shared error
path, which assumes that per-device IOMMU state exists.

This avoids dereferencing dev_data on error paths where the device
was not successfully initialized.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512191724.meqJENXe-lkp@intel.com/
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Testing note:
Compile tested only.

Build and Analysis:
This patch was compiled against the configuration file reported by
0day CI in the above link (config: x86_64-randconfig-r073-20251215)
using gcc version 15.2.0 (Ubuntu 15.2.0-4ubuntu4).

Static analysis was performed with Smatch to ensure the reported warning
no longer reproduces after applying this fix.

Command using for testing:
~/project/smatch/smatch_scripts/kchecker ./drivers/iommu/amd/iommu.c

 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5d45795c367a..075125f0f52b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2426,7 +2426,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		return iommu_dev;
 	}
 
 	amd_iommu_set_pci_msi_domain(dev, iommu);
-- 
2.51.0

