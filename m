Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C285947E3
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887854; cv=none; b=CGsHj16bXYGgTa3LY9Lrrjd8/cIEjxmeL8nPFwKhFamB2gSyZsgJM9MDih5vvUKRLrkJI/l/DiCSN5YFwrtETuBWA4XpcgB5mBW+j0s0B4MmTrZ4zAPCt1cvp3qpZ50r87FbSifH5VpZmROu0AKqLogtgsMhNG72iLueZd1+Emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887854; c=relaxed/simple;
	bh=C5uAJUyLYWWpIdx9dxkBviYTtWet+XiQNOrYr81Ody4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8f2UT1md/aVqsUjj+4CNlMiT7rrY+YzmbKZVJ9HxwJkCh1FPLCELCMF4JzwGwpJhin98KNjXPNnt5NYkVSO+SthrDgYQAqtC6SQT8FdIaz0+TzCMlCIYCenG+cZWvcdBj+3NkToKbdKm6JFqQYXsc4HzpGRQjutoJvz4aif6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OK9Qawm6; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OK9Qawm6"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8627258ef12so2515434b3a.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887852; x=1789492652; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZQ96GtbiVZMUuZJG5wzZJpcCp+T4Rvb6Y19B34gIxE=;
        b=OK9Qawm6pd9NcfqMemKMmhgel5pPvAoLailkJWlnOznVAmJ5iXzp/84IVRW6S1/CUe
         rPzRVKKKsh60O3Nw9f+P+JNiKfG4BStoMIiljuaKd/GSv6wEddVOrPdXF1iyoNuDIJ1m
         3OxnWfjYCYwXeNhTrkrscpSXpe3oVgP8XV0b91IhFUx9xWxVHpCzFXPMnHrfury29Sli
         Qi+A6ujjdLP8TVW35DMHCBRgXMiMlMkBi+eQTPhP0S6+tr9+Lu3rzHQGgU9LwCnk8eGH
         HxbyMprlOoL5u5CTJLIZVUdIBLgEudQmiQOzRZHw2d+5IPF7kcUUb4Q0v3V9w7Eptaax
         oB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887852; x=1789492652;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZQ96GtbiVZMUuZJG5wzZJpcCp+T4Rvb6Y19B34gIxE=;
        b=mvWCT3oyAcgsHDF5EcEsBYFKq0JYl8bmLtWIG8G5Xmx18FJLNjOJzFm+RqQndOmO88
         yTt1Dofern73eHFMqkjvw/PvaxEi5l7GOkvQlGoA71kzvC4ltHt+IGnU8iR/unSWvziH
         QTKXMyWYMwNB/fdwNS23lItSyi1ilYHPojNXs31TTi/OQfF2SS3Otfq89aoEs860hP/G
         G3WJ0FtbeIEuhY7OauuLeUXO/Tq5c/LA3MPX7FSyxMjhR9FpQVt5TSoaipG2nVOcSoOU
         7q9DLTbqGpW+sMvskCTrRdrum+u1f6HPaK5XFA9S+hYAXkNGxXE/wJyJm/7jM9EviD8i
         Qgtg==
X-Gm-Message-State: AFuF++kIjrl46ba5ExUz3EU4aFMHNYYu5UIui30sVJtRR0ZO35k1uJa0
	6CRaKaNGvjJP49CafgPzNj6NTuO6yFeC0k7Hg93rDmXPqO+8u/pCdw+eAMhZ7gNUHLhBoYYFC69
	Xd4xflj1NGRJNPv7AcxaFRQmClMw/UPvT2QtITfZi9X/hUbSs+GcgaJ00AdCH09BYBD+5PsoYMu
	SgADRNEYGtn/pxjJoqBF1TzJ7zOlEUNg==
X-Received: from pfcg5.prod.google.com ([2002:a05:6a00:23c5:b0:847:7f5d:6b90])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a1:b0:857:726d:2708
 with SMTP id d2e1a72fcca58-8616c645061mr40446869b3a.20.1788887851696; Tue, 08
 Sep 2026 10:17:31 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:03 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-8-praan@google.com>
Subject: [PATCH v10 07/15] platform-msi: Introduce platform_device_msi_rewrite()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Platform devices using MSIs often lose their MSI configuration registers
during system suspend or power down. Add platform_device_msi_rewrite()
to re-apply the cached MSI configuration for a given IRQ using the
device-provided write_msi_msg callback.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/base/platform-msi.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 69eed058eb20..022febf2da93 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -94,3 +94,40 @@ void platform_device_msi_free_irqs_all(struct device *dev)
 	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
+
+/**
+ * platform_device_msi_rewrite - Rewrite the MSI config for a platform device
+ * @dev:		The device for which to rewrite interrupt
+ * @irq:		The interrupt number to be rewritten.
+ * @write_msi_msg:	Callback to write the interrupt message for @dev
+ *
+ * Rewrites the cached MSI message for a platform device.
+ *
+ * Note: Platform MSI does not automatically cache composed messages. The caller's
+ * @write_msi_msg callback is expected to cache the message (e.g. into desc->msg)
+ * during initial configuration so it can be rewritten on resume.
+ */
+void platform_device_msi_rewrite(struct device *dev, unsigned int irq,
+				 irq_write_msi_msg_t write_msi_msg)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!irq || !write_msi_msg)
+		return;
+
+	desc = irq_get_msi_desc(irq);
+	if (!desc) {
+		dev_err(dev, "Failed to get MSI descriptor for irq %u\n", irq);
+		return;
+	}
+
+	__get_cached_msi_msg(desc, &msg);
+	if (!msg.address_hi && !msg.address_lo) {
+		dev_warn(dev, "No cached MSI message found for irq %u\n", irq);
+		return;
+	}
+
+	write_msi_msg(desc, &msg);
+}
+EXPORT_SYMBOL_GPL(platform_device_msi_rewrite);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a4613de11960..72b0d36160d9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -673,6 +673,8 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
 					    irq_write_msi_msg_t write_msi_msg);
 void platform_device_msi_free_irqs_all(struct device *dev);
+void platform_device_msi_rewrite(struct device *dev, unsigned int irq,
+				 irq_write_msi_msg_t write_msi_msg);
 
 bool msi_device_has_isolated_msi(struct device *dev);
 
-- 
2.55.0.979.g7e5102b832-goog

