Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB24A1DEE
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050432; cv=none; b=ibICrsvK0/HarGNnhsGNQ/i12Clr0lluQhTAI5CNCumRfOEAzk07vcogzkQTWVpx78Rf6H0HL+5pp//XztnfbjkTTpVg2N8TgDvgeRfxXJqZ0oXoULgZE+12Q9EsXCvxf5jFGeWN9ZpjTB7TxtP8WoxbnizK6F+a99M/EZP5+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050432; c=relaxed/simple;
	bh=Nd/TSx61dnRJcb82K5r+IJlVNkV8VFS+45irSLvRyZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kg4hKWd3dtF1LDMBU5vVVnbs0CxYuARy3jV7DYZrG8kEoqXnWDqEY1ClWzTl7tZHSjAtdHfZy/anYrxNtzSbwkwLYr6mxeW5I6swzTC7GnWtT79a5+vGiEvTS9xcqjvsaAc5hum6iqdOX82d+GTLY9HNZx++yxtUUTvjqN023+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgfkEabC; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgfkEabC"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so526224a12.2
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050428; x=1789655228; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6bJocx/haeARB/34yTuoF3un4Dy/cyjeIVcxgejW4w=;
        b=WgfkEabCOwfiMjUyJOa4rlLU9N/+B7FjDuURaiHxikNBb609IzILyxliiGCRgtRl1t
         r4s6n+NK5Y5ciakY4qR/rJKs95mpPo9lyNFTm2Q1vd47l/yL9JdDMgxBlquzGPITaqj1
         maApGkQ5My0IRgQ4X3RNaA9s1uAN5uoUvLLwHTMn64r8bIThTPTiO8pPJDuIm7o4IlK8
         Ajqeseg9Z2kUrsKTvwOAkcCFcbW2nCDUMS+L3EFydUsOdpGunIRWYardd2HQsM4zCc5p
         oYTarGjSed7e2Bz+p8QyD1yTK7ENlKrRW7R5qCxTNK9IZiA8RvD6U2lIGd9C2J1WX4WO
         E0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050428; x=1789655228;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6bJocx/haeARB/34yTuoF3un4Dy/cyjeIVcxgejW4w=;
        b=BUP6XA1ClCEvnNZS8DTttTl4lLNIRX+kfTteTJs64XTPbHTYY520LPKrkOrWS+3VuH
         0/VZhUBUFAS9j9/smp7JYyyynbugp3SvYArJhNE3BRZbnSP4Ligsrh1TyOAfZz+Z9aK3
         P35ppOd7TRbKjMpBKS407ub1HJqaHT83TWqYbJnoCQ2IneExKuevUTdfQrAQh4bYsmic
         wGmUiANHBF+IWJ0TKewVtHl46EhPqTU9ufq4W5jcv72LaM3shh4KxKBxpeT/VT3bfKu3
         NLCrlMA48YSxc+J7CvQCfh3vhU6TInkydXMpVExMMrGwNHN2QayBjiucVuweAbN/ZkQL
         GTgQ==
X-Gm-Message-State: AFuF++nHc28hwIrsZgCoZ7evf2UqKFsDUXsnCIwYLDWRMtBDA+atvGfo
	UZ9EI60ORNYUhJQUV6s+X9kBMXRPF1cyDDyKCg+Pi6ebMmm6zejMyWdFZYarozIT7dZ0iHnP+2L
	ll1dRb8b8o6l7vBf+Pufnemu0B/qD2TAizJunw1uzl7JsJa6A64HRRjKpu/i/ypgJBFsLKRDnBp
	X1p4AmIjEJpqr+JzFWh/ib8cMj3ox/2Q==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cc2:2366:6edd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6110:b0:3d1:39e9:b269
 with SMTP id adf61e73a8af0-3da39b5cfc5mr69071582637.4.1789050427790; Thu, 10
 Sep 2026 07:27:07 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:54 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-4-praan@google.com>
Subject: [PATCH v4 3/4] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7f8b51c28a7e..195097365413 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -573,10 +573,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+
+		/*
+		 * pci_enable_ats() should not fail here because earlier
+		 * checks have already verified support & config.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2458,10 +2465,12 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
-static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
-				   struct device *dev,
-				   struct amd_iommu *iommu)
+static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				  struct device *dev,
+				  struct amd_iommu *iommu)
 {
+	int ret;
+
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
 	else
@@ -2470,7 +2479,7 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	amd_iommu_set_pci_msi_domain(dev, iommu);
 
 	if (!dev_is_pci(dev))
-		return;
+		return 0;
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -2493,7 +2502,13 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
-	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (pci_ats_supported(to_pci_dev(dev))) {
+		ret = pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
@@ -2502,6 +2517,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data;
 	u16 devid;
+	int ret;
 
 	if (!lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);
@@ -2515,7 +2531,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		return ERR_CAST(dev_data);
 	}
 
-	iommu_init_device_caps(dev_data, dev, iommu);
+	ret = iommu_init_device_caps(dev_data, dev, iommu);
+	if (ret)
+		return ERR_PTR(ret);
+
 	iommu_dev = &iommu->iommu;
 
 	/*
-- 
2.55.0.1003.g10538fe699-goog

