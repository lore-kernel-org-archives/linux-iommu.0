Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8D228C8D
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026777; cv=none; b=QZtWP6VvgmvfjJob4ULCkf+mYXG2VMgFhMw6av9ISZpKYgrYIeDWXhMs2ABbos1PNrVGnQxmTgcq+5SEPd7qyV/olPnpUjiubqm0e2YXwmjbjtHQ069nYvKy4XcZW1K7Lm+NqYTh2z7gDGWIKFdpFhmbWVSTumdzEIngRUKQz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026777; c=relaxed/simple;
	bh=ydpi1l7ULDa9MBB6BZ9Z9gn/EuxJceatGhHzoQ9+coc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqUkEHsdDt5UEx8+1DGgYhJyTsyP6Og9VS4TZNHnatrSA6SdLHmGVcZ4LkRgRw7lmOTqw8d5snVMLsghPrrNyQj9UiD+cZlYOyziAvPCUVX1cUEfTNqP7loI9HCEE98vEjYLPVlW2p8V73InqeRhOyYJF7/dqU6qNLmT59g066s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIF2SK74; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIF2SK74"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so8402765e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026774; x=1734631574; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVsW/B0gP9PKHwLUmI8ZMBosi9aDXXUah+1PSSjDx2o=;
        b=hIF2SK74Qo4LQtoqTRNswNd/1fc5IKpfH1jZVG/zk7fuOdE0HTfU1nreH7/Ow3B6oG
         CN8aIkDYwKEqUAoUAzLV2CnsQKjsqBpWJ2NGm4u8+ny2g8FZtjLRuzZlbE+Gu3wB/Jd2
         zvn3cemvDQPXunLRNWTJg4nit19e4LRwDP4H3SgbW5z97uTuSl7Qzre2fbc41bBUQZva
         cb8dWTRMSz9pG47CL3AgXO8TrHD6UvctI1BUTyKzI6tul8pv2+usK+W28AfIzAcfQV32
         HFO10Z1IRx1xNjf9MZqo3II80T+0Gl4Rex1yxw238rEbGOqyUEI8U4QC7KfaZKY+KJkU
         aM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026774; x=1734631574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVsW/B0gP9PKHwLUmI8ZMBosi9aDXXUah+1PSSjDx2o=;
        b=KEZOKoSowMlvSVLoOPX+HTbsgORs4q/ZmqfkIen2v3lbWP5VIha148rWGBd28Bvxk3
         wzD6WEX2376etfNGP/Rg0rT9F2ZpJ+xgQ3a86PvMcMTdr7p3MoRJmYeiZ9/zh9dzIuym
         PiTpxzngpvYiq4u1OhM5A8Dq/F4S3763DqL9oE8Gh9QwFr+aybYSZK60y4EXnmbdvXrG
         3FzkXGNK4wrL21J9fxWH/R79WfCFqOczAXSG6W8GHiuOuRe0xZdl1XaAgbc7aDMjWETs
         jm5hKCDmqZThKlgO9N4YNQy+XNHjzkRQBxmdhrVIgdkAP63H7UdXqAyAkzO5nakl/Z1y
         ullw==
X-Gm-Message-State: AOJu0Yx54KdsDNNQJa5ei4bm8nja7vnUXUDkkvYTMGGIMg7Im1TzG7zA
	XALMRNkUuaIGZVsot+Ykc7hmQZ6N5UbO+UYu2FhxLZD4M2mBKsITRB5kiUyIv8IK1fAH7AehTdj
	aaFi0KImmcDg2Db1wma8xI9j0RzVn+3FOgin74uZX7pT76FJ7M4OdXcMlNMykIEGk/kYMW+IuYJ
	gWJc/hVMgOe5mzjMoeZ/PL7H+JeQul6E1bUL9qbSk32g==
X-Google-Smtp-Source: AGHT+IGtbmK0V/XXvUUniJq5jDJrYVzgaPP6wOPvnq/baCobCTh6J6FiAIEBuWfIVdGKl3cSeTr7ETO057hIBA==
X-Received: from wmpj7.prod.google.com ([2002:a05:600c:4887:b0:434:e90f:9fd3])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f86:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4361c35f09fmr65905665e9.11.1734026773733;
 Thu, 12 Dec 2024 10:06:13 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:07 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-44-smostafa@google.com>
Subject: [RFC PATCH v2 43/58] iommu/arm-smmu-v3-kvm: Pass a list of SMMU
 devices to the hypervisor
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Build a list of devices and donate the page to the hypervisor. At this
point the host is trusted and this would be a good opportunity to
provide more information about the system. For example, which devices
are owned by the host (perhaps via the VMID and SW bits in the stream
table, although we populate the stream table lazily at the moment.)

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 128 +++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 8cea33d15e08..e2d9bd97ddc5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -15,9 +15,73 @@
 
 extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
 
+struct host_arm_smmu_device {
+	struct arm_smmu_device		smmu;
+	pkvm_handle_t			id;
+};
+
+#define smmu_to_host(_smmu) \
+	container_of(_smmu, struct host_arm_smmu_device, smmu);
+
+static size_t				kvm_arm_smmu_cur;
+static size_t				kvm_arm_smmu_count;
+static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
-	return -ENOSYS;
+	int ret;
+	size_t size;
+	phys_addr_t ioaddr;
+	struct resource *res;
+	struct arm_smmu_device *smmu;
+	struct device *dev = &pdev->dev;
+	struct host_arm_smmu_device *host_smmu;
+	struct hyp_arm_smmu_v3_device *hyp_smmu;
+
+	if (kvm_arm_smmu_cur >= kvm_arm_smmu_count)
+		return -ENOSPC;
+
+	hyp_smmu = &kvm_arm_smmu_array[kvm_arm_smmu_cur];
+
+	host_smmu = devm_kzalloc(dev, sizeof(*host_smmu), GFP_KERNEL);
+	if (!host_smmu)
+		return -ENOMEM;
+
+	smmu = &host_smmu->smmu;
+	smmu->dev = dev;
+
+	ret = arm_smmu_fw_probe(pdev, smmu);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	size = resource_size(res);
+	if (size < SZ_128K) {
+		dev_err(dev, "unsupported MMIO region size (%pr)\n", res);
+		return -EINVAL;
+	}
+	ioaddr = res->start;
+	host_smmu->id = kvm_arm_smmu_cur;
+
+	smmu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(smmu->base))
+		return PTR_ERR(smmu->base);
+
+	ret = arm_smmu_device_hw_probe(smmu);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, smmu);
+
+	/* Hypervisor parameters */
+	hyp_smmu->pgsize_bitmap = smmu->pgsize_bitmap;
+	hyp_smmu->oas = smmu->oas;
+	hyp_smmu->ias = smmu->ias;
+	hyp_smmu->mmio_addr = ioaddr;
+	hyp_smmu->mmio_size = size;
+	kvm_arm_smmu_cur++;
+
+	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
 }
 
 static void kvm_arm_smmu_remove(struct platform_device *pdev)
@@ -37,9 +101,69 @@ static struct platform_driver kvm_arm_smmu_driver = {
 	.remove = kvm_arm_smmu_remove,
 };
 
+static int kvm_arm_smmu_array_alloc(void)
+{
+	int smmu_order;
+	struct device_node *np;
+
+	kvm_arm_smmu_count = 0;
+	for_each_compatible_node(np, NULL, "arm,smmu-v3")
+		kvm_arm_smmu_count++;
+
+	if (!kvm_arm_smmu_count)
+		return 0;
+
+	/* Allocate the parameter list shared with the hypervisor */
+	smmu_order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	kvm_arm_smmu_array = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						      smmu_order);
+	if (!kvm_arm_smmu_array)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void kvm_arm_smmu_array_free(void)
+{
+	int order;
+
+	order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
+	free_pages((unsigned long)kvm_arm_smmu_array, order);
+}
+
 static int kvm_arm_smmu_v3_init_drv(void)
 {
-	return platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
+	int ret;
+
+	/*
+	 * Check whether any device owned by the host is behind an SMMU.
+	 */
+	ret = kvm_arm_smmu_array_alloc();
+	if (ret || !kvm_arm_smmu_count)
+		return ret;
+
+	ret = platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
+	if (ret)
+		goto err_free;
+
+	if (kvm_arm_smmu_cur != kvm_arm_smmu_count) {
+		/* A device exists but failed to probe */
+		ret = -EUNATCH;
+		goto err_free;
+	}
+
+	/*
+	 * These variables are stored in the nVHE image, and won't be accessible
+	 * after KVM initialization. Ownership of kvm_arm_smmu_array will be
+	 * transferred to the hypervisor as well.
+	 */
+	kvm_hyp_arm_smmu_v3_smmus = kvm_arm_smmu_array;
+	kvm_hyp_arm_smmu_v3_count = kvm_arm_smmu_count;
+	return 0;
+
+err_free:
+	kvm_arm_smmu_array_free();
+	return ret;
 }
 
 static void kvm_arm_smmu_v3_remove_drv(void)
-- 
2.47.0.338.g60cca15819-goog

