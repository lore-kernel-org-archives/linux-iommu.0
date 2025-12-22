Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354634D4CC
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423424; cv=none; b=gPwWYLYIplClegqPJ/8zG3Tku7D9HZaBB/nzNjXbHDEQP4Z9Fv8NooTbPXI/VEd4jdmLFTZL/u2anguatWPkIidVZHeh3EjyTdo9qlIcpDaYWn/shxzxGBig3ovE2QowB80bsGtoboGJiavR8gFfI1twpL0hjiHKxmKfXcUiGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423424; c=relaxed/simple;
	bh=YzHI4G0+hRrgBsdVGircsVPa5FNf/xrUmMBxU/P9OYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdS3dc0OZUdzVVviSDBEiC0y5UHPWgrdy8N95EnSpn/7/NPiET/CqBXJmgzC2+2v6fAQYSPj8E39VJ5295f6utWyqOW48RWRZ+/7N7tmMRjFut5G2UGQRxtBobOp72NYsFCMjseLGNSyt7MM0QLfOk/3yAlbkJObKnisGlUy+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfRk97Q/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfRk97Q/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0833b5aeeso57253175ad.1
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766423422; x=1767028222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Twwl3eXQOJJG8t6zXbxVANRhPz0XPO3mVRHYXpjMWBk=;
        b=XfRk97Q/0lAas36dFGuKd8rboosW1DYX21vfoUkdAZ3J/788QDwXuH/YWhrSOspZH+
         h98KUDgjj/9Y7tq8Mv14H/CyWkLPJQXUtlVQtZ4DReXitXxcXn1OWLcy9IbSOGZa3KbA
         4Y7czmAboLi4iZD1kvREHwx3tPIIrfJouEwsf1CEKi74sIlYDXuk58cZhKj0j0+swnKR
         6FsfeiF4LObZreU1QlwDfFPxjVu3vWjl/Wdmc5Yda25llZPfP/rU91q6f7oHeK9AO5iB
         /E5aiLD/qsDJkgHIbkjMCosoMe4IGcoLuJ2Hz0QeCDSIYIHjdpZEne2ljP7leQSQsUmj
         C9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766423422; x=1767028222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twwl3eXQOJJG8t6zXbxVANRhPz0XPO3mVRHYXpjMWBk=;
        b=oumVW86njNZ1s/SMchap/AHSQCUMOhOTCL8egEsNRNWhhvh11Qbs58DFnNoFXp9ejR
         gyAntcB0jsQ39pHmo3vVdiN8s2F/vfS8le4SUFL4UDzRc1q4NGXzrVPJN1x2cG2WSNOP
         mHqOm8xVKWiAM+4Ik3jibVR1KpDguyy4V+1zy8RxXakAq2Tfh0KSZy+GvfareU4nOWXI
         rqa8czvoGw6bC9KU4YsZ7bM6xs4ZU8DYM7rNMR5WRvyiZ99NC7oQlpHJ9XITx4wSaOZ0
         ZcxmgU8kB8TSPgjqhnPsdhorsvD3e/qXh3fX9TIbReogI5eW/M26Df7a8v04Lvpzc/0Y
         fQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXtFqrZElo1/7EtcXPFGPV9TzNhBWZIq2vSFWYwP3VHNTYswSp0nlkiQ1S3jQF6g4GHLxn0pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKBYk0MR4WrCuRnc0WJ9lQDK2NUPZ1S9wSrU5sy3JCCMickKb/
	xYZaD+S464/7Z3MadoMpV6ujXtTK45hOFcIUt+Ky5Uus3DbscXowjWgX
X-Gm-Gg: AY/fxX6aE4I99mVmNnOd3fpFiytQQWh/murO/pXdrH262EG9+LoVZSGk/c6txmYCoWL
	D9RxBuBJliRcsvF2/yA5Oj3MFQzbWqFc/nQuWFus00zR/HIe66H0ViiE0K7QsJwjkA7CMa6IGIV
	v/hs895i8tyyVtFec4XarvEQNmyy8olT/uzj8ZdeYRXnZ/pdY+7eSJODcbKFM4WLslYQ68gwwQP
	6W6rjE/xBSqj8YuYO3qQTPONkUAm6suOnZohsAs+JIi8kPe3N9X/IbNCTWgjyeTn6XiNWkiPMiC
	7Lph+lz6PYLQvUfvr70mRjejw4nPVK3PThQlOIS74ryeOPXW0C/04ajeUEGi+IU6SKCwdeEVV/Y
	REzH1OoKdTqTvOzIhnJmFPCQ4h4ZjQ/txGywf4zDCwsvnANuLYSpafb7yQ6un6UyMXyEHuuHjIK
	/6BNPDdyCPoLsKHCbWBw==
X-Google-Smtp-Source: AGHT+IFGwoIvh/LClRN4uv8g8aCVZAOzLpRcs94hUY6IVuWUkgSsBL0HmTW1Es/wVhGveE4O22vjUw==
X-Received: by 2002:a17:902:cf08:b0:2a0:f488:24e with SMTP id d9443c01a7336-2a2f2836817mr121946555ad.28.1766423422153;
        Mon, 22 Dec 2025 09:10:22 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:67c6:fbd5:bf35:e32b:9520:be9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm104508575ad.56.2025.12.22.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 09:10:21 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Cc: dan.carpenter@linaro.org,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com
Subject: [PATCH] iommu/amd: Drop incorrect NULL check for iommu in alloc_irq_table()
Date: Mon, 22 Dec 2025 22:40:08 +0530
Message-ID: <20251222171009.44670-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_irq_table() contains a conditional check for a NULL iommu pointer
when computing the NUMA node, but the function dereferences iommu
in multiple places afterwards.

All callers ensure that a valid iommu pointer is passed in, and a NULL
iommu is not expected by the current callers. Remove the incorrect
NULL check to make the assumptions consistent and address the Smatch
warning.

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

Command using for Smatch testing:
~/project/smatch/smatch_scripts/kchecker ./drivers/iommu/amd/iommu.c

 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 075125f0f52b..611e3ccc93d1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3240,7 +3240,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
-	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
-- 
2.51.0

