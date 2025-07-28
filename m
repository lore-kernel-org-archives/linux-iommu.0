Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6C287518
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725243; cv=none; b=Jhh+A5l5vfxWKOW0zwbV49w0DTLBoWT65q4svOY8KlJA74l5abzZpiO/Zy9kM2yXzRZbz+7Wjl/WQu1NpPi2a3nzTl1HxNVf5lPPx5EcJwr2mvU8gB9KhWBlb64hkzDJZlMsOM1JCC3Hm9CVMEbaFCWt9RnfKEchCyVNaESe4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725243; c=relaxed/simple;
	bh=EUy/vZvpysFQHz5jEN+YFsXxAIi1s9ZWwxbNZ5/CgdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qM9cLbdPp2Nz1ywerqUjkJctLIa3apBN0B1VBgewniqavQCkME7TgoUx0F7X1Hb7Bqkyr2REG/GqMayorphAj25tuFWkpUAm244asUF6bnK8HE7JW9TmtRrvjZ0BYtRvMq3eG9kQTVvRY0AQ3KiphM9DbDkXmsLWtu3cHS3a3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8XElLR4; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8XElLR4"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f3796779so2644340f8f.1
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725238; x=1754330038; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSr0fqvgX1Drng12G6ETMDdU03kWvJEQjrB6gLd0l4Y=;
        b=R8XElLR4PfQxj5rX+rwYcwcsAQZx6t/JQxbh13N5NIr3ddec7Tid38ZxdHZ9Std01d
         6TtiA/DgB8Emdy1Y34iAtGC+Ip6JTO6EbpJIgCeUBAvdYZG3jRPHUzVhWdpVxfryk5fq
         6aG4f/sTthyLosJhRwZLOKoImi0LqcLfZZGQ0ZVxxdJeYzdeZxO3auIC86nNXGyh0OV9
         X01rQcrItzK/8n9BY13Xorj3AvHBQYDvv+Ri/nl8NxbFJComryhBBUOPlL9ATOARc8Oe
         qKIii2WLCFY2l8D8pW5ZhpprpDwPQ8+k2bBdXr4h1vVdMF5uPwj7TmXjetx60I5XRk0e
         agEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725238; x=1754330038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSr0fqvgX1Drng12G6ETMDdU03kWvJEQjrB6gLd0l4Y=;
        b=uFpvorNmhUJRePouj9qizu0t7ljZfXvNRWMt6wAZWHvluKYf+90a54C5i8jvO7qwYC
         hJ/yDbVQi4kkpz7nb25VX00BltuUlJ9pO7VFexQgo9Sxpl7yiLKr3aX7kTLnjie54EIL
         pLLN1G0/xPdJAk22GWzs8WVz2c3nMmj26pOl7T3LuBrds48ipL8zMIjiuiPJJfv5n6yN
         iEOFoH4ygZCfVpeojHJBARhyl/ztwKebFpYmA/aVThk+vkYcK4HUmfCNR1Ec7PIXEr24
         mMwgrEUB3Zv5fx9bv/Sv8atpItzr4OoChNmBQAjsVCdL4Uy4cqnr29vhk/zrvuJe5Ogp
         H1VA==
X-Forwarded-Encrypted: i=1; AJvYcCWW0O1KZnuWTxVKYliSPBJqJXGn4BjG3BJjfFsI85SWIazvoa7Cu4GXnbMsIsfRhhgAGivlnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb+cOMg8zXuxYcWNcmp+M+m3SPFcgI8ASF8+DXzcuHJ1JQiX0W
	kQsH5GC36K1U9J3gVa2VRpjve3uacJow0HC1j4viqx6qm2IN4myVGwz7nXa6SQ55Oywnnomf9Bt
	OzL3kzRLHmo2ARw==
X-Google-Smtp-Source: AGHT+IHJypg4BMzHTQELfiD77Icp1+iTSwb8rg42c8bIcH6n5fDLR43xwlqFaDtwSnP1AmX/74ubtwgfnroFOw==
X-Received: from wmbay36.prod.google.com ([2002:a05:600c:1e24:b0:456:1ccb:7fbc])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4011:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3b7765e58a1mr8332580f8f.2.1753725237768;
 Mon, 28 Jul 2025 10:53:57 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:16 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-30-smostafa@google.com>
Subject: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Register the SMMUv3 through IOMMU ops, that only support identity
domains. This allows the driver to know which device are currently used
to properly enable/disable then.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 2e51e211250d..d7b2a50a4cb2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -96,6 +96,95 @@ static int kvm_arm_smmu_device_reset(struct host_arm_smmu_device *host_smmu)
 	return 0;
 }
 
+static struct platform_driver kvm_arm_smmu_driver;
+static struct arm_smmu_device *
+kvm_arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = driver_find_device_by_fwnode(&kvm_arm_smmu_driver.driver, fwnode);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+
+static struct iommu_device *kvm_arm_smmu_probe_device(struct device *dev)
+{
+	struct arm_smmu_device *smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
+		return ERR_PTR(-EBUSY);
+
+	smmu = kvm_arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	if (!smmu)
+		return ERR_PTR(-ENODEV);
+
+	dev_iommu_priv_set(dev, smmu);
+	return &smmu->iommu;
+}
+
+static void kvm_arm_smmu_release_device(struct device *dev)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = dev_iommu_priv_get(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		int sid = fwspec->ids[i];
+
+		kvm_call_hyp_nvhe(__pkvm_iommu_disable_dev, host_smmu->id, sid);
+	}
+}
+
+static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					     dma_addr_t iova)
+{
+	return iova;
+}
+
+static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	int i, ret = 0;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = dev_iommu_priv_get(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		int sid = fwspec->ids[i];
+
+		ret = kvm_call_hyp_nvhe(__pkvm_iommu_enable_dev, host_smmu->id, sid);
+		if (ret)
+			goto out_err;
+	}
+	return ret;
+out_err:
+	while (i--)
+		kvm_call_hyp_nvhe(__pkvm_iommu_disable_dev, host_smmu->id, fwspec->ids[i]);
+
+	return ret;
+}
+
+static struct iommu_domain kvm_arm_smmu_def_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= kvm_arm_smmu_attach_dev,
+		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
+	}
+};
+
+static struct iommu_ops kvm_arm_smmu_ops = {
+	.device_group		= arm_smmu_device_group,
+	.of_xlate		= arm_smmu_of_xlate,
+	.get_resv_regions	= arm_smmu_get_resv_regions,
+	.probe_device		= kvm_arm_smmu_probe_device,
+	.release_device		= kvm_arm_smmu_release_device,
+	.pgsize_bitmap		= -1UL,
+	.owner			= THIS_MODULE,
+	.default_domain 	= &kvm_arm_smmu_def_domain,
+};
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -170,7 +259,7 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	hyp_smmu->features = smmu->features;
 	kvm_arm_smmu_cur++;
 
-	return 0;
+	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
 }
 
 static void kvm_arm_smmu_remove(struct platform_device *pdev)
@@ -184,6 +273,7 @@ static void kvm_arm_smmu_remove(struct platform_device *pdev)
 	 */
 	arm_smmu_device_disable(smmu);
 	arm_smmu_update_gbpa(smmu, host_smmu->boot_gbpa, GBPA_ABORT);
+	arm_smmu_unregister_iommu(smmu);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
-- 
2.50.1.552.g942d659e1b-goog

