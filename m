Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EE3502B9
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840304; cv=none; b=ohBCePiUf6vE/smK5/L4kn8wJQsVdLWCK//ia9z26fzpiNsEF2CZP6Avdi05HlC0mLd75VXQ0AOSFnOcXnhWq7xRERnic/8njrqhKgKfOrmQAEidwk7lW2PV1xOaBxTemutg2eReBFCiF8ptPsT1fWARmLQW+imYQ5o8TgT4l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840304; c=relaxed/simple;
	bh=hL1KRdcUkqD5m38qDR44cdwSUdn+MD14fevRfOfX13o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oic2Aavon3zcVnixsCdAREJ/8gtcxYglZ8FXLb9wZfKEmQIClI/w3SoyPqFaZVN+kQgVbvrfIe/FLQX7bl+ryu8h1pKY+T34BK8F25Pi1hrTY0SVeDdFR4CUzmChoK/iUtjTLbExUDDfYVDE3WZdIt+PwJr8NgZzkZG2DssXbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r38ZK/Fs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r38ZK/Fs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so38185185e9.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771840299; x=1772445099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZyzh76/vi/WA0Mw21DKfbc+O5VrV1Ds2EV/BZWk6NE=;
        b=r38ZK/FsF8lJZVpK6vMJfTKN/G/a42/MH7sywD74qgZirCuDb7PEqeV4p+EGAi8FaZ
         2ETajLeMfq/gk2cHg30MEaET4FtYXM4jO/VbAPbZLOeNzrlu1lIgvfIDITsxXHKvLYa8
         fwI1tqeggYP1awhsK1VGYUQmCYugLl/TBipWG6IC+UPpfYSQaofQDU3VWQS8EdoKVNds
         XXBGpjBYv1S4kyJ+shwK4gAz7Xm2uSxxlKWpkpR94YInx05WBRO5HrEYuHIRck3BwSe2
         Gkz0TmSV9jOGIidpHF92eSw1+fFhe/dzOF2e8vnJY60a55/1K2ED0fkAsVJ9E1sOO8/8
         f1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840299; x=1772445099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZyzh76/vi/WA0Mw21DKfbc+O5VrV1Ds2EV/BZWk6NE=;
        b=i9DEedobHuI2LC2Q+OWKIeZGfe/VDM7Oh+RT9kLiwMHb/VO2CxUNsoSaqxlQQSpPdQ
         2PaksJL6Ar7F0zTo5vTP+dcpgHVB63raQgLUAJvZphFUQKSjRjwB9Gxv/rV2KAunuprO
         8Cd7oqpLL2y54e3mBDZOz6M4Aay+aJ5kHWHllmIPrqtNO+gatU7pjsxR5mBcagZSrVWY
         EqUvRlK7xegVcXehnfMKbFjlrLkHBBcqFNmMhMdUUR+s8qAnxZo+SzPXRm0BqDQ1njvn
         BDiw/6Y5n9nR6q8MjjwVqFVT6CSNY9XacBjIscNx+8+kXmJiCrfHdSOdW+kibrbhqWe6
         FO+w==
X-Forwarded-Encrypted: i=1; AJvYcCUeP8q0jiRcCo/hsujUyYz322eh9wR9hw3iWmKBivk6yr3b8IOq9n/7TfeF8Sp+PVTruVh8pA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpjd9B053nW32vzRXmfWE8bfiYUJIqoIrb1X/kDimnGiAUvRkH
	v4ehTufDiOadRU0pkaYbRVBeT1aYKw4nouicKRKa1Hw2mByPtFc/TfgJra7QFPMO9/ETWQfUwDc
	fXDYY
X-Gm-Gg: AZuq6aJg1kS0OfB8a9FEXekaT/4L5K8RnXVeCXQuKGYBIdB4XH9iM49CwxU+QRYFytX
	upuw8seDJRkOPqCXEFmGp6yKsY3Pc+PR4uG/9JUtFr5m4A8NH6r6thyGnsNtMylatf0YhVs4Hvw
	imSEqHuue20qKB9qyfbffXOwjSHxHdIrDm0+lu2XXlqCrrfFirN0GRsdvJzrMLgl8k7KXi1z9zn
	HBCXFbyv9cQGuxdN+ZGm4vlYtNbOaZt/xT2YkmVEXG1BoAwE44dP9V/uLioH+HwJKBOZ2m7udcm
	QLRETOTrSaffZdkrrjGGYSEIEPRgdbq5VWs+W7w9gtCaC9ZYtxc6cyDWPeOnOpDifVhyE4btT9p
	ArBIfjhBw3rT3i4gOSYYu6Xcy4ZIZq5veU/a211hs4vT44lJ3VN3VKVSmgw6ZRYBT9djhDr6e77
	qkuwTX6wwqn9T2vQ6BwCmf48gv
X-Received: by 2002:a05:600c:1e1d:b0:483:456a:514b with SMTP id 5b1f17b1804b1-483a95befe5mr129473145e9.12.1771840299027;
        Mon, 23 Feb 2026 01:51:39 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3e0dsm397848795e9.1.2026.02.23.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:51:38 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH v2 1/2] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Date: Mon, 23 Feb 2026 10:51:35 +0100
Message-ID: <20260223095136.225277-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223095136.225277-1-jiri@resnulli.us>
References: <20260223095136.225277-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Current CC designs don't place a vIOMMU in front of untrusted devices.
Instead, the DMA API forces all untrusted device DMA through swiotlb
bounce buffers (is_swiotlb_force_bounce()) which copies data into
decrypted memory on behalf of the device.

When a caller has already arranged for the memory to be decrypted
via set_memory_decrypted(), the DMA API needs to know so it can map
directly using the unencrypted physical address rather than bounce
buffering. Following the pattern of DMA_ATTR_MMIO, add
DMA_ATTR_CC_DECRYPTED for this purpose. Like the MMIO case, only the
caller knows what kind of memory it has and must inform the DMA API
for it to work correctly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of recent dma-mapping-fixes
---
 include/linux/dma-mapping.h |  6 ++++++
 include/trace/events/dma.h  |  3 ++-
 kernel/dma/direct.h         | 14 +++++++++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29973baa0581..ae3d85e494ec 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -85,6 +85,12 @@
  * a cacheline must have this attribute for this to be considered safe.
  */
 #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
+/*
+ * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
+ * (shared) for confidential computing guests. The caller must have
+ * called set_memory_decrypted(). A struct page is required.
+ */
+#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 33e99e792f1a..b8082d5177c4 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -32,7 +32,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
-		{ DMA_ATTR_MMIO, "MMIO" })
+		{ DMA_ATTR_MMIO, "MMIO" }, \
+		{ DMA_ATTR_CC_DECRYPTED, "CC_DECRYPTED" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e89f175e9c2d..c047a9d0fda3 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -84,16 +84,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	dma_addr_t dma_addr;
 
 	if (is_swiotlb_force_bounce(dev)) {
-		if (attrs & DMA_ATTR_MMIO)
-			return DMA_MAPPING_ERROR;
+		if (!(attrs & DMA_ATTR_CC_DECRYPTED)) {
+			if (attrs & DMA_ATTR_MMIO)
+				return DMA_MAPPING_ERROR;
 
-		return swiotlb_map(dev, phys, size, dir, attrs);
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		}
+	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
+		return DMA_MAPPING_ERROR;
 	}
 
 	if (attrs & DMA_ATTR_MMIO) {
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
 			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+			goto err_overflow;
 	} else {
 		dma_addr = phys_to_dma(dev, phys);
 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
-- 
2.51.1

