Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBA30C631
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425421; cv=none; b=Q+eXOod4IeoCApZ1339urm2rbS+8EDrT1xX0qwk2fsetx58RjYuS5wieftdf4lX0klzXB8a+b4ErjlWuWxGNnzNHN2EaspDOfFm178i1jYwCNLdMxSY3JWxqYxECK0jjrdwkAqW929wJ2rrxNVFu3empyPjfRI+UpD6UYOUs+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425421; c=relaxed/simple;
	bh=Nlk2krWXigXedYIVbGLe3NHoVJ85MDZPNxBmyiex99U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nG4owm/+KaX9MzJF+/WR1WO9nA+b0qu1utchpHwAoXRqI2jHxBakz7+vvg475Q+WOWpIOHZWOQa7YBHKBhD59Y4t6LHz42DXaX99mTdpFZdZgmzbQ6VVNDhj/eBOfdezhDjql/XmeiRnirElj7uwFUzxxEpriydNzwYgSgMlKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0bc4yJz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0bc4yJz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1533297a91.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425415; x=1775030215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdEHDzLyvba5udnwz8c2vdy7nbbUB2Sw/8exS3LVD2c=;
        b=T0bc4yJzWWFHmg5hYeMmED4JkkwytD8kBivFXmOR5ZQ4RldqEj5li0PdIML8U3EZNv
         u3VxKapc08uxEdmJESt98vBDyf4GSuFgik0LpNV0GgFvpedKKslnSbVbKf+MxvzzxeSo
         AY7ow8b2o46LG3vdxUelRnWauZcXmwegm6gtEV7qQHMtUqoP3SeWEatcy8xsYCviQFWB
         tSHxZdIWKgND8rpKoJvJ5RPvERODPRfe8+yuTay+6j5cRs2KO/uYz2/G7C/xxnpEiaZ/
         r3tx99JwPcvLOKSwV31mcrIML955/o63qCtUI7zcOFrDUqf3tBqFhYJMypwqTISY23iR
         3xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425415; x=1775030215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdEHDzLyvba5udnwz8c2vdy7nbbUB2Sw/8exS3LVD2c=;
        b=dR3CTUqR1KPDHqX9YXbszfWPB4i2R7wnw5lDD+JfIKdJwSNqot9459nHNslJ99o4XA
         ZxZgOu/xYV/ir0ovJunG9Id7uKLBJu9Jppznk86qiwDSX2Hk5HRjUgSMGmAoXwgcOJhp
         UFYBX2c26MxqC1FKqel9lbyCLdi4qX02XB9q84DRuA1qlka2SLyyMarI+1+trkEPI2mF
         JmLsglUETArp7+s6hz3pTgus7Jan7kPfWzL+8LHEVFjmwP675S0i0tT/zf9UOZ4YbtRC
         2QEzuyt3fKK5EwAGpEpQy2rk2QlNu6LMt+PwgpvC0IVQh7CCyPwHFJdwPyTCzJJQxIR1
         XMGA==
X-Forwarded-Encrypted: i=1; AJvYcCU1KrDtpHu1x3RI84lG0ZzYjg/Ecllw/4cfXdpYcJMLKbbk8WcmAz1Z5PaSjyTa+TTu+KZBeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKQIQUl7n6oBDEMYdTZcZ5QBvNM8HJPQW454p4TCzVt1iMhah8
	iAJ8WyzuGQDBSQBt0IykXtsx5WG2UJZahXZmBHI+t8326ODYCtLGnV1a
X-Gm-Gg: ATEYQzxitOfAeKq6smTnzB8IyuRV4F80oWnJw5WKbrnqwiLJbhjqIYKW3pmJsEOD6LA
	lz/eIPdjD9zj8Dd0HKR43Yb1/lyMr5Rjv7khyuoxA3XSwuZ2lLFCZF1i8a7wRfp4h8UcxQSw303
	dZZK0alOi0kWcbW1qFtHmP69l8iVtYC3EdUO+Ys5nDNYWaJk3cIkQXdjueyGPEEDKIyfg11Z2ZB
	qa/mhd+u+bLDeg34xf8WM1YMFp1iEu29FKozIhGO2LDIF2JZEWWQxAXdbBLIKVnDR4rg5tgInyx
	kx+UwXxPu+e8as7OPeA8ogj+n4/laGlBOaGysYtZUJuQsItqdEVn7YUkZzbreqlBOxpBCiQhUvL
	Pm1ngldIa1JvQ6ENpm1glRA/Yc0RXvPxdkWOVSJ+xwMNXC5tn+kJXWhjGPeGJeqqfyyKOfYhtfT
	5iHmM0pPw1YeM4ls65/MgOFyA63eBTH3LOf419LoU7L0Bzxg3oeNcZICfaCA==
X-Received: by 2002:a17:90b:17c8:b0:35b:e591:99d1 with SMTP id 98e67ed59e1d1-35c0ddc4118mr2246370a91.29.1774425415489;
        Wed, 25 Mar 2026 00:56:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([104.43.2.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0ac5b287sm2769966a91.4.2026.03.25.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:56:55 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	vdso@hexbites.dev,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
Date: Wed, 25 Mar 2026 03:56:49 -0400
Message-Id: <20260325075649.248241-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V provides Confidential VMBus to communicate between
device model and device guest driver via encrypted/private
memory in Confidential VM. The device model is in OpenHCL
(https://openvmm.dev/guide/user_guide/openhcl.html) that
plays the paravisor role.

For a VMBus device, there are two communication methods to
talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
DMA transfer.

The Confidential VMBus Ring buffer has been upstreamed by
Roman Kisel(commit 6802d8af47d1).

The dynamic DMA transition of VMBus device normally goes
through DMA core and it uses SWIOTLB as bounce buffer in
a CoCo VM.

The Confidential VMBus device can do DMA directly to
private/encrypted memory. Because the swiotlb is decrypted
memory, the DMA transfer must not be bounced through the
swiotlb, so as to preserve confidentiality. This is different
from the default for Linux CoCo VMs, so disable the VMBus
device's use of swiotlb.

Expose swiotlb_dev_disable() from DMA Core to disable
bounce buffer for device.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/vmbus_drv.c  | 6 +++++-
 include/linux/swiotlb.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3d1a58b667db..84e6971fc90f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
+	device_initialize(&child_device_obj->device);
+	if (child_device_obj->channel->co_external_memory)
+		swiotlb_dev_disable(&child_device_obj->device);
+
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
 	 */
-	ret = device_register(&child_device_obj->device);
+	ret = device_add(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
 		put_device(&child_device_obj->device);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..7c572570d5d9 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
 	return NULL;
 }
 
+static inline bool swiotlb_dev_disable(struct device *dev)
+{
+	return dev->dma_io_tlb_mem == NULL;
+}
+
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-- 
2.50.1

