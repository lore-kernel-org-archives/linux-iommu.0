Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78853D47A9
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672615; cv=none; b=WDB9xJrDrDB5kFsCnoitjEKLP2Ne/P2O1sGVLRzQOGYKO/HyNoRi8/nRHo+ORqD5eDWyZOSLKWhfL8O6MdJyqBaIjeyla0YwGd4psLcRFChJ4YzXH/bCwTe3Y1T5gPUH5ui6S2ZBdV3+0NFuTuJedtaK9k0mzhZ7HETph1+LfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672615; c=relaxed/simple;
	bh=1redyhJC+IGh+e+S6ytViOC1oWenhApj7OjFxxKaJwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KwaA2vAXEXsr6t7zsC96auLceDq9E11Lxdrij3eBMvyBewnAjvr/DuRMqBKpNQFGfXDgxCkeyVVUkFVkRStltFptyMeBRLN1GyCG3Z/OhteF3K4eeZkq0khQskdLhfWCttnu755EEyzvbj0F5LqfiVClH2Z9GTt+4J2M9vVoprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYjBWz6i; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYjBWz6i"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84859a64079so622499b3a.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672613; x=1787277413; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7AGEyzljGhXcSI0kwm3voWfb0/wbSArpC0SZwch5AQ=;
        b=mYjBWz6iTIylxnFUsyjYragoFysNkXiR+pfmcljCRvaN9sdm8gR0NNlq+z+gwJxOq4
         CAKiqxmaCsnRxKvkD0w0T5aPBdzMRhYBtZgrNd3OXwzwzfkYGiMMzmADqx/pjniN0nlp
         e+AlAzBi3s8lf0alRny5ejmbYRkDBSEcfNT5EGJHJNQV5sHHeZrgvv+INCkrCoeydHLe
         QWIjDbdQVN6bSy+XqM/xF8SFGueehBBH1XwZKG5N2e8r3vMXwqFKjod/xb2ulKR88UCE
         dEvMhtgvhJV8IcBLsfxJcTg86A284r7yoD+39z6nTXD75VZa/blZWMYWbFpSuYkGWLuA
         aKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672613; x=1787277413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7AGEyzljGhXcSI0kwm3voWfb0/wbSArpC0SZwch5AQ=;
        b=qwuRFmbb7EdUdNsDOhLx1YX8/F01OR32rfYE09mJcx5XRPaODS8gchJqGS7pXuozi4
         TTmy6msXUZ06WIOfUJ1lDvBTj1t4ey3631y7I2H980+6y59YHwIrVo/AHNaa+7qvMG3D
         q3r9KIxBPif5jPFU0y5v9WaJ4cHYf24e9FmYlCHUVpBFDQS0EQI4eTFIraza5lP5BiBK
         nTO+Q43vgGL8LuEmxKTuLskHhpLG9laBGIyOy5NC6XEaHEusOZQX9g+urLwepmCqc1PJ
         x845z2jTJ4MGmEVOLR2w49y9Hmd8oCAe+reSOBUW93BFUsdcKJVnmmN8ntmMu2v7DP07
         AM8g==
X-Gm-Message-State: AOJu0YzoeNPmdIoFFnnGjbDDGY5pXFQwLXjvYUAWh7/OgSjnfzlBN4se
	OzyXadwU/L5j7emKb5qcDazQecwF6ISzLKuCRWIBoHJmMoHrXGnQ/rFOHIIG0MKKGEod2SsGklN
	ZbUQAlja8j2RgWmkLvERIcwNWVDaStR11ElJWkZxx7A20l3dnuqYibNG96XrckcxkU5zKGt02UY
	cMpN0G8OEcOAGw2qsOdhbh46wzHTtTpQ==
X-Received: from pfbmy11-n1.prod.google.com ([2002:a05:6a00:6d4b:10b0:84f:d0db:d487])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240d:b0:848:411f:3969
 with SMTP id d2e1a72fcca58-84fde20e899mr2349449b3a.20.1786672612845; Thu, 13
 Aug 2026 18:56:52 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:43 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-2-praan@google.com>
Subject: [PATCH v2 1/5] iommu/amd: Refactor device probe and capability initialization
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Restructure the device probe path to improve readability and prepare for
cleaner error handling. Refactor check_device() into iommu_lookup_device
to explicitly validate and return the amd_iommu ptr & devid. Refactor
iommu_init_device() to return the allocated dev_data. Consolidate all
PCI cap inits (MSI domains, PASID, ATS) into a new helper:
iommu_init_device_caps().

Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 114 +++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4c31294fabc5..9b8ad131ba79 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
  */
-static bool check_device(struct device *dev)
+static bool iommu_lookup_device(struct device *dev,
+				struct amd_iommu **iommu_out, u16 *devid_out)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
@@ -690,7 +691,7 @@ static bool check_device(struct device *dev)
 	devid = PCI_SBDF_TO_DEVID(sbdf);
 
 	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
+	if (!iommu || !iommu->iommu.ops)
 		return false;
 
 	/* Out of our scope? */
@@ -698,47 +699,33 @@ static bool check_device(struct device *dev)
 	if (devid > pci_seg->last_bdf)
 		return false;
 
+	*iommu_out = iommu;
+	*devid_out = devid;
 	return true;
 }
 
-static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
+static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
+						struct device *dev, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	int devid, sbdf;
-
-	if (dev_iommu_priv_get(dev))
-		return 0;
 
-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return sbdf;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev_data->dev = dev;
 
 	/*
-	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * The dev_iommu_priv_set() needs to be called before setup_aliases.
 	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
 	 */
 	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
-	/*
-	 * By default we use passthrough mode for IOMMUv2 capable device.
-	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
-	 * invalid address), we ignore the capability for the device so
-	 * it'll be forced to go into translation mode.
-	 */
-	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
-		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
-	}
+	/* Wait for DTE updates to go through */
+	iommu_completion_wait(iommu);
 
-	return 0;
+	return dev_data;
 }
 
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
@@ -2477,49 +2464,70 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
+static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				   struct device *dev,
+				   struct amd_iommu *iommu)
+{
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
+	else
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
+
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+
+	if (!dev_is_pci(dev))
+		return;
+
+	/*
+	 * By default we use passthrough mode for IOMMUv2 capable device.
+	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
+	 * invalid address), we ignore the capability for the device so
+	 * it'll be forced to go into translation mode.
+	 */
+	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
+	    amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
+	}
+
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	if (amd_iommu_pasid_supported() &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
+	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+}
+
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data;
 	int ret;
+	u16 devid;
 
-	if (!check_device(dev))
-		return ERR_PTR(-ENODEV);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	/* Not registered yet? */
-	if (!iommu->iommu.ops)
+	if (!iommu_lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);
 
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-	ret = iommu_init_device(iommu, dev);
-	if (ret) {
+	dev_data = iommu_init_device(iommu, dev, devid);
+	if (IS_ERR(dev_data)) {
+		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
 		goto out_err;
 	}
 
-	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_init_device_caps(dev_data, dev, iommu);
 	iommu_dev = &iommu->iommu;
 
-	/*
-	 * If IOMMU and device supports PASID then it will contain max
-	 * supported PASIDs, else it will be zero.
-	 */
-	dev_data = dev_iommu_priv_get(dev);
-	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
-	    pdev_pasid_supported(dev_data)) {
-		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
-					     pci_max_pasids(to_pci_dev(dev)));
-	}
-
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
@@ -2527,16 +2535,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-	iommu_completion_wait(iommu);
-
-	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
-	else
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
-
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
-
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.691.gc56d675ccc-goog

