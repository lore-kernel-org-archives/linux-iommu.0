Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD537FF7B
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651495; cv=none; b=MVs0hClCFqW2SJpoIpw58gkjfwyZPRF4FaH60CczE5Epcr70eTJ4PilyeZNpaFS67fQ8Qo6VUauprcTxC9liLerNlJUcBy5QroLF6RDet2VRfh9OQ/x5Z4EQD2OgnsSTqordHVo8aLkJaoGjVFZ2ViTMtbkKWRR3YR4HUN+2TuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651495; c=relaxed/simple;
	bh=4+KS84gkU8a/qj/+caCigpMBaF9Inx8ny9YhQVJcbQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTJQFLVV/l4OHUUuqU/yXcIOdhWGgKO5VMmnYgJyHYCZhXj6HNN7x7u7RNH4O57Jps5/Mu9euySfS5hyNuB3EBtGFxTzp7j84heHnsl3G/COE6hTjLTlJPdPC4STsu81SoRFTpMAVntTtAL6Y3QWLn3MzhWxAtKHBapdO96yTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HPLQgGgJ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HPLQgGgJ"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so39133075e9.3
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651494; x=1771256294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCp//tMOTqGacLZXvOrrIiaVx7JZ5khmQmJbVkzQNLk=;
        b=HPLQgGgJUB9MBPmh1Feluy+XWLeVC4Pkc0KiP9QiQ4JADz/RWZIqRZZFjRmYSE9O53
         dyZiPmI9EkIyNLwlfPgOxf4WwhLCty7UsrsywUDDPisixuD5OqddttaAtb0ZrfXlajcK
         ioyF61ygTOt/Zjz4v6YzQYht8atmwACzcocE9pYO/fojUdnNhxDQtRJiSXh8KWXtnVwE
         E96x30fvNSCVa4qbkyJ9+Pv4wmkOKJ9H4c7Uprt/hQeb7vLTP7Iu9wJoPsscsTwWBlS4
         96Vo5vUQG9JuTd56UvIKaG4g0uuGPp4cAn5/oiANJJ+TDv2aY1DgzfO66dj85PsZyFpk
         YYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651494; x=1771256294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCp//tMOTqGacLZXvOrrIiaVx7JZ5khmQmJbVkzQNLk=;
        b=eQSsrZwoWD6GrVnOberaYVeT/WrSFPDy/tIYJXLy6uub7gJOROJNGbGOzFqg9K0oFr
         TsonwI1EmFwVy3EoUiEmAkDAvPbPvRG7H0JT8CqYZCo47TxQ2HIghSBvj4R3owA1ZUgd
         J1KT/WCXitmGxu5dSBMWbJUEeCgfYgOz/I3vdjcsTTUxuldZg3Yxlf9yU5/0xUpLsDqG
         fqmmoAVWpGyGbUobG5zlEIYG3Zs7G0LEVw5DshSSVngzRy+vElHAagmpBGdpki8e6VLC
         V2fsdbo0AKVtRU5pXEWu33Kbx9X6byCQTZBJ83OFLkCJLGwwsNTNtf7irJHgkKas5aTz
         k2hw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHCelSVrVl5C6VnSKPW2yjN+o3BYtxNbrEDNYmWmH9g88fPAWQ3jSG8TeiA1IbR0ehIYbcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz16nHDEgTkpFzqtcoymaBOcd49btfU3jaUmMtaaOTlaPi2BKX3
	symLJ/gXBQJ33A6aW9gUk1ykAM17++aq1LJBmNI0ZFXSoeS1UdeUXynFqXQKawM9Ilw=
X-Gm-Gg: AZuq6aKFJ1Wcq9iFDTij2SFd2ST3lLdgk85P6Hn09Ibsb2WKXgtIlk5CVwPBA9F+YKA
	SWHV6MIBDiqpVbIQAgU/+nDc4wMdbapyflAbl30hNjHduYXNHypcgl0cFnx41LJQPA1bL4rpWpq
	FEsY4OUfS++TdkHIitCgbiwxj2qTML/N0gaKIOdQ6WmfuWbpVHxpv5o463IdjxOIKhuUVLsILTi
	n7oqwhxDTf8TKLDu5KHLkOyJU4aESLwa4mvXQPVRi/EHkIJ0mc3bvC1Je3iAfcKN+GIf3/iRomY
	4eABeK0pZFMbNzXIHGI7bHXop+Utjd7bIdugjbZBsQ7M3VyoU6SJZenuFd5MGj4orOWeKLXW0ew
	EbGk8mfutQ8vFjefpQSablT3diNXeABSK6h6BQ6cF7cPi96bCs7ZE0ngftU7JxxTLIyMT6pewtI
	tYUA==
X-Received: by 2002:a05:600c:c16a:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-483201e1895mr157429035e9.9.1770651493820;
        Mon, 09 Feb 2026 07:38:13 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8ebbsm382402735e9.1.2026.02.09.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:13 -0800 (PST)
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
Subject: [PATCH 3/5] dma-buf: heaps: use designated initializer for exp_info
Date: Mon,  9 Feb 2026 16:38:07 +0100
Message-ID: <20260209153809.250835-4-jiri@resnulli.us>
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

Use designated initializer for dma_heap_export_info instead of
separate field assignments and avoid the need to explicitly
zero fields in preparation to follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dma-buf/heaps/cma_heap.c    | 7 ++++---
 drivers/dma-buf/heaps/system_heap.c | 9 ++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 42f88193eab9..d12c98be7fa9 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -388,7 +388,10 @@ static const struct dma_heap_ops cma_heap_ops = {
 
 static int __init __add_cma_heap(struct cma *cma, const char *name)
 {
-	struct dma_heap_export_info exp_info;
+	struct dma_heap_export_info exp_info = {
+		.name = name,
+		.ops = &cma_heap_ops,
+	};
 	struct cma_heap *cma_heap;
 
 	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
@@ -396,8 +399,6 @@ static int __init __add_cma_heap(struct cma *cma, const char *name)
 		return -ENOMEM;
 	cma_heap->cma = cma;
 
-	exp_info.name = name;
-	exp_info.ops = &cma_heap_ops;
 	exp_info.priv = cma_heap;
 
 	cma_heap->heap = dma_heap_add(&exp_info);
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 4c782fe33fd4..124dca56e4d8 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -427,13 +427,12 @@ static const struct dma_heap_ops system_heap_ops = {
 
 static int __init system_heap_create(void)
 {
-	struct dma_heap_export_info exp_info;
+	struct dma_heap_export_info exp_info = {
+		.name = "system",
+		.ops = &system_heap_ops,
+	};
 	struct dma_heap *sys_heap;
 
-	exp_info.name = "system";
-	exp_info.ops = &system_heap_ops;
-	exp_info.priv = NULL;
-
 	sys_heap = dma_heap_add(&exp_info);
 	if (IS_ERR(sys_heap))
 		return PTR_ERR(sys_heap);
-- 
2.51.1

