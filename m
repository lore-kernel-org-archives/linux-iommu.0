Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCD7FBAC
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366457; cv=none; b=UACahKxOEn+a66tCFFXW6I5i3kfiZrfWeoR8PLuvJXWi32wJyiq1iorh/Uweai2p2+siuQrT8N2ebbG157czlCAfYrrMFW9fYLyDpO4paj2ar9v1qvu7WxkvDM3RLJc0hVFiUbCkWwtC1FyhPqsrWc1lWBtm/+JyBXkl4qZZNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366457; c=relaxed/simple;
	bh=EzbbarVAceIThGcdDJQMoTLX0eccNmtcHB8EGB1fufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu1PMwAqEYTsRzhjlf3UplpaNA9de6DT0bYLocO0zYfP325vKfZp+WtK8In1DScyquCxB2UA0CAdsFWlBwPjp+ugTUqqpuxa97Hq+naP1PtvX9ZCoZWjt3tkyLJ7k84u7fDDo3FjsXdanBJUlfQY7jQP3MATTSeNyC8NW4IgQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4FKnVoB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4FKnVoB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202ca70270so6544025e9.3
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366454; x=1716971254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tTr2u/xpZoc7xpf88V/G0TB2e+qjtO4Yfevyp6Z/VM=;
        b=N4FKnVoB6QUy+7rYjO/InXrK/nfTGyOMs2Ad1XJYJlXSroxS2FjOKVXde7gIG2G/Wi
         +y8xcCqesjEsdJR1uf4li0TpH0Z2DvAmXjj7dpSkeCgxocyUDY/ag/1oPCFKkVpdVVaL
         ZsX+Z5HWMphwWTYARb3kgi5at4xl00MuaEje5zHDEf9wKqdkAcE/A3/dG8tszmJDJ4Q0
         nJ9eBZ0Md8svaCyHxjsa6EaTO6IHb8U19mP6L4Mhjkpyaakzwmdl5bf+tJ9ztFDHeQfA
         oxfNqthoDwmfKAIECAAaFXZRALWTYT/0MMJkNs/C2HlvpXxADSObVXfUd2R/LsLkOpeM
         mQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366454; x=1716971254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tTr2u/xpZoc7xpf88V/G0TB2e+qjtO4Yfevyp6Z/VM=;
        b=r7KTWmAbFeqMzutDnzL+zV52SEpdhlyw6ooIFj6BatZmqRatouOCeamHHqUx10wOBN
         PPDeY3kpaGDc90qx4+IhfbOEC7XGbpj6TwmJtglwVWef2312Y440jZ968hxdUHhp1WrV
         WXS1JSBqwTNOp2ZP43UM+26qdzNJlSjmVzIqLtUKu289QW9oVVULcio/DRY9VzxSqi2Q
         OtEG+EzVuDCgJ1XSIHWnOqryrAJOel+jS3Op0RkAd0vKSNUla63IvX2aB/NDrqDxGY12
         bc642q8fPTLjpYAudWXjhfPbvNFrAwwmWkQYOUd72m64HO9F6wj3eZzZPXT1jnwZRXxY
         IU9w==
X-Gm-Message-State: AOJu0YxHT6Z3Q9ZgWUcvHv3HSrPPl5x3spAnsf53mtMGRqzKwzX9NxCp
	urOf02L+1SOgXXMeLuhwIdYpCDME/O1KW0OlpP0YQHjtEYFbgb+KFLR4reZuP8M=
X-Google-Smtp-Source: AGHT+IG9IJ8rp3fmMs48dAk6Y747OYcyjpxClqnc3kVxDzH+SdddvdkpIdEFObD0FX56tEt3Spe1fQ==
X-Received: by 2002:a05:600c:21d5:b0:420:2cbe:7f16 with SMTP id 5b1f17b1804b1-420fd3726d5mr13217935e9.34.1716366453292;
        Wed, 22 May 2024 01:27:33 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
Date: Wed, 22 May 2024 10:26:48 +0200
Message-ID: <20240522082729.971123-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522082729.971123-1-ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/pasid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index abce19e2ad6f..9bf45bc4b967 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -146,6 +146,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 retry:
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
+		u64 tmp;
+
 		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
 		if (!entries)
 			return NULL;
@@ -156,8 +158,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		 * clear. However, this entry might be populated by others
 		 * while we are preparing it. Use theirs with a retry.
 		 */
-		if (cmpxchg64(&dir[dir_index].val, 0ULL,
-			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
+		tmp = 0ULL;
+		if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
+				   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
 			iommu_free_page(entries);
 			goto retry;
 		}
-- 
2.45.1

