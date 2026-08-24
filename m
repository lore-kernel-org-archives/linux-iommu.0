Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3722A817
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574248; cv=none; b=busMWTUrUeMNgAMmztdpeZZB88dvoBC9RUn7iMYMSN4BzFbJHAAryZBYMKYxik7dcdqW3QvgZ5/QqKcjq+qbDGEw+NC0flLbUkvXLkNrJ21A5wp5OL/i7uccY4NeeGZKXPro4WNKmZfyzpaCFIB/ui1/HCBAS/ul01iZlHT0KgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574248; c=relaxed/simple;
	bh=kOP7TKliql6tszYytYH7F8i6k0AJjs0tVV+kSSOxFAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSt5QTz9qKHRsSApWjIZvzibubgxkyrnKqUuR8SNJGm37XAiHy9UUuQFS9Xhk+67v6QvRLpUzmd82aluOBa7brGyu5NsSpXq+wZ1gKTsxU8kOvdDhg7+DcIILxI8Fyc1jdReImarprW/qN3bjkVrPTdbm39ZDXc1/f0Hj3MXWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiWjS8Gk; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiWjS8Gk"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848d21bbb55so5265706b3a.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574245; x=1788179045; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2ntTwJmkn8Mp0hIVrIAJ91umhlH105/L19K0PYgdb0=;
        b=jiWjS8GkqGiwD/WmMSXDGFHqGXg2EZ3h3M/4XwDixANgeabRbPIzyBjd2JzG79/N5K
         l9e/MbNVzkc4g44txuVOzoYFLp7tn+/Zw6DDwGd5klcM5pcltn6pVSEDlkVtH+6pWeBy
         gt1FeV2YnfE6SysGphiPaEQ2EjxBjJuDzWCH6AJUPxMMYnLrTGNDnzdEH28fgoL0yo/6
         t+4heJy/LIys3XvelSNG6D30p15G2Sru/GEhMxmB9ted3Dk4mDc3LzWTMciI/E3KCAWu
         CnVnhqVup9RnK2tfqyFG2mBMQeEY2J8gQlHh91BAf8kayjE140gaQnZU1XqGPnOELuT/
         8uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574245; x=1788179045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2ntTwJmkn8Mp0hIVrIAJ91umhlH105/L19K0PYgdb0=;
        b=chbLjLVCLMqvN/1S6Q2BMjrCogfN7aCtDl8VPyXVu0qCth+Wvi3ymUcb4eeemxI5pc
         C0nXuVIKDNr/xcFpErrXlh2hMYofq3RkH4JZXSaPh6XDlt1FWIFHoEtr+ryJvGEGANsq
         P8TLufvNkM0OrQg3lozje60TDkjCkm9myF9sFTNPNhAGNCORBnAIUuEZ0jADRUKDgvmd
         8qNdfuLKquc+KeA5kglfESL5c2emyf6wWfgIHFa6Nut6cR1oTaLDDaQJqaOTbGGZ3ld4
         Kh8wm7ZnK7KxyXOTHYu9QNyrcUekd2/j1UzZyCUrIZA+YhEL8e7PlAoy5G9Jx9sJBiqt
         Vh1w==
X-Gm-Message-State: AFuF++ksRXd/vbL/3WCUsLCiVK3RrL8gPP+ow7a2kYx9NQwfAASZ7Ery
	Rj/czEPD5Nq4a/BGkKe6DtePrhwnU8hPKhR3O2zpFuNFnxmfjMh351GH/CR+eKJr+m5UVF+1s0Q
	frC4ISx5GOSeij5xlBowOiJvmaUqddVhJfEPNpYmCLyJCkDHurooa4ZvNzRPgHiAkZol7RNTiFH
	YpSf9kOauzkZVZ2KlkBfbyY2Q3mW9Lmg==
X-Received: from pfbfb10.prod.google.com ([2002:a05:6a00:2d8a:b0:84a:36a1:6b10])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2283:b0:848:3f07:c5a2
 with SMTP id d2e1a72fcca58-851f9bb67d5mr42275764b3a.4.1787574244207; Mon, 24
 Aug 2026 05:24:04 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:46 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-5-praan@google.com>
Subject: [PATCH v3 4/5] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ed336bca1a2e..ecee4d097e4e 100644
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
@@ -2483,10 +2490,12 @@ static void detach_device(struct device *dev)
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
@@ -2495,7 +2504,7 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	amd_iommu_set_pci_msi_domain(dev, iommu);
 
 	if (!dev_is_pci(dev))
-		return;
+		return 0;
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -2518,7 +2527,13 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
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
@@ -2543,7 +2558,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto err_deinit;
 	}
 
-	iommu_init_device_caps(dev_data, dev, iommu);
+	ret = iommu_init_device_caps(dev_data, dev, iommu);
+	if (ret) {
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
+
 	iommu_dev = &iommu->iommu;
 	
 	/*
-- 
2.55.0.766.g2966f0265a-goog

