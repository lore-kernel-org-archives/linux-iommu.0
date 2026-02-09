Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829837FF50
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651494; cv=none; b=W8dbf4aVuctUfOs59pu4KcjAqMMlVR9bEsIypXBSjeLiP6xWZF4mDGn6ljS7gUDq4mBnl42d2ovlCI17iHEjvtgD0xhyIqSY2haFh7G9ksX8X0N+Sun4dsqr7XToprMmEKdz9wV5Ztjuq9A7t1/o5OYTNRCH2WXQvJNVQ4QEseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651494; c=relaxed/simple;
	bh=ntpJZbbpBAGBfrW0cjUkMTCbCe6n90bP2ZCU7ZGm4GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMTcLQFk3rCLHuXuNMLlF3Q6HMwYZcP82lReYy6b85CavhO1Jj7rLSAVEQZt1y7dRPMozB6sJxX2olojqRHfmDQR3/NHgshrwW5/SnPIXeeKrsoLSx/WWfD/kI3jeMrg+ZDt57h3Fk8ynFH7DyhDwPLctZMgWii709vTkRfaSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lZlxXMTF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lZlxXMTF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359228b7c6so1952867f8f.2
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651493; x=1771256293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10eo7Xx3UsXznodXP/t6JgtysFzGllvuxfjnxVYXEzw=;
        b=lZlxXMTFw7xNO/ElxRDZnqSDaWtcqeCDNkuDs1i2DabDOy5NJ0MRIgRsIHXE570H2G
         HHWrHPI02SWPbyfNcqgV11NAmPquZmit32/rPPHCk+6KibLRiNCrGdCSPhGPTBOFkw0E
         67ABy52m8/yVvcV6H+5kIgab3Pz1qs+UX116fCTjfBN5JVzA17OVl9r6iiklq5AfndV6
         1lnvinwWOKPnXasOYjTrfnvkCEKZEpgE9DbRib6WmNxSb6MQuHC9vV+aUlz/6dD9tau5
         9nr8+/YkxbdWKD0uoZ6P34s/428A0g2q6Y3nPT9gE5eSWiwFiBe70njDBPFLcTDbTTEq
         XqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651493; x=1771256293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10eo7Xx3UsXznodXP/t6JgtysFzGllvuxfjnxVYXEzw=;
        b=wAIIlXFRBegCx4Nrjaya0b1FQI/adou3gH2/XcU5kf1u9Tdv+caGs8/BLMIsngaQcR
         FroFeph0H8eBvWfZmGq5NGtywaM03DBn6c16QJ3G+rH4HOqHl1W2Agbe77vGdrlzJ6s8
         8e7EfxH8tbUW8xShFZzTWU0bgwtfY+tzPuXpmQZBoTV0B+a+oca1G6E07OiY+Snsvs3Z
         uF7qLaonCD8Qjyh3SqHLVoQcPe/pfQu3BU3dbUIVrahnZFlhPMPEZbUozolxkPRHVwpy
         mh1XIsq8lHdPhvs6NCcCNnFbX5ZjcRI1kvG7cSLl7JUWwOpPQtdDkFzMgAksyR1UT0Xt
         04EA==
X-Forwarded-Encrypted: i=1; AJvYcCXvoeyXPMyklWz6rrOfezF2qs8C+/SLdqTnaHQg7bf56FvL+J16KrT0tcWyIlCn64YG7/ECfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVqFTGPtDvIUD4AaQUN3VkEvuxWwpoedJTkSr2bIVdzuuESlMn
	G2O//phLDp2wt3SrnvPX5Ucfi9NuSF/bY07C3+2r60fVDjyqiCVAsKFidCGTB6u/REQ=
X-Gm-Gg: AZuq6aIdYZE60KdNMXUxuWnO68nMYXPSc+4ZKapAg6LC40eUgbTcck3UzyL/Zl/cq++
	8MHN2pnNgJA2DsHwnVdQb6CLwtV7m/09JsToco5IzDuYIpsvl9yEuw76+Zn+0EK7FutIlGrGOZm
	Epm2D2V+3iGj4hoy8axuOxVh3PdHi3yC1L37rrBEdHusYmW66NhXVDSSBztzQjyvrNe441MsQev
	231FjekQPyTX/8d0PdeDVi8LpknnNThlPdMbaMUnmB31nnV33fCOBAwQF6ASnp2vpwKZHZKl3hb
	xnUwjiCTD/TP7BaN9fnwNjnomjkXoT/bajPDrmfGFZQKJmbCTdHiqtcDtXLFrMbLCxdcI8wpMQA
	i4dD6C3QaVzuQ+Faj0WhQr3TTyOcQ9EyRLs2UB/EZCUgUOblygAK/fu+5+TdTwPkK5YmkSYjWSF
	Bqzw==
X-Received: by 2002:a05:6000:4211:b0:435:b755:c67e with SMTP id ffacd0b85a97d-4362938a453mr16934813f8f.49.1770651492550;
        Mon, 09 Feb 2026 07:38:12 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm27481147f8f.17.2026.02.09.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:12 -0800 (PST)
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
Subject: [PATCH 2/5] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Date: Mon,  9 Feb 2026 16:38:06 +0100
Message-ID: <20260209153809.250835-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260209153809.250835-1-jiri@resnulli.us>
References: <20260209153809.250835-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This is only relevant inside confidential computing (CoCo) virtual
machines, not on the hypervisor side.

Current CoCo designs don't place a vIOMMU in front of untrusted devices.
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
 include/linux/dma-mapping.h |  7 +++++++
 include/trace/events/dma.h  |  3 ++-
 kernel/dma/direct.h         | 14 +++++++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..052235feb853 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -78,6 +78,13 @@
  */
 #define DMA_ATTR_MMIO		(1UL << 10)
 
+/*
+ * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
+ * (shared) for confidential computing guests. The caller must have
+ * called set_memory_decrypted(). A struct page is required.
+ */
+#define DMA_ATTR_CC_DECRYPTED	(1UL << 11)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b3fef140ae15..b3c2cee8841a 100644
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
index 62f0d9d0ba02..ae5bc1919e1c 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,16 +87,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
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

