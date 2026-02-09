Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044A3803C3
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651496; cv=none; b=CnQKTpXZQ7BwalzBHmLMcfI1pQkfAC6T6GgFV5W9JBzXlFZfwMV3RzTC8Ebz/urysK1ZOW7hB5Ml/Rd6pXPrk9L3tHIsvs0g0HjSJe/Ee6a7TFLkXRRsNke5btWNw48ixltfPZxqoaL0cxrfnX2CTOLv2SI9tiw7R+j9y0b68uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651496; c=relaxed/simple;
	bh=QKlzvN5Ibeyd+ZwXwOg2RWNZHh/JmCKBpn+iFp4nZow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI7GgPxQus0BClKrdBSIIeKArfYFeQwcNAUJCWW81rG75q2FHd1xUCtxCkIB/R5fKmKQPvbI8aGlcY0nWqsBoeTey5GXMC8UUKk0spZEiDg3YrKcV5zqOx1l/J6N39kRL6kBXPRMmV5pwUYvZXSbKEBcQwtzGm31/F+Rp5H4LCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OhoLKOXH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OhoLKOXH"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4376de3f128so837058f8f.0
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651495; x=1771256295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHwHnR/AkgDNwuGXRgvil2Ov0DASjUJHIHivMAy5Dsg=;
        b=OhoLKOXHaHq610DDLhE8c7TrjN6hgPfwLgKWZhY4yDNr59tib64/pUmsdkP7pRZW45
         3ZXYn3XeQZkOmWfB/cXPqna7rxjhyeFfx8Qd8M0mSVPhRAuWw2Upo7LH4+eaHLgknbJd
         FaZJw+b3NQ96b6+UyS0k/30zpfo8H8K8KiXPbSorn3VegMZzUu8EKZRtrwqNTwqAEfRp
         b4duHqednEwPKZcOXAhM3EOrN1lUqC7qj1W/1JPjKyf/+4fqw8YoU16H6PYO0rnL2pm4
         z+OLpavCkCEODYJ9ORM4Rmx4A+U8DnuCxENFPSSKiMZRvgonDKb/+Lt1yONObnKg1fyy
         9dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651495; x=1771256295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHwHnR/AkgDNwuGXRgvil2Ov0DASjUJHIHivMAy5Dsg=;
        b=VAFLJdIUN0qJqC0lQCynD/vfL9aURYIcqX+znL4qlgbr/KbBgjl4/70z1iqLkbEGOm
         VOM0m7sJ9aDImWsXbwBFZtmnFJctl4xWK8HV08eaAMn0fExmuyZH7ScJ9xjflX5hk2zs
         xgeishqXJ7oBLtWzyLYKrWUWXr7qQgaVme9JVunHYE0OhYEGHjWx3UYR1dNcfXEnJPgy
         T5c1eNREPhG0zqL74QQO6prULiHB5DTuCocTNOMBnbLg82bO/56wDgcfk9V4wFwKl7ij
         Bx2ODteGhpyvD2trYni/TShwwDM/X3ojAFfhPtFWjgfx/GmzKhJNR7bqnFdbF9+UcBhG
         bApQ==
X-Forwarded-Encrypted: i=1; AJvYcCW42lYqK72fZ6tLMKYIebd5yxmegadirN2Fl4HXQYSE+0dXAxz+Q9QCk4m04VZA53T01qkQHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjV9jRvGerqKvRJS3tkaPr+aVwpACX3MrSK2pUJ/Sm5bwMrdQM
	HIuA1QXiwlsAHZz0lU5GQKf8FkeGI58yEqXwA5ciAiiW3rAMFd0wReRzLpRWKIkIiEg=
X-Gm-Gg: AZuq6aLaZNgmwTDjB06GCZDfxCN5QG1HPtKAApJw9fx43PZScmWyzxLtu5r63rZPZEP
	qlI7AHngIoBm7uzyzZx1/WR2hA+vYQ54NQqajXQ67lyu/2mLauxr3t4C+Mrgrs+7TkFOmk1YC2o
	KdnP+EwedzGaZQH0scsGlKx1zDfM3IA7w1bpbCtXEECH6yBmKSo3OeUOxKmlrgg1ta3S8j6vsuK
	9sHJO6k5qR6mSBtHu2OfVIs4GoLaXPgjcT8UyY58iEOPHZCAliQ8v++iXbubNhUFeCq8dzqv68i
	uIX5VN4UpX6bILj5lKmFR6gNFbhwhNB2fBRHxaXPH8fiABFeXVgdMFlS4OB54RMfLixxaWpriBc
	DPdZQowxqwHBzjjJmXRylZ17pbowc+n59ftxoh1MsyR5mUEI4Gd6VYq+j76o42PC4tbEuWkXmLZ
	GmUg==
X-Received: by 2002:a5d:5f91:0:b0:432:852d:5662 with SMTP id ffacd0b85a97d-4362938f401mr17980642f8f.63.1770651495066;
        Mon, 09 Feb 2026 07:38:15 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25casm28647578f8f.4.2026.02.09.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:14 -0800 (PST)
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
Subject: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap flags
Date: Mon,  9 Feb 2026 16:38:08 +0100
Message-ID: <20260209153809.250835-5-jiri@resnulli.us>
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

Currently the flags, which are unused, are validated for all heaps.
Since the follow-up patch introduces a flag valid for only one of the
heaps, allow to specify the valid flags per-heap.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dma-buf/dma-heap.c | 5 ++++-
 include/linux/dma-heap.h   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8ab49924f8b7..4751bcef4b19 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -28,6 +28,7 @@
  * @name:		used for debugging/device-node name
  * @ops:		ops struct for this heap
  * @priv:		private data for this heap
+ * @valid_heap_flags:	valid heap flags for this heap
  * @heap_devt:		heap device node
  * @list:		list head connecting to list of heaps
  * @heap_cdev:		heap char device
@@ -38,6 +39,7 @@ struct dma_heap {
 	const char *name;
 	const struct dma_heap_ops *ops;
 	void *priv;
+	u64 valid_heap_flags;
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
@@ -105,7 +107,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
 		return -EINVAL;
 
-	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
+	if (heap_allocation->heap_flags & ~heap->valid_heap_flags)
 		return -EINVAL;
 
 	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
@@ -246,6 +248,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
+	heap->valid_heap_flags = exp_info->valid_heap_flags;
 
 	/* Find unused minor number */
 	ret = xa_alloc(&dma_heap_minors, &minor, heap,
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 27d15f60950a..7cfb531a9281 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -31,6 +31,7 @@ struct dma_heap_ops {
  * @name:	used for debugging/device-node name
  * @ops:	ops struct for this heap
  * @priv:	heap exporter private data
+ * @valid_heap_flags:	valid heap flags for this heap
  *
  * Information needed to export a new dmabuf heap.
  */
@@ -38,6 +39,7 @@ struct dma_heap_export_info {
 	const char *name;
 	const struct dma_heap_ops *ops;
 	void *priv;
+	u64 valid_heap_flags;
 };
 
 void *dma_heap_get_drvdata(struct dma_heap *heap);
-- 
2.51.1

