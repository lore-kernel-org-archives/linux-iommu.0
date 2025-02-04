Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481978F33
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712216; cv=none; b=N/fWKDwdHF9B0Qcv0GmJyWPdQGvw4xd7Z78fGoBQHYAZcDDohg43C4uH6ouVtxU3BAzcIzBVHL9mQZ8FU3zLr6at6Ml0pvgSbAec04nyB6qwgffRRl5rk55etCZqCF/yXa4NyO35ySGvNw0qJsFexUXAjTqXC4HjFVui6lqXotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712216; c=relaxed/simple;
	bh=qVxDJ+ZxuHgM8okVZKQanGDwAH+CuH6zHHCmcJwrvPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5gCKXZ2CahK6YyxCZbttRaOVTDvZea0pXxLfBf//CiwB6jM7JoUBG36qXO1NLiCgrADNA+S1FoZbHZbGEvf7NoyvQ9cWm5vpRS2R5w1DBJyWsxpFtO/8ZV6s6ZfWPjMAcbNIZqTKXfkSk8PjwYt2kP6R7YYa3twThxR/1ptjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JugqjbUH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JugqjbUH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216430a88b0so134378715ad.0
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 15:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712214; x=1739317014; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJVe67JRWk4bcEtE0wJxXkXG+iyqzbv5P3l6eWFvYfw=;
        b=JugqjbUHUmfVDnShaDy2C385CtaDlwumC5RgfKOLHgv4lo1m/DcIwnSchc+NkePgOj
         1FWAWTv0h9vy/Gvkn8T0kIUZPsA8OLc+aujfNttstW/QkwSroyTGQfQfnT6xT9M+J3Ts
         PsRQbRwflfjA6zIj5A7P3EFsWD7HCw0k2B/f6MQDN0R6tjbOiSlsAdN4EfqZz1Kx3uAG
         RAVbcCq6R6C8Gnbtxccr6qF0DXWoQdZP0VNATWjp3XtoByaLyq+e7vCsChNqBAV0bsSj
         PggUhHWgplPuRl+tGdgcRP8ObHWdVw4IL0HXhovcAyZaa8XL3FhmML18Qw6UsAC2SM3f
         ucIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712214; x=1739317014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJVe67JRWk4bcEtE0wJxXkXG+iyqzbv5P3l6eWFvYfw=;
        b=gR14WVZu1uc22SDXVtTYqUqXW2FrBu78z/Mp2U4QV/qglY1yGxh5MiAF59kW+ClRN9
         Z8xoUMEMgZazOkhqBbfq+DASHZsMhqDhX6amuTbzaY6mtjGp4QTcsf+znsBwgL6c+SGu
         GD3Q5ZSg/FrLzxVtAYAj+VOJ5LPpDdwLd46JIC0TF6L8qXclEvVFESXBgZnsAX3r5jsR
         IF3h0O51HLQxk624Xb+z/vE1rcLiRzjiCp4iYIglJ/4wq+g40PwtWc3y5VIUV1Q7gBrW
         EG0NN/G0OOcONZbwbPC0kzGa6ST5ujTUUYr9dKTLf5IOBSAX0Wztkbjsf4/2s6k42F3i
         zLVA==
X-Forwarded-Encrypted: i=1; AJvYcCV/BvP1XovWyaz42WTiB51lTUHvCK6ioPPGBQ44HKIjZMy5uIuFMvuIurVyK/qniXqsqF8lqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1FwJy2DruCj/URN4M3fmWqsdRZBEOfrXdJSjKixV4zK8qHO1I
	ZN84L4eLCXL2eNPi8HAxpVQlpMvB6M4zF+AyKuQewwrSad8y1F3razVDlv5/+dpAFftlgfdmEQ=
	=
X-Google-Smtp-Source: AGHT+IHqNiTQFePPYYTwiCZWSt9I9UEe6Z4Xonv9HrbH6InazMe/EyQGOeXMZvMM6NFFgT9S95Z9rbiivw==
X-Received: from pgbcx10.prod.google.com ([2002:a05:6a02:220a:b0:a87:a3b9:db3d])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f91:b0:1e1:a716:3157
 with SMTP id adf61e73a8af0-1ede883ba28mr948529637.17.1738712214499; Tue, 04
 Feb 2025 15:36:54 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:28 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-2-jxgao@google.com>
Subject: [RFC PATCH 1/3] add full_buffer_write flag to struct device_dma_parameters
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"

When devices write to a buffer, some devices are guaranteed to
overwrite the entire buffer. These devices may benefit from such
behaviors by reducing the need to pre-condition the original
buffer. For example when bouncing data through swiotlb, the buffer
is forced to be synced before the device writes to it. For devices
that we know for sure overwrites the entire buffer, this flag can
be utilized to eliminate the extra copy on every IO bounced
through the swiotlb.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..003007ad6ad3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -460,6 +460,7 @@ struct device_dma_parameters {
 	 * a low level driver may set these to teach IOMMU code about
 	 * sg limitations.
 	 */
+	bool full_buffer_write;
 	unsigned int max_segment_size;
 	unsigned int min_align_mask;
 	unsigned long segment_boundary_mask;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..e93b909865d3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -513,6 +513,21 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
+static inline bool dma_is_full_buffer_write(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->full_buffer_write;
+	return false;
+}
+
+static inline int dma_set_full_buffer_write(struct device *dev, bool full_buffer_write)
+{
+	if (WARN_ON_ONCE(!dev->dma_parms))
+		return -EIO;
+	dev->dma_parms->full_buffer_write = full_buffer_write;
+	return 0;
+}
+
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
-- 
2.48.1.362.g079036d154-goog

