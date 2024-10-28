Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B364F8A0
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115141; cv=none; b=UFxJrDtyf5dOo1RJjnf9ZxBBpcsgtyp3ytEiF71AefWqPXDe6pzNhsnU+npLUJ+TWRQYBxts5q+UNzFGhN/L23Dep6mKM0PwVNcJcEx9vJ/CzFsu4vC6h7ZCCDClrM40qmm5KfKR5TbH9K4svj2RzatmC+9WLof55189ugbRqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115141; c=relaxed/simple;
	bh=MpwHSufBcvm9xbl1qnwtR8Ww4UKjQwgRoEtn9RAdfr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLL1Xl/eMK74j2UT4Ey4sL3LhDZ0r9PCdjy6yI5AF0IlW3GRByZTo7Vr+7W2sHlyTagVA61qytAiF9DQ0nJZWe4rDeYIdA55ApY49YT41Cx467sM6Mr0hGt7zIfKMlrHEtOvh31pFuh7qp7jVs0zMpsUpwJ9+5mNJi2WRKMVo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSkD9SZZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSkD9SZZ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2822959a12.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115138; x=1730719938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb0HpRzR6BgtLF4tfspniLayDV2/WdPTrMJnx3jSjzw=;
        b=XSkD9SZZzdvpNb5I8+hIWE23hOn6nWfqL8wFOdWvrWqYGFhna7waz1iAwCpSC4xo1f
         HsbCA2mG/knue8iPvuYVCtUV40oF+AIm2kqA49P9PwRj9ATTsZwyv0YR20J/VYlmFHKz
         Gah2QnOBfbNEH4nxPexCHBvNBd62zJNHBCHAAffzfkfieb1nCl/vfMYdXf5Bomy9OaLt
         IqencEQQZtH2npc6z16OliRfd6N/LZmYqlmfzh1Ddfkdm7o759LBbpalZD4z4HnlHd4D
         3TxFmJaVs2bEu7NGKZtRT8yrm9eFRUrIfVwIKF1KU/5gCnBNUBX7wo4txNW2p4ddyN4n
         sFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115138; x=1730719938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb0HpRzR6BgtLF4tfspniLayDV2/WdPTrMJnx3jSjzw=;
        b=TYv8rnY8HrXFhFNRJwHsC6XTAtZj41Wov4c5gK7BTItFe71b5Lqay1+/+zyp1twURI
         0LQn5ZbMK4u8NhWutoyk0L+h9hDAVxMUkhBAwHTjeWh5HI5ApwdQy3vVzeKuoyZaIJI3
         HyjjpS341+iIlHCdC2UWrb9FNBYRVk2VzW/ZmZrEbgTqn2Cnezg1PZnJ2XHuzPc+Lzir
         GqctLX9pjJliSO0G7JVB38XKD4ryEiDok3yqLTWEjTY2ZkTZdociNKz4btkwBzLsm5Cb
         gorJDV0F0OXc56XTCINr/BsNuMrxD9ORwyJyN4fDJp+p8Pd7mkOfOi9hefns8LMfqfzL
         33xw==
X-Gm-Message-State: AOJu0YxaGBmKBijw5owPejnppgdeEJQF8MzFfpVCHsmX3JH/d8kZ72K8
	nmntpDk0u3W+SLbf2ZN3Q3C/qann5I7+vymNYonC53by0xHuiI1c2mMsK3DSc5CSO4P6O3IwEUQ
	+b/EIEA==
X-Google-Smtp-Source: AGHT+IEnLj7PoGhRW4uWLI9cq1+RrSzhC/pHY5nT47lvhGxgKmgL0cDKIHvPlCLTGBOdc+tXVcHU7w==
X-Received: by 2002:a05:6a21:78d:b0:1d2:f09e:c15b with SMTP id adf61e73a8af0-1d9a846a207mr10729246637.25.1730115138196;
        Mon, 28 Oct 2024 04:32:18 -0700 (PDT)
Received: from localhost.localdomain ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931cd4sm5523282b3a.70.2024.10.28.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:32:17 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	shamiali2008@gmail.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
Date: Mon, 28 Oct 2024 11:32:09 +0000
Message-Id: <20241028113209.123-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
because the PRI might be a shared resource and current iommu
subsystem is not ready to support enabling/disabling PRI on a VF
without any impact on others.

However, we have devices that appear as PCI but are actually on the
AMBA bus. These fake PCI devices have PASID capability, support
stall as well as SRIOV, so remove the limitation for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bca956d496bd..8b3e34250dae 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>
 
@@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 	 * resource between PF and VFs. There is no coordination for this
 	 * shared capability. This waits for a vPRI reset to recover.
 	 */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
-		return -EINVAL;
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pdev->is_virtfn && pci_pri_supported(pdev))
+			return -EINVAL;
+	}
 
 	mutex_lock(&idev->iopf_lock);
 	/* Device iopf has already been on. */
-- 
2.25.1

