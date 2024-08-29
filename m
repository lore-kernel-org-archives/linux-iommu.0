Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A76191F7C
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933113; cv=none; b=ufkGcnu1UElssipN4V8JsxLDQr9yosdxgvya0nPus7cWMrBIBpF7fvvounTmm14r4SFvB+uFMAoYa/BqvbGXp+m8jUSLkIIkyh5Ji6L2Q51nIwE5q7eQfnh0mu5YdMd9MPRES8mrm2B2zc1EMeYDv6wBIUjErWbi55sghYmVGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933113; c=relaxed/simple;
	bh=nBoN1yavaittbk+d7DraufNBYnZMycnA9WfuTETAQTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dt+uu1lMesXKeDSoX5/7mnm7wU1B71MnWSw6ZYW6S5BhRMUxLOL1JiZRusM9hfA9GjciKtU8bbo1YuhRZmqszCzq59voRq+rAU2A8QG4Pnxx7cp8HmBW6XDSP9vhX3KCL0qHzhJtihTGM9VSTenfs6sPx0MpqcqOL2Np9W0Huss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sachinparekh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVZEOFwO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sachinparekh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVZEOFwO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e164e64efb6so968032276.3
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724933111; x=1725537911; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0mys/2tQCcs3OTEBY7NrCgOPWFXZx1s1qQWQxRmqLc=;
        b=KVZEOFwOcY4uYveo7DKh0KMfC5+5/4oZjojSXI4qAzwjCYwGYFWB9zZ4m77eWqZEsM
         9tUDGUbD/Yp3TvqIl4VgF2UL3J6y54AX0yCcYxf9h06oPJ214TnnI4qTD+G1P7Bwr1sv
         7nLeZ+UX7klCuY/wP0wu0+8DDen9tWQ5wDWcd9uofu7FTzk/gfN1H2igQ3s9ikEuqS9M
         o+aVBlbuViAQvVVFA80VZ1Uv0faUW3nrq2qkZBAjXAnwd39d0F2JrKqGqfatg9uDyvMa
         CX5bcv22v9G0sXMm41vS2SqIFG5xsMum+pB7vCxPl7PTd7j2DiFV/CuTtxGwGSPkXxvt
         0IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933111; x=1725537911;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0mys/2tQCcs3OTEBY7NrCgOPWFXZx1s1qQWQxRmqLc=;
        b=Igl5L1C9rFmXaacWDR4qpTguDRcVgFFyTtyN4urNskIljmWO46UpsOy2Ul1Kyjngi1
         x/JE4mkvKwzPEtpk0AFm3E6f3743nszbNnaDc0M/jRMRjJrXZiClOrIvs72XzcD5tmWl
         FBREWyB6FPIDDIggtfZ/55GZ0WYAHU4z9n4ghdzDo434UcG2MRu5kDcveM+heQGGIdhR
         nYeE6Z9xT1cOjllIjIfoC5ZKAW5l3SYnZ3hAu/0LsovB9wkmWjGXzOdpOoEMa6tVg63b
         xtlRLOc5h/6eRqgpJXTSPkpG2fbeXyPHhBsZNSURafd6T9zYc3iDt5cYD0qflfJL65+O
         AQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXPDznDZU2PF/p7atMs3Tuc7awaBviYeOhCEVKA1HlG6xdLdZ6CWFW/gvowqYoLkmEbAeVErA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEt2Htkjdyo+PX2JETE8oR0cCvDJwaC0ODvTqhLBShaKHw1WIS
	CX5StYjyAXWaKtOBbYFUcRJgO0qwRxyBlPLsLyDotGxyFLkVzqihOesbO1joOMdHSq5cO2ZoyNT
	/BhSx1jm2XGMLTrksxZJD0oDWww==
X-Google-Smtp-Source: AGHT+IEIajcciXNXA9eAeI82KfBygYUO7hs4LPpXBbMDBnoip8dz1YA1Le2XY66UJM87v8KnyRRyKfiIMLUeWk2hEcQ=
X-Received: from sachinparekh.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:596d])
 (user=sachinparekh job=sendgmr) by 2002:a25:29c4:0:b0:e0b:cce3:45c7 with SMTP
 id 3f1490d57ef6-e1a5ae0d8e5mr3845276.9.1724933111089; Thu, 29 Aug 2024
 05:05:11 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:05:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829120504.2976612-1-sachinparekh@google.com>
Subject: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
From: Sachin Parekh <sachinparekh@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, will@kernel.org, 
	robin.murphy@arm.com
Cc: sachinparekh@google.com, lokeshvutla@google.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Installing a kernel module that has an iommu node in its
device tree increments corresponding iommu kernel module
reference count during driver_register.
Removing the same kernel module doesn't decrement the
iommu reference count resulting in error while
removing the iommu kernel module

    $ modprobe arm-smmu-v3
    $ modprobe test_module
    $ modprobe -r test_module
    $ modprobe -r arm-smmu-v3
    modprobe: can't unload module arm_smmu_v3: Resource temporarily unavailable

Cause:
    platform_driver_register
        ...
        -> platform_dma_configure
            ...
            -> iommu_probe_device (Increments reference count)

    platform_driver_unregister
        ...
        -> platform_dma_cleanup
            ...
            -> No corresponding iommu_release_device call

Fix:
    Call iommu_release_device in platform_dma_cleanup to remove the
    iommu from the corresponding kernel module

Signed-off-by: Sachin Parekh <sachinparekh@google.com>
---
 drivers/base/platform.c | 3 +++
 drivers/iommu/iommu.c   | 3 +--
 include/linux/iommu.h   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4c3ee6521ba5..c8125325a5e9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *dev)
 
 	if (!drv->driver_managed_dma)
 		iommu_device_unuse_default_domain(dev);
+
+	if (dev_of_node(dev))
+		iommu_release_device(dev);
 }
 
 static const struct dev_pm_ops platform_dev_pm_ops = {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..495f548fd4b9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -92,7 +92,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static void iommu_release_device(struct device *dev);
 static struct iommu_domain *
 __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -663,7 +662,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	iommu_group_put(group);
 }
 
-static void iommu_release_device(struct device *dev)
+void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04cbdae0052e..2f9cb7d9dadf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1049,6 +1049,7 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
+void iommu_release_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.46.0.295.g3b9ea8a38a-goog

