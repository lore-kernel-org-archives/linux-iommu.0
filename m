Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478313;
	b=NyfuvJSpIsQ/68wBUvWTMqlv4VXVi+Zf5AMOBmlz3IuTnQq7n+V8gLOfRASqolCWYE5a
	 H9vRqFgEYbDv5+4ZAZRq4IHLep75eqnojrru4TBRXq9jUM1EMbLOpPuqYNQ8OckG3Rf7v
	 QbRya+LpyiuEvGTLBOnwGrrEuY4+iV1OmbqhuXmk+rispjW0740oA3aml0OSvuXB/utsY
	 sS62BjEIdFh8Mfz/7T9zDc4MyVPRHOdliwXe87NHcJu88x9UNelukqAA5yvcWSb1v5Cg2
	 6zNwQcV/1NTTG054XSFt3uv5lFbGja7tp5VvPeyPRnKAzJgYnMolAPCjNNe2gqMWZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZfCKuhuFLFgY7+lDwr5/B266OUdv6BfsTvR8mFssGTA=;
	b=guGnD+llln5LcAn8wpVRqZ210hhcOV+ugz3dhX5xAkH4IFRSr2bYKfWkfNb570T/BYR/
	 RXYaZfawYQOt/7l2hf5z7oOgxrCZ1S7R/ncsPPKs+b8Z72EeClhUVSuesKGqaaY7ACYoP
	 +XhnVR0lsVfoTH0mnE2mWgXJp1Wq4D/GUMlT0SwxE4j7NjUqkASH7MuK+8Ia4HJ53FPzN
	 cmm1UqEWYiIzm9STtLfXgWbhBFFhL8/yWzMuown680d/iBqGcZX2kYjzQbV5m6B9+Gnnp
	 MaCyDfxqLVuCmmZ+q+o0NmhjyOErRLhZrDY/GYfY4L74daFW5OuW/CFsAxrmc28IeMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hd8t7/50";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47F60A2630
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E47F60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hd8t7/50
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2393024f8f.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478312; x=1793083112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfCKuhuFLFgY7+lDwr5/B266OUdv6BfsTvR8mFssGTA=;
        b=hd8t7/50Vx1pUfB8hJ3dX9+opmcGrykL0HVhHrRdojEERrDTeJuwBB0VH9shHYpUwd
         htzhp/pX8XvDYXmsVHYfTv1mhwfViurNFeaSkmZ5O/+tre9xIrW7NuQXP42msLY/uqAe
         d2mC3qXXQ2dToWQv1Aw4FmRYmcXpqCDzWDOZON7dW0ZtH6sqg3pPyCTzDVCAKKdiyOhA
         grNEiYD5jd24zW6GGiPMLAUNl/RgkyKb6ZlfL9qQZYNlY+pzP7iRkwUkskBwA2DtKOGB
         L1m6X2KdPJnlXt5g54Dr/DFyIhlaAUEqUjAPWuEwLuluwwRzIlMAmlyBD8PRJznjhdju
         3llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478312; x=1793083112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfCKuhuFLFgY7+lDwr5/B266OUdv6BfsTvR8mFssGTA=;
        b=r1+XjR39iqxh2t1yD6U5KnsnT83NJMfzWkvIhuym77+DJmb6VwDlI3xt+dWQOngEEn
         9K5JMX1k+bxoUbnUa9EfH8cIBEgCgWF/7kf80lnOyOUvyL1cDkkok8cDFCq0hPzUwiSy
         kSYffUzrLPpIv+B/WGZGieETekxr/44uBssaj77dtq1razIIPKi3xFEY9XlleLfWCoPq
         siIv5o0ogg4vsBFCXiFp5eUQexYdUtZqiI6clfttSg2Na1GDJo9tWsFvy7vIN9s1u2YJ
         hqLHmJ9PtWcobo2yVaq9W6k8ro1/tqRmp8RBLTGdQHX7AQevi0yI6eorwrc75ehNrZGg
         ZaGw==
X-Forwarded-Encrypted: i=1; AKwUvBwu3h5VuC7Cusa/QQkD7qmrPB/hFx3tyu7vk3mUVBYigIZqroZHc3C3OJY9+iFu2I6zXsyqdg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJw6iugLej4FLyXuDP/1YOHULUnUEjUFMW+d9ZAGcclQg4ZOSo1
	DDJ5F0BVQItdUHSA/IPzWOHfHsGLo+G8dIrqL3xn8HQDtKMGzhOH+R3l
X-Gm-Gg: AYBFou2lKaQ3vJteOd+Dh8/4X7thFzUVDk0X8GkhaLM/HYlaUqEiuQVXTt1pNdCO3Ip
	agmEXaOYbQLEpeczHwrtsF+Hv3v7sTsbUjfVbJMDgiNFSTgDsXyN4LtFM4lvyAdRmi2vtfLoJxt
	1fnO5UDx9CHTs67/ZrYJlSSvKyeEWjHKHWlbOgIZ4CsxJRGUy4c+rw2NMDHv17w4TwsEQuBF/pn
	4NFBFzktQUMD/JZTy5pY9EZl3EletmkpPtyK0AU3AwjsMNxP8e6yaN+AxwbWVTAntZyC4hn2syR
	mmKqT8UfyCSCukEmpUnZgDG9SFtifaF0u1cxU/pD9+O2ygqhMXPlW5VN91SCiIp6J2XdI61Md+w
	asSMsxys3lchp2puN3Q7uW3q1oPyEAe6z7GDNrWT4ypD62tM6eyIsc1/fSg+orYvMea1MgVNtjM
	Zf/trXVBn4QzMTT12le7tRYdvWSVOEKTecZZgFrrHdeJjAhggXZSiTBmGhWR9rTS26BJRZBw7Gw
	oATrG+f9bNYqtMAyFEFxJYjmOrdwHiVzOBum1rG+PWbnY9TSCD3pkQrNEhbSp0aWc/nmxGA/DVO
	to1DoC7VZBTqda1nktu2jk3ZJG5Qo+twMnCUE91wjMKz1d8gYgYK6DkHMgeGX7hs9UahS91cIZG
	X7A==
X-Received: by 2002:a05:6000:490f:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e07bbe6a1mr21638509f8f.15.1792478311632;
        Mon, 19 Oct 2026 23:38:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 4/6] iommufd: Keep the pages mutex alive until DMA-buf detach
Date: Tue, 20 Oct 2026 08:37:43 +0200
Message-Id: <fdb5d9715d7f278ac24f05246f09703edb283525.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopt_release_pages() destroys pages->mutex before removing the DMA-buf
attachment. The linked attachment still exposes pages through
importer_priv. An invalidation can enter iopt_revoke_notify() and lock
the destroyed mutex, including when exp_phys is already NULL.

Destroy pages->mutex after dma_buf_detach() has removed the attachment
and excluded further invalidation callbacks.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 76d8803d6..59ee68a1a 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1667,7 +1667,6 @@ void iopt_release_pages(struct kref *kref)
 	WARN_ON(pages->npinned);
 	WARN_ON(!xa_empty(&pages->pinned_pfns));
 	mmdrop(pages->source_mm);
-	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
 	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
@@ -1689,6 +1688,7 @@ void iopt_release_pages(struct kref *kref)
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
+	mutex_destroy(&pages->mutex);
 	kfree(pages);
 }
 
-- 
2.39.5 (Apple Git-154)

