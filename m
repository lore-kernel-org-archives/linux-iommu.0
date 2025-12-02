Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624C3064B2
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716614; cv=none; b=eh5V7XlZc3i8Ng2lIEy1Uhul0wRibMCUkg0woiPsPt3Kb8K5ErPUIRWs1Z34d+CH7I53UeFiEaRhs9X0GazXrgTKSLa4MsLBqZ0iktQgJ+HX2aTcRkteoy0pLHxR6BAX0HQukpKkh0nDsTrj8K30M8e/1Fl51MBvnlzqajjAboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716614; c=relaxed/simple;
	bh=tOydq3slfdu9JtyTiKAwwp6Hpif0D2PUjntntIRibp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jExW6SSX1ig10jtL0ZBBXdC2ZPNm0eoC8WyxNe7wJPcVpDgIDo4qgJnqWKysMqAQhE/HBT7GuynVHHprCziB8brYemy1Ur0ekL55eogU0/KPqupoX+NIecZkcqfwP9mMhd6/LtARbT7p3qvsfsZ/w1ct/riWDIe49vk1iY73CqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITRoyn0z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITRoyn0z"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34740cc80d5so10306133a91.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716612; x=1765321412; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2j0Lgb/rNw+C0ZmBDCgYVjwCBWA7vES7WrfyQecVmE=;
        b=ITRoyn0zTvy8QCxAXHKNzyITdIAvDupY9/VbNOZLYpMef7dtAaHFJSu80AOBOu5Aq+
         zGknejls65SAQWXH1m5tcpigZiltZ4ajCE7D9nw3sUekDkGoZMkfoZCaBWdPXKskcBaI
         Rp0UcBXYUdpSv3qw5A2SeI1jlb+wVH2e8iKNg9GfcMCWsiglIuJXwhEsTxApqpqEoYxo
         UPowCJXghdafYRhgiVbFoGeSGaU0fcCK6qog+QpLl/xU9H/RNsacda6Y9yHgdXYLzHuV
         25m4dX03p2PXWIRC41/pjrFKme6xbwopasX9r1yDtDmDrNu937ePt2XOgxz0S0RbUH3Q
         ZpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716612; x=1765321412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2j0Lgb/rNw+C0ZmBDCgYVjwCBWA7vES7WrfyQecVmE=;
        b=s9vQ5qPSIy6l5oxU7j+VGMcRvcifFZVbvak29w3Q18wHZ+B6g4Qa9+n/VJAEf44Q/Y
         k11sait3J6B+kF6j8yO5Hr7KeMJuQDS2mZ1/lNNATMxjQuD3RvftuE9TvVWt+9Tug5nc
         jtNVsuEIznVPMuNAQtXjIV/6iLQonpmN8hThBgaBQ1A8Y5PdwVVTFgb1nkPBXAfhqlgh
         Y+vJY+UuXWfVS5DXa05zih/+5IMQZyW2kDtj2IQZMvDG1qf5meTbCaZkb5SmwylAYuEF
         rtTMz8D894FI8UO8xMC1PbwfMwXqtKHpB3yJtdbxZ0jF+chl/267wKKNJBUqKNXWaOII
         djXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrMG7SK8EmTWtw+fumW0Yd8Umm8o+JG8FgIxxbDHhcuWwumYHY4ey/BXf0T6E+G4ow7m9SGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0es0hJUFhnnPpqY5ntdTflllr/psY4o0deg59JDLZocit99U1
	7+CYWBtjHmk1+aNGG8tjd9NOcO6bHqcIYA0l+OVIWKe9NsykuzojS19MktlZrTjezZu/3NKuAOi
	C76DGGijm0eYr7A==
X-Google-Smtp-Source: AGHT+IG53fov/iVxOs61D15owy8vLQDQJREsle6WJATSFGxAcKk6SVrPQxDs4qzsSKXKbiYGmQN/hKivZgWafw==
X-Received: from pjbpw13.prod.google.com ([2002:a17:90b:278d:b0:33d:ee1f:6fb7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b81:b0:340:ecad:414 with SMTP id 98e67ed59e1d1-349126b81acmr352148a91.27.1764716612215;
 Tue, 02 Dec 2025 15:03:32 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:48 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-19-skhawaja@google.com>
Subject: [RFC PATCH v2 18/32] iommufd: Add APIs to preserve/unpreserve a vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
the APIs exported by the IOMMU core to preserve/unpreserve device. Once
preserved, the token is returned to the caller so it can be used to
restore/rebind to the device after liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/device.c | 39 ++++++++++++++++++++++++++++++++++
 include/linux/iommufd.h        |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ba4d9c3cfa8b..2c81bfa7dedd 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/iommu-lu.h>
 #include <linux/iommufd.h>
 #include <linux/pci-ats.h>
 #include <linux/slab.h>
@@ -1666,3 +1667,41 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+#ifdef CONFIG_LIVEUPDATE
+int iommufd_device_preserve(struct iommufd_device *idev, ioasid_t pasid)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
+	int ret;
+
+	mutex_lock(&igroup->lock);
+	attach = xa_load(&igroup->pasid_attach, pasid);
+	if (!attach) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+	if (!hwpt_paging || !hwpt_paging->lu_preserved) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* TODO: Add support PASIDs */
+	ret = iommu_preserve_device(hwpt_paging->common.domain, idev->dev);
+
+out:
+	mutex_unlock(&igroup->lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
+
+void iommufd_device_unpreserve(struct iommufd_device *idev)
+{
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
+#endif
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..ba433fb1a481 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/liveupdate.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -71,6 +72,11 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
+#ifdef CONFIG_LIVEUPDATE
+int iommufd_device_preserve(struct iommufd_device *idev, ioasid_t pasid);
+void iommufd_device_unpreserve(struct iommufd_device *idev);
+#endif
+
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
 	void (*unmap)(void *data, unsigned long iova, unsigned long length);
-- 
2.52.0.158.g65b55ccf14-goog

