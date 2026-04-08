Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797533B95E0
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642918; cv=none; b=DE/vbbi01H6ZcQbntmpgktsZGhxB3reKvNSK4qU1XQxq+hJPhRh49lHoL8Eig4QHF6P5zVzeBjmlPN5FtEsJsZYWjDUn4JRF8L9hFfZzHg3GVIY8hsiS+G7TtG59a/kNgrOGsdB2163ofep6OFUmc7umI7cdUUXv4Q8xnWeECwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642918; c=relaxed/simple;
	bh=E3/giysvz5CnXAqEhtSOJDq9Jkv2a9jCXNPHxh3BiWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=lgqj5xHdsxkPxl44W7JIr1baTDTzutV6cHVHBD72OR65+YBndnYs9ToQpfVedyYpLHJ745kLCylb7Mb+7RBuFIG06ew8IjHE844gFtqJxPEeLFTLGswyRwWexZJfVY9kNokeizE9QLK7GygpJXU4upe+vZ6r0688kVwb/HERp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ergUMxKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ergUMxKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775642908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5Lp+7Mw/0AHH1tOuKEmXQ29IHEsWc1KXfBemJVlEFc=;
	b=ergUMxKYm86cZfRm/VN9+NAAKwu7GzT1sKn+grb0ypwo4AO1Ndu/94q2VV1rTa4ZyBhkdp
	KdMibfQchYTxWI3HKi7rETDag1rsbFWbyBkW9rmqwLcGLPzmyCf3JLJln1Vf+yU79jsglQ
	ffqj/1MA2pT6s2c4vyCxLm+pRb9ETJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-g3jIAepxOmyLi77jAfh6vw-1; Wed, 08 Apr 2026 06:08:26 -0400
X-MC-Unique: g3jIAepxOmyLi77jAfh6vw-1
X-Mimecast-MFC-AGG-ID: g3jIAepxOmyLi77jAfh6vw_1775642906
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b8c472f3eso4593063f8f.0
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 03:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642905; x=1776247705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Lp+7Mw/0AHH1tOuKEmXQ29IHEsWc1KXfBemJVlEFc=;
        b=m2ivtRTXcxW3vyeZmMTt8+DMnk0jTIHztRudTIr4agUDiU0pFb48H8olNKVQ7+0FHk
         BQzmgIh2icGZ1QcZSbRRWTzyu6hbo01hRBzyd/Onv/nFMNYJ0J1aEWhYDMzD3LZ6TrQl
         +K1mliO3/sxlZLep+mvsH5Ocm5x2uwc8GAVnusP6Q012NBwbrjMK0oLuAPcwizTTHDuz
         iAT6s3SDErIZU6Hg44/KBwvisOnbEY64FPbm9ZGDSxvip+HY0SNXP5nNKwoogoUIhdbK
         Ywawb/DtipcejeFOsENTENkltVp9M3RikevfITs7VZy3LEFMW+m2PQ9N03ws1b3HmwRI
         zObg==
X-Forwarded-Encrypted: i=1; AJvYcCUoG1zpjzR6V0shJDDJAJMYj6dK3aAYuWOGpKb4PcfuXvrC+AhNAFsjwG13xlR1ax5iZlcKRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4d8GhkykAdkFyXydhmNAK2C91V0gz+uVtfcXEphGcUPqsGj1s
	LPsuPdqbs338yyWiDJZuYZWPucn/7vs4xI+wRt8FSZf0TrNNQ4NwVF0FwcQBU1Lgmw5PxDcVc7N
	fcr5mH5BAZTwhcfIhn9AOIYmeKdqeFA+sokfLt8ihJn5LLn3m5wDtsQTr
X-Gm-Gg: AeBDiet/mtU4ocT+GMOKLRVTUuq3McuF58bhAbuEWiPLY0Cxs6gYeCt04MkzgO4XcKn
	LenGYHGawykQROOz1/8gERx03hRpCyPEQZZU2Lo70mCEG5GX82BkdtV22G+quXzkp6o7/dlAOX2
	D20MDy7zk5QyG/txBW7wRgTSiZ9UMs+mh/pgs0ud8BFLyvu2kwpVAVd4f7Emy7/8Pm6ifj1O3sU
	W8TssOY9mzdL53sEsrgYGv4vg6CAMj97K5tMsf0TQro63/c6JEnTi8gL0jNswM1sbgH3Sypn2Ey
	33HFs+wBE1/8wen6tPR/ycaT6mUuV2qORsljPk1vw0EnqpKLNT7ou+vcj8E56Ls/PWyJCKV2iUf
	OPRBXsJVLQsWRb8pXdBvI04SmMbLbP9Ktx2cAposyVoZu9XnUK7TBMH+5iAlvYeVU5fsSxeE=
X-Received: by 2002:a05:6000:2388:b0:43d:b99:bdc4 with SMTP id ffacd0b85a97d-43d292d32d9mr29056697f8f.30.1775642905551;
        Wed, 08 Apr 2026 03:08:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:43d:b99:bdc4 with SMTP id ffacd0b85a97d-43d292d32d9mr29056639f8f.30.1775642905099;
        Wed, 08 Apr 2026 03:08:25 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e52a0sm54935557f8f.30.2026.04.08.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:08:24 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Maxime Ripard <mripard@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: Remove obsolete file entry in DMA BUFFER SHARING FRAMEWORK
Date: Wed,  8 Apr 2026 12:08:19 +0200
Message-ID: <20260408100819.458347-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mT_dyVF_QezvgGg4AasWc5mrDcCYTVphcKJCf1JWLrI_1775642906
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 25bd73562941 ("dma: contiguous: Turn heap registration logic
around") removes the file include/linux/dma-buf/heaps/cma.h, which is the
only file in include/linux/dma-buf/.

Hence, there is no file matching the file entry include/linux/dma-buf/ in
the MAINTAINERS section DMA BUFFER SHARING FRAMEWORK.

Remove this obsolete file entry in DMA BUFFER SHARING FRAMEWORK.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10d12b51b1f6..77c0fc7ede03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7561,7 +7561,6 @@ F:	Documentation/userspace-api/dma-buf-alloc-exchange.rst
 F:	drivers/dma-buf/
 F:	include/linux/*fence.h
 F:	include/linux/dma-buf.h
-F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
 F:	rust/helpers/dma-resv.c
 K:	\bdma_(?:buf|fence|resv)\b
-- 
2.53.0

