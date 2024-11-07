Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3817D355
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954243; cv=none; b=b0mxzAWRzPYGhNImcc+t/CI6lSFIO/hBdR8Q824mlL00HT1V3nC8OMiBXRvAfVw6vIraOmNTygg1TkI4oS+wi7DptNNZvrpi6Mp5hCS61oSJkvDVKml+yKK/Rr+0y9if2B1gk9FMzVcmhWdxUi8yP/CLhFTGNlUUoPOcvoXni6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954243; c=relaxed/simple;
	bh=djtiKxfwMXlElXRqkoZlRIe/1URcPNqKmbd8HmdJso4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoxJ3AGO6ys00TUAq+ZQsW17Cxg4LVLJVL6j9VLNQyHPAKkqWua+2K7q1KopztoveWRJyqJUM8C1M2OG+E3xx3z+3a3XLD7aeXBgVknO3JrtdY0Z3adLoBAUpZmleAJTDmUEfjLvCfS3fehfzDzW/XdKvdLf9BnOI8JtdS6LMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sGDM86F/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGDM86F/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so403008b3a.1
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730954240; x=1731559040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGFL4n7hAh2FjnL+CWJ4ErGkXKiKPRoUD1KeW9udQmQ=;
        b=sGDM86F//HWb6h3RWPoZjSzAkNmp3udPDjeVnmn1BXImLZsj8uFC6MhpmA+c6zb1es
         wsZKUhRHX1MT8j6vHeP3/k30qXAF+eK+DesMCq5ah2rpREhvGanWLhNFTBnFsbeq9Y1j
         Mdao29W43rdHtH5u6IFBQ0Xj1Hf1LfqRoPlTfZv/J0sj0qzDKP5E9RiDNjMxgfpoBiPk
         xcIW2a/WyD2oYE2Q3S69NltAImTlkoQECvIkfY2gmeAiE86rBd7BclfDj54eBwCL80pu
         eN0xLxkDtz3rjWytOGiXmaD42A3ngqb8qnFoy4HRLvQ1m8kw2mGO+YytDFOF2UHJY29G
         qZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730954240; x=1731559040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGFL4n7hAh2FjnL+CWJ4ErGkXKiKPRoUD1KeW9udQmQ=;
        b=su+ZtCFmTqiSGk43JigRBedCMGXuDMAzuZwooLo+KDYcMpydoPzbVHXmkXZGaNCYZU
         D+315WdhECE7tDrKGVi7qZUVqxJ0EFTxFSI4cl62Yq3mLMVYORNSB4ir2/PeLnScTrUk
         HNJR4zjo6CRUTAJAHvHGJ0u6nSQf/pAPfz+YMg1ZM40ZLavcwPYk/EjQCj5VPcqi+Jkt
         J2evfGDT4PCFY/ejscpy2MfDXismfVS2ix4JjGLOqsIZxzCTVmQoBP4Vg53wZ6r01U8T
         Cg0VQpkHLtFBwexAavgEvSxgK9kPxr6Cp0W7lIzcbynVish7CpQEr6UgISXcDgT5Nx9t
         pzvg==
X-Gm-Message-State: AOJu0YwegEbUuG675jKze4T+O309Y92Su15yti51mUSuSBroR7iP1wlG
	fawMXfwonfwiBRujf0sb2Or/j1sFyrCONK2mPKxqMfrEwh6a9IxlnHIXVbWrv/MdAjNXLRIyHvx
	PhH464w==
X-Google-Smtp-Source: AGHT+IGiwavu5UGXq8CrIZC04nV302KesPSHi8v8p/O2mVfLRC0J4FG7JTtV0e6d9EK7h/RxeaKDAg==
X-Received: by 2002:a05:6a00:2341:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-7206306ed64mr58685515b3a.22.1730954240433;
        Wed, 06 Nov 2024 20:37:20 -0800 (PST)
Received: from localhost.localdomain ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a4f566sm445337b3a.171.2024.11.06.20.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 20:37:19 -0800 (PST)
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
Subject: [PATCH v2] iommufd: modify iommufd_fault_iopf_enable limitation
Date: Thu,  7 Nov 2024 04:37:11 +0000
Message-Id: <20241107043711.116-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028113209.123-1-zhangfei.gao@linaro.org>
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
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

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 80efef1c127d..c5b0aa719948 100644
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

