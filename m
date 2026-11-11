Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395322;
	b=2QoALHN5oQMPuOLqBCN9CrFhpqgLtfv4sJfwLm0Jklwb1uN6Tw/UzgsESXAM3VmiaOUp
	 +6PDva4hV9qe1hYOt5b4Y6nXdZcCtB+fKIcicX7v+A0E9IHM+zXDgSCzxWfl936IamON3
	 Aw/AUE7bhlCBCEJKxNBfIL2umAM8Krjpjj9AMB25JBTijJGukykGdLiMwVUpBIW+Ewdcr
	 ubO5VLM2EMFSHa0y9sMPWBGQKqLKMefXKmQ79SmE35oCGcbBCxHtK4vSxX4281GxXtdzv
	 MiCmNs783qx9YAc5NTmP8O389znCLn69DYBsZXuKUFZbbynl2X2qiI9kSlbLmcLajGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=1XlqkjYgUHqMtiyvO2/LqlbV238Aov7kyKv1cwFa5P4=;
	b=5HYEtSjYyT495dwaJx77xD6fpTzHitbDi6i5b1s/u/TYt+Z7WZpTJArRmtqRx19TfSoi
	 sJBJVnb2dfdKp7PYd32nBujff2ODq1yM3lDQsN3+CAiwLiGn0kl2MIeBPMTc0YXRRuvx/
	 GsCuIJ3cu7ldRuOIQ7W70yhCpmyzJtj7CH8eXsKFsP6/ycLhLE1GzQWDzPYVcHHlECByB
	 ymaOwi649w3pTIP6j++0xCvzwUcZtQDFji59fy/DEdxV34RhYqh7CKFe26gzQ0SwWg43u
	 vqhjCNJEKI+hTl9Q740jljhiUdyWK+fe5exwyL4yjXH1sBDTK4TAeVb5RgNzFGVtiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QRCpNZW5;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EF60A6F53
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553EF60A6F53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QRCpNZW5
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4923b9fdd43so2535275f8f.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395321; x=1795000121; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1XlqkjYgUHqMtiyvO2/LqlbV238Aov7kyKv1cwFa5P4=;
        b=QRCpNZW5WHoGxRcQY2U3uOJxpo9igMYkyeuObz+3tt5Enegdq3rE12usfYEdXvwY4P
         vrw5igly9A0KR5o+hpfs7tN6OFiUdrwa6Qy7Ma4F62fl3KrOVfPQxA3250nctHBU17uY
         vsZEiHtF0oEmT0/pPNKGbMdcTQtgwaxM6JDdI6l/ZcftjHR1XjWSu6ZpP2nO6QghzSjT
         pnoiGjanli+L6hr1azSIT6vsQAhSOePyNsWEkYovw3hSsDYr77dsgem7Tc1++DcC8lG/
         3CpgGtmNNCKs5MFBzQhusE7pPdFuGJq3PTPv5pdsKGa5XePEWaex90FmGHM9DZW+ceep
         8URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395321; x=1795000121;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XlqkjYgUHqMtiyvO2/LqlbV238Aov7kyKv1cwFa5P4=;
        b=yMYpcUSLwstsyAbTCAPVglz/fnLzR4v2WUIXxAeF0BWFxdv/1UNfvNF596GiwJqKkE
         fB1SPQV58+VcdH8b7bHX+kOJmW2DFF8iVdpYzwuPSenQEKPBs+h/zaJ/Q6hCq+wAT/YD
         lujnAWHiT/Q0So2PHHrNErusHQC6pqpRmBpBvEQjaZzcgZh4Ow65vUwTjLpr1xj0tx4w
         3BlkaXxTzGuPcFxqP7FPL9lTJ/c6dmE3lsKMuB6r74zHV8RJoZPi4iVYZXax7JI0L6gA
         4i1GuSb1EGThXXF7eRAxJ0hiPNM9CXs6lrmReN7WrDj1evWTe74G+mMnWYTCu8p6mvlh
         VXHQ==
X-Forwarded-Encrypted: i=1; AL+hErEG5/Cut/hVSMC0txXcbnlm9PA88LG1nklZvvE6T+G9RweSJB2733BTC1m+bryBRBCMK9VHsg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SCcmoq7BSGZNePxLIVb8QHPZICy+8D9UmuWYXA1rr8PB+VfgV
	sSoURMdZhzApkduQM0L3sm9daH3mPbnUsaqhncq5WP8C+uY/m2QTZ8QIjHvEzarpAmdtxBJitCt
	4g8E9a+cwokN1Y1SlgWr1rQ==
X-Received: from wrqn16.prod.google.com ([2002:a5d:4210:0:b0:48e:3826:ef3f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:481d:b0:493:803e:800f with SMTP id ffacd0b85a97d-499c6e96f58mr3024659f8f.29.1794395320547;
 Wed, 11 Nov 2026 03:08:40 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:38 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-9-vdonnefort@google.com>
Subject: [PATCH v3 8/8] optee: Add support for lendable-dma-pool
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
	ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When memory is lent to secure world, fatal CPU speculative reads can
still occur while it retains a cacheable mapping. Use the
lendable-dma-pool API to unmap pages before lending and restore them
upon reclaim.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 drivers/tee/optee/protmem.c | 48 ++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
index be3abf6e8aa6..10e8f1540e5e 100644
--- a/drivers/tee/optee/protmem.c
+++ b/drivers/tee/optee/protmem.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/genalloc.h>
 #include <linux/slab.h>
@@ -21,6 +22,7 @@ struct optee_protmem_dyn_pool {
 	u_int mem_attr_count;
 	refcount_t refcount;
 	u32 use_case;
+	bool unmapped;
 	struct tee_shm *protmem;
 	/* Protects when initializing and tearing down this struct */
 	struct mutex mutex;
@@ -32,6 +34,35 @@ to_protmem_dyn_pool(struct tee_protmem_pool *pool)
 	return container_of(pool, struct optee_protmem_dyn_pool, pool);
 }
 
+static int zap_direct_map_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	int ret;
+
+	ret = dma_zap_direct_map(&rp->optee->teedev->dev,
+				 phys_to_page(rp->protmem->paddr),
+				 rp->protmem->size);
+	if (ret && ret != -ENODEV)
+		return ret;
+
+	rp->unmapped = !ret;
+
+	return 0;
+}
+
+static void restore_direct_map_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	if (WARN_ON(!rp->protmem))
+		return;
+
+	if (!rp->unmapped)
+		return;
+
+	dma_restore_direct_map(&rp->optee->teedev->dev,
+			       phys_to_page(rp->protmem->paddr),
+			       rp->protmem->size);
+	rp->unmapped = false;
+}
+
 static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 {
 	int rc;
@@ -42,19 +73,15 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 		goto err_null_protmem;
 	}
 
-	/*
-	 * TODO unmap the memory range since the physical memory will
-	 * become inaccesible after the lend_protmem() call.
-	 *
-	 * If the platform supports a hypervisor at EL2, it will unmap the
-	 * intermediate physical memory for us and stop cache pre-fetch of
-	 * the memory.
-	 */
+	rc = zap_direct_map_dyn_protmem(rp);
+	if (rc)
+		goto err_put_shm;
+
 	rc = rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
 					  rp->mem_attrs,
 					  rp->mem_attr_count, rp->use_case);
 	if (rc)
-		goto err_put_shm;
+		goto err_restore_direct_map;
 	rp->protmem->flags |= TEE_SHM_DYNAMIC;
 
 	rp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
@@ -76,6 +103,8 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 err_reclaim:
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+err_restore_direct_map:
+	restore_direct_map_dyn_protmem(rp);
 err_put_shm:
 	tee_shm_put(rp->protmem);
 err_null_protmem:
@@ -112,6 +141,7 @@ static void release_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+	restore_direct_map_dyn_protmem(rp);
 	rp->protmem->flags &= ~TEE_SHM_DYNAMIC;
 
 	WARN(refcount_read(&rp->protmem->refcount) != 1, "Unexpected refcount");
-- 
2.56.0.542.g3ef89b7020-goog

